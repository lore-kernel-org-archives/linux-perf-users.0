Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6F265288
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097260; cv=none; b=RcpCPJTf7A3lOSlmzUR4CbgEDqfZ1J6q8mfyznWmoE1IXWIFI0MgqS5auIXnJ+BS+w58Xb4sEXlqnxa9S+omsRNUD4MyABRUZSOixz3Rpa7SGsBLexQJqAtcjB8fzdZFrh9Hnyo7g/KJ7Eqa/+wmTyuHoaUtlF5JapLfTRU3OqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097260; c=relaxed/simple;
	bh=taguiAu+XCAIQfq0Yy35oTrHyGgNZ8BMVFBK/i0b2/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oBjaKA87uJG63GEyrk11EZZrpsd7wr45bImblQdrgHxnGUfrVwEz479sZ44dPR85z1Dbjnq8Ca7nmMnP5+dZ7VJjLbeEl+E3JnzpQOA3xaKsucLgjuXvVGnC9P1BRDSz0LoeW5Yn6Jnpy6Wze9ZNG+58pFjOesVf/tZtsg2EjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yixeryP8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yixeryP8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b39280167fdso274261a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097258; x=1752702058; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yn07du8/mYddRoeb96O+tFsLyXiFjIJK2Jw/FgUbdtQ=;
        b=yixeryP8KEElgnO/5DnaiqjdeQtzhRymHgTjENkdbpBZzNGkBimW1/iNNZEeJFbsoR
         LRICQT4YK36+rEuFFQtkhzsfI1pk1/jsmCLZbaw+e1WVj/YkXLARynsJjNVJZGKbDrHc
         mQzVuH42MwFUZ8ANUXfBNXYdiLOOkRJeOTQqJJzB6h9Tak0PvKjoWkS6tnwau/O3d7A1
         /2cFfgYMelORqntP2R6w1xeWb1Ea4zXh/mTWqDfKX1tfre5WDIP3LUFtdmOgWMN7qka3
         uEzlbVVIM8NHKvXtwMlm7fDbKUlsPY8L2ipojzedlSqGUrZkrohCBZUdW7js23w3qF9M
         +tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097258; x=1752702058;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn07du8/mYddRoeb96O+tFsLyXiFjIJK2Jw/FgUbdtQ=;
        b=KjVz1CwNwZduvUVRtzRSdG0Q3XcrlPWAlkIzjir0ghljNqRQB5f/X2Kh9jp+hved3M
         SRjb8vogxjslRJSwrrN1y0xYV3tVtKVwGcAizTrEd2Ru9hgoyX4bMPyXXx/qIJWAoPNC
         qerom6/AujzGN/YB72yJfKK2Sz5uP7rWhlpJ9orqqEEhhrGeXm5a0Z/QNm+wtxpSZNwI
         QmVBJTWnOlpbAS12LQKb9VrI/Eaq/Ma2EGIiKR6A3FrkdECUOcLwDHVWGQItqdHbjyvx
         i4sjpZvIPkY7xnTGlrw1A0W595RW9BOBlIjjKlnIqDX3xBvb+8MYgqwWGSoeDApyV/XY
         u1yw==
X-Forwarded-Encrypted: i=1; AJvYcCVFXS5k2FmLY9fwOdqfk49hUUG5+v1B4npirlAEt/yOhv4TbhuiivHgars5UmwY03MCy/HY8QQLWZ5cqsaBX4E3@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwzGtF07F3hckHXBuQXAq16tlcBf6484POa2ecmhmu3pbxy8Z
	u+oiXz8ycC4HC5D+IHeHd6/KBa52dTkzElftcJOUEBaB4vel9bVZ48UvuI4uCijYKNrDQVZm6+l
	Al6QdPvDBCg==
X-Google-Smtp-Source: AGHT+IFpZES2b6ONLtzlMFYm7NFl1lVqMzCjtuWVqhSi7IKE8r7O3xr8e2sxXbNipHUDbPKriS5aVIZ1HZ5Y
X-Received: from pjbsw6.prod.google.com ([2002:a17:90b:2c86:b0:313:245:8921])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:568e:b0:2ee:d371:3227
 with SMTP id 98e67ed59e1d1-31c2fdba404mr8152456a91.17.1752097258649; Wed, 09
 Jul 2025 14:40:58 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:29 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-13-irogers@google.com>
Subject: [PATCH v1 12/12] perf python: Improve leader copying from evlist
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The struct pyrf_evlist embeds the evlist requiring the copying from
things like parsed events. The copying logic handles the leader being
the event itself, but if the leader group event is a different in the
list it will cause an evsel to point to the evsel in the list that was
copied from which is bad. Fix this by adding another pass over the
evlist rewriting leaders, simplified by the introductin of two evlist
helpers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f689560192f4..ad2437d132f3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1568,6 +1568,32 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
 	return (PyObject *)pevsel;
 }
 
+static int evlist__leader_pos(struct evlist *evlist, struct evsel *leader)
+{
+	struct evsel *pos;
+	int idx = 0;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (leader == evsel__leader(pos))
+			return idx;
+		idx++;
+	}
+	return -1;
+}
+
+static struct evsel *evlist__at(struct evlist *evlist, int idx)
+{
+	struct evsel *pos;
+	int idx2 = 0;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (idx == idx2)
+			return pos;
+		idx++;
+	}
+	return NULL;
+}
+
 static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 {
 	struct pyrf_evlist *pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
@@ -1583,6 +1609,13 @@ static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 
 		evlist__add(&pevlist->evlist, &pevsel->evsel);
 	}
+	evlist__for_each_entry(&pevlist->evlist, pos) {
+		struct evsel *leader = evsel__leader(pos);
+		int idx = evlist__leader_pos(evlist, leader);
+
+		if (idx >= 0)
+			evsel__set_leader(pos, evlist__at(&pevlist->evlist, idx));
+	}
 	metricgroup__copy_metric_events(&pevlist->evlist, /*cgrp=*/NULL,
 					&pevlist->evlist.metric_events,
 					&evlist->metric_events);
-- 
2.50.0.727.gbf7dc18ff4-goog

