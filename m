Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48231A275;
	Wed, 13 Aug 2025 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755056159; cv=none; b=bmuRFzJs0svqNO/2+LB/nf8x6sQzg08bPYqt72rnRfHSFn6OjZg5sRcWSta3ieeIMObcwu3ftSXeClvut0S463psoPdDwsSAfUyo2JIR2Omw3IIhBWDLNFn67qzIogTShImNQCSTT/SwxiQZxORjt4K8/uiLd0B22fHvH3rBC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755056159; c=relaxed/simple;
	bh=ciniG47yL5iXrnFZ1dgtMqrNtU20Fly7Hacebn6gSqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGtLliCPlzaAeSDS6s54NolfUGMfhzGmIdhMaBc3xCEVT09l8YxpNDnh131/JviZX9xgIhNsNsbdTDeqWGVbVyoJHgOfHg8EGdfbGdjS/NrluYV0JD6ipY8c0mOhn+ymRNccgf2BuC9+rYxzwCN0v6Vyr8g/INA8O3DMmhyCgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9bad3b7a77f611f0b29709d653e92f7d-20250813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:05a3f7ec-190c-43aa-9ad5-fd959d670235,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:ede127c1c55cb84756c65a0b63ab87f9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9bad3b7a77f611f0b29709d653e92f7d-20250813
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1157607160; Wed, 13 Aug 2025 11:35:50 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 555B8B8258E7;
	Wed, 13 Aug 2025 11:35:50 +0800 (CST)
X-ns-mid: postfix-689C0816-117208691
Received: from localhost.localdomain (unknown [10.42.12.87])
	by node2.com.cn (NSMail) with ESMTPA id 74C47B812916;
	Wed, 13 Aug 2025 03:35:48 +0000 (UTC)
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
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH v2] perf drm_pmu: fix fd_dir leaks in for_each_drm_fdinfo_in_dir()
Date: Wed, 13 Aug 2025 11:34:32 +0800
Message-ID: <20250813033432.8943-1-zhaoguohan@kylinos.cn>
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
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
V1 -> V2: Added the Fixes tag in commit message
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

