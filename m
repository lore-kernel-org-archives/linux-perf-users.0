Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB93DA5AF
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988867; cv=none; b=iohR0vv7X0nIey+ukMWDA8YX9p5r7OI3KEamagVodVSA60AbgwBaH8M/fv1306ihSv7E/Cz/eM9R8LOScx68ADSsBvpuEDjU5RmafCjzr4O4+XSxoP0R5kvFLDUfkxMOWh7IQs+YwcJeB52N3nEHN06YyDFdN27eflBnSruqlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988867; c=relaxed/simple;
	bh=7fw5E4HLrCJhOa1pawbP+lkS89pQgbeNBAZA0QnXx/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=O0kKdRO167d8ySY1onLLb4/CNVpqMdS6wupThinBGe/sFpcRf3IYyBVB++07cdAFdnjVe0NwwHxt3LXAQrsIncV4UnP0EX2hIvxLRcKNb0Hrvv2Ffpye+6iNUoGWmmqTe8v6ZZoBMaffGpI+Qcdggpg3IAGNWy9nqVuQ5Wn7Bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QYosvbLj; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QYosvbLj"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137fc6f8e9fso5444749c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988863; x=1781593663; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0maxxqhPW4HdueK2loC1JS3wtz9NDJQ5nnqIxKEVm7w=;
        b=QYosvbLjz8CEA/k3tkpzVAOcbny+gf5EEWJ0li34w8Am8aFMJLaprC3LymcIr1OQS3
         m9SKPxWESHC4HnHv2FjZb4rTWfeHsAdVYDHOrMOFKmHtVsL2n7p+wE67XqdJw9Xj6Arw
         yUZG6wRi5oejU5XIdgFMcpCN5RKO+sZFy5P6xEIdqJ+40grIFnBWzd+qqErRq/umPfvp
         rlIkc1jy87Cnw8BKSTC4dCezcxcPywvKddnd6t/WLDnunWqaKTpt9aXrMICZVuiQkNrF
         gqaAAj+XQLbQnBfwjFbe4T/mQVtaAvHLyaYHtOEPbBerI59KukmZqWKtKcS/aep0Oo5B
         xUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988863; x=1781593663;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0maxxqhPW4HdueK2loC1JS3wtz9NDJQ5nnqIxKEVm7w=;
        b=bkS6FtLaO6Au94A/KPE33gruxyMN+VOML5N0BM7bafHa3eqDlO8HLTJYeAlDmbFpaZ
         ieeienj1zI5Enkow65DFmWqp0qXcg+I/OLA4MFQRzusQMa1SAn0+Wg2UjX/HU26ro5EX
         rev6NsFydqIpGA6pLs07ECe/uRom3D82/vzQidD31h20u2tja2iG7z1PCKRcT3jQHe0/
         FO+RUpXzIOGUKOpcj+jIUGRjinpai6eSnZHJFoU8DhDu/RFloLh/OEtDSESaGzkzjXzD
         lVhK3sNUGi5Ra2VXp3KTSzV5NTnMcoi0uxcYdGn4pe+5QknGNW3toQ0I7gSEMZ3OlVE5
         03Ig==
X-Forwarded-Encrypted: i=1; AFNElJ+x36732zLDixsxjDOle/aJf60bge0Yhly9PCKsh08FRQdXtGvs1nxWiPp9f+gHfeLzMMlOUmfBeSmYp7Om0sDg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn44SAXLlpBjNV+IHRfak4VHpYgGAthXJrKikBgTHvmwcGJ77T
	QaHGZJ2LIIw/s/eZ/GFLtFviPXpbvhWX1IGK5/GunKW2MtYJ5/ytnF+FCZTtWBpvRy8no8WANtk
	iT6gYnIQj4w==
X-Received: from dlbsi13.prod.google.com ([2002:a05:7022:b88d:b0:137:f54a:5c7e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:603:b0:137:eceb:6f44
 with SMTP id a92af1059eb24-138066dff52mr9590779c88.22.1780988863049; Tue, 09
 Jun 2026 00:07:43 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:07:27 -0700
In-Reply-To: <20260609070732.545416-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070732.545416-3-irogers@google.com>
Subject: [PATCH v2 2/7] perf build: Add build support and capability for
 elfutils libasm
From: Ian Rogers <irogers@google.com>
To: Serhei Makarov <serhei@serhei.io>, mark@klomp.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
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
 tools/perf/Makefile.config | 22 ++++++++++++++++++++++
 tools/perf/builtin-check.c |  1 +
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6e7b15fab2ec..8527d20f498f 100644
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
@@ -432,6 +439,7 @@ ifeq ($(feature-file-handle), 1)
 endif
 
 ifdef NO_LIBELF
+  NO_LIBASM := 1
   NO_LIBDW := 1
   NO_LIBUNWIND := 1
   NO_LIBBPF := 1
@@ -1060,6 +1068,20 @@ ifndef NO_CAPSTONE
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

