Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891449;
	b=rMSptrHTH3+6JfhKC7RM17Di1xivwVl6JqOJySZlXFMssmyYLVHAM5iJ8oBMu/LtSauO
	 lTiy5jZIP8SlAs1U0fECsBWyZNIfBwObwpmnXYwREwl1X7Vdskbz/u5TkJ+kED7qjYjWk
	 dFt2yhg5fGMAubbPrjK6S1y18Ec+xVTG58lVxJcGiG/ks06tyNEU3ruC2GUjTpkdEhMPk
	 2M2Gwpg8W6TD1aTSpkwvieoCq4ac1A659Jbcj4lW9ciDblh2PZingGGKdZvwVcdvgeyZl
	 64W6LF06c/1FeUm+S6wLWpGNDYRBPEqb7mJhMOHO0x2ukIw7VZS6miA+T649Tp3JYrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xF2MyCPe1SO/SsRhlDuDyRpsUTowZ9eaIobnWhahWMM=;
	b=o6Ykg36VJCLbx3pw1y+cNHeoLK04Y+BrzBz3RjokB88Op8tK0N10IX3w4c1LA0IlZp8s
	 rQS/Wx+RUUnfuyeGkyZt/BftsfYhqF3SFGVHc7+RzeDITBBo40udZN3OnPeuIzfGalRvN
	 cT6oqA0fIPZBh7GYKSGAG+WnAWO5qhCnkYtMNy/j2IdcLOTCYaqS0iIXlVdxGaJwqxFni
	 KsvImid/dX8Sqj7l6WQ6nssXVvAwYU62X+wdsvLbd054wWUzJFAVABDL3KcgXQZTuQbGM
	 dALAXFvxsns4QAIYE3n+TDy64apZio5pyOtm3ksar8EcDm6qW7Pt1c6MZmqU4sGzDkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c9iPqoR4;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02120606A32C
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 15:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02120606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c9iPqoR4
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a215e64962so18979375e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793891447; x=1794496247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xF2MyCPe1SO/SsRhlDuDyRpsUTowZ9eaIobnWhahWMM=;
        b=c9iPqoR4i2lU4A7xlKx39/EykYZWlgSIgjSKBV39DrsJnL0vLz2kjB/P0sqI3+j6or
         5bGEoX7xJXJOvg7Ign0tCZGTh2KkQUgZiboADtKYk/dm+T9jcudH4kZIcEbek+V+oZqO
         HB6wCgdOGNNw/26rqnVZiL8Bu4m8ba2VV5CCMEqv1rUhE/9QzVyJeItfpKD7h1hLOE2G
         bLp6CM1Z64s+7w0bn73ag9ezPHyZIePIOqYnXN89KNg39cZxGKWKfFahxAeDt0ZtvGUU
         SXayBvs7GqshctvcGKF9YmlYG5Lnf/VuD4fNfl0BWu1L1j9tREM6cgGD8st66a5ySJvr
         tFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891447; x=1794496247;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xF2MyCPe1SO/SsRhlDuDyRpsUTowZ9eaIobnWhahWMM=;
        b=uj6bEgMdjXtxUXygGMvsm8amRRmgDIxnDuFDAceXHwrXOY2yLOBoFMYeeLdtxpGbTq
         jDdfTJ+usgJ2P1o8Z1+e2WQb1cpSU7pVIcU9cEuVb/XBYoxAy/8Qk40+Ao5J50NyBmeO
         VSx6GvZUi5jipMZ4CT2Vq739i1t4rBA2RNHqwhLEdEE5cw26ZPFOg7l940r8Nxvo4CZK
         eOtIuzIl2+R6qwyUF5iHw4Wsv+Ngg0jDEMEK18/KuJVKB/KnmA6ON8IoiBTuYpOgMxES
         72PX7OrQK+L1t3ZCTroY9A3Imsd+3PFfPGIwA3RzUbCupbDyuzIefiV9+BfplIqssr2H
         k3nA==
X-Forwarded-Encrypted: i=1; AKwUvByCMhukYS411O5+p49ZI6GqcIvtlAXZGGvzzw9IgudpglPCWQ2BukGtt3Mf6TMCYY5ybzE829wUmY4Z1rEoUXCb@vger.kernel.org
X-Gm-Message-State: APuU4Z/ryp1AuXf0IHjvwKRNc/JOhIF4t+Wl0pdBGtjpDngoueNLOSFR
	17JfvZp6IP8Ad2z6JaEC778gRDlfHa3znfgpMnYp5CwJkBeCwWez24tL74FI8dMgYmw=
X-Gm-Gg: AYBFou3TYmpsEf6eGYsD1gJI8bphwIu/6nB1j6qpRNEwI3TeMGRzjpZ7ucPjTLWTsBQ
	eN7s79Ep4V4vyS+did24WA82WbAbtR+awu/8/nW6ULh3DlbH/pxBTZ/09HVTYtofKu2TtlYXTpL
	B+EceQUOADKrkc9FXeFhRhIrpad8GmYanWrmOx1RdbInRre6CGwgVLGjfuWMPkfTKpyh6NLAamv
	osPz5B9YwmU+dn6TpO3w1dSUdh2xQ/Z3lIsG+3k5adeXercQ/vJnNsZPdsQ6r107HKzAlO/0GV2
	iXEXSN5XKX4TSI1Y+oFFsMmABubcWOho2vtNyxtLuG1H23V/110Y+TWYsCHYp9GVCj4B8rxYZUr
	BIRXAdDA3WWalYUnS787e5dKU4EohoQ+SyKHUbtIpW0dmk/3R4MH6SkEtW37xu11eWw4rSkebuT
	OMnekVJV2roZoDtdlgFeTSLDjAaCjNkhMr65454MLrPV7dd/MWmRstiNpM4wRArJBv1d1c/VdM/
	fdje8et3a9zN2+8gY/j5McVBlPqNNJ4yKk80/IOzFKsY559PzlrtdvsOjicatSCKFNbmSd3j3L8
	HEw/QHR8fCOA2hsKxuCX4AMFLqpBA1weJlN+o15FM5iayyDuzI1R/w==
X-Received: by 2002:a05:600c:4752:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4ac18e5d4d0mr449585315e9.29.1793891447318;
        Thu, 05 Nov 2026 07:10:47 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e58fcc6sm132091435e9.2.2026.11.05.07.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:10:46 -0800 (PST)
Message-ID: <f7b19834-dc88-4431-a383-4b73edc5dc4d@linaro.org>
Date: Thu, 5 Nov 2026 15:10:45 +0000
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
Subject: Re: [PATCH v4 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Amir Ayupov <aaupov@fb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Pereira <danielmaraboo@gmail.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
 Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <23ffe461b8d7b04f78118154dfc9ea1d2a14978a.1792989860.git.aaupov@fb.com>
 <a876b77b-c4e4-4019-868a-af12c93f441f@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <a876b77b-c4e4-4019-868a-af12c93f441f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/11/2026 14:54, Suzuki K Poulose wrote:
> On 26/10/2026 05:48, Amir Ayupov wrote:
>> Drivers outside the PMU driver may need to know whether the local CPU's
>> PMU implements a common event before relying on it, for example a trace
>> unit driver checking that the PMU counts its external outputs as
>> TRCEXTOUTn.
>>
>> Add pmuv3_event_implemented() to the arm64 asm/arm_pmuv3.h, next to
>> read_pmceid0() and read_pmceid1(). It reads PMCEID0/1 on the calling CPU:
>> events 0x0000-0x003f are reported in bits [31:0], and the common events
>> from ARMV8_PMUV3_EXT_COMMON_EVENT_BASE in bits [63:32] from PMUv3p1. Move
>> ARMV8_PMUV3_EXT_COMMON_EVENT_BASE next to the event numbers in
>> linux/perf/arm_pmuv3.h so it is available without CONFIG_ARM_PMU.
>>
>> Suggested-by: James Clark <james.clark@linaro.org>
>> Assisted-by: Devmate:Opus-5.5
>> Signed-off-by: Amir Ayupov <aaupov@fb.com>
>> ---
>>   arch/arm64/include/asm/arm_pmuv3.h | 19 +++++++++++++++++++
>>   include/linux/perf/arm_pmu.h       |  1 -
>>   include/linux/perf/arm_pmuv3.h     |  3 +++
>>   3 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/ 
>> asm/arm_pmuv3.h
>> index 8a777dec8d88a..acd62c4f16743 100644
>> --- a/arch/arm64/include/asm/arm_pmuv3.h
>> +++ b/arch/arm64/include/asm/arm_pmuv3.h
>> @@ -173,6 +173,25 @@ static inline bool pmuv3_implemented(int pmuver)
>>            pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
>>   }
>> +/*
>> + * Whether this CPU's PMU implements a common event, as reported by
>> + * PMCEID{0,1}: events 0x0000-0x003f in bits [31:0], and from PMUv3p1 
>> events
>> + * 0x4000-0x403f in bits [63:32], which read as zero before PMUv3p1.
>> + * Must run on the CPU whose PMU is queried.
>> + */
>> +static inline bool pmuv3_event_implemented(u16 event)
>> +{
>> +    bool ext = event >= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
>> +    u16 id = ext ? event - ARMV8_PMUV3_EXT_COMMON_EVENT_BASE : event;
>> +    u64 pmceid;
>> +
>> +    if (id >= 64 || !pmuv3_implemented(read_pmuver()))
>> +        return false;
>> +
>> +    pmceid = id < 32 ? :() : read_pmceid1();
>> +    return pmceid & BIT_ULL(id % 32 + (ext ? 32 : 0));
>> +}
>> +
>>   static inline bool is_pmuv3p4(int pmuver)
>>   {
>>       return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index 02d2c7f45b527..792283d29d7b5 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -124,7 +124,6 @@ struct arm_pmu {
>>       u64        reg_brbidr;
>>   #define ARMV8_PMUV3_MAX_COMMON_EVENTS        0x40
>>       DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
>> -#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE    0x4000
>>       DECLARE_BITMAP(pmceid_ext_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
> 
> Could we not avoid this change ? Or why not move both of the definitions ?
> 

I don't think you can avoid it unless you redefine it. But the place 
it's moved to has similar event number definitions, so it seems ok to me.

Moving both makes sense though.

> 
> Also, I would need an ACK from the arm_pmu maintainers to accept this
> change via coresight tree.
> 
> Cheers
> Suzuki
> 
> 
>>       /* Only to be used by ACPI probing code */
>> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/ 
>> arm_pmuv3.h
>> index d698efba28a27..c21f185a283d6 100644
>> --- a/include/linux/perf/arm_pmuv3.h
>> +++ b/include/linux/perf/arm_pmuv3.h
>> @@ -78,6 +78,9 @@
>>   #define ARMV8_PMUV3_PERFCTR_STALL_SLOT_FRONTEND            0x003E
>>   #define ARMV8_PMUV3_PERFCTR_STALL_SLOT                0x003F
>> +/* Base of the common events reported in PMCEID{0,1}[63:32] from 
>> PMUv3p1 */
>> +#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE            0x4000
>> +
>>   /* Statistical profiling extension microarchitectural events */
>>   #define ARMV8_SPE_PERFCTR_SAMPLE_POP                0x4000
>>   #define ARMV8_SPE_PERFCTR_SAMPLE_FEED                0x4001
> 

