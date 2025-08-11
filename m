Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F82E093A;
	Mon, 11 Aug 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920593; cv=none; b=QZ5lnq3dw0HEdOGaLw/ejuBaf9vrRGY+Gf2kpSypOzWVUWFxHFj2ABQH1V/m5t/PgpDsZf4Rgwip/L7SpN4JO0wkmyyX38VKosSy5obdQ4ixJnkdTo79l3S7Oo9YAgDg6Y3AB7WaWP2Fa2BeDrG8Koev7jygCC6qxzonqkhPOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920593; c=relaxed/simple;
	bh=iQOR0q5XQVT28sD6ndbFpIVd6zE5nRLSJJDlvhWOuPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lth8IdvDg6PCVaT7rca0/XzmWuGMEHA0rWQIhrEDSVl9b6/doMP2lE9yAjjn1EsK7m/qcLxX8odVhOYwK1/PGBwZIKc2wegEq7Nqdl4Jv3oZaDRGDbAykNdy/C3eR6MsRpRbGX+GFD54LtMfOHqkKtB79Z/kqVTRP3N2FJFC0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krqXOHtQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krqXOHtQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76b6422756fso6117131b3a.2;
        Mon, 11 Aug 2025 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920591; x=1755525391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6IrqtgdxmO+5NxhFJl5j4k2CHU9lAmIsv7IgP3iuNM=;
        b=krqXOHtQtDTm2xKY+1+xV/mWQZp/g9MkqrXz5EWYE8VGvKVqq8mgi9YfYb5JE0VLKv
         QJMxDJbD4WpV5FkBZ1gQZJW3Gbxe8XGo3lpZzHGlPROsjp5AdMsq+ABUPvfGGJRIZQ3b
         8/1aQmZDKgOCwMrmK578F/FfrmHky/RgbFdnoaR4lFsgmklvbYM0Mc2imbRNYHjZAXjW
         lJR4lH46naB8hgD4gR3KxvQaLsk65QU26f7XWt4seaBlhDDLyuuG9mRti3JN9tsqAuDa
         m/IX6fR3YfNUNgBWgByrLGuDNLry1yzdTUC5AyNR3acfEtK7hDT19xeVwzk3cyM4GdG6
         +66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920591; x=1755525391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6IrqtgdxmO+5NxhFJl5j4k2CHU9lAmIsv7IgP3iuNM=;
        b=FusBLALif414Du1bqkE329bU+jOg2tCmT+1PhEtSivf6sbJIdABQF0OfAZKa/hTIew
         OuCqvsVdtMEB+lp0iKQjdWuWjb6uEewOl4ZmZjD9/f5hFT0b536g+cSzVn3DaurFW/Kk
         ysPvTpjojuez4kvcclv/62iLeMAEycrPAWYcYsHliqdAVjqhHDCzoUBxrRFxXnmgjaqM
         wP1pLkhXoAJeF3qE/S9bDm+du+ecq98EdrZG/WXwD05n9b0TGXYS9w5xnyipnhvn5t4+
         5SfKCm8WZ6XyCCwm1sok6Amq7RulFnwRz4AUyxmDlszK0EzHDVlIRmgYRFE5qr8n/QJ8
         clTg==
X-Forwarded-Encrypted: i=1; AJvYcCVlm2En5+4Sd3/F3GMcrLRGrTC2FttOtXwDFEfhobICAU8IhZN1Wop3lu+YyJCExtj3ENASPxUXD0kZ@vger.kernel.org, AJvYcCVrzVzE8Z/qin51fHSAgDF7DQMD8DApP4euTzr75cer+Uk5ULrbG57Ojiy/2E/VXzL3GKPWuxY1ZW10MyUF06UkdA==@vger.kernel.org, AJvYcCXp7+FHUaRZD4KbXkCVB/g9XUksqNVZShuTcauTxBDNyTdiPQNJwFu9jenUzg/jZ6tkUg6+mESfeEHTOpHp@vger.kernel.org
X-Gm-Message-State: AOJu0YxZq90N5G8CA/FUpSWR0RhU+A9rtGsRMlMe3+4qZtrl8mCFCBds
	AkDjj7i+mWQy3vF4LZaGzIWGZLD4yoFRHv5TdL+h6EsNFsvE7ZON03SM
X-Gm-Gg: ASbGnct8/z1OHm/xqOP9gu0iqwxFSsbFfEDgDEgzIvSDDm17iy2KAPPYF4jsMHBSerY
	7cuwih5X9HmR5GK1QC3+tFAriKmiL83J03s+MnA3AxxMQH9z4t9dlqk2deqZ14cJM6ro3dU0OjY
	icrS7yp6LpyWmBI/626pzzvLO3d/ise15PbP/IEYAf23+u0Cz2Xc50ev6i8mfgQyPATKNC19XNP
	pFA5/QqUY2VxOcSbNjQWCFzxxvUNV4jSyHIs08lsM3VPbpw7S4fgFr4apbSO5aINIm3iykc95Wv
	aXBmWgDCa2fPQ9pLTyennbv9j+Pycn8paQAPB/a09zQSGoeJqafrwUOcTpfwd1HtcRdZbPMYn7O
	DjHktRKxMJ5R3wQqmDioqqWmzZf1cg11DoreBwOzfjBZMDD8=
X-Google-Smtp-Source: AGHT+IHjAtQwP+aWp0amp2HAfxxavIx04Q6gDYhnOvqodiiQYDQ+FqB1PnB8IQF25ASHJIttNYsq/w==
X-Received: by 2002:a05:6a20:5491:b0:240:196f:35e5 with SMTP id adf61e73a8af0-240551d6df4mr18725211637.36.1754920591372;
        Mon, 11 Aug 2025 06:56:31 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:30 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:47 +0800
Subject: [PATCH v8 15/21] arm64: dts: apple: t7001: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-15-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iQOR0q5XQVT28sD6ndbFpIVd6zE5nRLSJJDlvhWOuPc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZCBfFOvSHEgUCXK88RXHenFtgNmRrppMrfN
 axZ2It8yUyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QgAKCRABygi3psUI
 JNI+EACRW8glfUF5YaGdOU0n3JljQH8oNkDc1zs0oE7c3+E9uNoYX9UiFiQlZ0GCHMCUZD6MFU0
 kgcgj/RKc/AspzvWwaG4Xi2rpJwIS+tLbtxZVemfotAixGxWxkzKQda7pC6UOqCAEebmOUIgAiw
 FlSRcJG9ancMD4ntZCi3pDqxbnqSEA9Rw6+IQDDMta+uRW8cFr1gL8fu1rf3ApyzJQrTd9aYDh1
 DFU6jSC4vvaMAOsezhn6RYD7wTo+nlVeQCPJgnXUtua8WlgLfWsWJmMkJrqv3PpGCwi0s11MdRX
 Vhz/+Uolqp1/GUcv3Jo6+37Od6QTKHD0nF3helJ8w+FdhdMJZXkG+UE0g6kqjWrNun35MzRUsGL
 p+7iAuLWmqLEXdikvzGmaD6SMeLLRiXYi9lG9EFXf/MAV3+vqye7a6kGq3CuLbyoCWg10SkTWA1
 eyKTs7X2axjRpX7RZUeYzBDQTefqqXDNtRDV/7VMw4+rykJ2z0ka2HAhlnzjUdPcKolIm6XA+BW
 MKyNmxUDIT7Jqe8YnBplsrMEMKN4kTYfhzv4pex0KucNLoQEInD5ntYuMG4UN51e9bNY682VtyO
 xfdkoBYhD+aXT+94+IdUpJxTCTyjhClJivuWi7F9Q/gXR/InabhRixJ4cU+fPWKC+A/4w0oHXBJ
 gjhLIu4GUWeu0ag==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7001.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7001.dtsi b/arch/arm64/boot/dts/apple/t7001.dtsi
index a2efa81305df47bdfea6bc2a4d6749719a6ee619..0e414018f5acbcdb10db92bec6e26ba32e53c781 100644
--- a/arch/arm64/boot/dts/apple/t7001.dtsi
+++ b/arch/arm64/boot/dts/apple/t7001.dtsi
@@ -199,6 +199,15 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,typhoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 78 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 81 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1 &cpu2>;
+	};
 };
 
 #include "t7001-pmgr.dtsi"

-- 
2.50.1

