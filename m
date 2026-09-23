Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462D44A40E
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147666; cv=none; b=iXgiyHZkpsltdPzELj2cdBMc9l7xa5JOtkabugVn3n3bCN/LI3KjLKZ77ZkP2E2bXA9U5SSWdWckAu1ZT+OC78gLiy/RfH096fiJ3HOVsxEXIHjlXPQG8sf+0wvOPF/HCpPTVBvFOZFKTBxEvO7NKwVeS+KJTCgxYwOvIu5wA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147666; c=relaxed/simple;
	bh=NG61hDMAN/8MqjNmPkTpk+d48KbTt9ihnQruMIE3O58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KlJD8LOaCpwdNF62icLNiEcee2D3+lZbP3pc5+EdFWPF3uW7qVTNWYW5Xwqx1vHiIeo0IzjOdytM/SfHn6UkEbu7rdJJKkPrey3cPTMHQLkLXHV5Q7v/CyapRigcu2au/tvoiq4IPsQNgNHjgti7B6YNTZoU3KvE9ZDpVNajms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSB9c9YV; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSB9c9YV"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso917979eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147662; x=1790752462; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXZwHe62caikgyPiwv6l+s4W+ytiH/MmGz+IbCWr/dc=;
        b=WSB9c9YVtZfV8l/P2utQYC+VThTXYxnlOsJDpae1yifMDe4bDeNY5Gk/zFHQbaTfcY
         zzh+T3xDyZc7PukBbE35InGlE7YgImyiNoiqunDBAlKAySvsv/AM1/e2t08WZsQ1WKAh
         8tVplClvGUyG1iETPlfTYO2Tq7/FBt5rlCE87S2yG78Eg9SP2/l+IQIoMQLxpm6ZTeT0
         iOMXuft/DyG96pdYUkhrkm0i0qd1Q8qvvGvcyUyBOwbeI12elHnKaLB+LSzYZ1BPDw+k
         0ObnYUJ/Cer0M5COYSMTBtE9KcPqLI0nxm7iiZiUrLr08PzAHniY9Fs6w/b+QucwjMzc
         Gq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147662; x=1790752462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXZwHe62caikgyPiwv6l+s4W+ytiH/MmGz+IbCWr/dc=;
        b=RFAEzyv5Td18QK6xX1ktEm3Mmugf/buSfsIZFx+KAQNFclf1diOq/AxIJioktfroFS
         v71H+6rFxlkYaR2siGWB3zSgVSWhfoWw+KKrqeGWP9SLYBmU5H9Yr6hWbNKtWoLLfYf4
         YdtMCx8Ey2mTRW4fKbkeOFVmCJecvS8Dj6kEHXtpiD6etyc3VG8rWYoc7wMM7ZkZ5g/x
         JX6I6g2yZQ1qt40xH38Uuc4QCMZT9+ir2nqcGnPZCgCgiXtDWgg+bfENwOkWDhkAxwBI
         01SynMjRP8G+1413Larflw2X6k/A+0pWjMv1tyMlyxp/EOiFrYkhH2Cef36ku19WFLbd
         OGdA==
X-Forwarded-Encrypted: i=1; AKwUvBy4eSGg9TE/1Q5q9R4WK/0HP6rQOvqkWKBd11+xzA0BpyuBuRhWJo89R4IGNbe1l1yIAcQbrbR8bS7p0TPuETi3@vger.kernel.org
X-Gm-Message-State: AFuF++mEbUgEVp7Yw0X7VtN8l3wMEVgcAKT2HyQk8AeslS+DPe4OL3kh
	5sa3/nvcopdBdK3tD0AFDgPontcev0dZau+HKGwyEUqQkZSf8fdv52UqZtIgUgTA/CmjuvzPvTy
	TuT6iWq0Riw==
X-Received: from dybvu25.prod.google.com ([2002:a05:7300:f819:b0:33e:54b9:7324])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:88c8:20b0:33b:e3c8:aef4
 with SMTP id 5a478bee46e88-33e95f69048mr1489523eec.0.1790147662251; Wed, 23
 Sep 2026 00:14:22 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:45 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <89815a65029985761ed8356f8a648ab128fdebbc.1790145937.git.irogers@google.com>
Subject: [PATCH v5 05/23] perf evsel: Report an allocation failure as ENOMEM
 when setting filters
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

evsel__set_filter() and evsel__append_filter() return -1 when the strdup()
or asprintf() that builds the new filter string fails, and
evlist__set_tp_filter() and evlist__append_tp_filter() do the same when
handed the NULL that asprintf__tp_filter_pids() returns for the same
reason. In every case the only thing that can have gone wrong is an
allocation.

Callers all test the result with "< 0" or for being non-zero, so -1 has
been as good as any other error so far, but it is not an errno and so
cannot be printed as one. A caller that does, such as

	str_error_r(-err, errbuf, sizeof(errbuf))

turns it into EPERM and reports a failure to allocate as "Operation not
permitted", which is no help to anyone trying to work out what happened.

Return -ENOMEM instead, which is what these failures are.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 12 ++++++++++--
 tools/perf/util/evsel.c  |  4 ++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 22eb01116992..9392d912d254 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1432,8 +1432,12 @@ int evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	struct evsel *evsel;
 	int err = 0;
 
+	/*
+	 * The only caller that passes NULL is evlist__set_tp_filter_pids(),
+	 * where it means asprintf__tp_filter_pids() failed to allocate.
+	 */
 	if (filter == NULL)
-		return -1;
+		return -ENOMEM;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
@@ -1452,8 +1456,12 @@ int evlist__append_tp_filter(struct evlist *evlist, const char *filter)
 	struct evsel *evsel;
 	int err = 0;
 
+	/*
+	 * As above, a NULL filter is asprintf__tp_filter_pids() having failed
+	 * to allocate in evlist__append_tp_filter_pids().
+	 */
 	if (filter == NULL)
-		return -1;
+		return -ENOMEM;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0d0b2804d238..dd468716f424 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1872,7 +1872,7 @@ int evsel__set_filter(struct evsel *evsel, const char *filter)
 		return 0;
 	}
 
-	return -1;
+	return -ENOMEM;
 }
 
 static int evsel__append_filter(struct evsel *evsel, const char *fmt, const char *filter)
@@ -1888,7 +1888,7 @@ static int evsel__append_filter(struct evsel *evsel, const char *fmt, const char
 		return 0;
 	}
 
-	return -1;
+	return -ENOMEM;
 }
 
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

