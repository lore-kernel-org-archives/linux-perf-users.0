Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202E047CC97
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244585; cv=none; b=OH7lS4NMPuOM+8R1mE1CjEoMEY1E7hgBdlR65vPnyK9WS+r2RAJrKQ27ULoRN/bITNIRKR33WixfKJcWXRvDa6CUFpXK+gR+dfzMcrfHqJprkl+nBQXpS0zlHrjgp8r4b2vhn9Zo/4bAHm1kKF65ZVerGlDYCdJuCFnLJU1diDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244585; c=relaxed/simple;
	bh=uYzJoMbPyqoEaHF0dvvGm+ULGCE+DewWSiHZC8LrFF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IOl/x8rXsU7DaT2PbZhlnkLwrVlRz8EmWjIfESZauWD6SSprdqsvuuLAyXjH1q9fwU6SYjji67EF8rEV909aGQ6tn8Q9L6ysnV1e0OYNJDXeQo6LPv64HwtumsLL3kqUS4yN2IEnsvbIUlanp8UF1v79VN+M/zQAwdoG1xi5EVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGwjgYdX; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGwjgYdX"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so25207a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787244583; x=1787849383; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2DTEykckvZYMaxgCa5ZLlbjqp/wrdk34N7N6Tb7jKQ=;
        b=kGwjgYdX1jwHgXd0q0Hnu5CjlGUIXmZZWRXVG2tPdvV2wmBptDD80/2chhheHAzQgm
         nxIiYZ8Qk4ztkML6sXSDCPTEM1xwuNIZJTEgy0mdyXjNaLUwtIjBkmPe/nmyW8F6XyBq
         LSQc3zE/ou92wNtBZ6UQsGkXAJSrs2NipTNhOfHrf+gf4hP4FEFPu9lNqoWOBttDFvrG
         K12zpNzFr46CvWbmUjRfx5j6P9oCNJQTOFXzUWJgChleapNspFKNRqLPaRMlT0HCHVPe
         f+6zCJZT8qEMGWRQ9q7+hpxR1IZ9ZQOFxOePM9aiJQUFLUjO67ODRbrSQwZZk8sx4/aJ
         DXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244583; x=1787849383;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2DTEykckvZYMaxgCa5ZLlbjqp/wrdk34N7N6Tb7jKQ=;
        b=aYB3UGnPSLR62uchz/b7+PsxjYLpvbQAGQo5Q3+x+e5YN0jmYZRQJBF4S9juEos+C0
         0JHVbG8nHp4G4E9+QFr8vf9DyHXrBdJN7b/NrlTKFEkaePI+ELu+15a9GjO7+Cw2rkB6
         3d4c0xNmA1CMJHYn+1xuWcocceLozyb7rMrPjlv3EIpNHfCOiDDvTixl92DokZT1zCZT
         9ijTxhYUI8TcqkuSUrzIa7HxqTyzr95mizsF3kavFLW/nU8ZEOlzLoWHo/8c47BA+016
         IjbjhbV5eYrEhGrLNf4TI7ntQ3q9Tidr+kTI8jjplVBY79CCmD1NsA5P+G2mM7DTFpou
         Ya+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrbbVRedqQlE7/VaUbKV+ifoSYS1UOfeg7NYsWdaCU54zAuEycTQj7FMc9+tEAM1SNR9ytF0aAdgdSOmeI1X/ZB@vger.kernel.org
X-Gm-Message-State: AFuF++mOr0NquSA0lOeZwfHxXCa03G0Ti4Qn4A2eWHeOYroS89S83FKR
	xVuCVpSPy8htqY2JPmKbt9L3Ugft6qFhK9MpSvSJYXycXG3769G0m2wRNSZKW+RQH7GSBuqOqAv
	Euy85DD8Wjg==
X-Received: from dlbrl7.prod.google.com ([2002:a05:7022:f507:b0:141:59a4:247a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b83:b0:38d:ddc2:7ccb
 with SMTP id 98e67ed59e1d1-39580a4d117mr24173356a91.1.1787244583197; Thu, 20
 Aug 2026 09:49:43 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:49:37 -0700
In-Reply-To: <20260818003101.520874-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818003101.520874-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260820164937.2734066-1-irogers@google.com>
Subject: [PATCH v6] perf record: Fix unhandled POLLHUP on non_perf_event descriptors
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: abyssmystery@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When processing POLLHUP on a non_perf_event control descriptor (like ctl_fd),
evlist__finalize_ctlfd() is invoked to finalize the setup, correctly setting
the core evlist's poll array file descriptor to -1. However, this finalized
teardown state is never propagated back to the individual thread's local
replica of the pollfd array.

Consequently, on the next iteration of the main recording loop,
record__update_evlist_pollfd_from_thread() performs a strict equivalence
check between the core evlist's array and the thread's localized poll array,
detecting that the fd values no longer match (-1 != original_fd). This causes
an immediate -EINVAL abort and a premature, ungraceful teardown.

Fix the underlying logic within record__update_evlist_pollfd_from_thread()
to sustainably propagate the finalized teardown statuses (-1) originating
from the core evlist back to the thread's localized poll structure. This
correctly maintains synchronization and entirely prevents the unhandled
index mismatch crashes.

Additionally, add a unit test that explicitly validates that fdarray__filter()
preserves its invariants regarding fdarray_flag__nonfilterable items to
guard against future regressions.

Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide multi-threaded sessions")
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 10 ++++++++++
 tools/perf/tests/fdarray.c  | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a57987851cf0..d7c083803029 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1169,6 +1169,16 @@ static int record__update_evlist_pollfd_from_thread(struct record *rec,
 		int e_pos = rec->index_map[i].evlist_pollfd_index;
 		int t_pos = rec->index_map[i].thread_pollfd_index;
 
+		if (e_entries[e_pos].fd == -1 || e_entries[e_pos].events == 0) {
+			/*
+			 * e_entries might have been finalized by evlist__finalize_ctlfd().
+			 * We must propagate it to t_entries to avoid index mismatches
+			 * and to prevent a poll storm on the next iteration.
+			 */
+			t_entries[t_pos].fd = -1;
+			t_entries[t_pos].events = 0;
+		}
+
 		if (e_entries[e_pos].fd != t_entries[t_pos].fd ||
 		    e_entries[e_pos].events != t_entries[t_pos].events) {
 			pr_err("Thread and evlist pollfd index mismatch\n");
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index 40983c3574b1..2d3db7b754a1 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -80,6 +80,30 @@ static int test__fdarray__filter(struct test_suite *test __maybe_unused, int sub
 		goto out_delete;
 	}
 
+	fdarray__init_revents(fda, POLLHUP);
+	fda->priv[2].flags = fdarray_flag__nonfilterable;
+
+	pr_debug("\nfiltering all but fda->entries[2] (nonfilterable):");
+	fdarray__fprintf_prefix(fda, "before", stderr);
+	nr_fds = fdarray__filter(fda, POLLHUP, NULL, NULL);
+	fdarray__fprintf_prefix(fda, " after", stderr);
+
+	if (nr_fds != 0) {
+		pr_debug("\nfdarray__filter()=%d != 0, should be 0\n",
+			 nr_fds);
+		goto out_delete;
+	}
+	if (fda->entries[2].fd == -1) {
+		pr_debug("\nfdarray__filter() illegally modified nonfilterable fd!");
+		goto out_delete;
+	}
+	if (fda->entries[2].revents != POLLHUP) {
+		pr_debug("\nfdarray__filter() illegally modified nonfilterable revents!");
+		goto out_delete;
+	}
+
+	fda->priv[2].flags = 0; /* reset flags */
+
 	pr_debug("\n");
 
 	err = 0;
-- 
2.55.0.737.g08866a6d13-goog

