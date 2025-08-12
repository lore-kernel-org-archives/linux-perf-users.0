Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8A2D836A;
	Tue, 12 Aug 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989200; cv=none; b=RBWyj5dowmm+CKmova7UvRh7Zr71i24N5QuEThRH8R29bOuKZOcamWQVSCZAX/uxmAqAUGeVplpLlpVDWkdzoNY6yTGH5Ij8Wo6Ntr8DMJC9GJhr+kxXvlGBn2zIyVgLUo95X/gwasJ6ziZxxRVXt1txa3mmo9DT48fJBThqiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989200; c=relaxed/simple;
	bh=lCUCcWSajSHBubbvz3TpoXdgIFsupR6n4qNsl6f5xy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjWVQWFZvJPgnc8PJ8rffb3RJg/3TYP6CmHHVtNAbwLPqjwPiCmWuT/2s3DRt4bW2g8E7paevBDlLvKm/bCNO21NutA741zJJqn55seLfpYP8c+bPhSY7dIy9ClTOJUFy0IS5ueTAg5eps7/mJLjtde6H8EK4fDT9/LJaoPRrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b30a0af6775a11f0b29709d653e92f7d-20250812
X-CID-CACHE: Type:Local,Time:202508121650+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:006c181b-e2b3-4d48-aa88-aa662b726859,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:ba2f0da70cf20a38ff9c9c8b6094ec8f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b30a0af6775a11f0b29709d653e92f7d-20250812
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 375932857; Tue, 12 Aug 2025 16:59:48 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 0C83AB8258E7;
	Tue, 12 Aug 2025 16:59:48 +0800 (CST)
X-ns-mid: postfix-689B0283-820907551
Received: from localhost.localdomain (unknown [10.42.12.87])
	by node2.com.cn (NSMail) with ESMTPA id 21158B812916;
	Tue, 12 Aug 2025 08:59:44 +0000 (UTC)
From: zhaoguohan@kylinos.cn
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thomas.falcon@intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] perf parse-events: Fix potential null pointer dereference in __add_event()
Date: Tue, 12 Aug 2025 16:59:41 +0800
Message-ID: <20250812085941.19982-1-zhaoguohan@kylinos.cn>
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

Add a null check before accessing evsel members in the error path.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 tools/perf/util/parse-events.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
index 8282ddf68b98..251f1b31b62f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -313,9 +313,13 @@ __add_event(struct list_head *list, int *idx,
 out_err:
 	perf_cpu_map__put(cpus);
 	perf_cpu_map__put(pmu_cpus);
-	zfree(&evsel->name);
-	zfree(&evsel->metric_id);
-	free(evsel);
+
+	if (evsel) {
+		zfree(&evsel->name);
+		zfree(&evsel->metric_id);
+		free(evsel);
+	}
+
 	return NULL;
 }
=20
--=20
2.43.0

