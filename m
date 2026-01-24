Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0818FDBD
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Jan 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213783; cv=none; b=XQXSQ277fpTXdkSXYXh/9Y5reHt2IMCKbHFpUv9vQqPb6tJsis2t3SDiwXQ0QkPL2jvr0jerdHJUuVOCIcrCGKf5COfDBQUguir+hXGk5xVnpYJII6HgxS8AkKkeeY616911zrD51hNPOS2+9dd4gBoUNEPyHZh0VXlV9x3uEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213783; c=relaxed/simple;
	bh=xoTKdY5MAIMg9s3+CbhKXcBihq4xRVvKEKcGiPiugSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GA8DkVAEQ0Sik8592/KUNdAASLHWEV4iYlGL0G42lH45yxI6YD3IKBl+8hhVV4uyo54ImHK4T/OIFgMNj+xJjskp+O9shU8x78nyglDHwBh+IyYhKgStfF+BqWeDbYtNhX2d8HzJQ2aCVg7SvXqz7tpaXrj6kSfR4OKJoXhg0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMs7HADo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMs7HADo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b70d8095daso2518732eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769213781; x=1769818581; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XeLoVbBU1gOuq2z/uTQrFDkA2VXk5of7fAyzn6BOLT8=;
        b=gMs7HADoo2WMWFCMQTWMWDk30Xei1R5b4a7bUP96rONxLiOMTxKtyAIE7lCED+o6F3
         GTW2Qb2UQM8Cp2R1Qp/ZRu+EPivgk3tZXk78yFK21VCS+B9fcMrf+u7DkQcuwZ5ogJL8
         /lTYsZNfAmZNqf4o5qqjNPqwjgx0dXE5CYVHFo33hvOVeneURzmwtrJ8+7mnZdtGx6vc
         zYBaZykBLgRQFTDJs1LCCktSce7UO4DBwfDsO1BNvgkHmj16iY/jtYpJCPIJTDWajUF4
         uEGM1gwv8zZEHT1UtSpXm/+jw02/aPofPKAGhTacu3VaJQd0D5BwJPVPGaAlTqA5vZy9
         0Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769213781; x=1769818581;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeLoVbBU1gOuq2z/uTQrFDkA2VXk5of7fAyzn6BOLT8=;
        b=sQAQUehf6z+rvCU1fNQGU/05nGGCuD5uDMe2V56ggQMBb7LMPKg093Ek+F7Jm6yEY3
         pR/ZRO98pg7agQWrCILqDrjetmIIM++EpznNanb8cb1jc+84/DL+TTaXtAvAgyUNWQtp
         QQ+mV1XA26iDGyNO6IJQLEn7ODblkH5VlG2c6Y0FEG4bYmg8NUDPX7vyXaV9Hyw4nCSa
         1rOKfHfQaD0yW9rm5jsahyURI+4+JB+Jf6C21xlasNCfBUeyfHFhb/GxivGfOgC+dDs3
         Dtpy2x2OXv3lAZnUDyjFNnJi2dOPhIiWEJo1SD+YCVVn1Hj1dlzWPVtmUIe3lV8OiAre
         pRPA==
X-Forwarded-Encrypted: i=1; AJvYcCVaypFv265kn3b37JaK3yAoMnM4YgxohZOMfxyB51ZOasGG0nTi21/FWW0PHdMLwzERl0vnFp+QmL2+p9wuQ4+m@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5Fm/g2YuSrVctV+Bj+sNAGTlptGM+vzkW3a0FTHLsAaJCM2S
	xWG285CmgPhdqRNBbRAN7mCgqhxYfkItbEgX6k1dnv5V3WMa/FrbY01qYIjSz/KPDk2Mwffyvga
	jvwI4fyu5RQ==
X-Received: from dlbcf5.prod.google.com ([2002:a05:7022:4585:b0:123:291f:3e5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e0b:b0:119:e56b:91e6
 with SMTP id a92af1059eb24-1247dbf8170mr2467131c88.23.1769213781257; Fri, 23
 Jan 2026 16:16:21 -0800 (PST)
Date: Fri, 23 Jan 2026 16:16:10 -0800
In-Reply-To: <20260124001611.1332019-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260124001611.1332019-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124001611.1332019-3-irogers@google.com>
Subject: [PATCH v1 2/3] perf callchain: Switch callchain_param_setup from an
 arch to an e_machine
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Increase use of e_machine by replacing callchain_param_setup's arch
argument to be an e_machine typically read from the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++----
 tools/perf/builtin-script.c | 4 ++--
 tools/perf/util/callchain.c | 5 +++--
 tools/perf/util/callchain.h | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2e936928e8c0..810ffd66b11c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -448,7 +448,7 @@ static int report__setup_sample_type(struct report *rep)
 		}
 	}
 
-	callchain_param_setup(sample_type, perf_env__arch(perf_session__env(rep->session)));
+	callchain_param_setup(sample_type, perf_session__e_machine(session));
 
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
@@ -1283,7 +1283,6 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 			struct evlist **pevlist)
 {
 	struct perf_session *session;
-	struct perf_env *env;
 	u64 sample_type;
 	int err;
 
@@ -1297,8 +1296,7 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 	 */
 	sample_type = evlist__combined_sample_type(*pevlist);
 	session = (*pevlist)->session;
-	env = perf_session__env(session);
-	callchain_param_setup(sample_type, perf_env__arch(env));
+	callchain_param_setup(sample_type, perf_session__e_machine(session));
 	return 0;
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b4bf68b17948..c7c0d195b78b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2841,7 +2841,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(evlist);
-	callchain_param_setup(sample_type, perf_env__arch(perf_session__env(scr->session)));
+	callchain_param_setup(sample_type, perf_session__e_machine(evsel__session(evsel)));
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
@@ -3816,7 +3816,7 @@ static void script__setup_sample_type(struct perf_script *script)
 	struct perf_session *session = script->session;
 	u64 sample_type = evlist__combined_sample_type(session->evlist);
 
-	callchain_param_setup(sample_type, perf_env__arch(session->machines.host.env));
+	callchain_param_setup(sample_type, perf_session__e_machine(session));
 
 	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 428e5350d7a2..53ae382432c8 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -31,6 +31,7 @@
 #include "callchain.h"
 #include "branch.h"
 #include "symbol.h"
+#include "thread.h"
 #include "util.h"
 #include "../perf.h"
 
@@ -1679,7 +1680,7 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 		map_symbol__exit(&node->ms);
 }
 
-void callchain_param_setup(u64 sample_type, const char *arch)
+void callchain_param_setup(u64 sample_type, uint16_t e_machine)
 {
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
@@ -1701,7 +1702,7 @@ void callchain_param_setup(u64 sample_type, const char *arch)
 	 * erroneous entries. Always skipping the LR and starting from the FP
 	 * can result in missing entries.
 	 */
-	if (callchain_param.record_mode == CALLCHAIN_FP && !strcmp(arch, "arm64"))
+	if (callchain_param.record_mode == CALLCHAIN_FP && e_machine == EM_AARCH64)
 		dwarf_callchain_users = true;
 }
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 2a52af8c80ac..df54ddb8c0cb 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -303,7 +303,7 @@ int callchain_branch_counts(struct callchain_root *root,
 			    u64 *branch_count, u64 *predicted_count,
 			    u64 *abort_count, u64 *cycles_count);
 
-void callchain_param_setup(u64 sample_type, const char *arch);
+void callchain_param_setup(u64 sample_type, uint16_t e_machine);
 
 bool callchain_cnode_matched(struct callchain_node *base_cnode,
 			     struct callchain_node *pair_cnode);
-- 
2.52.0.457.g6b5491de43-goog

