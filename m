Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02B1F94C;
	Wed, 26 Jun 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416875; cv=none; b=cYULsy0lNQlQMMbCeZW4Mco/ilWHcS/4kqd7Ze8qgM0s7KZA+GbqAS52Bkgek5JUrR7XNMGc5aAJs/ctbv5QouKXzefpK89msjoBtvB2rlHu+B6FQpBfulPX03/00E3JHOSqKwHhMuEwjeKbewQZygRgwP7tLrhB1Gt5Lro4yXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416875; c=relaxed/simple;
	bh=iIwbTdgH6YrONpmP1QKayaTmhFJ+XFBFXOn324NrzLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbPF9652/9FSOa19RhhiA9tcrTk5fNl6VkwEkSpJ4hkaFWItELNT4yNZ0m4/ARQ9yzNiZ8pqpUZMom/7By4EeC9R5pZ5EiknWtTZ72/Z45wAsNAq0AHwRqeMHKIRp6D0NDchCsUicjZSvr9bZVQnvX/XSml8920UhN3kpo+DRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh9gRjsx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh9gRjsx"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7066f68e22cso3226644b3a.2;
        Wed, 26 Jun 2024 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719416874; x=1720021674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXfvd0m+3+tN0rU0XB0XqzYmYVrFO9u31ZbFfeNGbqY=;
        b=Hh9gRjsxjPfDzcTylqzZ8r0G9/EVaZUs1cEHW0KuScCacvDZtmGreC0vzxvbpqr2i7
         uHZqdrQtnexHcaFXPUPlGnnZ6pzvMWtDoJDTLf2in/QyiyXyj+Tid5OAIbIjG/lCVPEs
         fPft3nlX9FkKtleTqvCmINvgRNEd7yKKb61oatko5NCJsb2rBjd5Onr9/M63xY4El9Q5
         ve2qhX7b/hYRO1dXcsf/eBCW88QNCWhRVURKBMDhVVlefbGE5r0/EIbYFA1t5FaOEDRA
         GLYogrZwiW7TP/ByLffDiriQqZJr7WRKmkLxa7Np6G+Eey8u4itU3vZkysFEjTPb6b+X
         DDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719416874; x=1720021674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXfvd0m+3+tN0rU0XB0XqzYmYVrFO9u31ZbFfeNGbqY=;
        b=cPZh53uF2DrpnAXMoFhFAHPAjJ83n8zBAngpC+MA9Zi2PXy+qZyzWj6nDwTgMt1mI/
         XECg0+EJgBn1MkF3WhHxtVCFMdQMQSmATzu41SUj9BhSZ/qgbk6wQcEntpJWBMdocwZa
         BmsaE1rHWCozGER4nsfzE/VEslW7VfDWMqmvF5H1VHf9XhfBOFrmQGB6V7P9ykdSgH2c
         dzJD2kxLN6oa3i7dlIcoEdgv3guzeTfE2e4TAinEibUXeQ4vS3xK3A3XJUPDX8+sRN6n
         d7VArHB3q852k8LgcKgncJ37zif8Uad1reN198CTzj1UkTnJOUDManakd9tA18p36NWM
         JByw==
X-Forwarded-Encrypted: i=1; AJvYcCVq34VdiUv92hQCdsQP7NPXjwfj32PEc/zsMEB/a3goP/1Hfxd5tIT/l4LHh5hGPOyBXPA21Tbrw4DEVt4NWDrIaVG/TWqQEiWcjCgi/oBpavEitq1HJSb6cFqWX5iMjIMI62OHtG1VMQxULk4IcA==
X-Gm-Message-State: AOJu0YxbD274aHmYI/9vSyGj1UZk1VYmNKSraERL8F/QG8eMVpc1pT6w
	mI1dRQWAkx2iNiuY+TYWtNIunlwxdm4KbPv5YscVQQhKBVt029zU
X-Google-Smtp-Source: AGHT+IHTwZkDn97M57gb+TXkmFzxBvuEOvlZ68cTG4QgvSt0Au0lYg2lm7cTfeBVxk2kgb34opLNFw==
X-Received: by 2002:a05:6a00:2d12:b0:706:7052:205 with SMTP id d2e1a72fcca58-70670ee94c2mr14161244b3a.18.1719416873578;
        Wed, 26 Jun 2024 08:47:53 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706a8d0388fsm1451661b3a.157.2024.06.26.08.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:47:53 -0700 (PDT)
Message-ID: <ee434711-e4b1-47cf-a47a-6ba15ec6241d@gmail.com>
Date: Thu, 27 Jun 2024 00:47:47 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf unwind-libunwind: Add malloc() failure handling
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kan.liang@linux.intel.com, Yang Jihong <yangjihong1@huawei.com>,
 Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Austin Kim <austindh.kim@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 MichelleJin <shjy180909@gmail.com>
References: <20240619204211.6438-2-yskelg@gmail.com>
 <171937445590.2860437.11253278806338067490.b4-ty@kernel.org>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <171937445590.2860437.11253278806338067490.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Namhyung,

On 6/26/24 1:01 오후, Namhyung Kim wrote:
> On Thu, 20 Jun 2024 05:42:12 +0900, yskelg@gmail.com wrote:

>> This patch resolve following warning.
>>
>> tools/perf/util/evsel.c:1620:9: error: result of comparison of constant
>> -1 with expression of type 'char' is always false
>>  -Werror,-Wtautological-constant-out-of-range-compare
>>  1620 |                 if (c == -1)
>>       |                     ~ ^  ~~
>>
>> [...]

> Applied to perf-tools-next, thanks!

Thank you!

>> Add malloc() failure handling in unread_unwind_spec_debug_frame().
>> This make caller find_proc_info() works well when the allocation failure.
>>
>>
> 
> Applied to perf-tools-next, thanks!
> 
> Best regards,
> Namhyung


Thank you for applying my patch set.

I've been looking up the feedback you provided earlier and analyzing it
further.

Next time, I will strive to send a more meaningful patch set.


Warm regards,
Yunseong Kim
