Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942D2355038
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057163; cv=none; b=ny9maPOQU1ac6JwMpk4XSjBdvbMMKwpszkj3MYd1zn+X8RsKxg1KgSaZRm2nP2VJFz2UlIIDYQu37mkT6y1k2vaILThj8UuNCil/mrV8aYyLPpOman5MTBBPY/+5UixurAS88Ce+VhP1m0cH/78+73I/oftqPXhUv3s6hSCoPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057163; c=relaxed/simple;
	bh=VSPi5b0FYSjK9jbjwqv1ISG3u2SRPYT3qLyoAV5ofDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=G70ZG8thum6k9p7JxGWCDRV0jprWohu9fZKN4PZeWT0PsAeII3+Od6oUF6/TFiRgXxDQGzhyLskJOhHORSdftpEKU0K0U0ml3puE0ssSTGYJs4Y50Dw5RkQSrHcF7WlUcO1v5Uviue1UQhbQy+I3LbMhyVqEXCmMLvDOqtyPfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A49xG5wy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A49xG5wy"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b63038a6350so1746905a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057161; x=1763661961; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHUlYvYVsoqcUvPe52eoqpv7ujyDyUuBEdGEz9LzsdQ=;
        b=A49xG5wyyAJoZ5PngxBlKud/0zta7tUNjx7qGEAKodIT7wmBEDzFuxkdx3MkcpoQkj
         Bg4abRtUjy7DZGvjNvdN9udPDaxv2ugJ9DSVglLCEeeCfHSHYsFGXtfeV4iH1wX0zpIR
         RXqfC44HG/dOByp8Z1R9zROGOboSoQ2GqXgETlPN8pi/wX4EjN23p0/MCafOAXxB9oB4
         xfMsdINbfp6si0iiktSriWS4Dp5sASdgwyOlQuNoH+eU4ZubwS+HRfUHe/SbyCSOK221
         qDpzbU1c4BD4+XIzsclj/Cvnjg44eHUsdouyMsZgk6QB5iiWfGFs10isiWSfIlTyeKVc
         Em0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057161; x=1763661961;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHUlYvYVsoqcUvPe52eoqpv7ujyDyUuBEdGEz9LzsdQ=;
        b=FQthN0G2P38NWWYwUQyd32JRGCLZs/hT16g54vSFbehSMr29kfD9tg4slunqMG277+
         9hYYR+rd81SO/1v2TQWZ5e8Kkryk9nxEEjbkQmaPn9o4S9aNUC6xwayMKRNvAt2ygYJ+
         +naoAEECbhhxk02sTbYOIup89QaZfWJGBYteofT0DXINZLFa82/86Hq16t4tt0z9PsOS
         75/9j60t4VovgjMm657sZK7n5LzPHup1p/g4QlrXsjWuoHZAiGOIjHWDAA6OCkzbhZBS
         NyVH7ZfNwspUmhj+hrX9O8igeb9Xsy7Coct07QRbrCNJ1PHxbsfXfNXYTBXUjyMeeiZb
         kjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU27MZx1G7mCPm2sHqaJ3/gj8VNn2fIuTOhYtG/bpp++OAYsVmb7OUIdTe2WFgTiQ/BddoMv0KTNOrEq/RpwbCd@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJBckSlFFyTVdIP98yorBCBSyjrQFYXeYOXGnJejDec/Y8vKJ
	mX587J5PXq3f2YbDUpohKqK7RYsN0DULbfVcYY6T/t04Zjd58bqG7rHD1Y6TUGdFAozQLv3SRcp
	n9bOHfHYREw==
X-Google-Smtp-Source: AGHT+IFQJGwfEwwbqk/yBlpxj/IRuM1bsBxCbxuEgwiTito2SNi2QtdAhaXaZUrQ0UBVURt+znfpgQ3dcomE
X-Received: from dlbrd6.prod.google.com ([2002:a05:7022:f106:b0:119:9f33:34aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2912:b0:119:e569:f86c
 with SMTP id a92af1059eb24-11b40fa9495mr105517c88.9.1763057160835; Thu, 13
 Nov 2025 10:06:00 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:15 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-10-irogers@google.com>
Subject: [PATCH v4 09/10] perf stat: Read tool events last
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When reading a metric like memory bandwidth on multiple sockets, the
additional sockets will be on CPUS > 0. Because of the affinity
reading, the counters are read on CPU 0 along with the time, then the
later sockets are read. This can lead to the later sockets having a
bandwidth larger than is possible for the period of time. To avoid
this moving the reading of tool events to occur after all other events
are read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 29 ++++++++++++++++++++++++++++-
 tools/perf/util/evlist.c  |  4 ----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 947f11b8b106..aec93b91fd11 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -379,6 +379,9 @@ static int read_counters_with_affinity(void)
 		if (evsel__is_bpf(counter))
 			continue;
 
+		if (evsel__is_tool(counter))
+			continue;
+
 		if (!counter->err)
 			counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
 	}
@@ -402,6 +405,24 @@ static int read_bpf_map_counters(void)
 	return 0;
 }
 
+static int read_tool_counters(void)
+{
+	struct evsel *counter;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		int idx;
+
+		if (!evsel__is_tool(counter))
+			continue;
+
+		perf_cpu_map__for_each_idx(idx, counter->core.cpus) {
+			if (!counter->err)
+				counter->err = read_counter_cpu(counter, idx);
+		}
+	}
+	return 0;
+}
+
 static int read_counters(void)
 {
 	int ret;
@@ -415,7 +436,13 @@ static int read_counters(void)
 		return ret;
 
 	// Read non-BPF and non-tool counters next.
-	return read_counters_with_affinity();
+	ret = read_counters_with_affinity();
+	if (ret)
+		return ret;
+
+	// Read the tool counters last. This way the duration_time counter
+	// should always be greater than any other counter's enabled time.
+	return read_tool_counters();
 }
 
 static void process_counters(void)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b6df81b8a236..fc3dae7cdfca 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -368,10 +368,6 @@ static bool evlist__use_affinity(struct evlist *evlist)
 	struct perf_cpu_map *used_cpus = NULL;
 	bool ret = false;
 
-	/*
-	 * With perf record core.user_requested_cpus is usually NULL.
-	 * Use the old method to handle this for now.
-	 */
 	if (!evlist->core.user_requested_cpus ||
 	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
 		return false;
-- 
2.51.2.1041.gc1ab5b90ca-goog

