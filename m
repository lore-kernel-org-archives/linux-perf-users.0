Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B23F9EC
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000843; cv=none; b=DNWsfdkcUidaooqbAh0BFU6YFAyzGGyzUQ2NqecBZaugA7JwDAd3X5dLPDKkuTQQEFp9y6PDXa3Rvd8J3DvYSX1zdhp0/v+eqTFwtsrie6XERQ70sW4fU5/ndhT8ACDmJzStCLRi1302cC1d+EyZyW54ue2YLaAiC4pARbpnf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000843; c=relaxed/simple;
	bh=rINF0/w2RXu3LgEvP3KLdZjJJFVokCexX4VhnWu47v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lp/R2p206FAz0770tCj7jsUDBeka8SOvtIIKNKcjp/mYskchiqgjUfa09+pbLlbduNqtOPGxPiGfqZwc4ztwCLMvT0GcO/FYe0JntninTCXp8Spl/i0UE5m7NGs11uDszshafgUO2vtm/12orzEkrzF2Hbi9mQVLJDPF9xTv3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aY1KOsyh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aY1KOsyh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc5549788eso12275245ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 20:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000842; x=1723605642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsStSsh4YnwHHUY0AwViJ/lLTrst77QUsVxz4gNzJ10=;
        b=aY1KOsyhamv11j/mEyRKbD95Edpn35TY3oQxtUejPa4R0RPcfC5xCxRvpgvC6wQIn4
         Cvtosp7mcTcufau0Pswwg8qCvdtSBjV92uj/MM3/P0kQo2iNBIBuDUm7TrKDiCrrX9lC
         8Py+r7gR6Vd9so7TUUKsc84PvwCvLJKoJS1O1VoBLL0wNnWeKFkVOy18rgkegfCGgoEu
         B4qLKEXgWScZnaz46DoQoTSHaAd//YrTTJVkDF54JfxbzW0Wd7PJWJkAXgtI5WytUDZ3
         ozPBw47zDPvksovUIHTfMtkO5FPGQ1Y8cCXEjIbWggfZEq77CbLS/jSiXSctrlck7PAe
         0FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000842; x=1723605642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsStSsh4YnwHHUY0AwViJ/lLTrst77QUsVxz4gNzJ10=;
        b=XPr1nl5gDB70qRN3qcTkTs/+SQvycNQrPzUvmsEWovZ8KLtYuVg1RdqdZvAeirmnty
         M51+OqEcCIfjcJ9ayoGqmW2osPkEqK7rItVzbU6+qh7r5XqW8fzgYe9xBoyF72Slh/0O
         8WOuBAHzBnDW2M4RlP54BYTkqasxzbUoYPyD9J85TTKjjPPLkthjJsr81VEjNC3qOn+9
         aS0vbzmnTDsoTyWk5GtDA8EdHrHmv/hItcAPobSDl6/lZJQeZ4sYVV/WGzlgnzwSb2Ji
         wuHKl94McI/44SCB0nlIPTea4DPkZtBxAoEUsioXkQhEcOopSejhTonm1cJMl9LARuGf
         9XwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV09HKo01r2NO6NkFcqqjyu3kc567b/rkRUZOYMahFi5mwXwEuBbFGhkR1u3dvH5WM/ovOvGY801hsG3/WgLUFytIF+rb+0rbZGCl/YeupUYQ==
X-Gm-Message-State: AOJu0Yy9EGiLLmpnUZXq/cqVw8pWIfCLp6EwpAnWXF9oIFWGXF5x/AvO
	xQUvS3rDAgsywausryhDFIRL0wYuCJF4M0K64wjc7u/tgRfkZ0LfkH7wEfSKd+Q=
X-Google-Smtp-Source: AGHT+IHBqzFOE4mX1tmXArkN6Z2508Y+TjWmx9lFGGyEhPZzEOt6Yb5xJ6MkSbfEAn31BUtta/3b4g==
X-Received: by 2002:a17:902:ceca:b0:1fd:abd4:ed5b with SMTP id d9443c01a7336-1ff5735bcf9mr233515825ad.39.1723000841848;
        Tue, 06 Aug 2024 20:20:41 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19ebasm95116175ad.23.2024.08.06.20.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 20:20:41 -0700 (PDT)
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
Subject: [PATCH v3 2/3] perf: build: Fix build feature-dwarf_getlocations fail for old libdw
Date: Wed,  7 Aug 2024 11:20:18 +0800
Message-Id: <20240807032019.1828674-3-yangjihong@bytedance.com>
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

For libdw versions below 0.177, need to link libdl.a in addition to
libbebl.a during static compilation, otherwise feature-dwarf_getlocations
compilation will fail.

Before:

  $ make LDFLAGS=-static
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>
  Makefile.config:483: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
  <SNIP>

  $ cat ../build/feature/test-dwarf_getlocations.make.output
  /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libebl.a(eblclosebackend.o): in function `ebl_closebackend':
  (.text+0x20): undefined reference to `dlclose'
  collect2: error: ld returned 1 exit status

After:

  $ make LDFLAGS=-static
  <SNIP>
    Auto-detecting system features:
  ...                                   dwarf: [ on  ]
  <SNIP>

    $ ./perf probe
   Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
      or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
      or: perf probe [<options>] --del '[GROUP:]EVENT' ...
      or: perf probe --list [GROUP:]EVENT ...
  <SNIP>

Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/build/feature/Makefile | 3 +++
 tools/perf/Makefile.config   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index a0167244b2f7..ead476b373f6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -181,6 +181,9 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
     DWARFLIBS += -lebl
   endif
+
+  # Must put -ldl after -lebl for dependency
+  DWARFLIBS += -ldl
 endif
 
 $(OUTPUT)test-dwarf.bin:
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b452794c763a..9fccdff682af 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -152,7 +152,7 @@ ifdef LIBDW_DIR
 endif
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2 -lzstd
+  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
@@ -163,6 +163,9 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
     DWARFLIBS += -lebl
   endif
+
+  # Must put -ldl after -lebl for dependency
+  DWARFLIBS += -ldl
 endif
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-- 
2.25.1

