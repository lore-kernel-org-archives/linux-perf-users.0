Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411B14BF9B;
	Tue,  6 Aug 2024 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979713; cv=none; b=OUS65Jm+56IXceUt0JxQsIFSP76uZ9KdbL/G66e32HR3wzq08aXpzDy6sO3LChy/ryY0ZQ0SRG6P3OsXgSSO0H/5+ws90A+lA2LPwKsVEbPOF1bIDE2jLqPresTyk+wkmc2EdzPdFiXV0G2AWjdHdgC6wKWe+uXxlZx5pdc7/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979713; c=relaxed/simple;
	bh=2HazIKmqybg1sIeNZ7q9sJGZ/PfT4yHpU5L1tDejN9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F1G/l06ap3lyFUdZSxPE2mgFEwHKph/jY7TJPiEV19FXv8WZ7ILLcQtWfWJjAjYQwEHlhlCrif8JoC0phx7codrJ8VnBFcWzgjGyn0nwiE3iEcS1Fd8OytnTCULCP8pCUXvZzHNos9ctIZS+44M8qFZQd+QKEIWphTNmhYmZujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44380FEC;
	Tue,  6 Aug 2024 14:28:57 -0700 (PDT)
Received: from [10.57.79.15] (unknown [10.57.79.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A08B3F766;
	Tue,  6 Aug 2024 14:28:29 -0700 (PDT)
Message-ID: <2e9a74b5-9403-425d-8d98-9469e290d297@arm.com>
Date: Tue, 6 Aug 2024 22:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf: build: Fix build feature-dwarf_getlocations
 fail for old libdw
To: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
 <20240806114801.1652417-3-yangjihong@bytedance.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240806114801.1652417-3-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2024 12:48 PM, Yang Jihong wrote:
> 
> For libdw versions below 0.177, need to link libdl.a in addition to
> libbebl.a during static compilation, otherwise feature-dwarf_getlocations
> compilation will fail.
> 
> Before:
> 
>   $ make LDFLAGS=-static
>     BUILD:   Doing 'make -j20' parallel build
>   <SNIP>
>   Makefile.config:483: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
>   <SNIP>
> 
>   $ cat ../build/feature/test-dwarf_getlocations.make.output
>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libebl.a(eblclosebackend.o): in function `ebl_closebackend':
>   (.text+0x20): undefined reference to `dlclose'
>   collect2: error: ld returned 1 exit status

Indeed. Thanks for pointing out this.

> After:
> 
>   $ make LDFLAGS=-static
>   <SNIP>
>     Auto-detecting system features:
>   ...                                   dwarf: [ on  ]
>   <SNIP>
> 
>     $ ./perf probe
>    Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
>       or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
>       or: perf probe [<options>] --del '[GROUP:]EVENT' ...
>       or: perf probe --list [GROUP:]EVENT ...
>   <SNIP>
> 
> Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/build/feature/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index b18513ec4da6..1fc651cae9e5 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -179,7 +179,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
>    # Elfutils merged libebl.a into libdw.a starting from version 0.177,
>    # Link libebl.a only if libdw is older than this version.
>    ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
> -    DWARFLIBS += -lebl
> +    DWARFLIBS += -lebl -ldl
>    endif

One critical thing is the ordering of libs. We must put libdl after libebl,
otherwise, the building still fails (based on my test).

Given libdl is a general lib, I think it is good to add a line after the
`endif` wrapper and with a comment, something like:

   ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
      DWARFLIBS += -lebl
   endif

   # Must put -ldl after -lebl for dependency
   DWARFLIBS += -ldl

Please update the file tools/perf/Makefile.config for consistency.

Thanks,
Leo

>  endif
> 
> --
> 2.25.1
> 
> 
