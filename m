Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92713F23BF
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750415; cv=none; b=jPZZNeY0DvbBvRx9bj1OMSWkk4rk5sZs5YMVa1TZOxuG0nU/UIkQzqo67SLEEygLSZJMDLJ3Je+2m4HtDJaUiDG9qsYKLgIAL1xEo5MnIDBYog5iElO26D9LUilhJwfc63akASp0H0tYvKJVzAYuE3kUrdAvMoAOp9XTNmoXaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750415; c=relaxed/simple;
	bh=jMjxyEeDs5Y6CJbbbYobZN/g6YT/qU/vWkkiXcZdUYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIEF6AT5CIlziBKrhlU/68rqxnEmzG8qhJ27nmgrJGn2Q0KfSZrmbrG4cfZjqQER319+4GdaNvklwR6ufVbLVEJx/mMkKYO0DEUkztamyhzVkh0HORzE5TQwjCxC4kEsXHTxym8d/A0C5lZph/v64p2V4if1LUwU5a+qgbVynn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTXtMncV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gmrQ79pd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTXtMncV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gmrQ79pd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U6Gs9H2899513
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s+fRCN/HDGv
	HbTVltets/a+FtP+655QYnFd7sM9T9IE=; b=cTXtMncVx8F9bZEKQ/5WPNqofvn
	H8hvw+EMPs1XuYSMyK2b1qKcaeTLGmsEBlIsDbNG7l69KFdiEf9g+p9g2ITntvP2
	1Y8Ny3t0aitLBUNCYe4ySVOaOqBDHVa7xDX4bVpJWMy78sgRwwZDHep82RBNqVDt
	y9B4xYvvAFjHip/4FT+EI4HssNnxBNm2g9ioVTs2K/tdeshhuLWmCudnC/fXvUfr
	Rca8PiE412FQA221ZWRsIm4lgo+2QejOES524WTJUW/9872Ws8/702XFj21F4iqx
	W7nIOrPBDCiSSobgfByaCo9Lt+s3bHIsMuJLWf+vMpzzPyXI9MU1p6g6c1A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w1402x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:12 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so2186115c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790750412; x=1791355212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+fRCN/HDGvHbTVltets/a+FtP+655QYnFd7sM9T9IE=;
        b=gmrQ79pdFb7EiCZn+MyOpNRYJArV04TSCZzrcRDAieSp+9Ych1UkjQuf9/hQofmiFg
         hGy4MXah27Ix8Mg0ROkPp2eh90f5Nnm4TGRKIP3LBfHWJY7HuZy/ICF03FVi4ParpGA5
         4Wsh6enmVzereBS2ocQQ0Qwm1otiK/F3xdvowvJ7YwogYViC0Z756ugdmYJ7PyB0Xu1u
         nid75vlWtNR7ozAfql6a7Sh1DkR/Djia/q5duj/Oxz6jXyKQzcLAPr5fYx/iRQqIoMh2
         01+vAlRgMzHKT/w3pbya+f1dv8f9isNvyY5yAj9dZtujlLekXy2s5DqGO5t6phA+uJ2d
         vupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790750412; x=1791355212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+fRCN/HDGvHbTVltets/a+FtP+655QYnFd7sM9T9IE=;
        b=GndrMhg2P5Jp2KLFB+ekPDDv0vWmoremScKXCOdLLwqEdVi8+nSVSOH/eR8Tp6rsqk
         RUxKM4BF1mUwCEKHf2GYqnz3utCj6eAU1NiCp4g/17pc6jQZOh8LnPqUvHYTTZUb4LFf
         gqzglGo3lh/TkJGTrsROQ0ZPQAEeFScU/hRWNLxq3GjL43fvmYjydc9pySWU30ElMgMq
         SlRR901mTZtCHkecdnRsrA9opP0y7hqqbXaxPbNlP7sYNxnyhGSRCKy6Lw8WWXk0b2Et
         +EW0YRgKdwAgTXXvLqw+XNoEWtJjE0ct/rSlRn/lh4mA1OYGkIY1pGHfd2mblSQDa/B3
         jIOg==
X-Forwarded-Encrypted: i=1; AKwUvBwXViCO70OWut66S3rxY0udRSVQVbI5Q3UkdqtdZnL8j2IMKtBqB/Ffo/90NUv9Gkc6HQ76EK8LApDWt3Zynyio@vger.kernel.org
X-Gm-Message-State: AFuF++lJNscI8+/EsUgz7cxWDX/D5kf783GO0L3KBIjbHq5nRgdIVGIR
	xOj7kcZaGuN7Snji6k7qBjVdiT90fE1kQt6pFLrL0iSzsI5XnFkBc0SsjNoEqcsBn2vuK6JgYeL
	uXra0FknJGMmCzCeKl8Yg0SsDBzhEEKBu4TAlen9ZDSXK0ojKeJcyPhBFUFJZRb6WomwhfSam
X-Gm-Gg: AYBFou0kBxZyy6Z58xRiu5uICkWljVLehrtDiY2QCVgYTxkvXBUZYcdcN9/f+dqBADc
	+k29XSxhhTnImIcHjxZCuYq8oRpqCDOKxqBOxNOyevgNa+A7RxzQOBDKdicBW+AVIhuK0+v4fSQ
	Lk7a3wbntleNxSdsWhyjy8uYLYnW6IVM6L6pKMAumWce/ou4ShOuDtO47RgyvroPNC9PjIpxzDZ
	fa7Ns8jgu+aUNWWxUBCfTOq/0pM0WJ60T+mc5lOmdGTEYDsiqTlOlACtdSS+qWq77cJD9JPz/1U
	jshDtZNdZE4szRYNIfrvvIeBy9EGkJNN4YNpxFCwH/eLmMtHXLwF5RaYiDrZwrNE0YAX24vTnw2
	5ohTZJCZ6dxo2I94ifrTSRTqPStgfpsz9BTs9P6m8g0WPLkvmG7p6oUSFPRBB6Ihh6plnnpAKkR
	7jPfupSgBIXfOQ5BW3ujXvAefi
X-Received: by 2002:a05:7022:eb51:10b0:143:271a:3df2 with SMTP id a92af1059eb24-14d33f3dbf2mr303336c88.44.1790750411670;
        Tue, 29 Sep 2026 23:40:11 -0700 (PDT)
X-Received: by 2002:a05:7022:eb51:10b0:143:271a:3df2 with SMTP id a92af1059eb24-14d33f3dbf2mr303315c88.44.1790750411139;
        Tue, 29 Sep 2026 23:40:11 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d08fb50f1sm2711531c88.13.2026.09.29.23.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:40:10 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alex@ghiti.fr,
        aou@eecs.berkeley.edu, jtaubepe@redhat.com, palmer@dabbelt.com,
        pjw@kernel.org, qingfang.deng@linux.dev, shuah@kernel.org,
        thecharlesjenkins@gmail.com, cp0613@linux.alibaba.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v7 8/8] MAINTAINERS: Add entry for RISC-V Debugging
Date: Wed, 30 Sep 2026 12:09:19 +0530
Message-ID: <20260930063919.608911-9-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX67ut8tSvUH/O
 OqiLKrgiE3HUEeYaN4n+Aqhh7+BFOZLkYSO119gP8fdG0NGm26vwrnSMwmhQhIA9s/13qgX46Bx
 lQ8pOGE9hyF2cotXmkCX3UNlTaqlfq0=
X-Proofpoint-GUID: Hz_zGIhG56e59gq5uaD0Ye02oHE1TyKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX3gVLU4/eq7NN
 mM2lsQxofLJPOE0HzvUVfmzy3Sbpsi9smwPJTLXYd1Jwd8fAF5qodeXkq37LHF/UWrh95boha+/
 /fhDpHru25sBBaeh/FISHIsK9znkRapVvg/5zd+QHpIaG/dXHQoDVWhbIFdsg7qLlI4limw29mz
 l8azJe4nLZuYJApBdvf/slOuziignLWr/ggiUDY7P8aGeanXmBmcykqnj59TiIuagwovy0Xmcp0
 TxwhJ2ow2RpOwU37YaUWWLjTAMiX0R1H1nMvWstVUVNvB8eSQlM3w3Xq0rNtAOoyieUtwUmY64x
 XyuUdUKz0mhWXxdWqBr6M8JAieuAQL4Y2g8sfJW+pd8vmZpl/dYMmENwm6vpsj6aIcjmlua8ceP
 SoyaWe35jnlabJ0DiSrk672ctFmLKMoOL/s252cBf4FRyzoDMomX27VXrnkXnwALrsycHv8FQvz
 cGXaysV+4wp0CXdSiog==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abcaecc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=8h6Es3YqzoBqtYBhd2sA:9
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Hz_zGIhG56e59gq5uaD0Ye02oHE1TyKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026

Added myself as maintainer for the RISC-V inline debugging
with sdtrig extension

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72294ddfa5b7..01631359f0ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23586,6 +23586,17 @@ F:	drivers/irqchip/irq-riscv-rpmi-sysmsi.c
 F:	drivers/mailbox/riscv-sbi-mpxy-mbox.c
 F:	include/linux/mailbox/riscv-rpmi-message.h
 
+RISC-V DEBUGGING
+M:	Himanshu Chauhan <himanshu@thechauhan.dev>
+L:	linux-riscv@lists.infradead.org
+F:	arch/riscv/include/asm/hw_breakpoint.h
+F:	arch/riscv/include/asm/insn.h
+F:	arch/riscv/include/asm/perf_event.h
+F:	arch/riscv/kernel/hw_breakpoint.c
+F:	arch/riscv/kernel/perf_*
+F:	arch/riscv/lib/insn.c
+F:	drivers/perf/
+
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@kernel.org>
 L:	linux-riscv@lists.infradead.org
-- 
2.43.0

