Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B314B959
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363419; cv=none; b=TvKKDYxWzKdgsZi+qqWJgbecgGRxQ1+h4lQ4W662vq6QmXzN7444sOVxYKQ72bJLYIS91z6PH2lj2sPnL6wX/2aN5SFwbCdRDRyJfLI3hKjPVC3DLPW0jlHGCeHoSXaSF1mCQH9qVjfbbamiUn5z/EeKu6ng6/E2MH7vTz868d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363419; c=relaxed/simple;
	bh=hVE5ZilPLPNfrXuAXy2c+9nnJM7MfQr580xYHLvoS5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cu0IBmxCXC5PXaelHUMDKINNXRdsDbUe2DZ8llsEyo3qJ9Uc8wmUoAcy8a8VnBWnipCwP0/un1VtE54qGKeeV5xlEo7y23yGNKDM/U+VTaU34mk5SQMvYiVtqUuFtKiSBq1nYI9x/wqOUDyowdSgIzVNlVrpfhi0v1L9oXD8co4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Loa6j8EH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Loa6j8EH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2056aa5cefcso244665ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727363417; x=1727968217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd5wd2EDy91T2PV08KE1FbhF8/gu2jxlRWd3WkzT05w=;
        b=Loa6j8EHZu4P4kGTCvSe4W9ZdLLykufzI2am6uezCHNPZjwBDmVvSfnH6sSGKw9DFU
         VYm/+SOFG+rVr/AfzZGP2+4RiKIvMKD6QM9Ih4CmVzSpoOGBLRLFCo9w6XDVf3sJljlb
         4lCD9Bo1TRR8HWL8/NaoIc1lOQ4jCJ+rbinlyyjHAO2BzN8jMDpF4ZQHGkioZuWzLAAo
         j6plwBWxwVZroOh+YZpcJ/Bq1gOewcz6pJxDeOXELcoiSACmG+1ypXW97g3SU3P4TymP
         xT/MXkWNl+mmKkkNga90+jzTN2cSvuPU9Wr4+/E0Jv1bkEzCdqSXghUUDzO3GO+Iug4Q
         Xqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727363417; x=1727968217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd5wd2EDy91T2PV08KE1FbhF8/gu2jxlRWd3WkzT05w=;
        b=r+1bLkac+Zr6a97/6/+6Z0yA3/fP8owmAMMYfFWZOMMTQzK+Uu6KqsiM+961kYF1TI
         vFT44VGCUUSwi40tQOGEbsrlOkOiJN5SQCpXHTihFnPD03BzmJyrktjspdT4PdwsGrve
         GQdU83Z1wC1IM3BRgAhrxBO+3BI99eozVFgBlAx8cERDUbIiITJCSZOWzG0UztQbxIOt
         25Jt15YCK845rwFv7U2jkgcorjlEOEFjGZh2x+i+veUlbJ/2D/HyY8zL8iIJN3QOtPld
         YO/TZ9mxuhfge/ZrTYFtU7GMGbar7x1awlwyZltWa3j39w5+Ka0Ti+zuWk6lPeSTdHWe
         2sww==
X-Forwarded-Encrypted: i=1; AJvYcCWZKskXdlzJSgz2NLdtJDryx5w+Ra1nKfqKQWZ3swqLoNEekNzaOfv8/Or+vJwpyZjHj7Xhy5kI+LguStMxL9iC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7YhQAJqRwhmZZNOQn7MxmxwpjRiyPWlQyaNXmwXHppy20g7N3
	Gv/NYtUA/PLx7orU+F0jEP6wmtpOepN1+jp5VkPOAgXaS6Nz+zsf5ytY8FkIoTvqiQSoPTpF8KT
	DJMHMbpK4iqc8WGdlUlwDg9+Exfr6IkTGOElY
X-Google-Smtp-Source: AGHT+IHqRahqJwKWGmO6jTznzohb0TucVdaEV7XZBmzejNts+U7KeuAbCH3+rT6TkZcAAe+lnGE5M4p+H4ijVdt+KEA=
X-Received: by 2002:a17:902:fa8e:b0:1fc:719c:5d9 with SMTP id
 d9443c01a7336-20b203cad58mr2787815ad.25.1727363416347; Thu, 26 Sep 2024
 08:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-10-irogers@google.com>
 <ZvSsB8bT3CTLT4B0@google.com>
In-Reply-To: <ZvSsB8bT3CTLT4B0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 08:10:04 -0700
Message-ID: <CAP-5=fWe-CAgNb7ULNJc0e+Kr0zxSJZNUuF1iTrB7J=ANcUwUw@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] perf build: Rename HAVE_DWARF_SUPPORT to HAVE_LIBDW_SUPPORT
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Sep 24, 2024 at 09:04:16AM -0700, Ian Rogers wrote:
> > In Makefile.config for unwinding the name dwarf implies either
> > libunwind or libdw. Make it clearer that HAVE_DWARF_SUPPORT is really
> > just defined when libdw is present by renaming to HAVE_LIBDW_SUPPORT.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-check.txt         |  6 +++---
> >  tools/perf/Makefile.config                      |  2 +-
> >  tools/perf/arch/powerpc/annotate/instructions.c |  4 ++--
> >  tools/perf/arch/x86/annotate/instructions.c     |  2 +-
> >  tools/perf/builtin-annotate.c                   |  2 +-
> >  tools/perf/builtin-check.c                      |  6 +++---
> >  tools/perf/builtin-probe.c                      | 12 ++++++------
> >  tools/perf/builtin-report.c                     |  4 ++--
> >  tools/perf/util/annotate-data.h                 |  8 ++++----
> >  tools/perf/util/debuginfo.h                     |  6 +++---
> >  tools/perf/util/disasm.c                        |  4 ++--
> >  tools/perf/util/disasm.h                        |  4 ++--
> >  tools/perf/util/genelf.c                        |  4 ++--
> >  tools/perf/util/genelf.h                        |  2 +-
> >  tools/perf/util/include/dwarf-regs.h            |  6 +++---
> >  tools/perf/util/probe-event.c                   |  4 ++--
> >  tools/perf/util/probe-finder.h                  |  4 ++--
> >  17 files changed, 40 insertions(+), 40 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Docum=
entation/perf-check.txt
> > index 45101a8e4154..31741499e786 100644
> > --- a/tools/perf/Documentation/perf-check.txt
> > +++ b/tools/perf/Documentation/perf-check.txt
> > @@ -47,15 +47,15 @@ feature::
> >                  bpf                     /  HAVE_LIBBPF_SUPPORT
> >                  bpf_skeletons           /  HAVE_BPF_SKEL
> >                  debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
> > -                dwarf                   /  HAVE_DWARF_SUPPORT
> > -                dwarf_getlocations      /  HAVE_DWARF_SUPPORT
> > +                dwarf                   /  HAVE_LIBDW_SUPPORT
> > +                dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
>
> I'm not sure if we really want to display dwarf_getlocatiosn as it's too
> implementation detail IMHO.  Maybe just 'dwarf' or 'libdw' is enough.

I think that's follow up work. I think we should rename dwarf to libdw
given the confusion using dwarf here can create.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >                  dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
> >                  auxtrace                /  HAVE_AUXTRACE_SUPPORT
> >                  libaudit                /  HAVE_LIBAUDIT_SUPPORT
> >                  libbfd                  /  HAVE_LIBBFD_SUPPORT
> >                  libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
> >                  libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
> > -                libdw-dwarf-unwind      /  HAVE_DWARF_SUPPORT
> > +                libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
> >                  libelf                  /  HAVE_LIBELF_SUPPORT
> >                  libnuma                 /  HAVE_LIBNUMA_SUPPORT
> >                  libopencsd              /  HAVE_CSTRACE_SUPPORT
