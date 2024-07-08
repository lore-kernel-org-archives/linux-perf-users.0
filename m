Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F6454277;
	Mon,  8 Jul 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441932; cv=none; b=dbUYbax23lMMuhYc09JFoJil4qvJSJDicRwaHhWvG7C263us2HIQaFCoP8RZtzLyvIY1zSTD2ihSWQyV04M6FaXycozgZxblbNUTG1ch3pzyvehvccXblDic4C/h8oLAFZphsax98dq32aPpKM2pBBYhYOT2zVzbw3uD/8qTJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441932; c=relaxed/simple;
	bh=DMnLTqC6BUcFBeBvAD31PCj2jQEyHSG/XGFN5/YEEjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxS0REWP+7MEoQ+32PLQFzGqWfrW5ltTQpwnznW7LgUPH/6YzcdXb8LnhPwZ/M0AMC/vUVzqhSaPLyU+dQsfk+YCa9jDIFkTFBdYmSHqn4IP2jD2nZYXx5wTVGFkzBW1+iJ//1qeNg4WXWGzgy2KzIAGpJTGOF8o9y2Ay+5AZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEF221042;
	Mon,  8 Jul 2024 05:32:35 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB56F3F766;
	Mon,  8 Jul 2024 05:32:09 -0700 (PDT)
Message-ID: <9f65c70f-7b7e-40be-9726-5e4d83d33817@arm.com>
Date: Mon, 8 Jul 2024 13:32:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] perf build: Conditionally add feature check flags
 for libtrace{event,fs}
To: Guilherme Amadio <amadio@gentoo.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Thorsten Leemhuis <linux@leemhuis.info>, linux-perf-users@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20240628202608.3273329-1-amadio@gentoo.org>
 <20240628203432.3273625-1-amadio@gentoo.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240628203432.3273625-1-amadio@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Guilherme,

On 6/28/24 21:34, Guilherme Amadio wrote:
> 
> This avoids reported warnings when the packages are not installed.
> 
> Fixes: 0f0e1f44569061e3dc590cd0b8cb74d8fd53706b
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> ---
>   tools/perf/Makefile.config | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5271a4c1d2b3..5387babb8f04 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -182,13 +182,21 @@ endif
>   FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
>   FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
> 
> -# for linking with debug library, run like:
> -# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> -FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> -FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> -
> -FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> -FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> +ifneq ($(NO_LIBTRACEEVENT),1)
> +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> +  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> +  endif
> +endif
> +ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
> +  # for linking with debug library, run like:
> +  # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
> +  FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
> +  FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
> +endif
> +ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
> +  FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
> +  FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
> +endif

Seems to me, the patch 03 uses a more neat way for appending CFLAGS and
LDFLAGS of libtraceevent and libtracefs, should not use the same code
in patch 01?

Thanks,
Leo

>   FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
>   # include ARCH specific config
> @@ -208,12 +216,6 @@ ifeq ($(call get-executable,$(BISON)),)
>     $(error Error: $(BISON) is missing on this system, please install it)
>   endif
> 
> -ifneq ($(NO_LIBTRACEEVENT),1)
> -  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> -  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
> -  endif
> -endif
> -
>   ifneq ($(OUTPUT),)
>     ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
>       BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
> --
> 2.45.2
> 
