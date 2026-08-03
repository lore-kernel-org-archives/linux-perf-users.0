Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5F3ACEFE;
	Mon,  3 Aug 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748032; cv=none; b=gs1HH6m1Ha/Tsw3IhTb3A8tP63ZEHwWQjusn7F9xS4jAZfUvGmVN/RadZ5gPPowzM+UAKQKQkeVqBLSQNotnEEDCzcSgwR5i6cluHr6hgfTe83bykh11Cls5VAlvlYaRPqsLy741gwhW4YgWdle6ix5OPG0akcks2gwJKnGIR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748032; c=relaxed/simple;
	bh=/8zeMeCiCnbRkZ640Lbk1ng8nxG1hb7V3nh+P1UWtqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WJss4LZg+atOroEg/oE/xi1EoGata4/q0SX+AuFD9r54FKoae0Sxcw045yYgIqGyAANPF2SLhCpJMpRKn3aAoV24O5jF+zxa0xFEYm2m54D0KglWQ23teOvQX0/P6qB0ISFxKBuKSTz1MB1OO2mLm2AYFnEE9VrI0GF/Kw62Hgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=ilKgvVZs; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="ilKgvVZs"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67338awI078182;
	Mon, 3 Aug 2026 02:06:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=aTSS9onzK
	/eGFJ35BU3AcTYGYY+W2v+qFW6wa5L92Cs=; b=ilKgvVZsi9PyiaV245GV1Wr6d
	0lHEbXQLT3QKnXJ5tCu6RJe4YzrazVkLZmIBcuI1Eg4ODEL9uzwBLsUiSyiI6MKw
	mKnP0qrQs7HihpNAcvHgLWGwTO+DgdbTxychwaDuDoG/gQZRLTsMVFKigdVNUrjJ
	ZtlPy9R09+VBVbj7tJsCiO/o+L20qSb6CPs6SNG8TvT2ASGu2cIg9197u+pwwROf
	PlYGMWkYlb8OI7n1/yPc5Kbu6oXrJt59jW+uR6y02t99h/sAND43p4xB/CQehTLW
	CwIBAyxYChiIYoz7uT2yDM/SJ5tdMfWdJ5HgQB+myytNDyoARmEObpHrhF3BA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ft4tsv1mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Aug 2026 02:06:43 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 3 Aug
 2026 09:06:42 +0000
From: Amir Ayupov <aaupov@fb.com>
To: <linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Leo Yan
	<leo.yan@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Swapnil
 Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH 1/9] perf header: Tolerate inconsistent HEADER_GROUP_DESC
Date: Mon, 3 Aug 2026 02:06:32 -0700
Message-ID: <20260803090640.2412336-1-aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GpSbockUBSQ22Ad4J1h5H7EelkOtFlYN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX1LjYo9UbY1gX
 KoBUZIYt7mq30Ta8QPOremSWsgRXxGwcsaEUFEjT3MrCVN3Zb0JPf7QH+LrLUbiJXT0tKsUNAcB
 /BW5i7TWV7+3Gt1U5JYcSE8MIcc35ZWREi4Rvgz9g+8/kJyk7rwECYQXi+LdZAnCaRn0xDn0kYG
 mNEarIAIcUdTg4v0bqQw0rwVAK3cAej359G5Z2/BquxziFWxP8vCNubC3womI5CKgix03Qnv6wO
 ke+RuHonq9VvApoZBxZs8Lt3jT10FknZN52t8C7oD58ZMAz7sHjuxkRO02PY0JPgsbINc+Ra0KE
 G0K9uMgyRSKngzpjTr+lRC9IcGfV1sBlW4V4EVG6ttR5zfttrejVgG2beTqvfV3GJViDMZqEQoz
 v264MtebSswe8CvNncObd31ZpkkIMD/kLYqoQKnDmcSDY9GNw0Z3oYCAKTgaQVOJZvtg4sEGTSx
 Fsm1ObCU/fTah77EpHg==
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=6a705a23 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=FOH2dFAWAAAA:8 a=S_1yFPIV722Wla3RidoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX19cJeUhmurb6
 OaGnfMK55Db/3RuPVvqU0u3dB59wfD1hPWotRdVEZdOICwLimjRLxxgrIWqSZWuTxM4xgssU2Rg
 4/lUEKr2xRRf66RXHvDBPlz1hTXeNTQ=
X-Proofpoint-GUID: GpSbockUBSQ22Ad4J1h5H7EelkOtFlYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

process_group_desc() rejects the entire perf.data file ("invalid group
desc" -> "incompatible file format") whenever the group description is
inconsistent with the event list. Group information is optional metadata
and is not needed to decode samples, so a single bad group descriptor
should not make an otherwise valid file unreadable.

This is observable with AUX area recordings (Arm CoreSight ETM, Intel PT)
that use aux-action pause/resume: the aux-action regrouping inflates the
AUX group leader's nr_members, producing a group descriptor that the
strict reader rejects, even though the file is otherwise fine (older perf
and other tooling read it by rebuilding groups from event records).

Warn and fall back to a consistent ungrouped event list instead of
failing the read.

Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 tools/perf/util/header.c | 42 +++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e90e541f546b4..ddc59624d639b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3373,6 +3373,19 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	i = nr = 0;
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (i < nr_groups && evsel->core.idx == (int) desc[i].leader_idx) {
+			if (!desc[i].nr_members)
+				goto out_inconsistent;
+
+			if (nr > 0) {
+				/*
+				 * A new leader was found before the previous
+				 * group's members were all consumed, so the
+				 * group description is inconsistent with the
+				 * event list.
+				 */
+				goto out_inconsistent;
+			}
+
 			evsel__set_leader(evsel, evsel);
 			/* {anon_group} is a dummy name */
 			if (strcmp(desc[i].name, "{anon_group}")) {
@@ -3381,11 +3394,6 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 			}
 			evsel->core.nr_members = desc[i].nr_members;
 
-			if (i >= nr_groups || nr > 0) {
-				pr_debug("invalid group desc\n");
-				goto out_free;
-			}
-
 			leader = evsel;
 			nr = evsel->core.nr_members - 1;
 			i++;
@@ -3397,10 +3405,8 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 		}
 	}
 
-	if (i != nr_groups || nr != 0) {
-		pr_debug("invalid group desc\n");
-		goto out_free;
-	}
+	if (i != nr_groups || nr != 0)
+		goto out_inconsistent;
 
 	ret = 0;
 out_free:
@@ -3409,6 +3415,24 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	free(desc);
 
 	return ret;
+
+out_inconsistent:
+	/*
+	 * Group information is optional metadata and is not required to decode
+	 * samples. Rather than rejecting the whole file, warn and fall back to
+	 * a consistent ungrouped event list. This can happen with otherwise
+	 * valid perf.data files, e.g. AUX area (Intel PT, Arm CoreSight ETM)
+	 * recordings using aux-action pause/resume.
+	 */
+	pr_warning("Inconsistent HEADER_GROUP_DESC, ignoring group information\n");
+	env->nr_groups = 0;
+	evlist__for_each_entry(session->evlist, evsel) {
+		evsel__set_leader(evsel, evsel);
+		evsel->core.nr_members = 1;
+		zfree(&evsel->group_name);
+	}
+	ret = 0;
+	goto out_free;
 }
 
 static int process_auxtrace(struct feat_fd *ff, void *data __maybe_unused)
-- 
2.52.0

