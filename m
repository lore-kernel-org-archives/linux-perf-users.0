Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA5329C7B
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771509091; cv=none; b=H45m73lhF0qRm45YacN1uULoOEsmP5oyhi87q+cv4T8NAyT8Zi69vW1GPSgbue+9M4T302tZ7a5sAUxJ9K+uZSQDcGu4bN4rImVeCO0oIdK3Sk/85OGmMQnyeqSm1w+Lry0juDYhaWQpsQNkQXDwrD6l1QT0gZYkI3lu9cUOu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771509091; c=relaxed/simple;
	bh=Q1N5oRG6zUyA/BKhCvdB42zsDGhd8TvkV9AZnswBR6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcS9XGq5gNPPoxA7AzwEd1pyB2GYWb9sK+Ui0KAOdHxH8kOKBbe+dY0FiG8zSjerR0aQaqqg/2FNDpl98OMy24kx4NEAfIGfVFq3DTe1wWmjqGgDQFbWanWpLPRQPpfQ67p0mTL1MvyKDjVJtMXVSirkDwm0UuUq69JY+gOYGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldLVCcDh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldLVCcDh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso7594945e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 05:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771509088; x=1772113888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMeYVXWn4rNsdtLa5RrkjJUCcdAtFa2v3GVS4ivXFT0=;
        b=ldLVCcDhismGfWFrKgHlqsz/BhcdQAp+9SWTWFUZgbDWh2Y0xXXJzl5dnms6VPf0lx
         eBZNwDPbhWjb4v/UL5rLqgl8rlPVJShH6XMNcxYPgrDwWdQ5T7B8UGHlY1reUD6ME2xs
         ato2aRP4rxO7QDpZ0fYJ1ikvD+NqMVCtdWJWZGfpb10ft+w1Ol6llIHktdKdAqK/BmBc
         D028bPS4v9x6BxKHSGmUzfhG/2I90A/P2KwsYpy03aPjq+E7PcjSC+Bnz81A9EqUOWA3
         nKTy48OlYjv6PDyvN6LReYXmdtHIhZ37CWKxGSArWXxVxZXwmK2+LfUFfV0rZVeXLsp3
         I8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771509088; x=1772113888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMeYVXWn4rNsdtLa5RrkjJUCcdAtFa2v3GVS4ivXFT0=;
        b=Y+kM92iuEjkcKfAcJNO2VRAY+CjlxxF3wIVIN9pwkZwE2SGXNQLm7qu1V1Rl6POQKz
         BPNxJv9xws3xRoLsTlYhCp6YJ3YcLMwRS01rzibLTTpAidw4kdWPdawTOjSoi1sVXMX5
         cTOBbl/fR8Y+kqszmJHEPkrvts1xl9q7UI3UG/mvIXouPPNcRUaCl8naMMLuL25vZyxR
         ZTVMELmbiQhQPOu1yz1je54oY9htcFvlrpBUdSD6cxQwdQOAzFiGcoX3YWtiiuASA8Gg
         aLnl8UlV6FZScbXsR/gkppY+XFZpfFq2XUA9RpfpYg0O0FkJMozz8yNcK+kZIOomtIsG
         qzJA==
X-Forwarded-Encrypted: i=1; AJvYcCV5G86jVMbC3mrX6vSikSutWlUYz6kSsQuWqbw+gNPNPUKWejXgdb+BUpuWyf8xB8oRVHosUCYHGUZ/hZpkxf57@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwoScePuNzRmxdUjzmgVfOK5vwXM0mm3yS2YfU6Dkb7EWglVA
	vgocOcSQgBqqRrZG3HaiwsxzP9yYxom/TSKFNXPHHD4JJ/5ZqZzmtxnbPcfSe4gke/E=
X-Gm-Gg: AZuq6aIB9rdqMZc2pVNTJMQQ6ry/fc9dL9eDsvG8n8KA+YXuUrkUkClY7UcJk/i4SlJ
	R7Ihx5lkWn6CXJungzsSeHXdLAzkcIrNKhZuhD62i5eZZITeVKIqtAry0Ch+Pm2NBOIoppGRgt7
	QBy+OKY3oeswGMRkPJD24fikw/HjTWO6+A/6cXsfAH2q/TjIWViZH1YVKQd7RLzAgTyVXXLqKXO
	dVGCTkzGu7NLMFxLGIIJ3LeVaKLZy+n2PUR96uB+oWnDPnnTWoH0RbVajzWtxgKvkXNXAkXg8Ea
	6GOcMqkInDdrIWez6lcnbAil0KxkJWkW9jIPF1PYt/njNsGwO355cxCp1SG2iaqak50um1wF+6v
	eOXLj99wri1tAw2lxDVudGKfHqa+p05eKvHrqwEvFWXfEsCCCXkrMHhCJFoicV8VX1NUzvfUzZe
	toGgHfUZEhlm2wDzg35G4S2jPqhnYu
X-Received: by 2002:a05:600c:35cd:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-48398aefd55mr85918085e9.36.1771509088528;
        Thu, 19 Feb 2026 05:51:28 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31d82a8sm5742475e9.15.2026.02.19.05.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 05:51:27 -0800 (PST)
Message-ID: <7b692e5c-d376-4023-80e0-76c9d9c0604f@linaro.org>
Date: Thu, 19 Feb 2026 13:51:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Will Deacon <will@kernel.org>
Cc: Michael Williams <Michael.Williams@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <aYD08d42SewAAQCB@willie-the-truck>
 <aebe99ad-1189-4372-83e3-385f33829bd2@linaro.org>
 <aYHXCkFZcVm1L_25@willie-the-truck>
 <e7d53952-59f6-4990-83fb-1182641af29f@linaro.org>
 <705acb39-2eef-4e61-aec1-b9503e788299@linaro.org>
 <aZcIy1Or4c5-i7Tm@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aZcIy1Or4c5-i7Tm@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/02/2026 12:57 pm, Will Deacon wrote:
> On Thu, Feb 19, 2026 at 12:08:27PM +0000, James Clark wrote:
>> I'm back to drag this up again. So I think all of the above discussion
>> relies on the ordering given by the indirect read needed for the "might
>> ignore a direct write..." part. But it's _might_ ignore a direct write, it's
>> possible for an implementation to not do that, so there are two possible
>> implementations:
>>
>> #1 Where there is an indirect read to give the write ignore outcome
>> #2 Where there is no write ignore outcome so it doesn't require an
>>     indirect read
>>
>> For #2 there's nothing to force the ordering. We're writing to two different
>> registers (PMBPTR_EL1 and PMBLIMITR_EL1) and we have to have the
>> PMBLIMITR_EL1 write come second for the buffer to be considered configured
>> correctly. For example if the old value of PMBPTR_EL1 is higher than the new
>> PMBLIMITR_EL1 and the write to PMBLIMITR_EL1 happens first then it's
>> misconfigured. That's why we think we need the isb() here.
> 
> I thought profiling was disabled in these cases, so why is it
> misconfigured?
> 
> If it is misconfigured, what can go wrong given that we're either stopped
> or pmscr is clear?
> 
> Will

It is stopped in the interrupt handler because PMBSR_EL1.S = 1. But in 
arm_spe_pmu_start(), PMBSR_EL1.S = 0 so it's not stopped. And with 
PMBPTR_EL1 still being set to the value from the last session it could 
be higher than PMBLIMITR_EL1.

PMSCR_EL1 doesn't affect SPEProfilingStopped(), it's only:

   boolean stopped = (PMBSR_EL1.S == '1');

The conditions for when the buffer needs to be configured correctly from 
R24557 are:

   ProfilingBufferEnabled() && !SPEProfilingStopped() &&
     PMBLIMITR_EL1.FM != DISCARD

I think even if PMSCR_EL1 is clear you can still get a buffer management 
error, even if no samples were going to be written into the buffer. It 
just says:

   While the Profiling Buffer is enabled, profiling is not stopped, and
   Discard mode is not enabled, all of the following must be true:

   * The current write pointer must be at least one sample record below
     the write limit pointer.




