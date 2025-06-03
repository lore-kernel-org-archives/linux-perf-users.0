Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9628369A
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944230; cv=none; b=S0S5ZCt3S1/U7a2SB6fMRsgaggB1jUELNN5f4/0IYyCOOfOnN7LPs/DGUwkosye7lEMIEBnd5LnDx5Ovb74nryVMqrYhcp1Qdm/6qq8oLcPxt+nU1lh32i13JiCzuhH9tsRZc758+J3eUD0Qr1y5tFSTBk8Mny8zs8Kox40+mQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944230; c=relaxed/simple;
	bh=cYofdeohFRtCrlrs30kGtQgAlnzJghGw3tFBSu52gXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRLhohs6/ECj3Osp9BHK2AuiKXvICet8UqaSQYIu6iZyHHsoCTDVygEi+ewrgPsc+BzuBA5MlFAp9BoAF5AvwMeQJjepRWIBzq7nSxD5CjYfvasVeNzj+Dte5IWRMEtT+CIKTd4JDUIp1SrTBmsQ9UXFvEsiWpWP4wyLKaWe21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NjiOKPQD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjiOKPQD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375888297so3204944f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jun 2025 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748944226; x=1749549026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTiUXP9qqpwePncWUOCrudvn6ikDCRoeniFYV5C54HQ=;
        b=NjiOKPQDlT6MnFwQx9uTIPQmWBMWRPdZlu/lgZdmBoHwNCx6v1eS4FM2gZ+nSwtL/O
         FVep63rquqH5qPd+2WS5bOI2vYu5K3S0wn8Eb7ccdo/CEgeFwXouR3QX5JlKpyaXMIyF
         AEXmnYhuyvWzRNWLbUn5grpmPFLlbosiKeIExZwCP+uzAT9AL6O4h0FaNEIO8srQcn5t
         VUYQ25kkFz7DWqPY8GmTt1VDlxHQkCl5r+eW0Txe+W+sohDRwFYuL3OrMrRrXadCyO0e
         WIo4yWDWzmzRl0+jlGX5hWeCv/swOjzBxhgT+2xsQCihz8G/kqABs1IcBeeuPzCPnhQu
         Bplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748944226; x=1749549026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTiUXP9qqpwePncWUOCrudvn6ikDCRoeniFYV5C54HQ=;
        b=YfhlrzLEua8Wwv9Hxzkct4Q4DkGwRkX6LWtZvnaPg4GcDVFRbCt2RYr05Mf9qE1OuB
         JFfbiEKxfh10DYq6r/36pVvyN/5HbYEjeVGSDFC4QN+0dR8d0oYROaZYTqX9wFBTVTjr
         6ulduXq8aMHOWziiC1UZ2uy7eTf4z/+RnR3KSIHJhZlK0yGtvyw6p1CcQ5u0O5Z0T9Bx
         iuXE4kYPPdVhFrPoaNHcd3gBToBt14uVgnOmrPUwBuXg+1jTMsp86KtBnzJ9hWOUSCe5
         hNdFrRweKS5fPiDBj89Nlg/tmCuZuIm7qaWThYra9l76rTfm/FR7DcDS58mFNZCX4CCg
         Pr0g==
X-Forwarded-Encrypted: i=1; AJvYcCUq70Tbx0w0wELX5yztchY4rnyC3OXumrx8lSorz/jFhp1N2jhkLpstrmEpvm7QMAqfg19vzprwOZ7ju/vDgZtw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Ae/LhzGtDYpn2EfHV/UFoo4qQ3mGWP+GGXHCuw84ERfGEEia
	zBnCPOlQ27BCouz+6wnLf/9Aat/UZVBqDDMHIPAZJTC3arnkWcOAFezo9/GbsteVqqc=
X-Gm-Gg: ASbGncuSJASS6ujlE5dqVblrfAiewovXBvSNrJDBiun46LJeEVHVX30MYZbroX8/rZW
	4K8MZaq63KgS0yN7p3CaWW+fpuiRLOe65C3/dReKnFOCkn/yOq3NYX+52TgN0Iz9rs1CMU1eFFo
	imXSkVmPot4x55jj6umeMNBts8HQ4mhobQy4CzjnJITm4uL7KJwc5P+f/TF5RM7njtc3JW+LwIK
	7v7w7MTVcGMA8ubOD7pDG0bARHTL1Q24eOI7yDBDlVuiYAB/xWJDT080cinA6x8Fkt+/Ac1Jf4D
	IdavpuyElRij6QFcyTkkn9OgWMCyjuVPJWhxBoPWr+B1L3l5Va6zVar+
X-Google-Smtp-Source: AGHT+IHsW44MmqwfDKjzghl/i3BzuGEINgERerQaDbyP3gu7SUf4muuyytvtJbMK7SPgP194SuthmQ==
X-Received: by 2002:a05:6000:2892:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3a514502388mr1696065f8f.23.1748944225608;
        Tue, 03 Jun 2025 02:50:25 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c9d4sm17906246f8f.38.2025.06.03.02.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 02:50:25 -0700 (PDT)
Message-ID: <2fb1965b-bef9-4a8e-a1c7-c8a77d957b23@linaro.org>
Date: Tue, 3 Jun 2025 10:50:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] KVM: arm64: Add trap configs for PMSDSFR_EL1
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
 <20250529-james-perf-feat_spe_eft-v2-6-a01a9baad06a@linaro.org>
 <867c1ze4pg.wl-maz@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <867c1ze4pg.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/05/2025 5:56 pm, Marc Zyngier wrote:
> On Thu, 29 May 2025 12:30:27 +0100,
> James Clark <james.clark@linaro.org> wrote:
>>
>> SPE data source filtering (SPE_FEAT_FDS) adds a new register
>> PMSDSFR_EL1, add the trap configs for it.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   arch/arm64/kvm/emulate-nested.c | 1 +
>>   arch/arm64/kvm/sys_regs.c       | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
>> index 0fcfcc0478f9..05d3e6b93ae9 100644
>> --- a/arch/arm64/kvm/emulate-nested.c
>> +++ b/arch/arm64/kvm/emulate-nested.c
>> @@ -1169,6 +1169,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
>>   	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
>>   	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
>>   	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
>> +	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
>>   	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
>>   	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
>>   	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 5dde9285afc8..9f544ac7b5a6 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -2956,6 +2956,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>   	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
>>   	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
>>   	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
>> +	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
> 
> PMSDSFR_EL1 has an offset in the VNCR page (0x858), and must be
> described as such. This is equally true for a bunch of other
> SPE-related registers, so you might as well fix those while you're at
> it.
> 
> Thanks,
> 
> 	M.
> 

I got a bit stuck with what that would look like with registers that are 
only undef in case there was something that I missed, but do I just 
document the offsets?

+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -87,6 +87,8 @@
  #define VNCR_PMSICR_EL1         0x838
  #define VNCR_PMSIRR_EL1         0x840
  #define VNCR_PMSLATFR_EL1       0x848
+#define VNCR_PMSNEVFR_EL1       0x850
+#define VNCR_PMSDSFR_EL1        0x858

+++ b/arch/arm64/include/asm/kvm_host.h
@@ -596,6 +596,16 @@ enum vcpu_sysreg {
         VNCR(ICH_HCR_EL2),
         VNCR(ICH_VMCR_EL2),

+       /* SPE Registers */
+       VNCR(PMBLIMITR_EL1),
+       VNCR(PMBPTR_EL1),
+       VNCR(PMBSR_EL1),
+       VNCR(PMSCR_EL1),
+       VNCR(PMSEVFR_EL1),
+       VNCR(PMSICR_EL1),
+       VNCR(PMSIRR_EL1),
+       VNCR(PMSLATFR_EL1),


And then sys_reg_descs[] remain as "{ SYS_DESC(SYS_PMBLIMITR_EL1), 
undef_access }," rather than EL2_REG_VNCR() because we don't actually 
want to change to bad_vncr_trap()?

There are some other parts about fine grained traps and res0 bits for 
NV, but they all already look to be setup correctly. Except 
HDFGRTR2_EL2.nPMSDSFR_EL1, but it's inverted, none of the FGT2 traps are 
configured currently and PMSDSFR_EL1 is already trapped by MDCR_EL2 anyway.

Thanks
James

