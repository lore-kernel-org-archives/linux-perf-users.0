Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712EC232438
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069035; cv=none; b=awJPER7CYUGgPZSLzjT7nHoNj9/r59diGXojAmOmAKqO6H+8bCtk2Z+o/mGc1o0G/nEyKz9iA5dHm4A2+BjTaS63R4866srXgB7NUyI2ysgc6r826dX+bgc4o5bYSnbOgfgi5Nrxzvqs9F5qWR5wwxP6Ks+CH4BvwtJpLad1AO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069035; c=relaxed/simple;
	bh=XBw79LnYjlB57EbPiUfj8QEVhxDaH28VkwL1Z1KHM4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKkujc1yWjPk4qIxsCukYQMjXat3/kGApxxlTqgvHpENlb0RO0K8tH6UBEEvSpEFdFuALIEpJFj+w0UK27gFJbIj4nGaW7icTrEZwHX1tRblcUVnzWDiAL49UgBxtkpPoYL0sD62JhC6B0F5lTJrtP3jCDp12n4pqkkSEndjv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2b6ZAdal; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2b6ZAdal"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e3621518so708254f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737069032; x=1737673832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQjN+UKbroqD83qO2UjBTcTlF8+/q2QiSosN0QwUoU4=;
        b=2b6ZAdalQm6lBt9X8Kjf/jjvCGqKs+VGHmUQ5RrRUk9ngzoNwBfGu2hbg2s7I8Nl8/
         XoXrLEEy49rgMAQhlW3fkY/K2NLutn5Aihzi8DHrTc5lR0BbWWRb53Y1FllWwTGq8EQW
         UcArfhaRroWMexY0jxLuww8pyPAE7g5qcf2MQzfML5sHHoZvsX6qPRAKXT8JwwbqnXP3
         aP0o1fbEwWC7waDkUYzcC5qvDoaBhZ29X551oGdM3QTVLPLUNxfp5OtlHlJTuD1Pat7+
         /h2iLtSOLz9wgOhOFt2lKA7/c/D84CQj4/5LNCATp/1jl/qMpVG5AGQMxRjwdKWAI8t4
         RMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069032; x=1737673832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQjN+UKbroqD83qO2UjBTcTlF8+/q2QiSosN0QwUoU4=;
        b=mXnr8gwNM+Dge/4TJexx1XIWgb2QERQf6+kmIaMWTVdqeUrA+Oe5QFdsCOCuq74vgT
         sCSsHtvJFdeFFEnN/1GF6CSeQpXI+AmHpYQxGrqWLyqTG4D7LZRkInLDF8xw6VUzhGM+
         O8CTxZcJeNXls2dGk5nzaVKu3C9goYXnMdlYGkuoOSfVs/4SGXXgAjFdt/2+3LDUeMtf
         iNHa+nXDb2FqJLILR6Yl90z4NHwv2AeS+7Zmka/AvQG3ZlZ7j1ujfvjc7JsC7hMEhIzI
         yMTqQBuLrM+mW6oAa2y02gFVpOQTR3zGlzmPWuBHuWXHGT9T5UjbuWuTUtZQi1F3aDJV
         5m5w==
X-Gm-Message-State: AOJu0Yw8Bj8eCkcvf8SzIp2z4TV5o+n+wtzaTxUH8rfnyevZNq+9ROn0
	mGVFVZGV2yMy1ZV8YTKVr1Z6H9G+ux9h5WT3xnyMexmnnI3qsiogEf623bp79iM=
X-Gm-Gg: ASbGncuLpucg1PK4AuVKasDVR+QNPMVF4ZtFlfj/+lLRGZB2CH8hJ7kk1wCCQZbUSad
	HU4qFHdC9PowOkcEUvaDrnj7VUE4bDQVNOYtGrCMh5lbrUvFpKpaD+aBdtSt9jb88p+t1uSFrRB
	K56OzRLeXAeSfWCx8YUrycoeNLhLQnsS33SdYAy19jNemmA5BQy1nNx7XsUP03ZIRGsEKZKOTqI
	8f+mw4BPVNNH5QSzauQd33w0sbQflqJnMNKp06iE9cURhDX+QZWHc5Fq2qi88wUeEGK5mdwGaoh
	5zvgqE2wYjhjeP8V
X-Google-Smtp-Source: AGHT+IE8w0tW/wpQVyEgF5mM+IUwGM3ccJfDjyTPUx2Pdbu8PB/1j71pGZjZsCD/2FEHJdYpAfi9sw==
X-Received: by 2002:a05:6000:1a87:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-38bf57bb947mr268961f8f.50.1737069031710;
        Thu, 16 Jan 2025 15:10:31 -0800 (PST)
Received: from rkanwal-XPS-15-9520.uk.rivosinc.com ([2a02:c7c:75ac:6300:b3f2:3a24:1767:7db0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322b337sm974991f8f.59.2025.01.16.15.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:10:31 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	vincent.chen@sifive.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH v2 4/7] dt-bindings: riscv: add Sxctr ISA extension description
Date: Thu, 16 Jan 2025 23:09:52 +0000
Message-Id: <20250116230955.867152-5-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116230955.867152-1-rkanwal@rivosinc.com>
References: <20250116230955.867152-1-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the S[m|s]ctr ISA extension description.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 848354e3048f..8322503f0773 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -167,6 +167,13 @@ properties:
 	    extension allows other ISA extension to use indirect CSR access
 	    mechanism in M-mode.
 
+        - const: smctr
+          description: |
+            The standard Smctr supervisor-level extension for the machine mode
+            to enable recording limited branch history in a register-accessible
+            internal core storage. Smctr depend on both the implementation of
+            S-mode and the Sscsrind extension.
+
 	- const: sscsrind
           description: |
             The standard Sscsrind supervisor-level extension extends the
@@ -193,6 +200,13 @@ properties:
             and mode-based filtering as ratified at commit 01d1df0 ("Add ability
             to manually trigger workflow. (#2)") of riscv-count-overflow.
 
+        - const: ssctr
+          description: |
+            The standard Ssctr supervisor-level extension enables recording of
+            limited branch history in a register-accessible internal core
+            storage. Ssctr depend on both the implementation of S-mode and the
+            Sscsrind extension.
+
         - const: ssnpm
           description: |
             The standard Ssnpm extension for next-mode pointer masking as
-- 
2.34.1

