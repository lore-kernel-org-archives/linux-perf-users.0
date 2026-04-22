Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836A2737E3
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879390; cv=none; b=K/HbbdbF7g48BX9QO0uDye3kFieR6l8jcKYOxBJxEAkVxhDXY1nbkzhOi/nKCoWX6Xcijn6kKzHFHxz6EFGNSVCp3EJLm723yj2O6T8stMyalsjaHdESXi2IGxqx/NTIKKEFLs8LbW/YgYIVuuikOq4T6VEtQJKc11tmMRoF+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879390; c=relaxed/simple;
	bh=Uk+23ep+tZpY/WpE3EeHt/K9wHXIfbl//xmkje7rKT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=khzLHqby7x+FzXVvH8n3vmKUuIjDKdJKecUuM/2rCkd4P4mfcL4ghYvQyE05rwo8TY+C0kBRSrsIbh/NOpn7xmLAqNnv7NJ+kREE3dCN5HT5VkKFJzLBdXjWdRWZmjaxJIHsKI0vfVbDIq42Cf3f9Ael8miwMXzHJeU0BatCx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i7EOUKez; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i7EOUKez"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGMep03515444;
	Wed, 22 Apr 2026 17:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=s2BqK87P3busZvwnKMqLZKct+u+esfha5cyZCzHRZ
	kU=; b=i7EOUKezNPThLibWCTqm9JzX1lp+JxOtgcYWCSBB1wbgsfCWv/UaWSP6K
	jLKePsQCWhRTl/MSS/ouZVuZ5nccm1Tof1388I+qHgnZzpc0i4A9RpiVyOtGmZVJ
	BrsvBSc2tWKiYp+lLW7T85f+xwNOOlV+H4FoVoev8BkM/URWLsx4LOrxxTv4k2vS
	G3i8oKknqQYcoBb9ncdN1dMC91bvoQpNzhWBg4hd1xZTN8PEuRTZsgjdDiXWZjSQ
	Mklf0qrLz1PAllob4kW/29/0IrW5DzJ/jT9526QobFAvEeG+za6+FGpiPvpcRMTu
	yNz2FbyatguckwVrSQyQ0mXOcKD4A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu24sgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 17:36:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MHZKeV003564;
	Wed, 22 Apr 2026 17:36:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxu7kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 17:36:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MHaEo130409064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 17:36:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A613820043;
	Wed, 22 Apr 2026 17:36:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C721020040;
	Wed, 22 Apr 2026 17:36:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.30.235])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 17:36:11 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH] perf sched: Fix crash in sched stats diff due to uninitialized perf_data structure
Date: Wed, 22 Apr 2026 23:05:45 +0530
Message-Id: <20260422173545.73144-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE2NyBTYWx0ZWRfXz7XoSV/kWtvR
 YznATFeblMFplDhVI5eegDomNE30dm7QopcRBNthuIZSQ26z0MDEYeF3gw3m/SPoAy6CyfmRx0Y
 lgMUCRaJpyetNy/6ib6yhDOL14Srp0o3Xaos5r9xScB1HOVfNTNOoRXA77pSEDymYuwgOb/SRyT
 QULz66Z4YbiQhj/5q7Psdkr3/dx1k4YwNtifVks0/Q+CeS1TNsU4nyl2tcicY6cRFdyPriq7Yjj
 dAj+KkgbhP/W5S1vKj1qC+FM6MI6SPFsjnMn7QfvBJj61JPz56zgAUQOnCCHSo5SFDgKJRIBodL
 5urd01EUcKWxXGI79+bpQLMfv8oPQywlncjGEKBACGLDB9zJQTn4iH6mQP77owVuWq6mpMpbm4z
 dBU4YMfswRY+uhp0CfhmhJaNL1RUo4q8yLUddU4nDYyMmkwRPgoPChnDKrD1+eXd5V0PgvdKPVv
 sZURajTxo+zFlOmHcjg==
X-Proofpoint-ORIG-GUID: kO37_hnscnMYR81Tnn_nPId96kExk12C
X-Proofpoint-GUID: NM2Xa-JT7Lu4q0-Md1peximJP9oTjLfd
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e90713 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=gqBEGFNiBRC4Mxh7sp8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220167

perf sched stats diff fails sometimes with below logs:

 # perf sched stats record ls

 # perf sched stats diff
  *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: terminated
  Aborted (core dumped)

Also in some runs, perf sched stats tests fails

 ./perf test "perf sched stats tests"
 92: perf sched stats tests                                          : FAILED!

==172375== Conditional jump or move depends on uninitialised value(s)
==172375==    at 0x10393BD0: open_file_read (data.c:264)
==172375==    by 0x10393F63: open_file (data.c:317)
==172375==    by 0x10394067: open_file_dup (data.c:334)
==172375==    by 0x103942DF: perf_data__open (data.c:379)
==172375==    by 0x102F7CAF: __perf_session__new (session.c:169)
==172375==    by 0x100B5E63: perf_session__new (session.h:116)
==172375==    by 0x100D5D37: perf_sched__schedstat_diff (builtin-sched.c:4568)
==172375==    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
==172375==    by 0x1010231F: run_builtin (perf.c:348)
==172375==    by 0x1010262F: handle_internal_command (perf.c:398)
==172375==    by 0x1010286F: run_argv (perf.c:442)
==172375==    by 0x10102C67: main (perf.c:549)
==172375==
==172375== Conditional jump or move depends on uninitialised value(s)
==172375==    at 0x10393D20: open_file_read (data.c:282)
==172375==    by 0x10393F63: open_file (data.c:317)
==172375==    by 0x10394067: open_file_dup (data.c:334)
==172375==    by 0x103942DF: perf_data__open (data.c:379)
==172375==    by 0x102F7CAF: __perf_session__new (session.c:169)
==172375==    by 0x100B5E63: perf_session__new (session.h:116)
==172375==    by 0x100D5D37: perf_sched__schedstat_diff (builtin-sched.c:4568)
==172375==    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
==172375==    by 0x1010231F: run_builtin (perf.c:348)
==172375==    by 0x1010262F: handle_internal_command (perf.c:398)
==172375==    by 0x1010286F: run_argv (perf.c:442)
==172375==    by 0x10102C67: main (perf.c:549)

The valgrind logs and error message from the logs points to
below snippet:

     static int open_file_read(struct perf_data *data)
     {
            int flags = data->in_place_update ? O_RDWR : O_RDONLY;
            struct stat st;
            int fd;

            fd = open(data->file.path, flags);

The "struct perf_data" is defined here :

    static int perf_sched__schedstat_diff(struct perf_sched *sched,
                                      int argc, const char **argv)
    {
        struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
        struct list_head cpu_head_ses0, cpu_head_ses1;
        struct perf_session *session[2];
        struct perf_data data[2];
        int ret = 0, err = 0;
        static const char *defaults[] = {
                "perf.data.old",
                "perf.data",
        };

Here due to uninitialized "struct perf_data", the arguments to "open"
is getting wrongly passed sometimes depending on value in stack.
When perf_data__open() function calls open_file_read(),the
"in_place_update" could contain garbage value.

After initializing "struct perf_data" in perf_sched__schedstat_diff() function,
perf sched stats tests runs without issues in multiple attempts and also
"perf sched stats diff" ran individual without issues.

for i in {0..20}; do ./perf test "perf sched stats tests"; done
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok
 92: perf sched stats tests                                          : Ok

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/builtin-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..5d2740099eed 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4538,7 +4538,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
 	struct list_head cpu_head_ses0, cpu_head_ses1;
 	struct perf_session *session[2];
-	struct perf_data data[2];
+	struct perf_data data[2] = { 0 };
 	int ret = 0, err = 0;
 	static const char *defaults[] = {
 		"perf.data.old",
-- 
2.47.3

