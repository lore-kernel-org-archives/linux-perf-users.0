Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D15154449
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114859; cv=none; b=iPiZIYXt8yEm3u+ArzCpMtJozdIUH3+2mwDgKfUHSo0hxY0TjaFF52iotsD80deYhP6Jc6PaY/GRW9ZHUsX689miAsrJNLzBno386CXI+u4P2FScG3/MZYOj8MGLXlNq7lyiEBm053er0rpss/ZbR+UVLeUuwc5Pt+mWpSusQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114859; c=relaxed/simple;
	bh=3IaWesmiWr2cicrwXcF3eLCCczCO762Csg6QxbQA5w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZUzTJ8WvrC4Y5ifiyQ1R0mguZwI1alpLxgqgpzsQEVTmm33hUQmJbrCrirYI/ipPAAenrwViXNIs9jLvT2CmBae3GMIDukROJlhlmsU2GKrYw8GPZIdzcwnORkXE9itJFpSHlUbZXxyeEzcXi1MxiU/g9KVV17quxsJt7dYyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQRZ/T15; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQRZ/T15"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so193495ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 17:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738114857; x=1738719657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDsy6RSZpz9ow77za79sOYqCvwLqRyj79gdVd/xMSAY=;
        b=RQRZ/T15JG+nd0KF3n2FMbmTJX1oVt2HmeLlxWSsfNdc1hC78s+M+Fk54EdxVxaG0y
         KKmdssyfUX5w1s9WeRNl2gLtSwcEBN5+dyicec2Cka+MlrUrF0pUi5+VuU/A7sMfDGaE
         JeP8bc+CFWkj5Res5UvAu4F98VL/R+RKA76uPJtHwMYTMmKwGKF7mP3RpoCIEto+XV91
         1K9UZXJe/9GW5IbeWXIQzAH17q+rWgYsIXYejvzZbxq/isctWVID+IVTcPqzSJ2s2Op0
         x6JQR1tM3W82SE5zcmFZrCXecYiPr19rvQmxHbixwC2iV6qKPtXna81aYUFeowbB6K65
         yWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738114857; x=1738719657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDsy6RSZpz9ow77za79sOYqCvwLqRyj79gdVd/xMSAY=;
        b=Z5mqr4ayKcMLMeGJ8eS5XvvdrDQS++r0nC6zMRHm0UfQJH1RvXc7H2dS7SYQ3Jw3h/
         Ax/P3chd37Nqf8ZeR8Njl9NuAHxJmp0EAICErXWmdjV1R0YT+vqGOvzP8LSq0692hIbo
         NMTi6sJZ8TyWXEmr/uXA6qq1Ca2KfzXRNLfXOCYtpyL+etPLKtJBfsohtNPn99XLSmxC
         LQwv4gYnI3vPPeIlyvzwydWTMbilPODik4Jb67PIUPXFaEleiw+pFZ+BI7j60oQo8Goj
         pbQUMqlScIaThlqg4i2AdeA8ZyxwXXxfXos7ara/JkRhdyHtk234HZEco3G+FYumaBeb
         SMpg==
X-Forwarded-Encrypted: i=1; AJvYcCUBhPr/kovuq40BZHIaOBHDbl1C+FTOOvRufn6Mc5o8SDLZBZTeou32Yky8GhGXI5y3VmN1qSRg5r9yzM04JQPr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7U1kg4rHNxYJetlLWPJgCyzcSbv3pP5dlz+or3vJ7RnIbWakW
	pGrBp5hYtXbWmGQi0DhVxcVTDHy/SITOZ1pN5BsboKZYf5bA2djYcsRPaaiF57BterlLjEDF+Ms
	rJzZ2c8IUuVr8nDJqcfDEuKYHG6RB5skMxc5O
X-Gm-Gg: ASbGncsbJp/eXc1SeG2rUwsQ/mG0H1GDHX2MbosPZUMMWIZJ49mvO7lUw8of8KyLSKx
	PuHTiy8nBvci04/yBXl1ydGGRmBD/HZX5Ar08EZKyhksI7cvgm7xXD5BH6Xjk9K7oGeT8mnVMlA
	==
X-Google-Smtp-Source: AGHT+IFtwPircGx0cNqjWjLXFmuseDyJD49YXj0Fjsi0wsyI07WjwQhxx/Ru+LcHanJh3mJtoFcQQlcSOkqFnI4iTpw=
X-Received: by 2002:a05:6e02:1fc3:b0:3cf:c8b9:8826 with SMTP id
 e9e14a558f8ab-3cffeb833fdmr1919285ab.10.1738114856600; Tue, 28 Jan 2025
 17:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-14-irogers@google.com>
 <gnwmibvjtwboisw7uv32bdo4ziw4qzgwzvndqg2czpa6vp4olv@44n36ndbwobc>
In-Reply-To: <gnwmibvjtwboisw7uv32bdo4ziw4qzgwzvndqg2czpa6vp4olv@44n36ndbwobc>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Jan 2025 17:40:44 -0800
X-Gm-Features: AWEUYZlLjbLqgBHdACScPUyTzPQSG4bYslu6-GduAeDhlw3y6CZbVRjCdWJ9YaA
Message-ID: <CAP-5=fW9nM9zoQ5SQOq2HQfkougRotm=EBw99cvGDOpD=giK2g@mail.gmail.com>
Subject: Re: [PATCH v3 13/18] perf build: Remove libbfd support
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 4:31=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Ian,
>
> On Wed, Jan 22, 2025 at 09:43:03AM -0800, Ian Rogers wrote:
> > libbfd is license incompatible with perf and building requires the
> > BUILD_NONDISTRO=3D1 build flag. Remove the code to simplify the code
> > base.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-check.txt |   1 -
> >  tools/perf/Makefile.config              |  38 +---
> >  tools/perf/builtin-check.c              |   1 -
> >  tools/perf/tests/Build                  |   1 -
> >  tools/perf/tests/builtin-test.c         |   1 -
> >  tools/perf/tests/pe-file-parsing.c      | 101 ----------
> >  tools/perf/tests/tests.h                |   1 -
> >  tools/perf/util/demangle-cxx.cpp        |  13 +-
> >  tools/perf/util/disasm_bpf.c            | 166 ----------------
> >  tools/perf/util/srcline.c               | 243 +-----------------------
> >  tools/perf/util/symbol-elf.c            |  86 +--------
> >  tools/perf/util/symbol.c                | 135 -------------
> >  tools/perf/util/symbol.h                |   4 -
> >  13 files changed, 7 insertions(+), 784 deletions(-)
> >  delete mode 100644 tools/perf/tests/pe-file-parsing.c
>
> [..]
>
> I was briefly investigating why the centos build of perf was not
> demangling rust v0 symbols [0]. From looking at the rust issue [1], it
> appears the rust team somehow delivered support for v0 demangling
> through libbfd. The code itself looked a bit odd (relying on cxx
> demangle to run first?), but that's a separate thing.

There is still C++ demangling support by way of cxxabi:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/demangle-cxx.cpp?h=3Dperf-tools-next#n44
that was in libstdc++ (GNU) and libcxx (LLVM) when I looked.

> The centos build does not build with libbfd for the license issues you
> mentioned. So your change probably won't regress any distro use cases.
> But it does remove support for motivated users who don't have
> re-distribution requirements.
>
> But since this patchset came up first in my search, I thought it'd be
> good to mention that someone probably needs to add v0 support to
> tools/perf/util/demangle-rust.c.

So I don't see any libbfd dependencies in demangle-rust.c:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/demangle-rust.c?h=3Dperf-tools-next#n8
Unusually we don't have any tests on the Rust demangling, we do for
Java and OCaml:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/demangle-java-test.c?h=3Dperf-tools-next
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/demangle-ocaml-test.c?h=3Dperf-tools-next

Reading a bit more it seems that previous libiberty was coming to the
rescue by way of C++ demangling. I'll see if I can write a demangler
by way of lex and yacc. If we have a v0 standard one is there any
value in the existing demangler or legacy demangling? It seems this
has been broken for the best part of 5 years.

Thanks,
Ian

> Thanks,
> Daniel
>
>
> [0]: https://doc.rust-lang.org/rustc/symbol-mangling/v0.html
> [1]: https://github.com/rust-lang/rust/issues/60705
