Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157346;
	b=o5GGCxGaZtC4QQwuOTVRnuIXWLsmJ6qkVPu2dymbuBYLPRuMCxb2Y6GOzzB6MUGs+Grl
	 8sobGJDcmmFmJWWqGCQwHptJxVamyJgcetf/KsV0OpTax+Dok4xWrFvNxQv6s83UCsF2e
	 uDoqgU3eQhLTXjt9CyXwGSOf9BYhdDVoxvrV/1nEHHuuzS4iA+4/vWFq0ztpznroOrzQN
	 stI8JiKXib9fA8xI4zXmgEEj4ZyCUYON8/QCCJ4btyHCLsP3KZPMYKDW3dZF90Os0qAYk
	 kZtQrOfzhQBZ5DkjzIHhfa0QfDOffqHU7pGYT8fhyufRrH0WlR77HM3iW7SlZTSjyVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157346;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p2wxdWfQRPwOOeRcWpTD+nV5bhErhHOdlukDELG/7Eo=;
	b=WgBYxiPok6gSDHH/Yqi2uzdyDWUC0rMzvKeMaKQ4G0/zpOlMPLnGTb+atfRPr1MofoX/
	 QkcGXzf65QLrxhcCBS/rxgLi99OBoMZ9IhVYsQ2Dng3NJ4kkntPsoDi5q5kGZzdNG26KJ
	 ob49z/rgiW5L/pUjgIF4zdOpxAIM9zVhWi3Q3UTvVhxqu0uDQ0Q7iLhlZesb6L+YS3rye
	 94uYlM6fRjWmvk7wne/L0BzuyFvVtGFv5YglHIgKPCccXCa+7uXmtxjnFgN6xbAeKGNPX
	 M+FgecxqK7XxAUsKKHQokXCFIWSqKKdqP2mU942PzK70RteKj279nx/lVO0OHUd1sZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JrLoKZ5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25083606A325;
	Fri, 20 Nov 2026 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrLoKZ5/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795157346;
	b=QLS47mhJWJUDNCJYLJjI/vGJAkjnIMZi0/3/loMXjp4ald5I3OJ+5j39PlTVxFT9u4jn
	 OUeclKXrQlFe76mJoVDNmd/RD7w7gPbVIt/2aYTAvXi6cvSSMg5rRQ+sBrkrgSuHCstwT
	 4xssEnYi86YkhZI4W8zFV9TtdNZmsEGmUQfvTwFBLZFI3xIEXete5itB8VSl3uApVZzhw
	 D2pQMrfh0c12OzCy1loLb3Gmw1ZtlVzO41CmfW9D/Vpp0ajVDvwqnlViyV+mRV3Gs5kr6
	 t5sZkiGKWmnhvoWd822pfOgvlWR5EQXzlHMyr06skY5f6LggmuUi+4LKdZpRUmJQ+gg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795157346;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p2wxdWfQRPwOOeRcWpTD+nV5bhErhHOdlukDELG/7Eo=;
	b=FQDvANm22iV3Y4IF7KPHPinaS9dAmzKsrAdlWsjrylHKv5H17wwoep+42ww/2jnEA092
	 1fSGnZqoSQB5SnysuoDS9Ti71PGuAbLrnSY9wkffony6N04rzAtzMp+13gmiio5aYzlBy
	 saiZX2LudaQfIxYpPpuC5I0UxbkLrkkLgHplYhBDkxHYJw1RmzYWPnQ08KaWxf4tMpxjc
	 aJNOVne5br+zFi5EZWCIB1INuNSz/4ItM+3kPLDUHOWwco+2QIaQRtyKXc0wSSWFJmAro
	 iPA1GUrtFF1ReEQojkAoz2J0ifGf90FdbsNnBzERakLBfPY9skA1RRITCCtpbJqYhbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 688131F000CA;
	Fri, 20 Nov 2026 06:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157346;
	bh=p2wxdWfQRPwOOeRcWpTD+nV5bhErhHOdlukDELG/7Eo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=JrLoKZ5/o4cm3sVjT1tfiNNm207C/m+YpxQV6f8C0PpgXgjp6I2EU9L2io+tFBYLT
	 ZHRambkDa7DF1mtochqvvnvA20Q1ljPoDqdvwjQK73eM7f+wPsdNyN82rZPbbx2Lza
	 KFQUB8Te9EgZCIMDTYwVfpqa6+tvpdbnJ8CdnjwbAujz84cQptDAyIo1uavL3Vw0wT
	 pnXwMjQZhFlc3SUU2ATdwGsgtSmxeUshXDKBSebASHnW/Sn6Ta1HucQ8FG7q2FTA9N
	 1Fic3pbS6hxpuCHJHoAesCzU5h0fYiIVoEXL3H9cm3oEvSbigyJ3tGlK5vgAm/ktYa
	 cb/lkERhnN8uA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DA02149716;
	Fri, 20 Nov 2026 06:49:04 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 14:49:03 +0800
Subject: [PATCH] perf bpf_counter: Say why the perf_event_attr map can't be
 used
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
Message-Id: <20261120-bperf-attr-map-err-v1-1-b12b6b550273@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5EQBBG4atIrVWii2DmKmLR+FELplMtIhF3n
 47lt3jvpghTRPpmNxlOjfrbE1ye0bj6fQHrlExSSO2cFDwE2Mz+OIw3HxhmjLGWCh8pG9dSCoN
 h1uuddv3z/AG2fGcHZAAAAA==
X-Change-ID: 20261120-bperf-attr-map-err-ec624e923718
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795157344; l=4816;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=/BeuvCd1wLwgIc3E/XpIpzlI8yVjVaz/WrSOtWJ0nnU=;
 b=OoXQjlM4BOmBEPuwn3m+2/Mj+JD9xxGDX15QF4y/669yIuZ/YlxTnbBf44kvC/mUJiTC1sYZd
 p4d1X9p4uOhD4f9k525o+No+WHrU2JUoVtCku+BrZosq9mQC1j2ubbr
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

When 'perf stat --bpf-counters' can't set up the pinned map it uses to
share counters, all it prints is:

  Failed to lock perf_event_attr map

Arnaldo asked for better wording when bperf was added.  The map can
fail to be created, pinned, opened, checked or locked, and the message
says neither which step failed nor why.

Print the path and the error at each step, keeping the pin error
across the "pinned in parallel" retry.  When the pin fails because the
directory isn't on bpffs, say so, as libbpf's check_path() does.  The
caller's message is now redundant, so remove it.

As a normal user:

  Failed to create perf_event_attr map: Operation not permitted

As root, with bpffs not mounted:

  Failed to pin perf_event_attr map at /sys/fs/bpf/perf_attr_map: No such file or directory
  bpffs is not mounted at /sys/fs/bpf, try 'mount -t bpf bpf /sys/fs/bpf' or use --bpf-attr-map

Link: https://lore.kernel.org/all/YFneUHDiAt8Rg0cc@kernel.org/
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
Tested on perf-tools-next (bb27ddbaee56): each failure path as root in
a KVM guest and as a normal user, 8 concurrent runs with bpffs mounted
(no new output), and the bperf perf tests (no change).

The patch, this text and the tests were written and run with Claude
Code; I reproduced the issue and reviewed the change.
---
 tools/perf/util/bpf_counter.c | 45 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 9362e45e17ce..9a463eb9d51d 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -3,11 +3,13 @@
 /* Copyright (c) 2019 Facebook */
 
 #include <assert.h>
+#include <libgen.h>
 #include <limits.h>
 #include <unistd.h>
 #include <sys/file.h>
 #include <sys/resource.h>
 #include <sys/time.h>
+#include <sys/vfs.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/zalloc.h>
@@ -32,6 +34,10 @@
 #include "bpf_skel/bperf_leader.skel.h"
 #include "bpf_skel/bperf_follower.skel.h"
 
+#ifndef BPF_FS_MAGIC
+#define BPF_FS_MAGIC 0xcafe4a11
+#endif
+
 struct bpf_counter {
 	void *skel;
 	struct list_head list;
@@ -376,6 +382,24 @@ static bool bperf_attr_map_compatible(int attr_map_fd)
 		(map_info.value_size == sizeof(struct perf_event_attr_map_entry));
 }
 
+/* bpf_obj_pin() only works on bpffs: say so if that is why it failed. */
+static void bperf_pin_hint(struct target *target, const char *path)
+{
+	char buf[PATH_MAX];
+	struct statfs st;
+	const char *dir;
+
+	scnprintf(buf, sizeof(buf), "%s", path);
+	dir = dirname(buf);
+	if (statfs(dir, &st) || st.f_type == BPF_FS_MAGIC)
+		return;
+	if (target->attr_map)
+		pr_err("--bpf-attr-map: %s is not on bpffs\n", dir);
+	else
+		pr_err("bpffs is not mounted at %s, try 'mount -t bpf bpf %s' or use --bpf-attr-map\n",
+		       dir, dir);
+}
+
 static int bperf_lock_attr_map(struct target *target)
 {
 	char path[PATH_MAX];
@@ -393,30 +417,41 @@ static int bperf_lock_attr_map(struct target *target)
 					sizeof(struct perf_event_attr),
 					sizeof(struct perf_event_attr_map_entry),
 					ATTR_MAP_SIZE, NULL);
-		if (map_fd < 0)
+		if (map_fd < 0) {
+			pr_err("Failed to create perf_event_attr map: %m\n");
 			return -1;
+		}
 
 		err = bpf_obj_pin(map_fd, path);
 		if (err) {
 			/* someone pinned the map in parallel? */
 			close(map_fd);
 			map_fd = bpf_obj_get(path);
-			if (map_fd < 0)
+			if (map_fd < 0) {
+				/* report the pin error, not the bpf_obj_get() one */
+				errno = -err;
+				pr_err("Failed to pin perf_event_attr map at %s: %m\n", path);
+				bperf_pin_hint(target, path);
 				return -1;
+			}
 		}
 	} else {
 		map_fd = bpf_obj_get(path);
-		if (map_fd < 0)
+		if (map_fd < 0) {
+			pr_err("Failed to open perf_event_attr map at %s: %m\n", path);
 			return -1;
+		}
 	}
 
 	if (!bperf_attr_map_compatible(map_fd)) {
+		pr_err("%s is not a perf_event_attr map this perf can use\n", path);
 		close(map_fd);
 		return -1;
 
 	}
 	err = flock(map_fd, LOCK_EX);
 	if (err) {
+		pr_err("Failed to lock %s: %m\n", path);
 		close(map_fd);
 		return -1;
 	}
@@ -550,10 +585,8 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	 * map.
 	 */
 	attr_map_fd = bperf_lock_attr_map(target);
-	if (attr_map_fd < 0) {
-		pr_err("Failed to lock perf_event_attr map\n");
+	if (attr_map_fd < 0)
 		return -1;
-	}
 
 	err = bpf_map_lookup_elem(attr_map_fd, &evsel->core.attr, &entry);
 	if (err) {

---
base-commit: bb27ddbaee56536fb8df0a24f07b526766dfe131
change-id: 20261120-bperf-attr-map-err-ec624e923718

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


