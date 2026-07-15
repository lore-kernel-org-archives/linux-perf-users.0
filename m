Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265A41F5CC
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145687; cv=none; b=GCecu6FtN8v6MGDwL8oO5XdTwPmX0ksOcQOEXIToeR5hyT/EWTm/yvqYxcfmuE1YmUawFLG17OcHDaGpBS8b+KbLO7TxhWNdaPsTrUmQhGuLZJ6tuuu6G8S0ENxEacE2i7IMPlO1x6RvRwJOOyeAQD01bgYCs4CiAXGNeiAlr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145687; c=relaxed/simple;
	bh=uwxmuyKFx6g5q5HJXgqVNf9gdV44Jter6qaifngoZlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e00umLY2rvvZZT1BavJz59JGYJykExkFbDYMK+SwOvyZyOZhkfKCshg3JplNk2xl7zmIQfH0PRJco1j+TrCp6U+ceJM5QruML7ypPDB99yNAdFlwvrPtEhXSGRkarCJ8lVNVnZ1dDmX65hIonZyusfptbR4Ye7a8Yew/e50yFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OIsyIa1T; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OIsyIa1T"
Message-ID: <1a3378d8-2148-488f-a385-a20335553a9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784145677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8V5CX44D4jZQ0nRMWUdMxp0ZQiAGX/gtKoCLQP9d5Jo=;
	b=OIsyIa1TcYFh3nvcfnHzc4LyZ91jfE5QUxWO/MMKVE3Wxpcf0mmZL1JYd/77NeCKRCbSR2
	VegVVMGxr4y8jPoCtVz2xy3fyzPYcF4WvDd6BSH+PjJXO1wPriA1oSkb8QUDiG6Osvd2Od
	UoraCX3qu4QOEuDgU8Ad7bUsnGKSwnI=
Date: Wed, 15 Jul 2026 13:00:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/4] tools/build: Allow versioning LLVM readelf
To: James Clark <james.clark@linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
 <20260715-james-perf-llvm-version-v4-3-6dfdf984b435@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260715-james-perf-llvm-version-v4-3-6dfdf984b435@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/26 7:53 AM, James Clark wrote:
> Documentation/kbuild/llvm.rst mentions that readelf is included in the
> LLVM toolchain, but it's not currently included in this block.
> 
> Add it so that LLVM=... options also apply to readelf. Users in tools/
> were Perf which was hardcoding it, and another was the BPF makefile.
> Both already include Makefile.include so convert them to use the new
> variables.
> 
> Where readelf wasn't doing anything arch specific, use HOSTREADELF
> because it's more likely to be installed.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/lib/bpf/Makefile         | 8 ++++----
>  tools/perf/Makefile.perf       | 1 -
>  tools/scripts/Makefile.include | 4 ++++
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index eca584fb061e16013e76827e4203f6be0477a73e..269fe21fc8da73083367b3c122bdd2b718e12bc5 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -115,12 +115,12 @@ PC_FILE		:= $(addprefix $(OUTPUT),$(PC_FILE))
>  
>  TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
>  
> -GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
> +GLOBAL_SYM_COUNT = $(shell $(HOSTREADELF) -s --wide $(BPF_IN_SHARED) | \
>  			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
>  			   sed 's/\[.*\]//' | \
>  			   awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
>  			   sort -u | wc -l)
> -VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
> +VERSIONED_SYM_COUNT = $(shell $(HOSTREADELF) --dyn-syms --wide $(OUTPUT)libbpf.so | \
>  			      sed 's/\[.*\]//' | \
>  			      awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
>  			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
> @@ -183,12 +183,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
>  		     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
>  		     "Please make sure all LIBBPF_API symbols are"	 \
>  		     "versioned in $(VERSION_SCRIPT)." >&2;		 \
> -		readelf -s --wide $(BPF_IN_SHARED) |			 \
> +		$(HOSTREADELF) -s --wide $(BPF_IN_SHARED) |		 \
>  		    cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |	 \
>  		    sed 's/\[.*\]//' |					 \
>  		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
>  		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
> -		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
> +		$(HOSTREADELF) --dyn-syms --wide $(OUTPUT)libbpf.so |	 \

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

>  		    sed 's/\[.*\]//' |					 \
>  		    awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
>  		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf> index 476b8dcaef58cb1f3fa75f46a647c2cfe2352767..4d0d7ae02e06b117487a17691c4e62a138428ac5 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -215,7 +215,6 @@ FLEX    ?= flex
>  BISON   ?= bison
>  STRIP   = strip
>  AWK     = awk
> -READELF ?= readelf
>  
>  # include Makefile.config by default and rule out
>  # non-config cases
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index e81e5b479c563321e458b2a7ad8fca2b4607a254..46a3872b87624a7bf475d9b42a3e471f36789dfd 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -73,6 +73,8 @@ ifneq ($(LLVM),)
>    $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
>    $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
>    $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
> +  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
> +  $(call allow-override,HOSTREADELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
>  else
>    # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
>    $(call allow-override,CC,$(CROSS_COMPILE)gcc)
> @@ -80,11 +82,13 @@ else
>    $(call allow-override,LD,$(CROSS_COMPILE)ld)
>    $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>    $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
> +  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
>  
>    # Host versions aren't prefixed
>    $(call allow-override,HOSTAR,ar)
>    $(call allow-override,HOSTCC,gcc)
>    $(call allow-override,HOSTLD,ld)
> +  $(call allow-override,HOSTREADELF,readelf)
>  
>    # Some tools still require Clang, LLC and/or LLVM utils
>    $(call allow-override,CLANG,clang)
> 

