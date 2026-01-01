Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950F2836BE
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258162; cv=none; b=j2w2lOwMcpwj4etIEcOvbEQPdG9jCMxJRepVkwFVh1IVUC0s2AIhkg2UlklUVJoyBsS2HYHTnsu2Zw8i/UZfggW/Nuk/g/y9gyVoRt7WoLBPPJSH+kkrhdr8YlDIhw0+EY3CRzRXpFN5UiUttaCHT023rDZuDXZKRhZ4GmJ1ndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258162; c=relaxed/simple;
	bh=07n0zpGM1mcRCjmEoORnP+p4Tv6Nx9ryjVOY1OMyuiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kP9bjm9GFpPAJRu5w/ypU+dofcc8ZHKDR+1DqFhhNx0QdbNre+L0y1NiigkqGq03p3i2xOXa+Lst529/Cbb+nkErbrIJI/W07OV/eJr8Tf1HvHtDAMUZdJMeZPVhWiIKjThsvCJg5NhOC9foI9GyLGp2SP+fRTJhzJcxWuQBndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSQVH6CE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSQVH6CE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso9036919b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258160; x=1767862960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBsTBcVtZ52Xc7+liwX/QWMHum7rwn6gjjvyLUqjbLE=;
        b=JSQVH6CEd1vbsGe/D8Y5q8ITV0oZa6ZmWkqScduqmMM0M4R77PihWjzMXghpdMItMG
         hLiPNNuuHlkAygDWPsccSxANbxgvtNSblGeVb9dQyEwcQ8NkLfyKLJcjYKgBcXHOe3jD
         sArFRtdxMAW/1kUGhH50da+0dfnXsXTKRxIL950QLoMM9V1NqMdU/H5QPqj5k8oB6q8m
         TRJljtRtIwREFu9qEBDjPlyv/jKOSlnLfgnO/3umr52RyDCxVDCV2Nv/uzn2DYTWsmQe
         bI0Dsm23QNPCdnCf52h5bBvjwobIH8oJ5H/e/OBemtqMkbirM3eMzYyJ4lWJvENmf3Ek
         4TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258160; x=1767862960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBsTBcVtZ52Xc7+liwX/QWMHum7rwn6gjjvyLUqjbLE=;
        b=rh98uoezlpwPnSgCXbBUBHg25ztn1WU830bmFeRTg1mz5vOWMoOVWfnJ3qh6E+Bkwq
         EQN77PW26HFxRFA6nWQCN/BUCgNhKe4sA/hUD3EwVeW6mSPyRMY4dh2IxJD/MXtu3V0m
         3QEcbbyG6ycHe8ju5CORhhbD5IAeyx/77WRF9r3150YLeAZBR6SScjjMnrLP8aFUim9N
         igi/VTQejerTCmupUYc1ZfiEfRr6bC1P1t8TE6DGvIBwmm3FRCtZsmCXO7PG4iV+96kY
         iiSWzZ7I6NeVc8ssO8VpHkizX8Fs0XfoyftHb+B55+myBXDooDXwrXpQm/6TUvEXs1oC
         Y4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWcme7gxZmdduCgzmuEYX00KVcpHVg+9hQfx/702eiz1x543i6c5GclYe8dSzmdI16klZAnXdtnKK4+4o11+hdW@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYT2DeI9Zhl4CjkxEAYu8Bv2ZSdxoELuv4LnJwyfMkSfiFkdM
	veEOtrkB86e11S2zyKKEWfzebtHbIUJuGfQFPMeN0H6ErpefDUsAA9B7
X-Gm-Gg: AY/fxX6Xlv7bdj9hdfjEX/R6DFvBa9cUEFvy+D/YX6/Hr4e6Z9EXNSR4E9jq6oTB1bA
	gc7gp2aXu4FdCW5yPPMBnW+kDmEigOeMGNx8C0auvKs6yl6cJl0AT0tchGryibv9tijKkvnv7jL
	xh35tR1riVYfPbThUhtPuF3JrNgdskY1OdPHNzmrY42CSv0DAuQgBLgrn90Il/w680VP3FI9cCO
	yQ7cxWvSzXMNWdJJVTi0xKfFVd/Q0DBEpjSUH2X23vYkL/WZKqmaI+3g67Ww2kIEx3C44eRZaDD
	sYVT3Xgrk1jWKEUbjn8VCpIz7gmB4aEt0/VTr1Q9dXXsk61sG4kcKo1otX77lTcnQRfZLXf9xet
	LHwPHqTNM9nmMx4nR7OdmM49Eb4zk9zjYN/w5bT81qSrML1pRHBDio9jsPPNnP0AFvkqOOCO1uy
	wyeBr6O3OoiCJW
X-Google-Smtp-Source: AGHT+IFtoil+3P7aWnRMIiq8mqybLoG4UdYuQs6Y3uQb/Jyici2QQ+OBrSKeKnNpXmAnFflhht0LDQ==
X-Received: by 2002:a05:6a00:f99:b0:7e8:4587:e8ce with SMTP id d2e1a72fcca58-7ff66a6cd8cmr29772792b3a.65.1767258160250;
        Thu, 01 Jan 2026 01:02:40 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:02:39 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:37 +0800
Subject: [PATCH v10 01/21] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-1-48812c529ffc@gmail.com>
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
 Nick Chan <towinchenmi@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=07n0zpGM1mcRCjmEoORnP+p4Tv6Nx9ryjVOY1OMyuiY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgmRsRBPdL9/utiE0nqPtsVdLeRRqetK9YcJ
 ZMgjrSR3kqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4JgAKCRABygi3psUI
 JF4xD/0QoWqxkZH1Wn5QnoPV87CkMp55ChVhudxMJB4SC5V7Dt+HrAc4pSd7nFd+K4pPeP1qwbG
 0onYYZ1veiVkIAFlQsUpB3a8jGT90Vru0U2MYyIrv6kUYWohWOAABi2aNG5omb2G5Nk3MibHtpd
 rnmNJb97uGnUepEd95Fm20xBETKdOWHmsQ4061B9YKi9SIt4gXHPDlHMNUhIy19RNz4veCpzW/V
 +FyYucydUfvbOrmRFIkosShp5AHD1RXszDYIAEl1zJmLRHZymEXUavxBarEYUKdajJ/3+nvFvEK
 tlgApSDE6OHx88cvWjkIG+w+a5IuDUT+lTBb+X89PQP1h4cc1PM2a9HSPDoLN1dTrDA/UPNs6AZ
 /tjGneYg4Kgu76qanoKeZQTDwuG8iq5SyrT2mMHMjM9uAlnPwRm9KxiI/AtMQ2rYvlVqqXazAgP
 sHf7GgNlZjaE4SIQgkXm4EZN8wrvOBrAPOMUmeOoWzDXYuvBThwlZXAbCJFJROUTLsKEOUWQt6+
 WsDdb1MllmQlEl7jgopcMuD0dxR/s8Xee0I7UC4/KAtBWwrKZEZvQLknULROfmmCPyCNEvVfNZ3
 poA70X2OklbJrD+UFtMMUxVVft0gzk21SwEibpkyOc18DW6AyXoBFwusC9FpWoym7sAZcHHVNOC
 hygUle0lWVEoscw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Document the compatibles for Apple A7-A11 SoC CPU PMU.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index f47baaefcdacfd37472926ec6994c33603163a44..97800a991f208448aa4bc8dd59b45df2ff35b400 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -22,8 +22,14 @@ properties:
           - apm,potenza-pmu
           - apple,avalanche-pmu
           - apple,blizzard-pmu
+          - apple,cyclone-pmu
           - apple,firestorm-pmu
+          - apple,fusion-pmu
           - apple,icestorm-pmu
+          - apple,monsoon-pmu
+          - apple,mistral-pmu
+          - apple,twister-pmu
+          - apple,typhoon-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu

-- 
2.52.0

