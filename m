Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EFB3CCF2
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAtV+NBS"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C171170B
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da05b786f1dso667749276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186282; x=1698791082; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a57oV/e0Ni3jLZTf3mm6h3wI1Kphc9bMaGQTthj78GI=;
        b=lAtV+NBSe+UpA5Rr+Qd3pgNNsrTd3pDBkC2VnSTgUeHV+/WWSNMzgqe+hFljO5X3Xe
         OW+vvhGQnJNm4LaVzIjI7Mlg1SDO/g6gUfX4HKCffk2z6HJ+26ZvARpkL3E+8ZHfEiRQ
         p4rx+J3d+OOBZnyPb4c6C1dmCCQInCcRR5niZhlW3zmENUqwYtFwfHrtPghdVmE5ViZD
         /OYXinPQu9CTdOApQBa9RBJx97eEE4TJiizBdQRj7eIwZO2UHpilM+OauJBRMUvxVxYt
         oeej7fuVOb+dKVoIcE/v1jPDbO8BUU2XBfNY5t1J5vouR/+WumYlOvgYAyAYc4ztMILH
         0YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186282; x=1698791082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a57oV/e0Ni3jLZTf3mm6h3wI1Kphc9bMaGQTthj78GI=;
        b=sgXWNm9iVbLx8t4AEnNvxqVJ3XzkxM4JSrSYsBYgJvi6TF3BQfCGAjZLsnEkRZhPmH
         9ZtTHP9UUeP15rvV0MFADcuDR8rCsslX+BNw7/UQ26NZOkKdv5lrvT7Pp6EX+dN7ToeD
         o3m4R/U258Pj1EHJPp709CJ93x3ReHJEJIsrN+S3RQWRAY7Et3aKDE4pVxJgq1l2zqTP
         SFNyYa2aTSloRP3nF8SGFMQo2PDmbidKHjZZGiUVuvFg7pjuG2qyFKBKM+i4DVEGPhcK
         kqY1kcUtBW0qV6egsICraMmkpB2rBCKgSx1LTOMxjujuTIRWatbJIon+yKkog4t3cJlK
         uHPw==
X-Gm-Message-State: AOJu0Yzz7kYqlFTVhUpPz0qW1xPLYdMwbqNJBjdkx0WOElyBKY+l+/1O
	Nt6T3eWP75c7BQsNIuZex3HvO6Bqcmcw
X-Google-Smtp-Source: AGHT+IEPkOL25RHk8bVRtyjdwz3hrjdxp1tqKTyWX0JQPAMbJoqhJ5b/EnMNMB5cIk3AOTLJjQOWC+0bE/sd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:4f4c:961b with SMTP
 id v3-20020a056902108300b00d9a4f4c961bmr353600ybu.1.1698186282072; Tue, 24
 Oct 2023 15:24:42 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:16 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 13/50] libperf: Lazily allocate mmap event copy
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The event copy in the mmap is used to have storage to a read
event. Not all users of mmaps read the events, such as perf record, so
switch the allocation to being on first read rather than being
embedded within the perf_mmap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/mmap.h | 2 +-
 tools/lib/perf/mmap.c                  | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index 5a062af8e9d8..b11aaf5ed645 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -33,7 +33,7 @@ struct perf_mmap {
 	bool			 overwrite;
 	u64			 flush;
 	libperf_unmap_cb_t	 unmap_cb;
-	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void			*event_copy;
 	struct perf_mmap	*next;
 };
 
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 2184814b37dd..91ae46aac378 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	free(map->event_copy);
+	map->event_copy = NULL;
 	if (map && map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 			unsigned int len = min(sizeof(*event), size), cpy;
 			void *dst = map->event_copy;
 
+			if (!dst) {
+				dst = malloc(PERF_SAMPLE_MAX_SIZE);
+				if (!dst)
+					return NULL;
+				map->event_copy = dst;
+			}
+
 			do {
 				cpy = min(map->mask + 1 - (offset & map->mask), len);
 				memcpy(dst, &data[offset & map->mask], cpy);
-- 
2.42.0.758.gaed0368e0e-goog

