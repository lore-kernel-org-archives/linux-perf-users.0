Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE43A0E93
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576723; cv=pass; b=K8lNjp4mTq2qgiVaos6aFdVZwCvirgJefTGSXv4JH3pJX2XoYZz869MBg9i6JvFAXaSQgR2YVeQnUtdNbcIOfoJStZtKoY3Q4F1yAv8WTsVpvjC2P1Bl9Y46qDRV4cEJHEXYH1jKCkxlzt1bH7VawgRcVV23oLR0PfvYUXEGYMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576723; c=relaxed/simple;
	bh=SizGIY284nP8QgZuEKppOPomV+o+qh9r0uDkXXwENVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtBKVDqX7M1U9iCFdCvCRJT18hXHJZdbK1Uf6Yama9x9JD9B7TU2aZRq8t2x7rgzcPhdOk2n8GhTQt+0EhzBw4DyWMU3fs+SSdNpP++wIrBRU2IJX7gZ90T3aih6lTblt5ZGnpdhNKvRrT0S4H79bdryUT1NVKna9AleL+kSuPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdPENVRK; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdPENVRK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0c12be0ecso392225ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 08:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775576710; cv=none;
        d=google.com; s=arc-20240605;
        b=V2oPT/NWn+RGNEqVcSBrtMCinZoxTh+vNERt2lcv1xR6a9nPNpg2DUtQA2k21lDRt9
         Zg6D/tq6yLy/XZuIJ6eGw6H/TpImaKssP++KbCGmelJfr7eJze4f0o5TKQBHvqWLRCsa
         FRxbGIlROBssHQWcEDsNknqlUz1y0caiHThdhh+OiCHSZ7nXc8zNwW1O5eWuGxTsfXcU
         aiKMnOZy56KV0kwuUfVB5P/O9TA9nTKxxzpnKNRT3VgxJQFTEk5jZ8QpqeGdSYfPCWBs
         QMtmHTuBl3/AJvtvhYygiOHX9CJwWqzKnzyIr//rNsLMXm/RuE+6QQ2AvrH3A5j/5xT3
         Rr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZpyJUW1Ezz/DD7esDLCF1oEdUp+kVl5856msRhvzN10=;
        fh=tGk7NxC452YfukqbzVuVSHAKdOqoyP0UKWtuT2TVVQY=;
        b=jhZGB4kLuQaTJ9m4CNbNqIlOGX3cO6p7ctCA73fLXtvIjfBn7i0XVH+KSjAujcykex
         lNhcUNHFxiDM/2FNzE4+qvPw7IzATlgqdL4TX/YAfwM+6dBuF0uZH8Y44E0f5dRm68tX
         w1xNXOib6+ev6P02jzpR0rqr4WAm6M6iIpmZmMi/l5ZQKvA94mMaVcldLVUMT6j4Y78X
         sn/QdJZG3ftLcUIUlQ1INUNbQYjku9IkqLAgL1wB8PD3jt/eqW8eN+xAv+g3zdq/3dIS
         8bvK+ikVabllEkR/pgtsm1EJTWm/s///7bRNG7NrPl3FYiKzQyjKEL/2PqJC+o7VE1pD
         uYKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775576710; x=1776181510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpyJUW1Ezz/DD7esDLCF1oEdUp+kVl5856msRhvzN10=;
        b=SdPENVRKTfJPQpu/LOLtT0JvuVEOOB+nFPawu58XK+bsuTTxNxe7j5yv5xI8VGtjYj
         i/vaNzzYOdOneiMgpzizAHoHBxSFegfAD+JaGuScdai9JAKOT17WGhq6Qd/JFAqI9h0Y
         DTXcIIVhy5iYFleZb1tndTeoDD17IyT0Z0qRKPueriF7bIZpiGp6EFtXHQ1E2j+fmZub
         i0S5ITI2+pY2AyWdGQSPxuxis8LngJdBWfMztkGWxvCCMB8BzQxWV4HuO5ZvpMLrMOwl
         6JJTlzThJbABNLsiDjmqHsygLrsmsGtx269I8PfGrZKA0l/ZrM0+PprPeWVLKBPROT9r
         TUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775576710; x=1776181510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZpyJUW1Ezz/DD7esDLCF1oEdUp+kVl5856msRhvzN10=;
        b=bXJO6pfZCyPJbsL0LrC4Fc3oGH7MNIcSF4uN30NcjorolFWdCiCJRyF8O5aTe6vue6
         xXy2ojfdLEBzdcRlZi/c2s9SpFGrnMkv0hHCSN+yu2RGeJO3dSruCAj6E/roPlPQRzUs
         3wYXcNEgmSyH7tpw19EEWMjyDz1IdoSqtbmJPY3LOJTNH1ItOn8JZpYBhEe56OlkfqEF
         Psif8UEmR355v4iY1aK6opNpef5RkWDbsNeS9egF450x27PQKtDwSLa91dLuOjsEewJn
         n3hq884B6Pe2Cw+A1Zmwr6AwgfGr+sgMBBuD3uE4UQETrZOmeskPQJmlXpbNUmJiwrXI
         XyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYbyMO0XDf2zsynNB6CKUfufbACeDy1PmDyjR5jX3+BwbQp2Gtm+TLqvyWjGxru2EJsQR5DYgtqVq/3Xg5m02C@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeeikf7XEgj6VNedJ/VCzYSYaW6vbUt4OEWLvwgNJRJ7jfLzV
	lXGHnq0/RgHgG+tKsio23YySilH9EnP97OUBiykbeAhD2oC9y0ufWvGtiDPdsjrXPZigc/F+tbC
	78nqfsbC85vEN9szDVQaJylIGa6eDNAlaSI4PW9jU
X-Gm-Gg: AeBDiesHxxcxyjsuRxGieczq02lQFismVcSjqiENRepiHj8FBKgsZuwLYmuuNZT7703
	B9WKiReXqCJlGZTJ77kviAt3/+5SwQRsySI7nNbdiIbIuxA3DNBTnWNjfLgPEhHIGY4zo/RkV4B
	UI1cgC/SpkNmxV9yodPUTnHN1GqC0N9l5Two+OqELCvHyEAVf6cmGcOXZ1I/gvMDluswbB9s4rw
	NRJurCFzNv7ZNR8A8cNvzzdLEF0nJZpOKeDxiwDz5PG29ALHpp+F/Hz1g4nYFfB6CuBwRu0PXHf
	K1FVyOC4L9dtzzpKwB3qgRkn67k8E089ofuZxQ==
X-Received: by 2002:a17:902:ccc4:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b2840058dfmr9378235ad.15.1775576709885; Tue, 07 Apr 2026
 08:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402001740.2220481-1-acme@kernel.org> <20260402001740.2220481-5-acme@kernel.org>
 <CAP-5=fVv=5H-6DOaAr4BSDE=pKrxWDa9oduYbVTozYc-ZeeuRg@mail.gmail.com> <adTzzKCWES52egGl@x1>
In-Reply-To: <adTzzKCWES52egGl@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Apr 2026 08:44:58 -0700
X-Gm-Features: AQROBzBo428HQZn7_Bfg3X2uNsBBi00wMV7bCwvvPoELZ_wadxXURz-8N6R9gpE
Message-ID: <CAP-5=fV7Mgy0JvA896PGBaNwE7qW2rRd+Lee5uWghHMwbwfmVg@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf symbol: Add missing libgen.h include to get
 basename() prototype
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 5:08=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Thu, Apr 02, 2026 at 08:19:24AM -0700, Ian Rogers wrote:
> > On Wed, Apr 1, 2026 at 5:20=E2=80=AFPM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > This works in some places because there are tricks to prefer a GNU
> > > version instead of the XPG version, but started breaking in some musl
> > > libc systems due to some unrelated change that made libgen.h stop bei=
ng
> > > included by chance.
> > >
> > > Since symbol.h is using basename(), make it include libgen.h.
> >
> > Huh, this is being flagged by Sashiko:
> > """
> > Could this include cause segmentation faults by exposing the POSIX vers=
ion
> > of basename() to the rest of the tools?
> >
> > According to the POSIX specification, if the input is an empty string
> > or slashes, basename() can return a pointer to a statically allocated,
> > read-only string literal (such as "." or "/").
> >
> > In tools/perf/util/probe-event.c:convert_exec_to_group(), the code take=
s
> > the return value of basename() and modifies it in-place:
> >     ptr =3D basename(exec);
> >     ...
> >     for (ptr2 =3D ptr; *ptr2 !=3D '\0'; ptr2++) {
> >             if (!isalnum(*ptr2) && *ptr2 !=3D '_')
> >                     *ptr2 =3D '_';
> >     }
> > If a user provides an empty target or "/", the POSIX basename() would
> > return a read-only string. When the loop attempts to write a null or
> > underscore into it, wouldn't it trigger an immediate segmentation fault=
?
> >
> > Is there a way we can safely duplicate the returned string before modif=
ying it,
> > or ensure the inputs never resolve to these static strings?
> > """
> >
> > The story of the two basename versions and the issues appears in the
> > man pages. The whole thing makes me think we should avoid basename :-)
>
> What sashiko pointed out is a problem in some other part of perf that is
> unrelated to this patch and requires a separate fix, no?

Not quite, from the man page:

  With glibc, one gets the POSIX version of basename() when <libgen.h>
is included, and the GNU version otherwise.

As `symbol.h` is included in many places, then, with your change
whenever `symbol.h` is used the behavior of basename will flip.

> I.e. tools/perf/util/probe-event.c already includes libgen.h since
> 581037151910126a ("perf probe: Add missing libgen.h header needed for
> using basename()") from March, 2024.
>
> In the scope of this patch the potential problem isn't possible as
> __symbol__join_symfs() isn't changing the return of basename(), right?
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git grep '\<basename(' tools/per=
f
> tools/perf/builtin-daemon.c:    base =3D basename(basen);
> tools/perf/scripts/python/exported-sql-viewer.py:               if short_=
name[0:7] =3D=3D "[kernel" and os.path.basename(long_name) =3D=3D "kcore":
> tools/perf/util/annotate.c:             d_filename =3D basename(filename)=
;
> tools/perf/util/dsos.c:        * basename() may modify path buffer, so we=
 must pass
> tools/perf/util/dsos.c:          * basename() may return a pointer to int=
ernal
> tools/perf/util/dsos.c:         base =3D strdup(basename(lname));
> tools/perf/util/probe-event.c:  ptr1 =3D basename(exec_copy);
> tools/perf/util/symbol.h:               base =3D basename(path_copy);
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> It seems just the probe-event.c case needs fixing.
>
> And we also have this in tools/perf/util/srcline.c:
>
> /* basename version that takes a const input string */
> static const char *gnu_basename(const char *path)
> {
>         const char *base =3D strrchr(path, '/');
>
>         return base ? base + 1 : path;
> }
>
> That probably could be reused to avoid these basename() oddities?

Yeah, probably move gnu_basename to util.c/h and then make all callers
use gnu_basename and not basename. This would mean that symbol.h using
util.h, instead could we move  __symbol__join_symfs to symbol.c to
avoid all these includes and touching a file requiring everything
being rebuilt? The function is large enough that including it in the
header doesn't make much sense.

Thanks,
Ian

> - Arnaldo
