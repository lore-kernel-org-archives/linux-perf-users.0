Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A11C4601
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944899; cv=none; b=Y/1bNPddeIEszFv+4GLgFphaXadyesVU98Ni0lpJWf0OWJbMHGKAP0lmjOLkWqg46ZAil3JVVSGpUhlcxw7mqjXW9A3uBim7DNAnaKnsiI3Nptg2RF8Yx7Pfu8nZ7EDJCCItvEbItfikYMRxGcxggrSuvq8AGLW32WHAJGulttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944899; c=relaxed/simple;
	bh=lLK53uiQC3bZkEy2L61h0TC52VfEBeHo0ujP19/cMQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tf/2NQKTFr3qBlwmqRyubSx7SSiWbDFrTIUD2WHLIA4xsJsDa0h1odmctok0/KeVkohIhSg3jXF7vQ/za0YnusLmiB8ezy7fJY2txHEsx4BzQEki5q+SgyqcJpsLuA5tzC7CNbPsDTotIHcbnK6Dr0Kv7DKbv6Nb9bxBTBMXRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ekw7O+Bk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ekw7O+Bk"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70eae5896bcso382141b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722944897; x=1723549697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szK4YRuHQJi5DajMaeZdCXTgp1QcycA8fBZf8lAoRyI=;
        b=Ekw7O+BktCuwZYCq4vKqDcl6JBeXVbY3JXFhbfuG0sOVzWr1ldnFl6QiATgiOVWKkb
         SQr8I7hroGItrlcwoIHq+0pQcjJaCLcKdy97LL8RubBYZ04krJByhikEkLS2W0Fj6Bco
         mGW73wXnO3B7th/Q/H2aYLudvbelNLlL2P4AfpI2jWPOP9u/mGBCKyHR1+tRfto0l97D
         cn3kY/oiZoRvZWAvs4HiZqC0H+fWa3kT4ZUUG+BWGi0lW49ycBBMiAzQiiMgsVo5BY7n
         yr1T2PaxfkKUNr003+sgfj5cqqUF/F7KhZkHjn3y+rXRjC9fk3/8mhWxLwHznGOCFdeQ
         JUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944897; x=1723549697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szK4YRuHQJi5DajMaeZdCXTgp1QcycA8fBZf8lAoRyI=;
        b=FIEEJruxCNXjjq3+w0tyzipUe08LmpGcCPdwVp+ThGWQkwWsQ+PqklwIZ16W9nZMYe
         3RZ3EGTBGBvrEYsm8eS4TXy8m70XK5gCWzdZ539kPw0sIMGyhJGOC9VX+6s7EQwLbbpq
         /nEfD+VWLCzTyqKcs1udLnkut2M2jQnpsTR5MDwuPs6XSco8rJ0GJTyGyag8k0dQQJwS
         jLuImW31Cv/FSihWpTN93FKM8oypJXb8P6+yU8Wl45bzw6O11nNk6zS/fU2HVLd049T6
         5NH2WoxbMKWnn3ee0PkXyCzXmst4DBQbq9shthTKKnxsBKvro5R1kGeIT4jgtjUaCeTh
         7gPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwIxN9nKeWRF4/ejorsS0UhHjC9mxtOXWAy11G455fROJkpgonhaOsG5RO8GwGtrPWz2BQloS6b3sFlQB3eVYvTtDuFeGBW//PZG5+Z7fwdA==
X-Gm-Message-State: AOJu0Yx0e/65fqEdQb1KXBVCLqLGrLBKfP1CsfmFWA9Gi8wi7bOJpjW0
	wK+Yc9mqGCj42OXnOFi+DYXosCB4M2j3Nt9zxbxzaxqd69oV+3Hco3gnoSRfaNs=
X-Google-Smtp-Source: AGHT+IFdZ7eYHp2tmqJYcz5HMBgb90qZGuZ8bq6DyGDAHkGFzGLnob6VV7mkGgw4Wou6vWzfbqVFtQ==
X-Received: by 2002:a05:6a20:7faa:b0:1c3:b47d:d53f with SMTP id adf61e73a8af0-1c6995a1f7emr19507362637.25.1722944896989;
        Tue, 06 Aug 2024 04:48:16 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec43944sm6831705b3a.75.2024.08.06.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:48:16 -0700 (PDT)
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 1/3] perf: build: Fix static compilation error when libdw is not installed
Date: Tue,  6 Aug 2024 19:47:59 +0800
Message-Id: <20240806114801.1652417-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806114801.1652417-1-yangjihong@bytedance.com>
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
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
index 12796808f07a..b18513ec4da6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -178,7 +178,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
-  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
+  ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
     DWARFLIBS += -lebl
   endif
 endif
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fa679db61f62..7d1003d2efb2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -160,7 +160,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
-  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
+  ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
     DWARFLIBS += -lebl
   endif
 endif
-- 
2.25.1

