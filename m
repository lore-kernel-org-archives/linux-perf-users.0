Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69E28E7;
	Fri,  9 Aug 2024 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723169720; cv=none; b=cdaAlx+odsNIeyFS9cnLFGImAUiHvvaBH3ef18Iw3KdLX7vPpnNeE/TzFkNXWMpSAbMJGFl0oitZlVmTQYvZzSCB92gp1wVWp7XUOJZNUYYUWwqwQIAOw2jyb2t2EwrtQ9M0EpLt34RVHG65Q2iAKHk47DKIYtpp077rYV/L5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723169720; c=relaxed/simple;
	bh=M5MqM1KAWY5oYZaYbTi7EK4ppq6sp2rBOyFJN0AzKvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kk+VcESOX0FoXVruK9fqmkaDJDiFkraAOTi3cEvLHr/VjeK/dpFlrZkAVNmMN9hVJYdXJp3OXoknFiZR+Cc2Q3RrB6gfInFiR06wADVHq7RPNC63L4uV1gHXrySf1aDEDweMgc/bMBSbkWKHCvk9rKia1WjklUGoc3fbEOUCQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khw48ILc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khw48ILc"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d162eef54so1312260b3a.3;
        Thu, 08 Aug 2024 19:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723169718; x=1723774518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTiSyDzQ2lgiFfOqhlBi+UtxoJrWKu0iKpFDCLGRyQc=;
        b=khw48ILc70Jk5ehnC1KdZMWb4pab2TcSOl8+WqKtnXHy/yp5vpmQT1enoFTgrwCVdn
         12knZ8iaqItesggbssjrDY2TmwhJLuId8hrpYz7MHalJFv55iNoIIKQ8XOEcEkHv6+Mt
         iHScvf+IGx2NjsAFe9baqk6pxyhNVQoMwKvQAepQ/1hSaiYtQqiRVtHoTLxACWvj58x3
         gwMjyn1Hex+nUKHM5p6zN6XwmEY9uNIPuHR+199xXnrV99TPaBrGI9k1s1FDaRJ2T04Y
         bmOox/L7Tmds48pofCPiX0ZaynAvY+PAy8RSykKYpnUdOr8IsFeyK4ylcEqU5t2cREsX
         3Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723169718; x=1723774518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTiSyDzQ2lgiFfOqhlBi+UtxoJrWKu0iKpFDCLGRyQc=;
        b=sGBhkZj2433sItgE4QBIaysPb+5Gyop95mROUhferFcLRGmanm0arf/ysXjfeRIq/u
         32nRXtt+5LhosgBGIjEM1456IanbTdO9of0IWvgFeb9U7grgTWCT2Qy7U5Lt5VMUhnft
         v7XTZlmGKcyocwpU47fb9RpxJ8bpH3OZbH8WZTfU+PBjRnG0ZOeD2E1JdipkG9e58h2h
         Ok6VatmICg66uYcySb0k4sGgw9PAwWvx8Z0OjF+gExsvUxjZAMDTuyz69FMCRAuemg/a
         6ShWUQfcMH2TMeCl/KYeGHyqxu1CamdCBVmU8fvRMoO+8hWwGAP31k/Qk6c4e06f2F2i
         TEhw==
X-Forwarded-Encrypted: i=1; AJvYcCWr7PKRGKmSDrvLOSJ/07thNjtUe6bC6noy7cbjZDtKIyVm6m/mUgVQXVpKP558y6msTZ4y31PG/Q0suMrooFJ5jS1JHLwxCIyJWlPq5mC4JcV4soplTkW+Ah9cUi2+K5uhAG+1feULzRs5vYeovQ==
X-Gm-Message-State: AOJu0Yw+NaESaLbgb30HYMS6EBf5LuvrwRnLpN0dwvwNO/yR9g1XhPuV
	iZkhcyhFgArE28vunExzAHq0FHLT8lPGAru+UGUPS/pb3Qwq9m1L
X-Google-Smtp-Source: AGHT+IFlU6Bmj66ERhyWTfBHa+SN+Yo7E4RLP1y7LbEefmal6wAYAlWVZKHG8RFi97xIXo3d6ntMxA==
X-Received: by 2002:a05:6a00:b56:b0:710:9d5e:8a3 with SMTP id d2e1a72fcca58-710dcaa69fbmr46015b3a.30.1723169717910;
        Thu, 08 Aug 2024 19:15:17 -0700 (PDT)
Received: from [150.203.214.79] ([150.203.214.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a054sm1732459b3a.20.2024.08.08.19.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 19:15:17 -0700 (PDT)
Message-ID: <bb2e54b9-a40d-4c4c-b769-0563d071c303@gmail.com>
Date: Fri, 9 Aug 2024 12:15:08 +1000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf script python: Add the ins_lat field to event
 handler
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Paran Lee <p4ranlee@gmail.com>,
 Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240808133208.3577910-1-fzczx123@gmail.com>
 <8be2eeaf-9c85-4a77-b66d-53dd1b35bf91@intel.com> <ZrUrZOp1w5-8wjQM@x1>
Content-Language: en-US
From: Zixian Cai <fzczx123@gmail.com>
In-Reply-To: <ZrUrZOp1w5-8wjQM@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/2024 06:32, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 08, 2024 at 06:50:16PM +0300, Adrian Hunter wrote:
>>
>> Minor comments, otherwise:
>>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks, I'm then waiting for a v3 with those comments addressed and your
> Reviewed-by tag collected,
> 
> Thanks,
> 
> - Arnaldo

v3 submitted with the comments addressed.
