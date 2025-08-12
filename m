Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE920C001;
	Tue, 12 Aug 2025 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980571; cv=none; b=fqKhrMMNlYbxhJN+iMjSDMtA3jC4Qi68R36BL3YY+Py2OUEGmtK0Gz060Gfvt6ovpL2sFY5klGwRQHRdoQfhYY7g06MMPZHBl7Z26lT57OzgLLpAnml6YRhh+OVms5JxrJHGVbxhp9uK+pCO8K1s5zc6uVkdgNXDPcy8ej38U60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980571; c=relaxed/simple;
	bh=PqRBrCjuPPipQqbUjPrWWJCYZSDA5+ULEgdTcRC0Z84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QcSiKdZ+5Lb/PO/FHPmV5lJc4j5lYMqjhvGtEoTJVUuoNUDvYJlnY1GcrlT1J4WpxZHDeS+Id9Sf8vUMJla7LAWDezCREdL0oLA3on9SF9PTafJyLjNcP6YkaJiJ8vxcJKvSW23vNIvw86sVMzFRztq3Ka3lasTlekO+ZG5FnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9bdcc792774611f0b29709d653e92f7d-20250812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a156faad-1cdd-447b-aa95-3a03135fa44c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:ca2de71062e30d2de27ae29bbae5efd9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9bdcc792774611f0b29709d653e92f7d-20250812
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1047693736; Tue, 12 Aug 2025 14:35:59 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 37199B8258E7;
	Tue, 12 Aug 2025 14:35:59 +0800 (CST)
X-ns-mid: postfix-689AE0CE-987816144
Received: from localhost.localdomain (unknown [10.42.12.87])
	by node2.com.cn (NSMail) with ESMTPA id 9B798B812916;
	Tue, 12 Aug 2025 06:35:52 +0000 (UTC)
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
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] perf drm_pmu: fix fd_dir leaks in for_each_drm_fdinfo_in_dir()
Date: Tue, 12 Aug 2025 14:35:46 +0800
Message-ID: <20250812063546.13797-1-zhaoguohan@kylinos.cn>
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

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 tools/perf/util/drm_pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index 988890f37ba7..424a76d1a953 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -458,8 +458,10 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void=
 *args, int fdinfo_dir_fd, c
 		}
 		ret =3D cb(args, fdinfo_dir_fd, fd_entry->d_name);
 		if (ret)
-			return ret;
+			goto cleanup;
 	}
+
+cleanup:
 	if (fdinfo_dir_fd !=3D -1)
 		close(fdinfo_dir_fd);
 	closedir(fd_dir);
--=20
2.43.0

