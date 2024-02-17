Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4091E895
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Feb 2024 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131517; cv=none; b=mMWW70Fvianhgs2hoiSRsTI2JRDrGri89xp6jhHuOBtMvQh10SeDzgDOL6rwjKDSvsFUS39bw/kaQ3o1FbB7gXBGmv7lUJqCJvJ8t1Pv9gdRMrPs/9PR0xwNN5gJYQjJvye0V3ZoFs/Dk0MOLdtEO3FM9mb514ixCjo9neRJ7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131517; c=relaxed/simple;
	bh=ZkEzmULeXONmJmTlSVdM43i0xvCHwPJmXvRYjE51UxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jnOMopNvqOYW6EtH5P/lq1BPPwXqYH5TtgwX685SF8uf8HZeNZMbAcUPw+yB925+da3Hqe2mhnHaLkTtmGsd1qTCQHoue9+ceD3OhA/y9j7cl1NZUw0ndAMhVdFyqncvY/EVSaTv7F+oVpYczhuWZ8p6zKoQKXH8inG3wa/KQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=doaN3ZFq; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="doaN3ZFq"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c47f06863bso96712739f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708131514; x=1708736314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM1FhW7Qr3v0FtC5FiOLqFulLhlj/jL3zhy6p8GYU3U=;
        b=doaN3ZFqN3DtDDU7dn+1l0cb7l95xbybca8oAT8r8UAmJrtoAPSHQu8PuMNCAS+SmE
         Z3wKLQQ4SV64aGbTdxeZz72MzyHeeG8Kwm9ZTh99C/aZWWJdeDC5kKCGsX7RNwijxq/I
         ky65dI8qsQDokzNWVAEnNAJno/lxthCmTx88xgzx8EC64Z4azp2HNLbPrItvHymI9rdF
         H2agcA2NrGQMNt966twkhu+14SjfRFukwXtkJOCypWcO2orDbzIKxc4q6ywqiv3dqUN2
         uTNX0xbhVpjbwkP1ipn1T+BMj7ChOv8Z7gcdZkq2WyKEmqzLVR4No/QtfrT7YtxMEQug
         j2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131514; x=1708736314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM1FhW7Qr3v0FtC5FiOLqFulLhlj/jL3zhy6p8GYU3U=;
        b=Hzkyc5sOfx3EsuzDVwppv9wjpJuaSMxWnlXb3F/n12nXhTxEgDCfZ+qHb1UFSrig+0
         oPd3qRL+CAGcXPjGv0BxFnSAm08E7Drb+EOtkfFvXJA1DHHBMwdROvpXW3x8cSGRIcoa
         BXk6GLzONw/GhWkLMhR2qd1RUwNMe/aj/dgQ2cLPAn37ApvEqPV0f2gNz6LFBPk4l10g
         9tbf2P6qm6pTtcxKUz7ghJXH7jdNrqGdcaaOnm6tub4n0ENkjy+dZDY3JHOQtoqbEaLx
         gbHF9n3ukPH51pRn8aTx0Ym+EZbTFRbPyqu/qIspKzNiskDwWqQLZd2d4MY/2KF9+LBe
         J1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRcAy4brmv0XhdIpJuXN0IMtargO1m/xq+wNBu8Rj5r6J3qg1Gejk1g0y/VZ/JW0fuH3p3NI9ItRewbp4gUz7IH9YdcBzakndghw+hobPVdQ==
X-Gm-Message-State: AOJu0YwcyG0HdFvcdUzPvFMAMiWxSOTpWark0RDILuUB1IkjGl+zJGHX
	eompMUkXvi6AUQMrEpkjxoVpvPbq0QApxXQs96xc9NbNZtnScDQNbNR3OAb7hMc=
X-Google-Smtp-Source: AGHT+IG/18cu0XQrzjjkqrWO02cvxzc2sKclTHZn6KgjzARvIp50etYjTOykyTJQBV988xbbQes5Kw==
X-Received: by 2002:a6b:7018:0:b0:7c4:2254:8e59 with SMTP id l24-20020a6b7018000000b007c422548e59mr6880303ioc.5.1708131514686;
        Fri, 16 Feb 2024 16:58:34 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d188-20020a6336c5000000b005dc89957e06sm487655pga.71.2024.02.16.16.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:58:34 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor@kernel.org>,
	devicetree@vger.kernel.org,
	Evan Green <evan@rivosinc.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	John Garry <john.g.garry@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kan Liang <kan.liang@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Will Deacon <will@kernel.org>,
	kaiwenxue1@gmail.com,
	Yang Jihong <yangjihong1@huawei.com>
Subject: [PATCH RFC 08/20] dt-bindings: riscv: add Ssccfg ISA extension description
Date: Fri, 16 Feb 2024 16:57:26 -0800
Message-Id: <20240217005738.3744121-9-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217005738.3744121-1-atishp@rivosinc.com>
References: <20240217005738.3744121-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Ssccfg extension.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 77a9f867e36b..15adeb60441b 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,13 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+	- const: smcdeleg
+	  description: |
+	    The standard Smcdeleg supervisor-level extension for the machine mode
+	    to delegate the hpmcounters to supvervisor mode so that they are
+	    directlyi accessible in the supervisor mode. This extension depend
+	    on Sscsrind, Zihpm, Zicntr extensions.
+
         - const: smstateen
           description: |
             The standard Smstateen extension for controlling access to CSRs
@@ -154,6 +161,12 @@ properties:
             interrupt architecture for supervisor-mode-visible csr and
             behavioural changes to interrupts as frozen at commit ccbddab
             ("Merge pull request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
+	- const: ssccfg
+	  description: |
+	    The standard Ssccfg supervisor-level extension for configuring
+            the delegated hpmcounters to be accessible directly in supervisor
+            mode. This extension depend on Sscsrind, Smcdeleg, Zihpm, Zicntr
+            extensions.
 
         - const: sscofpmf
           description: |
-- 
2.34.1

