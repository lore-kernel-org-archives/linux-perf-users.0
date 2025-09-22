Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155B2E1C69
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554716; cv=none; b=beZzPsBfPDwx26Y8aFjANub5Zix6WVgVDsS0tXWIPFat+kZEX3NAUq8eDPmHAD7nWXJHHLhEE5C0DJqqD7DUeqY6wZmxnWv/+ZamGgbl4vA51eJO4xoDq3rPOhE7EpE+tY2PMHUGRXr0AXRf42/mdbi1HNOdwmvwX/Yry6/LEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554716; c=relaxed/simple;
	bh=Flvci69kLy4oqGvHOPqNh+K684ly9/dXY4U3t7DwwMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB3E5SmX206e57m2vh9V/0iiWUNLmrPdWgubFrUUmaBGU+U+MtSGtQ8YRoKk2PbhVbn888lI8+gZpp9AvjB2LffbkdoIH/IVi5H4anb+LRzcURcNACySYQaX6KF1ptOOietjyF0JYY4dZSpwAsfQKWoqguBLVJAm3MwfvFgcvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muUTNVb3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muUTNVb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758554715; x=1790090715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Flvci69kLy4oqGvHOPqNh+K684ly9/dXY4U3t7DwwMU=;
  b=muUTNVb30g6aW4BpVAVs8HK+09JVlruGwIGGn3hJg0ofwAx19gOZBNnh
   a9ZI9ShBQzGWgbRNrqPR4c8/mh/4aLM7+TJX2wefIMfDQCg0Owu69OpH9
   YCvtLejZ5Y4A52s1e/kdIsjXYX9LCGa87Zz0PB2a+ZjzSH2hMyhd7a1jS
   mkndqvbyKxL/T4D4UY64KnGue8T+aJMLHEKDzPh0WUPhFwsPEuu1TaYlz
   g+d1HzYJPXDbNuHedE9o+xp8nhZMzJV4YAPb8tw3VT76xV7Zj01rvgs4h
   erh2K1iEa6HVwcaBaTpbgX5ivFXC5Cx7RQ2WC5QpLxqqfwP1okxW+i6rB
   w==;
X-CSE-ConnectionGUID: HJ+naVwXQECX+9yh2zuCXA==
X-CSE-MsgGUID: 8bCDjTPfQca4YnLYmBP64A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63449105"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="63449105"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:25:14 -0700
X-CSE-ConnectionGUID: jyBQzMPORuS+GaJcFoNtFQ==
X-CSE-MsgGUID: UqzxoVg3QaWAGMTWMGPggg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207241918"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:25:14 -0700
Date: Mon, 22 Sep 2025 08:25:08 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] tools perf build: Support BUILD_NONDISTRO on OpenSUSE
 Tumbleweed
Message-ID: <aNFqVAO6Wy2IDEAt@tassilo>
References: <20250905183832.3011694-1-andi@firstfloor.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905183832.3011694-1-andi@firstfloor.org>

On Fri, Sep 05, 2025 at 11:38:32AM -0700, Andi Kleen wrote:
> My Tumbleweed system needs -lzstd -lsframe to build -lbfd
> for BUILD_NONDISTRO to get a sane BFD based setup.
> Add probing for that case.
> 
> The previously posted build fixes are also needed.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Patch still needs to be merged.

Thanks,

-Andi

> ---
>  tools/build/Makefile.feature |  4 +++-
>  tools/build/feature/Makefile | 24 ++++++++++++++++++------
>  tools/perf/Makefile.config   | 22 +++++++++++++++-------
>  3 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 649c5ab8e8f2..46bdb9f8ba7f 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -120,6 +120,7 @@ FEATURE_TESTS_EXTRA :=                  \
>           libcapstone                    \
>           libbfd-liberty                 \
>           libbfd-liberty-z               \
> +         libbfd-liberty-z-zstd-sframe   \
>           libopencsd                     \
>           cxx                            \
>           llvm                           \
> @@ -159,7 +160,8 @@ FEATURE_DISPLAY ?=              \
>  # Declare group members of a feature to display the logical OR of the detection
>  # result instead of each member result.
>  #
> -FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
> +FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z \
> +			       libbfd-liberty-z-zstd-sframe
>  
>  #
>  # Declare list of feature dependency packages that provide pkg-config files.
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index b41a42818d8a..7fd30cbeefb0 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -20,6 +20,7 @@ FILES=                                          \
>           test-reallocarray.bin			\
>           test-libbfd-liberty.bin                \
>           test-libbfd-liberty-z.bin              \
> +         test-libbfd-liberty-z-zstd-sframe.bin  \
>           test-cplus-demangle.bin                \
>           test-cxa-demangle.bin                  \
>           test-libcap.bin			\
> @@ -118,7 +119,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
>  ###############################
>  
>  $(OUTPUT)test-all.bin:
> -	$(BUILD_ALL) || $(BUILD_ALL) -lopcodes -liberty
> +	$(BUILD_ALL) || $(BUILD_ALL) -lopcodes -liberty || $(BUILD_ALL) -lopcodes -liberty -lz -lzstd -lsframe
>  
>  $(OUTPUT)test-hello.bin:
>  	$(BUILD)
> @@ -278,15 +279,22 @@ $(OUTPUT)test-libbfd.bin:
>  	$(BUILD_BFD)
>  
>  $(OUTPUT)test-libbfd-buildid.bin:
> -	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
> +	$(BUILD_BFD) || \
> +	$(BUILD_BFD) -liberty || \
> +	$(BUILD_BFD) -liberty -lz || \
> +	$(BUILD_BFD) -liberty -lz -lzstd -sframe
>  
>  $(OUTPUT)test-disassembler-four-args.bin:
> -	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
> -	$(BUILD_BFD) -lopcodes -liberty -lz
> +	$(BUILD_BFD) -lopcodes || \
> +	$(BUILD_BFD) -lopcodes -liberty || \
> +	$(BUILD_BFD) -lopcodes -liberty -lz || \
> +	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd -lsframe
>  
>  $(OUTPUT)test-disassembler-init-styled.bin:
> -	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
> -	$(BUILD_BFD) -lopcodes -liberty -lz
> +	$(BUILD_BFD) -lopcodes || \
> +	$(BUILD_BFD) -lopcodes -liberty || \
> +	$(BUILD_BFD) -lopcodes -liberty -lz || \
> +	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd -lsframe
>  
>  $(OUTPUT)test-reallocarray.bin:
>  	$(BUILD)
> @@ -297,6 +305,10 @@ $(OUTPUT)test-libbfd-liberty.bin:
>  $(OUTPUT)test-libbfd-liberty-z.bin:
>  	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
>  
> +$(OUTPUT)test-libbfd-liberty-z-zstd-sframe.bin:
> +	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz \
> +		-lzstd -lsframe
> +
>  $(OUTPUT)test-cplus-demangle.bin:
>  	$(BUILD) -liberty
>  
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5a5832ee7b53..53864a505cfa 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -923,23 +923,31 @@ ifdef BUILD_NONDISTRO
>      EXTLIBS += -lbfd -lopcodes
>    else
>      # we are on a system that requires -liberty and (maybe) -lz
> +    # and possibly sframe and zstd
>      # to link against -lbfd; test each case individually here
>  
>      # call all detections now so we get correct
>      # status in VF output
>      $(call feature_check,libbfd-liberty)
>      $(call feature_check,libbfd-liberty-z)
> +    $(call feature_check,libbfd-liberty-z-zstd-sframe)
>  
> -    ifeq ($(feature-libbfd-liberty), 1)
> +    ifeq ($(feature-libbfd-liberty),$(feature-libbfd-liberty-z),1)
>        EXTLIBS += -lbfd -lopcodes -liberty
>        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
>        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
> -    else
> -      ifeq ($(feature-libbfd-liberty-z), 1)
> -        EXTLIBS += -lbfd -lopcodes -liberty -lz
> -        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
> -        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
> -      endif
> +    endif
> +    ifeq ($(feature-libbfd-liberty-z),1)
> +      EXTLIBS += -lbfd -lopcodes -liberty -lz
> +      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
> +      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
> +    endif
> +    ifeq ($(feature-libbfd-liberty-z-zstd-sframe),1)
> +      EXTLIBS += -lbfd -lopcodes -liberty -lz -lzstd -lsframe
> +      FEATURE_CHECK_LDFLAGS-disassembler-four-args += \
> +	      -liberty -lz -lzstd -lsframe -ldl
> +      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += \
> +	      -liberty -lz -lzstd -lsframe -ldl
>      endif
>      $(call feature_check,disassembler-four-args)
>      $(call feature_check,disassembler-init-styled)
> -- 
> 2.51.0
> 
