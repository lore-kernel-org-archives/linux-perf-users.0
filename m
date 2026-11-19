Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795092419;
	b=cyFxXARqHZuwsGOLEuhK9F2sVg2psm3aw4MoJhC3tH1REjSat7ylDIrhjsW2bOmdu8y3
	 kJMo/qREJlJcyULBOjtHFehArgMx+LOFyv2jivF4NxXNTeN0JYVgmbcoqOXUJ5VlWWBRU
	 4DH1rpHGGe1ZmwpmMI5fAaJ70tlN/x4HKY2EWTroBceLXaYqFP09vxsFhwnDdavkVqEC6
	 E7Z1XAaGsRDyLayJeTTYFfMC6YVhdwMvSpwjujwKy8jhQWtj2VH4fQlXLVP2MGJO5pGHy
	 ZheZWF0PymNVmEc19VBRTeiUgae5Qoqs/ELhxIKfpcVzaki5XRj+XGF5QTk/yWHat+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:X-Original-From:From:Mime-Version:User-Agent:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=DQI1OZNYohFiuung2XmK2sEz1Uw+tUzC41KeP4vlNw8=;
	b=EVMzGgR/wsPc7+vDYzaTkTC/zj5MKHvmjUwN5TyZoI7SfjqrvzNdlBYIHDmTShDNAIei
	 Npq9tFTsC2Tgo+SSXNSBn5uWMh7aECUOeSQ3WEkJNc1oGqiKbQz7z4JE+iKwRC8BCAiWI
	 b49fdVC/q9U6mi1FeUXcxiX3nVxizx32/vSZIFBXrmMULfTEarF6rDoheebiAghTP/rdl
	 BzfEQg54uy6J0catMUc/TaJYiF2gw3EqiyKMae2gh+fNKfkDoXeRiPKeri4AfhV6mL7kK
	 6J+Ob6N5W45BSjav94lyarHadT3DlNMolmeLgPLHJ4KT9ciqTPhfj9p9ie8JfEYcg6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PVBcFpas;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228C606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E228C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PVBcFpas
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67db5e13b0cso2050900d50.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 04:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795092418; cv=none;
        d=google.com; s=arc-20260327;
        b=GolMbdSGqOvn2Lk5WSz/kSjtJE3yiSxOJZWjkaWEyy921V5V37PKPXT3xyRcdp24Ix
         qR3/elGSblebos2DXe1qH0KBUQ4WZilqkdSxxCFzdpRI92ebtl63JAiqXyzAt73cOU+0
         T2X2RSrIKGDCAooTnqq/pRtXizmDPDpaT0c+eXt5FaR2/tA/nAWWYzXbXqrMqAEiTuuf
         kmxQcUtr6x0xQhDd5vcfB83CMt3A9aFKyFtU69jAu23ibuEt+nl0HLWgm7GU9MFuMtQ8
         liZsyrccRwWV5cgHYyIB/gHZ0eqdZAR4i6e15Hw8VXwX8zf5hMwj2OvYDvWuqvO6tYnY
         9+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:user-agent:mime-version:from
         :references:in-reply-to:dkim-signature;
        bh=DQI1OZNYohFiuung2XmK2sEz1Uw+tUzC41KeP4vlNw8=;
        fh=rO+xIEFQleNqBzD714XLiz2l03tZKvKXWRldG3/wOyg=;
        b=NR6c/qJc1mdZ0u8z5vtddiyOqZV1ExG5lnpv1cBJBn0ODCBfhoBYmwVdoD9DjhqJxk
         sCUuvbPbZmT9w7shVmpStmVW0RF+SzBU+gT1Dsdv8ZTvuwcxlxSsFGpz3jP12NsA6gZC
         WFvIRfGzH26I74R/ZtBuV7YaYTBDGfCrwQVFgOByv13FDvig06BmqRsNW/fh22iKQGPU
         u6Cx0OJ/rAxhOVd0tKzCA2D2Yv3dvARgs5/gNVKX1wCejNAAaWhG0EerMx66RZ7rE/Wy
         ivR68uL15kOC3kxyBFiiwrzdUFbhoK6minr4gGFfw7X28DNRHpxWI2Qq+t97WMOKZwZS
         ZLKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795092418; x=1795697218; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:user-agent:mime-version
         :from:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DQI1OZNYohFiuung2XmK2sEz1Uw+tUzC41KeP4vlNw8=;
        b=PVBcFpas1O8smDHU+vAfrzG+rYFHrAQDcyNbr5hyCzToAVKVsl0IlJXf1fAxNIbcMS
         fFaMWPOIOO67Ge+lHCBqORfslCkWcgsu2TU0CDhp0qWnbg6+8wd7eFEzAt8d9VaDLdM2
         pIjVG+zDtEvZo9sQ2wU79yJo/+foxmdaxtCiOxYBKT/lgB6jYwTQteAv7sk54loaJZia
         mX5J+YP3UglKO1N9wQZ9BdscQDjZ++aBfNEbhKM2S5kXHY6gfg9HbHNxGiT/9zxGPwAu
         Yem+qoolbm7IdPNK2zTIsK6XZBZs0XnAfsi3gMxB3mjZAeIml7J0XqLZc4D9Hma1qGqM
         px/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092418; x=1795697218;
        h=content-type:cc:to:subject:message-id:date:user-agent:mime-version
         :from:references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DQI1OZNYohFiuung2XmK2sEz1Uw+tUzC41KeP4vlNw8=;
        b=HlCzgYHHX+zYWvqz6zFjz2Rkc8ABVXBneYmiQMnt7m9zoJ2b6QvnigNLmKrv0NCI4f
         kD/2nkop7rDeDQScu/lMg3ZQ/0xIJNaTEMKVBKIMbmq1aQXJ45cpRNvL53mu0ukLLZ+E
         zvEnFkfgFQ2aO7egarHTGBqyPBpDFQzAdJ8B8g45kjdJFrgu5pCufkklQKf4Yx4zqEMd
         NBUM9jydonkzHWOIxwAh+Pw7qw6K0YgDVh2+R/v8NMWBBCQkbNS5/q2IodRZaulsCx1z
         Rmt8/99noyIzIFjJnQ1FRNMHWztcaMBu/ezy0Zfrs+BYynjjMnAdI4Yh+Iq+HQ7dtAyD
         I/Qw==
X-Forwarded-Encrypted: i=1; AL+hErGVog4eJBMCgL/OXungnZhr8y44wtjEt/B+TujVzshnDqsQwGwCzei2dVYXVHyJ4bCjSVJXJ3ijQN2TfgordjCH@vger.kernel.org
X-Gm-Message-State: APuU4Z/zvHzWcpCUxrKXKk/+yeYwfkva+qFbWkhziDKD3Q3Su3pE4dPb
	F9Se/mjbqxu163TeE5Z6cvO5TIWNe7FrzkMi1TfV/KyJ31LY4EbtioEdew2EIyeIHOQ1SiWh0A5
	g+hXyeaJGYVyeR5+HRThY/RND3wKqo85XVi+1NduNcw==
X-Gm-Gg: AZFdTZf/8yrKiryaix4rZDXLbC/vHpIApBSdYJZmyAVsnKZq2X1RhFWKa9+4kccBbR/
	TIBl3UHoFC3A1HVQ/0qSoqJuE7njF/G6VYvwUoZlb1dcarQTmGjAAK+Z7r99rQnMVjolDIEEEzq
	YqZVz1/TtxZa4oDZlo0M906JsqrGGQz9X4Jj1VcgsJBhgqSIjTVrepFwAS76BTLJDKfkeWJISMi
	25xOl1NNwcSrI2FpztIPY4YUoXgxsYHxGayrif2JMJuYFc3k/ubLg0Cfy+xpRv6+0L7rOdCDQ9X
	SbPMXFUZsc7p1Bql8cJR01GSmfmqfg/VqNqlt95/OeLlKuOoIzhzxq9labWnNdwa+LOFcuHGTL0
	QCSqVBw31+UwfdY5UgRjb+eOQCAMhOxqj/fwRZg==
X-Received: by 2002:a05:690c:7405:b0:8b3:3fe5:f6ab with SMTP id
 00721157ae682-8b4fecfa349mr19565437b3.24.1795092417770; Thu, 19 Nov 2026
 04:46:57 -0800 (PST)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 19 Nov 2026 04:46:57 -0800
In-Reply-To: <29e631f0-c135-bea4-0a3b-81dd715cef54@kernel.org>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com> <29e631f0-c135-bea4-0a3b-81dd715cef54@kernel.org>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Date: Thu, 19 Nov 2026 04:46:57 -0800
X-Gm-Features: AclHuK_VCp2Kj6TuYw_2lEwgIiu0LS1C49sX3AV2M1eYDrqr2PQ_yG1as_cK4Hg
Message-ID: <CACnXVne49x1JEPZhCaQzofGDuZa65F6cRpE5Pzj=3s0rzpHUcg@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] riscv: add SBI Supervisor Software Events support
To: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>, 
	Conor Dooley <conor@kernel.org>, Anup Patel <anup@brainfault.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Atish Patra <atish.patra@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Yuanzhu <yuanzhu@bytedance.com>, Yicong Yang <yang.yicong@picoheart.com>, 
	Susheng Yang <yang.susheng@zte.com.cn>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On 10/6/26 6:21 PM, Paul Walmsley wrote:
> Hi Zhanpeng Zhang,
>
> On Fri, 11 Sep 2026, Zhanpeng Zhang wrote:
>
>> [...]
>
> Thanks for taking this series forward.  Could you please rebase this
> series against the current riscv/for-next branch and repost?  I tried
> pulling the series in, but it needs quite a few updates since we've
> queued up quite a few patches that touch SBI.
>

I've posted v13 [1], rebased onto riscv/for-next at 642fb67393c1. Could
you pick it up for the next merge window?

I'll address the crash-kernel kexec restriction in a separate follow-up.

Thanks,
Zhanpeng

[1]
https://lore.kernel.org/r/20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com/

> thanks,
>
>
> - Paul
