Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995505;
	b=kq5Q7QZS0TFFC3FYhz2KaKngwaQaRM1WMjoTu0BuetUWYfLqmaKp71bm5OGknbLzUNdg
	 qRekbfI5J/oWtMTw0DGR2l0gz9GDwr932glSEG6MnZTHfbLOEyvXPE+cyZygYrOWU3roQ
	 nq6QMOVzww8DC+uo9pRcGCN1BUWT0rjXN16dH2W91DdZqmlSvZFIJXXzYxP+IOcaGaNJe
	 rrOQ6Ybive6z6H4HNbcaRY3YOi0cuDR+mih8dJaSeCLkSS8LSKwwehAfSCSMMXJnLngwx
	 eN7GkSWdD9dSK4i2P0GMhNgVnJif9sRNa+D/rQhHeM+JL/6S2wxfq1mZItWkByzclPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995505;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bd8Cnycxgyr/ojYs5MysmoTkBj0fIEXfTZ9x/S6rg5o=;
	b=DImfrMmVvSizogKLhAn+SYX8u385rfFvj4pHgqKvn3mowNlMwcrr2EsHHy2oYESzS/5n
	 RtGUUAfaDLlcJKqAeuBGPDpY/mh59L3iwI1i0n2kv1l1/I91dAmxOInjnCafzM8cmraMC
	 Z0D+r94vU3pUcqA3NP8aYKECyTk4D/e92Yzrwwep5V4qsCLyl4N1ZwivhssQa4Die7mhK
	 LCgCF5Ka1p1+SOOsM/3BeVLGUBJmdpUhguJGfFf8kWtrZgqiHcBIAyl1XbQ9SYj8gphAr
	 LtlvLnvRSXhXE1A90olgCz7UAtg7H3aM3lQY7fn9cx4VaUzYq7fHNUrsucSgwmgzd2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i0Q0+vah;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5E606A31C;
	Wed, 18 Nov 2026 09:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D5E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i0Q0+vah
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9k3xL3353922;
	Wed, 18 Nov 2026 09:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bd8Cnycxgyr/ojYs5MysmoTkBj0fIEXfTZ9
	x/S6rg5o=; b=i0Q0+vahXLEPMFPkBFgljkZ1aLVVlGcHx3l99MNj8vAgO55EDu1
	0b9SqvmwyJ9ic0+M/MASq3DArIve3mYuQYs34CO9+z7/uRQPZWixMzarRMCiwAVS
	PpYC3pdRA7hG0TnQm7lC4MTJQhFpBiPIfz5GAU/o4zMNovOVGEB8qyDxSura64FC
	l9/ajri4XlVatmVsxDxAvAUzuKTxlnmmIT+xK1u+YZEWasXk/cwKR0Hw9ELca++j
	j1BwpTxTgeZt9NO6cCJ1BKTNqJdUmgJu4AazTdYudqUyNPo+HfV/txvjgiaS3SkK
	Ou6TTElXcBbHsC3GN+6ztvZ2KouWEH8gvcQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvateaq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:06 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9p3Gn375487;
	Wed, 18 Nov 2026 09:51:03 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AI9p35w375477
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:03 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id B62A624881; Wed, 18 Nov 2026 15:21:02 +0530 (+0530)
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        atishp@rivosinc.com, anup.patel@oss.qualcomm.com, will@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        beeman@rivosinc.com
Cc: Vikram Singh <vikram.singh3@oss.qualcomm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 0/7] riscv: pmu: Add support for Control Transfer Records Ext.
Date: Wed, 18 Nov 2026 15:20:46 +0530
Message-ID: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=SMzXx+vH c=1 sm=1 tr=0 ts=6afd750a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=xvfqbYfxAAAA:20 a=O76HWA22AAAA:20
 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8 a=NEAV23lmAAAA:8 a=JfrnYn6hAAAA:8
 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8
 a=pFyQfRViAAAA:8 a=_O3DOGVWAAAA:8 a=EUspDBNiAAAA:8 a=Epjr2bh0dWxRFF0fu90A:9
 a=MSi_79tMYmZZG2gvAgS0:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=oJz5jJLG1JtSoe7EL652:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: vH15hF1coqHfeu1IT8UqIny5nynf735H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX/X3bV1lru355
 9tC/vs2FhX7+bXPuXptsLYDQi7K83t0UIRq2wnwKoWdysqht99gzyK0lez+0N/hQVpoNjvvQ55g
 KkvDMvw1MGB8YObUUAz9DzBOzQAtZxYFiVzB10lOlIO/iuYJXtUarkzuUfoqzeNTcZfOHfI+PJu
 grPEKPdjjyhcAkBYr0A41WJYmFEkMz4X4qQD2JL3X5GpHvxKg2mcni//U1K84HBtCYp2cRYGSct
 cvSu5WuYS8ZKs2R3TvUzU0oJBGdEGJngpIAmUN40p71di+di472wx+8OFu3UeGZfCH6WAyqIwzH
 QaENYrW1FmaCCS9llUfohpmK+jMbPi7EAJezsxukiEfBfpytP2nJp47c6NitEfLyGWmy5qzV+ss
 Itakfe6Hcv5VLMGtjdj72UCJSy9yePjokFy4TX4nsquoCzQw/Cb8NcFrjFRE3stLJUgehdwYv5D
 d+QZj3aHDNwUaDBqnAw==
X-Proofpoint-ORIG-GUID: vH15hF1coqHfeu1IT8UqIny5nynf735H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX+gIjO3f4yV1h
 vK8U8oBbsvrbhICNQFB0ekStS5cC7ijLKmc1uwVKx2bcNnIiVm/Cka5EnoDizPk8jhqCTPY+x7T
 dwA4euVs/13JbxM9t/G7hyPNfBfbk1Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180039

his series enables Control Transfer Records extension support on riscv
architecture. This extension is similar to Arch LBR in x86 and BRBE in ARM.
The Extension has been ratified and latest release can be found here [0]

CTR extension depends on both the implementation of S-mode and Sscsrind
extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs
using sscsrind extension.

The series is based on Smcdeleg/Ssccfg counter delegation extension [2]
patches [3]. CTR itself doesn't depend on counter delegation support. This
rebase is basically to include the Smcsrind patches.

The last patch is in the perf tool to allow processing 256 entries. Without
this perf seems to consider that sample as corrupted and discards it.

Here is the link to a quick guide [4] to setup and run a basic perf demo on
Linux to use CTR Ext.

Qemu patches are merged upstream and is available with latest version.

Opensbi patch is merged upstream and is available with latest version.

[0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag/v1.0
[1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/tag/v1.0.0
[2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v1.0.0
[3]: https://lore.kernel.org/lkml/20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com/
[4]: https://github.com/vikramsgh/riscv_linux_ctr_demo/wiki/Steps-to-run-basic-CTR-demo-on-RISCV-Virt

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Atish Kumar Patra <atishp@rivosinc.com>
To: Anup Patel <anup.patel@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Beeman Strong <beeman@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org

---
Changelog:
v5:
- Rebased CTR driver and support files to Linux kernel version 7.4 RC3 

v4:
- Ported CTR driver and support files from kernel version 6.14 to kernel version 7.2
- Added CSR indirect access header file to be used by CTR driver
- Changes in sched_task call back signature to accomodate new kernel headers
- Minor clean up

v3:
- Added missing To/Cc, especially devicetree@vger.kernel.org
- Changed the commit description to better describe the need of
  perf tool change that increases max sample size processing
  capacity of remove_loops function.
- Minor fixes found while doing a virtualization PoC.
- Added the missing commit and repository information to dt-bindings,
  indicating where the extension was ratified.

v2
- Added context save/restore support for tasks using CTR feature.
- https://lore.kernel.org/lkml/20250116230955.867152-1-rkanwal@rivosinc.com/ 

v1:
- https://lore.kernel.org/lkml/20240529185337.182722-1-rkanwal@rivosinc.com/
---

Vikram Singh (7):
  perf: Increase the maximum number of branches remove_loops() can
    process.
  riscv: pmu: Add Control transfer records CSR definations.
  riscv: Add Control Transfer Records extension parsing
  riscv: pmu: Add infrastructure for Control Transfer Record
  riscv: pmu: Add driver for Control Transfer Records Ext
  riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver
  dt-bindings: riscv: add Sxctr ISA extension description

 .../devicetree/bindings/riscv/extensions.yaml |  29 +
 MAINTAINERS                                   |   3 +
 arch/riscv/include/asm/csr.h                  |  95 +++
 arch/riscv/include/asm/hwcap.h                |   6 +
 arch/riscv/kernel/cpufeature.c                |   2 +
 drivers/perf/Kconfig                          |  16 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/riscv_ctr.c                      | 609 ++++++++++++++++++
 drivers/perf/riscv_pmu.c                      |  21 +-
 drivers/perf/riscv_pmu_legacy.c               |   2 +
 drivers/perf/riscv_pmu_sbi.c                  |  87 ++-
 include/linux/perf/riscv_pmu.h                |  59 +-
 tools/perf/util/machine.c                     |  21 +-
 13 files changed, 939 insertions(+), 12 deletions(-)
 create mode 100644 drivers/perf/riscv_ctr.c

-- 
2.43.0

