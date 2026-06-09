Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E863C061C
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982295; cv=none; b=C3GhmLifYHWXV/+U4P8byipnZKSwQ4euMheVu3AwwUvnr67lKp9VmoUSWwM0Qu923YLW38T3qZVMfQNum0oUkOe8yqZFdgBcbiGmdFJv5C2t9msggYlQqWQfVLxHL+ZrIXcA8WP34QNkO4zLSa9G53Fwgg/YDIv8o1fefvDwdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982295; c=relaxed/simple;
	bh=3HwgXxoXLEUFIhqsCOsSHquVS2zHKZEHOuZTZeRkaJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=L8OYHOvq5t845mB2kr2Pfo5k4rESnkfFWREA1ce6mqTCtyOicRKmk+hnQz8osPJU5Y0qZiBWIZIflO0XOFFPR5nDoe1YAAduM7UpH+gk4SUMXOsfnR5vcit+1vzYPvGq92nthEZwjq0MSFrFGq43x+QOp6EQrdRVIYshlHegUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=unN6XFbI; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="unN6XFbI"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e4636205so12776540eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 22:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780982293; x=1781587093; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g2PzQf8zx2KeYH6w4jPJIluc/mfGGMGRRUmvvBUxyI=;
        b=unN6XFbIsJI5SXufVNGtuFYn5UrXZeeyhSq1L542WrxDRckmzZupvOLXgKY8jxvBZB
         p13xSr8HaTjD+WY26KYpUK4eWcYVY40Sj0y2kBV+snrrwDJaqTKiYWGrPO3zwzAkO+RM
         RVVqw6Wqg7zcOMLkmvnfVp9jyyqvKm41YJmN6ib5biwIlPPPAkPqOR8T2mLq012+SoVx
         biETJOSg9qQQHuuQ+TUV31tYeqvIL9N+5+Nuuino10dJgrgaluMCq9HqeQ3fgOHcQ1yu
         DiMojhItNTqqb/DebiZOgdbe6+ozGWm+xAsbosRAR8AD1rnOX4Zb00Rzsm20aYpADQsu
         /dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982293; x=1781587093;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9g2PzQf8zx2KeYH6w4jPJIluc/mfGGMGRRUmvvBUxyI=;
        b=iTECI2/WrQ5eO1oacnzNMeJp0JiQGHR3QSQZbQkVS2KvnYBbbCZDvNwhgLrWu5mtB9
         JY58Q1h0GZ+HGMkR0RJ8DTbHh863/gqAUK2GMHlokNjixad6bjUmqC9YLEpNib05Ves2
         HcgCDZlhebMhN6ecqi29mnjkxJpgJI/D87m3dXHVXBDymJutLvStREivbNXx1q7jD1Gg
         94uP1ZSJsYInHQNraJpa5NfTsD+dmuPa4trWjVgCneLHGt2zOxHJmvo7/w68iT32Y9Ub
         02uOuehWondJgRIBuOHqf62Kwk/2YMuVwUXHbu6YCLaOWp65kk6jrZDFzqjKIBUtYM8b
         weCw==
X-Forwarded-Encrypted: i=1; AFNElJ/HNALIu7Z+hH1KqI9MoURZhcgJ5J6EWddy09PBvHQNYPOeqQxQsauVcC+c6QGB1r3ozrwIQY0M+OBO9xu3hf0z@vger.kernel.org
X-Gm-Message-State: AOJu0YymIa6hT2gC1py29ZPE1v4R5Z/+iTdweHFVGFp0ETV15vTXWPDc
	ARiXO7K/3bY8OxzhgbubgKIkXF3osHpiC1WxZPBjOimkgOVUrXLSokgLtc4CkSHCJnOoesSFF0U
	Hy0psDpoqcQ==
X-Received: from dybmi6.prod.google.com ([2002:a05:7301:f86:b0:304:ee5b:e1a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80c8:b0:307:37a4:15dd
 with SMTP id 5a478bee46e88-3077b26f364mr11132022eec.26.1780982293157; Mon, 08
 Jun 2026 22:18:13 -0700 (PDT)
Date: Mon,  8 Jun 2026 22:17:54 -0700
In-Reply-To: <20260609051759.405027-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609051759.405027-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609051759.405027-3-irogers@google.com>
Subject: [PATCH v1 2/7] perf build: Add build support and capability for
 elfutils libasm
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

Configure perf build system to utilize the libasm feature check
(supporting both static and dynamic builds) and export the config flags.
Add "libasm" capability detection to perf check.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 23 +++++++++++++++++++++++
 tools/perf/builtin-check.c |  1 +
 2 files changed, 24 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6e7b15fab2ec..8b6c32392d61 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -199,6 +199,13 @@ endif
 FEATURE_CHECK_CFLAGS-libcapstone := $(LIBCAPSTONE_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libcapstone := $(LIBCAPSTONE_LDFLAGS) -lcapstone
 
+ifdef LIBASM_DIR
+  LIBASM_CFLAGS  := -I$(LIBASM_DIR)/include
+  LIBASM_LDFLAGS := -L$(LIBASM_DIR)/lib
+endif
+FEATURE_CHECK_CFLAGS-libasm := $(LIBASM_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libasm := $(LIBASM_LDFLAGS) -lasm -ldw -lelf
+
 ifdef LIBZSTD_DIR
   LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
   LIBZSTD_LDFLAGS := -L$(LIBZSTD_DIR)/lib
@@ -1060,6 +1067,22 @@ ifndef NO_CAPSTONE
   endif
 endif
 
+ifndef NO_LIBASM
+  $(call feature_check,libasm)
+  ifeq ($(feature-libasm), 1)
+    CFLAGS += -DHAVE_LIBASM_SUPPORT $(LIBASM_CFLAGS)
+    ifdef LIBASM_DLOPEN
+      CFLAGS += -DLIBASM_DLOPEN
+    else
+      LDFLAGS += $(LIBASM_LDFLAGS)
+      EXTLIBS += -lasm -ldw -lelf
+    endif
+    $(call detected,CONFIG_LIBASM)
+  else
+    msg := $(warning No libasm found, disables disasm engine support for 'perf script', please install elfutils-devel/elfutils-libelf-devel);
+  endif
+endif
+
 ifdef EXTRA_TESTS
     $(call detected,CONFIG_EXTRA_TESTS)
     CFLAGS += -DHAVE_EXTRA_TESTS
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 60437650c50f..d2ffea4d9b8b 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -46,6 +46,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("babeltrace2-ctf-writer", HAVE_BABELTRACE2_CTF_WRITER_SUPPORT),
 	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
+	FEATURE_STATUS("libasm", HAVE_LIBASM_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
 	FEATURE_STATUS("libLLVM", HAVE_LIBLLVM_SUPPORT),
-- 
2.54.0.1064.gd145956f57-goog

