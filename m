Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF11CF8B
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709749; cv=none; b=E2zeQhJS9OjcKn9WDhNrYr5/zv9WE+wUkXLMHon2yM2nozFnX+4bgPf7by0RHLM5BudzRniVPdpCSdpkvvjI1WfKsSjAd68v08kEZvsksqhFzHCZ8f1rJizftIz11VG/6GpZngTvTIcYgGIVosXd3iAt+317IEBcbHYT7KurV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709749; c=relaxed/simple;
	bh=PjKZwYz/qw8iWT80kCLlkaaJkclWhXR9GCyS8HXcdZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jkm8aiF6mSLc1lrVGQltDjPNErGH4NVqztWmKm8h0bIdlM7PYrlnxYM4SMX7Sq8Z5jLdK6nO1c9Um0byPIN+Dy88Re7B1dPyXERUSDqs+teeuBU4+jIJJTA4zrz31gICF1KKCKH/vtjoUU9bmqD+d2aWWFAiqiGDVFYTXN/kjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dhd/3g2+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dhd/3g2+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7193010d386so233005b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 18:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726709747; x=1727314547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRPR2z4bSKPgcYHClioZjkMZaKzgMP6y1ywJmn+vlyw=;
        b=Dhd/3g2+MgHW0brRUMZTY7JsZYZ/ZKkXEsf/E+3VLeSl939BGgNbgkFMhvf0MbrZzK
         EgPAeSnVkwPjD7uYD1KPXIDOzc50x2oiGzXOe6wbB+vDaOy62n7iN7xp8u9KMZ2L7ls4
         EeQBzzYIgsRgJEKMVjW6uFLsrozVBmGq0o63oNNUYhsBG32IcmE3QTctynbyMfz0c8Ti
         WlBVNkE5v6zhhPgwYWz/a29R6VrgLZ+5pZnASOehmKoLJ8ZRoW68g5eltKUehDn22rLy
         k384w30W1Icxj45p9mSARoQ5FLvLTUArd0GmKj5vFoABzwPk6Yuoz0o2XhNZJ1xkkz4j
         /nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726709747; x=1727314547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRPR2z4bSKPgcYHClioZjkMZaKzgMP6y1ywJmn+vlyw=;
        b=sCcoVytAqP5j8EHw+jzwP/myu32t5LJ5aDltqWmUotynMeBG6/uIM70eiHp8uljZLD
         tBqnqwM3+xGp9V1VJvugE2sNscn7Zgqu8a8FrBEQeCU282QaX/79g9OaV0nfo7BGdb2z
         tbbYevMeQbjeLpXZ8v3Js7RI9DWrFKDRWVV4cMSy9tXRo0EnBbi1D4BAh7FJ8GOms2bQ
         ABvgm+blAcJl9CGBw3MjmczzzyYHeYj1twOA8CePnPArEewp2Ww7Ers70JavCFmEiN7X
         Hm+YqNz+vyfkboJuwdQoW41l42g1blEZs4rQ1mtS/6cmdEW9+Y+BSSMsDIdD1GeunlIs
         ygeA==
X-Forwarded-Encrypted: i=1; AJvYcCXT45JYTZ2WTk3VlnF80/cw4tQxvI83psfdcusbPUD99/g0+mPewuEq7vBUuzT+7zt2fu+n1nIbq2tHn9rwBpGc@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQIM6QSPLQ1CdwBeXDXSoTfxjjh+db0Mtp+ZaikC6BTEkotKL
	sckdZP1rOGjfgm1ZoW6MdZwqCJne8kdAUjCbnG8qVX+umRVyUYhBTbq7mZO2Dz4=
X-Google-Smtp-Source: AGHT+IHJmMjgMpHs8cK/HKaUs5kUDu2r20vARZpe1WeIcoN+SfDr0aRr0YIJACU2NRUalrc6n6Fr5Q==
X-Received: by 2002:a05:6a00:2d17:b0:717:9483:5887 with SMTP id d2e1a72fcca58-71936a4b6a0mr29329476b3a.8.1726709746807;
        Wed, 18 Sep 2024 18:35:46 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc9ed9sm7282482b3a.209.2024.09.18.18.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 18:35:46 -0700 (PDT)
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
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Cc: yangjihong@bytedance.com
Subject: [PATCH RESEND v3 2/3] perf: build: Fix build feature-dwarf_getlocations fail for old libdw
Date: Thu, 19 Sep 2024 09:35:12 +0800
Message-Id: <20240919013513.118527-3-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919013513.118527-1-yangjihong@bytedance.com>
References: <20240919013513.118527-1-yangjihong@bytedance.com>
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
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/build/feature/Makefile | 3 +++
 tools/perf/Makefile.config   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 6f1c961f0ede..1658596188bf 100644
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
index 0049fd41cf57..4ddb27a48eed 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -147,7 +147,7 @@ ifdef LIBDW_DIR
 endif
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2 -lzstd
+  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
@@ -158,6 +158,9 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
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

