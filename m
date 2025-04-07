Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C74222581;
	Mon,  7 Apr 2025 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001212; cv=none; b=ZVaSZ3LPYvEyiF+f/u20tKhbsmh4c1cYzAYK5rVQP6bXYlmRsd2vq5x9m43uc79hijpAgJmdZq+F6kojd9kfdGYNUCPexDCW+xTQIMSZpD+qCQYsBegiIxRxWNjaLQOyK+Z97pwLSVx1UoRjXETzMKWVx3kcNxKM/UMpWASjJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001212; c=relaxed/simple;
	bh=gOE3a46CDNX3yVDAoVpyrWK4j8QsbYn+HXz/rfkRHIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIP1D0+Pd1rBvZOuD61jkNVuBiDct3SFzdwyuoSAOksSCeb5WAyg34eELgBEsPAu2kaGX3MZoisj/GyhuLclWo9OgPzMx3zSRFfc5Y584Vc8il7nrjVmwQ/kp3a7HBXqjbSvoPbNSGTDQTGBO0c8L/cgbxoL2oHh9ttNBFK6vWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPeKrfNZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPeKrfNZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30549dacd53so3035538a91.1;
        Sun, 06 Apr 2025 21:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001211; x=1744606011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bV39ciPbYxAqyF9bw5GexYzHMHyeT7cFiiGjkDg4x0=;
        b=MPeKrfNZ4/KSZf8Y2vzxB95SQRwtUWO9EN3lCobLjp4p+3JJOkpi8reGZKXOLm3BR9
         U8ZDHnD0K74QOhgR521yzxo3X+T0o6rhub9sSMpE7Sm2ZBjBA/bhkXn/7zxAzrPsmIBM
         +02n8POragAcECTvVHchg48UE/YumJQyZq4VXo8OXs8HQZG+5de0zxKlepazfuC25uiy
         9hXEdDPvhJFmkQJMrKViZ+qBHc2HT4M+VCSQQAE7ezksUc0VsEg3+vwEDiZAnuj6E3nU
         NJzO0lArNPlJDN9SotyaTPjNbSa4JvF/5fmRiO7ilfAixQ7GN4MI6l7mNPUyE+9DnrqI
         VHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001211; x=1744606011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bV39ciPbYxAqyF9bw5GexYzHMHyeT7cFiiGjkDg4x0=;
        b=EYrxAWP0fgxmJvakCeP4nWkzXbV67dibyJayhwZ9zCyrt9+wwZo8ObFxOjoM2jGVPK
         1ekqKYoHrW7nd+WTMcQsk/6cFJnt04vcR4pFrvCT0IZB0BkEk4nMQIiHrNtgXeRn25yF
         5FtXar1rf26MZtK5ij9YW1RXEgDIJq5jH2W7i65avyvZf9/KpHDc1Q0ShUnvOViC95wY
         aSCybgyNULGeJxDAcXzrMbubIukbpOyXwFdGpcLgBs2FowLV01QDPj3lO/GB7qgsPNlp
         w5AZrKYAW8+d9cUzXjJslI4uZmZWv2+jWIzVDZvGNhORSZVLZZSOIbSK/a3RGK3NLY0d
         VNIA==
X-Forwarded-Encrypted: i=1; AJvYcCV/+pinUGTtfdFS7cz18o4j5onwCm4xpnfPRPuKjSAmFZiI3NjYHm8KK5fPSLr2CF+yITlX6zSgYNQc@vger.kernel.org, AJvYcCVB4rqqoT68EexjkhZdcy3acrXGMgUe0S150nS811xJYrD4wjpU/q5Kzh4pMUdcMQxCSmMmNT4HfQA+DyKt@vger.kernel.org, AJvYcCWCtM+BiHYBYm++4/SBiXcI2y73Mu//VwJ+lscfeloqIySfSoIbJF9aZ+ghAvOAMOqt4JkpazifnSbtA0hjo0TuEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJDnz9aaRlpXXK5RVyZFvQtq2A0k83/I/7XsvXuWkubnzuQol
	T5UwA0LZWr7OexhOV8NWLAu0qXjtJc/e2NrUI+LeanT0I1x5C/dF
X-Gm-Gg: ASbGncs+PO/7stYHfWIBxIUBIri9uhud/cgtEzQBjQKby4KF52jOzLPCkoH/zD6UP9c
	PVAHQAmRnw5E1+YpabI8liyr3yq8Nbq4j5KRJV6pspEWbrFEkQdDVobMlYhlfhnPre8wiit6OCE
	1ocVfdONu/wnhWGLAIl4Iz2E09Zua40vpS2+yMc3LMUdtK52a+f8lr0qPqBze3SVQSMpm3Fx8TS
	GNE+P78qh5phUMtfEH0h1BNvSedAmknusXrlIJNUhzsFhWjrOcoyCuzQqUeAGOU/yIbrP0hD6hr
	vx8J3jmAIXwbacaLX3y2AhvNwzzlCFM6LYOnppS/u/JpLW4=
X-Google-Smtp-Source: AGHT+IHmg+dGZ5ffm359pcdGaL9W/XS2EUKol6XAMPziDAzw3x2N9fr/np18kiZDHh0QZ5bpJTIjHA==
X-Received: by 2002:a17:90b:5202:b0:2fe:93be:7c9d with SMTP id 98e67ed59e1d1-306a4e72bb7mr16105136a91.7.1744001210730;
        Sun, 06 Apr 2025 21:46:50 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:50 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:23 +0800
Subject: [PATCH v6 14/21] arm64: dts: apple: t7000: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-14-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=gOE3a46CDNX3yVDAoVpyrWK4j8QsbYn+HXz/rfkRHIk=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iH3+YmlrIk6rELKJ921/3DC4VYqrmOTFL5Z
 IKYXrgzhP6JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhwAKCRABygi3psUI
 JPPXEACeYWZb6Qe8nVF7Bpg87QTBRd8nTaQXFDxCft9qSVL/dChn5t40irfJnq2OmMGGhV6/oO2
 FHRe0zhsQmy4E48rH83xK1VBLheqa0RZjwwLptucJpXKy+qXq35buXrD6bKnJVHTM/Yp+0ju5pd
 0oV4SsDH6hZGbWDVlGM16qYK8hTWjc9sPwNNzchy09+Tsf+pv/gw0UpRtKRehaEwqYSs6Jyi916
 oaJjfVxCqgY7rI9qjvyOT9Wes6MatAmXw7i/M/vM/+UhrhoOUuov2qhCeurLJ4j/1CLmjsgqnwa
 WBBCQLxF7dLZ+unE5hFTsIHn4WU7OQvs4Y8PSmCaBu2rPfK5UENIedJ+jgE29pYOEEq/Ko5Pjm1
 OpxwE30Ofmdd6KjuFcnfX0JwDPiEfXBKZrEofTOpW7gkxGu+K30zNOX620C7xPkm4NOS6RZYI6r
 WfADjrIsRFhbdn446jIdWmW9kGOvwW2+vJEwNqrSd3aViIMmYXbFlby0GVh07x0W6zTE7c/ONlS
 qGazaEzlrAhyd0CA2K7jQfvQOO+bgtBLGYFZh+9+SApOrfaY+fd+80hS+HOaKn3WiRcP9jyVJfV
 9+dl1gPAxMIsSI2G21SYfqvkkWR2ueWEiEAdhICY6HoKeTqxxpB/Kj7G5ifdC3ezDjjtZWm6mPp
 lkKgDgnKC85RB6A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 85a34dc7bc01088167d33d7b7e1cdb78161c46d8..f1415f50cb150ce1d33999c817243c3dc9184199 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -193,6 +193,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,typhoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 78 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t7000-pmgr.dtsi"

-- 
2.49.0

