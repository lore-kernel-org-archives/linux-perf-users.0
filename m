Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9EA4315D;
	Tue,  6 Aug 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978056; cv=none; b=kfHWlshQPXUjs2zWlHNRYQnoCIiWZc8VjIXFUte1/BUhBv+Pd20oW3ych6rZG6arwCb/MotNmHK0ECUYDdwjxTR4HZv3NS4BWmiCZ/uXoWzkAWPePgMLvvsPVAdOROUCAU2Eawx0FgdqxevvabldGm2pD1xR1z/oKtupWhACR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978056; c=relaxed/simple;
	bh=tRdf+LnGUQ0dypRJKqYjJi9TNVNSqELl/O9tqmr4reY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=KPcXDDYkQDQhSH4B3qHmrStDcG3kXhU+pH6EUQnTwuRZCxEQK/MOTjfoFdht2sLvor6A49p2F8bCezOUFixUj0Vmug/Y7/mn9g6C02YOs2sDRnaqYtk8h4ike3Y2ldncYP6kdrlNh28RN1DkpC1jiGT39c1nwm7tibDQ7u94cGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F7FAFEC;
	Tue,  6 Aug 2024 14:01:20 -0700 (PDT)
Received: from [10.57.79.15] (unknown [10.57.79.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428623F766;
	Tue,  6 Aug 2024 14:00:52 -0700 (PDT)
Message-ID: <ecf3460a-7f31-4dce-9a8b-fde8f146bfd8@arm.com>
Date: Tue, 6 Aug 2024 22:00:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 1/3] perf: build: Fix static compilation error when
 libdw is not installed
To: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
 <20240806114801.1652417-2-yangjihong@bytedance.com>
Content-Language: en-US
In-Reply-To: <20240806114801.1652417-2-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2024 12:47 PM, Yang Jihong wrote:
> If libdw is not installed in build environment, the output of
> 'pkg-config --modversion libdw' is empty, causing LIBDW_VERSION_2
> to be empty and the shell test will have the following error:
> 
>   /bin/sh: 1: test: -lt: unexpected operator
> 
> Before:
> 
>   $ pkg-config --modversion libdw
>   Package libdw was not found in the pkg-config search path.
>   Perhaps you should add the directory containing `libdw.pc'
>   to the PKG_CONFIG_PATH environment variable
>   No package 'libdw' found
>   $ make LDFLAGS=-static -j16
>     BUILD:   Doing 'make -j20' parallel build
>   <SNIP>
>   Package libdw was not found in the pkg-config search path.
>   Perhaps you should add the directory containing `libdw.pc'
>   to the PKG_CONFIG_PATH environment variable
>   No package 'libdw' found
>   /bin/sh: 1: test: -lt: unexpected operator
> 
> After:
> 
>   1. libdw is not installed:
> 
>   $ pkg-config --modversion libdw
>   Package libdw was not found in the pkg-config search path.
>   Perhaps you should add the directory containing `libdw.pc'
>   to the PKG_CONFIG_PATH environment variable
>   No package 'libdw' found
>   $ make LDFLAGS=-static -j16
>     BUILD:   Doing 'make -j20' parallel build
>   <SNIP>
>   Package libdw was not found in the pkg-config search path.
>   Perhaps you should add the directory containing `libdw.pc'
>   to the PKG_CONFIG_PATH environment variable
>   No package 'libdw' found
>   Makefile.config:473: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
> 
>   2. libdw version is lower than 0.177
> 
>   $ pkg-config --modversion libdw
>   0.176
>   $ make LDFLAGS=-static -j16
>     BUILD:   Doing 'make -j20' parallel build
>   <SNIP>
> 
>   Auto-detecting system features:
>   ...                                   dwarf: [ on  ]
>   <SNIP>
>     INSTALL libsubcmd_headers
>     INSTALL libapi_headers
>     INSTALL libperf_headers
>     INSTALL libsymbol_headers
>     INSTALL libbpf_headers
>     LINK    perf
> 
>   3. libdw version is higher than 0.177
> 
>   $ pkg-config --modversion libdw
>   0.186
>   $ make LDFLAGS=-static -j16
>     BUILD:   Doing 'make -j20' parallel build
>   <SNIP>
> 
>   Auto-detecting system features:
>   ...                                   dwarf: [ on  ]
>   <SNIP>
>     CC      util/bpf-utils.o
>     CC      util/pfm.o
>     LD      util/perf-util-in.o
>     LD      perf-util-in.o
>     AR      libperf-util.a
>     LINK    perf
> 
> Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/build/feature/Makefile | 2 +-
>  tools/perf/Makefile.config   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 12796808f07a..b18513ec4da6 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -178,7 +178,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
> 
>    # Elfutils merged libebl.a into libdw.a starting from version 0.177,
>    # Link libebl.a only if libdw is older than this version.
> -  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
> +  ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)

I would like to follow up the style of LIBTRACEEVENT_VERSION and
LIBTRACEFS_VERSION, so change LIBDW_VERSION as below:

  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0

Does this work for you?

Thanks,
Leo
