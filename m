Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0827FD52
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166789; cv=none; b=Z3UuDplgF2CLBYdoAL1BtwHE7jenFz0hrla8ggoRHuzexAGBt3wTupxV7i4bNLpYTTOjkZnP6++HPXiO2GuqbJBqgemwZc/Lf6lW0i4LmaVQVFyRBolBkpjvbcfXI7F8wmWmat7tVXVWs6GRQp0Gs7axeblCBQB6BkYyRoa2lAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166789; c=relaxed/simple;
	bh=6rAHdPQAT/R5T3BqcinB8XCTK3Ooh2sndyFn1KuWLDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PFp5+rBixc+hzyQKQr8+VNlRh8Y3YRumP96hwNjsQdSOww6nnf64fMWgwG/ka5fF2xaVu5YHIer6XeHEvPl5IBvqPdM3guF1DkrAxAXEVSl7kk+nwdZqvRn5ZJaCL9xnJL1Bk2+oSVe1aJ+mUYh4fuEflOjMbPURuksu3S4a1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Im5jXGh5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Im5jXGh5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747d394f45fso1160719b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 16:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749166787; x=1749771587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ3W/Nb7ptq5pD3EWO6cOoPQgDhkUFl3I1Zen7d8SlU=;
        b=Im5jXGh5mYgmpoax7MGrvYQBDtrKH5MBYwdu4sJE6qfhobY0PsW8ML7y/wFrqJu5bo
         +3hpV/vwt2ypMkV9JRVAFFEsGTSV7/HnVO52Ke952JuOLrbMNCb19WBHgdlJ+LbOKQCI
         Bbu78uhaDIz75tYBBYqCeqUfxn7NGSy/DlzJyxdTuUzm7orUyJRbhVc8jN2E80ftCfRa
         0MIF4dESR2zEK+Sl6IJzWyxN6gE9uUfio1VtMIIh9RLMisESEE4GgUdRiHwKg+4iT1V6
         JP6SynE815yD/Bvy4xONmEV8A3opCaxeJX0OmE4cS3R+/CK+/GY08tBJwcBCdWzVR7lH
         esfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166787; x=1749771587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ3W/Nb7ptq5pD3EWO6cOoPQgDhkUFl3I1Zen7d8SlU=;
        b=lvJPMGfMsOyqeeTR0coxtIIdtsv2TdinHHqdho8XK0vwgtOLuYGQ7nOVBwkRez4rm0
         BiNruMHNsLZrPrY6ibWljrq1aNw01ID1oaQPZSet52ERoj5eq/PDaYQwcwvMds2tGZWF
         hnR4rZtTdsejo/+KTqfglVzbOWbdauFYf2VnB3wZHbRAwEG5fbVyfa1Px8C/K5DoT/kD
         FH6tQzH2n08vtQWJfXGQE4tQcbbf9RXRNSD5qMypqW+RC335qnz0sei9YrWiezrcrB/O
         rkQWknOb78dk00CYHwqy8suAo4UdX0XFp36s14Jc9Sa8NbmVeimOfWoF8NYsMa2Zv6Oc
         m8vA==
X-Forwarded-Encrypted: i=1; AJvYcCUozTrn5+RrMsD8x+Wf8tOw1udosGVi3mweY5GfP0S4ORQsB9UQ6/n3+M+35ene06UJ5BntLF2YlEAsR5mk2v7U@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQgPb/yxXQ//UCyHeyZdGqA003nZxBlI8Y3/lw6TE47VJSUoU
	iHy5jAkAv24OtyHgT5eDzs5HrDTf/O1mNFhM3Ummb2riW+KohLuw2nzbHQ/nUhflcuRJ9BRJz91
	SPQHDHrB3SByb6Ib9oQoKIw==
X-Google-Smtp-Source: AGHT+IFkwzICCuJKoG3Txs4Pq6B8e3LNe8LcJQkOsHb3DYNAAlEc1BVX4L6i630fVFk+wQLTy/GH043sJlsKauzy
X-Received: from pfbfc3.prod.google.com ([2002:a05:6a00:2e03:b0:747:bd3b:4b63])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:549d:b0:1f5:769a:a4be with SMTP id adf61e73a8af0-21ee263f9b4mr1776658637.36.1749166787399;
 Thu, 05 Jun 2025 16:39:47 -0700 (PDT)
Date: Thu,  5 Jun 2025 16:39:31 -0700
In-Reply-To: <20250605233934.1881839-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250605233934.1881839-2-blakejones@google.com>
Subject: [PATCH v2 1/4] perf: detect support for libbpf's emit_strings option
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

This creates a config option that detects libbpf's ability to display
character arrays as strings, which was just added to the BPF tree
(https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4).

To test this change, I built perf (from later in this patch set) with:

- static libbpf (default, using source from kernel tree)
- dynamic libbpf (LIBBPF_DYNAMIC=1 LIBBPF_INCLUDE=/usr/local/include)

For both the static and dynamic versions, I used headers with and without
the ".emit_strings" option.

I verified that of the four resulting binaries, the two with
".emit_strings" would successfully record BPF_METADATA events, and the two
without wouldn't.  All four binaries would successfully display
BPF_METADATA events, because the relevant bit of libbpf code is only used
during "perf record".

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/build/Makefile.feature              |  1 +
 tools/build/feature/Makefile              |  4 ++++
 tools/build/feature/test-libbpf-strings.c | 10 ++++++++++
 tools/perf/Documentation/perf-check.txt   |  1 +
 tools/perf/Makefile.config                | 12 ++++++++++++
 tools/perf/builtin-check.c                |  1 +
 6 files changed, 29 insertions(+)
 create mode 100644 tools/build/feature/test-libbpf-strings.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 57bd995ce6af..541ea3cc53e9 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -126,6 +126,7 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          clang                          \
          libbpf                         \
+         libbpf-strings                 \
          libbpf-btf__load_from_kernel_by_id \
          libbpf-bpf_prog_load           \
          libbpf-bpf_object__next_program \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b8b5fb183dd4..327bb501fd2b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -59,6 +59,7 @@ FILES=                                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
+         test-libbpf-strings.bin                \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
@@ -360,6 +361,9 @@ $(OUTPUT)test-libbpf-bpf_program__set_insns.bin:
 $(OUTPUT)test-libbpf-btf__raw_data.bin:
 	$(BUILD) -lbpf
 
+$(OUTPUT)test-libbpf-strings.bin:
+	$(BUILD)
+
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-libbpf-strings.c b/tools/build/feature/test-libbpf-strings.c
new file mode 100644
index 000000000000..83e6c45f5c85
--- /dev/null
+++ b/tools/build/feature/test-libbpf-strings.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bpf/btf.h>
+
+int main(void)
+{
+	struct btf_dump_type_data_opts opts;
+
+	opts.emit_strings = 0;
+	return opts.emit_strings;
+}
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index a764a4629220..799982d8d868 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -52,6 +52,7 @@ feature::
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
+                libbpf-strings          /  HAVE_LIBBPF_STRINGS_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
                 libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d1ea7bf44964..647ade45e4e5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -595,8 +595,20 @@ ifndef NO_LIBELF
           LIBBPF_STATIC := 1
           $(call detected,CONFIG_LIBBPF)
           CFLAGS += -DHAVE_LIBBPF_SUPPORT
+          ifneq ($(OUTPUT),)
+            LIBBPF_INCLUDE = $(abspath $(OUTPUT))/libbpf/include
+          else
+            LIBBPF_INCLUDE = $(CURDIR)/libbpf/include
+          endif
         endif
       endif
+
+      FEATURE_CHECK_CFLAGS-libbpf-strings="-I$(LIBBPF_INCLUDE)"
+      $(call feature_check,libbpf-strings)
+      ifeq ($(feature-libbpf-strings), 1)
+        $(call detected,CONFIG_LIBBPF_STRINGS)
+        CFLAGS += -DHAVE_LIBBPF_STRINGS_SUPPORT
+      endif
     endif
   endif # NO_LIBBPF
 endif # NO_LIBELF
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 9a509cb3bb9a..f4827f0ddb47 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -43,6 +43,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
+	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

