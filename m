Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED1270EC3;
	Mon, 22 Jun 2026 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124484; cv=none; b=ucNFSCUV/RXomHbTdFroSCbY5ZfkfuTq2o47oVH5mO5atZawIK5OrjyERdzBXS/XFqcvAgEoPpFGKhbB6MPjB5kbNouFq6LBN+AvEZWbNfstSu7gBc+tepaGU8WGTUFT37UmjaRBDXMtwy+6HRB4RZhKn9oGhbbrcKuOFm9AOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124484; c=relaxed/simple;
	bh=DesorlLzRm3VRMrt3mBXPnHHcOqRF4LtCLG/l6RuPaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8MFmZShNRFvQmv9z613+xohm8g2KRlCdrfs5Ure5z3E1MxfA+pfBu2ds7XIaFDhIPS0QyqWw/JAByJHt/YkuEAwxP+imk/UBd5BKDEINVH3pSyWY1iMG3g7qR0qQbv9LOi3UBpxeMTrHrE4z3iud/OHeb3iG7u/HCWc0175C98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rA9SWMKX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rA9SWMKX"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M9NpjC1433093;
	Mon, 22 Jun 2026 10:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=1DYOunAByr7eEbTA81uowPjUCc6bF
	2l3iupFX2dUSQk=; b=rA9SWMKX+/7kAO/t2BYc9gCfqzFCRLg3VS6Sa0V+TZjx/
	Wyfy+9s0z38HQIbBFs8Pjq5Oyc2MowUYEhm9CyKNAWaJvs4D1pTRqqDrI+w2eIeL
	V8onMkNN5nE01+lwEKOZPdjvYyOH8K6FPb4GMisltvk4g0q3FHuKqEyxG4GTbsLI
	dsGlOvAAhgQA3xvliCv5OhTdv5TYhLK7JN266GvXNm4KoqRecHMmBaP0qS+4NyKg
	1T3Z2MHjdIIWIoxVQbcO3pEbkbq75k/6PoHP8+oIjljmKkWbkFLbG+EBB1UJEDI2
	vIINTRFc1eKE0S2MMKumevIsQnAoA8+t1Pvx5qaXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhs91qed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 10:34:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65MAXTR2023014;
	Mon, 22 Jun 2026 10:34:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhanj2wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 10:34:21 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65MAYKT9026740;
	Mon, 22 Jun 2026 10:34:20 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-160.vpn.oracle.com [10.154.57.160])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ewhanj2vd-1;
	Mon, 22 Jun 2026 10:34:20 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: peterz@infradead.org, acme@kernel.org
Cc: mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH perf] perf: Fix btf_vlen() signedness errors
Date: Mon, 22 Jun 2026 11:34:18 +0100
Message-ID: <20260622103418.579115-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606220104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEwNCBTYWx0ZWRfXxXnu3AFeouzW
 0tf6tvWZ9EbUs7bCFDicEhQZaAdlo911hMgbe1+XaplBjbAgf5ghDtBz+C3Ys1zQ7BEDj20rFVj
 qeI98n3CmIY647Ku5MctIAnHdestj5HodbNkjISz1eah1qsLCqHV3dCOoJSALa5j7eLAB5vbAKp
 6JAKzozveSjHANHbr/DwgZ3J8Uu7Oo2WFpus2we/TF82I4yI5U+jQd2IK99Feo5JmR/Hnng5ozD
 Dhgh/FJ+Md0l2flJPz79+2pVvqxD6AFPDeDdg4T8AoPqfU85qbF6N4mGh3lqBYAcSM7RURaa+Mi
 QgkdUjnq5kIErPFuRUiSIxL1j+XsPze9kjUFpaVk+6rAMYxtz8NoRTK+1oXQjKVW8qtt1kFj5vq
 Rqe4xulndaT3qOUH51wT1uAiJsTVoewHNMleUAr0YGne2qNvoakZkZ6J5ec2iofowlqFwAFOKsj
 8RkjiIGb1sT/Ivwwbu2Q/0vy4O++p7m7vOflPF6E=
X-Proofpoint-ORIG-GUID: SE3XHrudSzrYM23J0YiOzPq4BQr4ycoR
X-Authority-Analysis: v=2.4 cv=Wokb99fv c=1 sm=1 tr=0 ts=6a390fae b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=NJn8BqKIbz5wdmeMu50A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13723
X-Proofpoint-GUID: SE3XHrudSzrYM23J0YiOzPq4BQr4ycoR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEwNCBTYWx0ZWRfX1Fqk6SUhhUkE
 9okkQq4p8WDl3BB+w+Pg9vXZ4Jpf02I0wpSVB5F8c2wGaqDypI1QrpniuzpAuTvxcFoYjFFeHa2
 jq8yf7cFatSFenPzl+FsgmVMJ8d5FyoN87sEIgDcC7wsY++4NbDp

Commit f7a6b9eaff3e6 ("bpf: Extend BTF UAPI vlen, kinds to use unused bits")

extended the return value for btf_vlen() to __u32, triggering
errors for cases where an int was used to store return value.
Fix these cases for perf as was done for other libbpf consumers.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 tools/perf/util/btf.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 48615ddccd93..9903d79c4b77 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -964,7 +964,7 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_
 	struct btf *btf = arg->trace->btf;
 	struct btf_enum *be = btf_enum(bt);
 
-	for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
+	for (unsigned int i = 0; i < btf_vlen(bt); ++i, ++be) {
 		const char *name = btf__name_by_offset(btf, be->name_off);
 		int max_len = max(size, strlen(name));
 
@@ -1009,9 +1009,9 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
 static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, int val)
 {
 	struct btf_enum *be = btf_enum(type);
-	const int nr_entries = btf_vlen(type);
+	const unsigned int nr_entries = btf_vlen(type);
 
-	for (int i = 0; i < nr_entries; ++i, ++be) {
+	for (unsigned int i = 0; i < nr_entries; ++i, ++be) {
 		if (be->val == val) {
 			return scnprintf(bf, size, "%s",
 					 btf__name_by_offset(btf, be->name_off));
diff --git a/tools/perf/util/btf.c b/tools/perf/util/btf.c
index bb163fe87767..1716b49d3568 100644
--- a/tools/perf/util/btf.c
+++ b/tools/perf/util/btf.c
@@ -14,7 +14,7 @@ const struct btf_member *__btf_type__find_member_by_name(struct btf *btf,
 {
 	const struct btf_type *t = btf__type_by_id(btf, type_id);
 	const struct btf_member *m;
-	int i;
+	unsigned int i;
 
 	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
 		const char *current_member_name = btf__name_by_offset(btf, m->name_off);
-- 
2.47.3

