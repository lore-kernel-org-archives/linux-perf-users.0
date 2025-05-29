Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2A1891A9;
	Thu, 29 May 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748501998; cv=none; b=ZsqzYbkwCuzTRgaK/uVqU7oz3EzI4YRw7dyWz2l9+ZBy8TSzwcgO1yczxfxK1XA6PpxEOl+GQy7eEiK+561hq9CTqKFLC1o35EciEcgz/JQiIDpRde3ql+ZexuEzM5/khli4msKARhDBhqb9erLmBgQn2z0X7w7JUZNFHu8NrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748501998; c=relaxed/simple;
	bh=ztOo2P+Kp25kZal9/S6GtVWn5jxb3IbOCVM//Ldz6T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3xUIre1YBI0tCQtKUnjuSgitgjtvvTwVBKes8XjN2pa5YznqDrSRck4SFlCdJgLKUkdSuBQwQQVAw1q7l4dDVFwG1EpYDy327aFbWPgs4ur+ywIAlEiv3WRkSmBZWu6e/AiG24I0yAU0PvNb4LK6pXF/QEGacif9aF68SWOAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLDR1S8o; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLDR1S8o"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7da03bb0cdso359667276.3;
        Wed, 28 May 2025 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748501996; x=1749106796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QrBk1b7GzNv1v3qwcsG2e8o+iQmGaHfk9Jdu6G+hic=;
        b=MLDR1S8oPRnyeZcN4Y3NfY62xyR2ZoCwWKTUfxl8vYZfDqS9yK8gvdZtzwSdP/kbtL
         CoF5MioibhcBWfJGvow7Zk8OW+Ar8lGbq1zvbIrKPTjeTCT49gMeK+x/BMM0Ftk2pHre
         TRGIZJcJcO1qCFWlYL/+6lXXRN+xhg3k0LNSYnFaWzxql3XYVrvxfYC8iLL3lgY2D/rV
         CZUxP5mbk4pOrwAp2bB4zzcOmOFGK7FX2xL9wuZFmYHCQTksJJkMc9hLYYByu5xKTmKx
         q7D/oTfoJDK3P+l7Fh0pkJdfpWTmE8dhlrzfnuyRRI3fxnlttERL2TFjREzfHA5yKEhJ
         mrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748501996; x=1749106796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QrBk1b7GzNv1v3qwcsG2e8o+iQmGaHfk9Jdu6G+hic=;
        b=ilXo+igjseTfxCriK88VcCdwGFUtQI4zsdNnTldS5+odFzxuLAwYvyeHY0gBWc1yWE
         tcdIWusI/D3l0mcaUoCFNqSWe/e9SwmgcblEa7s21036D8P2+w+srMFrZraGHorY57Xz
         xFMVrpPTXZb7HKWafPJurPHmEMmVYM3gFg9D1er+6Q65/LpcjrxLjjAzVF75TYbgEtho
         AOIbXbk4aSmyRUCsLFFwCEaFx24Ry0obYWXfz37TIVrV2XJrO2pHvB5CicuUFyfttG9g
         rdD3dFHq7ldN2dl+AYhqKaFmAJ0TT+/4TKE+eP58fu9Q/9WGLkx0yO7GKxdz741W2vBA
         OXFA==
X-Forwarded-Encrypted: i=1; AJvYcCU23U887aFPeloAtkOdoLKnNWtY/lum4KyoAaQ6u1/HFqo9wZjwqMAT4vHWdzpRHG/ps67nGycca63afEZm+mWUUA==@vger.kernel.org, AJvYcCUvGF2YcmSkD5td7D7cNQ+4/KZlsFeccUyqs+nIUwhhZTQXgTs4r3xDHdqFEp9Afe4xd8ExTo8KysrG50s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7xJvtSY5BTILTR+6fznyn8Aw+h6akRDRPD+WIKoYfnQ8cn9R
	bFKFH1OUyLdvEQ5b4BJQdDavwqlzByKjzFaZbQkk+UEmRIxcYkdcHjSOQV+gX2qwGD1yCXPkD2x
	A1puResbWra2YF931DgVYr84A8HI9N8g=
X-Gm-Gg: ASbGnctIEK5oSnyXw2KJgDGlN5SC3lru7zBhwIPlqlqdKrW03w4WeAtvqW0zfc5OkEE
	B6R1B0hygNJxMXfcw6nZZndL4Td1ItlVUyIJe/bhLXYk3NiMlHqqpUK1r8l3GuwT+5AXHbJYyM4
	zvEk4G09jKxvICMxb8wA9HoL4274ImrLU=
X-Google-Smtp-Source: AGHT+IHaThjw8dKJ98/uoe+DRSmC/l1hnpdyZwjXDuIcqRBU86D/SoMcww9vk3zzSOJdIuAqv5qDhJjNOzOf9lgvyeo=
X-Received: by 2002:a05:6902:450e:b0:e7d:9007:8685 with SMTP id
 3f1490d57ef6-e7d91b453d8mr17018283276.41.1748501995673; Wed, 28 May 2025
 23:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522142551.1062417-1-namhyung@kernel.org> <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>
 <aC9VoTL_Cv4R7J-j@x1> <aC-hHTgArwlF_zu9@x1> <aDDy4FQe7sBwECL8@google.com>
In-Reply-To: <aDDy4FQe7sBwECL8@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 28 May 2025 23:59:44 -0700
X-Gm-Features: AX0GCFvUB4AHXHI3CXK5FrvsQphFt_CGfX8AZNCotoRfo_fx8ZZO_f18V0VTW34
Message-ID: <CAH0uvog_5MToOmfcsEn3+hypPrftSvtQAe+Axe94TLNwgq4HbA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add cgroup summary test case for perf trace
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo and Namhyung,

On Fri, May 23, 2025 at 3:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, May 22, 2025 at 07:11:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, May 22, 2025 at 01:49:37PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Thu, May 22, 2025 at 08:33:16AM -0700, Howard Chu wrote:
> > > > $ sudo /tmp/perf/perf test -vv 112
> > > > 112: perf trace summary:
> > > > 112: perf trace summary
> > > > --- start ---
> > > > test child forked, pid 1574993
> > > > testing: perf trace -s -- true
> > > > testing: perf trace -S -- true
> > > > testing: perf trace -s --summary-mode=3Dthread -- true
> > > > testing: perf trace -S --summary-mode=3Dtotal -- true
> > > > testing: perf trace -as --summary-mode=3Dthread --no-bpf-summary --=
 true
> > > > testing: perf trace -as --summary-mode=3Dtotal --no-bpf-summary -- =
true
> > > > testing: perf trace -as --summary-mode=3Dthread --bpf-summary -- tr=
ue
> > > > testing: perf trace -as --summary-mode=3Dtotal --bpf-summary -- tru=
e
> > > > testing: perf trace -aS --summary-mode=3Dtotal --bpf-summary -- tru=
e
> > > > testing: perf trace -as --summary-mode=3Dcgroup --bpf-summary -- tr=
ue
> > > > testing: perf trace -aS --summary-mode=3Dcgroup --bpf-summary -- tr=
ue
> > > > ---- end(0) ----
> > > > 112: perf trace summary                                            =
  : Ok
> >
> > > Thanks, tested and applied to perf-tools-next,
> >
> > But then when running all the tests, since this does system wide
> > tracing, it fails:
> >
> > 112: perf trace summary                                              : =
FAILED!
> >
> > It works with the following patch applied, please check and ack/review:
> >
> > From 8c868979d886e2e88aa89f4e3d884e1b6450a7b2 Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Thu, 22 May 2025 19:01:47 -0300
> > Subject: [PATCH 1/1] perf tests trace_summary.sh: Run in exclusive mode
> >
> > And it is being successfull only when running alone, probably because
> > there are some tests that add the vfs_getname probe that gets used by
> > 'perf trace' and alter how it does syscall arg pathname resolution.
> >
> > This should be removed or made a fallback to the preferred BPF mode of
> > getting syscall parameters, but till then, run this in exclusive mode.
> >
> > For reference, here are some of the tests that run close to this one:
> >
> >   127: perf record offcpu profiling tests                              =
: Ok
> >   128: perf all PMU test                                               =
: Ok
> >   129: perf stat --bpf-counters test                                   =
: Ok
> >   130: Check Arm CoreSight trace data recording and synthesized samples=
: Skip
> >   131: Check Arm CoreSight disassembly script completes without errors =
: Skip
> >   132: Check Arm SPE trace data recording and synthesized samples      =
: Skip
> >   133: Test data symbol                                                =
: Ok
> >   134: Miscellaneous Intel PT testing                                  =
: Skip
> >   135: test Intel TPEBS counting mode                                  =
: Skip
> >   136: perf script task-analyzer tests                                 =
: Ok
> >   137: Check open filename arg using perf trace + vfs_getname          =
: Ok
> >   138: perf trace summary                                              =
: Ok
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Looks good to me.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Nacked (sorry). I think running them tests in parallel is great
because it points out a problem that perf trace has. Please check out
this approach: https://lore.kernel.org/linux-perf-users/20250529065537.5299=
37-1-howardchu95@gmail.com/T/#u

Thanks,
Howard
