Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8361DED52
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745227586; cv=none; b=Oh1nD/Rc0J9SsEfo9AE4CLaaYE9uItI0ujcvyqMSykAr3NglWdXZ18Qp0nGKE29B0IvuBN0W3WosDxZwhKXOu/HNNm5FNVb7iKM6TKdNCu9EuoJ2/L44CJWahigrEZedQsPh2s3iZghCHTbEvqWQFv80nTZLA67Uz9PorCIZIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745227586; c=relaxed/simple;
	bh=gJXlzt8xzxk9K+T6g0Nw822S4FjofEtMGLcJgi6DovY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOdp/UMRfJhUy4Jx7UNEYB+HW12YbHgxEaQJRo9gG96iAnWEKnO5LSDJ1JCAIya7JafqUGiwWK3r6NzSnktJaX+GCxo84qVrif3PH1NoBDjVDBOKie+z+hZpKJZmRwdmWFyJSyw9OAJd5olxM9E3j8bUNqTj/CPIfEMj73l4sbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Au+IXDUl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Au+IXDUl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNgFS4019157;
	Mon, 21 Apr 2025 09:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NMzEpFLJGpRGGSwUCsBzHt/BYxkWg5WdpNshT18rS
	0Q=; b=Au+IXDUltZUCBElfyb6uZ+Tkny+3CpTZ52zZGEI2i/B4gWL0yjEOTS3FY
	p+VRioOv38SKL9jN5OT/qQa2VRg4e5eEFDkIwCszHJFoKgK/ZaR/jWFc3FIFMsw6
	0m40s7CP30HMCBvHa6FCWejxjoPKxtxgkDkEMDq1eI6+ySxdrPpYGUEI9YqHNS6y
	nsQ3+nPRQ3yVDUBpju9CU2R1eKpLZ/TyRcVDHyEz9BxZB9AGEZWHX2fFOcc0t5lk
	7RfHjARdcB8j5HLk10R0JzJohIjS5pReg2oM6BtgLRL3uhTy+ZRQto8TN5xMMDlD
	Ej7R/Pe2onGavqYBNSVo+4FOnprxw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4658gk29pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 09:26:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53L96H3m028130;
	Mon, 21 Apr 2025 09:26:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rv1wc4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 09:26:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53L9QG0V56492410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 09:26:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBA08200CE;
	Mon, 21 Apr 2025 09:26:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCD03200D7;
	Mon, 21 Apr 2025 09:26:15 +0000 (GMT)
Received: from Adityas-MBP.lan (unknown [9.43.41.109])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Apr 2025 09:26:15 +0000 (GMT)
From: Aditya Bodkhe <adityab1@linux.ibm.com>
To: linux-perf-users@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>,
        Aditya Bodkhe <aditya.b1@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2] perf script: perf script tests fails with segfault
Date: Mon, 21 Apr 2025 14:55:59 +0530
Message-Id: <20250421092559.75109-1-adityab1@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3QG-OGA7kGxkTZlncEGaFbJa9KZmArQZ
X-Authority-Analysis: v=2.4 cv=Xv/6OUF9 c=1 sm=1 tr=0 ts=68060f3f cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=bfOIhj56j9TKDZiLBowA:9
X-Proofpoint-ORIG-GUID: 3QG-OGA7kGxkTZlncEGaFbJa9KZmArQZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210070

perf script: pert script tests fails with segmentation fault as below:

 92: perf script tests:
--- start ---
test child forked, pid 103769
DB test
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
/usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
--- Cleaning up ---
---- end(-1) ----
	92: perf script tests                                               : FAILED!

Backtrace pointed to :
	#0  0x0000000010247dd0 in maps.machine ()
	#1  0x00000000101d178c in db_export.sample ()
	#2  0x00000000103412c8 in python_process_event ()
	#3  0x000000001004eb28 in process_sample_event ()
	#4  0x000000001024fcd0 in machines.deliver_event ()
	#5  0x000000001025005c in perf_session.deliver_event ()
	#6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
	#7  0x0000000010251618 in perf_session.process_events ()
	#8  0x0000000010053620 in cmd_script ()
	#9  0x00000000100b5a28 in run_builtin ()
	#10 0x00000000100b5f94 in handle_internal_command ()
	#11 0x0000000010011114 in main ()

Further investigation reveals that this occurs in the `perf script tests`,
because it uses `db_test.py` script. This script sets `perf_db_export_mode = True`.

With `perf_db_export_mode` enabled, if a sample originates from a hypervisor,
perf doesn't set maps for "[H]" sample in the code. Consequently, `al->maps` remains NULL
when `maps__machine(al->maps)` is called from `db_export__sample`.

As al->maps can be NULL in case of Hypervisor samples , use thread->maps
because even for Hypervisor sample, machine should exist.
If we don't have machine for some reason, return -1 to avoid segmentation fault.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
v1 -> v2:
The below patch contains changes suggested by Adrian Hunter<adrian.hunter@intel.com> to handle the segmentation fault ,
as well as initialisation of al.thread

 tools/perf/util/db-export.c                           | 11 ++++++++---
 .../perf/util/scripting-engines/trace-event-python.c  |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 50f916374d87..8f52e8cefcf3 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	if (al->map) {
 		struct dso *dso = map__dso(al->map);

-		err = db_export__dso(dbe, dso, maps__machine(al->maps));
+		err = db_export__dso(dbe, dso, maps__machine(thread__maps(al->thread)));
 		if (err)
 			return err;
 		*dso_db_id = dso__db_id(dso);
@@ -256,6 +256,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		al.map = map__get(node->ms.map);
 		al.maps = maps__get(thread__maps(thread));
 		al.addr = node->ip;
+		al.thread = thread__get(thread);

 		if (al.map && !al.sym)
 			al.sym = dso__find_symbol(map__dso(al.map), al.addr);
@@ -358,14 +359,18 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	};
 	struct thread *main_thread;
 	struct comm *comm = NULL;
-	struct machine *machine;
+	struct machine *machine = NULL;
 	int err;

+	if (thread__maps(thread))
+		machine = maps__machine(thread__maps(thread));
+	if (!machine)
+		return -1;
+
 	err = db_export__evsel(dbe, evsel);
 	if (err)
 		return err;

-	machine = maps__machine(al->maps);
 	err = db_export__machine(dbe, machine);
 	if (err)
 		return err;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 520729e78965..00f2c6c5114d 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1306,7 +1306,7 @@ static void python_export_sample_table(struct db_export *dbe,

 	tuple_set_d64(t, 0, es->db_id);
 	tuple_set_d64(t, 1, es->evsel->db_id);
-	tuple_set_d64(t, 2, maps__machine(es->al->maps)->db_id);
+	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
 	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
 	tuple_set_d64(t, 4, es->comm_db_id);
 	tuple_set_d64(t, 5, es->dso_db_id);
--
2.43.0

