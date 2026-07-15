Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739173CF204;
	Wed, 15 Jul 2026 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159177; cv=none; b=vBIlxWskg1S9U/rStYYfia6I0tBKT69Tj9gp3VsJjH5niYHD58118MKa3xghrgD/xNI1KamLifXBxvv67Ngq2UHaJVKd+6b+Bjr6zC3ei/hXeRr1QekGJfnaZ2hol0wmft92KAqcml8DNxoPrAepWD22uDPw+jLc10KCmJCjwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159177; c=relaxed/simple;
	bh=dMoHufLvD7MkkNMJXcpSScmSapAuttAYNZQQtpNnMMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAn1VBGgpTmEC08NOiOIyGb3KSbTV6T4wvS3UjZqU4S2e7wcXr1DB3Y2Y+L5WUVNhoqVfdmzn5BSufW4MNdO8jei5hnm+Yc3eWY5IlJcCBOp1WuGUtk8V13Tv5lLeZ4XA9ISXldorFDVvZ3LDX/uH0Mg/00W02pAh+/QxpLLhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqFN18X4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqFN18X4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E8F1F000E9;
	Wed, 15 Jul 2026 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159176;
	bh=9M8j7I7VdmUl3g1TXrlGhuKxddx/mKZm9ejkTrkF5to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hqFN18X4ZmdicG79qc7kKagp6mZYoLt9/bXSXKUt86xuENBjF1IE4rrrZqZYb+Beg
	 izV9nOPHPoUoovny0IkOGpEnrFlvhMcrJotPZfxh7tysJX1gEgsGopimk3o15mNXae
	 Y0qxLPw4ndrWM+i3UGahJ80d+cL4K4ST4S9e3bh2yiNOT9g3Afmf3tPPZoGsGoU6Mq
	 IpVmnlmhZRVpJIFrCslfNoku8YEqM2YOCPLEvy+otidtPPdxAm9GKCdte6bzdMS0qj
	 tdOyZJ7cgmYJCH9sjr1Nq0bNtX46ovrG7y4+pl1vpigKGizAEWbuBNpdoOrikbWgo9
	 Be3aLVhUGZbSA==
Date: Wed, 15 Jul 2026 16:46:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/4] tools/build: Allow versioning of all LLVM tools
Message-ID: <algbxQAAmurxms8X@google.com>
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>

Hello BPF folks,

On Wed, Jul 15, 2026 at 03:53:47PM +0100, James Clark wrote:
> I ran into the build issue mentioned in the first commit, because using
> an option like LLVM=-15 is a documented way to build [1], but only
> some of the LLVM tools defined in tools/ support this.
> 
> After fixing that, a lot of other tidyups fell out. I didn't go too far,
> for example some selftests include tools/testing/selftests/lib.mk which
> reimplements some of the LLVM_SUFFIX stuff, but other selftests include
> tools/scripts/Makefile.include and I stopped before touching the former.
> Some other non build scripts hard code toolchains and I didn't touch
> those either, this change is only focused on things that already
> include Makefile.include.
> 
> [1]: Documentation/kbuild/llvm.rst
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v4:
> - Drop "tools/build: selftests: Allow versioning LLVM lld", clang
>   already picks the correct sibling lld version. (Sashiko)
> - Link to v3: https://lore.kernel.org/r/20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org
> 
> Changes in v3:
> - Add warning for empty $USE_LD
> - Use $HOSTREADELF in bpf Makefile
> - Rebase on v7.2-rc3
> - Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org
> 
> Changes in v2:
> - Fix selftests/bpf build. LLD needs to take the full path to be used
>   with -fuse-ld=
> - Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org
> 
> ---
> James Clark (4):
>       tools/build: Allow versioning of all LLVM tools defined in Makefile.include
>       tools/build: Indent if else blocks
>       tools/build: Allow versioning LLVM readelf
>       tools/build: selftests: Remove some duplicate toolchain definitions
> 
>  tools/bpf/resolve_btfids/Makefile    |  3 --
>  tools/lib/api/Makefile               |  4 --
>  tools/lib/bpf/Makefile               |  8 ++--
>  tools/lib/subcmd/Makefile            |  4 --
>  tools/lib/symbol/Makefile            |  4 --
>  tools/perf/Makefile.perf             |  7 ----
>  tools/scripts/Makefile.include       | 77 ++++++++++++++++++++----------------
>  tools/testing/selftests/bpf/Makefile |  1 -
>  8 files changed, 46 insertions(+), 62 deletions(-)

Are you ok with this change and going through perf tree?

Thanks,
Namhyung

> ---
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
