Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C881EB195
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981374; cv=none; b=GIbmHXOsQjsm8PmFzpsEPbtmVd/HbwJcmrB9pBHqZmWQoiZXKskxB7HfFZ1TJcZC9RKIsgBHZj2tz40GC7KzRv3DdqxlBu4sBtDBx5gWNBLmLOSjoZAoXpEoiIiGolm23p3wYjypEYL+suSMPW3NdEyNp3s2EwUSYnyrLt/9Fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981374; c=relaxed/simple;
	bh=/lekqJfKGMjw1dQxyTeqadS7uFPIGjGMoohx7NzndQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsbByfQcqpJXj4oOY67zZ8fJ2576F3hTpmALyp4K9cBxl6eOsCIo6a1a0AyJ8f4FEgPBk0t9GPVsAePsXwkivDNMpmBs6dHiZIfAaMUdc2hdbkd1mn2guuI1G3skTrEiaV5uDLbqNFrEUu924E2BIhSCPBOjNJvVH1BR6nA7Tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7YeYMf5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7YeYMf5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43998deed24so15577275e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739981370; x=1740586170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdBoFnuhqMD4bPK9q59QOYbccPf40KzMHKr/84iucLw=;
        b=u7YeYMf5dRram62SnlWh22KgU4LPjiB652elxEey2Q5REk8J2or/uo1C59oo64U4xR
         LmOp1sK/GmiMiifQFVO/Jk7UEZiEz6mpbSW4X7bxez3sLLW5n4P2DPUX1RLeWId8Kfm0
         8yuJVlHtV8MqU3THAwyNqumlIV2lqGRR2DOiIZKkoTi0Bia1gFt9nbhrFInaNpZwMEzq
         oSeuBCWfEjc/eDsOd37yHgcRQ6VBKf21sR2a9YSeT5ZE9GFTQNvkVd9bidGyNCwyr6aF
         rrwADKmcdlb5wcrenyH6j/JXFlT1Cfhia7LGCL11Zm3AIZBQGHh44RI5JiqIiTRfzG9M
         R4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981370; x=1740586170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdBoFnuhqMD4bPK9q59QOYbccPf40KzMHKr/84iucLw=;
        b=k4h4DCszhCUPnq8i1hsIwXYF4YKy8u3y0qNdjsaMsGQS2WwCR6a3PEwk+7mqzSVSrE
         an714igttfLMNlMfrY71dYok9EriyW9tb0UsLeJNxRkUeFAytL7fXiimOMT71C5DWTAa
         8413PGeJaKxtCVqrJDZz3QsHeUqAAvM05kyxwpGiaeeQIP4DcHuhzLBH17JuWz07Lp7h
         vPyWNMh2gf2p9k4gbD4WK8FUIkAmkoxgrHjxettBm6AGJSinQwlAJ0Se8K/LKQKkQOMd
         ufq7sREAFQimqiMwjt2RXh3Dgo8fZoNr5PbfTpUN9F7wackJz/hnnAuJ6jddzQn30VeT
         7ORQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXJEET5E8TNLfI2FeU4hWxBeAsTH/Xd3Bb+2Mg9RKFjA4Mvw5J6OVgU37NjGFVrSMQsGhWW9GAcprBqfx7h4xR@vger.kernel.org
X-Gm-Message-State: AOJu0YySsvwIkdQKgvLG10mXcjZ9NJpjuIUSED97IqNKmxrT0e9U/nsi
	n0ROyJa88FM+Hs+pPls8nAswVJccKJBNST3HKkQcgVq3NL8Y0rtxTLDRmhzYMIE=
X-Gm-Gg: ASbGnctW38QPE+8RszYGI6TgieYrr3zZ5iNpQg6Yw/e1GNcvBi6k3l+Kkgmz/4hHeNu
	y42XJKb5H3HIdNEFVcnjayugvtWPVgVvKE1TCO+OhGD4VVj9/Twbco76NuJ542l3LZgrfD2QNsb
	0aifeLPaFA2TFBAJfRCu2iRaVaIFpciopv8Hqb9p5QqSugZxEQAwbyKXawLzeF9wRYUF69dskBv
	2yPvXARK+YRPH48rk1r5JQs5Oe3DbbjLDOhZCciQ0F7uemdU7DuNYw9/eqADr6vE8vtOlbFVMq3
	jkMWiDKYmH6dTpl/rxWeZ7r6kQ==
X-Google-Smtp-Source: AGHT+IG87mSbuSo594YlU8iwWTPKAQqVV2chSBKXzyuZ7LJ3HKDzFEKHoFoqCd1APAlb8lVP4Vl8fQ==
X-Received: by 2002:a5d:64a3:0:b0:38f:50bd:ad11 with SMTP id ffacd0b85a97d-38f50bdadd5mr6657402f8f.5.1739981370330;
        Wed, 19 Feb 2025 08:09:30 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f561bee3esm3617686f8f.21.2025.02.19.08.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:09:29 -0800 (PST)
Message-ID: <f8f5b7bc-0219-4891-9ffd-f54102b90b45@linaro.org>
Date: Wed, 19 Feb 2025 16:09:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/11] arm64/perf: Enable branch stack sampling
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Leo Yan <leo.yan@arm.com>
References: <20250218-arm-brbe-v19-v20-0-4e9922fc2e8e@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250218-arm-brbe-v19-v20-0-4e9922fc2e8e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/02/2025 8:39 pm, Rob Herring (Arm) wrote:
> This series enables perf branch stack sampling support on arm64 via a
> v9.2 arch feature called Branch Record Buffer Extension (BRBE). Details
> on BRBE can be found in the Arm ARM[1] chapter D18.
> 
> I've picked up this series from Anshuman. v19 and v20 versions have been
> reworked quite a bit by Mark and myself. The bulk of those changes are
> in patch 11.
> 
> Patches 1-7 are new clean-ups/prep which stand on their own. They
> were previously posted here[2]. Please pick them up if there's no issues
> with them.
> 
> Patches 8-11 add BRBE support with the actual support in patch 11.
> 
> A git branch is here[3].
> 
> [1] https://developer.arm.com/documentation/ddi0487/latest/
> [2] https://lore.kernel.org/all/20250107-arm-pmu-cleanups-v1-v1-0-313951346a25@kernel.org/
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm/brbe-v20
> 
> v20:
>   - Added back some of the arm64 specific exception types. The x86 IRQ
>     branches also include other exceptions like page faults. On arm64, we
>     can distinguish the exception types, so we do. Also, to better
>     align with x86, we convert 'call' branches which are user to kernel
>     to 'syscall'.
>   - Only enable exceptions and exception returns if recording kernel
>     branches (matching x86)
>   - Drop requiring event and branch privileges to match
>   - Add "branches" caps sysfs attribute like x86
>   - Reword comment about FZP and MDCR_EL2.HPMN interaction
>   - Rework BRBE invalidation to avoid invalidating in interrupt handler
>     when no handled events capture the branch stack (i.e. when there are
>     multiple users).
>   - Also clear BRBCR_ELx bits in brbe_disable(). This is for KVM nVHE
>     checks if BRBE is enabled.
>   - Document that MDCR_EL3.SBRBE can be 0b01 also
> 

Tested-by: James Clark <james.clark@linaro.org>

