Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9C2BFC60;
	Sun, 24 May 2026 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593352; cv=none; b=CRtzm3yfuSYjl3tsgkua8WTFT0EgdQTo3rh8DexE+GPp2iXxoFv9iw1bl1ekJEedFKPn/AtIB2XKiKbTgr3GjH517ty2nv7wrFa04iOA/cJw4DMdqbvmFdX48TjZdK+YS41glGBGjJY045736v84zRxpQupqbZMB/A7nZj7Whhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593352; c=relaxed/simple;
	bh=xnReiC7LIc4FIhhidxubs+j9XOP3YYMrtGBU1PE5CRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xrm0BiLc2qtYrfGfCdc77k1z3NyRV3fM7jJL/oboBWeRpyytcx+ze6Uwd86IYwLrkPjaHLk4Sq2gmIInVrORgGUPmi1iiDAJg9qldeXOWy7V9MXwpTCVyay8wTSE86lCUy+hdUvesNTOjdTL7QCEzOTZG7e49b5c7LKXeWITL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZKO2OdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZKO2OdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E912A1F000E9;
	Sun, 24 May 2026 03:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593350;
	bh=Xjh9T5IiUdv+9+73B/1Edup0Gp0kWtbO/ZdAKxTcb8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZKO2OdH8A6lZXGeKvpni6Uz8sp2ERFAVJ//2yg2gAuQ0gISQsyujidY3ptLY6cIE
	 8aGU3XfRw5Ox5xMWKOxdae2K6nDtymnVj1/aJbvZinWaf73cE/PNKTCUDwBHRrG0DY
	 Wsza+BOc6eUFLqCPr5nTBS/G/GHyS/nSeTLz2hO05RcyHBfZrjLf+KBk2b60cI4+ZF
	 E4qiXpTukAZyOO8+rL/h0rYfbw4osKFtesT12Mifekh0GxWxCJCWl4edsHrCYMoVSg
	 wCnaxgDHsIMDYltTbC748mK5ldO+Z7+47ZMZOSAOEzmEnNlrqaKspe9WMXbyyGhJ3s
	 6jstJ+cqqxyWg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 18/29] perf header: Propagate feature section processing errors
Date: Sun, 24 May 2026 00:26:52 -0300
Message-ID: <20260524032709.1080771-19-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524032709.1080771-1-acme@kernel.org>
References: <20260524032709.1080771-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_session__read_header() discards the return value from
perf_header__process_sections(), so any error from a feature
section processor (process_nrcpus, process_compressed, etc.)
is silently ignored and the session opens as if nothing went
wrong.

This defeats the validation added by subsequent commits in this
series: a crafted perf.data that fails a feature section check
would still be processed with partially-initialized state.

Check the return value and fail the session if any feature
section processor returns an error.

For truncated files (data.size == 0, i.e. recording was
interrupted before the header was finalized), skip feature
section processing entirely and clear the feature bitmap so
tools use their "feature not present" fallbacks instead of
accessing uninitialized env fields.

Change the feature processor stubs for optional libraries
(libtraceevent, libbpf) from returning -1 to returning 0,
so that perf.data files containing these features can still be
opened on builds without the optional library — the feature is
simply skipped rather than causing a fatal error.

Also propagate evlist__prepare_tracepoint_events() failure as
-ENOMEM, since the function can fail due to strdup() allocation
failure inside evsel__prepare_tracepoint_event().

Fixes: 1c0b04d12ae9 ("perf tools: Add perf_session__read_header function")
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 51 ++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9e3a08b1f8ae5a73..f4e0e257ff7226ac 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2748,8 +2748,9 @@ static int process_tracing_data(struct feat_fd *ff __maybe_unused, void *data __
 
 	return ret < 0 ? -1 : 0;
 #else
-	pr_err("ERROR: Trying to read tracing data without libtraceevent support.\n");
-	return -1;
+	/* Not an error — the feature is simply unsupported in this build */
+	pr_debug("Tracing data present but libtraceevent not available, skipping.\n");
+	return 0;
 #endif
 }
 
@@ -3643,8 +3644,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 	up_write(&env->bpf_progs.lock);
 	return err;
 #else
-	pr_err("ERROR: Trying to read bpf_prog_info without libbpf support.\n");
-	return -1;
+	/* Not an error — the feature is simply unsupported in this build */
+	pr_debug("BPF prog info present but libbpf not available, skipping.\n");
+	return 0;
 #endif // HAVE_LIBBPF_SUPPORT
 }
 
@@ -3712,8 +3714,9 @@ static int process_bpf_btf(struct feat_fd *ff  __maybe_unused, void *data __mayb
 	free(node);
 	return err;
 #else
-	pr_err("ERROR: Trying to read btf data without libbpf support.\n");
-	return -1;
+	/* Not an error — the feature is simply unsupported in this build */
+	pr_debug("BTF data present but libbpf not available, skipping.\n");
+	return 0;
 #endif // HAVE_LIBBPF_SUPPORT
 }
 
@@ -4900,7 +4903,7 @@ int perf_session__read_header(struct perf_session *session)
 	struct perf_file_header	f_header;
 	struct perf_file_attr	f_attr;
 	u64			f_id;
-	int nr_attrs, nr_ids, i, j, err;
+	int nr_attrs, nr_ids, i, j, err = -ENOMEM;
 	int fd = perf_data__fd(data);
 
 	session->evlist = evlist__new();
@@ -4920,6 +4923,7 @@ int perf_session__read_header(struct perf_session *session)
 		return err;
 	}
 
+	err = -ENOMEM;
 	if (perf_file_header__read(&f_header, header, fd) < 0)
 		return -EINVAL;
 
@@ -4997,15 +5001,36 @@ int perf_session__read_header(struct perf_session *session)
 		lseek(fd, tmp, SEEK_SET);
 	}
 
+	/*
+	 * Skip feature section processing for truncated files
+	 * (data.size == 0 means recording was interrupted).  The
+	 * section table is unreliable in that case, and the event
+	 * data can still be processed without the feature headers.
+	 * Clear the bitmap so has_feat() returns false and tools
+	 * use their "feature not present" fallbacks instead of
+	 * accessing uninitialized env fields.
+	 */
+	if (f_header.data.size == 0) {
+		bitmap_zero(header->adds_features, HEADER_FEAT_BITS);
+	} else {
 #ifdef HAVE_LIBTRACEEVENT
-	perf_header__process_sections(header, fd, &session->tevent,
-				      perf_file_section__process);
+		err = perf_header__process_sections(header, fd, &session->tevent,
+						    perf_file_section__process);
+		if (err < 0)
+			goto out_delete_evlist;
 
-	if (evlist__prepare_tracepoint_events(session->evlist, session->tevent.pevent))
-		goto out_delete_evlist;
+		if (evlist__prepare_tracepoint_events(session->evlist,
+						      session->tevent.pevent)) {
+			err = -ENOMEM;
+			goto out_delete_evlist;
+		}
 #else
-	perf_header__process_sections(header, fd, NULL, perf_file_section__process);
+		err = perf_header__process_sections(header, fd, NULL,
+						    perf_file_section__process);
+		if (err < 0)
+			goto out_delete_evlist;
 #endif
+	}
 
 	return 0;
 out_errno:
@@ -5014,7 +5039,7 @@ int perf_session__read_header(struct perf_session *session)
 out_delete_evlist:
 	evlist__delete(session->evlist);
 	session->evlist = NULL;
-	return -ENOMEM;
+	return err;
 }
 
 int perf_event__process_feature(const struct perf_tool *tool __maybe_unused,
-- 
2.54.0

