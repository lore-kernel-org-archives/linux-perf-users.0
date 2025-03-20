Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04E1E5204
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Mar 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462163; cv=none; b=l/ISK7disaaApaeEqc3JzKII6VTG5RGtOCh2qtPIhayYBU9Du3WQIzbjJeVV5EHdbaVWrfdFs6QVgNspCJ0vHXWyT2n0lW53EVLx29WMT6MTD9w5CYkxSdmiYdKjtPeVY11tHCWbdtezFKz6T8hG4CtEdeMoti6t68EE8pxcIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462163; c=relaxed/simple;
	bh=StgTeWBsR1OdQokDuBmD5TNu8++OZxRb2Mww9a9lXE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sNhKs24CND5esZX0o3DPLuWQeIUN8odFVeR51j0e+ZETZHxQ218VmVAikaTmuaeG1Y8Y8HMInKUbHu37WoaOmM7VNW7RZ/1LZg52O7lGt2YYoSgLjtkiu7JhPnxy5YU7QdJd+fN8kMotR11qqHUGC5o948IMkUZiijKjbCsyUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pDmVw1hs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pDmVw1hs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K536v3020677
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Mar 2025 09:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=AmDn+51Q7pyjZ+MDNZCSF4YaixtQ
	+XmiTa175RFFlEA=; b=pDmVw1hsuyAUcGRAez+9RiBliHkpQ8v8fP4hcXeFt+HF
	TEDVCjAndPRVb/BibqDZL4e0e7ziDya/YNskvUBXbpYEmrfZUMaYycoV4Xve8CGL
	zwlXxVX9Wx5VtFl7apbIGPwuANounZ7ZZW7BsFZ1K9D48NopbnTPD4wJ2MEvhtkM
	JO3zQ8MLbbHo9m9TNOib+IXO1b4Fxwqz/Rnmn/b4EkO6upblI9eMKLPVifcbnPFU
	nGlG9fFOHei5rbNpGdncP0w/zs1eXTlwfvH/0nRpTy9iQnBbwZ+5HtHu+CmA9F5/
	Csp4hcUQD1HdNsopVqc9e7fCG4xOxVuOWVWABeD60A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g23vc4du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Mar 2025 09:16:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6RgRj005734
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Mar 2025 09:16:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2ppry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Mar 2025 09:15:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K9FskG53281202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:15:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF6FB20043;
	Thu, 20 Mar 2025 09:15:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0608420040;
	Thu, 20 Mar 2025 09:15:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.199.26])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 09:15:53 +0000 (GMT)
From: Aditya Bodkhe <adityab1@linux.ibm.com>
To: linux-perf-users@vger.kernel.org
Cc: Disha Goel <Disha.Goel@ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>
Subject: [PATCH] perf script: perf script tests fails with segfault
Date: Thu, 20 Mar 2025 14:45:51 +0530
Message-Id: <20250320091551.17846-1-adityab1@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZloF5lzyj44uvmW5lRVJKzymMidw56GW
X-Proofpoint-GUID: ZloF5lzyj44uvmW5lRVJKzymMidw56GW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=808
 clxscore=1011 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200053

perf script: pert script tests fails with segmentation fault as below:

1. Run perf test -vvv 'perf script tests'

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
perf doesn't set maps for “[H]” sample in the code. Consequently, `al->maps` remains NULL
when `maps__machine(al->maps)` is called from `db_export__sample`.

To prevent this NULL pointer dereference, add a check for `al->maps == NULL`
before calling `maps__machine()`. If `al->maps` is NULL, return `-1` to avoid
the segmentation fault.

Reported-by: Disha Goel <Disha.Goel@ibm.com>
Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
---
 tools/perf/util/db-export.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 50f916374d87..f355878a8c82 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -365,6 +365,11 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
        if (err)
                return err;

+       if (!al->maps) {
+          err = -1;
+          goto out_put;
+       }
+
        machine = maps__machine(al->maps);
        err = db_export__machine(dbe, machine);
        if (err)
-- 
2.43.0

