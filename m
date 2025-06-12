Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1052D8788
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757794; cv=none; b=dPQUbUdkZFJaIdlO1KEVycZd2st8agJnElpYG3T9hldvdPwj+/FVEo6uXPP5MLHcDtI4e2ATd205ZTatFQc5YWG2NlXe8c5LUAmJ8hFE78LqYvY0TesPQf+EC8oI4+yZXJr0sQI33IboGD5FKTC7CNU/qNQusfNBu4vIFe9goB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757794; c=relaxed/simple;
	bh=zMY1NElYNZzt1bGCpQPOES94FzbCwXlf9lyBYpGO4Zs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dph+dltAvt21pGVFb//w9to7HKdLIktuIkzG+KXSXjg7AgL0O+APYUa5yS4OH3SiK3mNJDWC8iVecx8oowHTsKhVNnkP0Q6A+JUmZ1msjLL1hWEFMDRqM1g7shWhtz+SCxN0Zcf+L1dzA+Zq8umP8xMBDEzaAZEQK74vRYKdrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pf/YFNdf; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pf/YFNdf"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2d9ea524aa6so1125710fac.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749757791; x=1750362591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnqUhIyewIO5q6Zf7WHC0dqAJTno3LzWwwCSTFeopTU=;
        b=pf/YFNdf2TFfW8W83c3aYcwSTXRNJDv3IiR1eZN/O2v4IhP+nduHsTIIyYMUuRTEBQ
         0IHtnZIGAAKux6EsiAibo7Cx7EYjgY2hW19ApTWr9sn1hmhtenpfCoWbT+rXVAsheCU7
         7GfvmlwA/SfzF5b51VFFHPn1E33Cq+K6UQSS6ucoIwhqhuz5VL76DQCRyVg6/WwZYT8Q
         dX3fYRTqPHiLyGcqugEZmhsexeL6pDyeWaliA/BnGop2PbFqgA26kFnVWOi54n/YRWDt
         8BzJe4GVKAyx5wHSnsLuCM/VoxDOfageIEzL1R8Zg4lyIxsitBO9cUUbTYxbPZIDVnsb
         XtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757791; x=1750362591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnqUhIyewIO5q6Zf7WHC0dqAJTno3LzWwwCSTFeopTU=;
        b=oBOk3cUREaDZ95NvlYk/7jkcCXH9cThI2TYTOUueZZ65mxgvC4cqjmT9oe/LFhDxeW
         XVH8+Cw8WkOVn976MWxNqVXbRCM/H6nuy4vgC53kXOVPl0JPNSiYnjJ9jVCvKQHNPwDd
         RruyzcanIhD9fpZ0VOuZZzebTvI/ZVZMGkvRetBkPR2thPTjmSlsc77ik7EkNA5RybRC
         /uXMMGFZ+HEHWJSimmB6hqt6NPPEpxLfRxF+R7UOcyiqFm9pUhv9ONBAdNEMkdDCmttx
         fRRfaLKOfV+Py9J70L4e973AbWL/gudVmyw7fAkcHc2K2SMGuTQDrwVjS3zZMCZrCQ+q
         6mjw==
X-Forwarded-Encrypted: i=1; AJvYcCUvmg29CLnPcQ5BHpRFlaMnfJAWvIInOVN/5VsKUKNqto9M+XKr6TtMMJS+zs6CY+6nDVsjcjMXW4ELwG8acSOs@vger.kernel.org
X-Gm-Message-State: AOJu0YwAA+1o/APi85/O6tED5r8AlqvHVpVTDo+qiJoT8Cxk3J4W60//
	CffGZX4iX5wNCltOHMXx/UGOi/3/m8y2S8L4u/JHWr//1oyF2bJR9nAWlvkSj+fpTOeMFcX1Ksp
	FOFtLcPz2+6ry2Xxab3y1bA==
X-Google-Smtp-Source: AGHT+IFNTXR/9UID8W6zRYCP3OwhC3x1U++y9rRlwJYFwQhSIGl+YEKkxpm2xUoLbRLXAHqqMRE3zncdhPzwhCzN
X-Received: from oabqw11.prod.google.com ([2002:a05:6870:6f0b:b0:2d9:841d:6155])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:4002:b0:2b8:e4b9:47a3 with SMTP id 586e51a60fabf-2ead509b590mr228640fac.22.1749757791440;
 Thu, 12 Jun 2025 12:49:51 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:49:39 -0700
In-Reply-To: <20250612194939.162730-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612194939.162730-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612194939.162730-6-blakejones@google.com>
Subject: [PATCH v4 5/5] perf: add test for PERF_RECORD_BPF_METADATA collection
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
2.50.0.rc1.591.g9c95f17f64-goog

