Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E7303CAB
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454332; cv=none; b=um22E+ud1k+oEb/WIWT5pbvqlCjjvSyw7sXgebidj5RACfaLVEaEPxyLUUn/f0qeNXH+PbFixYT5yPyy9Sp3P03vp7d2iN9YwLxReuxHHGwwIhpGSVQmA5UJlu54Jp4mxiPlO8adP84k47z2gYyov+LfdM382uBwhR9KkudBAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454332; c=relaxed/simple;
	bh=aC00DD3jiZSVPA6I5+G806JpCyFv8tDWkvwqkbp+yEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WESm4YaF2gh2X+T9vq9hEH3/jfmILgI0hNNbqnCC5yS+dLttY6GjqJUyW9WNxFJXsU3FJ6aEut0bXItjFDofr49mGptpirRNpn/8SihF9kAFaxTWDf8YX3uIYFNzgM+iOwLPw6eX3fnSpdSK+PRpgjUk3owHe+ZCTD44jpFrvmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiJoUKNL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiJoUKNL"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4347293b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454330; x=1761059130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/G/Lg7srDy0beJ935wpO9N4JjYVVtt8v3yHlGagArU=;
        b=BiJoUKNL3Xsl97qEd/TblDRuW0w20oeAiQAA1sj3O8VqYX2PzKLgxfUPEitY43dUW+
         EuJ1a90tQ6DS6BVQ5fgxsyY0e1Ts0VO6F3E3SPSLwBkS3BXfogGD9ynFf5tdYFe3KXg7
         R2ZzxzVFmt2mm5Tb5+jh8NQLTTruX9IhQjWcFBb0CvnAAdOsP8PToeSC1h3f9LlRgPxb
         JPIvLw3TjE9+aFH0SPn4ADyvw670n75zMEdHZaxZkDfmGaAilE79UPa9LLerZ4unfgVK
         +bLhB/3v9U3hG0n8DCq5VBsGGkf30o2X+BXRxn20QGhGML881FDTqjM8phuQtogLZHJR
         Cv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454330; x=1761059130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/G/Lg7srDy0beJ935wpO9N4JjYVVtt8v3yHlGagArU=;
        b=FkELZrNMWoqUmRXFU8HzFCI73FQ3l7LIzewIPpDkcY70LEN1iYMSFIXxWlipV8LFi+
         nT2ahv9HJAoXdHfqE8gg0L4vcQcEHmR7OjZab6UKgUPgik8FTgXFpkGQoqYn0VgzMvMZ
         8V+2DTz9avqgdTpED3Zesda05J7jxmkRjfE7VDQ+GlZ85voTT1Hj3BC0b05xVvlI/DSR
         YmcUhVIpwV/MA79wTT3VtcvRAZga9yIHI25SIcyk75EpmvciFuE0lBih7IeWLxjwMmXQ
         XNbRq0lUVKk2OXslt7lHmr3rs0yC5tR7Nj7oP0ch4pYwkcrR0FMu817gWvavjPaJsGMa
         QC4w==
X-Forwarded-Encrypted: i=1; AJvYcCUsFT3bX6LzcCdMPzahFYfm/F0nWJLDzWZWs7zyftWupwf7lr5P8OeVcJhHNP/9LQnsh0YhtkdF2ouZPCdroyio@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWt/I4Il6zSwWwgeNxxxdoh19EvJ39kzANygmteXD29tQtFi+
	S/vDlmFHbnbPp+iUMGC40garwgmxdJ/qSg5KGyCniDtpJQcPCE2h2AgH
X-Gm-Gg: ASbGncuoqoZrlCycQfvF3anSN+/pNZ1rKSnCZ/RnHIkZ1gTg4uB2IDs1zvhmhdYxjMG
	n+hXHFqb8Awlzr3cvjHA1EN05UxIkXPXLvlCsUXou9KnRatRAN6rOm7GDx98OQMVrqs04zlO8xi
	mdbLn9exZJ+D3EbMMmapS4Fviqt4AbQgC3QIHL/3TGjBbf7iNoOvES+jemILsxPbXb3qqKqCp4r
	UTA+5GTRS/sMk45IdnXd76Hot3C4tBYTPhBvYFLVEq5ez38G81joh0EmhpHvYLpO8iq/4geF24s
	cy5X7BXr++pSphMFVYL0twyJd6wm7HOaKapi3sb0B7bevBKeqqU6D6/Unj7/FM0yt6DWri4bMc2
	oTyKHTMx9zikx+R5/xn/0ohRvEhw70X1XuBAgCG80rj4=
X-Google-Smtp-Source: AGHT+IH4HBeKhh0rs/WsBsl8Ozw9jy+22oWE6s7x8YS6IasXPfN4lyvr/JwIJU3w/u8b0njenNKsAA==
X-Received: by 2002:a17:90b:3884:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-33b5112974amr36908126a91.16.1760454329752;
        Tue, 14 Oct 2025 08:05:29 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:29 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:53 +0800
Subject: [PATCH RESEND v8 20/21] arm64: dts: apple: t8012: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-20-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
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
 h=from:subject:message-id; bh=aC00DD3jiZSVPA6I5+G806JpCyFv8tDWkvwqkbp+yEU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZvaGEqO+ZN55ucW9OJJdfiSgXdY2n6ZdLkV
 GGDjJh23h6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbwAKCRABygi3psUI
 JBpoD/0YSyScg6oLOOGpChZtwSJeca8rNagdikOaYnLGKmjW3R7hJi5e3gdGkunPGdPyfk7SVPI
 EmVSWxvpMzLwYgd8uVw0j4IFIBIl2Toxd901AgnsGUO/gBoILkvz+lzF/Px2HuO8n9scQMiS5pM
 7vdWYHXt/s3f2DLx482Ja0H8BdHULUw59x87M8nzGlStRpqp/cFGmeRFwSQMSADPgaz2gkYuQJH
 f2bA+gLhHnz2qJ+uYMiYQBOj9iK0oa42bUdXwSiqV/DXiFiaO61DreTME4PJaP384XepWCg7jQu
 9pUmhh4lbnuqhSqNDtCUupSCaYWNm9EvBk1VrLf7Lfb4ZiKxIfMjjytjLDxchio8brg9Spb/IPb
 H30YLe13hM8Ofg2GcaTSowwY0npE6vr5QSxixPbDu10uaAhaK2z4fo3/V/qrVuAQbSQafE7KgL2
 amLqImtDuMDbBOMzDfY65vwwZTAqqCKT+imkfjt6HPMA9DbfihgoZJNGZleeFmYVWpu0mI4S8ld
 wLP6m4BGRUK6alHAGcHXfs5sROr8f/F7V8pcBOMHvth9aKZkWxNRjYJpI6k88eUEb4GnCkAGKns
 gEbC0XPjHQz/9w4kEILzGbXYID6au8ewy4bc/mBEUv+QmnwudYoopjOUAqKhNKA/NMNfoMkYK1Z
 x/RqjAo4T1ySY6g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index a259e5735d938cfa5b29cee6c754c7a3c0aaae08..fc87ab818d975974dd811cedde27292ec79f2c8b 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -289,6 +289,14 @@ timer {
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
2.51.0

