Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E057080D
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463648; cv=none; b=DjFMDuU7SjOfvpst1y9wVRxGmcpHgDdxByFudbO6HeHrO1S5dRBPxF+aW0IhAKy49V6AMmBUNF4TBnuD7LJbhVytbgGpmF38pJEmR9VMyAlkKBqU1bj7dMs6tqTAQdc5BaUK9+8SU6pmA9OcUiaAq527ZixZRnaDSuDBhLnxv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463648; c=relaxed/simple;
	bh=VixBwaY37c/GKzlxUTZFG6eV+3uilXtmGuUbxxhqWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KH5p7sw9eaf59hqpl8DYO+K4cRnekO9zivcrrdv5lL04+FRcOF74MwzH2oZsLDbIxkwXiK1hC4xAOhyuumID1idMUU+XNAyI+ntGaUdkedSFsAarg/SzRLSlBxZvuSgbOAkLUXtTSeRTh4ffMr78bKqfcCOGpL/R54ucmngRw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eKyrUB9E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eKyrUB9E"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAwudC012222;
	Fri, 25 Jul 2025 17:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2E6dVsgb4uGCe+dWm0wDHx3nmX4ST39WMK6PS1E1p
	fM=; b=eKyrUB9E0UeUZrRNBwz4CodxrFARTJh3SJ09uG2w2sXmq5ECa0BY29+vu
	NNHtQxH2Da3qkJd/6uu8J63XgnmTyzcccphN6Ecbky7rXrjjPiHZzAC5CdNgRSLF
	X+tODbKqh/8flmm+cNKlny+Y9aiQ33WRS4Q5TRCA1fVl5OkK1br+hbWo2esGnPq1
	M0PmBPkRgRv+WbUbG5pB/F/y5wfS5vNKW2nr4nH6GwDDAXeGP9267TneQJuno05z
	jnJlfV5mHWuiRQIhaXShLhdl78YnXMKgEOuhHMBbcvmgHqbCWB1dRlG6IigNbBtk
	Bk3Y1qG8UXeX+t8LldYRbVdflfFJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wchmb6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:14:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56PH5b0G007357;
	Fri, 25 Jul 2025 17:14:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wchmb6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:14:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PFOTAT025005;
	Fri, 25 Jul 2025 17:14:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480npu2pqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:14:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56PHDvKw13828478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:13:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 465B520043;
	Fri, 25 Jul 2025 17:13:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C6A320040;
	Fri, 25 Jul 2025 17:13:57 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Jul 2025 17:13:57 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
        tmricht@linux.ibm.com (Thomas Richter)
Cc: linux-perf-users@vger.kernel.org
Subject: [PATCH v1 1/1] perf tools: Fix auto-complete on s390x
Date: Fri, 25 Jul 2025 19:13:54 +0200
Message-ID: <20250725171354.3180806-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q7rS452a c=1 sm=1 tr=0 ts=6883bb5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=mDFymc3ylq8IewzSma0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE0NyBTYWx0ZWRfXy5Aw4fCfnyZ3
 7XXe+ajRzVEPH8oFAtjHQ1LvMapQUySVNJKMNh/YB/ETdF03tbSrHxCmnyxNnKK2/kcGXk0FRjv
 NiuvWQVyH2L8U7/TlywB/pXDcFZRq5lJaxMWi6tO1176PROJrtBLXRIcPSu0qZcOR6n+uQnwYJr
 hP3v1sQX2NHFXUbg78qqzMjOMTdvDMS0HgfT6WMz8Ayoz+tYcClDZ37CKMQXUuDSvdd9RKOyTkO
 8xrrmNvj9MHsLYpCDIhaNP5RklLQvq+Ls1zpNd61C+nx6ILIBvNRG5U6/uD9xTFDiooosexzIbz
 J8umaPFo8dz6/T54lE3IHPj/X6EqUq7P3Y2yjStrLGMPm5K+4WsD7wso3GM7ShKMSuZ3WAIPpCI
 D6k9I0YfZI65Te2swlM6xGqMEmmKs+NDea6q6YHaO+hg8qnVEOU8ShwJGr/3nuAO/jF3+JA6
X-Proofpoint-GUID: FIm_J0MSUADONJxrHT6AvoznMv9v8XND
X-Proofpoint-ORIG-GUID: ukIqO2ZpCOprfe3yQTN46yqLF2zT7sTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=913 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250147

On s390x, CPU-related events are not located in
event_source/devices/cpu/events. Instead, they are found in architecture
specific locations depending on the hypervisor configuration:

    /sys/devices/pai_crypto/events/
    /sys/devices/cpum_cf_diag/events/
    /sys/devices/pai_ext/events/
    /sys/devices/cpum_cf/events/
    /sys/devices/cpum_sf/events/

Using current auto-complete script result in the following error:

    [root@localhost perf]# perf top -e
    ls: cannot access '/sys/bus/event_source/devices/cpu/events': No such file or directory

Fix this by skipping the check for
/sys/bus/event_source/devices/cpu/events on s390x systems.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/perf-completion.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 69cba3c170d5..8db6de98007b 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -168,10 +168,11 @@ __perf_main ()
 		local cur1=${COMP_WORDS[COMP_CWORD]}
 		local raw_evts
 		local arr s tmp result cpu_evts
+		local arch=`uname -m`
 
 		raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
 		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
-		if [[ `uname -m` != aarch64 ]]; then
+		if [[ $arch != aarch64 && $arch != s390x ]]; then
 			cpu_evts=$(ls /sys/bus/event_source/devices/cpu/events)
 		fi
 
-- 
2.48.1

