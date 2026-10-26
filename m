Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007952;
	b=18/PziJD0EeQoCUlGogmI6+AF0kEOpI3nuowdSh4F1o2iHXbCPYHvXHcOv+0Cnt29v0Z
	 BKJOHIr0nxZdDnrq6zM+Eijh6zRGZ5pPJkoRophAgciTH5rRV22ZuymiKyZQuop1qxm6E
	 Wz0OF6oib7qL+PQT3W9UitFG1mKzsD6Gf1494ooH79ReadnDy4DIGRrAN62xKxQEwviwN
	 zs5tTgHN91QZINPphryGUNhp2spUypshyzZA6sNPqIoVSHWG2AinPQTKopwCCggt2Eyaw
	 K9xRlZaiMdiYT5+Fei9DlqU9YBS/amR0PwhYTCFZAGKqcWfEnXFTUgXwnQTf9q539vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=uISNjmCShJIJ9U7oVaCYIDvxAqLTubZCQAnAKv9Gul0=;
	b=pShiB/MpG4lqR5bWBLAY4Nufhs4UdsPjlIIFRwdWgYHwdr4TZfocflrmjj/ojpCjX86X
	 hzww2APIrw/HUangoSGrMNu3ga5bkRWVvxTmmCNTuthifSxF9awO7IfENpZji2GIaSysL
	 7Yfgimat+f8lF656vtAtyCVmEZ1LhADNTpJWOkG4bGeLU5ANQTyz2rkokGmQo3EJXAXBn
	 /jJrzeF2AtFVMbnn2DMxOsW0RUgpjm91+4DzLsueC4PPMOHGglUPHw4D4UAQ+/XbH98B/
	 z0hzX9UqpMfbqH24+h5R9XMzh4NCAmeFKknhHWuBPj6sPjycQsyXa1yxAAG11RIXvjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a8cOFiNT;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17E606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A17E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a8cOFiNT
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e47347279so768146f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793007950; x=1793612750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uISNjmCShJIJ9U7oVaCYIDvxAqLTubZCQAnAKv9Gul0=;
        b=a8cOFiNTzODoESqu/FX14nDX71ki+Ovb0lGMc4rG5YGA9fH/QDDHfoWo1RO2CmbE8W
         J5fKFEWzSMwVDgDCO8tMN/Dx7KyN8mGNby7U+hXaT+LtLVXUBUlYh6J2asFA0GAu7OAQ
         uIFCj2tEtPNskelLAqpWqFipr27pHfvBILQgIrW2wF/PaLIybuXHDas4wHZofKaQc5vN
         xICU37igjo5OnzjevgRB6Fgy5PsrNVsGq6ubhh9QZ9qzK5RquJmkXipoyjIWWt63vGFX
         ueyXwDs3FLPC0EgQyHzcp3SwTM8L9WVrb9Tk5heX7QgYYd1vo7QQD9QE1TgrywCfn0n1
         wdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007950; x=1793612750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uISNjmCShJIJ9U7oVaCYIDvxAqLTubZCQAnAKv9Gul0=;
        b=Y/yfXAg7QMHti3I9kzzxmqycLbfXIvIHQikHP6DzFMpcZhLU0d8Y2luDu9doCDkR3R
         3TuYEzHqhMleJBm1QKTMN32cpgVMHa14VR8lJCBwzOrC6+pCWy18W9yrH3W6RCSc6GH1
         PlGXpeYslxsvbYcXplphPe7u4MKt7HEDN4SxtcMpxeuZ0AqfugS/3JNGM11pBy7/MqPQ
         SRoLyMwTAHg939XM84tsyapfT/N2RPUIYYRf4VVOPrRVWFNLh0az1zluKN+GQfj2ZKXv
         l6ys8t/q7rUjBwCyVELjhzQvJIOjhRMPQCmWNQd6T/Vfy1yoMEcJtbvN1cAJrlA9cnGL
         5hcg==
X-Forwarded-Encrypted: i=1; AKwUvBzUqTdNI2ewioSH86GSOFrxe4RifZBIOh8d4KfEb+ErklfjWhx0baXvbsaUu5CHDYWnWK68M4SnjmEx+ZqXLP+f@vger.kernel.org
X-Gm-Message-State: AFq9FYLGVJkWxFSIG1v8W9LBWvxeJ/elgv+KBl1MMdVRtKAqEiP1U05j
	Z5cUcA6TjTGGZkWgS5QYpaPjXf2OOxLlTJkf9jzQtMlxgtYlrz8p0iyXywKpu6aqKBA=
X-Gm-Gg: AYBFou1pFIt8uhH5M2ofLNe87rf38v1Tcod3R7RIL3hu4fTl9xkJzuCo8Uqgaq0vKMx
	PN46iKvrvlA0u7UZ+B44j4X04V4RyTxycfIk/lD9Z5XIfXlLJKMzJYCh8mURy6idKQCJphsNTWP
	jczjIN5ImsqGqxBrwE4FSijHt30CCp610cSPykD+CzKuFFFfcrDzEG74/1QGB1gpMNMCxc1Kif/
	7sZnZqvcEw4A/yj4iAuMZQ+Z7pIzPcli9umsZhLZBpDRZdebuYun7u1tMw3aO3/YDbz41OLPkls
	seC/I0JzEQffxH0Nd5leZ/vxAaafGhWyhNCGOXA0yvyYGibwTFrc6gjdkMpFTnSdDh6JHHroMZG
	NbvYXhIsbmWgCFe9AuAUJxk0+WWYrXcOLS7onNh+HVm4fgVaZySxg9O4SYvm6aBCQ1aW+tS36UJ
	LT8z3BjaEoGPWmbTQ/K9DVnU2kuERwmhzIak9BEE6MVm6gLQuBnLsHDEvW1XpRsOC+NWdlw6lPQ
	RajgMfIYupVHkiSj1nzDJDEHA5p+t5UxXOhqV6uXTSYqSPsDUhwJlKarNeOgiriDHVRpEXfukBy
	OQEtnw==
X-Received: by 2002:a05:6000:46c3:b0:48d:fed0:ccbd with SMTP id ffacd0b85a97d-48e3eb93719mr6507061f8f.34.1793007949962;
        Mon, 26 Oct 2026 02:45:49 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4ba7sm15594852f8f.33.2026.10.26.02.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:45:49 -0700 (PDT)
Message-ID: <d3e80414-4f27-44de-b6fe-36d9a675e4d3@linaro.org>
Date: Mon, 26 Oct 2026 09:45:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] coresight: syscfg: Remove unused
 CS_CFG_MATCH_INST_ANY
To: Amir Ayupov <aaupov@fb.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Pereira <danielmaraboo@gmail.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <52b3c337cbf4a8460e399b084c6f854eb3beee89.1792989860.git.aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <52b3c337cbf4a8460e399b084c6f854eb3beee89.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2026 05:48, Amir Ayupov wrote:
> CS_CFG_MATCH_INST_ANY has been defined since the system configuration was
> introduced but is not used by any configuration, feature or device.
> Remove it.
> 
> Suggested-by: Leo Yan <leo.yan@arm.com>
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   drivers/hwtracing/coresight/coresight-config.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index f04e73b91d9a6..220bc54f8e5e1 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -39,9 +39,6 @@
>    */
>   #define CS_CFG_MATCH_CAP_MASK		GENMASK_U32(15, 8)
>   
> -/* flags defining device instance matching - used in config match desc data. */
> -#define CS_CFG_MATCH_INST_ANY		0x80000000 /* any instance of a class */
> -
>   /*
>    * Limit number of presets in a configuration
>    * This is related to the number of bits (4) we use to select the preset on

Reviewed-by: James Clark <james.clark@linaro.org>

