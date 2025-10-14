Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75D3016F1
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454308; cv=none; b=nsV6ufq6xZOeoGlkZNeYaGmvyDmRV+uBLahzGxocMFFWt4FoxmvJTSFGvOfJVw/7n4VkDe3tkZiurTBfpp/1vOc/+TYpgW02wsJf+3IsLt//eg48I3QwWaUy48ZnrcqjLWhoKJ3UxEDanPFGrDhEJ9cf8j7iNgGWQHiebnbrAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454308; c=relaxed/simple;
	bh=XiGGX/gYUODKcUIpICueRO0ZWhSBnplWOTrgw4sJMTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HDBq2hC6orQvUOjg+FUmqbsR6Ag9JeQ3bM7jg8DX7xpGYoQsuLoVUdp9LuFQ4dgCX/1UzOYODrzgHtTsPF2xzgqnf2uQfT4a8Rq7mnZ/okyis/P9T2OzbPsIL/PyyUHOOLU4rGIfyYHuqyUUxrMgGR8NURUD65526Mw71ttUc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE29QtUf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE29QtUf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4947788b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454306; x=1761059106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsMRt6a+0MtEqKde4YWuihoSzMbsHghVTF7OAbgmvz8=;
        b=BE29QtUfYh6esS518jkriPB4TxAqDWouJ+j9lxtf1ucD+1+HtXy8V7XdaT3hlLrJsA
         i+E5EGHpbQEBIh1I7e0IrdZVZ40RdJR01hZGz58OotV+DVtc1tejojX7Qpky791W0UhD
         MLk2iYfpfUnlN5jaFMoNuu0OOMfOhgB/k5knUYm+RVe/ievHXSvnFZFNoW7c6I+D5cI+
         G6B7F9fHYgAspAvq81HbCkLam9LCY80LgFTgQsF6NsuJDT7+5kcVNMlx0uNFQ6YE6rft
         j+TqfkxGYcmtMdjv1i8nFFPsCp8KaHjV8A0MQpVl4pz+S/o1HCtcq0hxSKrOqpGb/2oF
         fQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454306; x=1761059106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsMRt6a+0MtEqKde4YWuihoSzMbsHghVTF7OAbgmvz8=;
        b=fPlFUHSNZz1Gh/l5JK1Ij+a3FvWTLeOqClSm93sCxk8qe85Fn/l5uWdoqUj/0RM8G7
         5lTSfPhg4TExo6ffgT8EQr21X4V+xjlx3HWTVmp0g8EjZtv9vd3iJkC/FgMyPdzvvU+0
         afGWs55gJ/kpNpHEXdXy8JQ3P7npAe/IAUZYCeHYzKgIpDtqAPSUFIWuwUJwKtu/cCBv
         3svgoW6aZO5KVQOQCGC9J9p1w+KtMHEVoqmMN/5B5CxJ0KOSSJAlsP9xFxA89wBaHdAL
         ewGhBkbZtgDeq4S+5JQNMzh+8Aymj/YAdTWhwDJuxYYq2C0OeIJvyFlTcmqfS76d+Frf
         ws8w==
X-Forwarded-Encrypted: i=1; AJvYcCUdu0TI6VUjIgILocS5QC2PWzFBvPiuOCYqrNcOQT7yNz75632Cx8+W7EBMKJvCQT5ySsP1+9fr30Mt5YNbFM6I@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTSRkHyKr0DzmkYDdosRFAFxVgkaDydC/hEC4jP9/aYbBw7tj
	0Ayf5Ir/JENxiK8ZzjpGrlYRBZVOM5zBR+L3FlKEqQ1ZQXN7cbRbDiUp
X-Gm-Gg: ASbGnctHTM79fpcJG3Tdde9MYcuXzju6TcI1fwFVH3xKWMUGeXm944594EvGFAO/52S
	jEWe7AORczjEuKWh5CBVJePvCbjR2XdsnchQIjy2uH26ducvy+bLIvGHcR33M1n4h9K7EqIjSd4
	iXmhsgqrlSm1/tG3bbOATUZZ2qt6o0rCSQxQt9v0RXcmPbpIFpienx6SG8sefcYEiMVUxr+NOdf
	5gKRLvKPq9RUJ0psxeln2Xed3cdCKKaZTu8YwjIaaLpzfOIZVyKOXFMJp+srAfdKRxIv1+n1s+j
	Vpy9q5amMDJZBETiGQPlN3cR8VzX+Jwi2b4+aCIMGV738O/qp4BUs8AKT9nT4/+ixW0QNL2xfFx
	cJYcEMT2JcqmBz/lihXn0pFlnek94JccOnMU8/80pJ8H3phAVNCH1QA==
X-Google-Smtp-Source: AGHT+IHfYvpkP9qBYR0QxPI4MGOvmRjmBPWouaaIKnO8VsRvsEyRGrUKru6CiIL2ZB5M9rvBGZzptA==
X-Received: by 2002:a05:6a20:7d9d:b0:303:8207:eb51 with SMTP id adf61e73a8af0-32da8462f4bmr34021694637.55.1760454305535;
        Tue, 14 Oct 2025 08:05:05 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:46 +0800
Subject: [PATCH RESEND v8 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-13-3f94d4a2a285@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=XiGGX/gYUODKcUIpICueRO0ZWhSBnplWOTrgw4sJMTI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZuP34mQJBCd6DStjvUZPuGtGfYF/188yqem
 GL19LCKE4WJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbgAKCRABygi3psUI
 JBi6EACU9XHCs8g+4Qbt5yLz0F/EmK7cgyB1bpMgI6YWmKeTTXtIGIGFCPumMb5BOwQ2XU/cQhS
 pcNOLz7i0HEv7X/unBThX2PCscxe+9eSw59pvdHe4eEG+BDlHTFbIqZmPTzE2kMNZPLRXAGLdXU
 +UZWuG6HsNZSOknammazcOredp9P7t8+oCxz9X29YuMBXlzN6Tn95qwDmdbVUzuPBC4OvIY5/Jz
 uKigRJS/Jb6WCsRKMKx5v8QWbGRF4MRaBL2ddz8AIM9t73e0KUsnGG201jxuMUnEzPmQsxbngFi
 KdoT97UWsrW+eBqgVzrN/LoBPYcIGqskAcw4TRUmntFDVqi2S/cN3zbS40XpwnU9GNqwr798pgB
 ZYNP/Ay0Y1E2hbQJ4OqT8eEEFklsPT/7nw8hU+ZlcV2/2gIkSlUNN27N5M9fEULSRYK7hTYl3dB
 ft4GbH6QRVusX/oZVtoxaXQbKDJ2kvQw/mabUxusGg1CAsecpBDQYRky+n9DBIKRY+bqKVmWudr
 JrxS1XszQOq3013ZUOxJnDMsSMBtsekgfjST/EAIBJ4MZoI6WbQenxgZjTsIRFx7C7rpC4qazWK
 CFW4RAYAIuIArBchm8OO8dpRHXeuSnnWFezg3vOrr3cSX9TX9asFqC9xiSwxgfOcpG96SSTLWeq
 +9oQspGNJtE4Dtw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A7 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 5b5175d6978c45052ded495fc0d18ee3a8fbfdcb..1a3a90f7b9ded42e371ef0b41057fd3081579615 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -151,6 +151,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,cyclone-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 181 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s5l8960x-pmgr.dtsi"

-- 
2.51.0

