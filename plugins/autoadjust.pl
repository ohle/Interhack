# adds a new helper function autoadjust
# when you pick up an item matching the regex it'll ask if you want to adjust
# to the specified letter (unless the item is already in that slot)
# it should ignore anything that appears before the item, such as 
# BUC/grease/damage/enchantment etc
# but not anything that appears AFTER the regex/string you specify, such as
# charges
# by Eidolos

# NOTE: due to the way Perl parses this, you need to have either "sub autoadjust;" in your config before any autoadjust statements OR put parens around those statements. looking for a fix.

sub autoadjust
{
    my ($item, $adjust_to) = @_;

    make_tab qr{ \e\[H
                 (?-x:You have a little trouble lifting )?
                 ([^$adjust_to])
                 \ -\ 
                 (an?|\d+)
                 [^.]*?
                 \ 
                 $item
                 \.
               }x
          => sub { "\e#adjust\n$1$adjust_to" };
}

our $aa_key         = qr/key|lock pick|credit card/;
our $aa_unihorn     = qr/unicorn horn/;
our $aa_athame      = qr/Magicbane|athame/;
our $aa_stethoscope = qr/stethoscope/;
our $aa_pickaxe     = qr/pick-axe|mattock/;
our $aa_bag         = qr/bag|sack|holding/;
our $aa_Amulet      = qr/Amulet of Yendor(?: named .*?)?/;
our $aa_blindfold   = qr/towel|blindfold/;
our $aa_lizard      = qr/lizard corpse/;
our $aa_conflict    = qr/ring (?:of|called) conflict|Sceptre of Might/;
our $aa_whistle     = qr/magic whistle|whistle called magic/;

# samples (see *-config for more):
# sub autoadjust;
# autoadjust $aa_key => "k";
# autoadjust $aa_unihorn => "h";
# autoadjust $aa_athame => "E";
# autoadjust qr/potions? of healing/ => "H";

