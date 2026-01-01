Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16429A9FA
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258221; cv=none; b=QYA+l9NZH2gSSY78PRI72n+NZUZUZlXjr+wZmBX8PnCUjdbuVnyQzJP5sGI7C0hz0FHb5ySKaOBfuWJ0xMbl9owW6+x6LwT350bqstkWwlu+OTzH09lIFEUKVLRbMQ8zL4Y4pmOPdfuXeXEzOAFWclaQjfR8Ujd/P5bWeXHllkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258221; c=relaxed/simple;
	bh=OX5KL+MG6sfpo1KjHjEhXoAalFtdpPr6gBFVJvOaFLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxRlqdv/gfwC6wvGkdcoux4NHHCx3o3U5nOxUD/OMdMPVuA3B0miz7h55XsUChrwZjN0sbqOrRzjJ38F/DNFh/Vv16t2XBkycUi31bLyivT5yO9lvihUPOGmP/aIf4a/ytyzLVTCc2Kp5bMw4zJVbbZgbboAPnn3EG+VooooqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMYn0Mb6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMYn0Mb6"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso13359191b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258220; x=1767863020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS7rXNvu/k+fb0x7YdnIE3Agpb80vBTRZvlvmIIsndw=;
        b=BMYn0Mb6/aiVIizePYkr79HnfnU2CdfFV7HsZdq85jjKvL+xIB8F5uJnUIfZYqiGmr
         mv1RyP9PpcdevEYZpKi8zMB0wgrDLSUJEW64BhNImLDd8LjE1uqP9yEisH5HrktF4ppC
         SKGYiIVev79YEEzA4GbmmCYCewb1EfJapXphBlh1piKfiYyfuwYwEWgqNA2sfeAmwTKK
         /6ag8onk2uzVPNjj3vHhCHKgkQzLrjfA0IWlam/MzWlgBcSN+SRq/uLKQqcPBRAFaQQK
         hkLPdciEFbzbgTcvEZmSZ/13Si5Oj9ZTW2yCEFRatVOdSu4Z3jE2g5Eub7J9HUEdnp85
         tXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258220; x=1767863020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NS7rXNvu/k+fb0x7YdnIE3Agpb80vBTRZvlvmIIsndw=;
        b=efoP2sWwlJQKxqUzTbXb+/tMHI+lbQVO82hji/yoZA7o1zMhEKsgkGnEck/cEyO1nG
         /ReK1cPSSpmIt1Xc6Qzf+H6vmeSSjyP7/mgGuumPHSgpJoGOildh8k6vimVFk8HFFF9u
         l1xEOnoQHTPh/S+c1j8dEzFvHa+fC/wWeyM1pS3Xr3a4z8Jh1X35mE6kLQBq7hVr6S2M
         lg3q+cWN/qyyiV7Rlq92g3M8lyKKmYatVGZdofZ3KnNWJ/oIiamounVn01G4j6UW6phK
         5rUt31wo3GFdrWWJ+iZJQXEFsLwgm/+drbIbLiCKDWQNK6IDVNwPnC1U30lVXl7Mnw3Y
         vgXg==
X-Forwarded-Encrypted: i=1; AJvYcCWKBHvWNikL9mP4b+AGHMolHmYVwlKETBAzlKjb5MP6lE43UB/qSb3G3+zQ+SAN2lBaZAe2A2PFTg2IvJOVnMqG@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNBjvoY3gpL/7pPUjDm8StmscwRrVCC4aiaE4yBSFWBQcHGHp
	B6wzazKpMalZ4QEwpDUImNPLVHPXjYFwRdexjDrT2tLauxfAUd8cLVDX
X-Gm-Gg: AY/fxX5gecdHfCPuykIvCiz9rzT8q69Qv+8jf8bVSfRgAZ6mfovnA44v38hcK9+nbmV
	DzKMuf8T3k64fol6hdbncBPwl3NzGI6XTtXwEsvNYjf7UUGm6dm9y8ysEml/CLgQosAC3cfZCD4
	UzRKgJG20drMLNWR4xLs46RhR3tI64/IoDe/G3vlUlqXhDEmzA6eHC8A9WfoRrjCSE+u6y/d3XT
	uoGNN48JlvK1gfiWVD37Y4Rl0CcprUG1yzlZ9PUQRNC6sle/InWIsasgEvrmBP5fc5osPzVccBb
	/CEOczoPGFL+ghR4URhfZsn/yikG4s6XfOfsJJJwBR8NbQhZDJ9SsVRzW6yKDbKD+i2v4SYsS2n
	Ib/f8eW/zLEmejcDYVih5HgoQGoRgytZbCZ52rBPYjqAt1znqlQiwTSa8s+DWvXofIgZ2vzTOR+
	LHs0rssL5w2vy1
X-Google-Smtp-Source: AGHT+IFe2eYmVWLE8qLLK6tWjkKXLBApqyzquQyvEELPpD7zudq+rhR0KNlRnMSRuoUBRZkLLMtt0Q==
X-Received: by 2002:a05:6a00:6009:b0:7e8:4398:b367 with SMTP id d2e1a72fcca58-7ff66672842mr21088807b3a.58.1767258219859;
        Thu, 01 Jan 2026 01:03:39 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:03:38 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:55 +0800
Subject: [PATCH v10 19/21] arm64: dts: apple: t8011: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-19-48812c529ffc@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=OX5KL+MG6sfpo1KjHjEhXoAalFtdpPr6gBFVJvOaFLI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgpeeS+UEfUxUfudtiuD+PcujvuHezCHD5z8
 x9ladDrvDeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4KQAKCRABygi3psUI
 JC+uD/9SAW9UXMI8I0m8V/UHzOCtWUTPWfbNC2fPY4pLYEu1gNB937JUCCFEL5QoFfVRTabvK15
 RaBDG/EzwT4YHXcHyPN5ehspY9NIIh6kUqh1+oN689J17ZkRtisRM+N391Qfgacwj5XTjypx73O
 y4uihlGk+Ha1D9WAzs7L8OWyVGvRuxZIoTqUjdPWhKgHPxO2KweN5v2giZOpmJ0T1w2uIjjGaPa
 F4yli6Q9Ck8Mx/wQ3ls1nuA7TU/21leS+84f3t0KDBQTByLZTIv4/FtfKcZdncLjlY87evXI1m9
 2l+fLDspjdaFUMWpgmDsLCoir39s98aqLwa8y7M67+jre9zBXMPpHCwK8IDSant3skHQU2mioRF
 QAEsruAQuPI4u94MAtgtfEm3jmL6EZoz1TFRWdo5alsh09Z8/bFFIrurHAAwOrM6ayecJyIlxbt
 YDKh4UZTSvzHeFqIiWudQNuXu0bAZKN0S8VGQZGONe6hPUl8PDbf8HMWLTFIsLakMUSkhvime0a
 Eo3/STxQKgq2S/3rnHxyKSATl7/IdJeZ4QLz+UzJn8VLN9r0We88iZHVfrw1TCZIdN6DIzM5tUI
 lgF3Vzr1oA8AAdrUCjMWLcd0HruyQujEoxW2QLgzBSSUlxTEP4NvsVM/3TwdkIAWalc9qjlWW/r
 tbo3bM8BJ14ggAA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodse for Apple A10X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8011.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8011.dtsi b/arch/arm64/boot/dts/apple/t8011.dtsi
index 039aa4d1e887625e7b6ad789bfd9aa032dc58d01..7f7b0230cd648eba2533f860622f683771197bff 100644
--- a/arch/arm64/boot/dts/apple/t8011.dtsi
+++ b/arch/arm64/boot/dts/apple/t8011.dtsi
@@ -329,6 +329,15 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1 &cpu2>;
+	};
 };
 
 #include "t8011-pmgr.dtsi"

-- 
2.52.0

