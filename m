Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4F443E2F
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192715; cv=none; b=ikniNr3e11XDrAIiEYBA+tUNRQpVY/VEoQu5kO4vYqXDLg+C0yngoOzWeBxBjlvmlqusE1SCc+PoBMPdNuMuSAQzd4pq48H+a6u9c+vYsMhFMnlmOII6YY37IizSAX8kCoJQyhIjb4jssEQd6iixcPFxPy4HiQcwYcWDezWl/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192715; c=relaxed/simple;
	bh=Ane+bsiS8GQAApnlKO324S8NnqoCU6uZtPzlLeDK6xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=equG2uyjgtn2wVfOP/p6cVGWsNnuTVJrd9BDryNGbwwVoVvsIRzY02sSQ9B6tQrVpDYJuPBI6wDdb2Ohuj4RcCCXLCpXj/Bdu16ce6Kbuz/h0fFvX5jIqZujBg+no1WpBvwMMwSsf/dZxBGThcJ2jlAefge+eg95eCwou5ncepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ki168ysh; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ki168ysh"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so104973366b.1
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Oct 2026 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791192711; x=1791797511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jj8juTRF8BNg42eLql4dmeLHvm0zqwKNTWAupdQfKl8=;
        b=Ki168yshyKSGzSdfK6DceYLGGMJgjYBk7pO5okfqxEbtHirexNpz8wVhxqIl9bS/Hu
         4lU9+PV2jDaGnu6m2aIVDyvFqIulSU+4FxDBgpsFDOxRT5SK9N8DiK9nISCRl8pTmYzX
         CcdHVz1yuaSegiEyWlII/5HtjB7OvjRA/ZTEWfWECTm/w/jfEANJM/5BsO3Kj1SrnleC
         ja0tQLX1MjKXUbzTpNQr+gX9h2imX7jG3BhDL7/kf9CgC9WL/4xWlFKidjvQIUL7rGtL
         2uKxXClbd1c6T9XuLIBrCpi1Od4qcet/iHaT5aT/zIKRGKmoKB9nHmobOD36x8DrnU/q
         DjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791192711; x=1791797511;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jj8juTRF8BNg42eLql4dmeLHvm0zqwKNTWAupdQfKl8=;
        b=m0isOmezsOQSyPp6DIDQAc2XUHdz8K048pISFcMOHU0Mc5TrkxiHoX1/lX4t/qgFv6
         ml5tQEs9ckff0sjyAYaD+mgWe/3stq7M0ezBGcWf+XnlTSAp3+wJ3NMIFEzj5JXSYTQa
         VGbCCS04WwxCwmbAVm4I6X8M8k/sKLKZwrlzAe44pk/Box72MmLr0Fp1VPLk6cAKbKvX
         +uX8pzW9t6LcJbr7lNrgBnhlJmT38dTc9CLQibNmoCjKl5bwkdu9uar6b+9iLKIi6Zh9
         gJAoOvhdH2QiRlKEwJqRYSOlfzsGbVfkh+lmRa8ZLDRMrvPt130NNNrHM/sonbvEIr2Y
         XDMA==
X-Forwarded-Encrypted: i=1; AKwUvBybD/ffqbV+hXJc222eHk8VzkITEnDr/yuSccPVOEBqe3YGHwITBk4I2Sc1XoHI/GCKU7iAoo6aq7orfiZ2H6MV@vger.kernel.org
X-Gm-Message-State: AFuF++mqmNEfCsjmZUUnn4Xxa/irWqAqDYYgD/3bxepbZCS7+w07FBo8
	LlxJgK/rVequ5KzfOMUJtPU3RrgiiBQcM0abP/0PEA6cssKNJXMQDGPzeLHTl9MVvVo=
X-Gm-Gg: AYBFou0h2iU7xP4Lvps1bWJDvZEWWyUm7fmswSj8seWYycmWc1vVhCO70ckOWem2jh2
	hi3CLwLDOOgXdwKqNRluyirI5hIQLyMdhu1Sh5sZCWpLGAIkiXHdZyzYLOgCIpfp17NQHSJbLss
	AaMDVHUTpBWUkpSerG6evpUS7HMiRAxwgC/nTF53GNLbBz47Z4sAQSoBG5MYXqjIj60vNbZeGpD
	JkePaj26hfx5AjGfDtujGi9mZrep2Q+tzXmI4kRw2y0Af8Zs+o9R1Q6msWmD5cRR42F9gDigSz0
	OvjfHEvuQ4LTYbL79YUDOvH/CV+WkCS8j4EsOx460pkNd1os2th9ODauAl4o6wjwE86RWP9VxrZ
	CaS1gZNIWDGTZnku/pYe0x9Brv7g8m+zjCO+7xwgMRiPrBkz5EipwD6jYQCdMClY4Rjk35xbR1q
	KQF5KLpNXYSb0PZK+dMe/psWcCPVX7Vn617KlhURSNDAP6CbMyfFRp/zeZO4/4a1/j/D6rhtYaH
	4Julql+necB9Q==
X-Received: by 2002:a17:907:179a:b0:c2d:c6e7:9e9a with SMTP id a640c23a62f3a-c2e4aabae2emr924547566b.11.1791192711132;
        Mon, 05 Oct 2026 02:31:51 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3155ef11b9sm49533566b.0.2026.10.05.02.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 02:31:50 -0700 (PDT)
Message-ID: <9c5e1aa7-4e0f-4576-b322-b4594cdea5b0@linaro.org>
Date: Mon, 5 Oct 2026 10:31:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf: arm_spe: Factor HW discard mode out of
 arm_spe_perf_aux_output_begin()
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Leo Yan <leo.yan@arm.com>,
 Suzuki Poulose <Suzuki.Poulose@arm.com>, Al Grant <Al.Grant@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
 <20260805-james-spe-software-discard-v1-2-0ff0e44c4c92@linaro.org>
 <asNfh-qywjOPxajj@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <asNfh-qywjOPxajj@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/10/2026 09:27, Will Deacon wrote:
> On Wed, Aug 05, 2026 at 04:01:52PM +0100, James Clark wrote:
>> Discard mode doesn't call perf_aux_output_begin() or emit aux records,
>> and enabling it never fails. We'll add a second discard mode in the
>> next commit so it will be cleaner if there is a separate begin function
>> just for discard mode.
>>
>> No functional changes intended.
> 
> [...]
> 
>> +static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
>> +				      struct perf_event *event)
>> +{
>> +	u64 limit;
>> +
>> +	limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
>> +	limit |= PMBLIMITR_EL1_E;
>> +
>> +	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
>> +}
>> +
>>   static int arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>>   					 struct perf_event *event)
>>   {
>>   	u64 base, limit;
>>   	struct arm_spe_pmu_buf *buf;
> 
> Is it worth checking that we have a discard event in begin_discard() and
> similarly that we don't have a discard event in output_begin()? It looks
> like quite an error-prone interface for the caller, otherwise.
> 

Makes sense, I can add that.

>> @@ -775,6 +785,12 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>>   		arm_spe_pmu_disable_and_drain_local();
>>   		break;
>>   	case SPE_PMU_BUF_FAULT_ACT_OK:
>> +		if (arm_spe_discard_mode(event)) {
>> +			arm_spe_pmu_begin_discard(handle, event);
>> +			isb();
>> +			break;
>> +		}
> 
> This looks like new behaviour?
> 
> Will

I just extracted the discard part of arm_spe_perf_aux_output_begin() 
into here and arm_spe_pmu_begin_discard(). The PMBLIMITR_EL1 write and 
isb() should be the same.

Do you mean that now it does arm_spe_pmu_begin_discard() unconditionally 
before checking PERF_AUX_FLAG_TRUNCATED? Truncated would never be set in 
HW discard mode, so it should be equivalent. And the IRQ would never 
fire anyway so we don't get here until SW discard is added, and even if 
it did, handle->event is NULL so the handler would exit on the first 
line anyway.

I suppose there's another change that it can never call 
arm_spe_pmu_stop()? But that wouldn't have happened in discard mode either.

James

