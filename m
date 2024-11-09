Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3A148832
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133115; cv=none; b=HVrTfQb5B5RfICjhZzCqLEyXZGgFdjwhV1qFih9wSrvv50HG4WsojB1YyAhbqwimGM2tpe8JRWzokiIq2tQnFyX8XYG0/xO6AKYmCTSbj2OKkX+YSpWgJsOTgrqlZ2/hG+V4L7LPy/gQxYrvkSQEpPd4hUjHlCWY5b0xqrvChW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133115; c=relaxed/simple;
	bh=ME2AZmwamAaxLUxl/n4fQb9W7X1LdXUNBLV0PhT15RU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=rCQrNAd3Ibg9a2QiTeO6q4uJ1B0znTKI+YUdId2T9GvIqBaTax9vXIrofbLcaXuWZyw9jmpRo5LhQp2Lutm4oWU2E124e5rJGlK9OkAOse6EatZ3HKZPQFxUD9vbR4xH7curY3K/iGGiWETYzUZXwK10U8dbE3/178zMdaKoatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dnXeT+VR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnXeT+VR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eaa08a6fdbso52460697b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133113; x=1731737913; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vxvGl5vYfQ4Qd5F6bBw1bO/cdktsUuMIT15kf42GtQ=;
        b=dnXeT+VRbC6RHvaW9eDa2sDhYBaYT5q7DK7ICpuof/Obqwn14xS6mzq2Crn+gkLp+9
         29EgwgsMjlIdJnnpKn5lenP9C4nP7UfIJCY3UKUdAPF7yU4BBtqQ9LQar+3RwPZXlOCM
         wGjGpZBOkn+1eI/2wipaV6iGibD77eSeyE4tvMLOn/Bp10ewVkPDA5ck+AYwfLjYOlz+
         3e6eYBqm8T5eTR78StVtG6Prjw1k4lnuHfaVs33SLRd9h1Ws7BJN4BLht+VwW0A3SJvV
         BjxSV1gz2lpbUsNLTapkFYIdyI34uk/YALYHQ+CUc6ciDIUFOcvV9qgVXl7+zNFWGSis
         93gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133113; x=1731737913;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vxvGl5vYfQ4Qd5F6bBw1bO/cdktsUuMIT15kf42GtQ=;
        b=MlDzon2ObrySey8sALShqY/0e/lm0xpeXQi6uCPXVBQCGiLATXfViqRhWh2ycvczz6
         qQfMpbqnn5dViHHAun1mgZgf9NeitkL/LaQ//Q3YphcKWwX+RfrTXW2tsSzcEfnfUQ53
         Y0ujxGrp8uHblmZM32C8uVOPYLdc3H2SlzLl77e7bOmagpOijYjDWC42D37uHxHso1Lv
         Ry0YlxTmHCgWOxGY4H+Xy1M/dZHCl265S6+RFb8PqVJpZzoSz1ZLRoo3r43D81fYop9/
         dW3yASiy3sE/CbqG7IVPovjFA3ci7LeUA5Sb/cFi9P75Kn4e1pYELfc0DIH++q0MBVBh
         aYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV9i6hNKHVT38Ev+LKRx42nt6POZ+KJhd4o7+DnGcRJ939leKdikQerYg+JnBPp9KSdt/oMX3l5NAJmRstdCD+@vger.kernel.org
X-Gm-Message-State: AOJu0YwStM6FNq7HYnUXofPPcL5qq+LonxC3SRd3GC3jUPqo1HKlus8a
	zEcRG1HWdxOyVhefAWQTLS64fjAd7dg5c/BGbrGBXE5re4MQvqsr5i3+mkVnLcw5nDrXTFILr+n
	FnmBf0w==
X-Google-Smtp-Source: AGHT+IEfG4TB30bVTiocdZ7kQXgcw5C6ysvWB7xUMUoxLuqo3Co0e5PtXrMrwI+6ndfy0XGF1pxJGm+cp/bF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a0d:ed43:0:b0:6ea:7c90:41f2 with SMTP id
 00721157ae682-6eaddfbb341mr214977b3.6.1731133113036; Fri, 08 Nov 2024
 22:18:33 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:52 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 05/22] perf kvm: Move functions used in util out of builtin
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The util library code is used by the python module but doesn't have
access to the builtin files. Make a util/kvm-stat.c to match the
kvm-stat.h file that declares the functions and move the functions
there.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c   | 61 ---------------------------------
 tools/perf/util/Build      |  1 +
 tools/perf/util/kvm-stat.c | 70 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/kvm-stat.h |  3 ++
 tools/perf/util/python.c   | 32 -----------------
 5 files changed, 74 insertions(+), 93 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat.c

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 099ce3ebf67c..e50cd04e3725 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -615,67 +615,6 @@ static const char *get_filename_for_perf_kvm(void)
 
 #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 
-void exit_event_get_key(struct evsel *evsel,
-			struct perf_sample *sample,
-			struct event_key *key)
-{
-	key->info = 0;
-	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
-}
-
-bool kvm_exit_event(struct evsel *evsel)
-{
-	return evsel__name_is(evsel, kvm_exit_trace);
-}
-
-bool exit_event_begin(struct evsel *evsel,
-		      struct perf_sample *sample, struct event_key *key)
-{
-	if (kvm_exit_event(evsel)) {
-		exit_event_get_key(evsel, sample, key);
-		return true;
-	}
-
-	return false;
-}
-
-bool kvm_entry_event(struct evsel *evsel)
-{
-	return evsel__name_is(evsel, kvm_entry_trace);
-}
-
-bool exit_event_end(struct evsel *evsel,
-		    struct perf_sample *sample __maybe_unused,
-		    struct event_key *key __maybe_unused)
-{
-	return kvm_entry_event(evsel);
-}
-
-static const char *get_exit_reason(struct perf_kvm_stat *kvm,
-				   struct exit_reasons_table *tbl,
-				   u64 exit_code)
-{
-	while (tbl->reason != NULL) {
-		if (tbl->exit_code == exit_code)
-			return tbl->reason;
-		tbl++;
-	}
-
-	pr_err("unknown kvm exit code:%lld on %s\n",
-		(unsigned long long)exit_code, kvm->exit_reasons_isa);
-	return "UNKNOWN";
-}
-
-void exit_event_decode_key(struct perf_kvm_stat *kvm,
-			   struct event_key *key,
-			   char *decode)
-{
-	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
-						  key->key);
-
-	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
-}
-
 static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
 {
 	struct kvm_reg_events_ops *events_ops = kvm_reg_events_ops;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1eedead5f2f2..650974413849 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -120,6 +120,7 @@ perf-util-y += spark.o
 perf-util-y += topdown.o
 perf-util-y += iostat.o
 perf-util-y += stream.o
+perf-util-y += kvm-stat.o
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
new file mode 100644
index 000000000000..38ace736db5c
--- /dev/null
+++ b/tools/perf/util/kvm-stat.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
+#include "evsel.h"
+#include "kvm-stat.h"
+
+#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+
+bool kvm_exit_event(struct evsel *evsel)
+{
+	return evsel__name_is(evsel, kvm_exit_trace);
+}
+
+void exit_event_get_key(struct evsel *evsel,
+			struct perf_sample *sample,
+			struct event_key *key)
+{
+	key->info = 0;
+	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
+}
+
+
+bool exit_event_begin(struct evsel *evsel,
+		      struct perf_sample *sample, struct event_key *key)
+{
+	if (kvm_exit_event(evsel)) {
+		exit_event_get_key(evsel, sample, key);
+		return true;
+	}
+
+	return false;
+}
+
+bool kvm_entry_event(struct evsel *evsel)
+{
+	return evsel__name_is(evsel, kvm_entry_trace);
+}
+
+bool exit_event_end(struct evsel *evsel,
+		    struct perf_sample *sample __maybe_unused,
+		    struct event_key *key __maybe_unused)
+{
+	return kvm_entry_event(evsel);
+}
+
+static const char *get_exit_reason(struct perf_kvm_stat *kvm,
+				   struct exit_reasons_table *tbl,
+				   u64 exit_code)
+{
+	while (tbl->reason != NULL) {
+		if (tbl->exit_code == exit_code)
+			return tbl->reason;
+		tbl++;
+	}
+
+	pr_err("unknown kvm exit code:%lld on %s\n",
+		(unsigned long long)exit_code, kvm->exit_reasons_isa);
+	return "UNKNOWN";
+}
+
+void exit_event_decode_key(struct perf_kvm_stat *kvm,
+			   struct event_key *key,
+			   char *decode)
+{
+	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
+						  key->key);
+
+	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
+}
+
+#endif
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 3e9ac754c3d1..4249542544bb 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -115,6 +115,8 @@ struct kvm_reg_events_ops {
 	struct kvm_events_ops *ops;
 };
 
+#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+
 void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
 			struct event_key *key);
@@ -127,6 +129,7 @@ bool exit_event_end(struct evsel *evsel,
 void exit_event_decode_key(struct perf_kvm_stat *kvm,
 			   struct event_key *key,
 			   char *decode);
+#endif
 
 bool kvm_exit_event(struct evsel *evsel);
 bool kvm_entry_event(struct evsel *evsel);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f82e8a968e24..94902652e371 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1307,38 +1307,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-#ifdef HAVE_KVM_STAT_SUPPORT
-bool kvm_entry_event(struct evsel *evsel __maybe_unused)
-{
-	return false;
-}
-
-bool kvm_exit_event(struct evsel *evsel __maybe_unused)
-{
-	return false;
-}
-
-bool exit_event_begin(struct evsel *evsel __maybe_unused,
-		      struct perf_sample *sample  __maybe_unused,
-		      struct event_key *key  __maybe_unused)
-{
-	return false;
-}
-
-bool exit_event_end(struct evsel *evsel __maybe_unused,
-		    struct perf_sample *sample __maybe_unused,
-		    struct event_key *key __maybe_unused)
-{
-	return false;
-}
-
-void exit_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
-			   struct event_key *key __maybe_unused,
-			   char *decode __maybe_unused)
-{
-}
-#endif // HAVE_KVM_STAT_SUPPORT
-
 int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
 		int num  __maybe_unused, int pathlen __maybe_unused)
 {
-- 
2.47.0.277.g8800431eea-goog

