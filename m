Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D607131CA75;
	Tue,  9 Sep 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412755; cv=none; b=Ph6PYBqbxKEmoCeBtQc7uKIrrHDp7CvD1NjasLA7l/hNRj1SGwtgTa/J8DwUpJMWmzdnLQy8TKf2k42gy8XDEcSpmmaco3dWh6G+Ng0s9LoXw3j4DlFXfzT2Giu2cvmXiwgfiFDLVR9o/SKHzl6SK9TugTL7FWVRUjRNX2oo6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412755; c=relaxed/simple;
	bh=1ehExbLkMmNgsVXFhI/3vAuhpWWLmzmhuVgV7QDcaGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBeZfyqAhEIdJLu2dvNi7U8/j72f90gxE8gcL/6sp/EqHB/UBz5ZhzjpeLP6I1JeV+2c/nGJoEXxAbiJQlyS5PqUg1vLL8e0UbBnuWEW6O668u3buVWC4/Z06sB0vb2od6/vR+g0TvrzJ0i6RfRgtTtcy1D6QJlGs/xhrjNJlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToQIeg0T; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToQIeg0T"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45de1084868so12927245e9.2;
        Tue, 09 Sep 2025 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412752; x=1758017552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsYAjCVZTAgTbKUVHs9DAPmJO/mDOJAtaWrMK8+sbis=;
        b=ToQIeg0TJdG8NVTIEZL6QH0F6iFrqeNBTA9Umv5i2CYS+ZRTpLP9RO/pqb8NAI7SO/
         vOWVw/dBXiHOPVxWLXdRAkR7cPSY/Sz5gkfrfxFHf0QAGMCHIcZpMLAYlRZ6qVuOsDX+
         fTx8bISDgTDDe5bWakT49RsN7tFxKMc94LTLf6JGfdYd1TshpHieBPb67Fghjl9f2NOO
         hHBLFuyzekXwBpNhOwzrSdQjcXZ2O3S8wOFB7KJIrhDCSdmseybw6Rqg//QEnw35TVba
         fJRac9Tm3uJL/pXKYJOiNUoyZMwMaYLYXr3t58cCf+gzVK+tODriU77fbd3RHD+Lg+/a
         4S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412752; x=1758017552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsYAjCVZTAgTbKUVHs9DAPmJO/mDOJAtaWrMK8+sbis=;
        b=BO6OjRNbKWjlzqIItA/QMBAWuGpqwi1e3/6SFL89xt3hJe8DHHM+foDtCmJpiKz1at
         jfVdUiQP2nCds0BfyXBUDGWlxDGDYCzWRpZ0KjPqF79Tcs3jDeS2kJSmq1dCibw1YZB5
         wGVaobT4eE8I1UooNVOQMESvzTlIWK4h5nIp4MIHMrtico0OJvkRoM5lVwIKT35CvU/I
         7iH8QpvmIN8YXhCMZhPdD/7AQzVM6SRI634L1JiFZdhuDo7oXFodQEW6n+OI010TAVZp
         KcJLLttIPDlilNH3r/z0cU8RW/y3XlNsi6SJWWmoFT6wmAGb8dCzQMmNRXrRJugKBlTL
         2+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUabB6ywTkM4IJjvRfL4xwOHM7CEAJn2zFx59OxQBLGjWeIT6dqeBnVRmJFyW7E+pr+p6NgTmNhYebp@vger.kernel.org, AJvYcCVrWMEkHeaF1M2cCVWci4l27ATy8HoUJxyRPy7pnwnsemib/5XZ1LpAV4T88QKeeXbBsrgw2yQzuDB3AbDSN+1lAQ==@vger.kernel.org, AJvYcCW7qzQwrmQw1pp+0AhwaxNt7wZrP21XzK6vD/0jnvHBG98VQ3qsJP0MBh+g7iWj0CPIk5kiikUMgwQx@vger.kernel.org, AJvYcCXOyc0WnOgon4qUaAxYq2B/IA01EYICQwSqxJ3/5phwXAfgpg5E8ebNc/xtpQUz45p6Z1On/bH13uDB@vger.kernel.org, AJvYcCXSUvKP6T7xrypZg86xh+P+naOyloWTnNf9MWTWXPEkD1+sUVqBS9QN5D8ZvEeBVburxnQHHrpOClSU3klf@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrjmsvCx99owZdB0U9/zfTNkPUp2yzTUNnZ/iOxVJQon+9mwD
	ffqZFe/Hrrl6oiqPJLS6SC6MxunvAMjv62hH2Q4SIEI2mNncIT9QQnKCGNqNhcpc
X-Gm-Gg: ASbGnctOcXADyboVzwrursvJHBDd/iIBKVzJXNFitYppAzUbPyhONaQiikZvSSJ1WAV
	QuvBQcpmkoWows//5eBv6aRK+/Zcn001rgpHs5fPVHnf3RS/FRRanek84YxIbz3i4XrP3sTyKVt
	l0ay0B5uBA3oKn5sn1kac24OAzSDaW7JcBmSkj5Dd0b8D+IpW4QqUTX5kJoJMIyf0ph3fAUqaAU
	ACYo2iFvJIRsioaM4ywGnN1nn8kpyBwKYKJLpegtAnL189uQeSGDCvXUsqw15AM4ZX7LaAw0cwO
	JZubC4AFWz02cnHKeXXNYXrI7VdIQ49YZqczdcHUiBhbn0OJpMNVwipnh/kkvPffLm2Wli0TZPh
	31w/jmiLHNMwnbwdlD8+EtjFM4aAr+lfmJb0BYdewWBz+Bkxf9crxwZJJXSKoOmrOgnyNbKgsXq
	mU01tWO4KBiL8fHCA=
X-Google-Smtp-Source: AGHT+IGFWj1csfftMrTtbBzav0aJP8+tqV8mMQwZl+VGz1A+6Wfp7GkhRRrJnvAXOv1+MxZTXBPtKg==
X-Received: by 2002:a05:600c:1912:b0:45d:d099:873 with SMTP id 5b1f17b1804b1-45de2547b9emr85467345e9.6.1757412751881;
        Tue, 09 Sep 2025 03:12:31 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm289241375e9.0.2025.09.09.03.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:31 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:15 +0200
Subject: [PATCH v6 08/20] dt-binding: memory: add DDR4 channel compatible
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-8-ce082cc801b5@gmail.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
In-Reply-To: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
X-Mailer: b4 0.15-dev-dfb17

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add in the memory channel binding the DDR4 compatible to support DDR4
memory channel.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 9892da520fe4..866af40b654d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -19,6 +19,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - jedec,ddr4-channel
       - jedec,lpddr2-channel
       - jedec,lpddr3-channel
       - jedec,lpddr4-channel
@@ -61,6 +62,15 @@ patternProperties:
       - reg
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,ddr4-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,ddr4.yaml#
   - if:
       properties:
         compatible:

-- 
2.43.0

