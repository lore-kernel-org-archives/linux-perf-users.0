Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332D22A4F8;
	Mon,  8 Sep 2025 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757310305; cv=none; b=eNRGEBMLK3cwjKfYJLh8vmly2mUFVBqv91tONJkJEh6GcrVyuRtMLr4TxPvFagRzXTKwOXCEuJ/9j5MYVZAbVBcFHoa5I9JcC1ZCJMTfdMPSX8jgccJ/tXtyW9rtMOSIcp6j2qkzJH4tZZJ3RfOG0kvz84k2zOZa0zEIGP2YA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757310305; c=relaxed/simple;
	bh=46QfxNvcMaVLJWFUVGJoCw0SJDEAg3joG8eGL4C3XbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpvR4wbR24XjvwdKtPOVI8dYZ9rZRO1FeQzT8UoI3ecmZOKNoakyafLUYp1lN4/lrVbuF+c7AO56Kwk/FJCBEFKMFJcbiE0xLJAt0IKf7s4OJpS/y9rV08K98LCiDnJxgvm8L6aeBrzmfH06LChE4ciAhN9Hmnn22nHmaqyAvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f29ec5f48c7611f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:87719e05-7388-4ee9-9957-0e9a2dbe195e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:5cf66c1cfea8ac1b3975b87ae49a54c8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f29ec5f48c7611f0b29709d653e92f7d-20250908
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 198666652; Mon, 08 Sep 2025 13:44:55 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 10BC9B8258E6;
	Mon,  8 Sep 2025 13:44:55 +0800 (CST)
X-ns-mid: postfix-68BE6D56-94635319
Received: from localhost.localdomain (unknown [10.42.12.87])
	by node2.com.cn (NSMail) with ESMTPA id 008F0B812916;
	Mon,  8 Sep 2025 05:44:51 +0000 (UTC)
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
	GuoHan Zhao <zhaoguohan@kylinos.cn>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v3] perf parse-events: Prevent null pointer dereference in __add_event()
Date: Mon,  8 Sep 2025 13:44:49 +0800
Message-ID: <20250908054449.18414-1-zhaoguohan@kylinos.cn>
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
Reviewed-by: Markus Elfring <Markus.Elfring@web.de>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

---
V2 -> V3:
- Replaced `out_free_cpus` with `out_put_cpus`
- moved the patch version descriptions behind the marker line
V1 -> V2:
- Extended the goto chain with separate error handling labels instead of =
using null pointer check
- Reordered jump targets to avoid accessing NULL evsel members
- Added Fixes tag
- Updated commit subject to use "Prevent" instead of "Fix"
---
 tools/perf/util/parse-events.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
index 8282ddf68b98..2ffdd0d13c45 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -277,18 +277,18 @@ __add_event(struct list_head *list, int *idx,
=20
 	evsel =3D evsel__new_idx(attr, *idx);
 	if (!evsel)
-		goto out_err;
+		goto out_put_cpus;
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
@@ -310,12 +310,14 @@ __add_event(struct list_head *list, int *idx,
 		evsel__warn_user_requested_cpus(evsel, user_cpus);
=20
 	return evsel;
-out_err:
-	perf_cpu_map__put(cpus);
-	perf_cpu_map__put(pmu_cpus);
+out_free_evsel:
 	zfree(&evsel->name);
 	zfree(&evsel->metric_id);
 	free(evsel);
+out_put_cpus:
+	perf_cpu_map__put(cpus);
+	perf_cpu_map__put(pmu_cpus);
+
 	return NULL;
 }
=20
--=20
2.43.0

