Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749683;
	b=InHtSY7oiSv+opYyUUsYi0MSuXQoONTDp20RDoYzA3iaVOwWQt4eeNWRHr6Wg1Wy8+M5
	 N4WwqZLA0XLJUlYVk2Ed6/g7iSw4vLQ7zh0eBdYkG4dmUaQ2oHfiITw4NYKSRD9245iI8
	 tuZ+KtW4IZq6ZWU4jmpTNmBxEcW2Pvaue7RSsMb+AxMp166j+EAyZ1FwZLgOFGhLA66UM
	 C/PfQ4MDW8kXcQ/AaMfVWS0SIF67AreoaAYi/cxpTu0D2RhoSxHkcdDz2gcEQw37XDJAc
	 5bAyb20TAPUb3d7Kjv7qvd5tlGK4BH8naEUUmV9BuIP0yFoUNZpI9WPBoBZ8yxYtcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749683;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Bf3cG1Ad2v877Q8nJ/DOk90awBgX1TrReReXcjhiSH8=;
	b=ubHZujsnkzphuu/FRJyFG2suiZDUQU1T+gD116LTsid4EipUgzYb5ui4yBXTuE1RW86t
	 2t8uN0ldUr4lESyAJVz3zP4x4H6uJQPIpJtkvoi0k0sIG5gvnYv+V8fcauMRmA+RtuJre
	 ZS4YVSOzC7NlU+hdxGRLEnTvXdOEC8RqfINeROOGDUpqJCxG44cTscIUEspg5RKuORZry
	 yXREY84E6umGRBlkxbWLQUAhnGPeHsW3G/DY1ynFksEBEgcWx72o1BMOsa9tI6MpJFdKC
	 aphr51mtmOutwrH0n+2hbgxxZn8/Cj7EmrjqVdyVegPrxfp/fBL0gWvA21bF+1jEwHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="n+F/sNo8";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253DD606A31E;
	Sun, 15 Nov 2026 13:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 253DD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n+F/sNo8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F4A81516;
	Sun, 15 Nov 2026 05:34:34 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4607E3F85F;
	Sun, 15 Nov 2026 05:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794749677; bh=9qF8KuRigZTxXtnIt2IzpIGy0m7VEPymZkDmjA90tXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n+F/sNo8GeSBtrvDdRAP2veqLaDnJY4krMWCFRJ3srpUpyn1ZXYNTIGx4BSEwF49i
	 KrPYZIsGXNVw7NQT8u3ewJFYL84S03Iw1XUez6h6whDGSFJDNxCOgjWWOXU7PakpMr
	 u2MhE3z4FXB+hS61fuqTT9I40v99M352M1lB2H6g=
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 15 Nov 2026 13:34:19 +0000
Subject: [PATCH 1/4] perf synthetic-events: Split oversized thread maps
 into records
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-perf_fix_large_threads-v1-1-69c9b86b9ae5@arm.com>
References: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
In-Reply-To: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794749674; l=4512;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=9qF8KuRigZTxXtnIt2IzpIGy0m7VEPymZkDmjA90tXs=;
 b=ul+1VHYjVvNGqBNU+jigEzJdcmIJfPDgQH/e1wgBjzt4EqWJlqPGCLUaqcpDtXQSrSdtX/uQ3
 s+tMdmddpT3ALWFWx2eKhUZKSkz/n9VTUudf6bDeQis9HABiLdg4NQ3
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

PERF_RECORD_THREAD_MAP has a 16-bit header.size field. With 16 bytes of
fixed fields and 24 bytes per entry, a record can hold at most 2,729
threads within the 65,535-byte size limit.

For larger maps, header.size overflows and no longer describes the
entries counted by nr, so readers reject the record.

Split larger maps into records that fit the size field. Set
PERF_RECORD_MISC_THREAD_MAP_MORE in header.misc when another record
follows, and clear it in the final record. Preserve entry order and the
existing encoding for maps that fit in one record, including empty maps.

Stop synthesis if allocation or the event callback fails.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/perf/include/perf/event.h |  8 +++++++
 tools/perf/util/synthetic-events.c  | 46 +++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index fdced574c889e503bda3cf2f8457a14026140025..1785fea2873e4c4dca369b9257626302cece11c0 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -406,6 +406,14 @@ struct perf_record_thread_map_entry {
 	char			 comm[16];
 };
 
+/*
+ * PERF_RECORD_MISC_THREAD_MAP_MORE means another THREAD_MAP record follows
+ * for the same map. A clear bit marks the final record.
+ * Each nr counts only that record's entries; concatenate records in order.
+ * A map fitting in one record has the bit clear.
+ */
+#define PERF_RECORD_MISC_THREAD_MAP_MORE (1U << 0)
+
 struct perf_record_thread_map {
 	struct perf_event_header		 header;
 	__u64					 nr;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3c8d29f27fd91a2cb5ddcf3a20664024edf697c7..938fb63473c479bda167acfe432e7a2d623c6ef0 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1332,16 +1332,18 @@ int perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
 	return perf_event__synthesize_extra_kmaps(tool, process, machine);
 }
 
-int perf_event__synthesize_thread_map2(const struct perf_tool *tool,
-				      struct perf_thread_map *threads,
-				      perf_event__handler_t process,
-				      struct machine *machine)
+static int __perf_event__synthesize_thread_map2(const struct perf_tool *tool,
+					       struct perf_thread_map *threads,
+					       perf_event__handler_t process,
+					       struct machine *machine,
+					       int offset, int nr)
 {
 	union perf_event *event;
-	int i, err, size;
+	int i, err;
+	size_t size;
 
 	size  = sizeof(event->thread_map);
-	size +=	threads->nr * sizeof(event->thread_map.entries[0]);
+	size += nr * sizeof(event->thread_map.entries[0]);
 
 	event = zalloc(size);
 	if (!event)
@@ -1349,16 +1351,18 @@ int perf_event__synthesize_thread_map2(const struct perf_tool *tool,
 
 	event->header.type = PERF_RECORD_THREAD_MAP;
 	event->header.size = size;
-	event->thread_map.nr = threads->nr;
+	event->header.misc = offset + nr < threads->nr ?
+			     PERF_RECORD_MISC_THREAD_MAP_MORE : 0;
+	event->thread_map.nr = nr;
 
-	for (i = 0; i < threads->nr; i++) {
+	for (i = 0; i < nr; i++) {
 		struct perf_record_thread_map_entry *entry = &event->thread_map.entries[i];
-		char *comm = perf_thread_map__comm(threads, i);
+		char *comm = perf_thread_map__comm(threads, offset + i);
 
 		if (!comm)
 			comm = (char *) "";
 
-		entry->pid = perf_thread_map__pid(threads, i);
+		entry->pid = perf_thread_map__pid(threads, offset + i);
 		strncpy((char *) &entry->comm, comm, sizeof(entry->comm));
 	}
 
@@ -1368,6 +1372,28 @@ int perf_event__synthesize_thread_map2(const struct perf_tool *tool,
 	return err;
 }
 
+int perf_event__synthesize_thread_map2(const struct perf_tool *tool,
+				      struct perf_thread_map *threads,
+				      perf_event__handler_t process,
+				      struct machine *machine)
+{
+	const int max_nr = (UINT16_MAX - sizeof(struct perf_record_thread_map)) /
+			   sizeof(struct perf_record_thread_map_entry);
+	int offset = 0;
+	int nr, err;
+
+	do {
+		nr = min(threads->nr - offset, max_nr);
+		err = __perf_event__synthesize_thread_map2(tool, threads, process, machine,
+							 offset, nr);
+		if (err)
+			return err;
+		offset += nr;
+	} while (offset < threads->nr);
+
+	return 0;
+}
+
 struct synthesize_cpu_map_data {
 	const struct perf_cpu_map *map;
 	int nr;

-- 
2.34.1

