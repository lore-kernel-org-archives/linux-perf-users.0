Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124914F104;
	Fri, 12 Jul 2024 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779212; cv=none; b=AMnNeExSX+H0HXmNKWRhWF/8oi/dfU3IrUAGMsIlKfBdb7zSascjMf/xqCkCltPxlaxogo0ZYsqQ/YaYHxBzRBcYRfmRaWgcCGOWWw3/kOSrYUKLirFpzJGtsm32AM5oTUttFqk5d4UaQUnV7lUGM3GgDGDqxiMooqnkD5Ll/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779212; c=relaxed/simple;
	bh=W3BAxbhKUHjibbC4ZT6cFEubg4VU1RRIPtN57FYxdng=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z/QOWbXxYvlOhrjqvA9GKtU8eWTzU1Qe3t88oT2TQuwtsLX8pkGHsa+Fqa3uQuh2r1xDzkS7wIc1+P9X5ANG2Vuky4eo+TyBLVx+rSLGaZeaUK4jcY5rRo+IreO57RQzdMZAvIRiKodlXsO46v5GHKkDTLKtiFT4Z0fbVFt+oXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 161601007;
	Fri, 12 Jul 2024 03:13:49 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 545C33F766;
	Fri, 12 Jul 2024 03:13:21 -0700 (PDT)
Message-ID: <f7fc7ffe-1672-437d-8a45-13590f5a1c2d@arm.com>
Date: Fri, 12 Jul 2024 11:13:19 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v3 1/7] perf: build: Setup PKG_CONFIG_LIBDIR for cross
 compilation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Changbin Du
 <changbin.du@huawei.com>, James Clark <james.clark@linaro.org>,
 amadio@gentoo.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240706182912.222780-1-leo.yan@arm.com>
 <20240706182912.222780-2-leo.yan@arm.com> <ZpC2n-iDsbc6gNEW@google.com>
Content-Language: en-US
In-Reply-To: <ZpC2n-iDsbc6gNEW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Namhyung,

On 7/12/24 05:52, Namhyung Kim wrote:

[...]

>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index ed54cef450f5..65fd2b2cfacb 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -82,7 +82,31 @@ FILES=                                          \
>>
>>   FILES := $(addprefix $(OUTPUT),$(FILES))
>>
>> -PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>> +# Some distros provide the command $(CROSS_COMPILE)pkg-config for
>> +# searching packges installed with Multiarch. Use it for cross
>> +# compilation if it is existed.
>> +ifneq (, $(shell which $(CROSS_COMPILE)pkg-config))
>> +  PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>> +else
>> +  PKG_CONFIG ?= pkg-config
>> +
>> +  # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR is required for the cross
> 
> And PKG_CONFIG_SYSROOT_DIR too.

I will refine the comment as:

   # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR, alongside PKG_CONFIG_SYSROOT_DIR
   # for modified system root, is required for the cross compilation.
   # If these PKG_CONFIG environment variables are not set, Multiarch library
   # paths are used instead.

>> +  # compilation. If both is not set, try to set the lib paths installed
>> +  # by multiarch.
>> +  ifdef CROSS_COMPILE
>> +    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
>> +      CROSS_ARCH = $(shell $(CC) -dumpmachine)
>> +      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
>> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
>> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
>> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
>> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
>> +      export PKG_CONFIG_LIBDIR
>> +      $(warning Missing PKG_CONFIG_LIBDIR and PKG_CONFIG_PATH for cross compilation,)
> 
> Probably you need to add it here too.

Will do.

>> +      $(warning set PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) for building with Multiarch libs.)
> 
> I guess the message would get too long.  Maybe it's ok to hide the
> actual value..

Will do.

> In addition, I think this message will be displayed multiple times -
> once here and later in Makefile.perf.  Maybe we can show it once in
> the latter only?

Will polish for this.

Thanks,
Leo
