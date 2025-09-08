Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058762F659A;
	Mon,  8 Sep 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325729; cv=none; b=CyKPDyGnjhJlZaD7lzioekasCgQUSmKNynnbz1jXttZtEhv1EW3pCyqeCUjiGljJo3YVbFbPDCcXx4BrlPXpjynFkfXuJAl3nCJ28c+NBGcxqr3ognsOzl5VS4CyerdH/04N6BjNQuFmosohU4O98aQLfxJXAeTO7WypreNLd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325729; c=relaxed/simple;
	bh=I5bmZCvx8lSOgqzXisEWeIL6b++oNn2j9gQ7uou5JZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCuVw3R9FrguxCyzOnAFhmYcjvVbFTlXJ1SEdsP7O3b8ZipJIlT7GpXC+d79ymXy66bsnNlTW7W1eWkMLbmTkZOqqpXdLkcXpoW5i1YteVt4x1kSF+aUXz6M9IjxSAodq21e1erexMULmQ0jabxj1XVJ8nthrLn+RS0IGXUbrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8SNyRwc; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8SNyRwc"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b523af71683so239755a12.3;
        Mon, 08 Sep 2025 03:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325727; x=1757930527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7UzRpURIuRgTvljraCf/vxpCIMLGtFavfo4dJ3/GB8=;
        b=V8SNyRwcVyrsIbCqIAy7IdUf4tGjyIn99iGnLEVhg6qK61RDbqC46Y76p8GW0ByHBi
         B1usy3QNm2OqMcIfFXr5MQzOzYMsXh4/273BonA8aDKKDx0hwPxLKWwWVhz6LEUbf7pb
         KJKnFmlAjfL1IYXUIZRFdWhaUgNvl705SxAU64enThY9RjIXE1ROMzS/ro5orcAjuVr+
         GO+JXIan42OxcSDPzeD6c0y/dWk9wmVRl0Mb5A7hp+aAoSHj3DYfQTGbj6K9jHh5ZTFd
         7aRCjGmG492qZPye0ynKWez7DhUPmr/92aqGQpQwjjKZddTWYOY5vRupICwZGt3x/bZf
         +fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325727; x=1757930527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7UzRpURIuRgTvljraCf/vxpCIMLGtFavfo4dJ3/GB8=;
        b=urhJvDyWuB7RobCz/FDjq3se7ZEv7eLPEByzViL2g9o2ss9hdbAA6s4z3g2jK1E4Il
         +HZM4QFRJ5ttXrClHnLaj3+PAKE6G8HMr35ZgLOnx/RNKF86m561TycT/14QhQPZy0V9
         1g0OVhREgIeX1T1XDtikg//qVYX+vVv2bECG1+2haUBDwY68mq8DZb8zYonL4c9xl5cz
         PaGXG65J+LmJsKSd93msA7pI7P5mrTqGtt44H1w9nLqLg+uXb59hif5qN6boYLuAISAZ
         u7dLgF8Gi1ID+gkxRvnxYPYurRe6Te8yM129nhAMElO28murKaaRnPK+DSbuXN0T2RLq
         0UwA==
X-Forwarded-Encrypted: i=1; AJvYcCUIV5CXRHwBnX3lj9hHzOGPYS1qvC3Geg42mwtzX6+SHqCADhIT7TsLav86s3iGmFG9mBYz/weuMtgi@vger.kernel.org, AJvYcCW3JOffxrjoxuVirAOEwO1CyWlQYGwkvE2QU+zFDXGoV1nNLO5iajxa9O4ByGs4+R4o3F7Z9in+nQd8fvf2@vger.kernel.org, AJvYcCXLQy7Z/GYflhqPgENhs93IzJXohm8kHRM4OJqAxY3FkM9WJtUhj2JBotncLP6rx0vPhr+JKLmOIw3mzX8pwRjORw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sf1UhYvpXycJkhARCPRmGGNOp0vTMZJBLNb+D6Xtg74+SKwM
	3NTo7U5HBSQxRGKCAys/Q/w53y+MVhV0qaPzrx6WUfm6+hh3rimRqHuH
X-Gm-Gg: ASbGnctpylmUxhvq2EQhXs3vSTpwjCtuPyNFKB3/V+FXtYYJtkPoY8ElzgPsMzBRhAO
	eRUf5MFi30DgAiG1/4HemtJjj9qt7mK8tvLOa5TkFgjBX+xeboqYFA0f2f39eiYs4eArR6rW+BC
	6DXtl1xz0ARV/KSV5SllOGdbUfeMfsQTzrMNTV+G5E3h5g8y0M2dMt9EtgN36vc7AgXWpq9EAcm
	4r2KzAJM52GxToIfgQkryOua26IjRYccolC0Yf5MHaG256Se+tmg57CgmgB+/4zwSJLtggma1FT
	HMNO6RFBfrXuVNg2JhoHfTdvk6e54jhNK8H+uyTiSNwvjvl3globOrJSUaKjTgcXQjOL/6NaZnE
	y+pfWOOl9TH8LRJlNiZxfZBtiH3IX5ePxlV6nPA==
X-Google-Smtp-Source: AGHT+IF8LpVXd+WGZEtF1C2T+vTa9TSDeVl3CnSVMFCq8UOb/1o28OdTA4U/neCjSXbyvg/fcm5TvQ==
X-Received: by 2002:a17:903:90e:b0:24b:1785:6753 with SMTP id d9443c01a7336-251734f3e0cmr81802185ad.53.1757325727130;
        Mon, 08 Sep 2025 03:02:07 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:02:06 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:42 +0800
Subject: [PATCH RESEND v8 18/21] arm64: dts: apple: t8010: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-18-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=I5bmZCvx8lSOgqzXisEWeIL6b++oNn2j9gQ7uou5JZQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlFQ0cZrZzPeRGtCygbH95UuIjln1JvwKkJN
 24hE/EOxKuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRQAKCRABygi3psUI
 JJaBD/oD5cXvCu2sBW1J09kC3JBBl28CAnlGWlecEz3qWOCDCR4tZ1cxWW3m2tnll3CaC7xlGu7
 PFTC5tfA8pMiz/mJCb/XZcqIg4WEU7QCxjbRE5azyf2ruTRo84eQxpT/JULcO6OxcY59PmSA7HQ
 BzlzXWiIngPq5ex4K5CwtOZNREQDsqY27ECGJUmuiH1Fetnhf7unUNbE/o6bX0hg48FO1SnotwT
 +Idf0JNbMEDMHrAzWwrnhZwSmQJ9tk1ED+AQo+idFCmgESTsdjfi2UXO858CcCvwxkdfcf+t5Ot
 hpAHc9BVLzeCaGhbZdG56La/B3tTDcWJmF8atVIdQYKq9bsveCRrPVi9GxNQVEovMhrlRJi4jte
 IVnYVenLFmtKcVrDBD9xKwLszBmrM/pYHON27u5fOh22I0D+YYEmirFLX55eMQWupggKY69Ww9u
 fvSuxrIQW1u7lI99XVZMQzL9T1CuVYHyBVgthtKBSTigZc9kUkWefEvHjF33M5gkgjqp8nki9il
 81mag0B5orFM3nSHKMtPkFv+Nn8RtQUxRtJEsk2ipOWtI7ckgSATmjLK1Gh1fwlTBV8NMhMRCNR
 CWBSJkIvuNSzwzpDZmCOGfhnPwdzrANKt1UgaZPuz8SecA/Fl+X6/JsAdk/83DLWwtEowYsw6gn
 x35Sp1wBumOXpyg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A10 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index b961d4f65bc379da3b215ca76d5f68691df06f4d..d187fbf7e7a214cbbc1027034efd0724ef7f8b83 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -256,6 +256,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t8010-pmgr.dtsi"

-- 
2.51.0

