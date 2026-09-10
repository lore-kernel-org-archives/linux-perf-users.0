Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560423D647F;
	Thu, 10 Sep 2026 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032055; cv=none; b=a1XSeaq1hm/kGVAXpljuAiABQk+l32RWM4ImKjHr0i3zVqh5aXFBUEYS5j4WZBgXUZmszZG2PD0EibThPPaB1rL8BMLbf6IjI1pTxVXRHOmHSrKOxU3qdlQjuwaZEM5dlkfNHFzmzKTtdAE6Dqg5wNXqDul61Dyh7T/b+9LD74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032055; c=relaxed/simple;
	bh=sxGSHFaMLv5929K2Bj8xxgL+zdaOHrO/8pFXWlpJNjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChVxG4oiWxSLM1uvSpdQAn0z3ZFV0WC1s4KuE1UoL59/WMWrcNghEFys9Uy5/pEUNy2Mt7dQDTAq72091a8BDJgpdnDja3/M1qb2bPOgtW1iiQkQgrT7NKoYuq4C6c9tN1Ext6k7Gcix9C+JqTx9l2kA5JAn7OZjwoEHdGUANdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQrpunMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQrpunMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C0C1F00893;
	Thu, 10 Sep 2026 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032051;
	bh=cIGoZZbLsvzwNoMcLdGV92/uLFTkdg0Og9xuN7gX7Y4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KQrpunMhg71zv91/iq8EhwRVmd4Wn/mXcWTkKWMXVJ3a8uBWkN+6y7UTW3ueWL0go
	 W9KFt2yTgfok9A1utYOK2fcgq+d99Qx9OCbUCDw/+Qna/zSC3R15DYJBnuku+O0kcG
	 HYmg3DM2T2T86H77KAIrKOc4wKyGkEebuJpzY4bWRPB3ejNPcD/9K+U6F+99Gv4i4V
	 0Eu1aZwz4LUuJ7EqS+2zzeJ+OdMpBbpGT2GniGs7VkHM6VboDdRrXVT0FBMO9aOylg
	 Wd5J+QGk2jdBVa4E/KCCk+ijg+3XHmAHxCkrsqGN7mFvcowjE6bJpvLEEUc8mngRl4
	 EXMzBZjCkQZqw==
Message-ID: <36a64b34-bb69-4352-9e84-c31d0793b6a4@kernel.org>
Date: Thu, 10 Sep 2026 10:20:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] bpftool: Add explicitly sequenced -lzstd to libbfd
 feature fallback
To: Ian Rogers <irogers@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org
References: <20260909204122.1993010-1-irogers@google.com>
 <20260909204122.1993010-4-irogers@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260909204122.1993010-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2026 21:41, Ian Rogers wrote:
> Distributions like Fedora currently ship a statically compiled binutils
> libbfd that natively depends on zstd to decompress sections (e.g.
> undefined reference to 'ZSTD_decompress').
> 
> Extend the newly supplemented libbfd-liberty-z-zstd feature probe into
> bpftool's Makefile so it can natively build against static binutils
> distributions.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.1-pro
> ---
>  tools/bpf/bpftool/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index b0f7168e7943..1cac4508eb0c 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -125,6 +125,7 @@ FEATURE_TESTS += libcap
>  FEATURE_TESTS += libbfd
>  FEATURE_TESTS += libbfd-liberty
>  FEATURE_TESTS += libbfd-liberty-z
> +FEATURE_TESTS += libbfd-liberty-z-zstd
>  FEATURE_TESTS += disassembler-four-args
>  FEATURE_TESTS += disassembler-init-styled
>  FEATURE_TESTS += libelf-zstd
> @@ -135,6 +136,7 @@ FEATURE_DISPLAY += libcap
>  FEATURE_DISPLAY += libbfd
>  FEATURE_DISPLAY += libbfd-liberty
>  FEATURE_DISPLAY += libbfd-liberty-z
> +FEATURE_DISPLAY += libbfd-liberty-z-zstd
>  endif
>  
>  check_feat := 1
> @@ -201,6 +203,8 @@ else
>      LIBS += -lbfd -ldl -lopcodes -liberty
>    else ifeq ($(feature-libbfd-liberty-z),1)
>      LIBS += -lbfd -ldl -lopcodes -liberty -lz
> +  else ifeq ($(feature-libbfd-liberty-z-zstd),1)
> +    LIBS += -lbfd -ldl -lopcodes -liberty -lz -lzstd
>    endif
>  
>    # If one of the above feature combinations is set, we support libbfd


Hi Ian, thanks for this!

Just checking: my understanding is that if libbfd depends on libzstd,
then it always also depends on zlib, so we never need to check some
variant such as "feature-libbfd-liberty-zstd" (without the "-z"), is
this correct?

Quentin
