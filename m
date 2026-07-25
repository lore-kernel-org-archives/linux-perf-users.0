Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91529AAEA
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007063; cv=none; b=evjzHiTnYA7F0CJ4jHpMQOtFIuNd6TEv7keQUAGrUzGGzDjeIFbi7qpQlraXczc9nYE4Xqqetpwq3X+dQpRB7OI01i03SjQ05Gnqdu02qqa38kx+HE6u6Qfmqqu34sAkMLCGsNkejt9ANrXhxD8dmt5Kh/s45D8UwYRBZQ0Lpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007063; c=relaxed/simple;
	bh=FYforzYMvpJp5YBtZneC02PLTr5Cd4S13sUPFgIDExs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW/jE9u2PQu7+G3NnM2x30T8hHDORV7qujNLxD25R09hNOFc4wLdzl7076wVpL0mJR7JxNdjdL9OL+0GNybiHaKiSIf8/wGXyMGqnReV/apfwDJ9cmfXuSgvtNIIg1JPekFlmz/85Rw24bGadR7O5vpFNWDfGkU/0O88iuz8l58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a9kpkihT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a9kpkihT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHIC0N1107103;
	Sat, 25 Jul 2026 19:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GEciWD0V5OYIPDh79
	eg/c7FaJ+tihJi9MT5y5NYVOQ8=; b=a9kpkihTNRzIR3dDI439wSczBhAyiwgvX
	QIy/iVJPGTMci5sJS84HeqK4+wnD/pLxtGKbMGBdhvq9I3tSVSz6795TsyYMqTvD
	TvM+bh9jTgRoIMfU5HD8/+XkIf5hKmg2BYjFOeDj9rs8wIJ+RNqbSlYcC3YeQFBD
	lGFblDCFororsplOabEOGiKIa/N9S7w3l1Nx6WiqpYhPwiZWw6W1g4S6l2N73Rcr
	Pi3Km8JVmVAkDO1SYOXn0QmuT+uJEnvIefA3S5HxpYj7aMxKMZt8xG5Jk6tVcsva
	x3YmRr2AiEtnE0pdJp4N9VWb04JpsBq86LVIxHlTmFIio1Cs+NOYw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0n94p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 19:17:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PJBHSQ002293;
	Sat, 25 Jul 2026 19:17:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c2a96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 19:17:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PJHR5J14418274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 19:17:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D10DF2008F;
	Sat, 25 Jul 2026 18:50:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC7BA2008B;
	Sat, 25 Jul 2026 18:50:28 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:50:28 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v4 4/5] perf trace-event: Fix heap overflows in read_ftrace_printk()/read_saved_cmdline()
Date: Sun, 26 Jul 2026 00:19:52 +0530
Message-ID: <20260725184953.234759-5-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725184953.234759-1-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE4MyBTYWx0ZWRfX4JbxvaI1/zsz
 D3Gco3QHB9wdpOpdrzaBfGlIE+yNw1D4H3PbkaNwGsemcAtPODIhWK+tk5AKP2z3dzw3xXWcxJy
 bJZUd44rS2hxDMqbaC4NVbz5OslNoFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE4MyBTYWx0ZWRfX8DIXKIWNuis7
 yGtiTbwM2QJPSNqXbHs5TUOG3cTrkZnrm441qJUt9tm8IRwwcV+DSMBOvscbKn0GQPXI1BndcEi
 f6JJm3pRYeEKeChPWfEjmSv4ez6L8YRL02vacpXwdUmzQUlElqNHd2CklCUrJZPYCBycRwtIZqs
 I66mrRBUIl8AcwGdkStjHLhp5Ld3QuNlp2TmdLmt0ebg+zYVaDb/l/JFixI6XPg71F4ztjp+nm4
 472z8NLmOpCo9L5iDX0ecXWltwx9TZ+FM9tUkZtegDRUv8/Cz1Mp7sdlaxRPEXX89k55HIEPXGm
 P8k3+MayU7FX8M4+uIzA/zlLJgA6SieH+4btagZQk+GLyIwFzo+4sw4rxr7pUe2xjI0P3GtvOE+
 bw/Hn7LA2Axej2R5ABN37D/hLGKqCGVeBjTQ4Og+0/bMt+3g8iryrUEeNnbaOY2ww00cbGO4Ge0
 m6FErc8bLwD6ZYPziWg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a650bcc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-9rAvs5ZirYhReQkXt4A:9
X-Proofpoint-GUID: yzb88wVWrMOWqAzmFh18bvCsB1VinSBr
X-Proofpoint-ORIG-GUID: yzb88wVWrMOWqAzmFh18bvCsB1VinSBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250183

Both functions read an attacker-controlled size directly from the
input file and pass size + 1 to malloc() before reading size bytes
into the result:

read_ftrace_printk(): size is an unsigned int from read4(). When
size == UINT_MAX, size + 1 overflows to 0, so malloc(0) returns a
minimal allocation while size itself remains UINT_MAX.

read_saved_cmdline(): size is an unsigned long long from read8().
When size == ULLONG_MAX, size + 1 overflows to 0 the same way.

In both cases, do_read(buf, size) then attempts to read the full,
unwrapped size into the tiny allocated buffer, a heap buffer
overflow.

This was previously masked by do_read()'s size parameter being
'int': passing these values truncated them, which the read()
syscall's own boundary checks rejected before any data was read.
Fixing that truncation (widening do_read() to size_t) is correct
on its own, but it removes this accidental protection and exposes
the pre-existing missing bounds check in both functions.

Reject the one value that causes the overflow before it's used, in
each function.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 52ed496d92c3..53f1920c3fcb 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -15,6 +15,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
+#include <limits.h>
 
 #include "trace-event.h"
 #include "debug.h"
@@ -180,6 +181,11 @@ static int read_ftrace_printk(struct tep_handle *pevent)
 	if (!size)
 		return 0;
 
+	if (size == UINT_MAX) {
+		pr_debug("invalid ftrace printk size\n");
+		return -1;
+	}
+
 	buf = malloc(size + 1);
 	if (buf == NULL)
 		return -1;
@@ -357,6 +363,11 @@ static int read_saved_cmdline(struct tep_handle *pevent)
 	if (!size)
 		return 0;
 
+	if (size == ULLONG_MAX) {
+		pr_debug("invalid saved cmdline size");
+		return -1;
+	}
+
 	buf = malloc(size + 1);
 	if (buf == NULL) {
 		pr_debug("memory allocation failure\n");
-- 
2.47.3

