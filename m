Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECA31ED80
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840994; cv=none; b=ONerFrFWE2pWRl8ahEH3g83cPs8Br4Lpapi8CxSB9iSGxhAIK7fO+W3FxB2clMa/zxCwP7qEmxSxBZNxUgeF6gCawSOFfaKdlq5pQ1dI+UNnl/XkB3gy8hddfpSBMtlHZRE4XOF9lycoWC5AzaNW65SOI9TFSUuvSH6go5UgvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840994; c=relaxed/simple;
	bh=p8xQYKGgNa7FffzeNPHLtsRdlHtV1TQ30T+oetfX9mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UJWRVMj+KoJrxDvw9mmOQ2rJZ6RUAxqBD2tavGRZVYBqJ0WLzZ+Qa2F6K9Fgc57n07/K5rbtuOC7mahmje+YjUAOKchRNTD79tuIzuvyt6ffrbbwRtU6mrNmrhfBZ9qO6YzHGHkkF37Cq3u1/yHvvKqJFswyfFoI3x5lphZe1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rn4Rd2hx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rn4Rd2hx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657AudN73165130;
	Sun, 7 Jun 2026 14:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=92/15F0E7K+Gmt+DJNN7hwn2qqMr+y9fsv+d9JcHM
	Sw=; b=rn4Rd2hxuCXauF0SKbdEeMiCxkfSjWvsQFs01D11AwystNSSaW4FEACIY
	h+CcI/MjFc1OysbPiK2YLeXv7l5g1sXzu6debB/8yFIKCHEcth/ECZGT7Ox0CumG
	ejsAeWm7TQifUrE6aCxbbUFUU3AHXXOGSd6sNCJ53IO/YmQYxDkPFQMbpFpkmyyo
	ZPk6F8gq+vAVZT9DPsZ/IntwhNnNQkb1pxb8X1zUuQJzPn0vyjjKH5yEAVgjVYeK
	TAaxcs9tfE4qNli9mmXWahs2Ak1/5a+UYdkPM3TiZRjPyG1f7LQUSzLLYZFOCOcF
	BU/fUC2jiTvI8cuowp+9o6179FmJA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhm2h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 14:02:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657Dnapd026868;
	Sun, 7 Jun 2026 14:02:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vssdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 14:02:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657E2rYL57278722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 14:02:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08A9920040;
	Sun,  7 Jun 2026 14:02:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4222220049;
	Sun,  7 Jun 2026 14:02:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.16])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 14:02:48 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com,
        venkat88@linux.ibm.com
Subject: [PATCH V2] tools/perf/sched: Update process names of processes in zombie state for both -s and -S options
Date: Sun,  7 Jun 2026 19:32:45 +0530
Message-Id: <20260607140245.95706-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEzNSBTYWx0ZWRfX3gBK3KsX4JoS
 mfwFHmYiPJsRlr9iPxTvaEjLc8i8Pmp9yNyFLPya3/ACc7tSBFP9K2GtnMQu6YevVsL9nNrV7eb
 TY42Vt22DZOk5LP5XS+Kl9epVESPX1pCiKRqrT1QmFBkdJ+5YEvE/+0AAqAX020nKbwjadEH72U
 4j9XmlGAANk8xJac6ZL0pdgw4ANV+Hi3Z7wvM3SW6Fvg+Ee2QYUXTioSxhRVp4KQ0fIsKarWjLi
 eaJwNpN8y2LK8IqpM7MSY+7VleE4kNtVvuWHKjtw/dOi77mMKcoPkzRMBDqxzr3YY6lDFl96hv/
 On/p0gjhyGdCnRBoedWvzAn3ZStMVkogvZiApf5sZwem82SXDRn/9GVl8IQEQizGVQYec9NC9bI
 ukDfSqtNBMqrViaLjsibEU3LgVjvbRDnGon5Izfq80WaJguOsxkfUYF8TUbNI7nbLZwac+z/Pvg
 6YeA7RNjWY9+Y+gPxWg==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a257a12 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x5QCPqNzQhPJdF4W:21 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fa4VNzToAjw6E99RSBIA:9
X-Proofpoint-ORIG-GUID: LdMLDzD92-V2GmAAqTuh9EgA5zOWuSYO
X-Proofpoint-GUID: T-BxeIh0jjcDaAGtp5M1DMOMxB4iGfxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070135

In redhat perftool testsuite, observed fail for this test:
    -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary (output regexp parsing)

This led to analysis of "perf sched timehist" summary options.

  # perf sched record -a -o ./perf.data -- sleep 0.1
   This will record using perf sched record

perf sched timeliest has two options "-s" and "-S"
  # perf sched -i ./perf.data timehist -S
 -S : Captures summary also at the end

  # perf sched -i ./perf.data timehist -s
 -s : Captures only summary

The test saves -s result which has only summary and compares with
summary which comes at the end from -S . Since there is a difference
in these two, test fails.

Checking the behaviour change in -S and -s results, difference is:

                  rcu_sched[16]       2          4        0.013      0.001       0.003       0.006   33.23       0
               migration/11[73]       2          1        0.006      0.006       0.006       0.006    0.00       0
                migration/3[33]       2          1        0.006      0.006       0.006       0.006    0.00       0
 -               :216753[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
 +                 sleep[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
                migration/8[58]       2          1        0.005      0.005       0.005       0.005    0.00       0
            NetworkManager[811]       1          2        0.089      0.028       0.044       0.060   36.06       0
               migration/13[83]       2          1        0.005      0.005       0.005       0.005    0.00       0

Here 216753 is pid for sleep which is a zombie process. This is
happening in latest kernel due to an update in "-S" result.
In -S, the process name appears in the results "sleep[216753]",
where as in the -s, only pid is present in the summary result
":216753[216753]".

After commit 39f473f6d0b2 ("perf sched timehist: decode process names
of processes in zombie state")
for -S option, if process name is using pid, it uses different way to
set it. So that we get the process name and not just Pid.

This change went in only for timehist_print_sample() function.
Add this improvement in generic place so that even -s option (which
captures summary) also will have meaningful information.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog
v1 -> v2:
- Rebased on top of latest perf-tools-next
- Since there is no change in logic, carried Acked-by from
Namhyung Kim and Tested-by from Venkat Rao Bagalkote

 tools/perf/builtin-sched.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b7ccdc6a985d..5d3761a27e67 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2259,12 +2259,6 @@ static void timehist_print_sample(struct perf_sched *sched,
 		printf(" ");
 	}
 
-	if (!thread__comm_set(thread)) {
-		const char *prev_comm = perf_sample__strval(sample, "prev_comm");
-
-		thread__set_comm(thread, prev_comm, sample->time);
-        }
-
 	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
 
 	if (sched->show_prio)
@@ -2965,6 +2959,16 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 			thread__zput(itr->last_thread);
 		}
 
+		/*
+		 * If the process name is not set for the thread, use "prev_comm"
+		 * to set it. Otherwise the sched summary will have just pid information
+		 */
+		if (!thread__comm_set(thread)) {
+			const char *prev_comm = perf_sample__strval(sample, "prev_comm");
+
+			thread__set_comm(thread, prev_comm, sample->time);
+		}
+
 		if (!sched->summary_only)
 			timehist_print_sample(sched, sample, &al, thread, t, state);
 	}
-- 
2.52.0

