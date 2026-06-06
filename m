Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323E317163
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748438; cv=none; b=cy6yQ6n4y+OYzlDprKANMxQj2ex3mlpystdueaxH3F6mego16nVHvodDiokikmqMC8K1o6NzrHHWrKV9pjpr7HKJK8diA8UO3KUVQwdaa5bxoQTMTbWhMeoV8INQu+zmN4UY6iJJqsqes3u+6hoJ9slbAr1alvTE1lelXa1RnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748438; c=relaxed/simple;
	bh=tZn8Rz1EQHDytNLZil0azW00KP1vF8fqyFm8k1Eu0kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7NoJct53ixBeR+PgHa1lTEQWMMEXU8u0oUn6TmDvxa+k+Ltoqn9PV0ejib8bUOyf2ovGtjuUOvtskRIAFw9FFUvxE0TpJuD9ESIS0zNwD5+6GhbFqLwh+2OIgPUEoIUpMLzUE6rt8ePuLdxuN5kdJV2gBmr8M/Db8XzfoyQMpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LVxdZk3Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LVxdZk3Y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656AIBab690954;
	Sat, 6 Jun 2026 12:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fLwS1YIxOJfufyjYhB52Uo0u9IFZTzVVV64omQWyY
	zo=; b=LVxdZk3YVzY6aUMp4wOqhdoklVmsOYF0zkUh6Peb/OXa4Vsd47dI5Gi7E
	Rh/Lnp2nwcIF35j952KppJTBVabnd6XHxUwWS8RyzTVwQJl1uqTMc9TG2tGeJ84u
	QH1PBeXCxj5YT4SSwW8+RkQCCl8PxvI5jCjjnk+MMzhCADKkw7pBgJbo1YyaI3s2
	z676XPt9RovE2qkdjGpE+/DMN82/phC5ofZVlbswFyjo2/5khiB53K+346hal5Hn
	OiLGvnbvsCzm4q7cGcsBSwyB4zeTs6NqPLn4P+O9pfQjlJmi0Hd3X6cdCZW1GtZj
	BiJWyVAMtr0wlCStqmyitZV3fGSjQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9yds4m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 12:20:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656C4Zhx019232;
	Sat, 6 Jun 2026 12:20:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qwtq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 12:20:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 656CKNTg59572716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Jun 2026 12:20:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F24B22004B;
	Sat,  6 Jun 2026 12:20:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F68D20049;
	Sat,  6 Jun 2026 12:20:17 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.26.37])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Jun 2026 12:20:17 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH] perf data convert json: Fix addr_location leak on time-filtered samples
Date: Sat,  6 Jun 2026 17:45:29 +0530
Message-ID: <20260606121528.406919-2-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMSBTYWx0ZWRfX8Iw0SN3iFMPH
 wguFV9Ws3di2OXsJNfhYZHrpNGTaGowB68+1Kjprz/x49/de5iE02z/u+VlC1gOukNrXR3DXnaX
 SDLrLKPT1QRkiP9GxsKd7xSEj3lyzuwuD7M4YgVHW0BUR5/7ckBorQI5qdSlrPMgNbavVee2NcV
 RWeLG4zeVXTvtMKuxvfdSu4uFKTlCvhpMmFBXnMhgytFnx2l2jUeR2DG3AEgfEx4tsYHwqsRrLS
 m6yInnVW06MGcGshficDPUX7sL0t1f0nGn7m4M8xGLBK2BYjNOMKeqiOUnTeFTRHMEQfZCRaOXb
 hoQPrrzDKwYmHNqnvfm5sHnu1nwesCq8cFgLaSOrMVkNPgYHTtxMubXTuNQkCLaiOTWAsYdCfiq
 PO8REQHjsVSW9ovPVQ44LStrIAYVOZds6LSwuV/DoE9pDrnHnkw0mIKNcUMKmDwOf9KYgeVZHJ3
 S6fDNAbzNch1EAeeeoA==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a24108b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Ty57jLF3Lfqec-trjoQA:9
X-Proofpoint-GUID: rHho-ua72mM_R4wr9ymYhgyxrzht8VKz
X-Proofpoint-ORIG-GUID: Kyj7MI4yhoK0fw0vmueOMv-Vmd6nQHRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060121

When samples are skipped due to time filtering in process_sample_event(),
the early return path bypasses addr_location__exit(), causing memory leaks
of thread, map, and maps references acquired by machine__resolve().

These references must be released through addr_location__exit() before
returning.

Fixes: 8e746e95c3e4 ("perf data: Allow filtering conversion by time range")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/data-convert-json.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index d526c91312ed..6a8d00c80394 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -177,6 +177,7 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sample->time)) {
 		++c->skipped;
+		addr_location__exit(&al);
 		return 0;
 	}
 
-- 
2.47.3

