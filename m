Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1237BE97
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982293; cv=none; b=AJGSw8bj2VaceBv+qrYN96b2vWfg3Xl98aYbOCfq7ruwh1JNzxX8h28TZ4wD86BWMkwJFBWLUdZw48I9zwm/8+GWk3yCAl731C+At06gSQj+hgBZpPWat61V4bq06A4skwUY4k3qze21Z/eURW6vzUoltghv3qci7uh3NELdwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982293; c=relaxed/simple;
	bh=NKmS4ymSwfQxEWIzJPKOkiYUhGinMxmelF5ZgEfuqp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iquCc495xLZ5TBmP/T6643Lv5llFMwIHaiJZn0cnv5/FmB9phIj5p9MTmtRNERNxPJ/nb707BBZfkM6EIIUjYQyZG00QI1QvV4DaIgvSbNmkFZf2dC2j4l7vHH9y5ljIaqVV8/9UZNrX6aWjHK9Jr0+sq6+Oi5AOkqIf0HewnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwJBb1jw; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwJBb1jw"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137eff27f36so6480591c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 22:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780982292; x=1781587092; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUtXIOfKKY0YQV5gh85yfIsJQMQSXMy9or8FO6Z2WOk=;
        b=gwJBb1jwHQNKxDFU37ZEPUJ+xW2pYKBIkUQPWrAnLdFLaLGl43iyiQ9Hv4oG8Kmt2q
         /0UWqr4L/FH3elBqExgb9E76alxhwITRmLbFGygViEMuatKXbWERr1YbElEkW0YE1Inp
         avFhYPyB193/kxqNQUqQX403oGVqSXmD3GLrWkmZcpZe1fRRSPrD/G5GzLOXAfi43joM
         PXwEPP21VdjvyMmFkTu9gb17Y4OD8MNIz6mrVn7SQdvX+DwBO3Rkm87XP6YRBZxRvPdP
         9HNcHt+moXx/s4Vgkm6o3W7iXE7YnYk4LexehbVV/OLu1sW9tHRuaWVUF6Ryd5Zh1c/s
         ouZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982292; x=1781587092;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUtXIOfKKY0YQV5gh85yfIsJQMQSXMy9or8FO6Z2WOk=;
        b=dVc3H/BvSkqizHT6uQnQd+yS/BBUXoenv9X290YdJmvw38Hc+7X3a6d9SirKZB7aa4
         8d5rlqx1ofIy7ZXaH1TWaXKf3YVTrPTGvALQsibn+R1KfOj6O9LL5QndkvwSdOcfLNyC
         U8k5fr4KxVNWgCwjv2PJZcj0jOTq77R296VchE3DIl3DFnYYPrx+ezGjv/H2InYlbH9r
         qXopOTqfa/yraZ0rlOO0YvYQOUXHP7HK5XBSi5At1osV6TWmiHUs9ObQilYNfTXJ/Vom
         tk5Px0mhZmDHHQexGnw8ccYGG0wVCMQ0shrYj+2UEa4b/NndsXv0J4b8W380xChCgquY
         Utrg==
X-Forwarded-Encrypted: i=1; AFNElJ/C/X8SmwzRfn0MowTdjLv5MeN/pMIXh47NR/j4e7BsfdN6hP4Y3mdlzdMoGElyhSESVHWH11SV1efmCwxg+qz3@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIi1/+rdDBzsU6gmuhLoPBjKweaCeCr053u4AHLtkXZlXcMJ5
	fD8Iz17kITwI/Z/7KRsbUg8U5gru1FTfplJjLzsYYDlLmOuPvADGzLw6kiH5FRtPPys5HSUe0Ef
	EZSsVces9fw==
X-Received: from dlec14-n2.prod.google.com ([2002:a05:701b:428e:20b0:136:23d8:d537])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4a7:b0:136:5631:bfed
 with SMTP id a92af1059eb24-138066fd564mr9176894c88.20.1780982291305; Mon, 08
 Jun 2026 22:18:11 -0700 (PDT)
Date: Mon,  8 Jun 2026 22:17:53 -0700
In-Reply-To: <20260609051759.405027-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609051759.405027-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609051759.405027-2-irogers@google.com>
Subject: [PATCH v1 1/7] tools build: Add feature check for elfutils libasm
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce the build-time feature check for elfutils libasm library
in the shared tools/build system.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
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

