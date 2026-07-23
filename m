Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148D4322F9
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799665; cv=none; b=P/S9QZ1ukNl6BtlkbSrdp235a8ZccgmvE+7eXhkikdHDlEbMfOfNZJU432yzSzw2sZgISHxrpVXbKJM3BB3qnvyPaKlIinB3VXqxsWAHOdHwutpm5xJV4JXwy2vIEG3XYUHUAxn+EWc+6sXlODJG5hOLsHqiH56hBBkGPwYB0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799665; c=relaxed/simple;
	bh=ylM/6ye6xypg9DLWF3GDHXcW0l5CSp5KaDRbp5xdWkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByrVHfsHMIn/F1Y8vV0U23wWGJamHYCwdOQJh9pHCOawf1NmXCjQxFi2e2U8kSjwwy0VfskjCzMk1lIFPo+XaSDqiZylba57TrJryzy/QvkE0dTBhuYWgBGFQALWoFaRzWSJ+c9ZBlDomfJqMyIR2zUeTZce3vggtg6rGecnCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GbbcFNeH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GbbcFNeH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9C8Gm2586682;
	Thu, 23 Jul 2026 09:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w7d7iOIr4JYo5xD1x
	ds79ix5oGBdZQ9fFETxdf9csPQ=; b=GbbcFNeHwJL65TvFlpsgSWLpukDed1aXr
	2Xi5wFXk9WqJcB/WtbfVGopttQToz7jKETIslqleZvUG8tQI5xOzF97tjMvBPBVy
	1q12AAbKmbcpUjnNRhb7Bd9iVJL7AbtJOuhPYz+IPbLZjED84QVC6JafBK4cHM+S
	NgFkkJPDV42Te1D2oGdUqO6M3iGKBCcujj7wGlnBNLbvh3fkRUwoErnGRKJbaPzo
	FoLDUE1axrO5Mfd/+bJpQuqoEvruV0a1IAJKpTJoSYlOQSWH+VeUa7H6Xc/+ciy6
	FoVZA5PbxQy4zq4QV0TIifyZPqrBTwS+DNaQuEBmBuCSgwVf1+Utw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahe8b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:40:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9Jiig015066;
	Thu, 23 Jul 2026 09:40:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyk8rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:40:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N9eiKo12845438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:40:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 460472009B;
	Thu, 23 Jul 2026 09:40:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CA6920099;
	Thu, 23 Jul 2026 09:40:33 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.bl1-in.ibm.com (unknown [9.123.15.94])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 09:40:32 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v2 1/2] perf trace-event: Fix buffer overflow in read_string()
Date: Thu, 23 Jul 2026 15:10:00 +0530
Message-ID: <20260723093958.416650-5-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723093958.416650-3-tshah@linux.ibm.com>
References: <20260723093958.416650-3-tshah@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jfj39XiJyy3U9roaTGL-bTd5Vh1LJDKE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfX+dpk+nU86Hvt
 jNZ+niizBrThTymXXcVmGMKDk43/jgjxCBuovVMF640QhCtDnNWoPOVOmKWMA7YnyEq28aFB2I2
 NC2+khHVLMnklUV+bKTBgtvosQ3s72LBU6yFtoO6J4YsG0+WugYHaV8u2CetSTatPJoULIZU4Fh
 EbkazE4w2rfqisuHjJU9kVRNEQcToaYLMw8DszBG1r3vyymddpq5CTL7AB+jfhgG1bzbMaUGV+U
 CpAB/4uVu7RKhCPjjMBhOlcd0OR2lPiBAjBniaG3JQYuuf/7Kqj+DRaVwBZv4kH31NqiKE3c5/t
 f9lh+bDB0YnLWLE/eAx9YVKzCP7ctbe4uTpc00w6LHJDBqaFovZNH+pmNjtl0TMORuZL4W0yGA2
 C+S2oeNDIJXfdI0yyCrwCsI7LXiB7uArSLKAfiyccgBLdygakU2vcCQGanHa8aoHP7D1f0XWfy8
 k1NLB/DTxNUJu07qLrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfX84eyvaUKzOB/
 uEDqMsPyu2kYwBE3eaAaM1GB9I8pUH+4vJb+8rw4izEatAKG+3+CsU0INNDtRlZ03ZbEmlGQejb
 0RT+6zkzSyRfxjSx6HsLg6RjG/7cdkg=
X-Proofpoint-GUID: jPT4axtj0K6X_FYyTrx1eHLoPWWpW14T
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a61e1a1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=dRiuFSZL0wyzTp01T68A:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230091

read_string() writes into buf[BUFSIZ] one byte at a time without
checking 'size' against the buffer bound before each write. A
string longer than BUFSIZ in the input overflows the stack buffer.

Add a bounds check before each write to prevent overflow. On
overflow the function returns NULL, matching its other error paths.

Fixes: 9215545e99d8 ("perf: Convert perf tracing data into a tracing_data event")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index ecbbb93f0185..afd458cf1387 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -127,6 +127,11 @@ static char *read_string(void)
 			}
 		}
 
+		if (size >= (int)sizeof(buf) - 1) {
+			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
+			goto out;
+		}
+
 		buf[size++] = c;
 
 		if (!c)
-- 
2.47.3

