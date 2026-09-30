Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535493F1AAD
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750410; cv=none; b=KhBrlqNLunYVJPcyvE3RxZv4PPMQ4LsBi2Y1hgam5Jy5ENhBKUpea8PYc410m0UeKiojLv4/EuuLl1ljKBbIgMBV/N/YG+8VoxWTPQZV5Y0ZG5YsjHah0rgqlYouLRC0/WdAdRpi1SYqQnjsjixfP2Ak2vWDWow7M+4J96B5ThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750410; c=relaxed/simple;
	bh=FKb6BaGaOw+y5XBKoZBVYiEHstm1iw3inajCMM+zbvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhB84eUQ5/MtZKnZUyhXEVUWIt665R9T7/IVKRyHNOO2SH5mjb8O1Sik4sGiIboE/wW15uQFOvBGODTNO4tnnZuZi02OVWKwlWFDj4up46MtUvavZomIpZj4LkoVhYuf+uCb9JlNzb2EG99mS9wZHmrWbbA1vI5zk+BgKr8ZQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JB6bR8Sx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J94tN9fS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JB6bR8Sx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J94tN9fS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U6Grb12899505
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=A81eQh/mNmH
	iDTVrzFWMP6oC61Wb5fR8bGkTk+ZPckI=; b=JB6bR8SxkavlYwB2R2oAFmSYfik
	qKiA3JBjyRFOAPxaSr5FAZwumsoNDZ1EvxiRgA+4MI1J3Kx+qcfwsgvuB3f4H7KU
	08cfYrOQlhiOXoiy+ydVHJZFv/78wYZAf/8UHvC6ERJXGTkExFi16p5V8ePitYqL
	glLVF3QnbZboWXc+TWf+vgs3xwqCytSL8jzaGmCYOHYfwJ3sCx23qV9Q+/yJr8uf
	dmWxEhQIBG/s/SPzgqx+ezFDxSvnIIHy/cGb1bd3WPkpErDxd81pq1HDv0oBWVZD
	ZCDmM0/3AT0B29KbG3EB5XNZvXGSt5rrJiEM6dQaMOfvJHXNy6osd4zq1KQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w1402wv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34d18eee3dfso324189eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790750407; x=1791355207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A81eQh/mNmHiDTVrzFWMP6oC61Wb5fR8bGkTk+ZPckI=;
        b=J94tN9fSJB+Anu5G6QIDE9Wpn41Nabh8F+M2l/BVUTEXEXZCMzkDBHsp/MgQiS+2cz
         entLSQlLk2ZgKtLAEEPisuK14/oSeXHKPSsAlFSllBJpXAq/oj7KnanSo5TlO0iLQ/VN
         WgjaXYBP0XTE6hM1mylva01LH2eW0vdsfKglqAkjD5xQ6PcFxTaTu/QgtFnYaKgrxho4
         09PldGtMhXUgxsCZe0SKNsxXfO6gtWsobGcRNxY5HvMw0nJX+1xrNoUXGmrVdPVvDVOV
         btVZlkoK/tnBWE5Y9ASmwriSYFLI60iWjSxsBjlEkAm7R7XlTLgNblmwFvLU/np1DIMa
         0+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790750407; x=1791355207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A81eQh/mNmHiDTVrzFWMP6oC61Wb5fR8bGkTk+ZPckI=;
        b=aoOpSDqXsNtzCVn2te/JY7HU/xA0rm1/cbH8QLuTi1Oh0pfi7P3DIwPcRhZyWa2VKP
         jn90rIAcYZPzf8Cgllrz+FsXBwTyjMNwZlUhZkQjz35mmDNfpdtQVJhccqKyUmCL+3Qw
         UEJXdazOuAZnzmaaGST+mjg8ts7vFQAL2JWx0kwn98m4Bd/qYWc86Enao/0yWXOyz1+E
         QsqDdqGj/tth26vdtWC5bhyQ+D9WJZ+jjcVhyFbDFuIWJ6fT5KkwyvNX+5fRxcgXfEJc
         CynUfc/0Cax3qBqvUzqXL8XKilztVXK9RtxrbrrD6pb4rp/z+wJri4t+RidqvK7uNxs8
         8Hrg==
X-Forwarded-Encrypted: i=1; AKwUvBzWGqTnK9fxMkPw+yV/cRMpmY2mb6vMYXUoJp15WQIQjkaasa9JDhypkVqWCj2cv/zZAEHNfdqOmHEx4nUvkiZV@vger.kernel.org
X-Gm-Message-State: AFuF++mYT6hXnShfLvM0A7lMf/UlDGNsUzKN7yNh71bXc39UyjboxbwH
	jddVBXe/gICKFp9RRRgI4QVEeo6HSpoK/l8P3MAz8d3eG2MXAu/yb4mEK1Hh4VqNVK+m9FXFZ7w
	7NciPACvwTQgv8f8QjsRZcK2N/VixFUE2GcN0CYDCPCrzS2jzPi4l6I1/TNPcRxpyLdsH/EQn
X-Gm-Gg: AYBFou2dajpCQVIFKU/INx7nzF2r0dhEaY3V5VTXpDUK8WweMQrhQpLd+1N4cyasFY5
	1IaaJs87n3K2oqtb46Tox8RsnOm7IdUNBupYHudLtBgDC5HcNsLiPagBaWLHv7vgt0Flit+YH56
	DdbjeXNUALdLOeqgTGvvUMOLQCdHv6b0+vtWCagixZyqsMlEbuyaiQOsR4TQd3rtaoHk0vInda4
	MPUvcRtOFIVZ+BEDhXf6W8Y6lDfrXfnpmjf8vp1cERD3I16Y9+z6zKjWvMGvFUUHq7QhzEcROIt
	8px6CJ3qAXNuPbvTkXPWNBXr8n6VAMrA0ChwGi8Hthe8no7w7JmCe/9Myu3LNPmhes4ji2EVHam
	6i+iBDDd7f7qnlTcWC/zhn/3q4LM9Y2PaKKHl69Wbm0cBHsZ/FiJ4qPKSuFuwOGKIl2F0lWOjoE
	NF3lvPrHx63KMvohD7xrUL0FFI
X-Received: by 2002:a05:701b:2515:b0:148:306c:971 with SMTP id a92af1059eb24-14d323344b3mr394993c88.22.1790750406481;
        Tue, 29 Sep 2026 23:40:06 -0700 (PDT)
X-Received: by 2002:a05:701b:2515:b0:148:306c:971 with SMTP id a92af1059eb24-14d323344b3mr394953c88.22.1790750405907;
        Tue, 29 Sep 2026 23:40:05 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d08fb50f1sm2711531c88.13.2026.09.29.23.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:40:05 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alex@ghiti.fr,
        aou@eecs.berkeley.edu, jtaubepe@redhat.com, palmer@dabbelt.com,
        pjw@kernel.org, qingfang.deng@linux.dev, shuah@kernel.org,
        thecharlesjenkins@gmail.com, cp0613@linux.alibaba.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v7 7/8] perf tests: add noinline to __test_function
Date: Wed, 30 Sep 2026 12:09:18 +0530
Message-ID: <20260930063919.608911-8-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX5D4XlR9iAmxs
 ztpQAw0LJ9Z26GGJ+mmLTz2mUDhql4gTsfSZ0aPlfM1LBLeLdS0FDB1zGonpLG5f7APBNJnk6hE
 BMJW9tVUJeb9+XEuXRWPtN+Ier1B/Y8=
X-Proofpoint-GUID: NxUwv3VjmvtcKXYZivXKa0Kj6JGeGIiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX+1GU0kk0Ykdc
 EnSaccWmnf4EtfX2z4cV31vtdo8I/Y+36JvU/elxE+fN0TYrzLK8aQbDpGV31u3Z3yE52+6iEj5
 KP1l8s8bHnqiELcmJ6vjM+tJjC2ln4zjZYFCJV7TPnb0YsQqo75yOhZhaAryZ8Txj9QMGYgjTV4
 4wbucoe9dUDeYV0rtUMJ4+Ys5egLrYtjOO4VqCGvcvPELcPY1lccI8xwSX/ojNNzfi/0OrTsoNb
 WmyXTYnSJd/JBveqGDWJmALWv/rOEeLWDLOkdlijA07aKQM7lYnT9eOQ053BD0t9XePLISNwhrv
 YlyfaVT2uAPBWZJWfgbu11qjinm/8hyqXfYZFqzTQ5lGVQkL2auolueADuesGPErajx0WpwdsNG
 x66ppMt0l7Ak0FFZzyuLfHix6MT6xLh5sZJCZZm7elFaWhI7Jr98yOWprhhhBftA44307joNfqG
 znXPQuREKRXt/fw2Idw==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abcaec7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=nkb_lb6KKDW8e-7fnV8A:9 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: NxUwv3VjmvtcKXYZivXKa0Kj6JGeGIiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026

In the breakpoint signal handler test, a breakpoint is set on
__test_function. Compiler may optimize and inline __test_function.
This causes failure in the test.

Add noinline to __test_function so that it is not inlined.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 tools/perf/tests/bp_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index f580ba7486b1..cc4a27224884 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -54,7 +54,7 @@ asm (
 	"ret\n"
 	".popsection\n");
 #else
-static void __test_function(volatile long *ptr)
+static noinline void __test_function(volatile long *ptr)
 {
 	*ptr = 0x1234;
 }
-- 
2.43.0

