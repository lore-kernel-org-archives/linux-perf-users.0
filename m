Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989630;
	b=zQhJ/FNuyOi9RW22AiMYLCZQstp4iuW1YPFldx+JVuJnKePBEL/1EJQhiZHRcH05pSqZ
	 BiM7DZZ1Yk0kCiZLqu7+CjEBj1bSlwiPflTlMYuYnfrNoOLeyEuvmkmH0fTJkGjiOGclL
	 +/zrBFGDrgM0W2Ych13/VLfSAScGKhBP74owBWoUS3ebBIrJNm3nZnILfoyUHCPKgAsG9
	 h0TslL1yOtOV6/UCnzn1e5nKBlAuSEYHYTxlJeAk+qQrqp7r8VddIpxivoOrN0RTbovJd
	 /CS87uot305HerI1vusCtmsQ8wMrr70/jTfhZiLNkjTkVDkIutC5nyjPJTX9VvyHJlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LrvbirXIkv4em6QifUd4OnpixRUwowvXHi+8bl2oRk4=;
	b=MZ4011ZdZogIgmZVJWwGFGirlyETeRmcj2kZBI9rrQlTNOxhCvt4HNC26UX/Jmpzt5Vn
	 kDxMwCODEd9zFNrXuXfGgKdtEC3EF9w/cMx7s0AU1yUmesnjwUaTMMu42FPHMwglw86uc
	 7w5NOd74fbX3bG+6sSI8n6AUCxjEKC7uJjwSeA48nKLHextFfAPHops2W2ZYCIGNVrLo6
	 DyUDEmUxLgmGwNMMehHCNUIdkg/t06CZ2XIZeIgDzkMFqa3/TQ/N4Ysr51ORNWBWOWGqa
	 6FK5C/m6C/NG1pIbndAcM4bWJz+QH9Ac1Q0JFAMDGquQigxZ6PMS/QU9MC/iMvtna2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="F16/qyxe";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD87606A333
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD87606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=F16/qyxe
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so389599a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 00:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794989629; x=1795594429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrvbirXIkv4em6QifUd4OnpixRUwowvXHi+8bl2oRk4=;
        b=F16/qyxeJCnpp8cEUhvsIzwqbJ3dET3mcVkZCGuvG84FDRLSUKSXvBkFC/dcL95h3O
         nH+PR4V5h9u/CXPhFMsj2uTIAQIRtXn9Cs1Qc/obD1SHjPm/7cFXYoBKt0lWew4PsVZv
         Nkpu6WKaEpUTkfV/bxzun+N3aGLK08cjIVlgVcr3l+1DTbZCgg/jynXsSXRv4Tb1f8Wd
         0jYwQESDhgu9TfRoJ8wWU03yiHbjIPY74faHqETp1xJiWE+6/NB0rxJ7NGS/x48BzyGh
         1H1KNf+bmnqCe57I/4C9YZGtKmqRqeBA9oS2Uu+UmUlnQiI0uSKN2Rv8yBHqPAacLIN0
         yjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794989629; x=1795594429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrvbirXIkv4em6QifUd4OnpixRUwowvXHi+8bl2oRk4=;
        b=HyJT2LUT4t16G5/VuzM0UjPVB7SYhBV4yTpesgalwR1/TZEwOiCwEaP+jNhTwj/QU1
         boTZxn9cikdsGJnojqXcqZwf6oeQs2SrUaYkmo+hQ5EN+12EiMS5qe3NV5DpMCkN9X8g
         0zaBDekLo9zQiMLVUHEd3M/QWVyEdoTG0VvrNZn5neaxOcQ+BDS92hsOqUHSIsJ1zcQU
         1kyCrid/cL8iGD2k+Ekr7Chz33lK7FqXni7LWit1+E+gFFY1W2ynvrk9bGXc5V3lOa7W
         /rM6bCViWZ25CmywuHODPcrZTcTXxtCyYcEYqvNVHCLe+lkB7BEtqa4+RuuSu52cmWW3
         sa4w==
X-Forwarded-Encrypted: i=1; AL+hErHHJMP/k9F0c1RmiyycU98N427NUFbWGX9FzDphgN0hMrIL9of8p/JMAJUWQ3RtHT/7cS72JmkF0Dqy7jG4dNfr@vger.kernel.org
X-Gm-Message-State: APuU4Z9Nf5c1BVhkhmCi5mEFCCZoiarSll6vI3MaUkQiw2YU5al19lPd
	Sz6QFa58o7yoraegEbn2bN8x+pW7D9g9JuBhJL02rMecafv8YNeGj3OMlIWy6phQ78c=
X-Gm-Gg: AZFdTZdaU/T4wpyZE1hZnxJqggRKYajaYY3TJcRfgmFSwOxJ0J4oB0tPqWvnWTG1ics
	WsUQbzSm3qwMgtTUnFM1s90tJpspQnvgIT/RCQsA+8ebJxdUWKGPNS4JGAFB6YsvanyoPEKAS5l
	B6c/NHrSTl7Zq4KlEONEztF2zlcAR57qA+vEOCb8GEyUcxx3MEBMO/psSArXTTmrhYHCDIQ2dKL
	e5EviWfxDlJ2sfjRuHQaf9beIREEMtnr9fKzSRxOu4rvuuR91X2VQVJN2sZKl7sjQ910ESzBQnl
	rKjOOVehQIgMWkAUQOSEE1mhgxkxUQrPhbJqKpHT3YL5bzZPV1jbezS85kkfaTrv7VoMf5Bi1br
	NB0/Jw7UjtedgqTihBSZ/tLPJoFNFjPsoLlP0b2rkjEoV5QBZLo4zWRNfhEXt/LUxRfoKjZF4GG
	Bb5ZeiHw2opZg6rHTY3B7RUBgFMpCTNC+GTiy6ehyfkz+XLZBRw2fauW8+j4/grab5pVIAIuZlW
	5cgwwUT50PIvN0yYB6nQZORphsqFgq2S/6I8addl9KawotAltv6+JUqaW6cBkJAyaJN0cb1ZP/2
	uaBySyaBrLFB4nNZtug7qYPyoisOWHMzd+lJvjCzQYnCPYLtegfWVarv9ZIM8XlaKk6RVXKe4f7
	nZcmaNdo=
X-Received: by 2002:a17:90b:3943:b0:3b0:a7b5:c046 with SMTP id 98e67ed59e1d1-3b3d07e09f4mr2098689a91.54.1794989628976;
        Wed, 18 Nov 2026 00:13:48 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acde50sm3254680a91.14.2026.11.18.00.13.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 00:13:48 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	andrew.jones@linux.dev,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	atish.patra@linux.dev,
	anup@brainfault.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	yuanzhu@bytedance.com,
	cuiyunhui@bytedance.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	will@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [RFC PATCH v1 1/5] dt-bindings: riscv: Add Smpdis and Sspdis ISA extensions
Date: Wed, 18 Nov 2026 16:13:29 +0800
Message-ID: <20261118081327.10684-8-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the machine and supervisor PDIS extensions using the pinned
sampling draft. Machine support alone does not grant supervisor access.
These are draft bindings, not ratified extension or CSR allocations.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 79491ef8f86a..afda76b9c7c4 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -214,6 +214,15 @@ properties:
             ratified at commit d70011dde6c2 ("Update to ratified state")
             of riscv-j-extension.
 
+        - const: smpdis
+          description: |
+            The draft Smpdis machine-level extension for Precise Decoded
+            Instruction Sampling, as described at commit
+            2de60e18118ce78e2da82ec33296345c94d8560c of the
+            riscv-performance-event-sampling specification. It defines
+            instruction selection, filtering and sample collection across
+            privilege levels. This does not imply supervisor access to PDIS.
+
         - const: smstateen
           description: |
             The standard Smstateen extension for controlling access to CSRs
@@ -269,6 +278,16 @@ properties:
             ratified at commit d70011dde6c2 ("Update to ratified state")
             of riscv-j-extension.
 
+        - const: sspdis
+          description: |
+            The draft Sspdis supervisor-level extension for Precise Decoded
+            Instruction Sampling, as described at commit
+            2de60e18118ce78e2da82ec33296345c94d8560c of the
+            riscv-performance-event-sampling specification. It provides the
+            supervisor-visible PDIS registers and behavior, excluding the
+            machine-only state. Firmware must make this state accessible to
+            supervisor software before reporting this extension.
+
         - const: ssqosid
           description: |
             The standard Ssqosid extension for Quality of Service ID is
-- 
2.50.1 (Apple Git-155)

