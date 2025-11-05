Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA933CEB2;
	Wed,  5 Nov 2025 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370203; cv=none; b=Vyn2kd7vITd7zmVmGKMW6w6sFsHGqbj/7dru0O8mGii9RvPpBY0BMBxAnV6LQa5Oz+FP32pi3t/LjXywltcCfsBTU5lOhfE7t7UK28XEuy/vhKsBUS3DD7TLjaWbYNdF5HzP81yCvjoXKO/4f+KXqaBvAoHjYNu7PjuouXq/ALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370203; c=relaxed/simple;
	bh=xEPuY0Aq6t22FgSHExwjo58jWnNFk4btfpoFcms/TMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1P4eoWFulcG8AKKiRnL5ishUkQNCMIvgD9eJV8qY9M0kkkYzHNI8kFrnrQ1XIHX7GbKAwiNbMMB26xuvrJJ6UPpOOMDfiLwH3EciSkj95fFKp8qN/5jly6ye0tpKET9Qnc3To9aideoOw0ffzJP+bqIp0uGoXRFQ3MNkXfQ3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G7KwDwpJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G7KwDwpJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HJ0Kx021179;
	Wed, 5 Nov 2025 19:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p/08haptJ9TbAqui1
	15p4wPH+9xfsOic9U8vGBYByis=; b=G7KwDwpJEhakrJWV1njmUFw+UxbtezMja
	pfv8G4mbPjBRVgukpN9TA+rk+S40MrqSAgGDYPtxOpkG83JllN+9QvORrxfr/DMf
	9EehrgyBt/yRpdzZbisR8A6ybYxTirVBp871PuWMtIGuVBCBl/P305FKaQqYHNfd
	QI+6oX5nfqrQUSFwumU3jHanTMKfBjaSa2YUyIji9D9dnBfSVv+Xc4yXMprV1JKr
	mb9ewbkUR1MkMBnqZ2rfkFpstzPhbSXQGSDSujZNLw+7HnlSLtNoaibYkmb10n9g
	5Rx7CIkoUgcCr3ROiTXx8BQ1C329KNwc0sHxHEf8gaDGnG2ZtiNhQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q93a82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HZR31027407;
	Wed, 5 Nov 2025 19:16:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwyhxdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5JGXGo30343426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 19:16:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6DB520043;
	Wed,  5 Nov 2025 19:16:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C28E20040;
	Wed,  5 Nov 2025 19:16:33 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.135.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 19:16:33 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/5] perf jitdump: Fix PID namespace detection
Date: Wed,  5 Nov 2025 20:10:24 +0100
Message-ID: <20251105191626.34998-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105191626.34998-1-iii@linux.ibm.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690ba297 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=BtBgnFqPBM3CgXGvGYgA:9
X-Proofpoint-ORIG-GUID: EbYCSNVZ4S7mpTiQilpc6TvFUYX8pGVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX9bhAVL1fphdM
 tgJMuwx8d0BTerIUXVE7PwzcdG6vnVsleXC8w+t/Kzanjq1/pQYEwJFxov5KW6kN8HBXsLBnvSr
 M6qEzX+jEHQz7wnQeo4cAYXs6gcn6Dox2HdMbtizF20Zi9rbI/47Zv6d9DiIMzbdbKj1k8cFJaO
 p+NZiSBIZHBE/7T6fbNy5LctzPoTNEBHg69eKvzgx1lXh1I8991w66z31zI1jYjoCTwJ7Ng31S9
 AQuybggSi3gnecgLaJc1ViLdBqn17IOWC8nx8qzmVUHpy/WUu6L8uZ+Mc2RbXP435ZMEOS0RHt4
 QcHjVezONJIPxHXdR/VR3XOPZYaVbK9j3CH+SjjNmiYg4ht9GqwY1XxNMRqUmpMv51iZsM/Lw0l
 dQWp/tlY3FY4yps71fBgY5lu8iXHkQ==
X-Proofpoint-GUID: EbYCSNVZ4S7mpTiQilpc6TvFUYX8pGVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

perf inject fails to detect jitdump file produced by a process
running in a different PID namespace if this process has not exited
yet.

The PID namespace heuristic in jit_detect() compares two PIDs:

* pid: outermost NStgid of mmap(jitdump) caller from perf's PoV.
* nsinfo__nstgid(nsi): innermost NStgid of mmap(jitdump) caller from
                       perf's PoV.

The semantics of the in_pidns variable can be seen in, e.g.,
nsinfo__get_nspid(): it's true if and only if perf and the profiled
process are in different PID namespaces.

The current logic is clearly inverted: if pid and nsinfo__nstgid(nsi)
are different, then the profiled process must be in a different PID
namespace. This, of course, ignores that fact that they may end up
being equal by accident, but that's not the point here.

Fix by flipping the comparison.

Changing just that, however, breaks the case when the process has
exited. Add explicit support for that by adding "synthesized" field to
nsinfo, which tracks whether NStgid was obtained from a running
process (ignoring considerations of PID reuse or running inject on
a different machine). When the namespace information is synthesized,
assume the process ran in a different PID namespace.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/util/jitdump.c    | 27 +++++++++++++++++++++------
 tools/perf/util/namespaces.c |  9 +++++++++
 tools/perf/util/namespaces.h |  2 ++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index b062b1f234b62..19e4bc139935b 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -788,15 +788,30 @@ jit_detect(const char *mmap_name, pid_t pid, struct nsinfo *nsi, bool *in_pidns)
 	if (!end)
 		return -1;
 
-	*in_pidns = pid == nsinfo__nstgid(nsi);
 	/*
-	 * pid does not match mmap pid
-	 * pid==0 in system-wide mode (synthesized)
+	 * Determine whether the process ran inside a container, and whether it
+	 * mapped jit.dump for profiling purposes or by accident. Record this
+	 * for further use in jit_inject(). The kernel does not provide PID
+	 * namespace information, so we have to resort to guesswork.
 	 *
-	 * If the pid in the file name is equal to the nstgid, then
-	 * the agent ran inside a container and perf outside the
-	 * container, so record it for further use in jit_inject().
+	 * If the process exited and perf had to synthesize the namespace
+	 * information, then it's not possible to have any certainty; be
+	 * aggressive and assume that the process ran inside a container. This
+	 * allows the user to proceed with injection at the cost of a small
+	 * probability of injecting irrelevant data.
+	 *
+	 * If the process' NStgid as observed by perf is different from its
+	 * innermost NStgid, then it must have run inside a container. There is
+	 * a very small probability that NStgids randomly happenned to be the
+	 * same; ignore it.
+	 *
+	 * pid == 0 means system-wide mode, just proceed.
+	 *
+	 * Finally, the most straightforward case: if the PID in the file name
+	 * is equal to the process' NStgid as observed by perf, then it must be
+	 * a match.
 	 */
+	*in_pidns = nsinfo__synthesized(nsi) || pid != nsinfo__nstgid(nsi);
 	if (pid && !(pid2 == pid || *in_pidns))
 		return -1;
 	/*
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 01502570b32d0..7de5d62e271c4 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -132,6 +132,8 @@ int nsinfo__init(struct nsinfo *nsi)
 
 	rv = nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)->nstgid,
 			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
+	if (rv == 0)
+		RC_CHK_ACCESS(nsi)->synthesized = false;
 
 out:
 	free(newns);
@@ -166,6 +168,7 @@ struct nsinfo *nsinfo__new(pid_t pid)
 	RC_CHK_ACCESS(nsi)->nstgid = pid;
 	nsinfo__clear_need_setns(nsi);
 	RC_CHK_ACCESS(nsi)->in_pidns = false;
+	RC_CHK_ACCESS(nsi)->synthesized = true;
 	/* Init may fail if the process exits while we're trying to look at its
 	 * proc information. In that case, save the pid but don't try to enter
 	 * the namespace.
@@ -197,6 +200,7 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	RC_CHK_ACCESS(nnsi)->nstgid = nsinfo__nstgid(nsi);
 	RC_CHK_ACCESS(nnsi)->need_setns = nsinfo__need_setns(nsi);
 	RC_CHK_ACCESS(nnsi)->in_pidns = nsinfo__in_pidns(nsi);
+	RC_CHK_ACCESS(nnsi)->synthesized = nsinfo__synthesized(nsi);
 	if (nsinfo__mntns_path(nsi)) {
 		RC_CHK_ACCESS(nnsi)->mntns_path = strdup(nsinfo__mntns_path(nsi));
 		if (!RC_CHK_ACCESS(nnsi)->mntns_path) {
@@ -275,6 +279,11 @@ void nsinfo__set_in_pidns(struct nsinfo *nsi)
 	RC_CHK_ACCESS(nsi)->in_pidns = true;
 }
 
+bool nsinfo__synthesized(const struct nsinfo *nsi)
+{
+	return RC_CHK_ACCESS(nsi)->synthesized;
+}
+
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index e95c79b80e27c..41ba2ea8137e5 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -38,6 +38,7 @@ DECLARE_RC_STRUCT(nsinfo) {
 	bool			in_pidns;
 	char			*mntns_path;
 	refcount_t		refcnt;
+	bool			synthesized;
 };
 
 struct nscookie {
@@ -60,6 +61,7 @@ pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
 bool nsinfo__in_pidns(const struct nsinfo  *nsi);
 void nsinfo__set_in_pidns(struct nsinfo *nsi);
+bool nsinfo__synthesized(const struct nsinfo  *nsi);
 
 void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
 void nsinfo__mountns_exit(struct nscookie *nc);
-- 
2.51.1

