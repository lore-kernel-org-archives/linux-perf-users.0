Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7F283FCD
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258165; cv=none; b=GE7DBadE3Bjg7AdH5dSsqTfkrYn1FjJcQQ1/XVOETC7pizn4adbion4ZlPzLheXaTygdSm4zC4Ee9XB8yGqWAZgc1LPdVJ4CqV8M7qBzvGdH+PGF2VyCmV2LeUdmGtQKNqCw+1mpAP9Kd1wSVgGjkRBszRsOhr9xHvC64QNwE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258165; c=relaxed/simple;
	bh=T7VIuEp6hEe3RkCETbS7KqP+//z7d2ZDmQMS7i30tSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjO/iGky5Jat3YrV2mMRbNFYXeiZ7J44cq8QhC5SB1APLahpx6Cu37KsPHMjGdIC9ZBp1pFLjXLuZQqpuCc6nhnqARAGaFQ5U4egahZ8bp7IaLLNKIk4rADqxkNOCwdjB9Q3c++Ie8ZgLsnHofZcITw+LtMHDD3nbhZxuYBIe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQWOb1zY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQWOb1zY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso8663586b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258163; x=1767862963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnmU0etDq0lcWJuNgsoBFmFUTXG/dt5JQHfVECxG+u0=;
        b=jQWOb1zYrKym2cyozQPiQHSx6OzTx8q6juktqeIYNsaC5jTZek/8bnJyMB//zf1OsB
         yDRjEPaFKnSliz9WljRdNjwXNghxNbGow1DmKV8+kzUz8AHDQ7+xfGRY590LULfUhoj4
         gywtz3wWB5j8xP5X0wPX1NGWv0saPZ/DvBMaLy6K7ZwJKKxDS/ssiClcBj9C0Yqk5Eoe
         tqdxC6MMh3i7EbvJ2wCwGm4Kv90pBYEFgnat1MNLSwHUgtvbOXNh+OFKiiOlYmSM6DRo
         83CeBHMYlWoA+qAR0KjJrWCLuGV2SPtl4gUpHTCjzICV4YO6lJKWaKE4UnHd64zFCIM1
         6vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258163; x=1767862963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnmU0etDq0lcWJuNgsoBFmFUTXG/dt5JQHfVECxG+u0=;
        b=shJp7i0sKMkTbX/eHV/PYCBz83+dQm3zt4kb52FVbGV1WSfEu5Ti2WSmkyCDUeI6qX
         YkgS79SjS1uN6YhD+1NuXzolphAT4amqfIeBkbiM7hXZ7WiBBtWLyiyJYNTXwRCe1WaX
         4JZhDCzqDbVglcsWm885epOewRYBMKSSiaWam1AqjJ+EiX2L8bPFf1+OaF4kgXJXUH7F
         UoLcLZ1eo258wmsDK8/cklWIBvRXw5nUrnwq3OkGTX8OH6I32svlob3/4kJFghEerweF
         ht8uoRaWa54rAHnPmC/Crj03NvMi5R8BvCnzhyIN4WIZGKBFu33ZDQ1eiE8vtTpa+iLi
         mo7g==
X-Forwarded-Encrypted: i=1; AJvYcCWIakwurPzPtJvk9PnEHBYI0bEVOue79Il0o9GAucWnqhrmC8F4WQLZpEncIDCrmmsSk1dt8WiHXFReaZ7HwdtQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Z28VT2ztNsVxoaWOo55SltgpZjedwZEuFbZlpP+ZjNriEHbB
	dQ8eX78WbRc5X7y48zo11XLrc3L1pVWky5SnEsk9h+ARS4eQqkTStvgb
X-Gm-Gg: AY/fxX4kNl6eVQWxm676s8eqVw1h7yNWLx4e3vIyh0djsPwFalDlZqSiaBklDW87i+W
	6rEOPs8j4sXmQV2+uEUkQb7CTkzfZeQx+D8RcMS4owy+hdWcFPZtvlwJ1wiVjN+RndPcYhTNH+H
	AEL71ZfW1GFe8GxUbLOO/NTygLDCLVSiD75BKATQCHCo5CHwiYODVdXWiz4SBr9jHUNMQ+iJmMJ
	9JwliaAl1gLlN31THX0XQTJG1oY6rfhFILyEeUB+scTKL0Jx6H1JaZxQP4eJzTHjViGsj0sQQd4
	KbhGqWYkqq+ghaz8mPUf7fU4N7aLUnBfSb5iroMkF8y+xmBv3oxnXueo1DFuDneT5zjp+xEtQlE
	+nRPm4MAIsLRuo6hm8BH8Fs9HpHwNXh8irVb0Zy4/tvNZaytZHnJiaJv5L7q37WHMXnCRFJNbpT
	Bll4A3N40Cwltn
X-Google-Smtp-Source: AGHT+IFmkrWKS/7FmmxYOa2Rc6IAdldSe0vW+VCQopk2Z3V5RjuuRrxz6yRgFXBslyCW8xVE0ysndA==
X-Received: by 2002:a05:6a20:9389:b0:35f:fafa:a198 with SMTP id adf61e73a8af0-376a75e8a87mr34983779637.10.1767258163369;
        Thu, 01 Jan 2026 01:02:43 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:02:43 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:38 +0800
Subject: [PATCH v10 02/21] drivers/perf: apple_m1: Only init PMUv3 remap
 when EL2 is available
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-2-48812c529ffc@gmail.com>
References: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
In-Reply-To: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=T7VIuEp6hEe3RkCETbS7KqP+//z7d2ZDmQMS7i30tSU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgmcioDFW/cgCyqzljV2Zk1HIbx3mEdkkvCz
 qn5UQHjIACJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4JgAKCRABygi3psUI
 JGHYEACifxfNp4MaPvu9Ha3yNIOsVV8p76VKZFaIJFNpIC2Zg32i/Ut43TnFCiS8KNa/Z1lMnvH
 qO2YUVuRgPglNl5teGrwBILvKrc+4Mfr5cz/z0PM3SwzzZfU6ErE0gSfIjTjLF/garU0bJFiww5
 AhIKOOKrQg0sSuyk0+5/j7fdr23No9zE0cUYiaPyyZ6PsapXl7uZScKxqxv0UJ6otVAjdwDyK7Z
 yF5hb+lc24Ty3SeSNKwx++AeHURmH1I1f4lAGa3bMtyLrhd+xISa+eAMvPlWBSmp/c7B/ag0KDJ
 newogHd+vtN2SwJWTwHI/w3yoSRAuqh19czHPd+V73lGBQnJxVWHXrDFKPoGbHvoBPfQYkuTTwI
 nmwi3Eta7gpDcEOhBcX8n0fNpkM/6vliM3cEK0ZTsZQ61/eUZdrpJogIPCB43iLAkFJX0Y8pKkE
 Sri65VYBlADVMF9l/fcPp4Y37troNgDsNsiLhpRF+kZe+2UmxnE+TbkKd23JKopNYQ4blJUZmz5
 y+M7KTk69CdhgQp9fD1LmQ+8PpIcOf/qFrUr33awtQ26sF5F8l1Wlm7zDriYpBRjPvpw1d86YqU
 uWW180xDiOmD258mV0eFbE34YjS0MTPFY+HNJc7O7QiVi3C1S5D7b87hGnIlnFPSp8hLGbzajf4
 8iYG31jc9OUZNiw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

The events in the Apple A7 PMU is very different from the ones in M1, and
EL2 is not available on Apple A7. Instead of assigning the wrong PMUv3
remap on A7 or declaring a new PMUv3 remap that would never be used in
practice, skip initializing PMUv3 remap altogther when EL2 is unavailable.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 81b6f1a623499566ef04d04075752f34e2cb6a92..f3948528e28e0189efd0f17fde0d808930d936af 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -645,8 +645,10 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
-	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
-	m1_pmu_init_pmceid(cpu_pmu);
+	if (is_hyp_mode_available()) {
+		cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
+		m1_pmu_init_pmceid(cpu_pmu);
+	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;

-- 
2.52.0

