Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096D2E040C;
	Mon, 11 Aug 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920584; cv=none; b=U4uZp3YkrFeJuweu0ON1Go31Du1szG2AT3ZHgYSoSHqclPH30SJ62WdUTu7awCS4yLCOsDuWg6G6cOOksHva3hwUhus6A7v8vP1mgbGYDeH4utUCk4R1Nz+9fYukp4RJWBUjcVZIuiguhHGllG/+U5+7wGiEsVG5Of2HJzjBozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920584; c=relaxed/simple;
	bh=EpruOfD/q+EFiyB6qpD7d0v6HBQIo5PobeNa2WsPEsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ae3K/+w10w2IRwJs2+ZO0q+GI0O7YMPL+MmPYDelHmurjfNmnzIiwXE7enFx98fHGLV7bB8R8Z/aZ61/xabhvG3clrGmK+tQovRzrCV/z7EKyQIpyukh647mzZIePSPxNqhFmwCzULBUpoH1pgq5g3KtAXxu8nhVMt7Zq0dsy/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJO+n1qg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJO+n1qg"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bdc73f363so3807306b3a.3;
        Mon, 11 Aug 2025 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920582; x=1755525382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avIBeR8rEnAqVNBXeOJ8wqd6+seOLFJ0KWtILvJpIqE=;
        b=BJO+n1qgRgITY6Ux1xPTpaylYfbuBMO9EBJJN9gqjBIsUAeLtop+3lGe2PcNkLmWmg
         fPZEAXj+nNoTLkWOEZX3FUVT/VjzOUt/R2JV5AFdcCBdlr1hrdT4bbvkHVDbUqZ1bQio
         Fjcv5DapfwQY5f3WXwoWzk4MCYsbyGw6VD6gYUps3UowsmykUEWZbZkp0sK6O7azjmkx
         jIcG9VjZdqK8ub7aINM+krr1VeHIdoFXX2fOaCqoDFs0Z0hsU684i2r0nxv7gaiBUki2
         Dze7fX1S0w4ff4fywj+gPso/ruhZ6SMO0XqfHA7A1w0tQ7ouEEfkfm66y9q0093BR5ky
         0Kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920582; x=1755525382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avIBeR8rEnAqVNBXeOJ8wqd6+seOLFJ0KWtILvJpIqE=;
        b=nNCZ1kxsbGSl8n8EnIHnL40m/qb/PTG2lqXIXEzmhWVBgfjT0HyyOfqg+hEYMA/Uaf
         zWMgkZ1ddvB2YrYf85ybF+S3fUu6lZLvnlxLFSXcE+v9FLjxJLFpzAchbNDq0GMLhy3q
         JN72HkKZVGfu7r6pQY8lHCESe+sEbfQdaoAwWccuO4g9FLkoeR2o5fGBlcIvQ8KM+a8c
         K9EdCl/nMwDlV4F6eg2Nc555fQDuE8KbrFdbPcXkfKscDdxo/9GDfwBQbsqRSvPh3qz1
         9egXqzI8hur1oPg0xcmXfJeRaWJK7A1nFpBnZoCLXe2VY/bhWH5tF1DVjN5we7Egk7Kp
         HM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA8hxQ++D3DZtUbpeMTIUjcOjRIaKGiCdcmVz3/aDwyA+d5k5don79+skWlb+gHy5bO0SSrhVOk3GHG4xL@vger.kernel.org, AJvYcCXa2R4apKnyDvCC/leP0EomcwBkN+CTQd/PDqiVile/h9vnQ0a0ViE7NG7uOjHbCvWoSl2w9rwiMFFR@vger.kernel.org, AJvYcCXns6zZe9ls+WZt0dbe7T8vSCH45NP7BftTJzskeTjqMU8574ITtcXm5PiGu3BlCrq8H7L7C+ccWu/tp/8XmQOrvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSLOVi6RxL622RAJofX7Ce7oQQ9IWAzFDJP4JzML9zYIijeaz
	oJamNXF4VyAUcVYsOHQvosSIt3qTSfNzY5uZoXOM+ySUjJ0KEZnmq9Hw
X-Gm-Gg: ASbGncux64D8szbWW1fT/vj3LLGpiS1RcUShiNHbkxUscDzGGcSvC0rjrLlRbYwEqjv
	5NTj0iuyMROeBygnIv5U1biUgCXzrtu+Xfdypr1pCtKwPAJWACFhMJlflHuIC6TIA36bNPnfFTr
	9Dtots9GR3X3PUU8CchSoOZ4zTSv3NP3aQWeBr7ztCsgIYkp8fxazlu+lhCNT9gd0k9sPw527IO
	Ax3S9LRlu/4z3SVS69SZvuJ89YTi3LbLxS6SyTmT1PUR9ZJKq7rlQ+SWM3HzMHRsqJW/ti8ZfEc
	O5GpPQ7OpzrQbdB43GlXCT+o+MbI6FROLUozoqJVXyV1H33rX4d+ukje7PkSGWCInhXYFYvFEt4
	MqSAaKv5MaPJpmZPD63OIIlXaULvVhE6I9yo9lWGoHbkiBOI=
X-Google-Smtp-Source: AGHT+IE3ROZ02+joJ2/XZJxRG29EJhUFoJrI7FNVppCcYvvwFIRKg068dmR6hVYWvx4Z2peyKUSMyw==
X-Received: by 2002:a05:6a21:9990:b0:23f:fc18:77b0 with SMTP id adf61e73a8af0-2405503b99amr21712828637.17.1754920582044;
        Mon, 11 Aug 2025 06:56:22 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:21 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:45 +0800
Subject: [PATCH v8 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-13-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=EpruOfD/q+EFiyB6qpD7d0v6HBQIo5PobeNa2WsPEsU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZCtrzCmJINFsXMQXuzK2KVaLhmiAmEiX6pC
 KGvAhErDLeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QgAKCRABygi3psUI
 JGc/D/kBKhTM/DhwnhpwrT5dD9zmHbMRDZ/2Gctppczw581p304TYK8ymzYJzSShDs/csnIxEdX
 wXCIgVZ4WPGpHsmGKztkwdiV0bwTVYUxHvH7i2sONq2GPdsXnfIgC/74gcyaAYCaCA6UpMKawuD
 uSOOATu5GxQqnlDj1iyeSrXCvrs39uwo4B69Xb9I6EBBm93UPXoOBB15C9t0xszzyKp3CymnroM
 1s/2aj8bWzwrvylETXxxQuycD6N0kZMa6z2XS+fKINgL8eDmDWa8Te5nuU6dDcsHwsQhbwIjeUk
 rE3lIgPv8hfvtH5NE8kXB2KpEogwnYwJBBwKRPW9bIcpc5EheKUCO3zzr46y7gtNr2uEHtRCn3q
 gih+zlEDkYsAvde2+CpJ4a7taJQ1nx2IjJsQtkXuoUoUYT2e37rtOxbZrjwLzQnJBk8tt6TLB3H
 zae5WXMNods5BriqOB5em+/G7DZW4RHiNZhQWyLLR/kwsYaHuNRoL1S7TzPlMgW4xaUjfcpwfvx
 Nwmo7eCk+g9+iG7qbbFZJUZk+PoboVP854bxxWW8Q0k1+u1myiatSfOHQg0YUFrcSaxEjviCAej
 RZ9CftokBd7yIlrDMJQkuOZEZ7SSjIEZInj1sTul6sOGUtibs2ldDbuq3cPphV9bXHd/MVKA+Xn
 k1qn64enML+Lbng==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A7 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 5b5175d6978c45052ded495fc0d18ee3a8fbfdcb..1a3a90f7b9ded42e371ef0b41057fd3081579615 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -151,6 +151,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,cyclone-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 181 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s5l8960x-pmgr.dtsi"

-- 
2.50.1

