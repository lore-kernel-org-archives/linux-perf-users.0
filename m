Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1B38B7B4
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153923; cv=none; b=bDQ1Icb+3ulLDLnelNyUo1KH+LPYVgFju+Af83cHkjioFmD35qB6lSzkjF5XyyLstHFOg7RaM1uN2fdCreJnknra/sdQoWWElwnG8ZfpbAAMbVVq/WHztvYOeDDk8wUqDPy4xo94tnboo3+NWkS+IufiZrEfteqrT7MVe0/0V7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153923; c=relaxed/simple;
	bh=xRfot5V410ko3VC/JnSvckBt3VT2Kyp1M6wEsrFm0ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qs/0vVSK8pDIRIAHdlLjqTAJ5NV2BcP7tupL0BmB9Wnzs8tWPodgE7JwGk8ZnxSNeshRCo2NNYpC9pLiGL4nclpLJnsf5x5TkOICztCqxVv/B5rc0W0O1TJeHu7XAqKjMxIOvtD/AcloSGFNW7eV0fZxGQFqhdby+rbTG8QOnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b=LUeiMhYc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b="LUeiMhYc"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d95017a68so3294737a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20251104.gappssmtp.com; s=20251104; t=1776153921; x=1776758721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6633lJHMBTkrsVPQmGB6HI2mM0l2A6MHXZK2D7n6dc=;
        b=LUeiMhYcycFit18dolN3qBs6om9y4qo0Td7OrZN1INvpNWjiOasquFDnw4IBj/7HUw
         0GGE1kwIjgOpJWjrG91uma/HPScorOoZdYaWUWhEnZQXNiqsr9b0pMqRi3R+9bABUM8Y
         YNFG+kZYTXvVfqQvvG4P97i3GBv4lcd8cL/1RqK4itRDRSIGR2xKfyYRROKm6I/vixBb
         fXLIUhtbrsfK1GB5hDiF5l9svCDqXNwcQotCRFHBCOV8XklfFVJ+xy0A5i1nUaHNvfmm
         K3T3giZTTAf5o1EdU0VS9RbJ1AilC0lu/xW8+qWsFtF4R+k9edagfGiVAhoVo+YVqxqe
         4JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776153921; x=1776758721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6633lJHMBTkrsVPQmGB6HI2mM0l2A6MHXZK2D7n6dc=;
        b=KaTrh8CG/VOXox2PUGVt8I3p6kwygI/xPe0VkQAOsGaPBZRHdkk9/madlwcTdKVELe
         3wQzTnpJaPlegC2fOw094lFgTkQxPnEiXSXeAeuqhbjek+7lSu0qI3pUnqjZcahpHYbx
         IenznL7ZnIVmSD3nishlDXzlJ27SsKDWNA3tVfzKd3u9p+uEQx3xr05l2d+GkbP2B6ub
         KxnD9185C6C+xyvcGYqkvpfHojlBOVt2wMXCEMMQAxE6vNDwVP32DTqhMJUIF96nOoJW
         tJ34bJv8LJ51fD1Lr4B39sI20rlFY2wffMKL4FA+WhiQlaiPzZtpOLMlc2/HMCAb7XdJ
         4O+A==
X-Forwarded-Encrypted: i=1; AFNElJ+jsu90p4V1QL3K5i/t5GrBS6pkhLHz270Q62wJ17AvEUXrI5cWtnY/t+kBfAuIiJTsSohL8RMhEpDqn0xj8HDc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2L63e0zjmj0Y/Xm/yzc7TOtY+mCj6kiXfINtQ9eDZvw3Uh4Q
	d36skLNEqRKNeiHpzIVPNB3tetXUVkTCElKRXwj4GNx35KmOf6f/NTpNKEln7uTFgHI=
X-Gm-Gg: AeBDietYbN21qlDXaYlTaHh2mhSly9qJDNeb6VXu6hiDKbODnHIxP9M/PT4cLp28Ztp
	zQaa4CmdZY9JXV4+Zn5b0TLH4jTfvENPek75O2KLXjSAkSxX3l6QnTRnoprDF8sKa2kBTFwFKkA
	6IcBgH81QqPI3cTEELz9R6IyXFR/oF30rZlVSm0gZRBNMLqp4/sT4Pv/ovGrlNFgG939PO3Rku/
	/uUOMNLmvsrSJJOzQxtPu66J7mc1L6qLGQBSgecrCGA1pUZYu20lhUDRw5FVVzrb12QWrl0he3x
	NHQtymoOi2FTgmlYxrRdlOClRqRzegTvb1bbGWijUMKXvwVBeCP1SbznYSzdqvHXLNxCVIwXurl
	ggztl6Qw2CeB6lH2SglfWdxBvBb/W07tZhvwjKvsuqKxPtNBMQuf3UsbFN5zR8IpoaMRwXKSg87
	qAGka8FlLYZQ==
X-Received: by 2002:a17:90b:3e8a:b0:35d:a542:2dbf with SMTP id 98e67ed59e1d1-35e428320a8mr16108998a91.20.1776153921460;
        Tue, 14 Apr 2026 01:05:21 -0700 (PDT)
Received: from xpc ([2400:8902:e002:de21:a5e:ca8a:49d9:fb8a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e3fe18sm1243071a91.2.2026.04.14.01.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 01:05:20 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev,
	loongarch@lists.linux.dev,
	Haiyong Sun <sunhaiyong@loongson.cn>,
	WANG Rui <r@hev.cc>
Subject: [PATCH] perf build: Add clang and rust target flags for loongarch
Date: Tue, 14 Apr 2026 16:05:00 +0800
Message-ID: <20260414080500.320095-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haiyong Sun <sunhaiyong@loongson.cn>

Add missing CLANG_TARGET_FLAGS_loongarch and RUST_TARGET_FLAGS_loongarch
so that perf can be built with clang and enable rust cross compilation.

Signed-off-by: Haiyong Sun <sunhaiyong@loongson.cn>
Signed-off-by: WANG Rui <r@hev.cc>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 15fbba9f4..1340744a6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -27,6 +27,7 @@ CFLAGS += -fno-strict-aliasing
 ifeq ($(CC_NO_CLANG), 0)
   CLANG_TARGET_FLAGS_arm	:= arm-linux-gnueabi
   CLANG_TARGET_FLAGS_arm64	:= aarch64-linux-gnu
+  CLANG_TARGET_FLAGS_loongarch	:= loongarch64-linux-gnu
   CLANG_TARGET_FLAGS_m68k	:= m68k-linux-gnu
   CLANG_TARGET_FLAGS_mips	:= mipsel-linux-gnu
   CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
@@ -1167,6 +1168,7 @@ ifndef NO_RUST
   ifneq ($(CROSS_COMPILE),)
     RUST_TARGET_FLAGS_arm	:= arm-unknown-linux-gnueabi
     RUST_TARGET_FLAGS_arm64	:= aarch64-unknown-linux-gnu
+    RUST_TARGET_FLAGS_loongarch	:= loongarch64-unknown-linux-gnu
     RUST_TARGET_FLAGS_m68k	:= m68k-unknown-linux-gnu
     RUST_TARGET_FLAGS_mips	:= mipsel-unknown-linux-gnu
     RUST_TARGET_FLAGS_powerpc	:= powerpc64le-unknown-linux-gnu
-- 
2.53.0

