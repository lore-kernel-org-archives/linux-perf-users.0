Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EC4749EA;
	Fri, 24 Jul 2026 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935921; cv=none; b=MH3du710l+5yQHOtymGDSW99lGliZ5Ss97ltiZDyVNVz64aZNcwjEdH+4uxryx3aIsHEtk6i7G+QwMBdg4P781qpqe+mmZs4YMYpqDOaj8wFdtohteI0mVl9GaJ9u1mVqt1EDgpNG5PLnRu2ZvcoK3WGQ0AXvNYHs4sezQTEyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935921; c=relaxed/simple;
	bh=GChuWHtHeEaZjIXTwv7AMY4nFwKkG1u1PFK2c5gtOBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCGmvsnrn3Riq0FIAzA8u+tLEqT+olXiPjgeIY4hI7XCQxKaGJQJ3Nt+jGIR+4XsJVFIL8X1qjTA2CpIYpG3rNHuOnBY8Cnj+uCews0UvEjLJBgSDkCxihH7YtF8SB6FculAZDUXB0azShIIkdN2CNfjjFpn1Y8LPw/9BfrbJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpUx5yxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpUx5yxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30111F00A3A;
	Fri, 24 Jul 2026 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935920;
	bh=g/yMs5mpbraIdgJi4+gGtVX5xQCwfhYjp398n0dthvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SpUx5yxwVOVlZQgCYulYiAXs7IgrFjbDwRPdioIeTQk6Q6ErZH+frNylFd5zEP8kH
	 hXoTlUqjlYWmbmZzdaoVe0UamntjcckDxAPBGsEJrfqGGC8Dgvd8t7BKB+rrHZH+22
	 cH4Hzdx1945z2OLgRkuAuLp3SMxNQ+vbHHi3YiUdBN37wbdqAtyUc4784f0XVEZXhV
	 ACvA0v2f5CxYhmnVo+fLfMHRuTpybgXFQOO26kPxkrNFaLXw38mJEmT8ViYZ4uE7NJ
	 YxeOL+FHoWDwy/RdzEG/0I9H1abqUmBVlKGVSCF0tTakefqC4zSWsY/0lIM9uTBT6Y
	 4fBYVHT4TvpAA==
Date: Fri, 24 Jul 2026 19:31:52 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Message-ID: <amP16I_cn58hhupT@google.com>
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
 <algbxQAAmurxms8X@google.com>
 <DK6Z25AV02BM.3KXO0EMCMP2W9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DK6Z25AV02BM.3KXO0EMCMP2W9@gmail.com>

On Fri, Jul 24, 2026 at 07:19:45PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu Jul 16, 2026 at 1:46 AM CEST, Namhyung Kim wrote:
> > Hello BPF folks,
> >
> > On Wed, Jul 15, 2026 at 03:53:47PM +0100, James Clark wrote:
> >> I ran into the build issue mentioned in the first commit, because using
> >> an option like LLVM=-15 is a documented way to build [1], but only
> >> some of the LLVM tools defined in tools/ support this.
> >>
> >> After fixing that, a lot of other tidyups fell out. I didn't go too far,
> >> for example some selftests include tools/testing/selftests/lib.mk which
> >> reimplements some of the LLVM_SUFFIX stuff, but other selftests include
> >> tools/scripts/Makefile.include and I stopped before touching the former.
> >> Some other non build scripts hard code toolchains and I didn't touch
> >> those either, this change is only focused on things that already
> >> include Makefile.include.
> >>
> >> [1]: Documentation/kbuild/llvm.rst
> >>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >> Changes in v4:
> >> - Drop "tools/build: selftests: Allow versioning LLVM lld", clang
> >>   already picks the correct sibling lld version. (Sashiko)
> >> - Link to v3: https://lore.kernel.org/r/20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org
> >>
> >> Changes in v3:
> >> - Add warning for empty $USE_LD
> >> - Use $HOSTREADELF in bpf Makefile
> >> - Rebase on v7.2-rc3
> >> - Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org
> >>
> >> Changes in v2:
> >> - Fix selftests/bpf build. LLD needs to take the full path to be used
> >>   with -fuse-ld=
> >> - Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org
> >>
> >> ---
> >> James Clark (4):
> >>       tools/build: Allow versioning of all LLVM tools defined in Makefile.include
> >>       tools/build: Indent if else blocks
> >>       tools/build: Allow versioning LLVM readelf
> >>       tools/build: selftests: Remove some duplicate toolchain definitions
> >>
> >>  tools/bpf/resolve_btfids/Makefile    |  3 --
> >>  tools/lib/api/Makefile               |  4 --
> >>  tools/lib/bpf/Makefile               |  8 ++--
> >>  tools/lib/subcmd/Makefile            |  4 --
> >>  tools/lib/symbol/Makefile            |  4 --
> >>  tools/perf/Makefile.perf             |  7 ----
> >>  tools/scripts/Makefile.include       | 77 ++++++++++++++++++++----------------
> >>  tools/testing/selftests/bpf/Makefile |  1 -
> >>  8 files changed, 46 insertions(+), 62 deletions(-)
> >
> > Are you ok with this change and going through perf tree?
> >
> 
> Sorry for the delay, yes, feel free to take it through your tree.

Thanks, can I take it as your Acked-by?

Namhyung

