Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1E15ECF1
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000839; cv=none; b=D8c4TP3Y1oW6CWkfJlWNKBDHjMSwKoh1V2o0Djn4sNrd0j8DkKcW//DbjYMCUOTvwzDcweCwaUgMsbdBaOqZUGTyvRCBJXeYYuUuQNClh4cX/0KIJMDxpaUsjlOEJdp+izGFqlOLALMJG10PfEF0NyjQq65P4pP5JPudpbLG32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000839; c=relaxed/simple;
	bh=booZHkb3J+P+9GGvIu7tV+nPBnPKParzLCabNBXvnRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cvy2b+KOWTMdzqelxSL967jdUuKrei2owzKwP3n9fSMWsx6BDarK3HFGFLMUq4iwq/8h/f+cStEuzL/WIZcNzMzSvxvkpCtGo3xABsCiEao4v5nKXMItWy6nwZw+ZMPJ9CxdzOHeDBBV6lDqa5KHCldJ3NscDo/si/6lbHUjbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IKGeicuy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IKGeicuy"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ff1cd07f56so11059875ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 20:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000836; x=1723605636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aAlB9PgJPPOtppfWCUQ5EXdOMFZzMBqg7ZuOwVCeYY=;
        b=IKGeicuys95nsnuwNpxp5JmLMvmZKHVEzgqQU8LkLqQjR/x3egfQ6Bl13jj4mhvD6j
         iCG958ETffsGwDoUUKG5u/2IxlwLKMpmkthLDHw2f6vEzQt74vJ/4FXP67vxJvRuk1vI
         5L2XjwwfdoS2SatdHXDaqB4xMM7KudgefBHk1fgb+TW6lRfse4HtNE0g+32eQ7DTw1/k
         i8uEPVPO+ieWzbgO53tPHgVmcBoXwZ6r1k+Fm13KZBSRwbMJ1ofQgyqUcAWEp4s9MhlP
         NY1Gqs/UH7fcfQFchJFEWMQKqOQfobNoBbQX+Z84re7Ro0nK58DTeMnFPm67qEUVY4Bx
         oVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000836; x=1723605636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aAlB9PgJPPOtppfWCUQ5EXdOMFZzMBqg7ZuOwVCeYY=;
        b=SvHhycVQTvm/UJ/EP9HwUNOuh1JW9Vbp7w3+tphtsMvP1O3xBs1xfU4mwKq/Ns68uN
         +9LqkXrGu95/U6vEpQWOJPVWzVH9hh8Z9JUagt0GOizN1bmLbfqJ9x7PhEu5TBGAF/07
         ZwOd5VhkOXRucN677zcwm+i5jkB3S4WZQEXXUmmBCZKw5FRCVrY3h7rOZwvwYLh1/QgK
         fS/0LFnJsCRDBJPCNpIZK3ZbsFRc3Hg+x0VNM3a2cqVqz5aBwRpRk9H+wr/cRF9K4jdl
         35mt4rzZ8ctVRE3AH36KYSdAiGF9mLhF92QoS4rVK5EGTMG3MpJ6TJvAPnXj7fwPA33B
         4v5g==
X-Forwarded-Encrypted: i=1; AJvYcCWTYqNwckfcgc6P/KMJ0UjtOe1l5BGUONdrWSqgqBNeCxtG/hfbFDQXEJHB9qh3guAV7jBT/6iBh0oc1E03PzxVQblZsp8FGVatOg426nOAlg==
X-Gm-Message-State: AOJu0YxzUBLDxaN3LNsoMd2VaBCOYeVRucJdh7XnCmIPz7Y2XoKbaTor
	+80tYbL5SH8BKurMqG8x1d/TLBxjqfuA8ji3+AV+ntsJnmUplE7/Dr1LmB6Uf4k=
X-Google-Smtp-Source: AGHT+IGpXHYFN93zMcnLM0eYp3c42rH+KGNp0iFujr93jZKuPa9TwsE0DOJDAP4cdOLFtHf/EiwMMg==
X-Received: by 2002:a17:903:2441:b0:1fb:8890:16b4 with SMTP id d9443c01a7336-1ff573c4f57mr209914015ad.48.1723000836079;
        Tue, 06 Aug 2024 20:20:36 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19ebasm95116175ad.23.2024.08.06.20.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 20:20:35 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
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
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v3 1/3] perf: build: Fix static compilation error when libdw is not installed
Date: Wed,  7 Aug 2024 11:20:17 +0800
Message-Id: <20240807032019.1828674-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807032019.1828674-1-yangjihong@bytedance.com>
References: <20240807032019.1828674-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If libdw is not installed in build environment, the output of
'pkg-config --modversion libdw' is empty, causing LIBDW_VERSION_2
to be empty and the shell test will have the following error:

  /bin/sh: 1: test: -lt: unexpected operator

Before:

  $ pkg-config --modversion libdw
  Package libdw was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libdw.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libdw' found
  $ make LDFLAGS=-static -j16
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>
  Package libdw was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libdw.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libdw' found
  /bin/sh: 1: test: -lt: unexpected operator

After:

  1. libdw is not installed:

  $ pkg-config --modversion libdw
  Package libdw was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libdw.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libdw' found
  $ make LDFLAGS=-static -j16
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>
  Package libdw was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libdw.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libdw' found
  Makefile.config:473: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR

  2. libdw version is lower than 0.177

  $ pkg-config --modversion libdw
  0.176
  $ make LDFLAGS=-static -j16
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>

  Auto-detecting system features:
  ...                                   dwarf: [ on  ]
  <SNIP>
    INSTALL libsubcmd_headers
    INSTALL libapi_headers
    INSTALL libperf_headers
    INSTALL libsymbol_headers
    INSTALL libbpf_headers
    LINK    perf

  3. libdw version is higher than 0.177

  $ pkg-config --modversion libdw
  0.186
  $ make LDFLAGS=-static -j16
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>

  Auto-detecting system features:
  ...                                   dwarf: [ on  ]
  <SNIP>
    CC      util/bpf-utils.o
    CC      util/pfm.o
    LD      util/perf-util-in.o
    LD      perf-util-in.o
    AR      libperf-util.a
    LINK    perf

Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 12796808f07a..a0167244b2f7 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -172,7 +172,7 @@ DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
   DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
-  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
   LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fa679db61f62..b452794c763a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -154,7 +154,7 @@ DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
   DWARFLIBS += -lelf -ldl -lz -llzma -lbz2 -lzstd
 
-  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
   LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
 
-- 
2.25.1

