Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3BD1487E9;
	Tue, 25 Nov 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088766; cv=none; b=PNa0x6oxl8r4QgXFSYNh215LbMaZzJmQHvCRHLtFC10zqFLkBFS9fYCdwq6Su3RDFK8SUxPk1P7C2NUYsWA5ealZO8+DFV/tabOSXe8Crk4tPCqS9HWjDRuHhCzh4/4fpIb8QJDRhSPI1aEiXCII4OLmP/kmGpPzdsUu4vnqdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088766; c=relaxed/simple;
	bh=oTCNH0b1Y7GDCSwRRWldwuA6nWMqLUNaLlTqmBFV9yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1fvz6NzWkXAAymA+i4aCV7rgcvbzxHkJi8L9KV/Py5Guu+W9czRb3Tv9J+a2/Mh8N5Ra+GiL+LFV9ygGpzc70qqpKJYbfk2Tm7LFFynSK/LwQdtLrgnlw6KH1hIUFJkgO54NxrK37KVGfdwZAfU4R6pbX2yHskEflFB4PcFhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68DA168F;
	Tue, 25 Nov 2025 08:39:15 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9DD83F6A8;
	Tue, 25 Nov 2025 08:39:22 -0800 (PST)
Date: Tue, 25 Nov 2025 16:39:20 +0000
From: Leo Yan <leo.yan@arm.com>
To: hupu <hupu.gm@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: Re: [RFC] perf build: Use self-contained headers from kernel source
 when compiling
Message-ID: <20251125163920.GG724103@e132581.arm.com>
References: <20251124072310.3592-1-hupu.gm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124072310.3592-1-hupu.gm@gmail.com>

On Mon, Nov 24, 2025 at 03:23:10PM +0800, hupu wrote:
> When building perf, switch to using the self-contained headers provided
> in the kernel source tree to avoid build failures caused by missing
> architecture-specific headers. For example, the build may fail with
> errors like:
> 
> /usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not
> found
>     5 | #include <asm/ioctl.h>
>       |          ^~~~~~~~~~~~~
> 
> This issue may occur because system-installed headers are incomplete,
> incompatible with the kernel version being built, or the corresponding
> architecture-specific headers are not installed at all. Using the
> self-contained headers from the kernel source ensures a consistent and
> compatible build environment.
> 
> Signed-off-by: hupu <hupu.gm@gmail.com>
> ---
>  tools/perf/Makefile.perf | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 47c906b807ef..eaccaae87e3c 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1202,7 +1202,9 @@ endif
>  
>  CLANG_OPTIONS = -Wall
>  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
> -BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
> +KHDR_INCLUDES := $(abspath $(OUTPUT)/../../usr/include)

This doesn't work if use the commands:

  make -j `nproc` Image O=$OUT
  make headers_install O=$OUT
  make O=$OUT -C tools/perf VF=1 CORESIGHT=1 DEBUG=1

Maybe it is good to search possible paths:

  $(abspath ../../usr/include)    => Build in local folder
  $(abspath $(OUTPUT)usr/include) => Build in a specified folder

> +BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) \
> +		-I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)

Why the issue only happens for eBPF skel build but not for perf binary
build?  As I said in another reply, I'd consolidate options for both
cases.

Thanks,
Leo
