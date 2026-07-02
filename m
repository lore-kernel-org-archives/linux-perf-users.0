Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C45472764
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983096; cv=none; b=qQMdcTtZ1PIEK9U1w80WvlW5wjwh8bahzg7VTFhcVMIALsaT3Yy3dXYKUVZ8HmO4iVZCAmIw6rPXP3bf8oSvkJ+M8QU0MHU1kvONCMDxzJfp5ObyKFjMBXPuyk3b2GF1mrJaS/TE0t5dlZDA0XHkbnUzPp/2L08TAskJGWHF0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983096; c=relaxed/simple;
	bh=KuUldqSBvNUBw35ye/ZZ9kP2NkGYAK2SlfUkqDDVXZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/Ylgmn13NaVtU47dc6lwa+KN/u093Tvy5aub6dOAVpjQRiB/xDTHuc5dfXJUb35/k+mg26unfxiQMPRCwg2XYsrjDZvWrSG0DgXM4/Dsb8nDaHQ4OFuIge6QSpvyN3MY2M5ngYcfl7+wYatKYaE+BFBya4V4rccoL0QXqhEBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CpFAchRf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CpFAchRf"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso1256749a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jul 2026 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782983094; x=1783587894; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rYOUNaGMGZsPlGyhqLkbebVXqK7qfkK62tQGnVDlaQc=;
        b=CpFAchRfQ+uNLyC3bracfodFVnQc0mUl8RT+FrY0il9+6tp7XLeptQk0nGgSBoZf/N
         H7OBEnFB55VdLLyOs3QLAyGg7/5/YSBEvTleiNEFyVDhutPDc+KUf5udeyTKiGawBv4J
         K/8wIWq+ErmC08sUcHhEFgh0SY0PNI2y0wdAFB1YRFIliEWqFds7Dg0Oe1GpZbeyMRpR
         IzqcWWt5badk5pl/MNHhSFxGgO6HUyNeoCcCgUmZpJ3XoVwYzz6jqx4KErWvmC+ebJtj
         vlP1ISW0+lh5Bm8dtdZ3beu2Cmps34d/De7c2H98DsyVVsFW04Jrw+QjfbO3Bm98CjQw
         jgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782983094; x=1783587894;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rYOUNaGMGZsPlGyhqLkbebVXqK7qfkK62tQGnVDlaQc=;
        b=k2Etx8olSz7G/WimzEmMoHv+H/cSaNFZBVAoGp7P9kRyuB/BWw+5ePsW0EdrSz7sct
         ip+eTcl0IcC15Jjk7ACjlDcFgivpdQN+NJ51smXrOQlExvTE8LfdkEW5I4BitCJ4g11S
         3WlvyMhWxH/3W3+80Mg6lhuwufhzu7wfBxd9XGC4FmP72Vs3pZreP12mYnykByf/tCIK
         DhO6KZ9oq0hwJAAmGaO153fUS/MdUYdl89aBpPL6KHYtDhnA7K2wHvTGlUlglr3QU8Bc
         4xmoWm6NK2r+CgsZ4+s0rtzXgJJ3SKOSaojjR5XGWd0Au/Yid1QBLeUVzauHkLT5mnDA
         QiZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXdEVRQq3BoZUaTPy7PRvQQmiHa4lO0A3BYVQ5eA10pT4N3BA94En4GqXWQdRYC7ZRh91TEkafz/TL+NPf9zLl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxucb+/tw1VbxeHp6rdxUJR4dr3Kr/keEN0ozzU6EUHiFla+26w
	aKZIpDf/lcVB/TaocwyICwbkFvuhLfjS/mqvuqYi9BmT4tYQLK0dUC/Nssm+kY+A2m0=
X-Gm-Gg: AfdE7cmIeJVmh/XNgw4INa+FVy1RHcnBTROPJGnqiMzh6FYAjrX4NY8EeWPduVrdY0X
	uetWCHFZLFw+VygIDX4TWdlntomC8DEai5ocVTZJnJeKBrUuJ05cbGpIsLMszaZkkLSIAm3HZbf
	ELQ9ELlfKBMFHMcyLSZf7ntQXkX7DGDHh3ZzCey1SkPAkwTmnVVSBRQYB0fUHZvdpMntUA4/J8L
	cnP75Zu6CN3fi6tEx+jKFHkEtDxtVRZEJ/PBqUMH2kjsqdlUIox5MeJQVNGNDSmG0iXZEkyIG+T
	29TitWIG8w6x5ji8QikO4049TGM0dli9Nybz2u6nuk2w2PQpU6g+PTN4Sm6HNn5PcaPlijNz0Mi
	sM7R9VClul8zOJmQe5t5zSre+5ED9aBmkMZln34JA+cTbk0jvbAAhTjjWN6Q+Y4yPUUa5mt+Obl
	OIpynOtltKvj8YQ1LhIAII0KkUyO7dtx0=
X-Received: by 2002:a17:90b:3e45:b0:37f:d27f:5186 with SMTP id 98e67ed59e1d1-380ba91d167mr4114967a91.25.1782983094001;
        Thu, 02 Jul 2026 02:04:54 -0700 (PDT)
Received: from EricL-ThinkPadX1-TW.local ([136.226.240.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e15c362asm725719a91.1.2026.07.02.02.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:04:53 -0700 (PDT)
From: Eric Lin <eric.lin@sifive.com>
Date: Thu, 02 Jul 2026 17:04:31 +0800
Subject: [PATCH RFC] dt-bindings: perf: riscv,pmu: Add interrupts-extended
 property
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-pmu-dt-property-v1-1-a7a7737afb72@sifive.com>
X-B4-Tracking: v=1; b=H4sIAJ4pRmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwND3YLcUt2UEt2CovyC1KKSSt20NEOjJGPTtFSDtGQloK6CotS0zAq
 widFKQW7OSrEQweLSpKzU5BKQWUq1tQBQgp8DeAAAAA==
X-Change-ID: 20260701-pmu-dt-property-ff12b35fe0fc
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atishp@rivosinc.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nick Hu <nick.hu@sifive.com>, 
 Eric Lin <eric.lin@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782983089; l=2327;
 i=eric.lin@sifive.com; s=20260630; h=from:subject:message-id;
 bh=KuUldqSBvNUBw35ye/ZZ9kP2NkGYAK2SlfUkqDDVXZo=;
 b=r6xyJqLl12BSFPk0mVYjvI1fgO5czZqFRAdildvZY941PKjeY6XoAQqsZmgQVjkkNpPNiA/st
 /OSxALCjIC8As7kr5tTMspJ7rxU3VdXQOpNyeo7jc8yONMLS0Jk9Ffa
X-Developer-Key: i=eric.lin@sifive.com; a=ed25519;
 pk=RLPQN6uNJ1cSM8GhP+L++2j3pf5ohznFbkNdwIO1XDw=

The interrupts-extended property is used to specify the connection
between the PMU counter overflow interrupt and the corresponding CPU
local interrupt controller (riscv,cpu-intc).

This property also allows the software to associate a PMU node with a
specific CPU. To support future heterogeneous systems, where different
CPUs may support different PMU events, this property allows the driver
to identify the correct PMU capabilities for each hart.

Reviewed-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Eric Lin <eric.lin@sifive.com>
---
 Documentation/devicetree/bindings/perf/riscv,pmu.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
index d01c677ad3c7..13aceb3d42b9 100644
--- a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
+++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
@@ -34,6 +34,13 @@ properties:
   compatible:
     const: riscv,pmu
 
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+    description:
+      Specifies the interrupt-parent and local interrupt index for each CPU's
+      PMU counter overflow. Each item points to a riscv,cpu-intc node.
+
   riscv,event-to-mhpmevent:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
     description:
@@ -101,6 +108,7 @@ examples:
   - |
     pmu {
         compatible = "riscv,pmu";
+        interrupts-extended = <&cpu0_intc 13>;
         riscv,event-to-mhpmevent = <0x0000B 0x0000 0x0001>;
         riscv,event-to-mhpmcounters = <0x00001 0x00001 0x00000001>,
                                       <0x00002 0x00002 0x00000004>,
@@ -127,6 +135,9 @@ examples:
      */
     pmu {
           compatible = "riscv,pmu";
+          interrupts-extended = <&cpu0_intc 13>,
+                                <&cpu1_intc 13>,<&cpu2_intc 13>,
+                                <&cpu3_intc 13>,<&cpu4_intc 13>;
           riscv,event-to-mhpmevent =
               /* SBI_PMU_HW_CACHE_REFERENCES -> Instruction or Data cache/ITIM busy */
               <0x00003 0x00000000 0x1801>,

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260701-pmu-dt-property-ff12b35fe0fc

Best regards,
--  
Eric Lin <eric.lin@sifive.com>

