Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25D25B1E8;
	Sat, 10 May 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889947; cv=none; b=Sc8JfhBXQGcVukPp1YoJGuKxVdcOXB+tkfTJPd1q+7y4Q9w1CFdydZx5k9Z5LPhrh+Z4h3fE5Ldqyk6sZFLoM3xrXepOgtVJ1vRnRc/rR3hW0K8Km6Dl5CZ3UqKAxKRk27Uqli2VL7cDvwyI9/r0RT7h5kgfNevUJMGBUDijGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889947; c=relaxed/simple;
	bh=umS18Mpui1EoUACcGD+WdVdka5VgnqwULsO8fA+OvnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gP/6lxYe93Nf70CmekuzHdLWKvnz28SAQNdVc2EgSzMlyP5KG/HOuHX4IH6Qo/14t9qQQFYJ2FE6TBqDCi7W5XBq4kfwtYI7Oy/0FgvMhKbaIXYYNoMwSq5ipJ2vsYsIyuUC+UZ6fAct37khc2wALlo+7POmEbF6U6viHqH5+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEEXTd2t; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEEXTd2t"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so2335580a12.2;
        Sat, 10 May 2025 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889945; x=1747494745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+utL2luHU/M8t1jzjSvkLs9Wawp5wUxO2TP0BW4NMfc=;
        b=JEEXTd2t8TaPq85fif63koWkhjA/jDFZ6c3QGdZuIMmdWuP0qoH1kjvr8lmOxneSg1
         N+RA4JJ7Sdl16jq0HxAhYMBpZURyU+qUODsS+mrb4l+d3vhRaZQkzeYRDdU3z1hhq6b/
         sMhhCC9o5fGKHuuUF/i1+HvTTYFpxNUBPK6iqEAvSBOCG/s8N24aZ7eLrIKCcT/5G/sT
         Rz1LrYLjGem2qXnB6G9tHpRtg0VEKwgfJ+QWcpOQOcjw1Xu5ayIuegh09uy2eS1HmRsU
         QBCIqh1vjJxlImDGB2e1lb8hJhUbPNuvMT7SZWN2eoDiJvWRhNUlPyXddUCW8ZPCVJVI
         qUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889945; x=1747494745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+utL2luHU/M8t1jzjSvkLs9Wawp5wUxO2TP0BW4NMfc=;
        b=UHoFYUZB14MnEN7u3wIZRSoJvDEd5bl9tL4y6rMr9n9nYNzVdkqAM9phoCP2byIBwP
         EV8+rVbN74TxVZl5+dHTH/qjKwf/ZiJFzr5pIpk5KF2SlXJrLFmiO9za1NHdnwghUXML
         ExMOCjjsCyvRFUL9UZ64eUnnXIhmQmlSop702ua8I6p/wa3wsgMEM2M1HrWVPSJHf3Wn
         lqxyStAK5P4ltebUA6n9/ik1CFeojOKde+4bZXBIDxZVBJcGgQ/MTIDei7N+2FalubmM
         pD33UXaPdnvuKYQMHno4oLP5eHb98hRqqKqYCcLpjZzA3aJSSxnay+3CTIt7+RNkDoSo
         UQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/rCAroN9kJmU6xCjNMtWc44IwvrCOUzlni8C8wdDqX3dCKPyM67JLGUQJxIlICUoGiZRDFz/L78mB8JeF@vger.kernel.org, AJvYcCUkyqRl1sLangOdOBSosh9CMkv+/FMDOS3P89o07Mg8eRY04usow8NLWOr0UTk6DKIA5P4gXNmxwty0a9R+NcqMOg==@vger.kernel.org, AJvYcCXBRDD1Zz1u4s/vL3+MUBRLXDlcuQfAcsZTXtUmqwi/QVzkjxg7V6q1W7VBhXg+55BfR2ANq/+wU07T@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4QeKWcWoaJMNlHSf5E+W5ZdDcD0Pc/eWwFvUyBlCVuarkfx57
	5kxVQRvZMb3WodcYPkk3mBUJo4BQ8PYoRb4Dk7Zm1JrTweFeL/MY
X-Gm-Gg: ASbGncv9kGN5l2wPEJaxkPkRKYNV1oyfeGlcmCTHadsm9GFAnCYPWmx3MED/7KEbxFr
	3Y5fnv7xxklKWYFtr7xbdJ5R2lGC56vMB6Alh/+JEHpE+Y2/KybUuZ6PwhDWXTjFdOIftTqX5qK
	8STkWI2EnPKc9RbO05Ki5WPBwUJYKX5huxYvkIBwiq2PbeRTsNq+Y7bKPa3XY6Rz0XI7T/bTIA9
	swkrSfovEqncNPKQWvc/AhEREaFjla/Go7LXWSHbbl9r0NB6eigfXFvlohRFsyXyWOc6Kw/n4hg
	DH94rrvOtuF/8ka0l/Qv4PrB3l3PrHiRMdC4Vyj+PhvmRXgVLI8YhA==
X-Google-Smtp-Source: AGHT+IHvpyWaj41xEJ4fgTCl3JLKcagSaqSvSd0GQPAB2NLjBkSapSV9Zv6NdP86SFyL3wsGhog0iw==
X-Received: by 2002:a17:902:ce83:b0:224:fa0:36d2 with SMTP id d9443c01a7336-22fc8c7c0bcmr91362355ad.26.1746889945680;
        Sat, 10 May 2025 08:12:25 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:25 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:58 +0800
Subject: [PATCH v7 17/21] arm64: dts: apple: s8001: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-17-bd505cb6c520@gmail.com>
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=umS18Mpui1EoUACcGD+WdVdka5VgnqwULsO8fA+OvnQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2ycF2bw3pW8inBZRIdQmQjyjU46bjoUvRyrt
 YQ6AHCBUqSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9snAAKCRABygi3psUI
 JIc5D/0VQtva3ilCixys6Vr4EbzfXvPR+1Mz98aBHk5EgmotsOVrHArH9ENBqVQ/hwGkV1WCxFY
 Q3Z+zsshxMQ/LbtkpORixMbpkIcmj5YwDhOvCS5tbDqU6gtVoUgHgK15IFeUmoPalsv5TY70xZx
 WcYk/w3seRQcVgW7pp61jdLE3M/skJLGxw4Vs1C/h5bvqBKCmuj4HzKwFrqX56ysqsEBAVDplCv
 21kcI1cB0Ka1ZFsVUBOiP52hH3mu/A84SeGmjUL9dJBMNY8pJjtw3sbgaIP4CeauRbLJkUO+N2Y
 nVZHttdDvWtaZ65yOqe6hYNm8RKF0RAXGgoLYqvsyf9z36YkgoLRDCMxfeR0RyMh9421NwP/FT9
 rwKE1uF9qsHpeVpgzwNvncSLx6JgwCW7d5Dv3bvBcMh43H3nSYCnbz71INK0s9RTRBZQTwkeggL
 m9j3yLmsqiR/7rGAUS7FvzE8GHlz74wkE4rng3/68dhbTqsY6mWDy1oTFoSv4dPMWaGfoGLVoZb
 nYsbSvHx+BKwR8hIVYTX83B9NC44WWgsYlCZGQuiwOMl/lnCmL7R1UeXRV8OFXWpM1TBcPDWYrm
 bhCMMA3ui8oNM7RZdzc+IOlwXxVS3gAjR8cCGIHab+I/gb5amYkdzQe7E30iYzi7i6VYDRut0VL
 rI3xk/Ox5RZ1Uag==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index d56d49c048bbf55e5f2edf40f6fd1fcff6342a9f..33760c60a9189df5491256f81db7f413cada27a7 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -209,6 +209,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s8001-pmgr.dtsi"

-- 
2.49.0

