Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8A17993
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256140; cv=none; b=qtqMcpTttxwRddhQ7g21lTlqvKqzNBQpI8FV8gUtVeXTDRFtGpQgFuUSjZly5K36ur2bIyMwXfKNaGRk1UhklKiWaDlERrfI5jbntFXsycuQBzQftLSpofPlY3l5D8jCbnYdQ8FfzpVWBKc/bpSSGnIGmDM7fAFfyyTJtWOE9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256140; c=relaxed/simple;
	bh=dPRqJ1mlI/IFPCa4Sqq8ARYfgBmSkgzc8GLRzlDzPGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8tTHlnF5thu0rNlx5aeiIvskDY387VA5yadHKro2aYzXu/gx5vOi97dF7ZlIIwvo5U/f/7FOPbyiTls42fLBRSpF8MlgL2+gPSlZGGJjEvq7PyJYErbD0JpMgUH1ftp0x3XHFQlCHemmY5zDrT1A+9INfwKjoGpYq9LIvBY2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8ey2x31; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8ey2x31"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbee57593baso145294a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787256138; x=1787860938; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=naPXrGNP/ZZPz03m+r90wYcO4W6hJGOcA9yVDHAeuqc=;
        b=X8ey2x3189enMqJlVBcbyoLQOQ6Mt5QPAOeQAIQOIL/CzopMpOw5QMAHLwwKcEdW/y
         ESNLP6CZV6Qn9PHyU8D+qOkPU6ZHXrw2TR3JPu5lXElBJ9z7FGlpq8K6CMW90AM3Y0OM
         AkLlAuViCJsTraQ7qvanQhEklTgqPRKuYdMQizCvNAj37UPV3Dc1h0Jx6IG6NYeBKx8k
         T/UtIUPb4XkEpF2mnp83df4qzxzTRm7LrOTvAICto3BefhoR+IKsfRRyT+lm6twhsXXd
         wTrgB6TktzG0HJ2UT7g9+OMCzXhEDqkCpNBVEhgTzlU0v886CSBrv6LEQ+/TklMBWWRl
         XE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787256138; x=1787860938;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naPXrGNP/ZZPz03m+r90wYcO4W6hJGOcA9yVDHAeuqc=;
        b=fZniBNj2At3oViMTiUDlca/C+UapXs6BUYJ7nCmCGTDI7Esu/vouEmdvTrA66bQRMs
         TbgQIlA5hzffYevQeicB+Mp6slgf3drSMTLSPiF5Ey46A5BJS5U+StofZ9jB45R6EK8Q
         iOJSig7xn/eX4NFVhMJ4slQ/BabnKTeF05fQs7B4sgzySiK0GWoKe9ELC1JJr/CaBcOT
         TORJwiGYc1Z18tXO7sWi8UQhT6lbIZxzPpbrpb9/wC55tGEpfEzrn5c9zBpOq1aRy3fj
         UgQ5Ov/uT/tY6Ix5az2lISJqzXHjoUiOpRhyA196TmkOzlv4hQxd3a6tfa/xih6ysqSd
         9OZg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/hSnWNrGEJb25hcopOe7VRbyBTEGj/18ylzlrCgL3htV+tliyaDDkYKu6PWEba5hItabhlt+63AdcjQPrUa03@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzOykxXaHlg4v8OpWmrXddgdB5cqP6F+rlhFuBCdsEl6IbzsT
	K3Q6c8EtQl/up2UiSHfTxF4zhFPOqDlkRqFWKVWLPZ04HtTb/Tr6Av7W288apDK2VL+5+oGchAU
	p/wjScnAdLQ==
X-Received: from dycqw25-n2.prod.google.com ([2002:a05:7300:c019:20b0:313:b34f:8861])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1fc8:b0:3cc:9316:cad3
 with SMTP id adf61e73a8af0-3cd2fa367c0mr2107577637.0.1787256137872; Thu, 20
 Aug 2026 13:02:17 -0700 (PDT)
Date: Thu, 20 Aug 2026 13:02:14 -0700
In-Reply-To: <20260820164937.2734066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260820164937.2734066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260820200214.2865570-1-irogers@google.com>
Subject: [PATCH v7] perf record: Fix unhandled POLLHUP on non_perf_event descriptors
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: abyssmystery@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When processing POLLHUP on a non_perf_event control descriptor,
evlist__finalize_ctlfd() is invoked to finalize the setup, correctly
setting the core evlist's poll array file descriptor to -1. However,
this finalized teardown state is never propagated back to the
individual thread's local replica of the pollfd array.

Consequently, on the next iteration of the main recording loop,
record__update_evlist_pollfd_from_thread() performs a strict
equivalence check between the core evlist's array and the thread's
localized poll array, detecting that the fd values no longer match.
This causes an immediate -EINVAL abort and a premature teardown.

Fix the underlying logic within
record__update_evlist_pollfd_from_thread() to sustainably propagate
the finalized teardown statuses (-1) originating from the core evlist
back to the thread's localized poll structure. This correctly
maintains synchronization and entirely prevents the unhandled
index mismatch crashes.

Additionally, add a unit test that explicitly validates that
fdarray__filter() preserves its invariants regarding
fdarray_flag__nonfilterable items to guard against regressions.

Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide multi-threaded sessions")
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 15 +++++++++++++++
 tools/perf/tests/fdarray.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a57987851cf0..ad81458989b5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1169,6 +1169,21 @@ static int record__update_evlist_pollfd_from_thread(struct record *rec,
 		int e_pos = rec->index_map[i].evlist_pollfd_index;
 		int t_pos = rec->index_map[i].thread_pollfd_index;
 
+		if (e_entries[e_pos].fd == -1 || e_entries[e_pos].events == 0) {
+			/*
+			 * If the control file descriptor was closed, then evlist__ctlfd_process()
+			 * will have called evlist__finalize_ctlfd() on the PREVIOUS loop iteration
+			 * to cleanly set the core evlist's e_entries[e_pos].fd to -1.
+			 *
+			 * Since nonfilterable items are skipped by fdarray__filter(), the
+			 * thread's local t_entries[t_pos] retains its original state.
+			 * We must explicitly propagate the finalized -1 state to t_entries
+			 * BEFORE evaluating the strict equivalence check below.
+			 */
+			t_entries[t_pos].fd = -1;
+			t_entries[t_pos].events = 0;
+		}
+
 		if (e_entries[e_pos].fd != t_entries[t_pos].fd ||
 		    e_entries[e_pos].events != t_entries[t_pos].events) {
 			pr_err("Thread and evlist pollfd index mismatch\n");
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index 40983c3574b1..23860edb8ef0 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -80,6 +80,38 @@ static int test__fdarray__filter(struct test_suite *test __maybe_unused, int sub
 		goto out_delete;
 	}
 
+	fdarray__init_revents(fda, POLLHUP);
+	fda->priv[2].flags = fdarray_flag__nonfilterable;
+
+	pr_debug("\nfiltering all but fda->entries[2] (nonfilterable):");
+	fdarray__fprintf_prefix(fda, "before", stderr);
+
+	/*
+	 * Note: fdarray__filter() in tools/lib/api/fd/array.c evaluates the
+	 * fdarray_flag__nonfilterable flag at the very top of its loop via an
+	 * early continue. Therefore, it completely skips all processing for this
+	 * descriptor, guaranteeing its fd, events, and revents fields remain
+	 * entirely untouched by the filter mask evaluation below it.
+	 */
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
2.55.0.766.g2966f0265a-goog

