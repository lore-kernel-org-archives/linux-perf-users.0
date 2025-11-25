Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E5A24166C;
	Tue, 25 Nov 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087591; cv=none; b=T31jDQJef7zkST/wwBt273b292htzhPXJ7paPlRunK0po4cJum4Tdv03IcS7AhY0h4jVlSirQXW7D71gDyrzVIBHTv6DetgImSCmdev1feXUf8P17GRTfLWlKPzWgvsa2bt0+K9SaJAU8x2VtMqoTOKzxcSvIiegC0m/vKgUroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087591; c=relaxed/simple;
	bh=Ds8t21iK2O/SQssVxZ8aY6THSUMmPHBD9Tc42wlKTMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWbk24kdQD6QrLIcrzkO6aSYrVwVmsaL0Bc+bDkc+icSK0CDC4uh7oBJYYCqb88eMUIoCjyI6PFlmZt9TAMAMohf2b0UwLtt2Lot81XgNO5pJmvSvKTfARr9OymONhplDT8SHyuo71aNe4SIMro5WeWcWpeQMiGxFjSNRQf4RyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B049F168F;
	Tue, 25 Nov 2025 08:10:21 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56433F6A8;
	Tue, 25 Nov 2025 08:10:28 -0800 (PST)
Date: Tue, 25 Nov 2025 16:10:26 +0000
From: Leo Yan <leo.yan@arm.com>
To: hupu <hupu.gm@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, jolsa@kernel.org, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: Re: [PATCH] perf build: Support passing extra Clang options via
 EXTRA_BPF_FLAGS
Message-ID: <20251125161026.GF724103@e132581.arm.com>
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com>
 <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>

On Tue, Nov 25, 2025 at 09:07:26PM +0800, hupu wrote:

[...]

> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -35,6 +35,9 @@ include ../scripts/utilities.mak
>  #
>  # Define EXTRA_CFLAGS=-m64 or EXTRA_CFLAGS=-m32 as appropriate for
> cross-builds.
>  #
> +# Define EXTRA_BPF_FLAGS="--sysroot=<path>" or other custom include paths for
> +# cross-compiling BPF skeletons
> +#
>  # Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
>  # EXTLIBS.
>  #
> @@ -1252,7 +1255,7 @@ endif
>  $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE
> util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
>  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
>   $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
> -   $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> +   $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \

I am concerned for this change.

How can you only build eBPF skel program with "--sysroot" but not
applying the same build env on perf binary and associated libs (libperf,
bpftool, etc) ?

For a convinced solution, I'd expect we can apply PKG_CONFIG_SYSROOT_DIR
for both normal perf build and eBPF skel build.  More important, please
provide steps for how to build perf with a SDK.

Thanks,
Leo
