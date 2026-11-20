Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146846;
	b=s0+PHtx1ZckAoMinT0OxNiEwhvy1u3jPWH1dx/AWZ5e/nUgW73fSxc8w+wgu/dBZ1dYu
	 zVn0mg8Tj0IgZ4RlPhAN6PDReFJuoLefufgmbjDIiwa5W6e2zYm5wxl/if7QrWeydytaU
	 AAOui95eCIK4FnlU4RgWsHZu9o5UxU6FxgqkZ4kv+DUl1eH2i1nAdiVH48YrFn2/B9Fqa
	 tNuFyDQLFLM/u7Hfr2L0bf51ZQqVlvR1UcUygKdpe1PIqmGx6b+RCyUiY/tPGA1NgbKoo
	 C42IJWJkQSOWYbL4Im4fhudy+9h41cdYRLWnDHjtoQfxP5aU1e+0iIULtznIh3pb6NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146846;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=lgAB8SjZZEqhOPAKYyNHUQllC83UAzbAxpLqaoWk02k=;
	b=16MvBCAj4eaGm05EsLA4Zq7FPsW9HAH5wDta4EQBpCmGtKcUQcaTmJ2rfOsSyeAlLxYm
	 TO0dKbxmHx6JZInHNSj6P1t4xby7kRTIwhCv3cdsAh1I3FVadPQRQ/zPLTuRMGBhV1Wd2
	 6DQzInluJaLIUWzujORgvFRFQkNskhVaLQZRGeUwY6gCnKKqlSj0NYHhuvs5LaB5wJ+Qj
	 mBZNee7QbGDo435vfjLnn8IquflfForIEoQQWFSY7P7eHLy4e0GhMumLvk5SErEMeK4Ry
	 aBR8tSRhzz8uZ6ZZphZ+/wrMS4m5KuZLCHPlSGpnAyhsScZNNwX37EzavmlZ04R/VXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4AddT4F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9F60A260F;
	Fri, 20 Nov 2026 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4AddT4F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373521F000ED;
	Fri, 20 Nov 2026 03:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146846;
	bh=lgAB8SjZZEqhOPAKYyNHUQllC83UAzbAxpLqaoWk02k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=D4AddT4FNg4pRtDo6mXTaGziUye2s/aOk9J+wzyh+xejBQ/FJsU4EGwwhIqMhCveB
	 zQzonYyFEi7LMELnD7ZcbpcJH/tr4I2DS55l+rO7PxjsWCoo+vN0qK28gGhFEwOd5q
	 QPSq/LliwXWhliaSUA+d2uAutIQnRWWx1btywhr/LYa8//+PErEROofRMUNLxc9lfp
	 dryqRoh0GnC0tKhf32f47I4DbA3r9zuB1/3lxVISjdrgS1u5cXQRprgjsnHUXI6GQB
	 BbIdlAC/YdBhksdb4ScXxmY62MjTiAiKuuU964DTUScXl4DVsWqepAvZwUGVqhxHoc
	 RbapD+zZ0hoRg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, andrii@kernel.org, 
 cupertino.miranda@oracle.com, eddyz87@gmail.com, james.clark@linaro.org, 
 jolsa@kernel.org, jose.marchesi@oracle.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
 yonghong.song@linux.dev
In-Reply-To: <20261112011514.4032822-1-irogers@google.com>
References: <20261112011514.4032822-1-irogers@google.com>
Subject: Re: [PATCH v4 0/5] perf build: Support building BPF skeletons with
 bpf-gcc
Message-Id: <179514684525.638421.6265284837594211702.b4-ty@b4>
Date: Thu, 19 Nov 2026 19:54:05 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 11 Nov 2026 17:15:09 -0800, Ian Rogers wrote:
> Currently the perf build requires clang (>= 12.0.1) to compile BPF
> skeleton programs (.bpf.c -> .bpf.o). bpf-gcc (>= 14.0.0) also supports
> BPF CO-RE and BTF generation and is already supported in
> tools/testing/selftests/bpf/Makefile.
> 
> This series updates the perf build to support both clang and bpf-gcc,
> broken into small bisectable commits:
> - Patch 1 fixes version-ge3 and version-lt3 in tools/scripts/utilities.mak
>   so empty or fewer-than-3-component version strings do not shift awk
>   fields across arguments.
> - Patch 2 syncs bpf_skel.mak's get_sys_includes with
>   tools/testing/selftests/bpf/Makefile for LoongArch and MIPS.
> - Patch 3 updates Makefile.config, Makefile.perf, and bpf_skel.mak to
>   prefer bpf-gcc when building perf with GCC (CC_NO_CLANG=1) and clang
>   when building with Clang/LLVM (CC_NO_CLANG=0), while respecting
>   explicit BPF_GCC=... or CLANG=... command-line overrides and falling
>   back to whichever compiler is available.
> - Patch 4 introduces tools/build/Makefile.feature in
>   tools/perf/tests/make and switches the existing libbfd and llvm probes
>   to reuse libbfd-threadsafe and llvm-perf.
> - Patch 5 adds make_bpf_skel_clang and make_bpf_skel_bpf_gcc build-test
>   targets to tools/perf/tests/make and verifies with
>   'perf check -q feature bpf_skeletons' that BPF skeleton support is
>   enabled (or disabled with exit code 1 for make_no_bpf_skel) as
>   expected.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


