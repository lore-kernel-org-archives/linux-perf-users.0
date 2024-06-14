Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E419FA97;
	Fri, 14 Jun 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386033; cv=none; b=r5tO78TCIeW9Ao6xyHGk212U05oauj8xqAipK15ZehuEg+vjaE8D+eNx+lRrtIojwi+sVg8Pf5WuC6/L+mW+av2eI54jICISez3P8uVP1VGvuThFrrVgBPM5upUKKYjHio8N8yCwnrKEhCr3+O4tfKC/TSDfWwaHOmhoy+r3lPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386033; c=relaxed/simple;
	bh=PrZsfYAOiXj0R6lLK6TNy01oJxtvyWOpqm2nsW7Iv2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STRc7FMEmeNM45r3sud8QbImsztni4ZKt75ROgOVFZO95QZF3EJz4XbXSSW7LnrgdKOYwHZUWOavhn+Fjq/4Stqilu0PYXn8bYzDQcqOnY0szJewM4M4ygR+0nfG+imMXvAmFCaEXFTsGTDmcUJZUKZyU/xieJTpzr97+jN0XtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WivtN8bW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WivtN8bW"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EGcYsH010850;
	Fri, 14 Jun 2024 17:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	EdKKesiuyg9j5boOaiDjOgv1kNQpKTBOZ9j4zhgql1I=; b=WivtN8bWLajwYwEo
	LpCpJWdaTNfUIhJN3BtkdfCDKVkdF3m/yWu+iSOT/LEcN6jEemHlhq7nAGrtb5T9
	/lmJDFWRgqIKQtJ/qI0iBWK+C47Y79eq5OmflMLIjRfv2cpuK/aP6zw2rtTeLtFG
	PxdK8zgbTHTjWmFW9pKi5Imi1tGUOGIFTX52eAwNpEi/2lFWWVcm47bHdwfPDWwU
	VxxgTnKQIcSS5eq7yQi+/D1PRm8YGk3r9WMD6UJXJzY4sLraLVXgq2HMT6KL+1wn
	jgUvT7ggm3DYpDaEuiQLqjOXHsS4uQNI8VwtixOzxog1gB1FUAIbe2INK+Tp7ILo
	peDi2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrsja85f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:00 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45EHR00h025382;
	Fri, 14 Jun 2024 17:27:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrsja85ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45EGlpgr020077;
	Fri, 14 Jun 2024 17:26:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34nud3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:26:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EHQrda56689012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:26:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFBC620040;
	Fri, 14 Jun 2024 17:26:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1FA420043;
	Fri, 14 Jun 2024 17:26:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.82.18])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 17:26:50 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [V4 04/16] tools/perf: Use sort keys to determine whether to pick objdump to disassemble
Date: Fri, 14 Jun 2024 22:56:19 +0530
Message-Id: <20240614172631.56803-5-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IBHo98-uGeSPKhEfzdhnL1RCk8L09COJ
X-Proofpoint-GUID: Bn2PbMuAUw-fSDQbwRuKAWUjr8mwQy8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140119

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
index f19496133bf0..b81cdcf4d6b4 100644
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

