Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE83B635F
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261885; cv=none; b=H16/FAgcD+mHow1YKP9nXwOUN0nNq7hx3R1l2dSPQQ4kfKbSTZhpqwywObKTe4SbazvcjaZZlLWDU1Vtwn4IL9/GjOXE+h8O8P+MQDU8ZVuu+ui/J9Y21k/XWBvCIYPqXaLxzlE5QoccP05xs1iho1sc2X+Rxy+3Xrr+taEIHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261885; c=relaxed/simple;
	bh=Cf98IoLnhwEQM4fCiNSa3OTtiMPVHKhfCiyRgVgqBu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rai1uOnQRsh5AlQx5eFL1h0yIFXh1y2rBbyAjg2h0S7Sg6YkATaRm/yd7/P5dMd5kiF8fHQyd3oyxcKfjmQ/OzhfKto4kBE0Y6Owo665CAf0YLD5J+BlSCQNSML680zJ2GQQkHXfGVBoShAnQx2qkCMPn5h58PNQwQ1d3xkfGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdQDwKQg; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdQDwKQg"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so404854a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787261883; x=1787866683; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iztg2st1CarenIoYnhLpXhLJnTvFo9lRC02RsCA/rco=;
        b=TdQDwKQgb2sGTaWVh26Yy6HePfNDYfZlTrfYgWysF47SKG98X7Gz7+dRoB41wz36Tn
         Jykx7nyV61c0Qx75tVRHykZ4do+3wX4Pua9ivmdW+fFZNTUC0o1bTFjM6QM97sB+3zrF
         pSF1IQU0SJg9eB+cDTQpyaVaN5FuOnyDFR8sATDFB3vb630gsEbUP8Gs3VkJ4guxd8mv
         BqzP+PPaFWXgOD0z4UVp0VDGi7jygHAj1E2thjO9WqZfp9mqxuoiwSDJhoU9rpFXU3g+
         IAOPBC8JNYjRU4HycaMeNKJzb3lRo1gllm94LiwgxRbj98/5hcRf0JMeukGqopyN7nhl
         489w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787261883; x=1787866683;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iztg2st1CarenIoYnhLpXhLJnTvFo9lRC02RsCA/rco=;
        b=ng+m2Igier3QeTiSPDD+4W06mBn41auCZU8WNMt95GULKjo9Z0Ze2t1cTxrL0Gr0Z3
         exxuOYCsKp10URqIvhgJ82eEr6WEtkTzN9ob4a6qpgOYwnx8bo6y1ifN07QX8IZ/SBhn
         5vxVOJpih/EUlxkOjTdSiajwI1/M+PZsNDVhJZkSihE9xM3feVuRFG1yyKDfi2SnJ8Gn
         wfuvdG7wBJmQlgJ0NbaZacoYzRSJ6XnMPLA/Oy/D1KgE/Ng1d6/Y21br/vUpqFs5UmHI
         JfJx2JTFNOaFI8X2bslWvg4gCOPQ0K+f8gYNLCRormxRQd8LouLGGCI4M60/3nAE0akT
         DPuA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8YXeORUX6TBLDMapLt56gb0pJehJIzHZ2nOEa8f9MAVLNw10Q+ba4jwGUZKn+0RWXUe5zCcEXH3de0CBO1YaQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxBot8ox6fPcYUJL+PoKVh8iY4Qaoh4uDdAlg68vSXGk5MPqWAr
	X5/+ezve2riWqfvZE1SdwwNd+0dP7rPMfjzJ3xs2Ru6lQjP44CPGo5G4oy27WzguXVohWbh125C
	yNcMn6nQw3Q==
X-Received: from dlbrc13.prod.google.com ([2002:a05:7022:ea8d:b0:141:3e0f:b739])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4a97:b0:3c6:61b9:917c
 with SMTP id adf61e73a8af0-3cd3076a585mr2553422637.11.1787261882597; Thu, 20
 Aug 2026 14:38:02 -0700 (PDT)
Date: Thu, 20 Aug 2026 14:37:57 -0700
In-Reply-To: <20260820200214.2865570-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260820200214.2865570-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260820213757.2970316-1-irogers@google.com>
Subject: [PATCH v8] perf record: Fix unhandled POLLHUP on non_perf_event descriptors
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
 tools/lib/api/fd/array.c    |  4 ++++
 tools/perf/builtin-record.c | 15 +++++++++++++++
 tools/perf/tests/fdarray.c  | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 67b73481df27..3200746d1657 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -116,6 +116,10 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
 
 	for (fd = 0; fd < fda->nr; ++fd) {
+		/*
+		 * Explicitly bypass nonfilterable items (e.g. control descriptors).
+		 * This ensures their fd, events, and revents remain completely untouched.
+		 */
 		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
 			continue;
 
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

