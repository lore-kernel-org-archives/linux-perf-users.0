Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A2190664
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502522; cv=none; b=Aua38bUp0rmaU47ZjopfzmMBvfKATWD+cTtZq6zjXTNwGFYl/hZwXRkjWvmz4iOmu4tVbNPwTYAmrqGDYm5JncnesjsRNxnpZu0qFEj5IhNR+9WV4L0mJt22WgXC2A/kmF6013+vDr4LiRlPs5gy7ag4IFj+efYxdbJnu8EXF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502522; c=relaxed/simple;
	bh=wyd9uhmPN0GABF2K+vg3UiPa+g+PXig9NS7EoS1eKow=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=tVp96IA1IIGULFa50RlkNQREZApd2cjIva1e8ECPsP7kucQZ21HR8gsqFq8IrgO5Bo60u5Plf1xcBu7mEKcRf5+gHKcuvT0jTzwNBer5aUPR/Q9bS41Bud7pz4Q8wZE2HER97Fwq92XrmdxolJAYlxfZ6Wh4u+EIohq+evefl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvFFPtWL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvFFPtWL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61dfa4090c1so5648967b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714502519; x=1715107319; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=raUnGt98IcYzcfkEya4Nx4nEpZUQqXvCKciWuyHjTBM=;
        b=OvFFPtWLLLK8TOvX8IWsU/Uk/8SkiIsPQTpo2FVTXT8p48feeWN4/LIYQOQPe3T6nM
         mW0+wzwL+AC8lRtBNGM3MogMNAupMKgnsR0ou6DZh40rPoHJzV5bNxo4kA9Fp6SHzyTH
         RU8yqtSEvSTEE8ovL8kuAIP5zgyNcmuN5mRHPXsVKbaf3BGKZdWwSkmUoRVa8So+ikoQ
         6lIuckel2GAoq5V+kGORp6sneAwiYn/2SdLK3P7gmKwXs99obP24XAmOAAp2ss1ONT2a
         iHE2NPFxZPmNJh/WNv/ADomSh6AShhGrxeVRG11Xs7GlmeRNUqUtV5ZGgrInCJCm19Bs
         zjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502519; x=1715107319;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raUnGt98IcYzcfkEya4Nx4nEpZUQqXvCKciWuyHjTBM=;
        b=SdgdHweu1j+mjMDvrLNNTfWBNlPOBGLZO4LgNFRBiypvofE2vhic8njjCROlr3HM7S
         aAliAybmgTax/WHa35Htk8rPSKVCGuoe3wudWOyPR7Ok31RHtFKU5XXEiuGrX/xyxDp0
         SvGf92HwLmni3pupjxuU5O2b5moyN2v/FQxzUVzkEnmZKAwJG9xYSTGpjcnq7/RJZkbw
         iHHWaen9oqn+jwFStidxiSotMitcEHO3L4PyFj6WuyH/z9wuaxvFcQgMrGSoRpQLXDMq
         JoaqjbiqpPxIOPjcALgujhITsWys4prAMTCNO5I0OjtDHop2ZMNUOooWcivE81vYmwL2
         UXog==
X-Forwarded-Encrypted: i=1; AJvYcCWApp9jr5oj/siPv9NPVz3l8FNRQwAsnHqZbviQeF3gDT0eNHC5pdRsU7NvPgdIOqh2DRzuBs1VHE8XqGWTr/ZhVVHerRMoEuY27wrXJ5nYoA==
X-Gm-Message-State: AOJu0YxGI1IV6LYIjmXTSRCS2n3l1ZcdXH0/aMUSlWu91XoWyJzytboZ
	Y5oxjCIBgOjNsutqvGyBEBzcsk9Acwy5Kv7X6yqsYuf9aTPo+ZyIgceEc6X49ZBMcrpZUMbTWHJ
	vb3KF4Q==
X-Google-Smtp-Source: AGHT+IGTHT1sP7YaICYZuU4uWraHOYbZ2SgQw3ZkdDcqS4JSOBXL4Aj/lcZG9jZLqrosuWmv/kV9SKW3KO6u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:273c:4116:6850:f9d3])
 (user=irogers job=sendgmr) by 2002:a81:9206:0:b0:61b:3b02:6901 with SMTP id
 j6-20020a819206000000b0061b3b026901mr76250ywg.9.1714502519644; Tue, 30 Apr
 2024 11:41:59 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:41:56 -0700
Message-Id: <20240430184156.1824083-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v1] perf lock: More strdup argument freeing
From: Ian Rogers <irogers@google.com>
To: zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Leak sanitizer complains about the strdup-ed arguments not being
freed. rec_argv is reordered and duplicates inserted, meaning making
all its contents strdup-ed and freeing them all leads to double frees
or leaks. Add an extra array to track strup-ed arguments and free
them. This makes address sanitier running `perf test` "kernel lock
contention analysis test" memory leak free.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 44 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 230461280e45..26c059397cdf 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2230,10 +2230,11 @@ static int __cmd_record(int argc, const char **argv)
 	const char *callgraph_args[] = {
 		"--call-graph", "fp," __stringify(CONTENTION_STACK_DEPTH),
 	};
-	unsigned int rec_argc, i, j, ret;
+	unsigned int rec_argc, i, j, dups = 0, ret;
 	unsigned int nr_tracepoints;
 	unsigned int nr_callgraph_args = 0;
 	const char **rec_argv;
+	char **to_free;
 	bool has_lock_stat = true;
 
 	for (i = 0; i < ARRAY_SIZE(lock_tracepoints); i++) {
@@ -2270,28 +2271,25 @@ static int __cmd_record(int argc, const char **argv)
 	/* factor of 2 is for -e in front of each tracepoint */
 	rec_argc += 2 * nr_tracepoints;
 
-	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	rec_argv = calloc(rec_argc + 1, sizeof(*rec_argv));
 	if (!rec_argv)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = strdup(record_args[i]);
-
-	for (j = 0; j < nr_tracepoints; j++) {
-		const char *ev_name;
+	to_free = calloc(rec_argc, sizeof(*to_free));
+	if (!to_free)
+		return -ENOMEM;
 
-		if (has_lock_stat)
-			ev_name = strdup(lock_tracepoints[j].name);
-		else
-			ev_name = strdup(contention_tracepoints[j].name);
-
-		if (!ev_name) {
-			free(rec_argv);
-			return -ENOMEM;
-		}
 
+	for (i = 0; i < ARRAY_SIZE(record_args);) {
+		to_free[dups] = strdup(record_args[i]);
+		rec_argv[i++] = to_free[dups++];
+	}
+	for (j = 0; j < nr_tracepoints; j++) {
+		to_free[dups] = strdup(has_lock_stat
+				       ? lock_tracepoints[j].name
+				       : contention_tracepoints[j].name);
 		rec_argv[i++] = "-e";
-		rec_argv[i++] = ev_name;
+		rec_argv[i++] = to_free[dups++];
 	}
 
 	for (j = 0; j < nr_callgraph_args; j++, i++)
@@ -2302,7 +2300,17 @@ static int __cmd_record(int argc, const char **argv)
 
 	BUG_ON(i != rec_argc);
 
-	ret = cmd_record(i, rec_argv);
+	for (i = 0; i < dups; i++) {
+		if (to_free[i] == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	ret = cmd_record(rec_argc, rec_argv);
+out:
+	for (i = 0; i < dups; i++)
+		zfree(&to_free[i]);
+	free(to_free);
 	free(rec_argv);
 	return ret;
 }
-- 
2.45.0.rc0.197.gbae5840b3b-goog

