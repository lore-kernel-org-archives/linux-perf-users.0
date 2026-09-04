Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4A4AC15B;
	Fri,  4 Sep 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532886; cv=none; b=H5s/l4uc3TmT8fdZstEdHORV6rITMYUg4nFV1OghjLq9UN98xc0B+2GWk7Uo9Ou/5PoqeaVBn9nJZ1y+zPShZOrHBLNzEnpBCmrMhp2UNUj5Q/0jjADSny/8qzIp5FN7TfwgwEc5faPWYDpa1kwJIVxih+sBJit5Hxd/5Yz9EJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532886; c=relaxed/simple;
	bh=dPV7YYt+9jSQY38aHLmVpglkuVPvThHmR47SxszOGVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5c6IGZEey5WyfSybG9vxzHIHIKa0VKRdYTHa1cUv0uegU1X+sVCbZYdvPEpuBKOsdR1fu+H/CzFuZPq9dMXBbocbh4wRbL4Vfx4d129qcFMPkVFkF8QRC1rkUkTahZwdv7dhepw7pwIkQODmrYOHXONfnPVIqBuzgGAS8pfvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKtMykr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKtMykr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712EB1F00A3D;
	Fri,  4 Sep 2026 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532885;
	bh=83cGxc94L3/rpSSg6+7m8eJvyO9rx1qyIG+MvsR+ZdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKtMykr1ia1/vDczsT8nHKSKIThvTVBHGp1UUgwLvCOIwQDoBDRBoSDXal2BrvcVF
	 0xoAyuHPAQi3ttOuo1any5ApfymplUrbA8RCg9kAUPBx3oJQonwxbD3kXVLn2xl3dJ
	 ysfQ0tD8zeKHy3qqN9JDaGy85yBbjYqQwFOnYHONtxVTLpKJRP8SXCh3PhSrpUI3Mt
	 yyfH3wrdU6+6TGrd0+lxxQ61f3AtOgk57z//UYGQ18fXa8tl5lhutg3wm9rZLpugxL
	 mdKSXeehiM0CtdKXfjBIgWBzMV625vNzRhWIWHv9nwFOQ5OhxTnpu5IWbpUFuZu3Ef
	 2xa1BdaUSFjpg==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 4/5] perf jitdump: Write sample id fields in the order used by evsel__id_hdr_size()
Date: Fri,  4 Sep 2026 11:40:56 -0300
Message-ID: <20260904144058.3341-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904144058.3341-1-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_load() and jit_repipe_code_move() cast the sample id
area appended to the synthesized mmap2 record to a fixed:

	struct {
		u32 pid, tid;
		u64 time;
	};

and store the timestamp at offset 8 whenever PERF_SAMPLE_TIME is set.
That matches what evsel__id_hdr_size() accounts for only when
PERF_SAMPLE_TID is set as well: the fields are appended in a fixed
order, skipping the ones not requested by sample_type, so with
PERF_SAMPLE_TID unset PERF_SAMPLE_TIME starts at offset 0 and idr_size
is 8.

Storing the timestamp at offset 8 then lands 8 bytes past the end of
the id area, which for an event allocated as sizeof(*event) + idr_size
is past the end of the heap allocation, besides corrupting the record
the tooling reading it back expects.

Walk the id area in the order used by evsel__id_hdr_size(), advancing
past each field only when its sample_type bit is set, and keep the
computed timestamp in a local variable instead of reading it back from
the event buffer.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 64 +++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index efb40d93e33ae664..f8b937a95fe84573 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -472,10 +472,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	int ret, csize;
 	uint64_t usize;
 	pid_t nspid, pid, tid;
-	struct {
-		u32 pid, tid;
-		u64 time;
-	} *id;
+	uint64_t timestamp = 0;
+	unsigned long id;
 
 	nspid = jr->load.pid;
 	pid   = jr_entry_pid(jd, jr);
@@ -561,13 +559,27 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	event->mmap2.flags = MAP_SHARED;
 	event->mmap2.ino_generation = 1;
 
-	id = (void *)((unsigned long)event + event->mmap.header.size - idr_size);
+	/*
+	 * The sample id fields are appended in the order accounted for by
+	 * evsel__id_hdr_size(), skipping the ones not requested in
+	 * sample_type, so they cannot be written through a fixed struct:
+	 * with PERF_SAMPLE_TID unset, PERF_SAMPLE_TIME starts at offset 0
+	 * and idr_size is 8, so storing it at offset 8 runs past the end of
+	 * the event allocation.
+	 */
+	id = (unsigned long)event + event->mmap.header.size - idr_size;
 	if (jd->sample_type & PERF_SAMPLE_TID) {
-		id->pid  = pid;
-		id->tid  = tid;
+		struct { u32 pid, tid; } *id_tid = (void *)id;
+
+		id_tid->pid = pid;
+		id_tid->tid = tid;
+		id += sizeof(u64);
+	}
+	if (jd->sample_type & PERF_SAMPLE_TIME) {
+		timestamp = convert_timestamp(jd, jr->load.p.timestamp);
+		*(u64 *)id = timestamp;
+		id += sizeof(u64);
 	}
-	if (jd->sample_type & PERF_SAMPLE_TIME)
-		id->time = convert_timestamp(jd, jr->load.p.timestamp);
 
 	/*
 	 * create pseudo sample to induce dso hit increment
@@ -577,7 +589,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	sample.cpumode = PERF_RECORD_MISC_USER;
 	sample.pid  = pid;
 	sample.tid  = tid;
-	sample.time = id->time;
+	sample.time = timestamp;
 	sample.ip   = addr;
 
 	ret = perf_event__process_mmap2(tool, event, &sample, jd->machine);
@@ -624,10 +636,8 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	u16 idr_size;
 	int ret;
 	pid_t nspid, pid, tid;
-	struct {
-		u32 pid, tid;
-		u64 time;
-	} *id;
+	uint64_t timestamp = 0;
+	unsigned long id;
 
 	nspid = jr->load.pid;
 	pid   = jr_entry_pid(jd, jr);
@@ -675,13 +685,27 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	event->mmap2.flags = MAP_SHARED;
 	event->mmap2.ino_generation = 1;
 
-	id = (void *)((unsigned long)event + event->mmap.header.size - idr_size);
+	/*
+	 * The sample id fields are appended in the order accounted for by
+	 * evsel__id_hdr_size(), skipping the ones not requested in
+	 * sample_type, so they cannot be written through a fixed struct:
+	 * with PERF_SAMPLE_TID unset, PERF_SAMPLE_TIME starts at offset 0
+	 * and idr_size is 8, so storing it at offset 8 runs past the end of
+	 * the event allocation.
+	 */
+	id = (unsigned long)event + event->mmap.header.size - idr_size;
 	if (jd->sample_type & PERF_SAMPLE_TID) {
-		id->pid  = pid;
-		id->tid  = tid;
+		struct { u32 pid, tid; } *id_tid = (void *)id;
+
+		id_tid->pid = pid;
+		id_tid->tid = tid;
+		id += sizeof(u64);
+	}
+	if (jd->sample_type & PERF_SAMPLE_TIME) {
+		timestamp = convert_timestamp(jd, jr->load.p.timestamp);
+		*(u64 *)id = timestamp;
+		id += sizeof(u64);
 	}
-	if (jd->sample_type & PERF_SAMPLE_TIME)
-		id->time = convert_timestamp(jd, jr->load.p.timestamp);
 
 	/*
 	 * create pseudo sample to induce dso hit increment
@@ -691,7 +715,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	sample.cpumode = PERF_RECORD_MISC_USER;
 	sample.pid  = pid;
 	sample.tid  = tid;
-	sample.time = id->time;
+	sample.time = timestamp;
 	sample.ip   = jr->move.new_code_addr;
 
 	ret = perf_event__process_mmap2(tool, event, &sample, jd->machine);
-- 
2.55.0

