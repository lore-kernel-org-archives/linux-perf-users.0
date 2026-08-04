Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA92305691
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878730; cv=none; b=WosCGJgdsOYtnjAmJj9XIVXZ36o14+VSgId1lTX8e2xO5NZVyGPL9E96r79j1OtIMm03t9iQpW/6bsd1ZkJUB4Wbw3tCh/hEPF2Zto0CmKJV/qQnKxLUrMCUz1LddMM4cb+86J/uhgnVD54dtZ/Ahnmo1rgYTANX3c9QyREzjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878730; c=relaxed/simple;
	bh=huPoN5bucRUnQLu5sCfSPLzeR3X2OREye170NNUzpZQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=o1aBbrvNBvV9nbFkzF/3VU2nMdji6NqJT4FLpylkj0vV0IyTUFMCBdIhU4kISGBUS5J5HeuSlccyLQYhRLxY6O5vDo00C0fbw6Zro+5WFf+YnLjNldLfuFW+ScRrbCw/jhWU0nt8lmI4P6wqwh1WFtWFJRiBY2RCdcF92+Dr3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6TrE47T; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6TrE47T"
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4ab8b646492so402575b6e.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Aug 2026 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785878728; x=1786483528; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OoNJERa7N+ihiUvZZhE29iP6C+dCF84EVkVoe6Oj4kU=;
        b=j6TrE47TkiIUjqnqlxoibCfkMDopXAbDeHw3P8PWSxhionCIkjmotZAneHaM2R5Arl
         zq6WLxtaMGNVcFJGkYUjv+nZTiUNqA+kgflFavBQPIDM6/GaOt6TU4EvfqAjCe8Bmmll
         3l32UBCHa40KWBQBXv7DRIErZJ28LY2IZa6ckXrOZOpZQ6u4ANf2xllwhXuYYth5u9md
         2S90slRmai/s2f6MTNtUxESnZ+WBdxCaN3++F0VcX/V5O0JDn3qvwiPLE6M09bNr+mM1
         WLgdQvSoD3rtPeUNYsyIdwM9TQiCe5ch6vrCTM/f9ZQ30SkZturjP8JclHfckIJqP0Lv
         DDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878728; x=1786483528;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OoNJERa7N+ihiUvZZhE29iP6C+dCF84EVkVoe6Oj4kU=;
        b=afYY0m3hx579clUQ2bzhQDO5ymhGeH6KgRIGtbEMMejzE1CJxhtrst6qa8JzYytcXP
         JWq1o8wM4NHFo7+64N/slGCapmOmGxtWbQzvuuSBNv9l0XZMN4AATMZj1VkaaiS6PcEz
         tIr4CfsG8k6MW2XRvwmuOhqtuHMxC8Xbn0c6n1dB4NTvpi5ivtZEUOLPWkhVAImTbGoa
         xbUBv06o9gDoTONAdeogCCLsbv9ht2e6+CdWxxAUGkYGEcZZXFyNXrTyn2wM7+otc1yA
         2ZLJ/OmYWDt+9DLPjI/FkHRid4igNyzCuc+y06i5/rVBSNEltj1FmhRSR/oHKavoZb58
         S+kA==
X-Forwarded-Encrypted: i=1; AHgh+Rod+r29Hil6kHNp0E1nL7yzXNrOjVBl9Z/csTP6CtM4dSl7Xq4FeHnspwRcxEoLnUCtYVQ97dFtv58epxUPKLHB@vger.kernel.org
X-Gm-Message-State: AOJu0YwFP5+U+uBvesHrKZ+Xo7GW7HnqNrLvbLbzc0O6WzUWQS6sYSYN
	V/bsDNi5hcKMa4vY2CVN2JX/YVp6bVenM0ao4u8CqZyP7kE3gh8vB8cyDGjT7+4JOaLZnyCK7f/
	/LEFzRt+g4dLoZCeUa4E10rGt/Q==
X-Received: from iobmp17-n2.prod.google.com ([2002:a05:6602:a2d1:20b0:9ab:7c1:c30a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3986:b0:495:f85b:d08f with SMTP id 5614622812f47-4afadfd7dc5mr1041308b6e.18.1785878727621;
 Tue, 04 Aug 2026 14:25:27 -0700 (PDT)
Date: Tue, 04 Aug 2026 21:25:27 +0000
In-Reply-To: <b8b1fbe4-fb73-418a-b43d-086894d31ce8@arm.com> (message from
 Robin Murphy on Tue, 28 Jul 2026 16:07:44 +0100)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntpkzxvarc.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 05/21] perf: arm_pmuv3: Check cntr_mask before using pmccntr
From: Colton Lewis <coltonlewis@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	james.clark@linaro.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Robin, thanks for the review

Robin Murphy <robin.murphy@arm.com> writes:

> On 12/06/2026 8:28 pm, Colton Lewis wrote:
>> Check cntr_mask before using pmccntr to ensure it's available. With a
>> partitioned PMU, there may be instances where pmccntr is being used by
>> the guest and will be absent from cntr_mask.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>    drivers/perf/arm_pmuv3.c | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)

>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 1cceb1f614515..17bb1cfdc271c 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -1028,7 +1028,8 @@ static int armv8pmu_get_event_idx(struct  
>> pmu_hw_events *cpuc,

>>    	/* Always prefer to place a cycle counter into the cycle counter. */
>>    	if (armv8pmu_can_use_pmccntr(cpuc, event)) {

> Something smells wrong here - we can use PMCCNTR but we can't?

>> -		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
>> +		if (test_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask) &&

> ...i.e. this test would seem to belong in the helper function.
>> +		    !test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
>>    			return ARMV8_PMU_CYCLE_IDX;
>>    		else if (armv8pmu_event_is_64bit(event) &&
>>    			   armv8pmu_event_want_user_access(event) &&

> Plus it also doesn't make much sense to fall through to the "we _could_
> accommodate this event if only PMCCNTR was free" case here if we know
> PMCCNTR can never be free because it's not even available.

I agree it would be a good idea to refactor these if statements.

Probably something like:

/* tests moved to `armv8pmu_can_use_pmccntr` */
if (armv8pmu_can_use_pmccntr()) {
	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->used_mask);
         return ARMV8_PMU_CYCLE_IDX;
}

if (armv8pmu_event_is_64bit(event) &&
     armv8pmu_event_want_user_access(event) &&
     !armv8pmu_has_long_event(cpu_pmu))
	return -EAGAIN;
