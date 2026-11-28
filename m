Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838116;
	b=k64rF4b4X0sWP3TI++1xMQDnQF97MmWn3oa1RTlvgrAkbg2QJxGj9nZDOSaWj+FaKuUD
	 1EE9fp33cpGlIvy6IvmRJGUUZrQR1lQdIMq7ILwCLyc9WlRZzFki+X9DBmVAKnfJkCBdZ
	 FlojXNqDlkrTeGI8GxGaK+wAErGDwD/jSN/fvPDYEU+VhnPbBulNu4pLJHzC5S4SQbDlA
	 q7zTs2AtuPnp4ge91CjuwV/RBERrl31ff01iZHDg8IX1LlqsP+83xdl7fYkNLBwTy/Bkw
	 bjZUsWi4YqkI2Fhpxud6UOuWfwHE7/WKsX8FYKM0kuHvu2/Vnsh4DWxfMUb3mVm1L0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6XmgtedqGjyGKnA3AERgrzaJirhR7SRXn+PnZk5B5a4=;
	b=lPb9n4D/wGwEc3E+VJl+IMv5j8KKYFd1ymurywybaK31t6XoNAYIcWbd+lCExuGOoXoS
	 s4hG3jwMBey0G82db2JaTmx7Byc5IWxnxSdSeTXerFjHkwro7CS2Gj63nFOivMfapLuRD
	 D3DF8Vl6xTpAiMi9T0gCTeYkknKzIY8SYMghKPYXw4jxaQsU8fIQQdwwYej1ZcqWIQpGt
	 LD4mXX2qo4Jq+/M2TD7ffpLgvybvq5HWL8XaZ1A4HFQco8yiiT/Lp9a/bF96uV0r4lkya
	 j3XjlRM4J83UWpHdwOSO2CSMcGH2y0mJeDt8hjUKJk8+F6ZAiV5kyzDL3A1DEa/wMWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GqDNYQxV;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636A606A334
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Nov 2026 03:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6636A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GqDNYQxV
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f03f3631b2so44367475ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 19:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795838116; x=1796442916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XmgtedqGjyGKnA3AERgrzaJirhR7SRXn+PnZk5B5a4=;
        b=GqDNYQxVdzmPk71SYW4P4fnCAOImoIcnS1MfGYCtTPcLljr6z9flP4o4ZjhCgjqkYo
         F+OJsLbkypDiAtouP4r7JXfeb+qzBh7V3qodmbDEM3jgBJYoFsFGQB+0DmfEGxejWBQc
         fZM1UMOJwNpeEVKuSWkMg8lRStrvULmsnb+djFUjWzJL+XjVaTqPxFnUy8FMqITnUj1I
         iseRVKbUYLW/Ow52oRFUvea3VMBWIQu3o965QGtFzE+34KCdyCb/Dr6D7wFMg02iGmy/
         veluhCk6NWcQs3d39CGFgUX/mZVuX6mbjQ7HimijheF1kUesEwbz+0AMao4pVSAtMhgb
         mlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795838116; x=1796442916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6XmgtedqGjyGKnA3AERgrzaJirhR7SRXn+PnZk5B5a4=;
        b=lXB0yR2/X9rId12YUnPYS70ToU5GuLeuev/s6n5G7zN0QAYn2QrJruAy6raV2Gd1Hj
         w4BagjSNg9sVt/yvp7DwqkHZFIDB+9yc/Lc+FBPaAftYI+uqRbGgoFeLW1fKDTwOOyPk
         PPBLM3Z2azxUV60COeBCKQkxlmudqeOr+tj+ya54/gSrlBVq4YOvQ3vSju6W3ZRQYH0s
         Vk1UECjxP9bMpMUDsRfLI5atL4G1fqq/dO7ur2aekKhUSXiUzlxNmUhiS5Wt7/KscSR4
         Y7pUpro2Eu+VilFh7p06X6ZEjhxXVKIS5cNGyGF112tKSuTW+sCLKOigJI+p7GIMdiot
         YlmQ==
X-Forwarded-Encrypted: i=1; AL+hErFumCkiwq7zo2h0ZPK//hNTmlv4S9irtBjBR1ZKSGG1p+WIBrR3Gi60CRrGQYzRrk658Z0AdO1yrkuK0UL+wsPa@vger.kernel.org
X-Gm-Message-State: APuU4Z9ryJEekKSuFYFAITPE7tcbnFSozACJCJ3eIuMoV7L2rUy3IaPC
	rQv3mLylfYBViLhG9uAReGg32XUwzkE6JkjkozNnBE30L2T0L4F4C9ef
X-Gm-Gg: AZFdTZf6F5Dg3EDeBFXBZu1eCl1tx7eJrQVEIggTB3j7xkzQMnoEqzhCz1YT1Tcj/rb
	aSa9Yd8kcRFMRy1FZIjL6Xj0sEt8vexKP9F2ZPaRrla/EspQHr+ZxPlLQg29DEDzNjgJTBsvaNw
	QhPVeju3mSV2qUpiwDtZhKqe0dNAt/PZGhQWnfjLfWgG1Zj+kxoVVvI2ElwdY2nrXpjX7bkfPBk
	kFJ7qnSfRrT3M5Eu0Ud26w99oL0DdotLWUBlTXQ0x7EzLB4Rk5lq9WKsR+Pe6EEugJU4p8T8eJ+
	s2RZeL+0dCRq2s9T8X5wBgmAhei11f1dQPDf3a838YPD0iUco2XQsFxMIZshMQaMf92gmRi6ZXs
	h2npzgIZxZ/ixm14LCHN8c/OqdExRkBYbKSQbrrHc6NuiA87R0SelM9cBSNupwAOwGnDB/lPdiu
	hPbthyi7mG1ZibBrifXDeojQ6GFt0rfhPswdWC8zGnF+OvjIi3GrCEEbd70PWvEtyoyzg/TVVK4
	rRZfrscS10vJzxtkmphUK3M2Z6a7UGLoJXhI2WSYN0cRtUoqJNJwrI0Mcq0sJWYZaEjoIQvPkFI
	kbJiI3LeXUHx2/mKzeLPUODz16G8yWxo3hsJBUDt3TGKisXY
X-Received: by 2002:a17:903:19e7:b0:2df:a4d8:57ad with SMTP id d9443c01a7336-2f03f271d6dmr235900075ad.72.1795838115727;
        Fri, 27 Nov 2026 19:55:15 -0800 (PST)
Received: from debian.. ([192.227.246.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f099a4d875sm89190595ad.37.2026.11.27.19.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 19:55:15 -0800 (PST)
From: Harry Bit <idleassetsd@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Harry Bit <idleassetsd@gmail.com>
Subject: [PATCH 2/3] dt-bindings: arm: cpus: add Phytium FTC310 and FTC664
Date: Sat, 28 Nov 2026 11:55:03 +0800
Message-ID: <20261128035504.760778-2-idleassetsd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128035504.760778-1-idleassetsd@gmail.com>
References: <20261128035504.760778-1-idleassetsd@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Baozi <chenbaozi@phytium.com.cn>

Document the CPU and PMU compatible strings for Phytium FTC310 and
FTC664 ARMv8 cores integrated in PE220x SoCs.

Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Co-developed-by: Harry Bit <idleassetsd@gmail.com>
Signed-off-by: Harry Bit <idleassetsd@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 Documentation/devicetree/bindings/arm/pmu.yaml  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 96136b70da..658da1fdc4 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -206,6 +206,8 @@ properties:
           - nvidia,tegra132-denver
           - nvidia,tegra186-denver
           - nvidia,tegra194-carmel
+          - phytium,ftc310
+          - phytium,ftc664
           - qcom,krait
           - qcom,kryo240
           - qcom,kryo250
diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index f47baaefcd..49976c889f 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -79,6 +79,8 @@ properties:
           - cavium,thunder-pmu
           - nvidia,denver-pmu
           - nvidia,carmel-pmu
+          - phytium,ftc310-pmu
+          - phytium,ftc664-pmu
           - qcom,krait-pmu
           - qcom,scorpion-pmu
           - qcom,scorpion-mp-pmu
-- 
2.47.3
