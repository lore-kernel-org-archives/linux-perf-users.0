Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF3218858;
	Mon, 28 Jul 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703867; cv=none; b=GMCAN7ua93nqiJnR0f5eolZxIQNmJ7iC5hMGA4+B/IsPelgpX0N31uGCeYWScE7p2sqAGGctjGa+4FyTIOuWBXWbZgNPWW6A5kvUKRGOgcuTNsYByQN5lrDXr/jz22HVIdEEbaNZLuCCkkbzKMuXAcfEX0ZcPGSckyxMVgzeG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703867; c=relaxed/simple;
	bh=ZtT1le3P289gYN9XnvFtj8YV9WSOW1LkgpFqykFEcqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0MnipJg6fq2ex+VxSYjcae4viKSJ4hGGnu4LGwCWiIxEqdxd2PV825HiBdYRXlWSnPno3YMAaqfFesQ82iQyJKtDBRERev7fPO1nG1wuINnTpQOBbf9dj7ybB2pUyiVtkMJwZkssVEEew1lxEskQdWF0a4uySC5gTa5srSJqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InW/quMj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InW/quMj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2401b855635so6625575ad.2;
        Mon, 28 Jul 2025 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753703866; x=1754308666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7QH1fCvQmnSC89vnVLs/2ja8LbLIAQjyBUi34DkOfb0=;
        b=InW/quMjeeIt00PMfihwSdl8pQ72/7y4YX1jpnjEfA74inPe+HHC0MWAw6TZKqgVwn
         YsyhgOeWA1NMB/n6zXN6qZKN4FDw5mMnbELc5tsRFHotDIXLlYEgfczR6EhjPuob1eu3
         rUSD7ZuKDZUnERA8l694cAjpaZXGytxDBHe/8UOBmfzf5xJ6UB3Bq1dKV7Uhq73fIr3y
         g50zeOIP4gwNxosmuoVwKm324W41/K+xwpyHSNLKdt+d0IAwQsIQv8/ZXAAUwzlMnEd9
         ELbA4j8B0D4XreANLE3DWebXmaxvSPrUjnUHWSfzBXOz2UqrL/X0dcD7G5o+reSRXrOh
         0UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753703866; x=1754308666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QH1fCvQmnSC89vnVLs/2ja8LbLIAQjyBUi34DkOfb0=;
        b=Ih4brr5vHByHeTxmqmMjh44wEKAtSL0yIMqbxCXgRbkH5zLcaF/J667vlEJcFWusb4
         P7PbZ9ltBS78vOrHUGt/7wSaNv/kuOA2zede5Zr1aG3bM2NcQNMXIj7t7SsJd8rRsamR
         5oAC+sGeIDtFzur5cJGyGVwkcejW9z9Hzb3Mpnh0rFPKZGFMumwapzHoKUEWkpju8k8Z
         iIvszWfazyRVQ60zpePbI5Y7oGvXDrVc0LJGPPkn7bilTV9XwSJh2bXJPLpr8eMCWJSN
         fGL08lKZtW/C/7MBH9dopxo2a927TzLcLxc5eVi76HKCKQocq6V0RnXXNnHxpEZ8QtCe
         vHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFOvFHWoATZWFBpOzmeAwafhqECe8B863KXKquFNCapk0uhaVi+1WHJEJr2mpn9UCPSJeyGha+lJ7k3Hdi6hODaA==@vger.kernel.org, AJvYcCWLNpMjdpACN/lYQS+5i6MdjxLoZCe9CT9jiy7JOiovXAo114u8Fs4cm8uZbA89E5MVpkd9aqpnMQpJ@vger.kernel.org, AJvYcCXD976m6QtpLuuHUHOdgIE/YwaVj3f178hwpSLHTgkyz1y4FrdNp4JsS0iKOLBjUDAM17TokLFYZxh/TU5H@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbPtwkgOYKI81P1n8oedMAKVpmuaCmMkm6ZA6qscZ548HTL8z
	YEv5mpAHNkTJdnuVJSRusHIFDSHNXJg/Q0WWsVROPwP4tqVJmkDg4Wl8
X-Gm-Gg: ASbGnctAMHapL4A8ULpYFIKDq6sPWg5cXaoiVm61FGRQ8kxh3mr2ktdY4MJ9X1TlnF3
	IU2lZCQAai7D1yL+e9DBv+lJGN2bMoYNLjRx5hlFGi5I05tWg8kHu2PuxI5fGAAMnTVg1vKA1ow
	+BwIynBZbXFPHwCCjNPjkHE0/Ufe4CTHBKyFAE1EvsjVO3z0lYcrPU74hSMs5DIzt1fLXtxUX0L
	+foCpByku56cD2FHNhIoByspffw9ZTfHTN9I1ylYvNuBz5VgzQB3GQNFpTaxYXnDJwv7ifke83K
	K1NxW1SFZQjDNWJlvwmqORaRozH/nvvXnrBpdxLWPVm82Jvxm0fZy42hTm4bOOpftsv7OpSFU/3
	cueUUQsvUlpr0KGK+UfrS3jYgITfzQ+whobWaJ1z87T8+e7rZbLVlx/Q2
X-Google-Smtp-Source: AGHT+IGVkxhzM4QAYwzySEvOd+NXUqVS/Jgx0EE1xymZXd3jvGCDUW6EzJ9xB7Zw08erZmtjmgDO+w==
X-Received: by 2002:a17:902:f546:b0:240:44a6:5027 with SMTP id d9443c01a7336-24044a65233mr19422635ad.15.1753703865413;
        Mon, 28 Jul 2025 04:57:45 -0700 (PDT)
Received: from localhost.localdomain ([38.188.108.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24007d98b25sm30933685ad.97.2025.07.28.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 04:57:44 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org,
	atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com,
	linux-perf-users@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] perf/util: make TYPE_STATE_MAX_REGS architecture-dependent
Date: Mon, 28 Jul 2025 17:27:19 +0530
Message-Id: <20250728115719.143372-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the fixed definition of TYPE_STATE_MAX_REGS with architecture-
specific values for better accuracy across multiple CPU architectures
including PowerPC, ARM, x86, RISC-V, MIPS, and others. This change ensures
the type state registers array size matches the actual register count of
the target platform.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/annotate-data.h | 45 ++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 541fee1a5f0a..0dfb12a8f1cc 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -189,11 +189,48 @@ struct type_state_stack {
 	u8 kind;
 };
 
-/* FIXME: This should be arch-dependent */
-#ifdef __powerpc__
-#define TYPE_STATE_MAX_REGS  32
+#if defined(__powerpc__) || defined(__powerpc64__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__aarch64__)
+#define TYPE_STATE_MAX_REGS 31
+#elif defined(__arm__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__x86_64__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__i386__)
+#define TYPE_STATE_MAX_REGS 8
+#elif defined(__riscv)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__mips__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__sparc__) || defined(__sparc64__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__alpha__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__s390__) || defined(__s390x__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__sh__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__nios2__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__hexagon__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__openrisc__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__csky__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__loongarch__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__arc__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__microblaze__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__xtensa__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__m68k__)
+#define TYPE_STATE_MAX_REGS 16
 #else
-#define TYPE_STATE_MAX_REGS  16
+#define TYPE_STATE_MAX_REGS 16
 #endif
 
 /*
-- 
2.39.5

