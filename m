Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD02FA0FA
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932232; cv=none; b=LlDiHChIkdWjL6Aa3x5v8wS3MZ0g/L9CO8YTv1p/HOaFI6ObNViIjtNGohl+9d1BzEbUBiTyiRHLcgYOHPgXg77hJ0AmkaVkllQpk1Yi7TBSeDPNhuHPXwJBYCco+F4vy8AtNIv7P3OnrlVyifAOehoodwObiGiXHNVfcEtdPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932232; c=relaxed/simple;
	bh=SjnPi2zW1D9HtrG98Eb+zgIvS9YniiiuG4iYfKcq3Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emSR0zrZHrEZ5b4DWpNEtJRlZs0qvQJRRoTuVy9cEnq7pjZklBzgx2AWZHuqqp3sSAcB4ia3rOyNVJr3K+ccsXncWYRE+FFOZZiyTE5+C9daO7dJBD8/L/3im1dcm5hV7NluInjv2l62+luwwCNmK13Gic9uaCchWW6hiA5plfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n7ChhwSv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n7ChhwSv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F3PmQM024260;
	Mon, 15 Sep 2025 10:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sN4Kv1SAK5z+C/9Du
	14GsTaXj4uIJRc+GYlzWFU0beo=; b=n7ChhwSv+vAZ0/kY205uOVdfnAaq+mfDZ
	tgHlNQd16tblJ8iqLk7bHX+fy1Jzyp91sr8QRhmpEG0bqoqE8Ysvl7HPp3vNP/7S
	m9hcu0tQQd86MABuS9lCFHyC+59xOszJLRzMY51pJaewJO+iZxtwteEq4HD6ucMr
	G5h0fuKsz/1Zg4mNAVKGcVJa+cWAC6Fck/8DZuglTFAs+ASKKfP2vWygrJhO3rBP
	91ZPRwasUKyeBhzYqAytuLpmZA6LxSuAhnmuZ3UU7Qdji9aHBa74AuJX8/tIvgJ2
	ipkAYysKicKgsU5JLNvLJgrI/re6SlThNxgGvOWIcTuT/PZfALQwg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnhw89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 10:30:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FAL5Mc017081;
	Mon, 15 Sep 2025 10:30:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnhw87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 10:30:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6upXZ005981;
	Mon, 15 Sep 2025 10:30:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxtx4fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 10:30:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FAUKUU55968168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:30:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDC8920040;
	Mon, 15 Sep 2025 10:30:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6519120043;
	Mon, 15 Sep 2025 10:30:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.244.131])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 10:30:14 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, aboorvad@linux.ibm.com,
        sshegde@linux.ibm.com, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
        venkat88@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH V3 3/7] docs: ABI: sysfs-bus-event_source-devices-vpa-dtl: Document sysfs event format entries for vpa_dtl pmu
Date: Mon, 15 Sep 2025 15:59:43 +0530
Message-Id: <20250915102947.26681-4-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250915102947.26681-1-atrajeev@linux.ibm.com>
References: <20250915102947.26681-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BIIxWJqq0qzmRJ-8domjUrSpdAAZDcPe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDAyOCBTYWx0ZWRfX59D9gWHWPARq
 C1m3LpaI+nF2zxDOs0TODNOckXE4NSZTUxHa5PbBkxykxgpRrjFXv4+X5OnNCTebqLeADo1ChAu
 k1+qqqi6QvibZQ9fo1d+Vv032UDUBOUSiXXNEQBAdzFXG+D8VHN0zc3RSoo3Nc/EGSgZC9g2I/1
 JFs6DOBLoVPWHNkUtOmKNZMmhDm0REFrri7fNpndIq6ShZkkZ4eF4WtHH7L88qsj59SjSQkII9X
 dQkSWM/9QKcDcgmLlscHHR0WMb0pQL5RcVgy2nXO6ElgSK8cEGJstIcjmQ/IyuwPLJdOv3v3CDi
 XUo76pkswU2ZjInZGPoDEsIxq1vCojUJs7AOolROgJFSx2m43yk/FZzzxVBms9+HkDJCfm7wxPQ
 AWzlezqd
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68c7eac2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=aXd4d0V2UHYFZ3CtnQMA:9
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: 5WnJ9nvhJ4gpECodRhCpISqbVycM_-m7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150028

From: Kajol Jain <kjain@linux.ibm.com>

Details are added for the vpa_dtl pmu event and format
attributes in the ABI documentation.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../sysfs-bus-event_source-devices-vpa-dtl    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl b/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl
new file mode 100644
index 000000000000..7b7c789a5cf5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl
@@ -0,0 +1,25 @@
+What:           /sys/bus/event_source/devices/vpa_dtl/format
+Date:           February 2025
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe the magic bits
+                that go into perf_event_attr.config for a particular pmu.
+                (See ABI/testing/sysfs-bus-event_source-devices-format).
+
+                Each attribute under this group defines a bit range of the
+                perf_event_attr.config. Supported attribute are listed
+                below::
+
+				event  = "config:0-7"  - event ID
+
+		For example::
+
+		  dtl_cede = "event=0x1"
+
+What:           /sys/bus/event_source/devices/vpa_dtl/events
+Date:           February 2025
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:	(RO) Attribute group to describe performance monitoring events
+                for the Virtual Processor Dispatch Trace Log. Each attribute in
+		this group describes a single performance monitoring event
+		supported by vpa_dtl pmu.  The name of the file is the name of
+		the event (See ABI/testing/sysfs-bus-event_source-devices-events).
-- 
2.47.1

