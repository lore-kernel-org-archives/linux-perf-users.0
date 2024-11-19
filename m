Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123313B59A
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979044; cv=none; b=dmX2QmkpHSiSEAlIIn33OGqGImixTjFX0dfUTOJjSw4ipkLCJhV51RhiqsnZgzMrYouMv3g/z4eS0/qsoVVo547mWSVFHjJ86AfzwNlSD6wPqUHs8PheyPUiDbmXGjTH7dN4Deuu2clP4KyiBh179LqjsjAhCGstpqJ846+gJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979044; c=relaxed/simple;
	bh=a0x2GWPMzmDHCU///fMeR9OGwGDZuoq3My+P5rsc7LQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=W1QQ9QY41kpUpGwgIxN9KDyddIk67q9buZkG5YzQZ3wChNyHpt9xf9NaBFJOzG3RwAoog+OZPqikPQrGqcEHkqXUbEcRW5+0W+NpJyFnlUjBTwGf/9hQuaZ+mDfpnHIJDlx6GUyDyekVv//+JPcPyqiPnpjUO2r2ug2JFMG15EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsFnoFAs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsFnoFAs"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e388c4bd92bso3427917276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979042; x=1732583842; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DoPLEO76Qn6qjJVT4M/omIJSIRXBMHxrz0L3FzCobVI=;
        b=GsFnoFAsNG+ddJAcCdjx9F2AsOkhqmcJYahn1wS5LX/L8REb5SHomfEpYCfy80M5Om
         CbDK2YDz7+kPwUnHql9ci6XPI1stT/GadopZ0eJldKrM15tGU3ZWP/8g0bhUcjc1bQ7v
         LbIoVacNcvPnfv1UlctduoTIe/CUPiGORLIEtMr3ACvQCLCnYpZly9HE/mEhk7jwaav/
         C6P7Wf3+1bLWqkYIRqMlo0scsFIwGX59Ox1N7Lwtj0x7rz/oEZe57R6ek3GZspNunf+D
         Lse4+X7EDHtWUKNVL+Az/XKKKTdRPFjhKgpPOn45pVQZbUzrIIz6vO0OYt8jKx/kbgmS
         1AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979042; x=1732583842;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoPLEO76Qn6qjJVT4M/omIJSIRXBMHxrz0L3FzCobVI=;
        b=eMOHVEaLxTk/Qx05hQkUTXfaN/+VjYimWyMAV3I6h13RPohtZeI14vFTQAyyDPyVVX
         y4hpNWuwgpLtoJ+5xy2L0Tb24uMJXVLxYujS9Vo0Ekm1uMv2yZfZllYjHdrfJ3/S8N/i
         WLhRlIixd0GYCHu3qM8ElnyfBaa88QzVFMg9wg129hZgf1yoU9cjXcHF8Ts7zcYvf2Us
         x74X5THpZ+0AoRw+vysPu89zy6NeJKxzNsImSbkEuhMCE0x2/kDadgX3RdSjSRNvdsqN
         AesspsgOuRYkLF0THTCmkLKU/CLTQusMdYIhDVxO5A0DYWRupjVOMqFwC7TxdiFmwlsc
         m/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXWaV1U3fo56BQf/kr0S4/5updNkDGJ3Dk/rPxJkyubmGxifeMAz2M/0wnc53htaYQVvyigRZyjaDIoHJz/hiOd@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwrhZFBiBzJi06+agzGTa4b1JeMYI3Wm+OXqw5NYc77O9mu18
	/fYc9tjMEMa+8IUzQAIqB+GlphJ2VUrHAN+9reEXMr8+UqES6DLbwKLbHJstlLBB0s5JHEZ8hUP
	eCKBoBg==
X-Google-Smtp-Source: AGHT+IEDUY7uikFm0PLLoa4SWCag4yDK2cFssmBI7rVcELRd/96KcIDLXNCeeDSTCU2mUUxx9oFMyzZKR+Ij
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:46c4:b0:6db:c34f:9e4f with SMTP
 id 00721157ae682-6ee55ce2ed7mr6320877b3.8.1731979041911; Mon, 18 Nov 2024
 17:17:21 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:27 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 05/22] perf kvm: Move functions used in util out of builtin
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
index 274568d712d1..67fd2b006b0b 100644
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
index c06d2ee9024c..cc6962407376 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -121,6 +121,7 @@ perf-util-y += spark.o
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
index 029536c1fabc..f8b291143884 100644
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
2.47.0.338.g60cca15819-goog

