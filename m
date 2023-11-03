Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC91C2B6
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVa5r15i"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE91BD
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 08:41:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507c9305727so3575e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Nov 2023 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699026084; x=1699630884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRaJx5yqDoLyT5Xi3DrUXbLg8Rya2MY4ntt0ooWt/pY=;
        b=YVa5r15iCTcnhduAgAXBO91zsBizM++a3H9jJurUuQ3smDK0JtQ7d6pCNwKt4CS+hG
         m3hfRf1Dbjh/z1Oqk3axxH+2dO+1YHrUttmpZANCAiRO+wVasa6cYvlMDEfqHoufP+4O
         U+ATdT/CR6BFzAXoBXbzG4rloH58Mv4yqFeRNeNqfBLjbrpVDNDUXlP+rNcxhcMiDcme
         EP4YjOjuuLITF4oOiNm9D45aTvxR0j4naQz40tiwedM6drfcdZSxbNuhRE13ArOMGEgU
         sNAcPHKBnlhNMcolfqipAbPGC9eQg/hWsQ8yZN8fXgwBLGjN8F9rEfbC3lVb9E8GC8zL
         hhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026084; x=1699630884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRaJx5yqDoLyT5Xi3DrUXbLg8Rya2MY4ntt0ooWt/pY=;
        b=X2Rs/pN7hxqsK0sr25pfqxNT7YOqSxQp81B8fRgJNZENkHA8b+WE3FU3kxDO0j+cFI
         uEfJDteJ/yKQ0zMknmd88kQWuYsxgiyc3CT3PvlVK7f+rzaso+dBvrzmx+EegSCGPKh3
         gjOwrdS4Vp14TuEsfMk/fdx2Fxc8aUU7rOsykmwg/xk/CVCYNGbcXyyBxiGoPVxtPYVw
         O0gXWEBAWe9zD9sY7LYdb3QoB52RJH3Q7Vm4iC0ek6kKEuEykxYpH4t35jPi/RxZHn7d
         XwhMLqAOJ8bbt11wISrnNLe4Gf9qFGkcDqIYKeSUuwjxfyQGGLIJT9+oQFk4KJEoMxcE
         0BUQ==
X-Gm-Message-State: AOJu0YypyVcoUb7Bo0necPO7NEoRS1kSmd/UXETfm/hpqOUAUjFi5IR1
	RLBEYWoB/0PEyMa6GD2CMfKAqr5G5Zumf5MZL1NmYQ==
X-Google-Smtp-Source: AGHT+IH310mUKc8QXz+cZoC/fxdXqHImALuyVrBOwQDL0RiBksQVuXw44g9e6DniBg/n5jlSutqpX8jNZa0LiEdDLEg=
X-Received: by 2002:a05:6512:358c:b0:509:4535:b272 with SMTP id
 m12-20020a056512358c00b005094535b272mr143154lfr.3.1699026083710; Fri, 03 Nov
 2023 08:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103113501.490012-1-james.clark@arm.com>
In-Reply-To: <20231103113501.490012-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Nov 2023 08:41:12 -0700
Message-ID: <CAP-5=fWazX_q1W8HN7ErrRMB2bx5sz3x1V=+XqY7Hxx0jR0p9w@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add option to change objdump binary
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 4:35=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> All of the other Perf subcommands that use objdump have an option to
> specify the binary, so add the same option to perf test.
>
> This is useful if you have built the kernel with a different toolchain
> to the system one, where the system objdump may fail to disassemble
> vmlinux.
>
> Now this can be fixed with something like this:
>
>   $ perf test --objdump llvm-objdump "object code reading"
>
> Signed-off-by: James Clark <james.clark@arm.com>

There is also "perf config" for things like this.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
