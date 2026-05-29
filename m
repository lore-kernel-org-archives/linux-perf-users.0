Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250E3BF694
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047760; cv=none; b=WplocAeHCLylAWv5nu+5FGnAMhHfInMAKDWasP7+WfyViRP5lEWS9Y7vSqRH8Q+Wrm6r0DZoYIdD4u3OIckB3JAy9lXTV0YWWwtA5c852HbDSNi3/CQ1fEPCrI7RpMTLcpcjBInu9T05sWPw2pBv65tVTwq7SmLd3J8GQ90XopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047760; c=relaxed/simple;
	bh=isASItfmZgHeSp/dcJBZBesZe5OH1kNpFjlamfqEyO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbbuQTpk2hfEIO650t/EABhQcHlVtJg1Ej6UhUeyq6uH3wHXY6vUDfL2tSvONigqED7qJYIusGFDIDwS1QnN1iESPwl1XkF2xuB+isX1iRUizZdbGngeR79tnSUfNVfY1ApOExUHxwOR25KVlHAtJeHLn4gGpVIaa/9aTZV2ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NmsNbqhF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmsNbqhF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-459bf19e87bso8302677f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780047757; x=1780652557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vV1zx1+zZXbYX7ohob99roya0Trf7vZYsGCeAF2uekc=;
        b=NmsNbqhFMl+Y5R3tF70ojex0jI4qObXI3MOI5ZR8bFgZjuEqTJ8n+0xu3nHluC2tbh
         sTl58uNUuajXNslbXZCn/n2bjkDUHDc2QPS/W73SCq88moUn1F8q/XSMUGIJ/T60hn6o
         7JW4VgeDF/bkIgegSJlnTz53oTlxKCaQ1J3ehpl/z6XSfimw7snd4IZY8rG4wT+U9tzx
         r76/UmTdKvjRUrmAZUE9sQ3Vw7IYaWSZ+eg7nxqhlqCsgXPvhYLeGu+1cagXQgreN6ff
         oS6GUgXsk1rDehbxbxN21jBSfDWv87xqkXMIflymuev+ad1jC0Pm31W0JI+Td7KZtEhI
         rgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780047757; x=1780652557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vV1zx1+zZXbYX7ohob99roya0Trf7vZYsGCeAF2uekc=;
        b=U/WN98wt+gPqnou0hhiUtziWWhCJMPa7QziffScTGW14TFyqYokt40X6emr1ltXRMx
         R/aqPf1odQo1miJ+Avyfr2O5xYbAaglmLkmVKp+l0I5mUF4eHDFm8Fm8FYYE1EsXZHgd
         W6E36fiannHNC3SQdvHr3CwzeBtGdXqus6/GUYOQYmBlQmmFF3BbxghcxGnzRCoY5XqD
         59fCHrAM8a+gYlL78TCgkZPx4y6bfM8Ri/h+ba6IL9qci0BsF9rTp33k6rXOJCwXEY5T
         EeKIcXs4dGZGSCKGlDPshPyw0B7ExQqLJXTRub0uAKUBUxV6SiNoL9zcYntnXsujBhXK
         Uqow==
X-Forwarded-Encrypted: i=1; AFNElJ/MNXY6wOM/wNdQ7GHisjUMH6FjKPSF4Lv0oQbNImaB4zQ+3VVl+v2l45oQyiUuIzlQditqSMNL8J03GuRSGx6b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3rL75s5OZy+u5FoRmdo67J9PrnG7LTz0fAxguHSLmgpvBFuh
	JQ9FBiEerL7uueUp+xh4GzpUpXe1JzOCka8p/wbFrSbdoTNoFwA27tJIdi8SbffrYqg=
X-Gm-Gg: Acq92OEiFubAcqkfbFVSL1na13XHB4qisNz9cso0GlwbwccF8yg1C2OlVshKbjWgG43
	prvdkeIFfqPhBo/Qc22eFSmYup1WPIh+Ou67+igv5L1UKXmcimrE46NQ+8nafAmAqew0IoBfCHB
	HPATGwdg+5EKwBz+Co9HwpAaiddkEC1T3qbpPXgtIHJlopErJ+VTc1R0EUctvn6j5EBhlBDPzXn
	8FLKC3DuUEKlwAWq1ZwQq0xNSV4UZUlGqKV1H/f/SctTdFQLME/xoHwh7ytsAC04sbiPmlHFXF+
	GlPpltJ+M5SJf8lwt4NyqkqVoVgZ/e21pEowci3K1nyJD/IH752NMgMbSO+IOcx1t48LnoZDpjk
	SoLe+OB2MgFwfZ3IxIhzimkQZIw+SPl0SbYWHg4/Z0etjIoycJXqT+b2sxfE1nPZ1qxBi/RjOaU
	VwxVJbpPqKgusVlpAbX8iPA03fD8SeVY2kuZxuAXA=
X-Received: by 2002:a05:600c:6008:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-4909c0ac911mr29067875e9.21.1780047756739;
        Fri, 29 May 2026 02:42:36 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca72cfbsm33571475e9.8.2026.05.29.02.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 02:42:35 -0700 (PDT)
Message-ID: <bf58d60f-1483-4832-9424-5e85e0e5f943@linaro.org>
Date: Fri, 29 May 2026 10:42:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf arm-spe: Don't warn about the discard bit if it
 doesn't exist
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
 Leo Yan <leo.yan@arm.com>
References: <20260410-james-spe-discard-warning-v1-1-985c02756ee4@linaro.org>
 <20260513102024.GE34802@e132581.arm.com>
 <CAP-5=fUoebOVhWvTbgkyY6erZJjbLRbRVk6oauVKjtHGGgMyaQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUoebOVhWvTbgkyY6erZJjbLRbRVk6oauVKjtHGGgMyaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/05/2026 1:55 pm, Ian Rogers wrote:
> On Wed, May 13, 2026 at 3:20 AM Leo Yan <leo.yan@arm.com> wrote:
>>
>> On Fri, Apr 10, 2026 at 12:05:12PM +0100, James Clark wrote:
>>> Opening an SPE event shows a warning that doesn't concern the user:
>>>
>>>    $ perf record -e arm_spe
>>>    Unknown/empty format name: discard
>>>
>>> Perf only wants to know if the discard bit is set for configuring the
>>> event, not in response to anything the user has done. Fix it by adding
>>> another helper that returns if a config bit exists without warning.
>>>
>>> We should probably keep the warning in evsel__get_config_val() to avoid
>>> having every caller having to do it, and most format bits should never
>>> be missing.
>>>
>>> Add a test for the new helper. Rename the parent test function to be
>>> more generic rather than adding a new one as it requires a lot of
>>> boilerplate.
>>>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian

Ping, thanks

