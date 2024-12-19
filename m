Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50BA17E00E
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Dec 2024 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644681; cv=none; b=mCOUEOhxNmI4cNPyEsxyA5O3jy9gxHdUuSsntYgSDPdI/+N7MPd/UA92BhGlNbKgl6nPQo+RAxRourw1KO7q/sLPLDI/6LvyfJa+wIqYEkjwVXvPEubO4DP0tnMyjNyiuWyjmCpCp6QdpcY1oGEAvyhxeMBstRxgEOsvCbh772M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644681; c=relaxed/simple;
	bh=wWyB3e6Pwb2xRIuVd33jnwwDT6+K1bV7pj/iZQhcDZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KbgWRNMbPI9He6t5+jbDjD1OKJxpwi1lKoMYMYc0YvxevLYQ+j7jUv5jC/5EtWVL+dCQwOL0LGVdJLbvQ+YqxgZRr8PcmPRY/QNYiUjoGB1YvKyC/IfXAoKpV+oT28bhqJZlVRpYVaNmr+a9qMltOpvcsq9q8//vj5ocHLRd9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YVeHqLmu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YVeHqLmu"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so12187885ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Dec 2024 13:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734644678; x=1735249478; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYEfqfk8DGuXJ+bqhaUnePdNAvFx/LugbO7a0lVFtTw=;
        b=YVeHqLmu/1lwKs12eYz27n7DeJTWKZaDRRixkYzx4JftC9+UjhhwZi9/nzlJ3jgQYp
         kBgxsgE1tYSV8YquAxw5Y9MJanQFxV/EtP6DCNbNSL+dDBhRG3b4E6M47lj/oQVBCWDK
         oBaGadmi1+FUw7eCVMUa2IUDlhd54/Bq8sEKCF5BtaGni08hgQpruDk2tyLZleLMyaFb
         5sqyaGlJkNm1WxDOfQD6CnIRyNvS4Rl5J37QbFiDE7e4wcCzKC6w5Mj9Y1zpJHfSDkhj
         1Ouq43KoBNXZXjgUFIvNI+2+XbjKcYJVhYuSUU3s/lg23AlJ5WJcf3bumHjPTTEejf8K
         +3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734644678; x=1735249478;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYEfqfk8DGuXJ+bqhaUnePdNAvFx/LugbO7a0lVFtTw=;
        b=R69ZwL09MKdl8Vgi/6rAsIyYFKQNt7BSFe89K7zbNvw4zieeqyS8BX8fON6tejPIfp
         rTBKLexjiIujzTzaulLZAG4jvNggg8Xkxnbn33dUBb/dZnrRgny604iLf757f92Ju/f6
         tWtrHjCEL9sqG4hyX208McN2SXAkGpquo+PmUbLwUNpUDRUd5eY4L0SrnspBWOeNa8ZH
         39gMLhJRhtzNIlLggcytdzoev4acYFO0f+T+OAnB+VsP8CAF5tj35jiB/kDOmD1Nmj6d
         rcP1KJWkdQ+uqniHKMpqbbJvanC/2nm+tH7yaA0CdwpTZbY3CTwN8EQX6HZv0PrimR7W
         Oy7g==
X-Gm-Message-State: AOJu0Yws4gwpOxdjQ4cCnQl45hiRa4EjGUJSpxG0YiImycNQaT4xcylX
	4p8nrM5gHGuVNNZWzxvM42qPhDAErwMNLGAszr83Bx/fYqvxQq8TcJJqf633zas=
X-Gm-Gg: ASbGnctWk4guhJVirsb/AU3b2mU9ysv7FWKehM8GO6k5/+2m1SpzrtTDHceo2lYDc/D
	6EUkqCFTF8cyPcm4N2ukDSOIdOf7AueWkChwMf3HVK1JvsKE6loXteffZBeKCnbR9BPf2Tl8Lnf
	O9NpnVkBdyWo1TwGeOKxZgeAFHgCwrswReKehfXoQ6uP6A8Qt18CRq60p9RWFOYsZVMX8WK6puf
	RNhx3Vfv/YfTRx671Wc5HYJuEhZY4eYPnvIYtT+jTtuiQACyVZWKFecvx5G83cOIar1gr3I
X-Google-Smtp-Source: AGHT+IH3kYwgtQW1aXJARuWrTfbyWFEx2W9Kj5c944+awCZK4morLQyWo6rMAMCN9RkSh+qEbRce9w==
X-Received: by 2002:a17:90b:538e:b0:2ee:fc08:1bc1 with SMTP id 98e67ed59e1d1-2f452eeb5aemr855129a91.37.1734644677918;
        Thu, 19 Dec 2024 13:44:37 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52d27esm3847949a91.10.2024.12.19.13.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 13:44:36 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 19 Dec 2024 13:44:25 -0800
Subject: [PATCH v3] tools: perf: tests: Fix code reading for riscv
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-perf_fix_riscv_obj_reading-v3-1-a7d644dcfa50@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIALiTZGcC/33N0QrCIBTG8VcJrzPUbbp11XtEiDrdTpAODSnG3
 j03CKKLXf4/Dr8zo2Qj2ITOhxlFmyFB8CWq4wGZUfnBYuhLI0ZYTRmt8GSjkw5eMkIyWQZ9l9G
 qHvyAjdKOMG0r0zaoAFO05XDDr7fSI6RniO/tV6br+mX5HpspJliLpuOMc6I6fYmQQwJvTiY80
 Cpn9quJXY1hipvWtVQLXRvR/2nLsnwAxBQauxUBAAA=
X-Change-ID: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4747; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=wWyB3e6Pwb2xRIuVd33jnwwDT6+K1bV7pj/iZQhcDZo=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rK5L1hex84vCmuenXW62S0/v5jDz8cWPAsouaTyOVom
 ZNvu3pSO0pZGMQ4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZiIkhLD/xj3KdP1NK0+eh9q
 u5bs1HWwUkFhK6P3pJP8j7N9Ze8ynWRkuCp0uNNb9rbNc9n4UP49Go+2r+hbrJTVWduqOZtBQOI
 gJwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

After binutils commit e43d876 which was first included in binutils 2.41,
riscv no longer supports dumping in the middle of instructions. Increase
the objdump window by 2-bytes to ensure that any instruction that sits
on the boundary of the specified stop-address is not cut in half.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
A binutils patch has been sent as well to fix this in objdump [1].

Link:
https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]
---
Changes in v3:
- Dynamically detect riscv for objdump change (Arnaldo)
- Link to v2: https://lore.kernel.org/r/20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com

Changes in v2:
- Do objdump version detection at runtime (Ian)
- Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
---
 tools/perf/tests/code-reading.c | 92 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..b1abb34d7818d8a9ac963e2185ec3e7d9bf8d387 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <inttypes.h>
@@ -8,6 +9,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/param.h>
+#include <sys/utsname.h>
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 #include <perf/mmap.h>
@@ -176,16 +178,104 @@ static int read_objdump_output(FILE *f, void *buf, size_t *len, u64 start_addr)
 	return err;
 }
 
+/*
+ * Only gets GNU objdump version. Returns 0 for llvm-objdump.
+ */
+static int objdump_version(void)
+{
+	size_t line_len;
+	char cmd[PATH_MAX * 2];
+	char *line = NULL;
+	const char *fmt;
+	FILE *f;
+	int ret;
+
+	int version_tmp, version_num = 0;
+	char *version = 0, *token;
+
+	fmt = "%s --version";
+	ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path);
+	if (ret <= 0 || (size_t)ret >= sizeof(cmd))
+		return -1;
+	/* Ignore objdump errors */
+	strcat(cmd, " 2>/dev/null");
+	f = popen(cmd, "r");
+	if (!f) {
+		pr_debug("popen failed\n");
+		return -1;
+	}
+	/* Get first line of objdump --version output */
+	ret = getline(&line, &line_len, f);
+	pclose(f);
+	if (ret < 0) {
+		pr_debug("getline failed\n");
+		return -1;
+	}
+
+	token = strsep(&line, " ");
+	if (token != NULL && !strcmp(token, "GNU")) {
+		// version is last part of first line of objdump --version output.
+		while ((token = strsep(&line, " ")))
+			version = token;
+
+		// Convert version into a format we can compare with
+		token = strsep(&version, ".");
+		version_num = atoi(token);
+		if (version_num)
+			version_num *= 10000;
+
+		token = strsep(&version, ".");
+		version_tmp = atoi(token);
+		if (token)
+			version_num += version_tmp * 100;
+
+		token = strsep(&version, ".");
+		version_tmp = atoi(token);
+		if (token)
+			version_num += version_tmp;
+	}
+
+	return version_num;
+}
+
 static int read_via_objdump(const char *filename, u64 addr, void *buf,
 			    size_t len)
 {
+	u64 stop_address = addr + len;
+	struct utsname uname_buf;
 	char cmd[PATH_MAX * 2];
 	const char *fmt;
 	FILE *f;
 	int ret;
 
+	ret = uname(&uname_buf);
+	if (ret) {
+		pr_debug("uname failed\n");
+		return -1;
+	}
+
+	if (!strncmp(uname_buf.machine, "riscv", 5)) {
+		int version = objdump_version();
+
+		/* Default to this workaround if version parsing fails */
+		if (version < 0 || version > 24100) {
+			/*
+			 * Starting at riscv objdump version 2.41, dumping in
+			 * the middle of an instruction is not supported. riscv
+			 * instructions are aligned along 2-byte intervals and
+			 * can be either 2-bytes or 4-bytes. This makes it
+			 * possible that the stop-address lands in the middle of
+			 * a 4-byte instruction. Increase the stop_address by
+			 * two to ensure an instruction is not cut in half, but
+			 * leave the len as-is so only the expected number of
+			 * bytes are collected.
+			 */
+			stop_address += 2;
+		}
+	}
+
 	fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
-	ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, addr + len,
+	ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, stop_address,
 		       filename);
 	if (ret <= 0 || (size_t)ret >= sizeof(cmd))
 		return -1;

---
base-commit: 233157785a34612e5899be6edcc6a53ea682d379
change-id: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
-- 
- Charlie

