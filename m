Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35552848A1
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258175; cv=none; b=XMGFKHnZJ+UcahTBmb+9/KnCY6LO1GqY1oCO/GBEEIZoHh+Xq6sFPwsrqxJgyMx4/j3vQJuRadQoMc1MHcIX8T+SRW0M12OgQB9hMEgqHNOSe/oBJkVuNkkoeM3qJ+LUe4jPVhi6xD2LbI9HQML8p8ixfEa5x7R41xVsMmugdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258175; c=relaxed/simple;
	bh=HP3+BRpxCk9vu8k0Gmg3N76nZU0a4qyvZesmM5VNmx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSFSEh9JlRdHnx/iSOre06UudAAvf77wK1SaU51ihqb7CqxnoORLIB7MxAFRA3q+MOwtYeOlFRa4iVOWAly7zy52PHNBnufJXXqsIKe5n+aFJjPANlw2iodoYZ+kRdSzWtH8F9V1BXTkoFOuyaq0PKacOtmok+FfKEfE0zQKvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLc/0gxD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLc/0gxD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so101169455ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258173; x=1767862973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYhLngMqNJ6OldqM8uri9fztTRs+E1nPGgcMJFZEiIY=;
        b=lLc/0gxDo+Al9yzGv7K7Rzr1JUePmu0WP0ZJub+W3vXmfgpg8rwYt+ubibAKomeeig
         Q2fJxOeUKrUolS4Z7C4xM1hNP6B0UZZ8FR2KRw0IIkWSBhFzM920hdDTuWdmXNz+awPi
         tFYkf/h4MlAD5eoFItz5TkAxWsODkNqHPLRAWl48K8k1a78o2qy31yNVipUSS4XnH//d
         XGi4lCTB9aRsdwLs9CriRTGgeFyKZN11/1gJBhRkeG+olVcxCkLHnjmncvbJsdHpm+YX
         GbfFWL2JNasNyZaXNZiTxN6OHap7rrEfpcc5N9ykxxPscsfqxjYdUA6ED4D9TPz/TZ1z
         pgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258173; x=1767862973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LYhLngMqNJ6OldqM8uri9fztTRs+E1nPGgcMJFZEiIY=;
        b=PmtsFdPMq5aZqoSf7qL0qtjlMtNmgrYm/uWqymvhA3c+c7V+TpmkEchJwf2Qq2R4BP
         WiDwC+xOOzDlGY75t7cKfW10Wlk6FMLsqWckF1EcxqDjDHNME4wpNVFwVOhdrVXlifwq
         UWU3vwwAuuHp6i1HChx+My7nrZpHFZ+tqRXWjWIiQC9uXXQGAVjQ+n7MO0ajX8OLJ4g4
         ukR11mX3xp3gs6U7EhEMK4XKgwLNVztfadHCHLbB4qqOEl8QGndojHFhR9wQ73PVBZRQ
         K70jWjSykmgef9X0ujBLHzkEhCPNEfAjWKoRZ4rXEE+uR0fZpcyVqzo3AsWjugMRRTU1
         H+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7+sAnhlVlcNfqz4tDBuUkCdZJSX9/Rr5EaPq6MCGng0XN8VilyXUSX/1ULBri2phiGMcTCRzDx1vnnAFbBz3V@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKu+7nquJeEiCK2hf6rQNqyv1cPVhIz8ExOW3dbRfEgQnhQHr
	mBMQrS9mwX2aq3VzUeyOxZL8DVB0u3ldEse7b7YZUBPlUTwxVneg2AZE
X-Gm-Gg: AY/fxX6rWDxTrSM5mxClloTHJ5Zj3MPqtcQUW4lt/s0t1erYeYguykO9+aW6IQzjT9/
	T08SOIa3XCyTrI9krJATTxnd5VAWNhea6O+txb/92M/NjrpISMnBPy6+Fw67EZEvuG+SYlMzYmm
	eCzm+weAdnnlqzi1a5PiS59RlBbfuc8FqKQxW1izFo+jczcmevzRsDXos1bMsdknBr01x4Tt1zX
	myYDLS81VGdUWlUySd0g02qqUUz8EeUctjRU3K84L5gN/l1qZJhUDis73zzsSPZ3LFjHZ/0Os80
	6jA0hF9TxxsTz8h4aKhCxaiPtlbfOu3AGgpdUNdu0A50JFaPuGlexqduvGCKn9YgSf0HzClHxNf
	1hyYwfUihATgLlLTtnTNzkhW24JcrYvZMIAatsaOwHHytHcXNOA62iQwDwrmDz0d/umlDC1nxpa
	NwBk6KL7afSVP8
X-Google-Smtp-Source: AGHT+IF2DK/wudcCjuHS9KGm1WeGhjtlIUvpoPE63sH8WHjKNF73liEZe8dOYBfzDMRjLKw9kdzJgw==
X-Received: by 2002:a17:903:1cd:b0:258:f033:3ff9 with SMTP id d9443c01a7336-2a2f2a4f072mr340888935ad.48.1767258172838;
        Thu, 01 Jan 2026 01:02:52 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:02:52 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:41 +0800
Subject: [PATCH v10 05/21] drivers/perf: apple_m1: Support configuring
 counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-5-48812c529ffc@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=HP3+BRpxCk9vu8k0Gmg3N76nZU0a4qyvZesmM5VNmx4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgn0cIO4FislP7e3t8nidSA1+CQMnbCNH3pF
 h1xmqm6xcyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4JwAKCRABygi3psUI
 JDnRD/9gYiOUD+XFPH6CuOvFxz6OirPhj00mypSpKS6xPDABNlbRm6Gpq2c8l/14xhRKhcTEFWE
 wppVRTTwtKjb2bicRv0dx7ReyAY6SSGq9rLxVnWb85qXeNrxKut2up5+QYJr0v6L6X/wqF1IGIa
 UgQ24vn4LdN+SCNi59WaZ7X0QJRb3w93mznF6mCQJXYRiTIDWifB/sQteUprkUHxzlwT3ID2lvp
 hx8f3tl24RDYGH2qccljtXnVWrHO8tYZl35zov2s1cjkwQdINF4UO9UxGjo+GCHj/xTETx1atcF
 /SvGj0u91ifTnPB/j7/nizOSZh1JifhmoQO4kNd7acRZivFtzu036oKoIernRQvQsnWDsTrfvxg
 eYPZkSaFQL5eC259rFHjkJoVX7dsPExFJMEvkbbu9uhtJeYp7O2vji09NAFqiGRCOdBU4dkO1b0
 CmIzcWKl6BvlzTKm8G5LJgm5XPtyWtdjddecvLRsDKkQC6Iy/vckYLjUj1eA3HOBWDp69NmyNeE
 n+vS1Z0/35HwheeHocy1/vDnuQXu2J8NfoLYa57FjXj1yJkQjZldfjGQ/O0e+I4vpf+MN0MchKs
 WYScYjbtt2U34OzHdfHxOhsSm4cQYiyHqCLm11bS+UoqE7qkQDzL+Llk7V3vajXFNv3myxXuNfV
 5n2Iqm3zjmofrnA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for configuring counters for 32-bit EL0 to allow adding support
for implementations with 32-bit EL0.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/include/asm/apple_m1_pmu.h | 2 ++
 drivers/perf/apple_m1_cpu_pmu.c       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
index 02e05d05851f739b985bf416f1aa3baeafd691dc..8a667e7f07a517419c22a4f930947347be8546f7 100644
--- a/arch/arm64/include/asm/apple_m1_pmu.h
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -38,8 +38,10 @@
 
 #define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
 #define SYS_IMP_APL_PMCR1_EL12	sys_reg(3, 1, 15, 7, 2)
+#define PMCR1_COUNT_A32_EL0_0_7	GENMASK(7, 0)
 #define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
 #define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
+#define PMCR1_COUNT_A32_EL0_8_9	GENMASK(33, 32)
 #define PMCR1_COUNT_A64_EL0_8_9	GENMASK(41, 40)
 #define PMCR1_COUNT_A64_EL1_8_9	GENMASK(49, 48)
 
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 0b0ee2b9ad4b555f66b9b478055a420b7eec8f3c..6340ff7d3b75d7f0c7ab159e4114d49cf031daca 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -348,10 +348,16 @@ static void __m1_pmu_configure_event_filter(unsigned int index, bool user,
 	case 0 ... 7:
 		user_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL0_0_7));
 		kernel_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL1_0_7));
+
+		if (system_supports_32bit_el0())
+			user_bit |= BIT(get_bit_offset(index, PMCR1_COUNT_A32_EL0_0_7));
 		break;
 	case 8 ... 9:
 		user_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL0_8_9));
 		kernel_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL1_8_9));
+
+		if (system_supports_32bit_el0())
+			user_bit |= BIT(get_bit_offset(index - 8, PMCR1_COUNT_A32_EL0_8_9));
 		break;
 	default:
 		BUG();

-- 
2.52.0

