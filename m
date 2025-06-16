Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF01F0994;
	Mon, 16 Jun 2025 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037602; cv=none; b=AHkxSTTSUSsFxdEEctqAYPtPJyg4oxhu2q0NkMXSoi+kOqwSh/T34bXLfRycP5IiIotsMxQWOmSmGwheW4E/gmlCGPQULNdW4B5pt9czjI08l42Lh1v5odfe11f2dMtHJ4ZDAV5EBvsA+6k0+tZur7TcqZqdynbsQ42kMImCSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037602; c=relaxed/simple;
	bh=iSgQuvf9kmSTE4D2ckw53TzjQOR5RrwNb5r5c6wUTAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFuB9uIYQXL3QmcnsdT8SuVEtMw8EQDrLz1qEmgT/ib1kmhyMWSnAZmJU8diKWQ5dZS5kokivFe98ZNZXEKP2qMtHA3sJaA3SUB8ikM+RQiby9qZe/H+Ed7uvObQ2bjQ2Jfjs6Z1JzJcUN7Fi7kl+lYla1AtKeP+mouEXrtO/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvbYUqAa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvbYUqAa"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2363e973db1so39289125ad.0;
        Sun, 15 Jun 2025 18:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037600; x=1750642400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbV9nsv1jvdE6TIAVwMdOO2R8WMK9uKpowquURgrnXA=;
        b=YvbYUqAaIDNxGXf8ZJ5cbEw7yr2+pZMNjKlqyW7hAjmsJ7qgxO7cp4CWf4MfrJO2D2
         phHURSHhKuMN4H3ku4Xtv8OhrQmFWUN6mVA3wxCiF5xiqHQVSPZmIriIfCTK/3dQv/9+
         ECkoS8JN6GvaYRC/BDcNVZwtaWBeTU04RKQ44msx5OTDp6YuJlOxyEHyj7yazqhNRkOl
         CT5RxFb/5J9EESAY05UYpqDl1bkUf09M7uuRuDSA0sTSQfuBVxPEhI5UPIsW8Sy6FK2H
         TFszbkFygtqlRi2HY4IUHDynKGz68W5IEPcW/1WOsm1eZeMOijXzgs4QYi5WsE2hvIuU
         QXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037600; x=1750642400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbV9nsv1jvdE6TIAVwMdOO2R8WMK9uKpowquURgrnXA=;
        b=YuMiRBPKH94UoDYS6uu7PjqOLBX+x/IfxSW7Y05prdB9Xxdy7zYqLz/YlUgeV/a8/O
         XjA78TGcv871NaLxwOUmBTCaTTRO7r8oexVUJJHbIGH9Ga4ZQ5QCeL7MDKqOY9jYSWWU
         tFJhnfge8rlKWj9TGWtcuU+TmCjTt9KLmPYvoHNKGBHchiO/QJjBT2RJj05hQnW2QCJx
         C5DrDhRv/H9LXQLq+PhNBjQCtC6otJjbMyDlyH3Ndx+PhEAUSWNdbaVpFkCnc0V0eCck
         m1unDuujZnw+emkve2I1+dwV9q9JtshsuiOAMBFkKTDRNyHwjcG0vNrWJQc8X+hgGNeS
         EJSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4+ogUDJj8+z/z/bDgNeaI9140DdnkT0/t+ZUQtvL54D+gdhfOOD4Md203MmOmYa53zZ4ZppbY5VZZ@vger.kernel.org, AJvYcCXVpSubknvalrwDLBnmwfdtAN9GizZ1YpnLiTdH/yO6O2Myd6at/qvfXyjxKz1Ehkry39yb6lF+0EwjQCbo@vger.kernel.org, AJvYcCXW0HO7jZGid4oCzieCsw+VNIPqUu6ui8Y+Phu+mratHA3LY7b6faKVH8OMsWoW0YHwWYDWPDItfUMr4bmA9QLB2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6CvqHPPnFmtZEKntz+ZlW4S6tpjWkGkVaqfqkN9SPsABM9Pb+
	iorBfKuILyHXpKu0EQWZAkU4GfBemNmZZqTNkZ23tFFz25SBenCqEukfAG6hPg==
X-Gm-Gg: ASbGncsDUdtyezn9hYBFCq9qzoXr18pCaUYeUTz/uGUSjATtFgsLChBgQMeoLuCIXLm
	/I1hn+NSx9ueAp9HVs0modQKwdLjaLiDBEEIpCjesSlbtpuMvJHEmzv/O3ORb2CFu20bV0HDTIP
	mlFx+VmXTDBwkkXpJjPY4poV5+8ATArmRFOHxrcQosI5o0bZLsEFz/S8Z6NFqz6fmCVlaW7HpXk
	mfcajyS/Ms+OjrbBdztubXzGCzTKtMVzKrxLVL1IlQfeUZmb1ZLh5sM5nhKx2QSGT+H8gENgyfu
	dmI7VJ7OO2bqhPH6lkQw0Bmkm8KDi5qzUsI0BtqqAr+uTHrjRAn02KrnakZxvj9SiS19w6C5M25
	v9SU=
X-Google-Smtp-Source: AGHT+IHwac9QTGWxlkC1rzZ2SMHVmAjfvFm/k/YvsDasORNoNjPp9i3crC4psW6aNolqCYQjKg8vrQ==
X-Received: by 2002:a17:903:98d:b0:233:d3e7:6fd6 with SMTP id d9443c01a7336-236678a6edcmr139967795ad.19.1750037600015;
        Sun, 15 Jun 2025 18:33:20 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:33:19 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:09 +0800
Subject: [PATCH RESEND v7 20/21] arm64: dts: apple: t8012: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-20-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iSgQuvf9kmSTE4D2ckw53TzjQOR5RrwNb5r5c6wUTAU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3Qa6p1xENFWuaERQyHsdefacxc1lUVxttion
 +igFpn0Z02JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GgAKCRABygi3psUI
 JEUnD/9OsHCyPEKi9IsB1sRFkIFSwMCnJxmhxXbWNlRkpOPFr2HE/5NldQtqGVk5ePzKhwmAMD0
 RiL9IyxqhyYXU0zWo5aAHBilDRVIBOHWOETE9PyFhBtpJd67OMSzCfRHe1i9yUm7ijtX+gEaWsB
 QWl+G4//yilBZESoVxJJg29wAGDw89dgEVh2di6N6vaQ4rQFEjBlTv+M0fvnkcYipZteLo75Ot5
 xD0qG1fGN2q0JKcsZrfLB9TLxQbZAtUL8T3N190LSiYYSrUBe2LqHdG8MlF6C2eoAQC5RGNARj/
 R7EuIEqyA29pQoBsk5VWBnmQfnv0gOYEP2orq6SGF5obhrgSLQhgwMfmWNPjp/RS7jUiS9gmgzN
 SwWuCuMo6iB0k3KnIZs7gShT7u5jwlazrtSzknn8VHRrQZJitk2hnL7K1uwN54b5u+lrSM4P3Hx
 dOqwYVM/fmFRmldcL2Udf3MVMvFFWTjEe39GJcY/STrS9p2GND0JpNIg0G0W8RmTSTZbPZXWUmL
 /8l7ctLDuXyy/idnrADdgJD29QE01H6Sf/ZnkbgOWtOprWiuSj/3fbzTedrLMz6b6/eHsjGY6lA
 LNokQE2Jzrs95Bz84eiZQIbBk7KO2o9HDecKYjKmJ4oqcVIRYU59pIl50hZLG9AykMmeU0eMzTi
 CSizSVKXhOCwUig==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index 42df2f51ad7be4c4533e76d18e49a9a747b6b7a8..d79ed754c68dd89fc8c52887e6dcbbce04fe126b 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -276,6 +276,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t8012-pmgr.dtsi"

-- 
2.49.0

