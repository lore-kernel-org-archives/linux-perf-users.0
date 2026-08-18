Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78A19644B
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787013067; cv=none; b=TFIkpWGrmuY9MyMepTM2o8VA9tNUqZq9nvV6JTXxHL889xHYm/fMHyd+O1+bH8QwvXdkojxHX3Zl7LWaLqinysYlM6d4631iFU5tkeIFvTRK6dA0JO28C1YdPAT1BmlqyeroFecrH9ZypgOguIBmJ82uRnCEclnCYO/svVMtWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787013067; c=relaxed/simple;
	bh=Xvd1UL8Vgn5rYH7mFCDcMHXnFC3yh+9nr4WA6d6jVf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkaoUbhqMPvG2X5hyxPEGVjY5/y5nCdCOAxj7MN89QMvyot7P2ThKLNTG8YgzgZkZpXxl3YiCxkDf6SzAM+eFJOSUpPuwdMim5Gr1ezAhPAqHKS7pbvLcO/RRgenWtrN0wB5aB5ZqqlDM8Gucn7VQf1yTe5+HyHLiaiRm6THJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuC7h3g0; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuC7h3g0"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca8aee88725so6131270a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787013065; x=1787617865; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eBkWEsGiIHckhP28r73Q4W8h3Fk9SPGkVFAPKyhiLAg=;
        b=BuC7h3g0iEjTdFx37EQ+qsaxca+sC7ZX2HLwsMk4pLwKaGex4lnoHZfSFojmpZsU5h
         73hlqPrx3hlto4+msLmdD+U1d6vFWG0YnM02gcR5ZNBX1lQb/ZYNwItM3a8Y9D5wwPXp
         Nk5eD6U2qjZ3ukm20aBEfHhLjFh0D2FvmpcTo6VrS+TtFcbWiNRBcDJkZPwXhbob2fTC
         UHg8s5KSjwRq7MK8FG4dsj8mjCBMdIIvxxTMT2SZx1GEGUgJVjZ0LWvCaGS4tfoRfrtl
         BeLb+sSxfmQdLypPWfttinf4kfVQSeJFmZPXPb0Wliw4eE5+n6qU37+0AuEmMAdD4fGv
         7fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787013065; x=1787617865;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBkWEsGiIHckhP28r73Q4W8h3Fk9SPGkVFAPKyhiLAg=;
        b=m6JHNfX/s5uR5lgz51fU2z/WwtX4ViLHi5h7FRnOx5R6HJ/R5TTKjtPvUu/L1HcOb+
         wavD+3iIZrWS18j4+ZfiEFcTXmDPZpBW2ItVHNqSjRJ5KCCG/9s/nefqdJ+2LMp6fQsy
         phOcZncmVBmHWocgL9fIwIXMKK7Vz2Vy59JAGE8uXTYrIqS4iOrYEZRwE/SNJuXoAS+j
         Eqv//F36HX5h6/QoA9DNWkg4Du8L23fvncpUAKGq/iJujUoLatmvjP+wL8eTAwsKJCD+
         HTFyEPrmxBNBDEfDizDZPYHWpG4WDPg04cUDWF0bQSSGV3RD7xVIZeV0jMovsWr9ms8b
         iyqw==
X-Forwarded-Encrypted: i=1; AHgh+Royoip+eSdb4amqlN7aMgZbXvs2Hpw3nluSDKVXYo+EeqNfv4D27QUFt6xccqdFaZo4pzcgGg1bcl5Z7H2Dg3Kp@vger.kernel.org
X-Gm-Message-State: AOJu0YwOG5XIIVasbCNpaUTFSx80fQtgPKrmakO9REfOhTlJx/o0uatH
	Wwsic3RfyTTSzkdB0rN9AE2TLgCvgoRHqqH7Fw2CQs9zdhfC8gtfFmv+fe2/9+865+jZjmNCE/M
	85vnzoFsiUQ==
X-Received: from dlec4-n2.prod.google.com ([2002:a05:701b:4284:20b0:141:5319:4d04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a48:b0:3c3:b57b:6291
 with SMTP id adf61e73a8af0-3ccdac00616mr5132127637.18.1787013065039; Mon, 17
 Aug 2026 17:31:05 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:31:01 -0700
In-Reply-To: <20260817230431.424646-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817230431.424646-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260818003101.520874-1-irogers@google.com>
Subject: [PATCH v5] perf record: Fix unhandled POLLHUP on non_perf_event descriptors
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: abyssmystery@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When processing POLLHUP or POLLERR for an event in fdarray__filter, the
function's prior iterations incorrectly mutated non_perf_event control
descriptors by zeroing their events when a POLLHUP occurred. This caused
premature termination due to index mismatches or hangs since the core
evlist logic was prevented from safely finalizing the poll array setup via
evlist__ctlfd_process().

Revert the logic in fdarray__filter to cleanly bypass all nonfilterable
events as introduced by fb4751e79c45. Instead, fix the underlying logic
within record__update_evlist_pollfd_from_thread() in builtin-record.c to
sustainably reflect teardown statuses (-1) originating from
evlist__finalize_ctlfd(). This correctly mirrors the finalized state to the
thread's poll structure avoiding both invalid -EINVAL index crashes and
POLLHUP spin loops.

Included is a unit test to enforce that fdarray_flag__nonfilterable items
are accurately completely circumvented during revents filtering loops.

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
2.55.0.699.gb54405d56f-goog

