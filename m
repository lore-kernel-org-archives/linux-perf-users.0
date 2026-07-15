Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA544A2E1D
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145780; cv=none; b=phMZoO+DqL8xogJgZr7fREOHpEg+qU25KRkxkKMrNxiav4uMlO/izKBL8JC3NcQIorhriy4lkYDfi+/OZUY9H/ARV+3tiaKBRWDj4EzDtnUPVg+vOJiNZTJmTYiMTmeJ8Fvkb62IoVuHGum+lyzRNIhNVB92qbXKSvxESiUUqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145780; c=relaxed/simple;
	bh=wBmEZDzYRvWOYr5klbQELQXSgjjyjWGnQiwI/wr/IaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaMOWenMyHWGwAKpOtttiUA/TIUbZn3nHQLt8gtmzGkM/vpLSJcZLcYV0GUwVP7eGtdc6P1LW1kJluIELX/yKKUsteWr/L0JSY3paudsI5xHyqJXKDsHyvsP0PJBsksVyaAV9bWhtED31GP5dw0PI5tmV1CjHa60DOdOuhm6P1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w+sjgD9k; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w+sjgD9k"
Message-ID: <45986fae-1abd-4ff9-91f1-35181e3c352d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784145774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHdKvQh/rlWKeApfpf/tzMK4TSbvkElaRfjKMW0v+s4=;
	b=w+sjgD9kRBTS4n/JBtM49px5s+fkS9PIsiCxnbaDy0j/AnFF1vYfPzgn0TizoQ4m9ag1Ec
	YvVmNjyIK8m0uAMcuRtJ36RHRXMHnrw0uOtEE3lpEGjh72LmyZdEGgsM7TAhFsS5jU9a/h
	xBMgCohVBD057+oXaSIrshSKq+YK/E0=
Date: Wed, 15 Jul 2026 13:02:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] tools/build: selftests: Remove some duplicate
 toolchain definitions
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
 <20260715-james-perf-llvm-version-v4-4-6dfdf984b435@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260715-james-perf-llvm-version-v4-4-6dfdf984b435@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/26 7:53 AM, James Clark wrote:
> Try to remove some, but not all duplicate toolchain definitions. In
> these instances, their makefiles already include
> tools/scripts/Makefile.include which defines these in a consistent way.
> 
> STRIP is the only one that was set with an '=', but I don't think it
> was significant so that difference can be dropped.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/bpf/resolve_btfids/Makefile    | 3 ---
>  tools/lib/api/Makefile               | 4 ----
>  tools/lib/subcmd/Makefile            | 4 ----
>  tools/lib/symbol/Makefile            | 4 ----
>  tools/perf/Makefile.perf             | 6 ------
>  tools/testing/selftests/bpf/Makefile | 1 -
>  6 files changed, 22 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 7672208f65e4bc245c03603634d3aa0093a91096..6fdb6302e0a28e9166175822f42cfbb4f4eb24e5 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -20,9 +20,6 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
>  		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
>  
>  RM      ?= rm
> -HOSTCC  ?= gcc
> -HOSTLD  ?= ld
> -HOSTAR  ?= ar

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  HOSTPKG_CONFIG ?= pkg-config
>  CROSS_COMPILE =
>  
> [...]
> 

