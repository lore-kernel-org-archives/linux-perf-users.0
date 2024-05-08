Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E721373;
	Wed,  8 May 2024 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202658; cv=none; b=BmGIf5a0GzRNX8Bgt8TQUmEyJWTEXNUWnNQ26CS5nc2T8jZgehVj4p0uhGK/KMmppD31y0V8UOv/cdqTQ5Df6bOiwx2wOuRKpFbK6DhSbha3cxpYAphywhHeFAYl1A41TpHldXfG4oatPxJVOziMF8RwDshQu+Y1+M7V5ezbJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202658; c=relaxed/simple;
	bh=Rq0sgbSVKAF9f0zp2XsnYI13Zjl1Mao2IwDg3Lw3aSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwhfpGgBYGaOTORAXpRQlC6CDlF+Vmzgpe4V4P3avYRsaknWoJoCMayU+oPl5jN/YMj7zpdrUzCqW4+aEqFbceYnC8SoBd+OkQOiQt2fOH9TkNZXLGvihou3NWKMr1f8hYGTTdmNRF5dsWXWPfFw2s/2kUHAl9amYdTmj2LZXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so194030a91.2;
        Wed, 08 May 2024 14:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715202656; x=1715807456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6imyIJTMo4xA0dmfwzlWT+Xdp+rxpa+6dL8UE1tHP98=;
        b=ZmnzVEMS1Z+6Gi8jLXkoFgo3KoLr+5/FeKYOCxi40oxEPfDgaG3CB3qHZnJruXsmOL
         AVCRAVThpEWOAVyE22OtAkblspt0ITGEDRrESC0IXNDN+WDHAB2PgbmEmA9TwrBRaDzV
         UluzzZgHK/jfDDvxaOdBtKuHBEDsfZNUlHP6oFfMtrpWiK7Tx5XqELoeMdZyizkjw58h
         81RZYHgsnhFDbvov+d5bOHeuHkrWZNnax6WbXTs5wMc8N4qMeu/KKA/HKwNZCASzqvVZ
         EI22m5dTEmzGDOhY+mPX7Tvxl4ZsdJcwarfnFnhZpFyzyJxmpZ8qFmu6MyTKH/AlwOZT
         lhsg==
X-Forwarded-Encrypted: i=1; AJvYcCXuMq8tOpm7HnHuWekhW1iaWoET0O0C92N8BGSGZdufK7csXWSEDP7Yzs7DbZK4oYooOLNbb1ESdQOwPwjVozu82nHTKSgA4MIbvErnuUF+9asZhJSnXpzEX1Q0aHADAMeKDn3HOpICvSECphSYNg==
X-Gm-Message-State: AOJu0YyGWRVNMjHjVHAj3ztgiTmyaHHrLlQ0/2Cw9iJ+d+8gsOy9taBl
	PBkxX0hxNQ/l9W4uEmZ0d6mQO/Y95J/FgcPsRwrKPSawNLWIqopqiepP/G6wBDAy0UOkiH98VJJ
	Zptxu8IydaXsbzM6oqmnR4H+6sYQ=
X-Google-Smtp-Source: AGHT+IHF7osWwaB+EPlf7x9OJczyN/NXgIFzOdtLI1gg2tsvLXNsI4+heT5l3jY0MwuJDNnOMdgQeS/Rzzs+MxvsXSo=
X-Received: by 2002:a17:90b:914:b0:2b2:c85f:aa0b with SMTP id
 98e67ed59e1d1-2b616be62f6mr3738098a91.42.1715202656458; Wed, 08 May 2024
 14:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508141458.439017-1-james.clark@arm.com> <CAP-5=fWMbLDmT8=h_He7+9V+ntTdg1+5hmSTm87VJsTy2m3Bag@mail.gmail.com>
In-Reply-To: <CAP-5=fWMbLDmT8=h_He7+9V+ntTdg1+5hmSTm87VJsTy2m3Bag@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 8 May 2024 14:10:44 -0700
Message-ID: <CAM9d7cgeWXB45WEwHLOazVKvq-e-34v2q-MikdjyweHP8b7tFg@mail.gmail.com>
Subject: Re: [PATCH] perf dwarf-aux: Fix build with HAVE_DWARF_CFI_SUPPORT
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	leo.yan@linux.dev, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 2:05=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, May 8, 2024 at 7:15=E2=80=AFAM James Clark <james.clark@arm.com> =
wrote:
> >
> > check_allowed_ops() is used from both HAVE_DWARF_GETLOCATIONS_SUPPORT
> > and HAVE_DWARF_CFI_SUPPORT sections, so move it into the right place so
> > that it's available when either are defined. This shows up when doing
> > a static cross compile for arm64:
> >
> >   $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- LDFLAGS=3D"-st=
atic" \
> >     EXTRA_PERFLIBS=3D"-lexpat"
> >
> >   util/dwarf-aux.c:1723:6: error: implicit declaration of function 'che=
ck_allowed_ops'
> >
> > Fixes: 55442cc2f22d ("perf dwarf-aux: Check allowed DWARF Ops")
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> (eye-balled to see the #if problem exists and this is the correct fix)

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
