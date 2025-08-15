Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC061219EB;
	Fri, 15 Aug 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242440; cv=none; b=PMWy/Kj2u6fb5myxm8I0w+oZJ8QzgKbYIG/eXbtQgGfDkvxeRKYBstcJr2iyCnhmHNzb+R62ljG+wfw00elY5ldxkX8O/1Cof4eB0DL8EKnBHbd1ogV2GkAKf0BnM24bACg7eM49ZxWENhAOO03+krc7q7KEm+KwdEw36dNNZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242440; c=relaxed/simple;
	bh=LJ5hwcVtv8L4QJbMAkLE+n3yrJ6SMbNWpVFjDzuDzAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kU3W2VVH0SipnG7GGD85RPHklH9G2fH5EXVFVIJ0bKi+Gcsawm7d/DKYiGh5qiLDA+1Gb+4cUfbvGM29VZCfhSzqZZ2RSExynxN7BCjLOSWnMHLNbIaReaBMuvxAg0CSjpCDIaNWqLJjj5UnWVr9hZiveSlx5yt4BnAaK5dTTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5395d6ae79a811f0b29709d653e92f7d-20250815
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:612345b8-8f28-4ac7-88c9-7afc108cde8f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:8d7f38ea3075bad0b42d9549ab5de2cc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5395d6ae79a811f0b29709d653e92f7d-20250815
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1737500474; Fri, 15 Aug 2025 15:20:31 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id F3E90B8258E7;
	Fri, 15 Aug 2025 15:20:30 +0800 (CST)
X-ns-mid: postfix-689EDFBE-875798283
Received: from localhost.localdomain (unknown [10.42.12.87])
	by node2.com.cn (NSMail) with ESMTPA id BD49CB812916;
	Fri, 15 Aug 2025 07:20:28 +0000 (UTC)
From: zhaoguohan@kylinos.cn
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH v2] perf parse-events: Prevent null pointer dereference in __add_event()
Date: Fri, 15 Aug 2025 15:20:08 +0800
Message-ID: <20250815072008.20214-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

In the error handling path of __add_event(), if evsel__new_idx() fails
and returns NULL, the subsequent calls to zfree(&evsel->name) and
zfree(&evsel->metric_id) will cause null pointer dereference.

Extend the goto chain to properly handle the case where evsel allocation
fails, avoiding unnecessary cleanup operations on a NULL pointer.

Fixes: cd63c2216825 ("perf parse-events: Minor __add_event refactoring")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Changes in V2:
- Extended the goto chain with separate error handling labels instead of =
using null pointer check
- Reordered jump targets to avoid accessing NULL evsel members
- Added Fixes tag
- Updated commit subject to use "Prevent" instead of "Fix"
---
 tools/perf/util/parse-events.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
index 8282ddf68b98..8a1fc5d024bf 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -277,18 +277,18 @@ __add_event(struct list_head *list, int *idx,
=20
 	evsel =3D evsel__new_idx(attr, *idx);
 	if (!evsel)
-		goto out_err;
+		goto out_free_cpus;
=20
 	if (name) {
 		evsel->name =3D strdup(name);
 		if (!evsel->name)
-			goto out_err;
+			goto out_free_evsel;
 	}
=20
 	if (metric_id) {
 		evsel->metric_id =3D strdup(metric_id);
 		if (!evsel->metric_id)
-			goto out_err;
+			goto out_free_evsel;
 	}
=20
 	(*idx)++;
@@ -310,12 +310,15 @@ __add_event(struct list_head *list, int *idx,
 		evsel__warn_user_requested_cpus(evsel, user_cpus);
=20
 	return evsel;
-out_err:
-	perf_cpu_map__put(cpus);
-	perf_cpu_map__put(pmu_cpus);
+
+out_free_evsel:
 	zfree(&evsel->name);
 	zfree(&evsel->metric_id);
 	free(evsel);
+out_free_cpus:
+	perf_cpu_map__put(cpus);
+	perf_cpu_map__put(pmu_cpus);
+
 	return NULL;
 }
=20
--=20
2.43.0

