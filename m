Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6582139AF;
	Tue, 29 Apr 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913760; cv=none; b=S6miqhqAxj5WkPQsZgstzhaDTlEejHV/wiFBXU97Y29NV6VRaHkeNU3w18orfU29re9ghf2n+CEU7yWr7rHjWEJtMLAVl0/rPZvngdOFaN8gG+aDegEECxibrHrbvMOBjPGbt0gwDvO7YgdURHdmd/RaatKhunLC2fnbzdNSyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913760; c=relaxed/simple;
	bh=5A76dadDBGQNppsiAGNHm5YkMrbIAYqIF2Pg/LDa5+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQ1wDujPRbdpLN5v/J9LiSz3wOoFj9ojAVqBSOCmU1Hkrrj+aFH7UM4SsJBqoy2R9gtjkdwHXWkxo40POMbU0CpuZSCEyM/d9Wqzu3UVCrYERIfQfHCaGpLOR2IasCXl+MHbewyLW+vDt67VgOeoK3IL+ycYh8VS/sgMqqj7BfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=OXLYAszg; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="OXLYAszg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=zqTzET6MGQVNG34duuSY1RDKYbmBBtwG51ANpL/jG6Y=; t=1745913758;
	x=1746345758; b=OXLYAszg1JKdwsDQih3VSRCb7yIWc4FsTd37HacP73EI43xGQVaZOXiS6tm/4
	RpqaGI1HeNAXlzSP7eIuit4gYwcp3dxw6sGHefJ8VgrIZbVCLeGz0meh48uu4KvJMTBdeV8e78ZgS
	4m3tQfBv1xPoCBli6PjVtXefuxfN1rfgJbEEYMACdWpcr/n5RjYdKtZrlTHQltOYhG3KU3wqkBtSf
	4HOuNthNfvZvEAsZDpF2NtnoBZn5eHvoRE8KVpCfIi/jZ4udjKNnwjrgPCsW1hYDuUovPAlpPFfSI
	rTFByzdywWHFBTC+Yh/7FmnjRcWXvDeeMglNSwCdxGleb0mPwA==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1u9fvB-00CdUg-0p;
	Tue, 29 Apr 2025 10:02:29 +0200
Message-ID: <f0bab5f8-ff61-4eee-a736-8c2dbd33bc72@leemhuis.info>
Date: Tue, 29 Apr 2025 10:02:26 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix arm64 build by generating unistd_64.h
To: James Clark <james.clark@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, arnd@linaro.org
References: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>
 <7703f88e-ccb7-4c98-9da4-8aad224e780f@leemhuis.info>
 <4c92fd9c-e545-47f9-bc67-0dfff962f506@linaro.org>
 <4c5eb1e1-f8ef-46a5-92da-50d77aba1405@linaro.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <4c5eb1e1-f8ef-46a5-92da-50d77aba1405@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1745913758;51d7ad6e;
X-HE-SMSGID: 1u9fvB-00CdUg-0p

On 29.04.25 09:52, James Clark wrote:
> On 29/04/2025 8:42 am, James Clark wrote:
>> On 28/04/2025 2:23 pm, Thorsten Leemhuis wrote:
>>> On 17.04.25 15:55, James Clark wrote:
>>>> Since pulling in the kernel changes in commit 22f72088ffe6 ("tools
>>>> headers: Update the syscall table with the kernel sources"), arm64 is
>>>> no longer using a generic syscall header and generates one from the
>>>> syscall table. Therefore we must also generate the syscall header for
>>>> arm64 before building Perf.
>>>>
>>>> Add it as a dependency to libperf which uses one syscall number. Perf
>>>> uses more, but as libperf is a dependency of Perf it will be generated
>>>> for both.
>>>>
>>>> Future platforms that need this will have to add their own syscall-y
>>>> targets in libperf manually. Unfortunately the arch specific files that
>>>> do this (e.g. arch/arm64/include/asm/Kbuild) can't easily be imported
>>>> into the Perf build. But Perf only needs a subset of the generated
>>>> files
>>>> anyway, so redefining them is probably the correct thing to do.
>>>
>>> FYI, my daily -next build for Fedora based on its RPM spec file broke
>>> on arm64 (x86_64 worked fine) while building libperf. I haven't checked
>>> yet, but due to the error messages and a quick look in the history I
>>> wonder if this is due to the quoted change, which showed up in -next
>>> today:
>>>
>>> """
>>> kernel.spec:3115: build libperf
>>> + /usr/bin/make -s 'EXTRA_CFLAGS=-O2  -fexceptions -g -grecord-gcc-
>>> switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security
>>> -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -
>>> specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-
>>> strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -mbranch-
>>> protection=standard -fasynchronous-unwind-tables -fstack-clash-
>>> protection  ' 'LDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-
>>> relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-
>>> hardened- ld -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -
>>> specs=/usr/ lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -
>>> specs=/usr/ lib/rpm/redhat/redhat-package-notes ' -C tools/lib/perf
>>> V=1 DESTDIR=/ builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT
>>> mkdir: cannot create directory â€˜/../archâ€™: Permission denied
>>> /builddir/build/BUILD/kernel-6.15.0-build/kernel-next-20250428/
>>> linux-6.15.0-0.0.next.20250428.435.vanilla.fc43.aarch64/scripts/
>>> syscallhdr.sh: line 98: /../arch/arm64/include/generated/uapi/asm/
>>> unistd_64.h: No such file or directory
>>> make[2]: *** [/builddir/build/BUILD/kernel-6.15.0-build/kernel-
>>> next-20250428/
>>> linux-6.15.0-0.0.next.20250428.435.vanilla.fc43.aarch64/ scripts/
>>> Makefile.asm-headers:81: /../arch/arm64/include/generated/ uapi/asm/
>>> unistd_64.h] Error 1
>>> make[1]: *** [Makefile:108: uapi-asm-generic] Error 2
>>> make: *** [Makefile:128: all] Error 2
>>> error: Bad exit status from /var/tmp/rpm-tmp.vAfil2 (%build)
>>> """
>>>
>>> Full log: https://download.copr.fedorainfracloud.org/results/@kernel-
>>> vanilla/next/fedora-rawhide-aarch64/08975350-next-next-all/builder-
>>> live.log.gz
>>
>> Yes, this is the error that the fix is for.
> 
> Sorry I had it the wrong way around,

Okay, for a moment I was confused and wondered if I was holding things
wrong. :-D

> I see you were asking about a new
> build failure caused by the fix. Looking into it now.

Many thx!

> I noticed some strange characters in here

Sorry, that was my (or my browsers) fault (some encoding mixup somewhere
I've seen earlier) and highly unlikely to be related.

>   mkdir: cannot create directory â€˜/../archâ€™: Permission denied

Ciao, Thorsten
