Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22D1591F0;
	Thu, 27 Jun 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495502; cv=none; b=GIgRMbEax916UiwNYRm5j+x4jBlGp4WVYtV2PqoUoWd3KBRmX8FzZpD4qNrnxJOJSmH1gwLAdBQFqy0XopggU8wdt5TEnTdBOes2l64P4UfzMnheplLqaCukNEUa8Q9bJtV8i/wRUUTZCawuFUoUuJ5zjcJsjiIp6Shr0tfahbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495502; c=relaxed/simple;
	bh=Wwr5SFLweSjVAg7AZ0LyTnhyIf6EXInYU7IwdmAJ9O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNUzLAt6xEsNcMekIgW49PGpVq32hq5qB7bW7GBRO+cxJFyPVDbV0zOFdpkCT4jovJAWHXylc+fc52iMMfRUXPprG3lEgxxzU8jbX2RjqVrz9l4ZrYN8EjmBBqi34YRk8y/caNIxFcOmtOzM70bLVxsKIG5KGKZw1SHi8RiBm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gcOuoApZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gcOuoApZ"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RDQu3M028935;
	Thu, 27 Jun 2024 13:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=EexzgJBj+tt6+l2+7cxvFAJb/k
	4mJCbDy4YUYm3EaMQ=; b=gcOuoApZuwcjzFaPJjnKzH1qsGVTK+efOHkjlI3Lro
	AwWI4v/o9+J42IqllmJtZv4n+OWXxjdHgT0z8g3gSgC/jLuAF43FrdqkwGoVVZ3v
	yEFSh6WDBKBQtBfPaEgcDDPI7NMMcdZNB/Ka//AOsBMaGoLJOufEABKni4yVI24S
	fKruT1SWXX1YF6o5o8lF4xSl0BxnESsl2hyRId1bnBriR7a1qrt4qqYTmtsvmqux
	Ce7+nV7hVqsqenWSuku1xs9l5udXyl8tzZoxDOpaRwfpRyrZAwsDZ3I1q/Xqxnmy
	fSGo6i+jSYYQqmt67OzFWPARub6orJVWOuc1CyyBingQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4018jhr2vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:37:54 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45RDUG8N003475;
	Thu, 27 Jun 2024 13:37:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4018jhr2vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:37:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45RBJQn3000564;
	Thu, 27 Jun 2024 13:37:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaenaue2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:37:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45RDbmjT55116164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 13:37:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69A4D20043;
	Thu, 27 Jun 2024 13:37:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19E8320040;
	Thu, 27 Jun 2024 13:37:46 +0000 (GMT)
Received: from ltcden3-lp14.aus.stglabs.ibm.com (unknown [9.53.174.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 13:37:45 +0000 (GMT)
From: Abhishek Dubey <adubey@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH] Perf: Calling available function for stats printing
Date: Thu, 27 Jun 2024 09:37:43 -0400
Message-ID: <20240627133743.407048-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T10gs8bLWGzO1eEpJxWH5rJm_0T4n-kz
X-Proofpoint-ORIG-GUID: UiLTGOdyY01ZP8Y-FWMaq8WXAY4Bg9cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_08,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270101

For printing dump_trace, just use existing stats_print()
function.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/perf/builtin-report.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 69618fb0110b..8678eebc49e6 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1089,10 +1089,7 @@ static int __cmd_report(struct report *rep)
 			perf_session__fprintf_dsos(session, stdout);
 
 		if (dump_trace) {
-			perf_session__fprintf_nr_events(session, stdout,
-							rep->skip_empty);
-			evlist__fprintf_nr_events(session->evlist, stdout,
-						  rep->skip_empty);
+			stats_print(rep);
 			return 0;
 		}
 	}
-- 
2.44.0

