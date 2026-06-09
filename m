Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81D3D0BFB
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988863; cv=none; b=h/RF91nrWxc7Xu372QFGvAV6suycie1f/854W4Ww7yaHM5F2Qa8tiPPPG2OhRaRc1H1iclf49jyaa3v7v6Y5u7cUoKVa4wGuK2zuVW4DUl31Qg42G0jNiBebRHCn85G2IJ0WnU/3/1WN1yijvucR/HCxTBSZb81DQq1NZ5IAS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988863; c=relaxed/simple;
	bh=6Y6Kxxj0ic+87OJxMSRx7NvuBDYNK74TUl1X8r/VrI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qr06JicbRm9V2Lvb9MYm1/ZtebU64OVsAULpXvYh7kglRzPs8YtTGJJ+FMbUkFv/WBmRR066j7WlnCBwxFxaXk4ov6dLSckbd6PTRoAVy8qnxx0BD8XD7a/gRL9CXTW60r95pOVlOxSxBz6pGbv5qFb868frYjfdKnSP4EWJgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+XUf14S; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+XUf14S"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-138155294c4so10562283c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988861; x=1781593661; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUTH3SLhVAIaNVX+dAaIQun2/4gjAUxBjr7otV+pO2I=;
        b=p+XUf14SD9Y70JgCCcwYfVGWPkuhYdr9HeYQuqPIxJX6itzZ3KadUQ3/Hgv8JE+AKQ
         fXMleXnL+RHEL4DqxVG+37h3VAH9zCQ3DeBNaYni2Aqx2aoUOaKaPl3iBn+d+YJIG5Fl
         hk1Wszj5aYf4rPApbAz81Q1PeqCOLzCsoJ4NYhSk7LIlmEUTCnNBLA3JoxrA0PTlvc/v
         yXmO1lhB0W17Kli2UDVWzcEKtiGIa9rl/MaPZNgjxhO4lvjWUqywSZivAg3d9FG45AuH
         tuMZYLFTWA6KVvCm7QT5h1LTv9B9AqSfmqFk6lmOkiCEuUE91wMAJEFErrYzpEL2vFkM
         t1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988861; x=1781593661;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUTH3SLhVAIaNVX+dAaIQun2/4gjAUxBjr7otV+pO2I=;
        b=SbDEqOYxnfuHCzyVKNNJhOPFQysaNJ9jjcT/0s2gI9tnpejWoU+rVIpgzB3ZyfEpAS
         wSV2e20SpFXhpqZVVB6zq+QbF1UBx5aSIV+g+jYKbUxmKQ9MBZ8DaiQYh8cwsG7KbtKa
         GgebpUXTVY7JZv5svNO/mwirvF3IEwH4el2krbKXenPFILyijJZhWscDR/kB/k1aGhHY
         I4N0BXlpUAnm3eHBLmJzSNNpT4qI4r7f4jMZJ6poEx7SdS7kc309oxXfOm94073Vsvz3
         1IybQTtkuFW/wCVcjxFT209aFa7mCmf+7Jn0lbl3nUNoUel+NnUFrCcM6PYBD9KZaqcG
         AHLw==
X-Forwarded-Encrypted: i=1; AFNElJ//OevpW+LBN6Pz3oWSznH2Q5utd+7ep21dHCu5loRkuaa70TSFbcD5UyrtZRnS42fNatJpcsldG1rEC4S9wAMv@vger.kernel.org
X-Gm-Message-State: AOJu0YwVucGxU1RLGAC9KJc9ue2MSOvwq9pXRnaUB+oW1fKsjquVOi6x
	wS+fhy+7Jsv2fo8+2hfq2AZYFQOq77Ie7xKKOZBqU5JthKUk6F6F9MRbk95g0Je1ByyifSyZLUs
	V4PcQscYKMg==
X-Received: from dlbqd13.prod.google.com ([2002:a05:7023:b0d:b0:137:e7d3:1490])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2595:b0:135:3025:be5c
 with SMTP id a92af1059eb24-13831bb3d63mr1083306c88.27.1780988861172; Tue, 09
 Jun 2026 00:07:41 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:07:26 -0700
In-Reply-To: <20260609070732.545416-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070732.545416-2-irogers@google.com>
Subject: [PATCH v2 1/7] tools build: Add feature check for elfutils libasm
From: Ian Rogers <irogers@google.com>
To: Serhei Makarov <serhei@serhei.io>, mark@klomp.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This commit introduces a build-time feature test for the elfutils libasm
library in the shared tools/build system. It adds the test program and
updates the Makefiles to attempt building it to detect support.

Note on static linking: pkg-config for libdw/libelf on modern systems
does not list -lebl as a dependency. Older versions of elfutils that
require explicitly linking -lebl statically are unsupported by this
feature check.
---
 tools/build/Makefile.feature      |  2 ++
 tools/build/feature/Makefile      |  9 +++++++++
 tools/build/feature/test-libasm.c | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+)
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
index 000000000000..f3598ad1cc9e
--- /dev/null
+++ b/tools/build/feature/test-libasm.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#include <elfutils/libasm.h>
+#include <gelf.h>
+
+typedef struct ebl Ebl;
+extern Ebl *ebl_openbackend (Elf *elf);
+extern void ebl_closebackend (Ebl *ebl);
+
+int main(void)
+{
+	Elf *elf = elf_begin(0, ELF_C_READ, NULL);
+	Ebl *ebl = ebl_openbackend(elf);
+	DisasmCtx_t *ctx = disasm_begin(ebl, elf, NULL);
+	disasm_end(ctx);
+	ebl_closebackend(ebl);
+	elf_end(elf);
+	return 0;
+}
-- 
2.54.0.1064.gd145956f57-goog

