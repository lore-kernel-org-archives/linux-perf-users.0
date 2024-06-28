Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9F1E50B;
	Fri, 28 Jun 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599575; cv=none; b=KsOxvlGOR81zSrOe+z74qPf/kLvpxkqEQAdWARaUwYXJsdsvYklgueYV+MsY+Xzpu0LWwpFhzdL3u8t1FmvtY/GulAUz3wd1lEU01CykfjLegnvU7M5qkCLU/NgdX2LajOha6N0cfUWJW34PwZed5wdMv/6m5BjTVUVpcTPVifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599575; c=relaxed/simple;
	bh=3WMX+8dYH4smiEAoQsiSB6rmSuaLqfLq5O2FIcd3ijA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLWQQaQXrGv812mlAsdUDJOnOpVFUrWetBNFT3R3OuOzqVBJa5TrdZcXML1SAqbpW0lN8Px31jxPOgrWNJCa3wPYlkL3mP+jxC7NVwLcMuMl5UoL6AMip2DWAyDUYVnAZmIv7aQQ9Jtl/Vd1nF8qNXXkiN+QUWrSSO2YEmbHIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QGQOnwF3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QGQOnwF3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SITjmB019024;
	Fri, 28 Jun 2024 18:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=uWEtcjQkVsXYP7zz5baR3/Agzt
	ubsT255FVG3/FAg/g=; b=QGQOnwF3F16H25E6l1YBEkHE9TLX65GCu31rHhI3hI
	9nC5yj+dYrFVTXzweTZ+G8Jnt0sn/w2m3RLyOsaDzAcMA3jYBeS72sA6jK4AGLUV
	XG7RyiRNc/3xH0B3tG/UdmXlZWIdEYQCLbNBMO9Wyb5FzhoMKAexKw0yUjqAjVSZ
	7qbVfOskkmF8zhUXdROJTGKsdEmAiOZmgr66aPzv5fh+Ecykbvk/Ci7fL4vegPFD
	njZxXxUV8C8BJv4iTPeQuQ3Dv/2Jy4JhB5xsPFTBONR1awM5nZh/B6ZN1mIQjJ0M
	mLYz5BGS2bo7dog+kLeWA9t7mDQUdhorSvJw5muNayLw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4022fvg094-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 18:32:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45SIWYgj023524;
	Fri, 28 Jun 2024 18:32:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4022fvg08u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 18:32:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45SFMfHH000411;
	Fri, 28 Jun 2024 18:32:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3scsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 18:32:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45SIWUa656361282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 18:32:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F23DA20043;
	Fri, 28 Jun 2024 18:32:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F0220040;
	Fri, 28 Jun 2024 18:32:27 +0000 (GMT)
Received: from ltcden3-lp14.aus.stglabs.ibm.com (unknown [9.53.174.165])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 18:32:27 +0000 (GMT)
From: Abhishek Dubey <adubey@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH] perf report: Calling available function for stats printing
Date: Fri, 28 Jun 2024 14:32:24 -0400
Message-ID: <20240628183224.452055-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5VwGW74Y-WPaUyKou2ABU2nyy_sv7MlL
X-Proofpoint-ORIG-GUID: _9a9l5m5VVUfykp2eAShrtnLgRYzVwRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_13,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280137

For printing dump_trace, just use existing stats_print()
function.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/perf/builtin-report.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9718770facb5..6edc0d4ce6fb 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1089,8 +1089,7 @@ static int __cmd_report(struct report *rep)
 			perf_session__fprintf_dsos(session, stdout);
 
 		if (dump_trace) {
-			perf_session__fprintf_nr_events(session, stdout);
-			evlist__fprintf_nr_events(session->evlist, stdout);
+			stats_print(rep);
 			return 0;
 		}
 	}
-- 
2.44.0

