Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB24280331
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166798; cv=none; b=Zuk0YzGEprrPayPwYnUbDU2V/Wn448Yj3xJzPc3O3h9KKw4tq3qykT9cNhnkV04NcZkVjUF7wHpBdtA3Tbj2t+y8Xx6Lp9H729UuzoXbj+CfBIVpqqyiicoawGXQmrZO6SKh/w1AVfYnu3DImOe++Zod4ZDYYwOLDT1/Pt/fuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166798; c=relaxed/simple;
	bh=b5qIz6P3lrcv3sGS7KxAxKzdqooPdqfn8oztpbwmp10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f8Otugg3aPu+nDgt/LM+QZTbJspokVcDVQ/F9OyxQcj1ujUCmKNq0OsIg8vGOVnszNhkgBdjOm+044aBx9isuOEPsjRB7sdhSU+Sd/AVsc6qO9qrie/kqIMCGZayrR/RUtY19LWfOq8t5RIL/jdkJeJ8W0YA57ueZLviUNpdfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoYkv7G3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoYkv7G3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311fa374c2fso2585622a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749166794; x=1749771594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iFfeaMcLuzx3qT6HoU1lCQOc9APQy0cingwV7epWcY=;
        b=KoYkv7G3t2JacguDnQHkoLBhbfUedimSiSODTtF/fmj+UCDxcVKrXJwSz/RO+LAxDD
         SXjhZRz80la3GK/70l1ddjc2UexGjM+kYdQzg1R9gTmX0ite7NDD08t8gygHpreMHnW2
         ww92zqAxQK1Yj5DXxCo2mXzZ89SgOIFfgFrNVJvaeYb4DK3EA/bHxXaWTOb9+bhJFbhP
         skIRNYzTvXpqOmlQHtLuTr6ur1e8BGvvQCVZhrmmJKuY70/6EhdeayuN8If3Ts/waaTa
         BPF0NyCjURvxs7X7/EKAkUpGCXT+istdBqo7SijG+ThX/OC8HYN5LDyZWkWYvnNFqins
         NNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166794; x=1749771594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iFfeaMcLuzx3qT6HoU1lCQOc9APQy0cingwV7epWcY=;
        b=d/YMDEfoF9pPgqtlK5fOAfjSTEcjBk/o1u9UGWtzhEtX/b/FeP0Ul5lCyuWlLAU4wP
         zVyWy0hmF+l5eSOPx+loC6zsE92vDMGcKCbS8DTeOPsrySg/sYgi+CkRcEnC6c1PdtbK
         vMDwdrUzSvpybBFX/5P7jWtMO8UKcbKIau6/sw6rzJ4NyMRGtjtFQOOqQVD8nPf9bqTf
         yu8GKPfNrN7oJCpQlW7DUy4Bu/eg1cTbY+v0b45VbZ5IQ5vWaWyQ9+o9qheVLWfvbbHr
         hBwwGZMHs2Z8/vY43KTj8BR72bx8dHufgFlbxqNhKpBN9b1XXxnioTWQKSl3tAjdcF7Z
         3tTw==
X-Forwarded-Encrypted: i=1; AJvYcCWJN51sfC1oSYKKKSMIiVo+FSCjEe+4bzTK0jQ3ifdFJ0PCAhX5mzfEvUwVShJy0kyPnn7osGzdmq6YbpKkkAti@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mXJWozjka/KbwvuslNhAbg474QDs/hgX8HBU8cPatgT33+Fw
	yq3/y2FXd/zEL2e/xmTMxLEYIRjFTcREfIoFulgCv32iM/rUnlUro6Y9J8jUADZql3c/OVGIIww
	OlFnHoyWU/ADkWIcV+0gDgw==
X-Google-Smtp-Source: AGHT+IFUcFav0NjAszjunYAxed+zQO9SwfdaT5YNefYYg0tyYpUQXQps02dUQweyT2eKvQCmOpCRVw1JAQd50fP3
X-Received: from pjh7.prod.google.com ([2002:a17:90b:3f87:b0:311:4aa8:2179])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:38c3:b0:30e:ee4:3094 with SMTP id 98e67ed59e1d1-31346b04333mr1683541a91.1.1749166794276;
 Thu, 05 Jun 2025 16:39:54 -0700 (PDT)
Date: Thu,  5 Jun 2025 16:39:34 -0700
In-Reply-To: <20250605233934.1881839-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250605233934.1881839-5-blakejones@google.com>
Subject: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
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

This is an end-to-end test for the PERF_RECORD_BPF_METADATA support.
It adds a new "bpf_metadata_perf_version" variable to perf's BPF programs,
so that when they are loaded, there will be at least one BPF program with
some metadata to parse. The test invokes "perf record" in a way that loads
one of those BPF programs, and then sifts through the output to find its
BPF metadata.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/Makefile.perf                    |  3 +-
 tools/perf/tests/shell/test_bpf_metadata.sh | 76 +++++++++++++++++++++
 tools/perf/util/bpf_skel/perf_version.h     | 17 +++++
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/test_bpf_metadata.sh
 create mode 100644 tools/perf/util/bpf_skel/perf_version.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4c7031b01a7..4f292edeca5a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1250,8 +1250,9 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
 	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tests/shell/test_bpf_metadata.sh
new file mode 100755
index 000000000000..11df592fb661
--- /dev/null
+++ b/tools/perf/tests/shell/test_bpf_metadata.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# BPF metadata collection test.
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+	rm -f "${perfdata}"
+	rm -f "${perfdata}".old
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_bpf_metadata() {
+	echo "Checking BPF metadata collection"
+
+	if ! perf check -q feature libbpf-strings ; then
+		echo "Basic BPF metadata test [skipping - not supported]"
+		err=0
+		return
+	fi
+
+	# This is a basic invocation of perf record
+	# that invokes the perf_sample_filter BPF program.
+	if ! perf record -e task-clock --filter 'ip > 0' \
+			 -o "${perfdata}" sleep 1 2> /dev/null
+	then
+		echo "Basic BPF metadata test [Failed record]"
+		err=1
+		return
+	fi
+
+	# The BPF programs that ship with "perf" all have the following
+	# variable defined at compile time:
+	#
+	#   const char bpf_metadata_perf_version[] SEC(".rodata") = <...>;
+	#
+	# This invocation looks for a PERF_RECORD_BPF_METADATA event,
+	# and checks that its content contains the string given by
+	# "perf version".
+	VERS=$(perf version | awk '{print $NF}')
+	if ! perf script --show-bpf-events -i "${perfdata}" | awk '
+		/PERF_RECORD_BPF_METADATA.*perf_sample_filter/ {
+			header = 1;
+		}
+		/^ *entry/ {
+			if (header) { header = 0; entry = 1; }
+		}
+		$0 !~ /^ *entry/ {
+			entry = 0;
+		}
+		/perf_version/ {
+			if (entry) print $NF;
+		}
+	' | egrep "$VERS" > /dev/null
+	then
+		echo "Basic BPF metadata test [Failed invalid output]"
+		err=1
+		return
+	fi
+	echo "Basic BPF metadata test [Success]"
+}
+
+test_bpf_metadata
+
+cleanup
+exit $err
diff --git a/tools/perf/util/bpf_skel/perf_version.h b/tools/perf/util/bpf_skel/perf_version.h
new file mode 100644
index 000000000000..1ed5b2e59bf5
--- /dev/null
+++ b/tools/perf/util/bpf_skel/perf_version.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __PERF_VERSION_H__
+#define __PERF_VERSION_H__
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+/*
+ * This is used by tests/shell/record_bpf_metadata.sh
+ * to verify that BPF metadata generation works.
+ *
+ * PERF_VERSION is defined by a build rule at compile time.
+ */
+const char bpf_metadata_perf_version[] SEC(".rodata") = PERF_VERSION;
+
+#endif /* __PERF_VERSION_H__ */
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

