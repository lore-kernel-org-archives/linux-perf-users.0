Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734B12B83;
	Mon,  3 Jun 2024 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717391584; cv=none; b=oCxtASpHBTPTOz3/xauWJ10Hxs4nhNOHdh6mEtQwsisWy1QR1hZ1AVBYTundVnt0SP178Cjtr+jUoGUtzib5tgOtZZ85rfNP4TjP+Szafrkc1D79Hyz+sxtF/mmM+88EgJV3bwDRlJoCgyKf/QMD2Mqcf2UtAohhn1kTyuFnu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717391584; c=relaxed/simple;
	bh=I4tg3RbZKDscuJkrdFyXIhahM/BAQns9/jygbqowXeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFPyXKZ6PC830RzyNAR16KUkDfxHHMoMyi4854YtYhX2pJEf72FwpKNWogGoa8yzd9UYFBwqT+Mxbv0J9aYSQdMBEEYNLJPtd+ZzUOBXWxXewaOy6l3g4HTbbklK2G1LctXtzxHbMu9qOuFZJXw2zNNl+wgsmy5cnR+t7Qxaung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 253B21042;
	Sun,  2 Jun 2024 22:13:25 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C4EC3F762;
	Sun,  2 Jun 2024 22:12:56 -0700 (PDT)
Message-ID: <ad3e457a-cc3d-4422-9be8-656b4f925711@arm.com>
Date: Mon, 3 Jun 2024 10:42:53 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V17 1/9] arm64/sysreg: Add BRBE registers and fields
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <20240405024639.1179064-2-anshuman.khandual@arm.com>
 <Zkygkt2a9HBHfmeu@J2N7QTR9R3>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zkygkt2a9HBHfmeu@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/24 18:54, Mark Rutland wrote:
> On Fri, Apr 05, 2024 at 08:16:31AM +0530, Anshuman Khandual wrote:
>> This adds BRBE related register definitions and various other related field
>> macros there in. These will be used subsequently in a BRBE driver, which is
>> being added later on. While here, this drops redundant register definitions
>> from the header i.e (arch/arm64/include/asm/sysreg.h).
>>
>> BRBINFx_EL1_TYPE_IMPDEF_TRAP_EL3 register field value has been derived from
>> latest ARM DDI 0601 ID121123, AKA 2023-12 instead of latest ARM ARM i.e ARM
>> DDI 0487J.a. Please find the definition here.
>>
>> https://developer.arm.com/documentation/ddi0601/2023-12/
> 
> The K.a release of the ARM ARM has now been published, and that includes
> the "0b110000 IMPLEMENTATION DEFINED exception to EL3" value, so we can
> point to that now.

Sure.

> 
> With that in mind, for the commit message we can say:
> 
> | This patch adds definitions related to the Branch Record Buffer
> | Extension (BRBE) as per ARM DDI 0487K.a. These will be used by KVM and
> | a BRBE driver in subsequent patches.
> |
> | Some existing BRBE definitions in asm/sysreg.h are replaced with
> | equivalent generated definitions.

Replaced the commit message wordings as suggested.

> 
> Aside from a couple of minor issues below, this looks good to me. With
> those fixed up (and the commit message above):
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks Mark.

> 
> [...]
> 
>> +Sysreg	BRBIDR0_EL1	2	1	9	2	0
>> +Res0	63:16
>> +Enum	15:12	CC
>> +	0b101	20_BIT
>> +EndEnum
> 
> Please pad this to the width of the field, i.e.
> 
> 	0b0101	20_bit

Done.

> 
>> +Enum	11:8	FORMAT
>> +	0b0	0
>> +EndEnum
> 
> Likewise, this should be padded to the width of the field.

Done.

> 
> As with the BRBFCR_EL1.BANK definitions, I reckon it's worth givin the
> enum value a prefix, so please make this:
> 
> 	0b0000	FORMAT_0

Sure, will change as suggested.
