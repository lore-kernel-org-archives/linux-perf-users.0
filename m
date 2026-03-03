Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5238C435
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578770; cv=pass; b=iR8Xh17qbmDPa/VOSH4IUoPsngjMH5P2f0CjEmr3gnm2Zsm0k+hcOJ6RFpHkFKRFerBHBs8CnCVzi2YrEAkpVIZW4hS7spDCXgB9yj/NzWlNIuDgMdr6bEXQzeMPGw9E+Ie2Rug0IZlOoWT1ysXSm+mgnIgeOG3+Tk5F/cSgZ4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578770; c=relaxed/simple;
	bh=r4BpBujAf96rJszGZ7D1Ew65lJB9bP9Smn3rNoeKafs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrXkdYJu0jknMlPujKtEgAwjON7oe9ZLKxz9VTp/RBE8VVL9fEP8vmLy34pHo9RKmT7eoMkkeL9rm2w/GoL+RPULBLNj67stS7N86nx1E7SBiyoevGFtJ54ZaX1zumRoSZVlBYgiYUoR4uQ4QB9+x3/bpBXm1m366l9baY6Tkjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Iv1PZMA; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Iv1PZMA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae523d54d2so124755ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 14:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772578769; cv=none;
        d=google.com; s=arc-20240605;
        b=AR9W9lp6Ak9EI3VwVSQnRCprloDTfug39GvdDqx38XlfLf0BN//s9boSlKnI+hDZmG
         GJzRGtFQDrfwUX/vjuZ3XjWPIMGDLmmMGpX66BUWay0GeAAM8KP+M6YyE6E00wRKS+9f
         /mdJwl7K1S81orFQOxT/gnM+ocKqKbK5ns/xbrRQwk56a9htYK2xwcXVdZ1GmppYw0d8
         NhUsvovHzygiO/CFQ5qVU7C7CqgTqZgNfkjiDgceGw4PFnT39WDTBVyEXE0QbxusFzA6
         2FTDMy30xuKXJtEXoTIPGnwTRGe5I5CZNZ72h3Mh8eXNGoc54u1DTCEA2xZ+u+/3bJFw
         R7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RAUx2Hh98pnPWu25+lY2nplxXPqfu0Jg3P7givY2rLQ=;
        fh=kjYoAh00NKz2D3eXo1CbyX7En4ejoY/ZlAodxtSShbw=;
        b=lRjUdotiqlYG15tAT7XUB2EhFN1QK5mE+0Nc3UKqAxNz0zb9azIplW8nalMdXmPgPL
         Ayw3SeLUbCAyBJMExtucuC9HBCZrwawehsduS+KFztGxsKRiSCrTcukeW8zNI10BPTxa
         ramFLwVbxyvpYuCBMZ+cPU1jdeK2/Ki3kjWBXLXIRcfMrwXCN8sRlocg+/NbZvsDoC7k
         MJXPwbgykowt5Mul4C88ZhcF2DW1nHAXahNVe9ayMEsfU9Hwo0ql9JzDh2OMAHsxMKXc
         zAGYGMKA19SyiuMX4S+0PoLQ4S7zdGOx4cxTWS0egqFM+WB0geBdYy9RcEmINFq18nGk
         nAuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772578769; x=1773183569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAUx2Hh98pnPWu25+lY2nplxXPqfu0Jg3P7givY2rLQ=;
        b=4Iv1PZMAn5gpZl1FgxejzL128WoPpm3KUS6/wD+wPaWkruIn4d7QfLp3IwKPZZpB8a
         +JODPpWjd3oa6IDLmhEkXmG3IlzXyU87jmTWX5u8t6OWjddevdLdjB2tfWu6nOmbPZOR
         my8BX36HdMuWipsZ6TIfgenpiEtTgFOCgJIgrp3cJLGVS7rIohEa14S+0AU/odvRS3IO
         /jzFtXIaIV3n8UzRLKf1bbzdkawo63FP0hbbwzJJPX9cjWEYN9GY70viQ1VT1slwrvpM
         DfFA1EFDOTQH9R6K+eHrNU94PgN2B5hfiU56R13p5Gviz2wZEcXUeswyEZHbXVbl6nmi
         D8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772578769; x=1773183569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RAUx2Hh98pnPWu25+lY2nplxXPqfu0Jg3P7givY2rLQ=;
        b=w+sr0pYBocIwJOUemeGpPNWs1o1zi6L8u7P/DqFeIa6kCMy97a0O8DiRyEBGqU0Nx5
         YuSr+vI1q287pFI7Olcst60HAkvwLA6Pmda31Ith8ISM4f3JWdzEHugvdzjVBWWbgqAF
         a97VKSJVABLzBJ7IrFhUysS/pRkfA7bIhNWeEx3fefGZJwJmWJvgSPrYpUVN9tgUy5zJ
         WIB5h46b2etRXLP/DTi6m+aM9GLPQCgj2stcqk23tjj6gQHtGcni92IgmAsyxX0a5zHX
         waUCBqa5aNh8+ogy9pS3ZpizNrHq7fmqvHSd0I92BnlAbZfWH5jZCBtD+biJWnxQcqV0
         cJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQcaL2u92Zh4W4mL+fXnCvazirn3ekEQ7S50aYbt0ywUZbwtlsYIfN523zmKyNEmATwvvD5qKVgorcfYhirlWX@vger.kernel.org
X-Gm-Message-State: AOJu0YxZPBmqNLzIkmKDAFAXxU2Dy2Qup7wGKZztEt9U05/9PkXLU8Bs
	bzJ79qycSYg1Yz+bT/MHconPvIh5R14oE0cAzjhXYXt0juuc0CSaQAOR3unyn4boJzRbPnkf9g+
	1fPJ8iSUmcVMBNf3XpLuMESKZgl4PEfWBXwnIkWMl
X-Gm-Gg: ATEYQzz9AdujjFmpxpqHHw/EbFuyA+fqbug93zgAEjgfwMqim7Zdh8yNUb2vOluYZn1
	srw1srmQUn0xTWPn2PfZ/EJWT7N+wca2y7/qlTOSWiFtLQPOnl/EhrAT6x5CKbU4PQ1qDVm7Nw2
	nzU67dXPkn80xSXRvldJDXXpteXvFI9a3y99Rft9JLFBhDncuNyQGlAmKBS0S2hsVUjlvSXCP9l
	eCaMUR6hgjaAN7Fh4AEgfiIAy8aQB/SZ3PYESAwmKvBsIyfRY1hHy4J6hSPlEwOQ56wwYKo25YR
	g49firhScAdesLYoj4EW74wyGpRm/ah0rjKQTw==
X-Received: by 2002:a17:902:e54b:b0:2ad:e574:7a7 with SMTP id
 d9443c01a7336-2ae3b5138b9mr7614285ad.11.1772578768457; Tue, 03 Mar 2026
 14:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303211503.165337-1-mmayer@broadcom.com> <CAP-5=fV5yQGGL3q9KB-3-bc+T0ZyW6robVLhskb7aSQ7HV=a5Q@mail.gmail.com>
 <CAGt4E5t_VXxnYHJhvWCwhfap5=tnFLHHvhaPafru0A+XcZmiXA@mail.gmail.com>
In-Reply-To: <CAGt4E5t_VXxnYHJhvWCwhfap5=tnFLHHvhaPafru0A+XcZmiXA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Mar 2026 14:59:17 -0800
X-Gm-Features: AaiRm508E-wLVwbX1crx-rT1JQGXXiJC9hGfmqAH7h-yw4TwK1mtjCpfIKmOlzg
Message-ID: <CAP-5=fVfwZx7ys2xk7cBOEeVYydg4Rzr0ARw9XJa=WfNhwX1Fw@mail.gmail.com>
Subject: Re: [PATCH] perf build: prevent "argument list too long" error
To: Markus Mayer <mmayer@broadcom.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Perf Mailing List <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 2:47=E2=80=AFPM Markus Mayer <mmayer@broadcom.com> w=
rote:
>
> On Tue, 3 Mar 2026 at 14:35, Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Mar 3, 2026 at 1:16=E2=80=AFPM Markus Mayer <mmayer@broadcom.co=
m> wrote:
> > >
> > >   TEST    [...]/arm64/build/linux-custom/tools/perf/pmu-events/metric=
_test.log
> > > make[5]: /bin/sh: Argument list too long
> > > make[5]: *** [pmu-events/Build:217: prune_orphans] Error 127
> > > make[5]: *** Waiting for unfinished jobs....
> > > make[4]: *** [Makefile.perf:773: [...]/tools/perf/pmu-events/pmu-even=
ts-in.o] Error 2
> > > make[4]: *** Waiting for unfinished jobs....
> > > make[3]: *** [Makefile.perf:289: sub-make] Error 2
> >
> > As with:
> > https://lore.kernel.org/lkml/20250728093153.2330009-1-changqing.li@wind=
river.com/
> > I'm not able to reproduce the problem but the change makes sense.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks for the review. Not sure what makes my setup different from
> yours. FWIW, it's an ARM64 cross-compile. I had the build system dump
> the contents of $(ORPHAN_FILES) into a file for me. This is how many
> files it was trying to pass via the shell:
>
> $ wc -l json_files.txt
> 634 json_files.txt
>
> Maybe you have fewer orphans to prune or your shell has a higher the
> argument limit. Whatever the case, both our automated nightly builds
> and manual builds have been running into this issue.

Yes, building an x86 version and then cross-compiling for ARM would
create a large set of orphan files requiring cleanup. Trying that with
a giant output directory path I couldn't trigger a breakage, but I
think I just have a very generous MAX_ARGS.

Thanks,
Ian

> Regards,
> -Markus
