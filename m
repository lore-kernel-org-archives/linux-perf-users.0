Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AF442385
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982563; cv=none; b=c5qcWVmsYUe7YK9+PPcwRgb1RL8afg+qlbiGjxC88kCwQW4W8MRJNLpzEla5wzLk2dimJR1YHHXPlaXDohN/JtUyXb5WbzzTB9RNR3sT3wlT0nTuH8+3sZgeREUuilsDX+wYTwxDREwIdZPRZZxig+p7AmSoEoKwO3LVpuQ7myc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982563; c=relaxed/simple;
	bh=eKbgGx3jlC870GvaTOCcW9Jj9cJ5SYGFymmxeWq3AV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgbQsOuHDqmJljAPIqWE8lP/L2GdvJDk+HIvU6lV81dd3h8vxxSieXEvj2FoBHkmtXJ5kQt7PcE7/v6QyIz2AX1dcCmmqceQlBqjLkPGa1PXorILzELVboWAfjenrltDdETGEjjoIzhmcFnoMmwuckU6qZ2jh5B7H4GCx/5tDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PosSKHKv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bKncAh/t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PosSKHKv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bKncAh/t"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYvOa1530551
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=F1ydbwCOJHJXHm4fbFBs3uDl9Dggh/0McdK
	z5MjuJng=; b=PosSKHKv5Wk14m5PM6r3+D+7nUkYhx8jJ8e9DVlT6gx8JSle5Mk
	LGVFcaraXw4j/vw8ezxa4tFzbdA8gxMczUe8gqGTt/D1Dmf+d+eEzd4JfGSgJA9d
	cA+gIMqf/XbtebnBfHODSLV2XS7zsaSFKGemeQuSBEAiFEoWGj/Ww7g2ZIw87VKv
	E9LMKF9lPg8Vd46HHHaw31rpt6mT7ats6te6hFV7CcdDOqiMv1AcJwESaBvVA2My
	iFbp8wt3aF8B8CmMYws57xwSAGd5xtWbrokw4xLi5TDvrSRAp8VlUvoygFGeIB7Y
	yU1g6aV4nVt8+MBtUtiClIwN3gJV+jiGLWw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wke2528-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:02:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e1da97175so4537457b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786982559; x=1787587359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F1ydbwCOJHJXHm4fbFBs3uDl9Dggh/0McdKz5MjuJng=;
        b=bKncAh/tY1tLEKk0+9RqnsmKW4tEI8A6WMeljFjetRmkZPsaAtU75dQ+6QynMfFjXs
         m1ktmHySekeSN5hvVyPxYC3Rgkv5mqF3cBGXoXtkG/qHmGF2fMBSG1GfxD2LqeFlUymz
         Y4sMJf2bpb+TlYgAQzHTQ3gRT5JzhINkK73pU/Mj5BAczZNKQiGKlqTV5BFzzL3PZYtl
         laaCvdZv0NhU7nFeDU7fojEsK9oivihJv6C7EaA/rHdxPVYbchqnkrZk8AMn6FehEP12
         PlnaT9khn9yMnEpwJaNbpyJGN0nMx3qQwqniox51Kin5Wsc6qONEkdqiPgpmz55fmDbk
         xBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982559; x=1787587359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F1ydbwCOJHJXHm4fbFBs3uDl9Dggh/0McdKz5MjuJng=;
        b=hFgs6B0MLjHm2sSjAvcnt3/X5E0G0u4h3E63n7fnbMstQOIz1mq3m74HZMg6TPjgvY
         VmwoEk99TgoNpRQiLr3ItGF6OjV2TCVsOGTYzE5Mv69cpxWEcO0ULl6LoDwtCrdJg5IG
         lEwztPoIoX+DhAZhRYgYyi+KwnK3cVSuu8xa/70Ptj2d2X1N0uJR9dQQfDXCUXyljGRk
         2l2RuVZlS/cQ8i9ckTJqnRa5WE+aV+/SykkXSw7g6/WlsFvC94CHaB+ACP/eNnii9wFf
         i/o36FsjtPsJrFsfCk0m8EnyTjvwi3lCe7O2DyWJ+ARFZ/nM/v2sshH6q8EOy1MRWsai
         VQ0A==
X-Forwarded-Encrypted: i=1; AHgh+RqVcK0hELktFTTGF4POIVFdEZ6RIpoppHReZyV9BPAIh+cwxPqJaQ+vc4uTrzuHLQOdvugrdOlW41Dfjaghaoto@vger.kernel.org
X-Gm-Message-State: AOJu0YyKoH89JRk5dveHidUb9VLOlvd/Dr+D0RnEAuEw1bGlVp9K2vzC
	twGnTsPYAUuBlPZj28h6WPkSnDZgTQt/1ydObQ7VKVemnIKk/OEMMkXh4aRJZUOZ8MIZy+jEkdC
	C7NGiJjwTrTOGGnmpIXkFK9/6WSGplq76xUtLzRiK31bqjAKkpZvlO+wEaT9i5Y7OVznRYBbr
X-Gm-Gg: AR+sD11/Nt7eDhJEXM1sUt0EEjEvSGgC7594PwwlJgp3mkskZY0acBKSyyhZPHMwWxG
	MSwpSiksarL8CU9gv1ayszSD+ebb2/Dg0Ve60Sm8a2JQtz8TNRLJKbDQR3sfRco5JZUAH9YCVL2
	bv0IrRr2R3UYnl25wCl0sAGDwoKYtlmq7dqZD+kseKI/DBjaV3HvSTLzbbdvzPrMmUuBIVWvDL9
	jKgUZWSaoipGXSX+fCFpNQA5teIDqJP/JWjLNgd1p25sGGJs5VkYb0zggE+Tl+k0vLozl9DAEcY
	BLyEhuANSGF6kSHaRMitxzWk4cQmvCugTTfkRlz6wJWkM+9vWrJbV+LPS6qtPDgahBR4TcZDi6q
	Kk/DE6LMX8hbTRnOfQczr9oJwaIN5cILs8gCn88WcpHcv8k9mXp50GCTT4qw5AB1Mco25LjPtwz
	WK9s1JXKEGEC6mtM0jq/lnr/kHFg==
X-Received: by 2002:a05:6a00:a219:b0:848:4c0c:9482 with SMTP id d2e1a72fcca58-84fde2bb2camr25464877b3a.35.1786982559201;
        Mon, 17 Aug 2026 09:02:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:a219:b0:848:4c0c:9482 with SMTP id d2e1a72fcca58-84fde2bb2camr25464810b3a.35.1786982558539;
        Mon, 17 Aug 2026 09:02:38 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-851b6f8b189sm562883b3a.34.2026.08.17.09.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:02:37 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Chiu <andybnac@gmail.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@linux.dev>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Conor Dooley <conor+dt@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
        Guodong Xu <docular.xu@gmail.com>, Guodong Xu <guodong@riscstar.com>,
        Hui Wang <hui.wang@canonical.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>,
        Rob Herring <robh@kernel.org>, Sergey Matyukevich <geomatsi@gmail.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Xu Lu <luxu.kernel@bytedance.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC PATCH 0/3] RISC-V Sspesa: Linux perf precise sample attribution
Date: Mon, 17 Aug 2026 21:32:16 +0530
Message-ID: <20260817160222.3313295-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfX+LVqz68fBSQu
 /tTVwCOwDjtkV5rho+0guEbDfCahM5asyOgNmaVi1WPEQR9tC3rID4JiOtsNVGtCEWuQpnqPfxu
 rkSexBqvjmwZARd+L0VPjUZKfk1TPuLqGHsx6ao94+ng1wTZHwx3BJHSam4iiORFEjlPpTQ8qD4
 jo63ppHyrVlZgN5y49alayowEV19T78VKHfJS3WXLYpQCqIb0f/OfELG4YqkYGwJ4zlljEpfGhp
 rDXnn/i6N9OcW5EIHxlrK+tnngai8MCgQtjgLSUop3eJcci47fQsF5ZT70SICheBJj8a1dBbG2k
 AlHZyf4PIiL/tJziC3WZVHPv2a3grbPvVTBjL4FoKVCNhg7utA2RJ1dP8wr29a0L45F2FvgAWK/
 0SEXy2qe2NOrP5rsNiU605sPSejzPkUVNM72RjUg7/mQaOc5q16l69ZRO9YAXJALVNC19vaLnOD
 hvbmsgVp1r+/q9zJiaQ==
X-Authority-Analysis: v=2.4 cv=QetWeMbv c=1 sm=1 tr=0 ts=6a8330a0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=8ilw5EQWc8m46JC1U7oA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 2wA7C4A7pqokAOgdn58nfAj9deNpX-xD
X-Proofpoint-GUID: 2wA7C4A7pqokAOgdn58nfAj9deNpX-xD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfX/dZnKk+M3I8g
 I1Y7RHD3s75fB5rlNG1JUApppm3p1Oz1VEEpAPByZy4F61NvJ+4a9wcAXQbp4Z1/+C15VFF/fZH
 hI4OuK4apg2zTIwUF7hds+LS7GIctyQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170123

This Linux series adds kernel support for the RISC-V Performance Event
Sampling extensions Sspesa (Precise Event Sample Attribution) and
Ssplcofi (Precise Local Counter Overflow Interrupt).

The first two patches add the DT binding and ISA-extension detection
(Ssplcofi depends on Sspesa). The third patch uses shpmspc to report the
sample PC via PERF_SAMPLE_IP in the SBI PMU overflow handler, and
exports shpmsdata as PERF_SAMPLE_RAW.

Reproducing the full setup:

Sspesa support requires three projects: OpenSBI, Linux and QEMU. The
matching branches are:

  OpenSBI: https://github.com/mdchitale/opensbi/tree/riscv_sspesa_rfc_v1
  Linux:   https://github.com/mdchitale/linux/tree/riscv_sspesa_rfc_v1
  QEMU:    https://github.com/mdchitale/qemu/tree/riscv_sspesa_rfc_v1

To test Sspesa, build OpenSBI, Linux and QEMU from the branches above,
then boot Linux with:

  qemu-system-riscv64 -nographic -machine virt -smp 2 -m 2G \
    -cpu rv64,sscofpmf=on,sspesa=on \
    -bios /path/to/fw_dynamic.bin -kernel /path/to/Image \
    -drive file=/path/to/rootfs.img,id=hd0,format=raw,if=none \
    -device virtio-blk-device,drive=hd0 \
    -append "root=/dev/vda rw console=ttyS0 earlycon=sbi"

With all three in place, a counter overflow (e.g. 'perf record -e
cycles -c 1000000 -- <workload>') is attributed using the
hardware-provided sample PC (shpmspc) and counter ID (shpmsdata)
instead of falling back to epc.

Mayuresh Chitale (3):
  dt-bindings: riscv: Add Sspesa and Ssplcofi extensions
  riscv: Add detection for Sspesa and Ssplcofi extensions
  perf/riscv: Use Sspesa for precise sample attribution

 .../devicetree/bindings/riscv/extensions.yaml | 19 ++++++++++++
 arch/riscv/include/asm/csr.h                  |  7 +++++
 arch/riscv/include/asm/hwcap.h                |  2 ++
 arch/riscv/kernel/cpufeature.c                | 12 ++++++++
 drivers/perf/riscv_pmu_sbi.c                  | 29 +++++++++++++++++++
 5 files changed, 69 insertions(+)

-- 
2.43.0

