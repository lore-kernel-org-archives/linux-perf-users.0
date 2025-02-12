Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E5255E42;
	Wed, 12 Feb 2025 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380986; cv=none; b=utVYhDmnzRzqIt7bCq6WpjOpsIXNzpXNrwFWzkuOE68VVhsaYIEBg3hI0BSH9tpybwPEc8hyRKvyzRhAMk5Sk5kEKhbU37378/9u0o3YcaCfe7ERyj3pIu0jhKHzLxl9Z6J54T+uYpjE9sFKCkU/6mpsByy03/Pqlo0yD6za104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380986; c=relaxed/simple;
	bh=xKNBKHADoFe0D0/YamWRency2Eic4YhwlS1J3poCzGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYVsYcG3Its9knFxc3iKQQdoYq0BInJMmxmrIwIUGDe7IRcrez1Co1uhRd+NjtlYGDVvZY5L8DDXgBH5j79hCsgfQpChD5pbwZ4aK9JUyTkqNAeQE51bOhyMQWKVybQrtC8zmLcvIijxgJ61bDooLXkV7Erx4t3q/SI6bPpQmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmtrChk9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmtrChk9"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f6022c2c3so19766495ad.0;
        Wed, 12 Feb 2025 09:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739380983; x=1739985783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCgOaShG88KaX9ZrY+HfMI5Bon6pKtYLqZUjsI6n6g4=;
        b=LmtrChk9DEAvh0uWixt5bilTvM1PPN9FmUDw9rKI0BVRsWbYHBqIyPOuleSpTWcs2j
         pUlY03V0CoErOT25O4w8AguqkhXBgyco+wwnKmIsEwtExGu0JenMMbRIgcuo/ypRRDfs
         c7POdcE1aFVktPBX9Elw6IcKboHi9MxSVG5opAIKEODy778/oEodJFI5Iqf1w21KhUro
         Bdb+twI5p8Nl4r5pvTtTQ2abSPw28wHATWjHK/qitkya1DldzIIGaJfTdpDGmGUOS6Dx
         KfPvLmujN4GyKdD1eRp25tb78XMoQzM/9bH/Yy8QnoK973TsCc+9xKu7vEe7gm3spod8
         YbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380983; x=1739985783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCgOaShG88KaX9ZrY+HfMI5Bon6pKtYLqZUjsI6n6g4=;
        b=Wc9zxZNUxtr0HQ6lQLoWDEPkWz65sFMMbuO2VT2RDZlmmZF6rkyc9COLj5Eb+gvzeN
         vtqchQxr5/TbVkljKfJiajgAG48mu3z2MHwivt8VdoNjE7Omu2nxU/s9SMelrQlumHez
         qwoOQfkKCBnAYVpqF+dzEYf0hTaGsOiThUhOVxglilYdSlpf4WZeo8BofV6iVJLG0qal
         ACWGP5Y6iTxJvTt6tG871GFGNzcLJH+U4aBruwxgoWbzU3D0jRrRReQt8b1gjds4bezM
         rrYQBFO45an/Hq6kADx82ZThA+jC+6qtJ2BUi8jurmqVwimUvtUnRX7AzV4O5gr3Uy1e
         12nA==
X-Forwarded-Encrypted: i=1; AJvYcCUUrLzNrF5IVhMfSY3W/5Zb1sB+Ct8w3Fz/lYyZFgXl0eXiFtuxz7ehqKg1jTULokkBEbPkEiP64w6aME/Bqr63lg==@vger.kernel.org, AJvYcCVbY5CqWV6EoT+UWLV4YVCsPyUFfgAmMGTneTixD6klouYYyaPiJzI05lGmlVmrqDHQxuaSSGWeI9eI@vger.kernel.org, AJvYcCWvp0k1/+i8/zfgSAqywm/8M5cCh9aCaq3Tixy7fYL/6Ouq/tLbcqcmH220X+oBH8V02npXA+mC9/4IEgMt@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjK8bthVx+qPbLY7obZ2CkuzuJ/XeeNzRayTmJ7MGJTP/NivZ
	ttBsLTI0+RnohlGfaO2mK9h98OIKpiOT+yTBppqGGbjo0GKREusf
X-Gm-Gg: ASbGncuLm0uEbeQwz45qQRNJzMGP5hurJC3vmXKuozco1+EkUEKuJW9F01rRMdmXPKR
	iagXNPKqU0Gb4Nw8+8TWPpq7Kbg3bSm2NYCbmUXOd9ktvi0JHXPxSvOigqV3vaZkugPKZqhU0WK
	uMoNm08rphZU8bFWItQu8qbEfZ91BCpiQ61L0WuEobrUz0RXpaWE8MsDaPskTtGx0y6LhlKym7I
	ANHXau5vZ8LnLGvuwzcxB23R9DaLAkPKs/MgrP4vDyc0QIAItgVef0m+5imzrK8O4A5D/riJkdN
	5O57cpNvVsSNdlGG4Q==
X-Google-Smtp-Source: AGHT+IGEy1jSFc7CoEH40Z2HRbFahUzGAgG3SF1zUBLy8tYFGnP8eFybnOnuulflEwPS88Om92TV1g==
X-Received: by 2002:a05:6a20:734a:b0:1ee:64c0:aa85 with SMTP id adf61e73a8af0-1ee6bae9454mr152576637.6.1739380982936;
        Wed, 12 Feb 2025 09:23:02 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6001705a12.61.2025.02.12.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:23:02 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 01:22:24 +0800
Subject: [PATCH v2 01/10] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v2-1-87b361932e88@gmail.com>
References: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=xKNBKHADoFe0D0/YamWRency2Eic4YhwlS1J3poCzGo=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrNjvWO+25WvZjqa60EjVC9mqSIkhHbwtfm+Dt
 0wHaa0R9XKJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6zY7wAKCRABygi3psUI
 JLWlD/964sLrzrYk5mzJZPYQe5C6BGPTmD69eecHjciATrYkefUjS2mNGrNwu8fFrk33S8FEtRE
 9pj9HJSteWctfZ6jMMOr6XJm1FI9KLbo9TVxRhnV2jn+rSpa+v7LXJvl4ihWFoG8jerRrt5ULgs
 dCx440En+aKZ5MWPwUFXzq2RMAFaFtH8O1Z6cChndMEq+MGK1fIiPwvC3iXBsPmqQpmF1y/tWYB
 wuyLcfHp8b7JzSp0p/6J3iWi8inJYdUl/+EGJVdGpdIRXkl5gfUGG5jIXq3YAe52M0n5qvC4RD9
 B6CL4BbtmIoAvl60FAdNMopJD7iritzvulBVwQV0XN1HC7tO6i0h9AEI/GlK8ufK8hhc+Ea6ZwD
 OdMol0Ub0+iMpogYqSYh7qH/18QGXBOxik6HQ8tXZMDMxdIhlCInGNezu5ApJfGYsyLebGFSrpQ
 Sxmo9u6yQ6WCYjzNNzRmArs+BatLYvUrcvmR94sluTAf31d7OIZjVc80Z+BgPA47QnffOq0vVy6
 SaEzELS2cfqOBV+wV/Ou1Xo7t70prXQeOhJ4Tqqqx9smOsyoYpr1Ag6cKh2oQCKbmLLTxzZN7LQ
 7ZqdObroNYRny61Xyy62qTaTII35GjEVMYi4vpB7WRDHsF9tqSZFIfB9Q+2uJneOMF0lCO7Odl/
 KV90+5FraX7ke/Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Document the compatibles for Apple A7-A11 SoC CPU PMU.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index a148ff54f2b8a92fa3fcfa78c1bcc525dba1c6dd..d2e7f19cf6a2d7d2348d163d37c2787c7a36bbd4 100644
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
2.48.1

