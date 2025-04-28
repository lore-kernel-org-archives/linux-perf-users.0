Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF9265CA3;
	Mon, 28 Apr 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846633; cv=none; b=sZ4s1D5hbXaOyrsuOrPMQjiNMCwCV0m8V5pM9mp7BU3FE4EIgaXestmbpQ4kUwaYNjzabiZbpgQqy5xMIPBO1D2CnhaTph2LIXJHYryhXH1y/Mov85rGzmVXBXQVWVcvOvtjCm2SgaMEpLgEygHehKYfQB3RBIvnYiA3eVqSV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846633; c=relaxed/simple;
	bh=PZ58W/fh/oIsI/HU9YwpIcoWTv1ZA3v47t5escImeVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uopuIZzY1dDNe/wLCFcxCGoDI+N+FAtEF7/r64TnadfuB/kN8be4pEtlLU3cAu5OLLE/pu+gMcU+AxGWTsJSM98cHoyC8covxOHZnQUbfmv+pZN7HI+oJ0KtNa0uxo/7gxLqcaRML+KEjKGYC08C8DbjQqzgR0KmLyBNRxBvIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QNh+vskZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="QNh+vskZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=iGXj63J8VBhZa0Z6vwO5joFqgsLfCrZn2O4wsUpwsxc=; t=1745846631;
	x=1746278631; b=QNh+vskZIOm55U5hiFE7zkKhbbFSlRHD7CWjHdQMXyG5OdQC0PiQ07zWZGNUE
	/BCdLYtH2zkzRxnKYebTyCsf2wp+8cXIEWrinWmX9JaXJ37ZCZUrliWlk07eP3srfY6lfnaQRqozw
	mBbNU9+goohJ4ep75Q19ep7jM+E/StpxHgbCHlrBe/lQ5igSbuBDkC4qnAfRWD1HZ6xH2wDHpxVWD
	SVo76ks157a9RITTB+V2ihEKlQd06YKUNTJvKevKzldxbu+82U4zn+fw22mIE4mvjwO+NdJ9JU09j
	H/VMumqb7QYb0tQqxylxj4fkt8pHXBapwNllDY6srizARgJD/A==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1u9OSJ-0092j3-2B;
	Mon, 28 Apr 2025 15:23:31 +0200
Message-ID: <7703f88e-ccb7-4c98-9da4-8aad224e780f@leemhuis.info>
Date: Mon, 28 Apr 2025 15:23:30 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix arm64 build by generating unistd_64.h
To: James Clark <james.clark@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, arnd@linaro.org
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1745846631;3d1aed48;
X-HE-SMSGID: 1u9OSJ-0092j3-2B

On 17.04.25 15:55, James Clark wrote:
> Since pulling in the kernel changes in commit 22f72088ffe6 ("tools
> headers: Update the syscall table with the kernel sources"), arm64 is
> no longer using a generic syscall header and generates one from the
> syscall table. Therefore we must also generate the syscall header for
> arm64 before building Perf.
> 
> Add it as a dependency to libperf which uses one syscall number. Perf
> uses more, but as libperf is a dependency of Perf it will be generated
> for both.
> 
> Future platforms that need this will have to add their own syscall-y
> targets in libperf manually. Unfortunately the arch specific files that
> do this (e.g. arch/arm64/include/asm/Kbuild) can't easily be imported
> into the Perf build. But Perf only needs a subset of the generated files
> anyway, so redefining them is probably the correct thing to do.

FYI, my daily -next build for Fedora based on its RPM spec file broke
on arm64 (x86_64 worked fine) while building libperf. I haven't checked
yet, but due to the error messages and a quick look in the history I
wonder if this is due to the quoted change, which showed up in -next
today:

"""
kernel.spec:3115: build libperf
+ /usr/bin/make -s 'EXTRA_CFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -mbranch-protection=standard -fasynchronous-unwind-tables -fstack-clash-protection  ' 'LDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes ' -C tools/lib/perf V=1 DESTDIR=/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT
mkdir: cannot create directory â€˜/../archâ€™: Permission denied
/builddir/build/BUILD/kernel-6.15.0-build/kernel-next-20250428/linux-6.15.0-0.0.next.20250428.435.vanilla.fc43.aarch64/scripts/syscallhdr.sh: line 98: /../arch/arm64/include/generated/uapi/asm/unistd_64.h: No such file or directory
make[2]: *** [/builddir/build/BUILD/kernel-6.15.0-build/kernel-next-20250428/linux-6.15.0-0.0.next.20250428.435.vanilla.fc43.aarch64/scripts/Makefile.asm-headers:81: /../arch/arm64/include/generated/uapi/asm/unistd_64.h] Error 1
make[1]: *** [Makefile:108: uapi-asm-generic] Error 2
make: *** [Makefile:128: all] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.vAfil2 (%build)
"""

Full log: https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/08975350-next-next-all/builder-live.log.gz

Ciao, Thorsten
 
> Fixes: 22f72088ffe6 ("tools headers: Update the syscall table with the kernel sources")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/lib/perf/Makefile    | 12 +++++++++++-
>  tools/perf/Makefile.config |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index ffcfd777c451..1a19b5013f45 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -42,6 +42,7 @@ libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
>  TEST_ARGS := $(if $(V),-v)
>  
>  INCLUDES = \
> +-I$(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi \
>  -I$(srctree)/tools/lib/perf/include \
>  -I$(srctree)/tools/lib/ \
>  -I$(srctree)/tools/include \
> @@ -99,7 +100,16 @@ $(LIBAPI)-clean:
>  	$(call QUIET_CLEAN, libapi)
>  	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
>  
> -$(LIBPERF_IN): FORCE
> +uapi-asm := $(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi/asm
> +ifeq ($(SRCARCH),arm64)
> +	syscall-y := $(uapi-asm)/unistd_64.h
> +endif
> +uapi-asm-generic:
> +	$(if $(syscall-y),\
> +		$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-headers obj=$(uapi-asm) \
> +		generic=include/uapi/asm-generic $(syscall-y),)
> +
> +$(LIBPERF_IN): uapi-asm-generic FORCE
>  	$(Q)$(MAKE) $(build)=libperf
>  
>  $(LIBPERF_A): $(LIBPERF_IN)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index eea95c6c0c71..a52482654d4b 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -29,6 +29,7 @@ include $(srctree)/tools/scripts/Makefile.arch
>  $(call detected_var,SRCARCH)
>  
>  CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
> +CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi
>  
>  # Additional ARCH settings for ppc
>  ifeq ($(SRCARCH),powerpc)
> 
> ---
> base-commit: 2b70702917337a8d6d07f03eed961e0119091647
> change-id: 20250414-james-perf-fix-gen-syscall-a8d9b4367d07
> 
> Best regards,

