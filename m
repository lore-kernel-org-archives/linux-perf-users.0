Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B21FA8FA
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479556; cv=none; b=T4UhuQo8bZDOJNHUkIv/ksu9tRB1rVTxc3kPh3+ULM3059ikZNDw31WtPTFM+xun0QHDP+wSkJetlgOynElr3Ba81zkYnhFGyYcCpvt8Z2Fsb1p5nYcbwn5yBOt29VDbQremZc7T3R6rV1kaJ5qgT+LA9/CqKt/VeUVHy/d+wDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479556; c=relaxed/simple;
	bh=GMyLH59PFYiUYCKLwxtQUm2kAygEyDToR1S9m0WZNeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SjsY7DHIHJiku4tV28a9PyXugINSEP9Pc4Q+hidVvNbxdoTAgtuBv6D3IOZ84aW/iWkMQRVJQ8oYjEmt4OCvthUlVwmTW8c3fGbQdlVu/2Q9eZFHG2shAng5TXlfD/ekPuV+PN+jXeECdYQFjiB3yNtZOMV1R7haKoEWmITil4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vvNpsJBc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vvNpsJBc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso51403065ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 15:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734479550; x=1735084350; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GeOVEdFEHGFM6Kz0Pkc246HNNIx9K1qYWLTokvWzItw=;
        b=vvNpsJBcLxL/mL0t6Mg6rDaaFIvVe95EyOngQ4T++01w5kfCAgbKJ/nANzherosaRC
         XtZ9dx6+/PPfnmrI5QO5CL8gSzv/q2QKFWsqc2LkMnm0wYAAo6WXNNkD1E1ZKNOZBkr5
         CRLEbcT1heanAbv3qY5TkMJjhL3sZBoD6cvKCjanU8f3yTTYMutOuprNftl2GWXcIyP9
         AwSqfR4xne/u7RifwafCkudL5KFDgAxY8zQ2ou3/pjka4m4UOXciQ0/sd1U5IsdL86Ih
         +pnuEEY6MEikKNV7doHm29Nw6EiI2qdl2ov9ShOzSGIYyEn66Alt7HLFryrXVKtaGAmb
         QobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734479550; x=1735084350;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeOVEdFEHGFM6Kz0Pkc246HNNIx9K1qYWLTokvWzItw=;
        b=HnQMucjTCZt1QIWRq1i+Pa7LAhgWS7mFfI0/gj+XWP4SKlnAY6dtKH1jXN3pFUbGty
         0zVA8doFR1DPK58omOoYOq+x4qUU/ufYGsJmndh/BkVYFp7lwFVMmxx+sJWRbDMHj3NG
         vXVGe8e2NeBLMUjauL/+bv7020Ju1sDNJXFxT/onB7RGTQdVKrBbbthmmXoVmN3lSV7w
         Zh/gPWaxpYt1ypQTlOFuP73MO2xcVhNbzkFsd/M66jL29JQSb63ZgZTqKiJdfks2M5Wp
         cUi38V9Fl3hu6ZiRT578jJ/jtymHJXgyuhSXqRWTj/JP1LgHtvbSfWPY0Qu8QL0R47Dk
         9FUA==
X-Gm-Message-State: AOJu0YwA+DQYI7mRC8K/Pa5AkKmTvGnSDJDiyMZklkVh6cCv/D+dedHR
	9tIcnl6gB3OUv/cpdR/gPRioW/p12nqaGCaYnmeBRH0rys8Gy2EanDOB/t3rUwJII/ZTYZ66fSd
	U
X-Gm-Gg: ASbGncu8IVlj7ZpGK6MnuBP66kgmoVyvVjYwJ4zegSbHo3CFPwaVmEdKF+1HHAhI2sP
	49kiheQ6q4Q9EgHvewZ3LeinYeGxtwRLJjsb+EV8sb+oFjZwTjo7b2/BD08uRfL0axITr5S0+iX
	fbwxFW/ZfK/BDfEpPyb93FeK5/TjrgV661n3H1ldyA9N9it4hIYUW+ZPWyGRYEwCF5mtDb125mA
	MVXlZS+6vepnfB9W6oe2Ppv/E+wPR6WfRxCbzwdpwgufXiabHJ99YJClr8bEo74H3G6goah
X-Google-Smtp-Source: AGHT+IE8h+7wsOokGyz0BX6sDCEqaDaSYl7MWAZYjl0KKibeho6DEXkEcxCW4CpVQzh0X1E5CaXGpQ==
X-Received: by 2002:a17:902:f542:b0:216:554a:212c with SMTP id d9443c01a7336-218d725b78dmr9314985ad.46.1734479549811;
        Tue, 17 Dec 2024 15:52:29 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e72111sm64343085ad.271.2024.12.17.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 15:52:28 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 17 Dec 2024 15:52:08 -0800
Subject: [PATCH v2] tools: perf: tests: Fix code reading for riscv
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAKcOYmcC/33NQQrCMBCF4auUrI0kqY22K+8hJSTptB3BpEwkK
 KV3NxbcuvwfwzcrS0AIiXXVyggyJoyhhDpUzM82TMBxKM2UUCepZM0XoNGM+DKEyWcT3d0Q2AH
 DxL11o1AOan9pWAEWgnK447e+9IzpGem9/8ryu/5Y/Y/Nkgvuzk2rldbCtu5KmGPC4I8+Pli/b
 dsHwq9MS8cAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4291; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=GMyLH59PFYiUYCKLwxtQUm2kAygEyDToR1S9m0WZNeM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3oS35br/zZf3zjl/K08fqNMNTNh4+5rr9IOWK2SE21/J
 +rxaKNkRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABP5tZPhv+9tu8bk+LXGbEva
 4wLbtZ47VNut59c7cejYjuf8R+tsvzMyvNENX8gTEHAlW3OV0v/I1CDe634fLnwyTFP7kbH/8uJ
 tPAA=
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
Changes in v2:
- Do objdump version detection at runtime (Ian)
- Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
---
 tools/perf/tests/code-reading.c | 84 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..7e24d10a543ac18ac2be70b829d088874e0edfd5 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <inttypes.h>
@@ -176,6 +177,66 @@ static int read_objdump_output(FILE *f, void *buf, size_t *len, u64 start_addr)
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
@@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
 	const char *fmt;
 	FILE *f;
 	int ret;
+	u64 stop_address = addr + len;
+
+	if (IS_ENABLED(__riscv)) {
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
 
 	fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
-	ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, addr + len,
+	ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, stop_address,
 		       filename);
 	if (ret <= 0 || (size_t)ret >= sizeof(cmd))
 		return -1;

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
-- 
- Charlie

