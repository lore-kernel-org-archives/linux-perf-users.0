Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01301DB34B
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390811; cv=none; b=QIq3OqH7kvhGCL5U8jGEYAsydGYqfT52iXG4gPwhNuJBquVbDMGUOorl1u9RVZwQa1tKmKrUQBcgkRNzM6VTGSI8TLaln19j4lRra63TQU+gIWombinu+iIlRkD2jE1eiGkMKxiljuDBbcK/kWZSnzspzCaAmGQLv1/2re8gOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390811; c=relaxed/simple;
	bh=k4Sj7dM5EROtRyKRIxtv+8o9o4DaFse9qSyIbzlZ98Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOrC3MFlVvDI7MhsnEUVDSj2oNvZmkn92ZqWniBVW+7zkK78rFf+lmvWL9zWeA6W1enaOqdLRGlKmmrdpQNYbXHF0S+kwbDVzIizt0odwKV/it7E5fReEuo1NZykIZTEjfvkGgUOsxpWRExg/OVy4AteregiV1bWUwJVp8l1WFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rLzNy+Zo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rLzNy+Zo"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21654fdd5daso38629405ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 15:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734390809; x=1734995609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm+gy0vg6ADpwKtQUne3ds2s3sgHguLz0qdVVhDqizo=;
        b=rLzNy+ZoD62XrVBG36DyvneX+0xpq7HIHUzxZgHPmXBc9QEUE5T62rTbzpje8A9xcz
         n/NzfEDKmuP3+oXVhcadC8LYl74usW5a8YoL2U4UhvDPN4gFnfv8Eim9I4SfJplAQGgX
         6iTdSPXU7hLhW6VrjxXpl571KVK7PRLaEa1rTcJIGdJNU32cMQAskfTyef9AKRH7SHwV
         T8uye/SUoIQZI405B38FMIYd7XH6DTqQnQGWy+AnMOrNYbaCWTkNeNutwJdunKlHOpxR
         lWz1XL79M5qJnS4WSp8by4kzqYq+B7yzWyXH2Pq4m1fsN5jHcsSv3Tx2b6jhpwPLM4Ou
         MtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390809; x=1734995609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm+gy0vg6ADpwKtQUne3ds2s3sgHguLz0qdVVhDqizo=;
        b=KAASn/ld/4D3HlsRsWDRd8hoyl+/2Q2EvSo153i7rhzQXfjoFLl9n/QLOuXmf7VDbu
         me9fDm+C8TzccRtoZvdW68eSx7O+SzeZ49LcMY/+0o4xXmDVLvZ1BrXrAHxseHoXk+0W
         ykEUhNm/3CT3iAQEZ+fMQ0E8x/IigjYGAx9SJLtYSN5jp78AD4Qc6ESnnaVLGpjaBifJ
         qOVrNHHnh8dNEbpT1MXp2lBrhQV7n/oyhBsTYVAeh9A1+yEXLf83tkIpJE8urXT+EozA
         AgSoJJoTaTjrOqAjBcgjQrvtZXl+7NExIYmYszDn/u44v4OY+fSCyXAVBjfA20FP698e
         hJRg==
X-Forwarded-Encrypted: i=1; AJvYcCUI0DKwdLrik8zcJj+7shvGtseQq4XWervMvv1hB8asqdEPVhmWgnMjqkG6oQZkbiSlvS4c4XH1BpezeioINWEx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kg7GFzJtdeyf6PpWRf8PHf3ivpVj0gyT77UICXtxq2WZbcuV
	Ss9e+dt8WS5dTImkpzliJeFAtg1qq3WkdDr/fdHN/+z2j43M+bUKncpxJ+1dASs=
X-Gm-Gg: ASbGnct/mpaufyZR8fVgsSYne+Ivu5PhJ3LzmqZxLgpwVXhAuvSdp0c6enpKD/ppW7B
	jDQje+KNe7x7TPg+rEKDV8lA9cg1CH39q1e5rGRa1NkYvepDDxNDq8bsaxNsr1gRt1wla6ylKmr
	GlfppJrcRt2nS0GXRFibGAoNUOQIptspbcE05zsd9pJ1V5dcdLnw+uGHPlTevDugv7kHfBeFgwx
	rV74iBDq6cpRvSaHrO8xCujwSUjun+nzdE/XwPu1COtr9Cd47UDnqmrAWUUIxKv1H63TWNB
X-Google-Smtp-Source: AGHT+IEUS1KQ0ef501yi9KQdApUOJap2Q7VLgsPuhiCn2hfgEw7VxTtRPysE5A5XxEfaj3jPqra1Kw==
X-Received: by 2002:a17:902:ecd1:b0:216:3eaf:3781 with SMTP id d9443c01a7336-21892a58734mr187815855ad.43.1734390808967;
        Mon, 16 Dec 2024 15:13:28 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc47bsm48333255ad.63.2024.12.16.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:13:28 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 16 Dec 2024 15:12:52 -0800
Subject: [PATCH 2/2] tools: perf: tests: Fix code reading for riscv
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-perf_fix_riscv_obj_reading-v1-2-b75962660a9b@rivosinc.com>
References: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
In-Reply-To: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Nelson Chu <nelson@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev, 
 linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=k4Sj7dM5EROtRyKRIxtv+8o9o4DaFse9qSyIbzlZ98Q=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rCFsHN62Zdecfs+JNP2uLlep5+jx3vdkTV/r39gW3+i
 RnX8+22dZSyMIhxMMiKKbLwXGtgbr2jX3ZUtGwCzBxWJpAhDFycAjCR+wmMDF+2JGUuPhm4eJ+U
 wobqzxGrOt5EMjWvrZGL5XpxZAfXtzWMDFOnT7tTaS962CctyFjKfIG1dduJX4UMnUpCpZ6iYvz
 KnAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

After binutils commit e43d876 which was first included in binutils 2.41,
riscv no longer supports dumping in the middle of instructions. Increase
the objdump window by 2-bytes to ensure that any instruction that sits
on the boundary of the specified stop-address is not cut in half.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig              |  5 +++++
 tools/perf/tests/code-reading.c | 17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d4a7ca0388c071b536df59c0eb11d55f9080c7cd..f164047471267936bc62389b7d7d9a7cbdca8f97 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -229,6 +229,11 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=8)
 
+config RISCV_OBJDUMP_SUPPORTS_SPLIT_INSTRUCTION
+	# Some versions of objdump do not support dumping partial instructions
+	def_bool y
+	depends on !(OBJDUMP_IS_GNU && OBJDUMP_VERSION > 24100)
+
 config HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option,-fsanitize=shadow-call-stack)
 	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..605f4a8e1dbc00d8a572503f45053c2f30ad19e3 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <inttypes.h>
@@ -183,9 +184,23 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
 	const char *fmt;
 	FILE *f;
 	int ret;
+	u64 stop_address = addr + len;
+
+	if (IS_ENABLED(__riscv) && !IS_ENABLED(CONFIG_RISCV_OBJDUMP_SUPPORTS_SPLIT_INSTRUCTION)) {
+		/*
+		 * On some versions of riscv objdump, dumping in the middle of
+		 * instructions is not supported. riscv instructions are aligned along
+		 * 2-byte intervals and can be either 2-bytes or 4-bytes. This makes it
+		 * possible that the stop-address lands in the middle of a 4-byte
+		 * instruction. Increase the stop_address by two to ensure an
+		 * instruction is not cut in half, but leave the len as-is so only the
+		 * expected number of bytes are collected.
+		 */
+		stop_address += 2;
+	}
 
 	fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
-	ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, addr + len,
+	ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, stop_address,
 		       filename);
 	if (ret <= 0 || (size_t)ret >= sizeof(cmd))
 		return -1;

-- 
2.34.1

