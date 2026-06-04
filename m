Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658537106D
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575769; cv=none; b=K8ZByz/oZVkA3bf7i4sQmrtln1jyaEqXSuevSVBf4v++R9yTE5rtKZHUtp3FLpyZkZluxbo+Ve2asxcZGgN0ZKKZ+HUMtL3E2y2pbOmlOz4/yJ/HHfcCuXJsEVPDrt+UBV/5JnkPLKp/OoEWNtzyPZI/4jjWmuZm3D4e6WIHoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575769; c=relaxed/simple;
	bh=a15fuknZPhg5CxoMfrb46XjXkuhlhr76ZG6Cgy5CSJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgFJSxqP7LCHYzUg3Oqkkvj05uzY2FvRdGXdECwgZw/Itk5eBgAaObVccu225aJbDfNu8KlGC4eCbM0nCb8YM/pc16ND8O+HuNEYUvpdiM03Ytolf4Cu0heBMzhodyeG+XU1C/uPwHSpQLwo6hEpDt6s+HvgICpygHqwezNMvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7DRIlwD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7DRIlwD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef372c58aso388230f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780575766; x=1781180566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKLGdfNT18VsLriOtCEzvToAjcqMcAhaOgOhA4AjUBM=;
        b=Z7DRIlwDE+O5+F0yRaV4aNQJhCYEoeZ48p6+2MdthghnabTwr+VK4iyaVxW7rpeJJf
         wLGuOz0Z3d1uJbCWkkvzVfgIAqg/NpqWPwYj38e3MUzIWeEz41ME1vij0VO7kwq44Sbk
         sa2oINx1hAImPZqi5oswDQSCIUAN7ZcbgcKSe7ooWxcqhIdE1RojDtPz2Q4RgraHiGjI
         wc7YcvC0BmAS2+rAyRZPm+8oSV+YLgwZzQNJ1peOlF6cc/0Bo+r42NxpIlH869jSh7hW
         cw0ULVATqK7Sx0T9vLW/0ycPdjSa1xS98bWVbMi1LTyJtRJC/it9asoHW3sMB1+4RLyj
         Gnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575766; x=1781180566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKLGdfNT18VsLriOtCEzvToAjcqMcAhaOgOhA4AjUBM=;
        b=YMCTxR+zI8q8TYLXtWj+mAyP+1zgo/R7y9lbTKzYhxDDyKHgmMQ7lubwNdNUeGHgNy
         VazwXxsPTyu8mP8UlMla5ReI+F/sdZBVTzd23iuVW1iNR4U+ZTkx2vHWWfRGVBExTvAA
         6cK91j1jnLBFyyPewgjucaf1c7MZHGM5Bs6OLK7q94aQgm6P0BdB6HHcUOU1UVYZx5WG
         na8OSkh/bkKB5YbGkTYucCKgzHzp8sACwiRwuAMS1KFWgEdXIoVBnPviTfw4aQrYB3Uf
         QUHTErJWqI/7gl0t6+SBaiRd51YONd4IzzhoRjoPp6IYC+3aK8EJiZYEldoVDTcZeMC1
         jBgg==
X-Forwarded-Encrypted: i=1; AFNElJ/NjkVjln4886U01jcJgJ8wsqXcx0/s4ti5de57oQkP8BlmtX249iEwL2hXnN9b0PbExmONiPRp9RlIy+3rIF93@vger.kernel.org
X-Gm-Message-State: AOJu0YwTC6ZzL15gxlJYobQgf/lBRtflmRzcPKbnkc0XrIpExWf3Aafj
	v/J2Hu9jEBNAthfU6r8IRo5hwdvGWpKQeI2VmBZYiABnMFOHebXEl3zQVZB6cnDWqRhDIqSOoDM
	nZMK+PLE=
X-Gm-Gg: Acq92OFMPlU6C8UzkthkSnxB1QPb6+YVNA/MXrOh4IeF4wbfRb2iPenUNJ8V6QKBOyl
	oizkljL8f13ItvhehuglG5FDKYZn31h7eF00uLA8tUzCLBUC0Zxkk+Lcv6p466elmRe/HLgJYyh
	3FAxVRThyfflbty1Hj4PB68fMpasLxV7uVmw4VW9/VyS8uaXpBOl7+wk5M8zgJbK7dgMmPgTX8+
	es+rDaD87vLXjT2MPWrEUYOQw8z6zMs3N9z4Ls2uyCyuWe/4mgpLmRnI8W4ncYYQ7JAe42wd4Rf
	miNTo6TJVOXc/tBslkykrUuguKUkHJLBatEqXJvlp2AjME7XLugXrGjQ6isFEKiYVHSx61PbaJ4
	gEOHM3uTbR6v20vPj5TI7NWEjBxCXoRuOwRCXTTe1a9QH+D39P8ZkrVHbMn9Vmw5UGNzTcNkX/b
	XFfUOi48UN9p+Xb4wSB4WRVDEnYjIUU/MAE66fbSY=
X-Received: by 2002:a05:600c:a016:b0:490:bc46:1a58 with SMTP id 5b1f17b1804b1-490bc461b57mr64677525e9.18.1780575766123;
        Thu, 04 Jun 2026 05:22:46 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm15406844f8f.37.2026.06.04.05.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 05:22:45 -0700 (PDT)
Message-ID: <64f23ad7-5033-4d4d-9e64-7503f0d2c46c@linaro.org>
Date: Thu, 4 Jun 2026 13:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] perf test cs-etm: Move existing tests to
 coresight folder
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-18-85b5ce6f55c6@linaro.org>
 <20260603180219.GJ101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603180219.GJ101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 7:02 pm, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:27:00PM +0100, James Clark wrote:
>> There is a subfolder for Coresight tests so might as well keep them all
>> in here.
> 
> Now we only have two shell test for CoreSight (I might add one for

That's not right, we have 6. The tests/shell/coresight folder already 
existed so it seemed like a mistake to not move these two in there when 
it was originally created.

> callchain test), seems to me it is more meaningful to move Arm specific
> tests into a central place (like tools/perf/tests/shell/arm/) for
> easier maintainence.

Maybe, but arm/ and then arm/coresight probably makes sense. There are 
some tests that have arm specific blocks in them but are still shared 
with other platforms so it could be confusing. I think we can do that 
later if we ever end up with a load of arm tests, but right now there 
aren't many.

> 
> Anyway, this patch is fine as well:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

