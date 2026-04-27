Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15A39099C
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273265; cv=none; b=eBkPPQvdyRRlUvYH/9+MLFXpyrsxGRyvhtHi19S9I4B3bi3rYZAr7m9K4367AZzju0dlDiP0IOpwElPmwTXzTThRWifkanOGd2/8dVlL6ontODWOE3ovKY0dsyxWwA2Q9GUsrjx/SOQ//jNrgsbtO8NE40km5rgkhhOHdjChkgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273265; c=relaxed/simple;
	bh=k4YB8opbBw344ozjCeHK7Kv82EegIQzI3fMHh6g5Aa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sie4nI9fCWKo2QcE75xNOSu3z1hhW0mmLBdmFFdjBbms9otcMCht5HrkAkMsRPX5E2bZMJjOCGDsltWCb3HZOPQzIKXXCnyHUWQIxkhfOUfNz91Vv14fKZ1iVtBllYidmp73YGua6OMSFM52G1zDmsGyXoHcQ7YjiRExBjl+hNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B0J4qsn5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T/WWS/i9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B0J4qsn5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T/WWS/i9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R6wXGe453894
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 07:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qig1LQfZqj+uPc8nSdpLCAnp0N/nSYgIaCt
	vzTFOc/I=; b=B0J4qsn5vbzBpy4fP7kR/IFkESfBs8yHz6Fa/Dltl4WKTkzjxfy
	vPSM4vlAQ6NDUDR99Fpd12tNM0I8cBV6QOmHXMBnvSudKQU3MuUIHQQ0CLXAzyOl
	u52Rts7L6urINzuhEFhD9c1TvOpSXMsH6Yltj1V9dueOj9Ndpaz1MgUL5+IyN6ys
	K58vyRC0waWlE/rr+wd6su6oVDlDzIfpZ+4UUPdfygoJYMERiSR9v/RjAqy/LlkG
	9RiUXp/vfgUvoFLxa1YRyjaL45EStb5QDPgJNjLTTcu5XT8i6BRP/pjaTKg++dFZ
	GvvcXpoLph3u7oD8xFskguO+DVqdUgEdQrQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n00da-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 07:01:01 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f6c90b142so15768409e0c.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777273261; x=1777878061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qig1LQfZqj+uPc8nSdpLCAnp0N/nSYgIaCtvzTFOc/I=;
        b=T/WWS/i9mbfKTWsjYuy8DahU/Bm7c+EIGf3XNzEpd7r6CMO8E0+mWlRu/Y+zVIXz9X
         NLEKZGMX5L0GxobvHRTpspkAg9bmGXuR1ap7FT1WWA5cdvA5KFZ0TFiy5rgIcFz7ifg/
         Pxb1/uypgfhxYaow0d2fzx4LXs3Mhx4LWXfVD6kQKvI6wmetH2mfpl0EpuFX4C/6mcjO
         KzWcLDaQLkUR6zYH6Ij/62I1zQLyj89IQRyRDPOAv6KRIOjNBkXMwk8+0ppsJ8X8tMA1
         FNodI8CvZ7ql7kqplFxWBGmMym1IhLmTP+w5UNzX7hGZvf9Bayh5FSg3D7pFlL+xutoN
         S01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777273261; x=1777878061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qig1LQfZqj+uPc8nSdpLCAnp0N/nSYgIaCtvzTFOc/I=;
        b=H3G1qx+ei54tzmeL5MFeRsVeH6SqbfY8MzTTnvYfsx0uc/UI8NpWHCy0f4WlEkpaNR
         kUiv4hU9HDhXtaj+h+TPpzTrp2NJl/x6Isnqe1wOfT0cX1xpEmbOal8oIwPhYEKCACXg
         ZJM/RP6Y0C7GrvaAo+zFqEJ9Nff+w25G1TWR96EihqjGjq0x1qJk6ua+GJ1FdfXva0Vi
         ldFW7LXP/6Ij86kCT2CAIfFNTm7siFCGlMHPndtczkE43n/u3FQwYrhPjHcyB+O/Whhh
         PdX0YLtPEAPjO6b37PpgOrlglBgcTvY0rFdM9ApB1fzRuv8HEItorbFn1bvLlBDSXdBU
         t6jg==
X-Forwarded-Encrypted: i=1; AFNElJ84G3T0YR6wIUxaqYxxm2xl5BV0QtNDT8oeirXAHqMjTWfwzSn2bfd7qXF7gNIXcmmQHGjPv4Ls1MzF5Zxl6Vfq@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOJ4UOs0Zh3zGTGpiQt2VU1z7rpkiRsEc6GpfuBSmiGMCH/5m
	CAbWkkuMevLVYUeaOS9Hx7JI6YNkb5VM8l5SCSX8MajErlUAkBrMeTN4DHvLVClLMj0fl0jgVuk
	V4NM//VMRgwmXyfk/8t0/UaUjg8fog1gA+4X8Fts84kp0E2skKWp6QVl8DEMN3d3HWx4UYyuz
X-Gm-Gg: AeBDietkN4UkUsyOr9co0LWoBso+lBuxwCRB7PQOlFzmzHOsBXChyhMAiKnKbM0AKSL
	67iFAVapJxENQWKe6yMUpT7/snxLiQhQlGKwddKKdho0mqMFcyLY/XCd523inqdCTMYua2D4Ghi
	x/0SmKdkXQUnX/gRwifGfwumrB8UMwMwkVo7WCFMMDv+4obP0n1dYk3YHEgLue3uMQGqo9zcu82
	Kz0NJN1BsKhK/FY+nO07apO2KwnHkNDByiN5wvLyNVB5m8A0UhJ6CG0ZXFIGjAOKiqI419Mo/qe
	gT1LAJ3EXnREECd3Tds+vYT1mPBpVvw2p4nB6bIO/SIk+tAnMYl9qipA4Ai1R8V4YvESMgkeXCI
	j+y6TjvYtf6h3SlbdAhd9iH7e8bq552uikIf63nxYUxCn9Zz0/UCXDOYdDz8MW1R4gmOfHlpAYV
	1lNmiy1pD1og==
X-Received: by 2002:a05:6122:3a0b:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-56fa5808124mr21604533e0c.1.1777273260917;
        Mon, 27 Apr 2026 00:01:00 -0700 (PDT)
X-Received: by 2002:a05:6122:3a0b:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-56fa5808124mr21604507e0c.1.1777273260493;
        Mon, 27 Apr 2026 00:01:00 -0700 (PDT)
Received: from quoll (5-226-109-134.static.ip.netia.com.pl. [5.226.109.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm716382795e9.9.2026.04.27.00.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 00:00:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] perf: qcom: Unify user-visible "Qualcomm" name
Date: Mon, 27 Apr 2026 09:00:57 +0200
Message-ID: <20260427070056.18140-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=k4YB8opbBw344ozjCeHK7Kv82EegIQzI3fMHh6g5Aa4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp7wmoZdv1uIlmrphTPV8l2g0yWVfZOvw+HHm1F
 LDm7hSUJLCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCae8JqAAKCRDBN2bmhouD
 12udD/sE1ZxN1kMdztPeX9tA9pPE23yxt0zdodni29mmrl2fVkfYu0NSsuogiCQjiHZVJr40Sr4
 pT8gXASC4Q/t9+KCZGtPl+QdrPV+iftPc4yzSlq5I7t4B9S9K0LEu25pjsySY0nsqPLqMNY/nLZ
 71PxlcSqTsgizHMvYYMyprbEEfBf3EhSMFOZgZtu3Qncxn6Z//zE6cYJXD7+12FL/pzTzXcRtNU
 GsCy7ooDGs7M8rtE440FIx+CjxvkIqnYms2L7k1A/8DQZVEXm80QqhYTMOsJPECbzt7JYUn0eOW
 4hFAnmmepUNHT7jq2wdUA2snHrFp/LPX7cQJm7aFohTyCDW60Sm8Q/PaMNH+gEFDuD5jrCDMbI/
 r2v1J9M5EC0GuInTn0ZWFC0rm9FAM07oRk1hcFifoR/gC3613BM9uMwPpaLdnJZs9Fv9w9Nz/kb
 K6/amh8uVFmaYqlW1DUkuR3nh0lNsfhHciNekzqTJ4cbBdwc/CfPXzGyugKZa9Nf11blCzWf6ny
 ASvZtAdbrl5bHG6zGuqMwC2Amyhp/rXfjHhobD4fYGWb07XeSd2bc8e2WICY6xhnJwwBxR360xt
 CxWXrot7kRGTDGO2PtLwEN/60x0pV84n7Dc8UyNj8BXwcH7KUuC+myfSJVHjcwmseXRWGZbJRN9 xPlHA4xGvdOgFxw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA3MiBTYWx0ZWRfXyaLnwt72l6fv
 /sQg/zCrA5C8jIb129WvgJafxTXs1VjceYuGNOlS8KnNfJY8qvMTzBP7cniRQETaQy75MSQPJmu
 pQTxUuUcEP9f81GSpKcQfVtRD0y1TfQ2fV5xaCmvAG1g6tKmJimvHm0OdqK6LO3iseB8giOjxlh
 SlHZFg3Fr9tE5qgqCPjX8sHASpOrXiucc3uNLsRVBkhCKLdl3vrBNYOmnAnsvx0nAZWSwzZ1D8U
 oNHLYpCUpIBlXSTgCFcoUOvxdEDJRFaKEh98zac2H4oB5SOdi4DOBNq7T49LRE9hEAfeqGgKuUx
 d4JTeHUc5PgCkOXsmlv4IZWJz36I1nZjYGaDaLVKlCdOYCh4gYV1HmXjKLJnbUnCG/8WrrWZfBQ
 +8uhTs9oc729ODxGE+jXC6SoDCIIMVyB6nigkdcpUkB+SPls4dJ2olBxzEtfceyVAhJDm4i63jy
 VeCTzkLsWfYcxVgqhbw==
X-Proofpoint-GUID: M1HX2Z11aIvLK7bRGC-CiyrEYlpHCfAU
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef09ad cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=nnYKl1aPHK5ktf5uHVwi7Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Vxq8--nCh1aH0Y99WKwA:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: M1HX2Z11aIvLK7bRGC-CiyrEYlpHCfAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270072

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/perf/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index ab90932fc2d0..245e7bb763b9 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -188,7 +188,7 @@ config FUJITSU_UNCORE_PMU
 	 monitoring Uncore events.
 
 config QCOM_L2_PMU
-	bool "Qualcomm Technologies L2-cache PMU"
+	bool "Qualcomm L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && ACPI
 	select QCOM_KRYO_L2_ACCESSORS
 	  help
@@ -198,7 +198,7 @@ config QCOM_L2_PMU
 	  monitoring L2 cache events.
 
 config QCOM_L3_PMU
-	bool "Qualcomm Technologies L3-cache PMU"
+	bool "Qualcomm L3-cache PMU"
 	depends on ARCH_QCOM && ARM64 && ACPI
 	select QCOM_IRQ_COMBINER
 	help
-- 
2.51.0

