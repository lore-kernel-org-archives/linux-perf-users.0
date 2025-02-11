Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE41EE7D5
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305425; cv=none; b=YJSq5ULPZ5ebQSKhxYnmemEIawM92W+/mjThrel1WuWOdeVVK8nlSCnSt8C1tXI0mkZqETl0rqlXMV7+exQDgmK0/uFJMp7e8qOJIOVnwa0WXNAtM5GUujE01x/HufE65O2VU7QoxI+hf4/Al0Gn5sdTT5WF3/zYWAGrhB+1NfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305425; c=relaxed/simple;
	bh=nu+g8braZFq/6RFMloNF0B+jDmX+cvEIsch6YG8svfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGdZdRuJqdS/ke5OoAkpXJ09Ng3nzQq4hvzpuWjpqOw3wWeSv/TzoiKq+NBwRyfB0S+quBbF5rkw1a2TZ1I5fIk/5WFltvxlEgHijz/t7MDeTSq6n6jA8bKTU48IjFWwgmRbNNDl/dXtWWkWKt0RMn+84mo1n78nqjBi1cSPM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SgQLnEF8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgQLnEF8"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30797730cbdso58773701fa.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 12:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739305422; x=1739910222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3/MT8ys+ADgAinGP2p8Ypnjpy09+xK2m843XIGFUfg=;
        b=SgQLnEF8+4HJJzYimZiq+Rmt45Jjwb605rXyH22UOuvVhL96oqbWKbP+WUYe0EfKmk
         Xxy1HTsgoy1hHol3hopMj0XW1cWUfcbbgo2jLplymUgvZzRxUrLyqFnxx1th6ahoxXFb
         IUVDGr1iRnLCQNhsHI22AtzPaY8hknAN+Moj+B88rktF5la1A0dOimeTADG4DcdXrWlM
         okpl24Fa7qYVDm/IftQ1BT7nH6Z5Vev+oKOwsH8pujb0S8p04rwqRI6phlz7Ckgydm+X
         Z/IJTxQaLe8Eyy4iaKTl43AeIPvwTQbkyB6NZjrthSNPUyQSkRpUGjKPaJHAL5gcgWBp
         gv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739305422; x=1739910222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3/MT8ys+ADgAinGP2p8Ypnjpy09+xK2m843XIGFUfg=;
        b=YuYyt2GpRCjiKFl0ylJCvSZ8o4Ql4Eu85krex0ju90GjfUlkeT5e1l9Wy4+2XVQqQD
         ellM5HWYze1GaKP1rRbI2AtGUHRbM7Fq6fgfTJNIVpy86kFkxGrcAL6hmynmUMXjTN24
         Z2VWXUWeVJupnEEhnMJyJhJ/Tn5plkOCuKTwL9iW7Ut5rmlOdgcIooIHtAX1BSWcyCLR
         c7c136C7n2uO0+EjN7xrn1JqPYcqVma80O1SV1HGQ8Pei2/LypKqn5JYAEoo8sk4Hiu0
         XkYputHJxC1H9hPMuerGgWWM/Hpj7mUNj8m7HwSZu4VYPtQTI1TaJtzgZ8O2KeVpVUEb
         4nuA==
X-Forwarded-Encrypted: i=1; AJvYcCXP8kOJhlRkHbBpwjKtFUldViC5QqEoo8soIYMyalRKG00vPJSzt1yOnZCoq3bhFQbK/pOzikRsEABfNfX2Bpq7@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDzt8vriLELrqZWlz3Ymv5fbLZ884y8UUbUWCwm2ERFxr5sga
	MxOwcbYeOQ2+R1geVTNtuT8DpA3cAhwhdgfPbijZAU2eZLrrfZoPRVEzK9bwryAEwlCIzzcgXXB
	5HTeBWR2SAW3Nr3y1U3XPhIcExQh0V/VYiKIK
X-Gm-Gg: ASbGncvXTw9e50VDlIO9+8jETV4yNHzugG9Pq1xQagi6NjNuBaYGfilGugfHQge/mP+
	M2biwyhbnroynNucFa8w1EvWLcKh1L8Mm1wYpliqaImYee2i8kBN198qdMuFhNUhm7+2aapsJZq
	BateoCq0dD9XB5Pylz9sQCJZ0wcgqp
X-Google-Smtp-Source: AGHT+IGgl5B7zUqu81I0TwqtVrMY+eV6m3uWOl98IEqX+slWfixAz3v1LsERZWIH12oCRxOrXAn7eBXhd9Ac5XOUGco=
X-Received: by 2002:a2e:bc84:0:b0:308:db61:34cf with SMTP id
 38308e7fff4ca-309036b585cmr4091181fa.14.1739305421668; Tue, 11 Feb 2025
 12:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
 <Z6WBsruddcx0SFV5@google.com> <CACT4Y+afC5WfTMaKGtg760PS5oXkkurzAyHVyKr9TsPs9RU2DQ@mail.gmail.com>
 <Z6qhjFs0YOMTzk9W@google.com> <CACT4Y+brgj5vRoxQtZ76hUVcHWUJJ2u_8n89EwuTAoyXXbGDCw@mail.gmail.com>
 <Z6uMBAG0hePL9JV3@google.com>
In-Reply-To: <Z6uMBAG0hePL9JV3@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 11 Feb 2025 21:23:30 +0100
X-Gm-Features: AWEUYZmnWnJVRraAWQ7AI5WqYVsmniGSEUXqGNvUJVrlwdwG8bV_gV1ty1WHGmI
Message-ID: <CACT4Y+YB_Ckfptkyu6yiF5Daa8q4MgGyf_1u7RPjoTsdQ3h=qw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] perf report: Add --latency flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 18:42, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Feb 11, 2025 at 09:42:16AM +0100, Dmitry Vyukov wrote:
> > On Tue, 11 Feb 2025 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Fri, Feb 07, 2025 at 08:23:58AM +0100, Dmitry Vyukov wrote:
> > > > On Fri, 7 Feb 2025 at 04:44, Namhyung Kim <namhyung@kernel.org> wrote:
> [SNIP]
> > > > > > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > -int hpp_dimension__add_output(unsigned col)
> > > > > > +int hpp_dimension__add_output(unsigned col, bool implicit)
> > > > > >  {
> > > > > > +     struct hpp_dimension *hd;
> > > > > > +
> > > > > >       BUG_ON(col >= PERF_HPP__MAX_INDEX);
> > > > > > -     return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> > > > > > +     hd = &hpp_sort_dimensions[col];
> > > > > > +     if (implicit && !hd->was_taken)
> > > > > > +             return 0;
> > > > >
> > > > > I don't think you need these implicit and was_taken things.
> > > > > Just removing from the sort list when it's unregistered seems to work.
> > > > >
> > > > > ---8<---
> > > > > @@ -685,6 +685,7 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
> > > > >  static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
> > > > >  {
> > > > >         list_del_init(&format->list);
> > > > > +       list_del_init(&format->sort_list);
> > > > >         fmt_free(format);
> > > > >  }
> > > > >
> > > > > ---8<---
> > > >
> > > > It merely suppresses the warning, but does not work the same way. See
> > > > this for details:
> > > > https://lore.kernel.org/all/CACT4Y+ZREdDL7a+DMKGFGae1ZjX1C8uNRwCGF0c8iUJtTTq0Lw@mail.gmail.com/
> > >
> > > But I think it's better to pass --latency option rather than adding it
> > > to -s option.  If you really want to have specific output fields, then
> > > please use -F latency,sym instead.
> > >
> > > Also I've realized that it should add one sort key in setup_overhead()
> > > to support hierarchy mode properly.  Something like this?
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> > > ---8<---
> > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > index 2b6023de7a53ae2e..329c2e9bbc69a725 100644
> > > --- a/tools/perf/util/sort.c
> > > +++ b/tools/perf/util/sort.c
> > > @@ -3817,22 +3817,15 @@ static char *setup_overhead(char *keys)
> > >                 return keys;
> > >
> > >         if (symbol_conf.prefer_latency) {
> > > -               keys = prefix_if_not_in("overhead", keys);
> > > -               keys = prefix_if_not_in("latency", keys);
> > > -               if (symbol_conf.cumulate_callchain) {
> > > -                       keys = prefix_if_not_in("overhead_children", keys);
> > > +               if (symbol_conf.cumulate_callchain)
> > >                         keys = prefix_if_not_in("latency_children", keys);
> > > -               }
> > > -       } else if (!keys || (!strstr(keys, "overhead") &&
> > > -                       !strstr(keys, "latency"))) {
> > > -               if (symbol_conf.enable_latency)
> > > +               else
> > >                         keys = prefix_if_not_in("latency", keys);
> > > -               keys = prefix_if_not_in("overhead", keys);
> > > -               if (symbol_conf.cumulate_callchain) {
> > > -                       if (symbol_conf.enable_latency)
> > > -                               keys = prefix_if_not_in("latency_children", keys);
> > > +       } else {
> > > +               if (symbol_conf.cumulate_callchain)
> > >                         keys = prefix_if_not_in("overhead_children", keys);
> > > -               }
> > > +               else
> > > +                       keys = prefix_if_not_in("overhead", keys);
> > >         }
> > >
> > >         return keys;
> >
> >
> > Have I decoded the patch correctly?
> >
> >         if (symbol_conf.prefer_latency) {
> >                 if (symbol_conf.cumulate_callchain)
> >                         keys = prefix_if_not_in("latency_children", keys);
> >                 else
> >                         keys = prefix_if_not_in("latency", keys);
> >         } else {
> >                 if (symbol_conf.cumulate_callchain)
> >                         keys = prefix_if_not_in("overhead_children", keys);
> >                 else
> >                         keys = prefix_if_not_in("overhead", keys);
> >         }
> >
>
> Yep, that's correct.
>
>
> > If I decoded the patch correctly, it's not what we want.
> >
> > For the default prefer_latency case we also want to add overhead, that
> > was intentional for the --latency preset. It does not harm, and allows
> > to see/compare differences in latency and overhead.
> > Again, if a user wants something custom, there is no way to second
> > guess all possible intentions. For non-default cases, we just let the
> > user say what exactly they want, and we will follow that.
> >
> > "latency" should be added even if cumulate_callchain.
>
> Please note that it just sets the sort key - which column you want to
> order the result.  The output fields for overhead and children will be
> added in perf_hpp__init() if you remove the 'was_taken' logic.  So I
> think this change will have the same output with that.

Yes, but perf_hpp__init() does not have the logic that's currently
contained in setup_overhead().

If the user specified a "latency" field, and we don't want to add
"overhead" in that case, then _both_ setup_overhead() and
perf_hpp__init() must not add "overhead".

If we do what you proposed, then perf_hpp__init() will still add
"overhead" and we go back to square 0.

I used was_taken to not duplicate this non-trivial logic in both
functions. As I mentioned in the previous replies, I tried that but it
was messier/more complex. was_taken is a simple way to not duplicate
logic and keep these functions consistent.


> > For the !prefer_latency case, we don't want to mess with
> > overhead/latency fields if the user specified any of them explicitly.
> > Otherwise this convenience part gets in the user's way and does not
> > allow them to do what they want. User says "I want X" and perf says
> > "screw you, I will give you Y instead, and won't allow you to possibly
> > do X".
>
> That's what -F option does.  The -s option used to specify how to group
> the histogram entries and it will add 'overhead' (and/or 'latency') if
> it's not even requested.  So I think it's ok to add more output column
> when -s option is used.
>
> But unfortunately, using -F and -s together is confusing and change the
> meaning of -s option - it now says how it sort the result.
>
> >
> > And see above: -F does not work with --hierarchy, so this part is unskippable.
>
> Yep, but I mean it fixes --hierarchy and --latency.  I'm thinking of a
> way to support -F and --hierarchy in general.

I don't know why it was disabled. There are likely other things to
improve, but please let's not tie that to this change.
