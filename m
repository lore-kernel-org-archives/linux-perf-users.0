Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F487215066
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437772; cv=none; b=cJ8msZUz+5y64Zxgt0kDa1teUuE//CHYbS0AUE5dImaLL+G5xai9myqqZkY5wTiG59gH0ArnsHLCu1WAnSOeEB9VfpL31Je4fgDC44eo0D246pyNQOXsPr2f2s14FqjzOKiEVhjhUCLZKhyKuovyVRYHTjeDeBxTKe6Lj4CilkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437772; c=relaxed/simple;
	bh=KcBD2cPQmGBfq6elz01c8ijxlyjzLUstdIiX1VSTJv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUq8jscjHxB3Jx9I2l5w4LwfzUbZKUwVmGK3B8YsjxqQBtNOUXbw2Vq/Z1/vsqkrbLIi/uOoCXBZzI2CxVnRDgABFmHsrirnaiqKgU2jUfxrbGx0c+Gh4JRDaetfubwg7g/pxLngiJX05q6r/qsCDh9kpGEpvK5pnpNX3C96HTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWFrJCAn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWFrJCAn"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30795988ebeso6752041fa.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 01:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437768; x=1740042568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAudk4OBy3oQ5BFlJBkk/G/IpQ0/neUpevp/6wokGyc=;
        b=dWFrJCAn8OeawCz9LqjsdNsRey0sTbVdVZ91WSXo4h1bysqlBAFkediTtx4/yia9lj
         gWOqzID6sTBrWljJiKFRUf+PV2koiv3VyJkQLUPrirBrmafbuYPGRKJ52KllqFhUtFMh
         RnX7mqhOafGdhrD/2KO73P4DA6qq4s0gKdmmmdC/MTvygva9v3XyLCkrrAnx5uegE3Nc
         LAW+HRdTkJgA+GvP/TYPxw/S3+qhG1vcSLIkoWzToWZYhgyKSl3Vi1QPTzs0HAi+6xwG
         7m81LrHrKQIpH/nO+QZkSC/u4tF5Gu2Zw42VtWoilcOD3mTr+2B3ewMEyPLPwrjztbVh
         XEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437768; x=1740042568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAudk4OBy3oQ5BFlJBkk/G/IpQ0/neUpevp/6wokGyc=;
        b=hN2FEu/ARQ5a0UCc/aNhJFi4XkfAeCIFlU5KOUBP77ts83wQ24qJF10tc6P3U0Qzcv
         ycNtlZJcfs/TS0iisNfh2zzGnpIHaSwXG3qRuVInTem/VU5+kYXa2CnoZHbJf8P5revK
         1mo6MY3tgVRq9j61BKs7FXd/a6jXIyww8w2skXtL2hneKy6ElL/Sd5W0KB+YZQZIHQbv
         ouu/YN85VJaiYfxnUFWh3IHfZl2Bf7dtojCIkRLlqAO01in1JwtoXS55+ee0bnc3d+fV
         z8XDB/kHGVEruRSoDuQ6w5lRxnxYk8grGt6n/K4Fuk/W0NJC2wW5OdLHYqi1GSiYtwHn
         4bjw==
X-Forwarded-Encrypted: i=1; AJvYcCWvhFjR2+kIF1uFGkXyvntKLzoT5SPU/v0pRM+FvOTY8PqIT2jOeQfVO8LyN9ZxB2GVBWopWsDRCO+Jbr1Zny36@vger.kernel.org
X-Gm-Message-State: AOJu0YztOoLp1YDfeP8k5ChqqARZEzFQwkd4V3650zrjkAELrVj6vUou
	MzDf0+2rfy+KjwryWNE4+xzRYWURPFBCUe1km7Pi6Kx1ItEZgNpzcg0oOUIPen4at4hVQvoKpiA
	7o/qZfV0XclSbYuNtwaZFbC2+c7eDLb425ne6
X-Gm-Gg: ASbGnctMVpzRuLEFR8RiZutQtu/0kHbd+YiVn9Mvi24Eh1paKgNmnWI8+w0wzg86O51
	D3Iq3CySgjxOjMpfIKYLiEWPslMqDR70XwCoT0WpOl7hHl1ly9xzkY5n6Y8Mh/VN4EAGtvBhLV3
	rF9JCuR/z+4zUUE14Xop4L4/JaOF7NyQ==
X-Google-Smtp-Source: AGHT+IGytENfR1Y5HPvNb7G5JdouX7QcgKyJucqODl7HSF99koYksEWn58+z7u0X5kP6vJmWxmRVKbLTknVp9MubMeE=
X-Received: by 2002:a2e:be9a:0:b0:307:c829:f170 with SMTP id
 38308e7fff4ca-3090dcba09cmr7118641fa.4.1739437767915; Thu, 13 Feb 2025
 01:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
 <Z6WBsruddcx0SFV5@google.com> <CACT4Y+afC5WfTMaKGtg760PS5oXkkurzAyHVyKr9TsPs9RU2DQ@mail.gmail.com>
 <Z6qhjFs0YOMTzk9W@google.com> <CACT4Y+brgj5vRoxQtZ76hUVcHWUJJ2u_8n89EwuTAoyXXbGDCw@mail.gmail.com>
 <Z6uMBAG0hePL9JV3@google.com> <CACT4Y+YB_Ckfptkyu6yiF5Daa8q4MgGyf_1u7RPjoTsdQ3h=qw@mail.gmail.com>
 <Z6z6znWi3o-ewuNs@google.com>
In-Reply-To: <Z6z6znWi3o-ewuNs@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 13 Feb 2025 10:09:15 +0100
X-Gm-Features: AWEUYZnvPHNlsYlZPnafaUYgaXRAn2-afRgaVBuyItL5BtSYs1zIW7nxeO7UJYw
Message-ID: <CACT4Y+aBsT5VddEHQPtkjWkO_2NF_Ra3BDzi=AwvjvxwYo1gMA@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] perf report: Add --latency flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2025 at 20:47, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Feb 11, 2025 at 09:23:30PM +0100, Dmitry Vyukov wrote:
> > On Tue, 11 Feb 2025 at 18:42, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 09:42:16AM +0100, Dmitry Vyukov wrote:
> > > > On Tue, 11 Feb 2025 at 02:02, Namhyung Kim <namhyung@kernel.org> wr=
ote:
> > > > >
> > > > > On Fri, Feb 07, 2025 at 08:23:58AM +0100, Dmitry Vyukov wrote:
> > > > > > On Fri, 7 Feb 2025 at 04:44, Namhyung Kim <namhyung@kernel.org>=
 wrote:
> > > [SNIP]
> > > > > > > > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_out=
put(struct perf_hpp_list *list,
> > > > > > > >       return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -int hpp_dimension__add_output(unsigned col)
> > > > > > > > +int hpp_dimension__add_output(unsigned col, bool implicit)
> > > > > > > >  {
> > > > > > > > +     struct hpp_dimension *hd;
> > > > > > > > +
> > > > > > > >       BUG_ON(col >=3D PERF_HPP__MAX_INDEX);
> > > > > > > > -     return __hpp_dimension__add_output(&perf_hpp_list, &h=
pp_sort_dimensions[col]);
> > > > > > > > +     hd =3D &hpp_sort_dimensions[col];
> > > > > > > > +     if (implicit && !hd->was_taken)
> > > > > > > > +             return 0;
> > > > > > >
> > > > > > > I don't think you need these implicit and was_taken things.
> > > > > > > Just removing from the sort list when it's unregistered seems=
 to work.
> > > > > > >
> > > > > > > ---8<---
> > > > > > > @@ -685,6 +685,7 @@ void perf_hpp_list__prepend_sort_field(st=
ruct perf_hpp_list *list,
> > > > > > >  static void perf_hpp__column_unregister(struct perf_hpp_fmt =
*format)
> > > > > > >  {
> > > > > > >         list_del_init(&format->list);
> > > > > > > +       list_del_init(&format->sort_list);
> > > > > > >         fmt_free(format);
> > > > > > >  }
> > > > > > >
> > > > > > > ---8<---
> > > > > >
> > > > > > It merely suppresses the warning, but does not work the same wa=
y. See
> > > > > > this for details:
> > > > > > https://lore.kernel.org/all/CACT4Y+ZREdDL7a+DMKGFGae1ZjX1C8uNRw=
CGF0c8iUJtTTq0Lw@mail.gmail.com/
> > > > >
> > > > > But I think it's better to pass --latency option rather than addi=
ng it
> > > > > to -s option.  If you really want to have specific output fields,=
 then
> > > > > please use -F latency,sym instead.
> > > > >
> > > > > Also I've realized that it should add one sort key in setup_overh=
ead()
> > > > > to support hierarchy mode properly.  Something like this?
> > > > >
> > > > > Thanks,
> > > > > Namhyung
> > > > >
> > > > >
> > > > > ---8<---
> > > > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > > > index 2b6023de7a53ae2e..329c2e9bbc69a725 100644
> > > > > --- a/tools/perf/util/sort.c
> > > > > +++ b/tools/perf/util/sort.c
> > > > > @@ -3817,22 +3817,15 @@ static char *setup_overhead(char *keys)
> > > > >                 return keys;
> > > > >
> > > > >         if (symbol_conf.prefer_latency) {
> > > > > -               keys =3D prefix_if_not_in("overhead", keys);
> > > > > -               keys =3D prefix_if_not_in("latency", keys);
> > > > > -               if (symbol_conf.cumulate_callchain) {
> > > > > -                       keys =3D prefix_if_not_in("overhead_child=
ren", keys);
> > > > > +               if (symbol_conf.cumulate_callchain)
> > > > >                         keys =3D prefix_if_not_in("latency_childr=
en", keys);
> > > > > -               }
> > > > > -       } else if (!keys || (!strstr(keys, "overhead") &&
> > > > > -                       !strstr(keys, "latency"))) {
> > > > > -               if (symbol_conf.enable_latency)
> > > > > +               else
> > > > >                         keys =3D prefix_if_not_in("latency", keys=
);
> > > > > -               keys =3D prefix_if_not_in("overhead", keys);
> > > > > -               if (symbol_conf.cumulate_callchain) {
> > > > > -                       if (symbol_conf.enable_latency)
> > > > > -                               keys =3D prefix_if_not_in("latenc=
y_children", keys);
> > > > > +       } else {
> > > > > +               if (symbol_conf.cumulate_callchain)
> > > > >                         keys =3D prefix_if_not_in("overhead_child=
ren", keys);
> > > > > -               }
> > > > > +               else
> > > > > +                       keys =3D prefix_if_not_in("overhead", key=
s);
> > > > >         }
> > > > >
> > > > >         return keys;
> > > >
> > > >
> > > > Have I decoded the patch correctly?
> > > >
> > > >         if (symbol_conf.prefer_latency) {
> > > >                 if (symbol_conf.cumulate_callchain)
> > > >                         keys =3D prefix_if_not_in("latency_children=
", keys);
> > > >                 else
> > > >                         keys =3D prefix_if_not_in("latency", keys);
> > > >         } else {
> > > >                 if (symbol_conf.cumulate_callchain)
> > > >                         keys =3D prefix_if_not_in("overhead_childre=
n", keys);
> > > >                 else
> > > >                         keys =3D prefix_if_not_in("overhead", keys)=
;
> > > >         }
> > > >
> > >
> > > Yep, that's correct.
> > >
> > >
> > > > If I decoded the patch correctly, it's not what we want.
> > > >
> > > > For the default prefer_latency case we also want to add overhead, t=
hat
> > > > was intentional for the --latency preset. It does not harm, and all=
ows
> > > > to see/compare differences in latency and overhead.
> > > > Again, if a user wants something custom, there is no way to second
> > > > guess all possible intentions. For non-default cases, we just let t=
he
> > > > user say what exactly they want, and we will follow that.
> > > >
> > > > "latency" should be added even if cumulate_callchain.
> > >
> > > Please note that it just sets the sort key - which column you want to
> > > order the result.  The output fields for overhead and children will b=
e
> > > added in perf_hpp__init() if you remove the 'was_taken' logic.  So I
> > > think this change will have the same output with that.
> >
> > Yes, but perf_hpp__init() does not have the logic that's currently
> > contained in setup_overhead().
> >
> > If the user specified a "latency" field, and we don't want to add
> > "overhead" in that case, then _both_ setup_overhead() and
> > perf_hpp__init() must not add "overhead".
>
> Ok, I see your point.  But I think it'd be much easier if you allow the
> 'overhead' column in that case too.


It may be possible. However, one of my motivations that I did not
fully explain and realized myself is as follows.

You referred to fields and sort order as to different things. However,
for a person not working on perf code internals these are mostly the
same thing.

Fields are merged into sort order, sort order elements appear as fields.
Say, if I do "-F symbol,overhead", output will be sorted by symbols
first, so fields =3D=3D sort. Similarly, anything specified in --sort
appears as fields in output, so sort =3D=3D fields.

My current code keeps behavior for them consistent. Making it
non-consistent may be confusing for users.

For example, --hierarchy requires --sort (fails with -F), so I tend to
use it more than F (commands with --sort are already in my bash
history).
So if I want latency and symbol I tend to do:

perf report --sort latency,symbol

and with my current code this behaves the same way as:

perf report -F latency,symbol

Which matches my mental model of F/sort being the same.
However, if we remove was_taken, then the above commands behave
differently, which for end user like me is:
=C2=AF\_(=E3=83=84)_/=C2=AF


After reading the code, I think I understand the difference
(hopefully), e.g. it allows me to do a subtle things like:
-F symbol,overhead --sort overhead,symbol
(not sure how useful this is compared to always sticking to field
order for sorting)




> > If we do what you proposed, then perf_hpp__init() will still add
> > "overhead" and we go back to square 0.
>
> Right, but currently the default perf report and with --latency option,
> will show both overhead and latency columns.  That's why I thought you
> wanted to display them together.
>
> Actually I don't want to use -s option to describe output fields (like
> overhead and latency) but I cannot prevent people from doing that. :(
> Maybe you can skip the setup_overhead() if user gives either 'overhead'
> or 'latency' explicitly - oh, you have that in the !prefer_latency case.
>
> >
> > I used was_taken to not duplicate this non-trivial logic in both
> > functions. As I mentioned in the previous replies, I tried that but it
> > was messier/more complex. was_taken is a simple way to not duplicate
> > logic and keep these functions consistent.
>
> Hmm.. ok.  Maybe we can update this part later.  Can you please add a
> comment in the perf_hpp__init() that says overhead and latency columns
> are added to the sort list in setup_overhead() so it's added implicitly
> here only if it's already taken?

Added a comment capturing some of this discussion in v7


> > > > For the !prefer_latency case, we don't want to mess with
> > > > overhead/latency fields if the user specified any of them explicitl=
y.
> > > > Otherwise this convenience part gets in the user's way and does not
> > > > allow them to do what they want. User says "I want X" and perf says
> > > > "screw you, I will give you Y instead, and won't allow you to possi=
bly
> > > > do X".
> > >
> > > That's what -F option does.  The -s option used to specify how to gro=
up
> > > the histogram entries and it will add 'overhead' (and/or 'latency') i=
f
> > > it's not even requested.  So I think it's ok to add more output colum=
n
> > > when -s option is used.
> > >
> > > But unfortunately, using -F and -s together is confusing and change t=
he
> > > meaning of -s option - it now says how it sort the result.
> > >
> > > >
> > > > And see above: -F does not work with --hierarchy, so this part is u=
nskippable.
> > >
> > > Yep, but I mean it fixes --hierarchy and --latency.  I'm thinking of =
a
> > > way to support -F and --hierarchy in general.
> >
> > I don't know why it was disabled. There are likely other things to
> > improve, but please let's not tie that to this change.
>
> Right, it's a separate issue.  I was afraid of mixing output fields and
> sort keys in an unexpected order.  But maybe we can support that if
> that's what user wants.
>
> Thanks,
> Namhyung
>
