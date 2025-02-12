Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3B1FCF62;
	Wed, 12 Feb 2025 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389648; cv=none; b=fWLR6iicfgyLDK2OvHoHgPfBoSChOcYFoYMgHAvaqdTiWZu3P5pf2ZzkYCGEIjvhTddCJUa7ucLJ6isgOmgQtUa0nLyX+pFNiwuBsXvLfMDFJn1026F958e+w6cfUTGIbLnWHx1D27IyIs/JN/eZJEGVDlOGEpjJGBy2ior4Lj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389648; c=relaxed/simple;
	bh=n1Yrc133x+G4MJHEHEy4UdQHNvSunG07EFrM7aCNh68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb3H0o8subMahO59CWFhYYHomXEFMU0ldEDEFFyoHu0qVw8lRBcwp5GFzGDWaQmlVTQ6W4hcId8JJRLgXRICcgiDHKirBAssQWhu15qECO9nMeD13uv/VeWVRT8Obym02oP/hR/wa6e3GJ9zbPtnRto11244Xfz705HSKh4gX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=te7n+rBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="te7n+rBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5593C4CEDF;
	Wed, 12 Feb 2025 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739389647;
	bh=n1Yrc133x+G4MJHEHEy4UdQHNvSunG07EFrM7aCNh68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=te7n+rBTrapQNOXLuYFF7hD46kGbqAV57cVKVHoVxJkb54S3dX40me6KIyHrfnhLP
	 mXfnmFskL17VgsuxiQ0evNISrgIS3xYII50GCvGmOsY2WPQ1/1320xbLP1rEfBzsiF
	 4woAHExFgN8He553w1H7p5Oz1h3f+3/o6ViUhFva2DLPK+ObXr5YgSCrJfkD0DHq+x
	 bRJfTulS9kzp3ZlT2L6euqIb3RdQZRJZ9MIMeaMN9ndBZ3rYhSoydD636jjKUJbqis
	 ObZ8vVxT4niFK/UoUrvanmeEoM0voMncpkxIwD+N2kE5fSnBl/MNC+Ho96fbdwTAeo
	 1LrTlliigkCYQ==
Date: Wed, 12 Feb 2025 11:47:26 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 6/8] perf report: Add --latency flag
Message-ID: <Z6z6znWi3o-ewuNs@google.com>
References: <cover.1738772628.git.dvyukov@google.com>
 <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
 <Z6WBsruddcx0SFV5@google.com>
 <CACT4Y+afC5WfTMaKGtg760PS5oXkkurzAyHVyKr9TsPs9RU2DQ@mail.gmail.com>
 <Z6qhjFs0YOMTzk9W@google.com>
 <CACT4Y+brgj5vRoxQtZ76hUVcHWUJJ2u_8n89EwuTAoyXXbGDCw@mail.gmail.com>
 <Z6uMBAG0hePL9JV3@google.com>
 <CACT4Y+YB_Ckfptkyu6yiF5Daa8q4MgGyf_1u7RPjoTsdQ3h=qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YB_Ckfptkyu6yiF5Daa8q4MgGyf_1u7RPjoTsdQ3h=qw@mail.gmail.com>

On Tue, Feb 11, 2025 at 09:23:30PM +0100, Dmitry Vyukov wrote:
> On Tue, 11 Feb 2025 at 18:42, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Feb 11, 2025 at 09:42:16AM +0100, Dmitry Vyukov wrote:
> > > On Tue, 11 Feb 2025 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Fri, Feb 07, 2025 at 08:23:58AM +0100, Dmitry Vyukov wrote:
> > > > > On Fri, 7 Feb 2025 at 04:44, Namhyung Kim <namhyung@kernel.org> wrote:
> > [SNIP]
> > > > > > > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > -int hpp_dimension__add_output(unsigned col)
> > > > > > > +int hpp_dimension__add_output(unsigned col, bool implicit)
> > > > > > >  {
> > > > > > > +     struct hpp_dimension *hd;
> > > > > > > +
> > > > > > >       BUG_ON(col >= PERF_HPP__MAX_INDEX);
> > > > > > > -     return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> > > > > > > +     hd = &hpp_sort_dimensions[col];
> > > > > > > +     if (implicit && !hd->was_taken)
> > > > > > > +             return 0;
> > > > > >
> > > > > > I don't think you need these implicit and was_taken things.
> > > > > > Just removing from the sort list when it's unregistered seems to work.
> > > > > >
> > > > > > ---8<---
> > > > > > @@ -685,6 +685,7 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
> > > > > >  static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
> > > > > >  {
> > > > > >         list_del_init(&format->list);
> > > > > > +       list_del_init(&format->sort_list);
> > > > > >         fmt_free(format);
> > > > > >  }
> > > > > >
> > > > > > ---8<---
> > > > >
> > > > > It merely suppresses the warning, but does not work the same way. See
> > > > > this for details:
> > > > > https://lore.kernel.org/all/CACT4Y+ZREdDL7a+DMKGFGae1ZjX1C8uNRwCGF0c8iUJtTTq0Lw@mail.gmail.com/
> > > >
> > > > But I think it's better to pass --latency option rather than adding it
> > > > to -s option.  If you really want to have specific output fields, then
> > > > please use -F latency,sym instead.
> > > >
> > > > Also I've realized that it should add one sort key in setup_overhead()
> > > > to support hierarchy mode properly.  Something like this?
> > > >
> > > > Thanks,
> > > > Namhyung
> > > >
> > > >
> > > > ---8<---
> > > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > > index 2b6023de7a53ae2e..329c2e9bbc69a725 100644
> > > > --- a/tools/perf/util/sort.c
> > > > +++ b/tools/perf/util/sort.c
> > > > @@ -3817,22 +3817,15 @@ static char *setup_overhead(char *keys)
> > > >                 return keys;
> > > >
> > > >         if (symbol_conf.prefer_latency) {
> > > > -               keys = prefix_if_not_in("overhead", keys);
> > > > -               keys = prefix_if_not_in("latency", keys);
> > > > -               if (symbol_conf.cumulate_callchain) {
> > > > -                       keys = prefix_if_not_in("overhead_children", keys);
> > > > +               if (symbol_conf.cumulate_callchain)
> > > >                         keys = prefix_if_not_in("latency_children", keys);
> > > > -               }
> > > > -       } else if (!keys || (!strstr(keys, "overhead") &&
> > > > -                       !strstr(keys, "latency"))) {
> > > > -               if (symbol_conf.enable_latency)
> > > > +               else
> > > >                         keys = prefix_if_not_in("latency", keys);
> > > > -               keys = prefix_if_not_in("overhead", keys);
> > > > -               if (symbol_conf.cumulate_callchain) {
> > > > -                       if (symbol_conf.enable_latency)
> > > > -                               keys = prefix_if_not_in("latency_children", keys);
> > > > +       } else {
> > > > +               if (symbol_conf.cumulate_callchain)
> > > >                         keys = prefix_if_not_in("overhead_children", keys);
> > > > -               }
> > > > +               else
> > > > +                       keys = prefix_if_not_in("overhead", keys);
> > > >         }
> > > >
> > > >         return keys;
> > >
> > >
> > > Have I decoded the patch correctly?
> > >
> > >         if (symbol_conf.prefer_latency) {
> > >                 if (symbol_conf.cumulate_callchain)
> > >                         keys = prefix_if_not_in("latency_children", keys);
> > >                 else
> > >                         keys = prefix_if_not_in("latency", keys);
> > >         } else {
> > >                 if (symbol_conf.cumulate_callchain)
> > >                         keys = prefix_if_not_in("overhead_children", keys);
> > >                 else
> > >                         keys = prefix_if_not_in("overhead", keys);
> > >         }
> > >
> >
> > Yep, that's correct.
> >
> >
> > > If I decoded the patch correctly, it's not what we want.
> > >
> > > For the default prefer_latency case we also want to add overhead, that
> > > was intentional for the --latency preset. It does not harm, and allows
> > > to see/compare differences in latency and overhead.
> > > Again, if a user wants something custom, there is no way to second
> > > guess all possible intentions. For non-default cases, we just let the
> > > user say what exactly they want, and we will follow that.
> > >
> > > "latency" should be added even if cumulate_callchain.
> >
> > Please note that it just sets the sort key - which column you want to
> > order the result.  The output fields for overhead and children will be
> > added in perf_hpp__init() if you remove the 'was_taken' logic.  So I
> > think this change will have the same output with that.
> 
> Yes, but perf_hpp__init() does not have the logic that's currently
> contained in setup_overhead().
> 
> If the user specified a "latency" field, and we don't want to add
> "overhead" in that case, then _both_ setup_overhead() and
> perf_hpp__init() must not add "overhead".

Ok, I see your point.  But I think it'd be much easier if you allow the
'overhead' column in that case too.

> 
> If we do what you proposed, then perf_hpp__init() will still add
> "overhead" and we go back to square 0.

Right, but currently the default perf report and with --latency option,
will show both overhead and latency columns.  That's why I thought you
wanted to display them together.

Actually I don't want to use -s option to describe output fields (like
overhead and latency) but I cannot prevent people from doing that. :(
Maybe you can skip the setup_overhead() if user gives either 'overhead'
or 'latency' explicitly - oh, you have that in the !prefer_latency case.

> 
> I used was_taken to not duplicate this non-trivial logic in both
> functions. As I mentioned in the previous replies, I tried that but it
> was messier/more complex. was_taken is a simple way to not duplicate
> logic and keep these functions consistent.

Hmm.. ok.  Maybe we can update this part later.  Can you please add a
comment in the perf_hpp__init() that says overhead and latency columns
are added to the sort list in setup_overhead() so it's added implicitly
here only if it's already taken?

> 
> 
> > > For the !prefer_latency case, we don't want to mess with
> > > overhead/latency fields if the user specified any of them explicitly.
> > > Otherwise this convenience part gets in the user's way and does not
> > > allow them to do what they want. User says "I want X" and perf says
> > > "screw you, I will give you Y instead, and won't allow you to possibly
> > > do X".
> >
> > That's what -F option does.  The -s option used to specify how to group
> > the histogram entries and it will add 'overhead' (and/or 'latency') if
> > it's not even requested.  So I think it's ok to add more output column
> > when -s option is used.
> >
> > But unfortunately, using -F and -s together is confusing and change the
> > meaning of -s option - it now says how it sort the result.
> >
> > >
> > > And see above: -F does not work with --hierarchy, so this part is unskippable.
> >
> > Yep, but I mean it fixes --hierarchy and --latency.  I'm thinking of a
> > way to support -F and --hierarchy in general.
> 
> I don't know why it was disabled. There are likely other things to
> improve, but please let's not tie that to this change.

Right, it's a separate issue.  I was afraid of mixing output fields and
sort keys in an unexpected order.  But maybe we can support that if
that's what user wants.

Thanks,
Namhyung

