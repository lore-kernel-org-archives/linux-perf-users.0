Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEF331205
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788426; cv=none; b=jZktRExcoOManhPGrnW4iQXKIOAUDV5ZFPvehP1hndBv2eP8ujBiEN5Hb8hyCh5ohEniRPLmDVykylvNr9P5QJ3ppcbwdWKbla11WyMNbqjLrBjntx0nkY7iF53jfnD5/T1uPiygfUaIqGVfujg+RQAd8dRZjYQMobmslgYq+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788426; c=relaxed/simple;
	bh=t8lQ6tS0js1YcqGRomxEF3rG912CBWGbdy7N+ydCDFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3dZhILtvjf/+NrRkTXSadCqpbkhPvPOGh4cGn0mIEjHH7w+KiaC7OEs8foblvllp+Qa4dO6IDAHQhyMebrGORAElMxTAjqqlsSIGmVcc+VvmZb+wPYuv44EMJdhvBj+o3ZA9SVIN7wwHJTG4y+QPn/OkiMkidu5iSWlBnTb4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LeV8uO57; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeV8uO57"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so4257953a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 00:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765788423; x=1766393223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olctGR1OoIBKA9JqPtxHxqGDlNhk2l7c5pdiCsPqVzQ=;
        b=LeV8uO57q2gFSdxBpKN6jdrF8w1hnITS2fvMj0740C0mg2sBJDSamKoeA31qybYCSt
         IiYYxZTYkMbTuCJhgE/lVoHx6EW4RLPUck5IGxh6uX+4QW1RfSDuz4oA1wPXmu5aR++a
         L2NIY8zJFaWGkQg5md/nBTUb6y6mgqPhZxXSMTcGXiteeZkjP2Ds9SvTKIj6frtudNnP
         tAatKrA04Fudr7kEbZwkHpEvBsN3sP1R8geaDs2Jxlj9YdhWEMkhJU9QmMf4sIiqJOfI
         eSisnqcdkiDxAc03SvScWhtDREcqhtZS6QfeqIwtjSAef/7CITHXWw6geRMwz+qyFUTq
         sXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788423; x=1766393223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olctGR1OoIBKA9JqPtxHxqGDlNhk2l7c5pdiCsPqVzQ=;
        b=jyaRoSPZg/mYrqBLIMz9pwqF5WnuUSplwadIeTJon2YxzgiiKgZWN84OcDGfAFw1ip
         WGEaOup+qM9feNDJ+XsIuaYTWnLguQPfExVx/lxA7xlTEC5NAvIyrMnj40jNYHefklyN
         VwDAVAU+6og7zvnBM/hKjqP5siPtMlA2HwtMJNELFpJ72BaFvGusd4P+juGa/U5qpokL
         N3qhuC1DQGM23qT+8JJDaaiyZou0u13v4U3MKtfPKfk31l3w8pOvX18wwDugcYtnME3L
         JZrMLaslQ2+xGPQ7GPG2sn7tjZbHltl9/UUC466JTnL1k6IEhMS6pdASc/+pYlGVxZC5
         Xuig==
X-Forwarded-Encrypted: i=1; AJvYcCUNrTnnrMn96mr12WFVb0pum8l6Ka09ENodIYXfI3j/Fh+zl4CaCzTeUILQVFloqawS3foAUkE8dJ84xiBQVKBU@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqKKLf9rGBRu5ZO9tvmB29rNHjWAsGn0s/ZA1He5geyjswwZZ
	APm9eGLa2MS6UHfil7X9nY7lz0MAt3x6cpg9+znx87tjjr/9bKMQAtBR9qdHsVcdPeMx5pajxHn
	1FlBHl775drhm
X-Gm-Gg: AY/fxX7LyM6IX9NTqolFod4llCp9t/cuHKVYGUbb1nl1yQkhF4DD2BDc/fiwMHuTQHT
	xF+CmDOFuIGJfPbml7xf/pSSEGYoIsQlYoapRXsvYRoY9pbjCKl/yg99hTWKFsjkLRJZHqXbtcy
	RhLCDtIkUoj4m+kQ3e5/VIhip0KrKBfF479QfmQ0/31hQingw4uA7DzIMYu1w5kTgfNG4oc95Rb
	stFaon5xsyQnead3zdia09zrMdFpv1/Dfei+uv8i3fzcrM+/1j+gJK6RC3rlq2Jt4/G8q7GSVEU
	ThgH1jf1PicDSnxCZLjkzF2ulh9VowZI3orBxij7lAYcE7Et35p6za0fR0EYarxCfncfbTFVA1L
	EIpE273lINbLoy60wfjbAsSNTUjHnI3vRVBQZ6VXglsue5WcWJ/VvkFhkA36BEXjUCkr5UWaQH7
	eAoyNJ5L8Cp4+anoAfbHqvfqb6y/ufAos=
X-Google-Smtp-Source: AGHT+IE11WB6QPPr1tBqpVVVM08QRXAEa1dmMcvpY5A4CSjX64MQTPPHz0VIcmU0USVC6McrtkW0VA==
X-Received: by 2002:a17:907:2d8d:b0:b73:8639:cd93 with SMTP id a640c23a62f3a-b7d2362927fmr1008136966b.14.1765788423083;
        Mon, 15 Dec 2025 00:47:03 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29f6cbsm1362342666b.5.2025.12.15.00.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 00:47:02 -0800 (PST)
Message-ID: <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
Date: Mon, 15 Dec 2025 10:47:05 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
To: Joel May <joel-linux@jmay.us>, catalin.marinas@arm.com, will@kernel.org,
 Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/12/2025 00:12, Joel May wrote:
> From: Joel May <joel-linux@jmay.us>
> 
> A fix for the Perf build process was introduced in commit bfb713ea53c74
> ("perf tools: Fix arm64 build by generating unistd_64.h"), which generates
> the unistd_64.h header as necessary.  This fix works fine in some
> scenarios.
> 
> My problem is when building Perf from tools/perf with SRCARCH=arm64, the
> path used in scripts/Makefile.asm-headers is relative to tools/perf
> instead of root directory.  This results in the build failing like so.
> This snippet is a simplified repro of the problem, see the link to the
> TrueNAS SCALE build script to see the problem in context.
> 
>    jmay@debian13-aarch64:/mnt/linux/linux-vanilla/tools/perf$ ARCH=arm64 SRCARCH=arm64 make -j1
>    ...
>    make[4]: *** No rule to make target '/mnt/linux/linux-vanilla/tools/perf/libperf/arch/arm64/include/generated/uapi/asm/unistd_64.h'.  Stop.
>    make[3]: *** [Makefile:108: uapi-asm-generic] Error 2
>    make[2]: *** [Makefile.perf:972: /mnt/linux/linux-vanilla/tools/perf/libperf/libperf.a] Error 2
> 
> The problem is that scripts/Makefile.asm-headers is including a relative
> syscalltbl path from arch/arm64/kernel/Makefile.syscalls.  The syscalltbl
> path needs to be based on the srctree root.
> 
> Fixes: 7fe33e9f662c0 ("arm64: convert unistd_32.h to syscall.tbl format")
> Fixes: bfb713ea53c74 ("perf tools: Fix arm64 build by generating unistd_64.h")

Hi Joel,

There is a similar fix on the list here:

https://lore.kernel.org/linux-perf-users/20251204-perf_fix_syscall_header-v1-1-b8e27f74ed6a@arm.com/

I'm not sure if commit 1 alone will also fix your issue, or we'd need to 
collapse both of the commits in that set.

The first commit has an older fixes: tag and also fixes some other 
issues so it might be better to take that one rather than this one.

Thanks
James

> Link: https://github.com/truenas/linux/commit/91377b555a57dfa75364d7da85b5e21e41e81625#diff-831a0e8e3eaa7a5ca92599e58771b8a6b2c4bd7533f627e33138873995aac61eR147
> Signed-off-by: Joel May <joel-linux@jmay.us>
> ---
>   arch/arm64/kernel/Makefile.syscalls | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/Makefile.syscalls b/arch/arm64/kernel/Makefile.syscalls
> index 0542a718871a..958f2335ec1b 100644
> --- a/arch/arm64/kernel/Makefile.syscalls
> +++ b/arch/arm64/kernel/Makefile.syscalls
> @@ -3,4 +3,4 @@
>   syscall_abis_32 +=
>   syscall_abis_64 += renameat rlimit memfd_secret
>   
> -syscalltbl = arch/arm64/tools/syscall_%.tbl
> +syscalltbl = $(srctree)/arch/arm64/tools/syscall_%.tbl
> 
> base-commit: edde060637b92607f3522252c03d64ad06369933

