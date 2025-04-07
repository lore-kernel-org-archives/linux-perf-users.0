Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAC229B2E;
	Mon,  7 Apr 2025 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001235; cv=none; b=GfzLd7GJof0chLN7AJFslugD5SPvAe+QqMUqX/quOHjkg6ZegRpCFSpw6+ub2sXWZTodi+xelR8tPK6YxSd/Q9TS2fHivwfmOoCbRYuT/ohfL/W1I03dQ64kPkprrWVlOyTfzV8vYXmp9pbmwQksj8dbVkavgxyOCIgSxG5AmIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001235; c=relaxed/simple;
	bh=ZHoXysjC3tKjwBhupXya9t0tvevKJFeLclU2Q2P4acg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0ix7yNPiJKzlcNrnorDRRp2SVjA7G2aeSQR9ruSWExeu0XeZtKpet/QK5yZt/X9beUcg6AThQhFINxUPMEHk+Y59F8DlJMnXwfgb7olnmxagOJtsSVZzedcsHnXpsossUg+2/azaFepYsNSIZ5yIeLiDQS+b0dQ/Nd4XMa07bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ8en1S6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ8en1S6"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224100e9a5cso38510655ad.2;
        Sun, 06 Apr 2025 21:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001234; x=1744606034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgYxG+vTxBAlApfr9OfPBfVTpSGem7njEO/S/STMqlg=;
        b=RQ8en1S6Bj4BR1AblM/TJTbtob50w+6lofXACKKMO1Yr6qyT1y4MNXja7ypfrKH7Eb
         ZihGPlPmw28CO1JU96GLM4FeR2McGyZdtnknTlfTOQlmLPlH2s4BjibR/LOm+I9WfZLL
         PIKdCjjJ8zG3Xjf9qxwqkKEJbOKY9DqfOc/zFBgVntoZRYTU6UYhkHodZod+TOaGPcWn
         HHGRWJrBXSDGJtpaL/X9w0H1sHfFpdi+9QfiEBcsRtj5qWx4lRjuPQhVBIWoQLbM0SlZ
         Zi3ACB5Y6cl622KiqCv9/yhMBoYjr8Azwvk2vQuVtr8+2ioabeBvxRVFXT8mW33iCbrT
         Sksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001234; x=1744606034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgYxG+vTxBAlApfr9OfPBfVTpSGem7njEO/S/STMqlg=;
        b=Ua4ksHMVoqOeSpJbQUxzpvKNSBeBXSKJypPlRBTGFb25nTHdMLfwQJKdbATX42Kmzs
         E4Q7E0yh8NZggwu+qHgxA4wK3qy0v2L9Enc+vz8mEWnct/7KVz62WUJHOHFD8V7EKeF9
         yqpMayeJV0o599Z5XmajqHTTbHBNOxArKaNMye4fn6gwpqIZHG98g7Y7Qxey9TF0JnyQ
         YGodli/Y4lUGzYl+tDny+FD0t1lIJBMSLu3YODIUhIcIwWMn7mvfYjKyjDEFCyw6N5fx
         90XNfEfUINiv3tgliNJ5kvlEEtIC/Q4pYsMj80Eopr97ErshVAbVB+t4+DA7o16lzAR5
         60eA==
X-Forwarded-Encrypted: i=1; AJvYcCVEE7tk038uAJqsPgTrqHpiwWydq2UQDhPrzBvSRI/fKWvRPqYjW+ivwmCKrAd71UOBLw9+AipMLkBDVvuM@vger.kernel.org, AJvYcCVUmFYL5ncObbCTKucpAmhXdAdeIeER892dNBDNkNz1irSzZ717muzMec0JlkV7VBH7sIo2JWGUDPhZaGzrslfl1Q==@vger.kernel.org, AJvYcCVnGJrtoPusBB1FHuPv+F31FISpOzW/xN6Wu6nUsX+/N2TEAsaBgIyJCAH/0eVS74EAEoivT4objZ2H@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0rxPcxjyooB3p2l51OgpHt0sHp6kDEKnVOv8PVX3dKKXtceI
	lK7pfChc6en0MpUCO7YmU26zlOG6j3vaAm887NnVoql7lT4A2qNg
X-Gm-Gg: ASbGncu+jKM0gYOGNF2+pT9NEXqQxIU1EAQJqJsiDitbCDuD3673HtbYjASMnbyegg1
	0vRzpCAe15cIXjJcrubTr0JjYIWvZxi2q52yZsOuaFLc1dhASWNAkKntTrgEi8s+cv2IgQj1nS/
	4iL81pxr33TYlXjxvoHJiyYfzdXhpnVl4WNwpm1loKQsEQzsy3KKqIqN0jSUjr1EnFtadEolRqu
	bMHrI8v45zLbh1cK2ggSniLEgK4QI1kI2brpMnJtw91bG6E24FZz3YKZYTSaWTxJjk6EI29417Y
	cn+D4TJZ6coWOJfGQ2ZGvYcqDpgZqKirDWgLMBTIDEyYN7U=
X-Google-Smtp-Source: AGHT+IGVRXDaZv4MaSqiCi64YlbFNaNr9jW0ETVrxcDxHOUBBfHyhpbXAoN/raHDXUOn4FNed84NSQ==
X-Received: by 2002:a17:902:f705:b0:223:4816:3e9e with SMTP id d9443c01a7336-22a8a8656e7mr153126495ad.13.1744001233923;
        Sun, 06 Apr 2025 21:47:13 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:47:13 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:30 +0800
Subject: [PATCH v6 21/21] arm64: dts: apple: t8015: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-21-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZHoXysjC3tKjwBhupXya9t0tvevKJFeLclU2Q2P4acg=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iIlNNKyQ70bdORJ/DAimDpZx0W96Yy2ZPys
 e7RrOF6AcmJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYiAAKCRABygi3psUI
 JP/bD/9WqrXV46Nv698aK45neuhPCPVAAc3Zr9tC7sjf1zp0kioLkofK6D7l6saQtbodG8jx1FS
 LMgQbxRn9DZ/J84t/w2rAzHNhmLwYbcZ8tZOxYVZS2eGFT6LffyzMAFAMe0yYJLVZ54UDqZh7NO
 E9sBG7INDBrYld8DtQvmMrz1Ior/Y0LfVO6vKfi6kcEcf0SF6HNn/gBZdgUTZLrpKgS02VM/tbY
 Cowa7yYIzwpJ88bllbQcs8gQlnNTidfz34h5gcxooIl2amFFndI1RxVihVTaPMJpKDN+ki9R1EM
 wEBj7B2ayLyRwgaCPZ/1fAeZdRQ7U46Tx9U7qLWgAt9jW0S6s1MN7PrUflv/VTyFMQeTp0ULyGy
 DkGNUU6ThWXz14WZ/FYItrLBlVqaL+YEvGyvOeJIi6jAnaTL7csuwGhcv0sHy6mTSSJOuLhRIun
 4gxCERceNX7oIH8TBdI5syXlfXL9RqQv7O4QgWZyOCk3LpoqhSxEhtcrU4msP4ZbYPXZNnZqWdS
 Hviw1ML4rF3DNGo4Zc7zDUDJhJIVbiivpjG8tQ6CusxNdTfaGthZe3tIXspiFDRp+nHy02wMQue
 Kma+c3RNQcuByy4bB95ZtjvohUO4RWK+V2Q+5moOG9+uGG+pPSTfD3VsyxXZvbaHRV7CDaMl9q/
 Jvv0FscN3xAoXJg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 4d54afcecd50b50ed1fd386ccfc46c373e190e6b..e838b65ea63eef9c198032ee87e63dae282141dc 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -252,6 +252,18 @@ aic: interrupt-controller@232100000 {
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu_p0 &cpu_p1>;
+				};
+			};
 		};
 
 		pmgr: power-management@232000000 {
@@ -380,6 +392,18 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu-e {
+		compatible = "apple,mistral-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,monsoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 #include "t8015-pmgr.dtsi"

-- 
2.49.0

