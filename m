Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262733F12F5
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545471; cv=none; b=ntslr/bmQXtNxt7ed9SZ2Hf2vESs/9mcy41I7dt03H6wdYAlKWUdQgjlc6/1Ydk4NSU/Ir2D/qEn9BcDjJsV8P0n6wJ1DYwrWwGwwmuRJL0ShlfhtzZ3LXlG8y+aSFzcFNFnYjZB99nvOzFdQrnCYFKQqTTWi9yPS49kqIAPEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545471; c=relaxed/simple;
	bh=rJDJav2jEJ68+Iuqu1WSLtfDNH3h3JiCxDxU65DPwZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lC3EYF72WiavRnhfYCW4qdQUxfdY9Ruk+VR4MWVlD/Tr7zOt5FOsWifftgjJ5bNIHLw6eslA/sS1gNMywRkVHq8jfftZA1ODqMpg2cB+Nh81L2swNvtb4eg2kexAX3G5ohs7aught1NANKgAquP8b1BgOv75KPIWbvcvm+ZoJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cvsylL5C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cvsylL5C"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABhma1907941;
	Mon, 20 Jul 2026 11:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sVnww5nYeSWXu81Ux
	dEfRhnC8XT/E1qwugerah/00eA=; b=cvsylL5CoPUSHbZ+kuCQriGuhbXkQoDEm
	ap++wXNtGIQ22tEhkR8Dyxrw63TRTCYf4mIZ2Yavq07y4Hf1fRmUxkTCwlVwH53F
	87x+WkUIQKRAKkyZxuet0+p9jGojiXhqr1Jl90gywdIDVJMk1uLRhdxo6+N7ZlOp
	KRJ5ab5jtYHlDbMQArq3k37e/fVLFc1W7DIf5drU5f19OZ5X/XJfWQdzVTcMc3zt
	69ABrDfeRFKByQFTLAtFZMtb4xAZbeyuo8Q4Zs9llRrOTi8qZTL7oKE4PVSr7Yoj
	0/LoJLx7ObnsVKb0B4OByECheXbEze4wsAkdVy+WAOC/nzItOtUXQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7agxtck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAnjwI009484;
	Mon, 20 Jul 2026 11:04:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjn987-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KB4CBt31064510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 11:04:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 092612004D;
	Mon, 20 Jul 2026 11:04:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE09E20040;
	Mon, 20 Jul 2026 11:04:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 11:04:08 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V2 3/6] tools/perf: Add arch hook to drain remaining data before event close
Date: Mon, 20 Jul 2026 16:22:15 +0530
Message-Id: <20260720105218.14277-4-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260720105218.14277-1-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: l5ivHdJYlolOWxvfurWRy_X3fQuvZ8Mr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX88c419WHukjl
 LxeVgZ5gFRt2NwrlN+8oqtiRHYrYCPMZHRl/Z2X24rlVMob9qiCxAmN3brW2VphLR1G36aF1+SB
 4PQ1SkgrYnH5/ROloYXEgD+17ZdIjBqmC7wVf793Y8ONsRc8TgTIdp1zneml/n1abstaUBSp+Up
 PX84AEZ6KIqWM2MXYNAVORtCy/7WDXYtEysD75BjR+UrBdebfBJSJmjQNJ4L0VHh6klDrcEOhAm
 Ld63XhdKgzraqE8UR0tvy9HRdlmDRmpqIIlH7DxCY5b5xP6MLPa8u7Wuc9KbrZkwmHtB/iAqtlf
 LgCTsk+ORUyuwYVlqPa/gUYE6dHi7m+BSEHrtP+lIJhEAo8TiTH/1IZHAvfRwVC1AdQdwIwF0ma
 ts9et6XL1uxBqnsGpobkuHjIm8M2gj/kaCtC2rtTzOO4wGX94zwt5RlT5BYBnqqIm/MEhpNTHoV
 uAMKKHeyybZ6uk+LFOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX5c9NEKC23tvv
 rUcivEwkFr565T355cBivQIYueHbGml0d/Df9URftMzbrH7QmzLBeWlNMAzNylEclgKrXZE4iNk
 7eysi51bmp11Kc3m2iJosBJ/pBQFcBs=
X-Proofpoint-GUID: wec21FZdszHZtQImcmuhw3bNO1ZXCTlk
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5e00b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=KqnElyTDCdP3ZBrdxgsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

While collecting samples using perf record, __cmd_record() disables the
evlist once recording is complete. After that, event fds are no longer
read and any remaining PMU-specific data cannot be drained.

Add a weak arch_perf_record__need_read() hook so architecture code can
indicate that more data remains to be collected before events are
disabled and closed. When the hook reports pending data, perf record
performs another read pass.

This allows architectures such as powerpc HTM to drain trace data and
associated metadata before the event is closed.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
-  V1's callback was responsible for driving the read loop
  including evlist__enable cycling. Removed that logic
- Use bytes written to check if session needs to be continued.
- Patch is now 3/6 instead of 3/9.

 tools/perf/builtin-record.c | 45 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/record.h    |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f58d7e3c7879..ae44e452d148 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2437,6 +2437,45 @@ static unsigned long record__waking(struct record *rec)
 	return waking;
 }
 
+/*
+ * Weak symbol - architecture can override to indicate if more
+ * data needs to be collected before finishing output.
+ *
+ * Returns: 1 if more data exists, 0 if collection is complete
+ */
+__weak int arch_perf_record__need_read(struct evlist *evlist __maybe_unused)
+{
+	return 0;  /* Default: no arch-specific data to collect */
+}
+
+static void record__final_data(struct record *rec)
+{
+	u64 last_bytes_written = 0;
+	/*
+	 * Collect any remaining architecture-specific data.
+	 * The arch code checks if more data exists, and we do the actual
+	 * reading here since we have access to record__mmap_read_all().
+	 * This code performs the additional read pass while events are
+	 * still live.
+	 */
+	while (arch_perf_record__need_read(rec->evlist)) {
+		/* If user presses Ctrl+C again during draining, abort cleanly */
+		if (done > 1)
+			break;
+
+		last_bytes_written = rec->bytes_written;
+
+		if (record__mmap_read_all(rec, true) < 0)
+			break;
+
+		if (rec->bytes_written == last_bytes_written) {
+			pr_warning("Final data drain made no forward progress.\n");
+			break;
+		}
+		usleep(100);
+	}
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -2451,6 +2490,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	float ratio = 0;
 	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
 	struct perf_env *env;
+	bool final_data_drained = false;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -2857,6 +2897,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			done = 1;
 		}
 
+		if (done && !disabled && !final_data_drained) {
+			record__final_data(rec);
+			final_data_drained = true;
+		}
+
 		/*
 		 * When perf is starting the traced process, at the end events
 		 * die with the process and we wait for that. Thus no need to
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..56de4f95a836 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -10,6 +10,7 @@
 #include "util/target.h"
 
 struct option;
+struct evlist;
 
 struct record_opts {
 	struct target target;
@@ -95,4 +96,6 @@ static inline bool record_opts__no_switch_events(const struct record_opts *opts)
 	return opts->record_switch_events_set && !opts->record_switch_events;
 }
 
+int arch_perf_record__need_read(struct evlist *evlist);
+
 #endif // _PERF_RECORD_H
-- 
2.43.0

