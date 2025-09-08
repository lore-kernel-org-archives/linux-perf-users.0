Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4229D292;
	Mon,  8 Sep 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314337; cv=none; b=jcoO9MlxBrR4isF32ijB9u8qG4stoSca+UTQuM+7FtAANGnhy09r5Re9XA3l4Fog9+K1CvfD41LmFXafnSmObCb41x7UcXF7vQa3oLatlEjeQzhXPHCoxvXfkG15BeU2U0fagt8/ad2i+AG8Hy3D8dc3nRxqx+6PKruCi0C43Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314337; c=relaxed/simple;
	bh=LKTVzd+xR/q0tfDUogMQit2CKDvdrjwv4cLxtK/jrxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8bKBwxaYqgfI9uR9V9i0Zbp5Lz9sNo0UPQzOKuXzPAOjN3/wP9tyOzrW+Knmp99fnduxgwLGunciu9ELkUBkVK5R0iJLYSE6DEPlRfRlvSOakPscKRtdmQmiwoh04unQMHPXUfzLr6z9zoR3ICqmT+If5TT8dQnG+1Q07LtxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5642cfde8c8011f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a9f2cfb7-85d6-4541-8531-58d81e1ffa4b,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:5f159c1976d34ed9306448720ed0388a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5642cfde8c8011f0b29709d653e92f7d-20250908
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1535495310; Mon, 08 Sep 2025 14:52:07 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 8AD30B8258E7;
	Mon,  8 Sep 2025 14:52:07 +0800 (CST)
X-ns-mid: postfix-68BE7D17-39063937
Received: from localhost.localdomain (unknown [10.42.12.87])
	by node2.com.cn (NSMail) with ESMTPA id CB337B812916;
	Mon,  8 Sep 2025 06:52:05 +0000 (UTC)
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
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	GuoHan Zhao <zhaoguohan@kylinos.cn>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v3] perf drm_pmu: fix fd_dir leaks in for_each_drm_fdinfo_in_dir()
Date: Mon,  8 Sep 2025 14:52:03 +0800
Message-ID: <20250908065203.22187-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Fix file descriptor leak when callback function returns error. The
function was directly returning without closing fdinfo_dir_fd and
fd_dir when cb() returned non-zero value.

Fixes: 28917cb17f9d ("perf drm_pmu: Add a tool like PMU to expose DRM inf=
ormation")
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
v2 -> v3: replaced "cleanup" with "close_fdinfo"
v1 -> v2: Added the Fixes tag in commit message
---
 tools/perf/util/drm_pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index 988890f37ba7..98d4d2b556d4 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -458,8 +458,10 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void=
 *args, int fdinfo_dir_fd, c
 		}
 		ret =3D cb(args, fdinfo_dir_fd, fd_entry->d_name);
 		if (ret)
-			return ret;
+			goto close_fdinfo;
 	}
+
+close_fdinfo:
 	if (fdinfo_dir_fd !=3D -1)
 		close(fdinfo_dir_fd);
 	closedir(fd_dir);
--=20
2.43.0

