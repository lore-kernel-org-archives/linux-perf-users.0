Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA954963DF
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029277; cv=none; b=JZi1PkHYRXtR80Sspo2vjt5wxdvSPnoqOLAfvsR5AP6IclZQ7jt2ec3GG0Ez2FvnHXN/9Iu/5f6hGzuY9UsOcabIq4pMXmSIqrzeBhKE45YQjOeV/zdn1yJNqRkRC8m8nWvwJgPevyj07dCbsCjF1d+mkk4Ym0oTBppXcamsvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029277; c=relaxed/simple;
	bh=yM6cFgNuAiFc6GRYkPgqXfyt8aAWVhdPppjzhcJdAw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cHDy3m0mTj9qkHspOl0uWdo1cxXbL8YFh6X38J3XWbaJFEXKTznD68PAkfu/rsUn9gkItitGkBUSqdM977D3y+ACTfumT+djBiKbhbxjqDjxF0ocZrwVgl41LUmAKvMgYlSC3QJLw+cGEW+Ga72sV2UhdSi71XEBiXpF6gJeqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCIhzKPi; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCIhzKPi"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d8613efbso5973536eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029275; x=1781634075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly4JmNOM5N61T5QvPZcscuv73dRglZhIk4ju+WD5XhA=;
        b=eCIhzKPiKtSkfgzGTnP8FGx3n7Ykc6qZe22Q2jjarkaY77rnIPN6jplmooWDQj5vlD
         k2Tld7b1g7V+ddRyWyEs+Lox7DUF/xc68vh9t/XzqtqSqUU5X1MshpOhY25oRpVKq7Sa
         dPZPm9Gizg++42xNDm3Co+EZfn95qkabzRpyf8WQpc3xkR7pzHAtKq/i6siLt3vF/tdJ
         bg+mcJ/qZjsW7cFj9W/QFFdFNTwpo0l/XjI/Vz0PyKiog6177/pxD7xFBqY0sctb4/2V
         2g5xXkSKue9MA23CWgoF3uiGK7pxaSphhjXg9TrWUuJ26Cy/rtArEsVsetVtx0gbYx8S
         gv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029275; x=1781634075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly4JmNOM5N61T5QvPZcscuv73dRglZhIk4ju+WD5XhA=;
        b=Qon2Xgc0nJePl38Cin79BtGDrKpbjFFxevVCJUP7ypu3sdyaJaXw5smge2LpUCtQvH
         BE7frgUWO0cW1zSEeFLfy9YS8lUrfeywTowMkHOUxJQL4h8N4mhrXLzM762Z4M6qm0Vc
         YOmbMYGDMPLjMSJ8lCQuIRBx4Qc/eGzisJJQY8m3Sv3pz8VaNrR+eu6zo++c7rWBBXTM
         vwDfX54tT55B5bTwS4gGnW3UNztzHCMgnHfqLDVH0PyjiYN0L2gs0yb527rdNCn7tTvu
         pyo4pCOVQwW3VuSIN9gAxwMu4KU/ohcSmoAerwqjZTDdnfa88qYMxEVCgAjuh5PWxiBL
         FoRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+N1Hi7Yq3WNveCm/iufPlG7YnktXBweNMvbkhBtY8vuyFTY3kuejEihfzQ4WHhLP6Ndgu4nxIp6mThvMJlSyiw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9PSa6NEF7wcCIvj2VZJbpFdJkrPDlUg8cJZNdLWmLcuEcXdN
	DmD6fGwGhgEU4vuuYKW5uWDkYCnQmfzLFWFJIjGsTx+gPzJ87yETYGVoCJaOMxkT+dGnet5SBpj
	5LqDNI+dYgw==
X-Received: from dlbsi3.prod.google.com ([2002:a05:7022:b883:b0:137:f3ad:9756])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec4:b0:12d:de3f:f3e5
 with SMTP id a92af1059eb24-138067571bbmr10124117c88.37.1781029274808; Tue, 09
 Jun 2026 11:21:14 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:02 -0700
In-Reply-To: <20260609182108.975586-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com> <20260609182108.975586-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-2-irogers@google.com>
Subject: [PATCH v3 1/7] tools build: Add feature check for elfutils libasm
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

This commit introduces a build-time feature test for the elfutils libasm
library in the shared tools/build system. It adds the test program and
updates the Makefiles to attempt building it to detect support.

Note on static linking: pkg-config for libdw/libelf on modern systems
does not list -lebl as a dependency. Older versions of elfutils that
require explicitly linking -lebl statically are unsupported by this
feature check.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature      |  2 ++
 tools/build/feature/Makefile      |  9 +++++++++
 tools/build/feature/test-libasm.c | 20 ++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 tools/build/feature/test-libasm.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ed1374af31c1..422329dbc20a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -118,6 +118,7 @@ FEATURE_TESTS_EXTRA :=                  \
          hello                          \
          babeltrace2-ctf-writer         \
          libcapstone                    \
+         libasm                         \
          libcheck                       \
          libbfd-liberty                 \
          libbfd-liberty-z               \
@@ -150,6 +151,7 @@ FEATURE_DISPLAY ?=              \
          numa_num_possible_cpus \
          libpython              \
          libcapstone            \
+         libasm                 \
          llvm-perf              \
          zlib                   \
          lzma                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 62909a9c799d..f0f39a2ab203 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -47,6 +47,7 @@ FILES=                                          \
          test-timerfd.bin                       \
          test-babeltrace2-ctf-writer.bin        \
          test-libcapstone.bin			\
+         test-libasm.bin			\
          test-libcheck.bin			\
          test-compile-32.bin                    \
          test-compile-x32.bin                   \
@@ -184,6 +185,11 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   DWARFLIBS += -ldl
 endif
 
+ASMLIBS := -lasm -ldw -lelf
+ifeq ($(findstring -static,${LDFLAGS}),-static)
+  ASMLIBS += -lz -llzma -lbz2 -lzstd
+endif
+
 $(OUTPUT)test-libdw.bin:
 	$(BUILD) $(DWLIBS)
 
@@ -311,6 +317,9 @@ $(OUTPUT)test-babeltrace2-ctf-writer.bin:
 $(OUTPUT)test-libcapstone.bin:
 	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
 
+$(OUTPUT)test-libasm.bin:
+	$(BUILD) $(ASMLIBS)
+
 $(OUTPUT)test-libcheck.bin:
 	$(BUILD) # -lcheck is provided by $(FEATURE_CHECK_LDFLAGS-libcheck)
 
diff --git a/tools/build/feature/test-libasm.c b/tools/build/feature/test-libasm.c
new file mode 100644
index 000000000000..928fc46ecc75
--- /dev/null
+++ b/tools/build/feature/test-libasm.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#include <elfutils/libasm.h>
+#include <gelf.h>
+
+struct ebl;
+extern struct ebl *ebl_openbackend(Elf *elf);
+extern void ebl_closebackend(struct ebl *ebl);
+
+int main(void)
+{
+	Elf *elf = elf_begin(0, ELF_C_READ, NULL);
+	struct ebl *ebl = ebl_openbackend(elf);
+	DisasmCtx_t *ctx = disasm_begin(ebl, elf, NULL);
+
+	disasm_end(ctx);
+	ebl_closebackend(ebl);
+	elf_end(elf);
+	return 0;
+}
-- 
2.54.0.1099.g489fc7bff1-goog

