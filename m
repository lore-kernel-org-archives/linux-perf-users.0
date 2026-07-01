Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882913126BC
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915250; cv=none; b=T2+YvOtTLsSS2rXnjsJq4qQzZ7apeXUyhOXHRpgOuQnfVb5ANaiTbLlum/0GsMqfm3LT9SBF/btM+sA/BRUqGJ9JaqcDggU0AsEhu9CtaLTHzzP4FiZt3YrH4YC16vPIvmNE/R+Tex3OvmSuQg+CJIClJRNGFga12xlYe3iKQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915250; c=relaxed/simple;
	bh=/hrfveLb1uPV4VCGvpq1d49nVZzabJSPa2N33mW8rPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW9mI3YRDr+veNNtp6vlY0JQmusYwJ1DhHg+alvAopjTvnUiyU9RSPqUXGV514RAk684fOdNW7X8AzCBxedaxxMsFT+fPqkfEotuY02J6nCdTTS6GFN3C67aU59hNOGCJi7gF+G+IYgoMrmzSsC2m0pppblbRFyNgzzEuGC5S/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WJNZ8BIo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h6tCW2GU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJNZ8BIo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h6tCW2GU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8OSR761392
	for <linux-perf-users@vger.kernel.org>; Wed, 1 Jul 2026 14:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8bUSJda4ilqPSsr+kj3ujHasO466L6Tnfyx
	nT4QYlUY=; b=WJNZ8BIoBcePfmJQhe/ivluEkiTCn3a1RjKO16JwiiD2FZ/508Z
	Al4gxTNu9JO0SGGGP74S+fFmr7FEZ8K/3IeOWrzwt29t3aDfX7KQNKZkZ/hWcJOk
	nzS7TMd3BGQeRpR/yyijMgVUnM1VV5nW9VG9hVSBl6OAzqtIB/PMVyEprb9MmnmJ
	NEyYN9uvqjXje1vWHANeJI30FsbjjKYYHGUd6Qm3bAv5M7HfZGyHCMoBUYx7fxSM
	tGWu/FwwP6c3sug/1gzYQb/5E92xczd8Lq0JvvFDYem/DEPwMU84Yi0pdu7pX8qb
	e1I1Tad+GT7ZG4zJt1/pKzvDw/N8OV2Q1QQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd11k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 01 Jul 2026 14:14:07 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139f02b1fbeso3147447c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jul 2026 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782915247; x=1783520047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bUSJda4ilqPSsr+kj3ujHasO466L6TnfyxnT4QYlUY=;
        b=h6tCW2GUcZdSKvPTzfSkD+C7vXzcf+ELFzHns+AcaCPA+20Vmm7GyxlJDHa3IaucZB
         tMk5X3ujmFCDLVrBARd5gdlYU7lZYJ6/Vkfsc94MOEUj8rI/bJyaZ+wfzgsa0GaBakUS
         kgttg+GAfE+TyVs7/6uvboMLUinTiBBVNa36md2HMsrTuMUzIYSvl2D2ei4qgWH7X5tt
         yd1c1e2vsVyjzqjpmyliTddW2ugFZGMETZR/ZX7qrke8gOJv4TnMrWR+HWOJVJmPkdUC
         wbVolpOxy0IgSCHoPQt64SIaLFgWpOAVTjlPY+vBMFcwLq6DRW6LcPOmw6JHe9ESgq34
         zc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915247; x=1783520047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bUSJda4ilqPSsr+kj3ujHasO466L6TnfyxnT4QYlUY=;
        b=BkuE315YhgUoA3505LeMK5F37dYiDu0Tq7qPopv40mF/DWhnzeEf74zci+HCXQj23k
         Du0zkqDQTnFvTlsuLzVfjbkqaXqWzXbohmMvZ2WCLO3SY/IaKaP62N4vRhEon61hw/4h
         2fHtYgs2EKOlSHLlsNHCbwEAGGyvjC/vRGqjyPmknZwJhAYWKPzzalMYD9NONVzKRaxe
         lrcKlUzJhgRAUuSn2FAwqDCVNdDujj88QRiGv44ZNTvGb4ok4xS86iFQMcaLHpI3sv99
         +4mhDZfZLQeAGXRa9NNdQHWgAf9I/pFonDi6HZZgMOZbePFBkBRmIrqFA5ddvDWrVNVp
         QKzA==
X-Forwarded-Encrypted: i=1; AFNElJ+oqLBWC3zOx+YcR5UUz3iQsRcDWCZHw2BHdXv71xOVgcvWQ7Hg6RNdTLGu+7tp7SZeFoOsGSz1MG+2AYe37Wkf@vger.kernel.org
X-Gm-Message-State: AOJu0YxmaEeYlcmiWtrs1vGOtPAk5cN1M2ApjnRSINc3047Oq1PtzLfq
	HeURGKygMkulVwS4ar8/M9UvRudOBlgtvLoG82z3eJQGLSgYQFbJpY6rn7qzpFWhogcH+31/Nxa
	e5jCQlKHi141T7nVF3exUXo08DJ//mZpWeas3Oa91nqNbS++5W3BdNHO6jM5gqZOzTUfFrfDr
X-Gm-Gg: AfdE7cl4C7zSzjP6pfa4RE4HDtYvoQpgiue4zDwqmLp6WGKsyGLcO0pp+JiuUG04/7p
	OPsY/UxCEaZQrDSptRCXimpUS0yUAbhLBVL4+hvz/+Ihe6D4/zKsvQRXRyOQX+/OJpYp78FQ39J
	VMtqxrbbPdYk0XBbviwIHDyAppcQB8Zgqjy+swhl87x/rMWzo+2jtlkv5AcU5bvFbPvDw+qMVbb
	8fIHjdM26qTzdx5eBeynF5DE9ZGqD7abt4HMClkTDpV9N2Uiq/0r94Nw/EnwpY47hAB5zrBUUHO
	32/iQFu2pilsb3IY0HhlnsCXOYBKc3o1yhcSlKAI6Qd0rLzYXXNetYBR/Xx+iFFOPsT6Em4B5E8
	86LoW3a0lpEmX9NODZiYuMCPAXSTCyf4ntXi/CJzzOYSSnBAkPiqKW1VyKuwCmMRN9wwDtPAwiH
	w2A5DemWOeq6a47SflU3lPf7soBd0y/XFcraYW
X-Received: by 2002:a05:7022:922:b0:137:ae1d:5b5c with SMTP id a92af1059eb24-13b390f6342mr920109c88.22.1782915247019;
        Wed, 01 Jul 2026 07:14:07 -0700 (PDT)
X-Received: by 2002:a05:7022:922:b0:137:ae1d:5b5c with SMTP id a92af1059eb24-13b390f6342mr920081c88.22.1782915246492;
        Wed, 01 Jul 2026 07:14:06 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13b2ab0fc3fsm22644741c88.2.2026.07.01.07.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:14:06 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Subject: [PATCH] perf: record: Clear BPF headers if not needed
Date: Wed,  1 Jul 2026 19:43:47 +0530
Message-ID: <20260701141347.4098670-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a4520af cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=N4SQ0fxuwrioDB_HzhwA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: oXLuCb1rYRjaFKV9MTXPykGqp9dWrSsK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0OSBTYWx0ZWRfX2sUU4KeMqx4A
 hx/q0G+UZenJIVskD4T/0scPKH1kJzBp2VwVYSyy1pAnpkBOc/1re0zg8FF99ru1UHh9QbbiZug
 JddljH0QT5hL0wEjq0DKkTxnJZL1SoQ=
X-Proofpoint-GUID: oXLuCb1rYRjaFKV9MTXPykGqp9dWrSsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0OSBTYWx0ZWRfXwKFLVxpaRQUL
 weN5XikLkqzgF8SJE9aQ7J/lM8zh1+lH22CBUj8CmNrTS5USi/H9pkyVxGxV41vMocEnc5IMUy4
 kqKY0/SAyg/9eXh3t8fHcnUcwWkxbYhXvVRlMaM97wQH7ZSQFz2tN+8OyAVrD0xILBjAgPfT+71
 pdGPk+3kMzTw+Jaq9b77LlootBlaIihiXeS7Hosx4XapsDadiEveAF62HdsqFqzI/Rnk2q9yzQD
 l07AvtbH9CQ0ibsVRbxiJyMHpQ+QqsuMrC3q9b+hRQ96fa9gM34vvvvx0bQBAEpO4vsouUyi1K3
 SPju7uGCAJxg6qu+kZmD9P6i0A7ej91lKPLsZko0mrMsHbfuCermyIQxSdY3CwdX5U+t19YapoX
 mJ5B1wMICkkLOYjUkIUMDgCruW21gaNciXZgvsXaUT54xLIr+vFNk1oAg7KKISQ9EZC3bEczMZA
 cMLpK5/J3JNEwFOHBuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010149

When perf is compiled without libbpf support (e.g., passing NO_LIBELF=1)
and even if the user explicitly passes the '--no-bpf-event' flag, the file
header feature bitmask still unconditionally retains the BPF/BTF tracking
bits. As a result, write_bpf_prog_info() and write_bpf_btf() always get
called and display the error messages below:

ERROR: Trying to write bpf_prog_info without libbpf support.
ERROR: Trying to write btf data without libbpf support.

Fix this by clearing HEADER_BPF_PROG_INFO and HEADER_BPF_BTF from the
features bitmask, whenever the user passes the '--no-bpf-event' flag.

Fixes: 598de368375e ("perf header: Properly warn/print when libtraceevent/libbpf support is missing")
Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
 tools/perf/builtin-record.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e91539055675..692ab7138d2c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1829,6 +1829,11 @@ static void record__init_features(struct record *rec)
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
+	if (rec->opts.no_bpf_event) {
+		perf_header__clear_feat(&session->header, HEADER_BPF_PROG_INFO);
+		perf_header__clear_feat(&session->header, HEADER_BPF_BTF);
+	}
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
-- 
2.43.0

