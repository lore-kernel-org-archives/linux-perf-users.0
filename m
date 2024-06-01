Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E310949;
	Sat,  1 Jun 2024 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222229; cv=none; b=GVUN/x0VKigcyA6rU/k/QFdeBGVQdJt9sg81MGBHAkn5nE5ozDYlXv/0Ct3pWkgZOyOnn/g6a5/iIIkyyaNui0kHpyo/Yy20W99ZL1JaSUhrT6ks1RHWswaaFBTdxbuGudMjJoA7Q3jAxobK4+caGiaTNXLTck2JTuES4AMjl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222229; c=relaxed/simple;
	bh=kLmDOeMZpkz0VHmekJYB7M8nZtXJBf1+O+bsMI1/h2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bx70ZyHeCz4zRNPd2vGEJAYVeCMGnnCxNkb+SMf2GbcMxgbOB1VqeXqtmNjrjMMk2XCD0V0WHoNuSNjIyVvsQsrfz2iYWOY/0xjvjfQg76lxJxXrpXwjmL7LRpCPpJdLBj/Oen115HjGa2Ky07I7/ZBQVCG5o1NdjqIA4bNz9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c/HddNRz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c/HddNRz"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4515unIR004124;
	Sat, 1 Jun 2024 06:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=4Fmc9KEPhP0+gzZCp09M75xvsPJ12fPhPCwFLXGu4gw=;
 b=c/HddNRz4P5EB8AfTHWaZMFIbLnzHpQGu95AY1hzh50+L1YBx4n0LH3M9ooZQjhQndWy
 dFlPgKq5lNc4hRqqcAfI3fnvXy4QEXE3y6pt9MtFHlb0azjQKCBCciMDBS3dhBpJ+Eiu
 n7GTgEEU3pYOlSDSntlSqCbDUuwoXyXC/Dsj6MRb4fJROkq5+OCNtuem0CaDwAXqgeSM
 S+fk2RfSZIzLBNzuWadpJcAjBquUYnGvc5vqMUwBa26Psmy8PDCSxwNYuIbsIl92xnyy
 4mWLW/mvS1LBhjmGwmbUTBOJBIfEboF4N4CxO0zg1PsT+GAovjOJDqacvQJfTxQVhG9D Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yfw56g3nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 06:10:11 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4516ABw3027977;
	Sat, 1 Jun 2024 06:10:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yfw56g3nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 06:10:11 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4514JDwn022536;
	Sat, 1 Jun 2024 06:10:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yfv180jxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 06:10:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4516A40q21233950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Jun 2024 06:10:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B658B20040;
	Sat,  1 Jun 2024 06:10:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B24B72004B;
	Sat,  1 Jun 2024 06:10:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.41.43])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Jun 2024 06:10:01 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V3 04/14] tools/perf: Use sort keys to determine whether to pick objdump to disassemble
Date: Sat,  1 Jun 2024 11:39:31 +0530
Message-Id: <20240601060941.13692-5-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240601060941.13692-1-atrajeev@linux.vnet.ibm.com>
References: <20240601060941.13692-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FlFfSojoWaecclMeMKvU5r-MW1PbDapv
X-Proofpoint-ORIG-GUID: 2RJ9f_b6ULZB6wDfpB4QSWgVcKoBfju4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_01,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406010045

perf annotate can be done in different ways. One way is to directly use
"perf annotate" command, other way to annotate specific symbol is to do
"perf report" and press "a" on the sample in UI mode. The approach
preferred in powerpc to parse sample for data type profiling is:
- Read directly from DSO using dso__data_read_offset
- If that fails for any case, fallback to using libcapstone
- If libcapstone is not supported, approach will use objdump

The above works well when perf report is invoked with only sort keys for
data type ie type and typeoff. Because there is no instruction level
annotation needed if only data type information is requested for. For
annotating sample, along with type and typeoff sort key, "sym" sort key
is also needed. And by default invoking just "perf report" uses sort key
"sym" that displays the symbol information.

With approach changes in powerpc which first reads DSO for raw
instruction, "perf annotate" and "perf report" + a key breaks since
it doesn't do the instruction level disassembly.

Snippet of result from perf report:

Samples: 1K of event 'mem-loads', 4000 Hz, Event count (approx.): 937238
do_work  /usr/bin/pmlogger [Percent: local period]
Percent│        ea230010
       │        3a550010
       │        3a600000

       │        38f60001
       │        39490008
       │        42400438
 51.44 │        81290008
       │        7d485378

Here, raw instruction is displayed in the output instead of human
readable annotated form.

One way to get the appropriate data is to specify "--objdump path", by
which code annotation will be done. But the default behaviour will be
changed. To fix this breakage, check if "sym" sort key is set. If so
fallback and use the libcapstone/objdump way of disassmbling the sample.

With the changes and "perf report"

Samples: 1K of event 'mem-loads', 4000 Hz, Event count (approx.): 937238
do_work  /usr/bin/pmlogger [Percent: local period]
Percent│        ld        r17,16(r3)
       │        addi      r18,r21,16
       │        li        r19,0

       │ 8b0:   rldicl    r10,r10,63,33
       │        addi      r10,r10,1
       │        mtctr     r10
       │      ↓ b         8e4
       │ 8c0:   addi      r7,r22,1
       │        addi      r10,r9,8
       │      ↓ bdz       d00
 51.44 │        lwz       r9,8(r9)
       │        mr        r8,r10
       │        cmpw      r20,r9

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/disasm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 89a9e4136c09..3cd187f08193 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -25,6 +25,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "util.h"
+#include "sort.h"
 
 static regex_t	 file_lineno;
 
@@ -1803,9 +1804,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	 * not required in case of powerpc.
 	 */
 	if (arch__is(args->arch, "powerpc")) {
-		err = symbol__disassemble_dso(symfs_filename, sym, args);
-		if (err == 0)
-			goto out_remove_tmp;
+		if (sort_order && !strstr(sort_order, "sym")) {
+			err = symbol__disassemble_dso(symfs_filename, sym, args);
+			if (err == 0)
+				goto out_remove_tmp;
+		}
 	}
 
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
-- 
2.43.0

