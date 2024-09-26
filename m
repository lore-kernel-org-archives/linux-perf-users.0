Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF116D4E6;
	Thu, 26 Sep 2024 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727310860; cv=none; b=AccgAU20CiiPnbW9GBiagsDTayfwNCedJAyQ7S4bYfoU34GH2mEscn/d1sBP+iSA9OZk0bM3C/9omjcq9YcGpn+FIXqONlVToVwxFgbptqTgl5B+kL8UUjdZPRAhTWX+BUJ1Nl+8FlUJljh1R6rNd9PWH+zaxHLS6Meaju3Inp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727310860; c=relaxed/simple;
	bh=um2xMlvib2CN05auEw1jp/lh1xunvTfllOnZydnRhQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aph6wM8Qj/NIeGFI2v7hqyvFidxZ2INBkoMxggp+JsIjyaLEqeQITd/Tn0x+MDY8zDD2JwTR8YklfLQsKNtDcht+6VQXuimmAzvL6fa/5HGYXAXcr+yfWCvFel/5dGmCX2bIyM9okb+kakk0EAvZJlMHMJPa29Be8NW9uc2M5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7tbpnj5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7tbpnj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38FDC4CEC3;
	Thu, 26 Sep 2024 00:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727310858;
	bh=um2xMlvib2CN05auEw1jp/lh1xunvTfllOnZydnRhQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7tbpnj5WOzdHcTEW25rt+QlegitMWjk1hY34B0t7CZLhdK+vySW0gRvov8IG1Hxl
	 2sjlJ1rjmsB3ZTeFXaXTwLwC6N2HxW95gIOlt3CxqABPSiCfnFCKy7dGtAdZCEwQUN
	 G/IQseAAb/viBtAa9tcQ+yN/SiZXsf+rPilT7nYgzH/ze+GPkKhPVMHwQyjU051Whv
	 qe8sRLLWxQOzubtrggvSyArunGu1pfPTn5DQdPcUOdyUn3pK2qhc0ef7K3ttsK/PFQ
	 28vmvw9I+Adx05wmjVNQsp/LV4HkFtlHh8gXeNpCi+Ldl9TC0cyieDq/pt5SE7L6W1
	 48MwswGdiny1w==
Date: Wed, 25 Sep 2024 17:34:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Atish Patra <atishp@rivosinc.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 09/11] perf build: Rename HAVE_DWARF_SUPPORT to
 HAVE_LIBDW_SUPPORT
Message-ID: <ZvSsB8bT3CTLT4B0@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
 <20240924160418.1391100-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924160418.1391100-10-irogers@google.com>

On Tue, Sep 24, 2024 at 09:04:16AM -0700, Ian Rogers wrote:
> In Makefile.config for unwinding the name dwarf implies either
> libunwind or libdw. Make it clearer that HAVE_DWARF_SUPPORT is really
> just defined when libdw is present by renaming to HAVE_LIBDW_SUPPORT.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-check.txt         |  6 +++---
>  tools/perf/Makefile.config                      |  2 +-
>  tools/perf/arch/powerpc/annotate/instructions.c |  4 ++--
>  tools/perf/arch/x86/annotate/instructions.c     |  2 +-
>  tools/perf/builtin-annotate.c                   |  2 +-
>  tools/perf/builtin-check.c                      |  6 +++---
>  tools/perf/builtin-probe.c                      | 12 ++++++------
>  tools/perf/builtin-report.c                     |  4 ++--
>  tools/perf/util/annotate-data.h                 |  8 ++++----
>  tools/perf/util/debuginfo.h                     |  6 +++---
>  tools/perf/util/disasm.c                        |  4 ++--
>  tools/perf/util/disasm.h                        |  4 ++--
>  tools/perf/util/genelf.c                        |  4 ++--
>  tools/perf/util/genelf.h                        |  2 +-
>  tools/perf/util/include/dwarf-regs.h            |  6 +++---
>  tools/perf/util/probe-event.c                   |  4 ++--
>  tools/perf/util/probe-finder.h                  |  4 ++--
>  17 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> index 45101a8e4154..31741499e786 100644
> --- a/tools/perf/Documentation/perf-check.txt
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -47,15 +47,15 @@ feature::
>                  bpf                     /  HAVE_LIBBPF_SUPPORT
>                  bpf_skeletons           /  HAVE_BPF_SKEL
>                  debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
> -                dwarf                   /  HAVE_DWARF_SUPPORT
> -                dwarf_getlocations      /  HAVE_DWARF_SUPPORT
> +                dwarf                   /  HAVE_LIBDW_SUPPORT
> +                dwarf_getlocations      /  HAVE_LIBDW_SUPPORT

I'm not sure if we really want to display dwarf_getlocatiosn as it's too
implementation detail IMHO.  Maybe just 'dwarf' or 'libdw' is enough.

Thanks,
Namhyung


>                  dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
>                  auxtrace                /  HAVE_AUXTRACE_SUPPORT
>                  libaudit                /  HAVE_LIBAUDIT_SUPPORT
>                  libbfd                  /  HAVE_LIBBFD_SUPPORT
>                  libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
>                  libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
> -                libdw-dwarf-unwind      /  HAVE_DWARF_SUPPORT
> +                libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
>                  libelf                  /  HAVE_LIBELF_SUPPORT
>                  libnuma                 /  HAVE_LIBNUMA_SUPPORT
>                  libopencsd              /  HAVE_CSTRACE_SUPPORT
