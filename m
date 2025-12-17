Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE534B424
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988684; cv=none; b=HwgIn+8b8jNCBtgAEJWXPbsifmUf1XOxCDQBlnG/u+eUrcwgtne82OJvbM9cKbOwALiyVzvzDKO7UXGHGPixQB3CY4bJfTbeqlPqIpmqyhhNOqMayVEWFs9l5LrGN8pgOALy1/WSprF4z1JlBZv2m+v8xL/nc/nqbGiRjZjeijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988684; c=relaxed/simple;
	bh=07n0zpGM1mcRCjmEoORnP+p4Tv6Nx9ryjVOY1OMyuiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFsacy2t/p7wymz2KzmT0lLHQk/IyWKONTOG1Fkx6fASY/o5hfhInxUSli1RPPQ/Vbl9hlnWKBc8Qf2mjpTqCUk/djXYkasqgMwRp6E7TLWRn50+RbTBcEr7XGhX645mp9/LpTngH1LEcyOUO+L1s1OJTHoWukaHU+Mt9/B1h5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlvCNvK8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlvCNvK8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d0788adaso36177625ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988682; x=1766593482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBsTBcVtZ52Xc7+liwX/QWMHum7rwn6gjjvyLUqjbLE=;
        b=SlvCNvK8QM6e7XWU/ptoxsBs5sD7391zUewVvpX+ORq1tYpgHAZWk9EyEs3fVltefi
         mo7vUr6sjeZFB4Sp2ZH+1Oxho6A6JuBdbFVW8VQanHarzE9GI7A+/tiUQa1ZcR7sXzZn
         4tudeSnPtNvvhtq8SBupyRAhiK99vUN3xkiosyY/FX7vgj2/qcwnlWhehJq3NtwIO0xt
         vAxqifFzbt1mVhJb/KQuNdLwvy4Nlj9dkvdGLrYtXUL7vXfIDnpV7z3ByBtFS1TTDNjr
         WD8sQyuGBbkNW7kN2Jvqxkgain/ZOtWOPQp5Y1Faz+38Fv/dmgdXfT6lXBF8YvIH28xC
         AJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988682; x=1766593482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBsTBcVtZ52Xc7+liwX/QWMHum7rwn6gjjvyLUqjbLE=;
        b=SvSmGR8fzSaMDca6DfU1CWNOz2En11cXyPP+ByO9smSTErW0yiJwB1J/s7e/pK3SxD
         3JHULJThE4vD9phIxv1Hw4916+0jvriomFaydc+lz5QIILJDfqc96pC0PJO8scftf2fL
         W6/LQFFO9MFgfJESmHMEqnC1CQEFNrgXJRUEHWHGODvLCOqrAtTrAjGqsF3zxu0HbgPz
         DfomI12eazaaCuxeQdO9lRNt4zqQv58Ul+phUa5NDvHpuVvdjbHmuWtkgSMluIY8e3wD
         OI2hDxP61PSOOUCi5uGPM8HPo3cRDC+i3p+AWiAFbX7qprWvO4mzU/jt+EBsLPdGmNTd
         CtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy4WXt5OO4UBbNPSUF7g3E8FWZ1wH6QLnOcLWnnicszDBhktXfNDtdAjrI1dOzvpffcS12R0xAvOdkr+vP42GU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8f+ahIO4i98Rt/PzG7JMb2RLGGcszTpQ7kgDsPI+NA5OLi/4V
	xeFdYbg1G/Mqk67tBv/bBeLfJo3vvi3mwxIrP36+mWfzfkHQPc4j/Y3x
X-Gm-Gg: AY/fxX67z8KnZmFkKUY1R2u2HfW7q3ifyINEB0yMWK9341SK7uo19VnLp8GME2KhcDo
	r9IJKYwbJdYuP61A+SZNUewxYrmNKfVjiXDMI4paVk5UOYy0jmSdVvxAYQZUZGDXLJmk1bKrAwj
	QKr86WiIOUvi3qMi9583TX8zIz+KuxQ+vyNZpSAy+wObQn05/aDpEAJ8d8mqnicGF8ohxrjZQsE
	JUf1h7sMjIx4B8iH8QUqzP9r28Mhip4GWxVPi/gN+E/Nm1V1LSjdXWlBainkBT6qiIwQeWZ5SYy
	7zb04BT3ogVczZWvtwg1KsnnG9dL/Qoa50D60yOOqx3MjHpH5ZkO2JvSBS0MD9MulNwuMYulcJY
	k3h9Sa8syM8fptlE6LBOdN4uVIlrXysIISiTG3R5uwmEhEoq9h0QOBWqSS1lNWeJ60DULlKs5X+
	MlRa8iKHCXQXoq
X-Google-Smtp-Source: AGHT+IHerJ40FopgnOq9crZZQAG5AvJv+BI6Pdff7E5Aip3DS5jCH8CIcKubc8M48Ss2JNmpxKhZYg==
X-Received: by 2002:a17:902:f789:b0:29f:2734:6ffb with SMTP id d9443c01a7336-29f27347628mr180428125ad.22.1765988682146;
        Wed, 17 Dec 2025 08:24:42 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:24:41 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:14 +0800
Subject: [PATCH v9 01/21] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-1-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtk/vxtAppGPRI3gSWnHu4Hgsj14l3noyd1EW
 dyQk74BBouJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZPwAKCRABygi3psUI
 JFiAD/0WRDI1uvHw5wnu/YUvKRrNw/aC/10n7dU4nlOOgz+dT2KXA7o+S0CfTGh2NUVNhRrpuoT
 kiFY0DSNFkJ1kJg2hA+mEg2UGBT8OGcCZB6CZOJo3YseuW989tPXypTy38ESuklM3Tz/XkzyiDs
 civ3Rx5FQqHxTNS+wm9nYxtKh4U/2boicojfE9ehPkgcQUXXG66QdjjyXyWK1z6wcyJR3wWPOLr
 leGpDrNP+ObKEOLJIBLDoUiCGWzMqWfDQsSl6dRBtgmNXtFbMukuXkDFDteotZWcTDmh39+2ZEn
 U7zE8lTV9jRgCuh0RKG6oe4CTRdjtaxgygKITh35fCATqjJUhTpc355eJOuJyFi/OmtiAFSAfEw
 YA1+50N9Pd4JbRYFovGZSc78FrPMz/Wwx+I9lGOyDf6j3QFnS0zrMB6/06ZMj6HTtPABNlXvzWi
 qOTBig7MI72khRcL+fEsKZ+yiLg1FryCsvaJZf0CRNQEAocCmCjzcPE8S6QiKVqZQEhICQ+6NTc
 ZQiZYlal8uS2Z6CNF6LxR3NX8WG6l8DlcNCkft6Lp5NdTMmHdd/cd0u/FefQykKx9TvnButGA04
 WwGNHnq04CsmWXXfX0rO+QBhYTbLw2LwCN6FA8HkCXH9fLFB/tY4FDFm5VLA3OgLrbjb7OYAq6J
 sGEJf5OdJIkDI4w==
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

