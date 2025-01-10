Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF824B240
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536975; cv=none; b=TIGWDH6PjHdE4KTSlCQizEuwZCy3o5xuf96pwSJegT5t9OXLLF+pTQMK71VRfZtvObrNwIAkKUmu2WN0TOBc2iffynsMX/QCKRciQ3ksen7r13THFnGa9b8MpCXDYaisyrR+L/zKrJs/ReTDm3h02sOH9mGTtkEcew2e1nYUL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536975; c=relaxed/simple;
	bh=L16zPyM52CEabrV6MpoFJNrF+kZ6qsyIXG7GrhJJXOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AkNd4sfedbqWH5IzwDEfeSOG9ObMSmux8NI6mG9PEIdbL5YId2rJN4P6i/vprHbDp7VKYV12CoeKmsLTaaAn8Gw/2chueWTncHXBVM4L4W/WMqUeKvHv/J/3e3D93tDLYDwkBdqXbLCZQrSBK3IXuQCQCT4+CkNh4jxs/87KLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dDbyruAD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dDbyruAD"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21675fd60feso53984615ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736536973; x=1737141773; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cex40nB/noEwYT/MbchJE807eqDcX65N/QD8HqxX0qE=;
        b=dDbyruAD4sbsy6mpEvh1cVQAdFljMoalFdL8rgjP/kIzJtEMj0egmdJ9sv2gbCfvLX
         cxUQEW7Q1P3DZicZr6lZkHbP+DAfTy0bM6H0JRC/MJsLIBZT16V6Jo7g0cISib6W7/Ay
         HLx2q+ypZ0saOE1Tf+m6WSv0OeQu8wrEnaExE5KTi4eNVHjvglQpHuNZeQziJYaIJxJG
         Hi6H4fF8SxhgPsblQgU6Ta066u7AVhJpIloLRMefhsopXmavc3Z54rlXxFAYYXwFoC1o
         BfVRZzcGLmWCKdze6TzXnE8XlmxeVE8LJqSP/0i69y+BmdhP78Fd22AVxjOc+rBQqgzT
         K53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536973; x=1737141773;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cex40nB/noEwYT/MbchJE807eqDcX65N/QD8HqxX0qE=;
        b=LEH6yBJpNzB5VY4ajYLysaz+aq91bgSGez+xL+KOby+mO+PvzgLVqKABhcFYs9WWgF
         a0d196KoOTApYbB2I3vMdZy3H260UEBWn6YK2F/iHod9ZgPuMO6269xh6jovClRCag8A
         yYN+Ha83wU+73AgSs3lgESWWkIVcciuthOiOSzKe+ZLu0ZifdM4sP7P09Yq3er+OkWGo
         Xuq0yDVNMHUT403S6qDKR55LvFHo7bl/V3eYNRTBsThjNG9L7hdqduClfcO8D/M3C2F1
         15xgWUrJHcxzK4CKPOaca3xZiUPzHmu/bg+iztesb4BFHw3uZWGZYGireEVUrqd9eBo7
         2aMg==
X-Forwarded-Encrypted: i=1; AJvYcCUmeS1viJtNR879Vn3Rz7rWiFFxGYQQA/3BTB4hxvXTxLX7+WXM3khEwKQ1YJ6NwG0szg0NM4QKpKkT5FT9+8D5@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdQLs5ipHAFFRZpJU56eAXjqGHTiHrxrZhiZA0U5oyA9B+j65
	Yr1Q/8WWeLxTVQFgRCd6svix0yhgCZX5j8A5pEB/3P8jRS1f6dKu9OFWO4n8QK4=
X-Gm-Gg: ASbGncuYSo/63MNGLj+HlcU1wArQf6MQ2KpG8kIY3cuzrKP4SwOpZhhnSTqbppHuQCD
	mV7zH7TZuFnPRb+c4aXxkRXDKaaLLEZSMDu2U2Pday8t7W5CkDhw9aqV71ofQ3IkL857wjhudlN
	UFRHILOokAOlDp4t7MfyCUb3LIPJAuxe6Hwuy/hlaLsaQ4Iw3jZAYkE0DRDhvmnpMMOovl7xvD7
	FyJCx0whm1/aTHtDiIGA8WE1JFt/H0pIcmiaK8EpPHbOBxjpSW6Df/aSDr95MPVjaV6SyKA
X-Google-Smtp-Source: AGHT+IFLvgowhBdH3STVilOsjwxjCJgWl1jepuJF2YS4XP47dCYKiPc8WD3S4DDA5vCLhAbJsgbmjw==
X-Received: by 2002:a05:6a00:a11:b0:728:e182:a8b with SMTP id d2e1a72fcca58-72d21f38395mr15199037b3a.9.1736536972977;
        Fri, 10 Jan 2025 11:22:52 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405493e3sm1872650b3a.4.2025.01.10.11.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 11:22:52 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 10 Jan 2025 11:22:51 -0800
Subject: [PATCH FOR-NEXT] perf tools: mips: Fix mips syscall generation
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-perf_fix_mips-v1-1-4e661c3b710a@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAIpzgWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0MD3YLUorT4tMyK+NzMgmLdRHOjxEQLYyOzREMDJaCegqJUoBzYvGg
 lN/8gXT/XiBCl2NpaAJrY9dxpAAAA
X-Change-ID: 20250110-perf_fix_mips-a72aa8326a10
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=L16zPyM52CEabrV6MpoFJNrF+kZ6qsyIXG7GrhJJXOk=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3pjcffp+ntSfyZcO+3x8uiljRGMj9oZWXOS22cI3XxXd
 furjc60jlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACYSaM/wVzZxdu2GVXMXLfvy
 f2PFi54a64i7L7mUPK3dbKS/RPDPfMvwh9MmvzvDIfxqdPPhkNm1osqqPu9OFOz78Y3PZM6H5zF
 mzAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The mips syscall generation was still based on the old method. Delete
the Makefile since it is no longer needed with the new method of
generation.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 619ffe669496 ("perf tools mips: Use generic syscall scripts")
---
 tools/perf/arch/mips/Makefile | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
deleted file mode 100644
index 827168f1077a670d558878e4de2694ce2083d046..0000000000000000000000000000000000000000
--- a/tools/perf/arch/mips/Makefile
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Syscall table generation for perf
-out    := $(OUTPUT)arch/mips/include/generated/asm
-header := $(out)/syscalls_n64.c
-sysprf := $(srctree)/tools/perf/arch/mips/entry/syscalls
-sysdef := $(sysprf)/syscall_n64.tbl
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, mips) $(RM) $(header)
-
-archheaders: $(header)

---
base-commit: 01d08f525d260b547fd6dcf9fc8405219331bc34
change-id: 20250110-perf_fix_mips-a72aa8326a10
-- 
- Charlie

