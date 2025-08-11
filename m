Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04E222596;
	Mon, 11 Aug 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920600; cv=none; b=bSYFhwdxcEqO8IjgszSxShINayeSAXTLSPLAqH/SgHxziQvQHO4BXH27jmLj8nwHHUP8UVQghhJ7aDVh8MPXMyrzdzxYC3jv3B7lYwJjuC+LgzXxsGRPqV16At9ww9sWwLPcF0NxgdERZLYcT+5tt6h/daRxiAmqFKtd1G/k2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920600; c=relaxed/simple;
	bh=9j5ZxyjZdsR30i5iMe1iTApH7z3PUuNFKUIRS/3pejQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RD1W/oEct2ehAsCb/FzMenb62AGJMtGOcIdwV1wlDgj9Y6I5hf1KeglkBCOvHnD+V9YkLCZLqR5bns+hBsd/0hystACsaUSlZogiYC2r6ySm2jl47CrfYV6lti3yQ8F0zX316Ru1PpFn7Hppc4hxRPBZJX0N1Vya2zRbrHV/M3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElRJ6R4s; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElRJ6R4s"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd7676e60so3674673b3a.0;
        Mon, 11 Aug 2025 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920596; x=1755525396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WWayxFmkMisVE6Y9kvigFg2uNGk2FXDKQVXpWrzd7w=;
        b=ElRJ6R4sMccE2FjOTmYQ0zZv2Ojj9CQ55iUHn28u1GjhcZHuAO2miP2M7+IAET1fAp
         3qnZErey/ohQqgMeEVdjQXvoYY7CDISJGmvqjH5fPaoTwAHGBNksqySdchmerW/hZns4
         ybVtc/HBap0TwWgYLCO553NmtenIH6gWG6koCdzrZo1uxLXR9CCTqCpjWh7C35dBb3lr
         KyOXd4OIm9dm7eTslRuHbkhG55BZKRmVrWzjnrfLf+hKJN41p/AVl+FxSva5cd//Arjg
         46EKRx3rMLo+nsNaMnmzykkMrwkSZ/Bi+XaQC6U4Usr0AsDu7bP7d0xJm5O/PsEItrTy
         NYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920596; x=1755525396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WWayxFmkMisVE6Y9kvigFg2uNGk2FXDKQVXpWrzd7w=;
        b=CSKakqTcdhJQB6B7qqrzskmCG2OanNkdHYe4yNeLWDYkXnvxeIgJQEoUz5skFUh02r
         3jk6uT1yhXZXD/wv9SRpkyBCTixKVrRr36MpXdSeR6LZLYEuNPp9fx+xALc8BPp8ybUh
         sti8md2YmzF0nEZ6AFc1qXIAADjJ+DPLegFp4LORb9goB8GlcAm2bxEoofXbNTUD2DER
         SbNL9Fs1SBzym4bsH8BpQY1X/CIyg8uheua2mqMn8+Iwt+YNd/JNPCxCWF9kEHSRvPO/
         +5Gk5lEBpI253EbNdnL2sc5oIcDNijb9em0HMFPukYEyow/b31JF2fJN+hIlRzz8le5E
         TCqA==
X-Forwarded-Encrypted: i=1; AJvYcCUXOnTa9OyaVrMwRl/GdUgv81VIIEgWDdAaCE8WY+CWuvD+ULR4erGCr0nWXs/N/MWWa/jYYoVNSvRg9suLdaPlyA==@vger.kernel.org, AJvYcCVT1iL5FBjnSXU+XioD3OMzKZicL4sOdOvVQnEn8df5LDOJC3gxoe/8cVf3uJdpg691bh2J4h6AF1LWGSPn@vger.kernel.org, AJvYcCXSLZkOkMlTjBf8F2qNvoz/QaoNPkxnXkA8ydegy+GcG6CHkwTwES/1wZ2gTGd6iDyy0hU6/wO84zzR@vger.kernel.org
X-Gm-Message-State: AOJu0YyYH1Lvk1f8mvnt19hoeiMkXR4iGfwEihYkvMHDpepYPb4mNJFj
	Nln3/hcCb2eR5oxmlHOXiNiC92hEGKddoz46SirjeFmRH7hirG97RVKs
X-Gm-Gg: ASbGncuGtIdNJlRmRse3MnaZSQ2itjrhA5KEVwrNDQUEi+Qf5aJ7apsVLQQqfWxNULt
	nSGvvnvErKcKvs/oC7DaqAWrCCxQfX22EJGdrKwqjF+Dqu9UPrcnoCmFmg4tiCADMmJaIUqJq/c
	TQ58prTQjkP6Z11RFH6LG09mlbRhWZ2Y851pgPolaeFfTh+gzxxbq5wlAr+Qztf8OzkKoHbhiw/
	Pmq+BAstv2g/F+TssrXRUM7ZshOCWqXPcIcurqmFkcvEkjeF/3vLJIMbYFaZ2oVarB46j1mHm5L
	0e9AFO0ItuQJNUK248L6ZqyRfDAP1NmnEFlcOZec4IfjLRKBcqwvZIjsgc30LLyhl84iK376Z4d
	o+OY/74tX9FrRBDZS5F5BQD0QM39a0nWR+chQ2QkmPU/rpnA=
X-Google-Smtp-Source: AGHT+IFC9+qMduLHx/kv62D+AKLjqQXtPAZ8B1dS/GnXuolXkXGHpFTgCxFdBl8TxomEObWkWY+B9A==
X-Received: by 2002:a05:6a20:6a0a:b0:240:1b13:45a0 with SMTP id adf61e73a8af0-240550164c8mr20469672637.2.1754920596054;
        Mon, 11 Aug 2025 06:56:36 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:35 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:48 +0800
Subject: [PATCH v8 16/21] arm64: dts: apple: s800-0-3: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-16-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=9j5ZxyjZdsR30i5iMe1iTApH7z3PUuNFKUIRS/3pejQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZDVrNuz5z60KZnXAYs/bnoyBxXv1eeWTkKF
 o1AgDuC4XOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QwAKCRABygi3psUI
 JG0lD/sErM1lA3FS2AYeWQcYwHpgGj06MMxXl7uhvrRUfD5DT8FY/nhs6Cul1JDBSFjRzxd1eyj
 L2q8j875i3cnzub4cIsb7fQ8O1JqjgUB+5a1/4EzXbxZLW6WigUX/DKvZTwe+aO/fdVnNcbfa4E
 fmYdy22zICmiXJdXQ+Lf1rz9oUHEk9bs/w3+tyapZ6yxucM3Os9USjHDWhmYRvBYWF8Qg8kD9dD
 epbcvIcChhNT/y/nSRiXGIuQ+TMXOFACA3mE5sd3ZNkYLurUqoL6DcVj70vOSZcJDsuuMIRDH1s
 LvZUOl4ORicfJpniakAJFpl8s9bYQG91R1OL+VjGSjEOCd41A2lITp6PWh4142P5cHh3qzLjUQ8
 lDmo3HK6lvbRTIEHdyn2xDBREiK9HFqrpsyoIsXErliFprlbN/3r90Hn5tbZBXJ61T3/jN86QlG
 F0VcRmEBvbbl8caYC+06LAc55pk4N0QXnZJZ6lEjavir3NRBhqUUxSN0dQDI6heIn5lkX9fLAVu
 MU3Hk7/qMi5u9C4v/iSuUWhlKCh6p8LjzD8tHwpYkoyMRy+U0Du9R46AGdO+jf6QttdE6F0mvHM
 VwMHUfWhXXdC3mVV5YJrJRCxqTs2SMW5PlLYEFbedo4QJo+JaQnVy2rt/mTYfZf760g9850JXdb
 povlWWmtFl8dRtw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s800-0-3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
index 09db4ed64054aefe5b8f8298553d87fe5514e81a..bdb66f7e0de43a6a751af37c9ceabba44ef907d6 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -180,6 +180,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 79 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s800-0-3-pmgr.dtsi"

-- 
2.50.1

