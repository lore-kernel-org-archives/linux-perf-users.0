Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E93A9612
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094124; cv=none; b=YdS+aD1Dp33eNapxwi1N/pHGn7hQTdLpiJr0TUhRuDL2FiFQmeDIcoaf6PbPomsQb0PvZPSNdR3LEDv9lklc0XLUrwAlgqYeaDZGjzl9ioL3YG9bZu1nqar61a1YPG6zQFp3rsgNJD2/zLLxKh56fFBKqsMAFo7+tKdC4P3+KCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094124; c=relaxed/simple;
	bh=M1pf+02huWyWg7XJVqpd9nXyaTXfzjeclnrKBHS5JO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UtC5m9AcPmoYUTweGndP2NzHkQv5ss+O17QvrOnuiLYXJubCmZC+HIWXM4guMt4zlIUbn4trj2AQ2kk91/YUvzpXcJWSouOgbfSZSnU/+23DvFRNW0nEE/gt2Br1Jwmx6S9cvE9dEPjoT94iM4uavPtTgBTdYFsuoAmnQ81G76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJxYfMNU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJxYfMNU"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1508740f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786094119; x=1786698919; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e6t3+tBS5sN1Dfvci+p8e/0NE4L3dqjBbVzFjBmD5o0=;
        b=IJxYfMNU6c6p+SQnqF7Y+hjp15zi0HYXKnLUMSkpIxqE6Q/bXyEXrxfeajDhXsXqGi
         3xOwnZ4D/xwLpwRJ/JlCLuiFHPs0hcYAFqItQo4q6Yv3YkCs15mmWJsEyEpLUCqFj1J2
         vd+Kl1bpW69O8cjc76PBe12PCzmVE3ZU05k7OhoWQLQsVGq0DdgVFxp1uH9tAVPIH9N+
         h9bCUxSVyM3cOrHE+tfU+JFXiBSign2tMrx5qWW7Y+p6wiZUZttOd1fXoND6eo25FQ72
         n11ryd+5eJwZbNxq4uKx/12v5HrOPUVh9fhfWlzN+97q48CamgWeu3pWFORO/yFIdMs1
         SWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786094119; x=1786698919;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e6t3+tBS5sN1Dfvci+p8e/0NE4L3dqjBbVzFjBmD5o0=;
        b=UeNETr0X6rhRFfOpZJ13Zevpx9nUcfzfQS+viIe28f+IrC8jxtMRNPl2BuCS2wAU7D
         X/6sACxYzCsc9Z7Z6F1tFooeNLfaTRpEjSkg7QLc1GLGnZkbJmgcdI/NenJcUyqfH82r
         dC2hiBWIkEcdZsTj2ahLdlENa3g2di8Ldh4FB7BcS8M1Owjf1dCTM/LIpTBvbDvQ0DrJ
         OBCkLtOXqvaig+7xn/MKeveef65frYSO9o+586H1wURGpjFRPoqVokZCmM9HgRy1Ewk4
         TjHoJ3zayr8SGeNu6LPcgQy+joveEBR1VkyPwORCiwl1gRuYZBI5nMn7hRKNl6TUxCXE
         JJnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyiKEKQAfZNM/eV6BEHaBQPydpIP7RLCz89Btr80lyY4ID9IUO1gY66L3v92ICwkbJnIcSKRv+sjo6/oPXX0pU@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOXWV8BXFqxzubDJiA/m3NBHF8ZeqJUrmtSN2O1vbzg+59OjY
	PXsaFnjeyjrrBsh0L8TGzrKWCx4Y+QmIighVQptlIgkdJrkQJAC9OXWnJqY67GTYA0YoNnuKcyO
	lnsqWQBU=
X-Gm-Gg: AR+sD10qaxAZJWQHh5j+4S06Z+Nw1EuxQKdDorivrjXU3y3yozbHsTBbh92DBNINp+0
	IU3RRjbGQbQ7xzxl0CtLdh+WBOIV1Jr4wKHKhZORB0GDqAJJY5pUom0L4W92iCpENqtJkHiptI9
	3bHFzmTgrK6k0i6Se45xcCrZm6zWcaeDGbJM98D3lIStEyeMSt3SUj9zpOnncILe4nLnwBIYx17
	SYzAQYcm1rIF2yYR4GwHpTrh3lciTIEhUBlEwN5RoySMDbtJ9y3vFlia/ReyWWoCdFVYarAf91h
	I/uB8wJBIs05Y/P/Ar8X3eTP9KoKBwvRj1QcEksxArtWQi3f4Mxy2ZRKz55N3OBHNT7tQ5xQZy1
	/sjClRx96r+ZmYZVM4NWUC9CQwzYTuYe1LBCLZQc4M5/TSG3QK+7Y25cEglWRRCeUv6f8LE6tse
	PmdbYT0VRbZQS1OAaitifwmQLoiYM4AowDSzzPaGJG4ImCzoalUO700LVP1D8ZychB
X-Received: by 2002:a05:6000:d0e:b0:47f:9557:8d77 with SMTP id ffacd0b85a97d-47ffd2236f6mr9845559f8f.10.1786094119255;
        Fri, 07 Aug 2026 02:15:19 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021fd392sm3809077f8f.31.2026.08.07.02.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:15:18 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 07 Aug 2026 10:14:59 +0100
Subject: [PATCH] perf: arm_pmuv3: Zero initialize hw_id branch stack field
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-james-brbe-init-hw-idx-v1-1-009d1843960a@linaro.org>
X-B4-Tracking: v=1; b=H4sIABKidWoC/yWM0Q6CMBAEf4Xcs5fUKtX4K8YHWhY5EqvpoZIQ/
 p1DHye7MzMpikDpUs1U8BGVZzbY7ypKfZPvYGmNyTsf3NmdeGgeUI4l2pJl5P5rj4nrQ4tUHzv
 4EMjkV0En0y98vf1Z33FAGrcaLcsK1wyFaHoAAAA=
X-Change-ID: 20260807-james-brbe-init-hw-idx-53dec54fe266
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

PERF_SAMPLE_BRANCH_HW_INDEX is supported by BRBE so hw_id is passed to
userspace, but it's never set by the BRBE driver. Zero initialize it as
it should be according to the docs:

   * For the architectures whose raw branch records are
   * already stored in age order, the hw_idx should be 0.

It's probably too risky to remove PERF_SAMPLE_BRANCH_HW_INDEX from BRBE
now in case anyone is setting it and reading the value, but zero
initializing the whole struct also protects against the same issue with
new fields that are added in the future.

Fixes: 58074a0fce66 ("perf: arm_pmuv3: Add support for the Branch Record Buffer Extension (BRBE)")
Signed-off-by: James Clark <james.clark@linaro.org>
---
Very small fix spotted by Sashiko. It was probably always zero during
testing or never looked at.
---
 drivers/perf/arm_pmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8014ff766cff..b9a8592bf112 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1361,7 +1361,7 @@ static int branch_records_alloc(struct arm_pmu *armpmu)
 		struct pmu_hw_events *events_cpu;
 
 		events_cpu = per_cpu_ptr(armpmu->hw_events, cpu);
-		events_cpu->branch_stack = kmalloc(size, GFP_KERNEL);
+		events_cpu->branch_stack = kzalloc(size, GFP_KERNEL);
 		if (!events_cpu->branch_stack)
 			return -ENOMEM;
 	}

---
base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
change-id: 20260807-james-brbe-init-hw-idx-53dec54fe266

Best regards,
--  
James Clark <james.clark@linaro.org>

