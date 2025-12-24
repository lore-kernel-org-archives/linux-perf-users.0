Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3C1FB1
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766576901; cv=none; b=PwO+EwrJEn1sioACLp0FUikaNMdH+W17Cphp/NR3rOui/mCcFQEutCEOhMS5DG7QAbhe6RA42LMdp0l+GL1sY5L5GzwgzZKIyr1+ve3+6ovXWtA7JbERMfw3vFnKUxdNDVry+zC5PaRbNW7sCVeZB+FtTOwlpI6XnpO9iI6QNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766576901; c=relaxed/simple;
	bh=+lmWrVRoB9NV1lG7We0TArMYCWYCFqVWUWrRovJRVsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEZo6tZ+BmlFNPQiPjq0XdODeReLJMPq6lEc3MXvxWVmXDtZbnIA8jZc7gNwOptSeV1CVS4igZqInbEZ9/F6Lxt72tOpxK6Ku9sPN/8f+W9SFob0Mx4lKV5WqwnyygWx0lStB9LnOMFjnbzs81fR4ZdnhQ03NjllGBlefLAezt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrOFOCb+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrOFOCb+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so37989405e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 03:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766576898; x=1767181698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmwJnPK0/k19zvjzfNZyD+piNt5FoQgvIZxs3BnyujY=;
        b=qrOFOCb+rUhEtXle0N+t7ynLaxalCYdFy940CkPVSvbRDaCBvXJFD+ufw1/ahXICWO
         Ceo92mY9qu6b0t1kQ5IPr8NLdx3aKVpTHLaAuMK1ReRL+ifCS9GXPmoQzwrmfRU3DPNt
         loz2ewcJm4F7vBDtXrfepg546qNqh3d/cnE4D3OrUqzlG4WXAfFLAZNTSDMh/ScIEVoL
         ptDJ765xSphWU/hCZmcADRYbsXYEg451GVCcybGMyFTr4sMq0B7dEPykxFlEL1Kc44YB
         J/zzdkKHaTAeE2u1ihG4ikhk8E0s/64RUuGPXwl1LtMOo36FvMslMve+gG3XApBQEr/Z
         Os7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766576898; x=1767181698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmwJnPK0/k19zvjzfNZyD+piNt5FoQgvIZxs3BnyujY=;
        b=JjP1jGHqQfawHt8+q9YC9lPItFbtUqXWlNYbFXVtBxNzOk89EpZCmEGbo5opnOsRuM
         lXgBI5mwpMlrS5+V8X2RTElo25hE/5HaMQSt9AH+zvG83jC28puh3Obs/6VBZ/70vtKE
         c0iPrUBmFitw0m8EeHWLgzdKRzSfqBudGchb+pY34xiVJ5Ivqpod3Wh/LfYet2/G7FZz
         rtujkpbwzis4eypVmZnveVZEfzfGtqeEZj8+jux+Ekna00lMuseNq+KWocWEKYUyNaLk
         haGRWS/HYsIdwUOhqo+GaAQ8NLs9us3Gn6gI7ZeR+UOUqDDw2/d2GJKex1fZhWngQZld
         CibQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnn44ZGSB9K9qH0ve7KNScN8YGVKoGPRwzJ5TuL3VYPrUqBUv6yOQ0zvMmIiMdYHRujbEKViLLSvLT3nTt/b8G@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPkM28uwVniilNbfs0fOL68MmMMPWCkNuUtEapGIIuRpxJ0YD
	z2bWu3ZYivd7KidffvW8sAa5ogVp0Ss020rnsqazDVktDvq4QBNw+/UXFjqibRVPpTE=
X-Gm-Gg: AY/fxX4VwWTTmDVsoscyYwYSXCigoByZhXawxK9py7TZSBb5X6c5iiT/YjcObqyc+A7
	tG/VqWWA904aUpO6Qed23mRLCfnhSpeVfzNfSJFhk7AdHcuOTtcyiHmEIoW/AVSXN3Hg071FhEE
	7LiZ3mFp5WJjq1WMCdPmQvHHv+nUpVYfZWX/gOxkhRIjNgbiQCsOt+bjhNvZdDiZ1xtg3AsE5c1
	9mDHOQqjR2a/7Op9jszWWVaLhI+yntIko2eejW5InkD69SUazCEQlt5LLDAKCKLHyJHFivI1Rd7
	FwWgvRNk3oPDcyCEGhNJHg935gfFcx58VeNJuUVMen2SeLciaC8xfWVIh+yhinM/m8rSuHG6wa2
	uU/ry6X47I+T4P8EmPUyq5wWT0jq9Ok0+yAiyvAWdenWe/9i3CrHmdIJTMAg5XKrslfPtgsgZ2U
	+v2mygfGgNJ3CeaoZl
X-Google-Smtp-Source: AGHT+IFQnxOS8Fo9ssG9yvX5CNSoShelKmbrQ1jOaq5Jq5+SpaY/9sMIMbiDZiAMgXJiLpNEz1Bvvw==
X-Received: by 2002:a05:600c:c493:b0:477:8b2e:aa7d with SMTP id 5b1f17b1804b1-47d19586cd4mr168937395e9.30.1766576898316;
        Wed, 24 Dec 2025 03:48:18 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c637sm327991215e9.11.2025.12.24.03.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 03:48:17 -0800 (PST)
Message-ID: <ef9af950-84d7-408c-8f1d-e9e75c6dc561@linaro.org>
Date: Wed, 24 Dec 2025 11:48:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf jit: close agent in Agent_OnLoad()
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
 peterz@infradead.org, yuzhuo@google.com
References: <51b38c17-4cb7-467b-8606-fae51f629802@linaro.org>
 <20251224113918.1593967-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251224113918.1593967-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/12/2025 11:39 am, Haoxiang Li wrote:
> On Wed, 24 Dec 2025 10:39:18 +0000, James Clark wrote:
>> Does this actually do anything? jvmti_close() is already called in
>> Agent_OnUnload().
> 
> I think Agent_OnUnload() is not called if Agent_Onload() fails, so it
> is necessary to release the resource.
> 

The docs say otherwise and suggest that VMDeath() is actually the one 
that wouldn't be called if startup was unsuccessful. But 
Agent_OnUnload() is always called:

  this function will be called if some platform specific mechanism causes
  the unload (an unload mechanism is not specified in this document) or
  the library is (in effect) unloaded by the termination of the VM
  whether through normal termination or VM failure, including start-up
  failure. ...  Note the distinction between this function and the VM
  Death event: for the VM Death event to be sent, the VM must have run at
  least to the point of initialization

>> The commit message is lacking any details about how this was found or
>> what the effect is.
> 
> Sorry for that. I found it by a static analyzer prototype and comfirmed
> by manual review. I think it leads to a resource leak.
> 
> If this is ok, I modify the changelog and resubmit it.
> 

I don't think it's enough, you have to actually run the code that you 
submit. For all we know it results in some double free and makes it worse.

> Thanks,
> Haoxiang Li
> 


