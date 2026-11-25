Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596035;
	b=JLFjqc0RfTuOEQXjOrnw1SUfRWrIFqxcbpPCt3hZmBfoBjaorzKVT1VbseWz+a5k/B+0
	 SuO87Vt6kTIFyybVD2sjzctrbNjmaP4K5vvEdkr01Z+8nkxbyd3yFIxdzPLtxsMFaR3/o
	 5NunHMnwn/QvVSbMyyvb7pWHTDkny+FMrJhBMNKN9EE/Zao4EPbRloIetUY7tqDxo0CEg
	 vWWBYnXajRBKs63J349LNmNp++capwDzj1yDGuvPJf/hrKi/bXABkMttf+ZB6cMqd6Diu
	 t7TmVIbxfUOoKgya+JGCTD+umVfFX0CAn4MrrbKRJg1xm0oOZpGrgxYJ4JqLucLQgpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596035;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4slVq+RmbXTqpQEC3uiQ6EXVDAb9mbcbcLzU53TUUF8=;
	b=biufcCELfRT7aIutDwudfirQM3CKmgdpSJ9ikhslUQRPj0i9EinC6Ks3M4V+0BKJSeXr
	 iGIa0tBSuym6kjo6bLsLsrbkgIf4dGWSyysqRXPijWi7CioPeQ/2nfTeM7TzGESCxJ/oA
	 8vDidcXprxEAYmPJfZeveH+lVD5td3kfUs2OyMBbwpuDWuc+/OpJSIxuCSsRgSzqOdJqI
	 3iAaKGyHwmCXDc22dz8G+H5sQ97C1fb/CUNq1cpT4tpLEKCvzcvqQCfpR5XoF5SctI72r
	 sXcZucyNdOlgZqes/RMfbOZpgGY20LobzSt+8XdEoMNaDHrI7Vi6w18Cyc02K4qonIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HmUcnpnE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C2606A323;
	Wed, 25 Nov 2026 08:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E6C2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HmUcnpnE
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68Zop300022;
	Wed, 25 Nov 2026 08:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4slVq+RmbXTqpQEC3uiQ6EXVDAb9mbcbcLz
	U53TUUF8=; b=HmUcnpnEK+hGH4K9Gi4YCmiZQ+c24Arv1Z5R/ECGXQkIFvuQXsm
	yYZCFjdgUk2WKvI3/k1ZDhJfLvYcEiYFESYSL1lma1mbY+G/6UzMAzYLpi9tCzp5
	0xY/3cZcRN87W5u6PFeq7b9LyO3dStJD7/YPo91/2Kckn9vPbFhGkLKbHEos2Tl7
	doa1b8GSXAu0T/L6mBRN7XiV/DBym/sumqzpDqCj21twh6awKDrXt0JWrfRi9bbO
	3I1o7q8oehoU+4ajaY3D+j9ggYcgSH9ojJ0XiRKGjUQYFBbwtdMTkT0BI6v3auep
	BArhLahVimJIdAOnrxCNr+MC8m4cwGi638w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5n6rspmc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:52 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP8dncM075224;
	Wed, 25 Nov 2026 08:39:49 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AP8dmoa075215
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:49 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id EB8C3248A5; Wed, 25 Nov 2026 14:09:47 +0530 (+0530)
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
Subject: [PATCH v6 0/7] riscv: pmu: Add support for Control Transfer Records Ext. 
Date: Wed, 25 Nov 2026 14:09:35 +0530
Message-ID: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfXz04vVdIO3v6R
 hmOpfKJi0uVZRihTzEC1K9W6O8T9U1xUBxIHMP42IcU7kZS2x+QNJw+nVCBTolV2LN1o1qFGQxo
 Asn2x3Jx4IsNiooRyfGDYgyzxM+EdidKS2MD9s6xAYu8Gaj4MoXeTVLif+6Bco4oo8B7MA9+iww
 XAEQZfiKjHJaDfPCP6AEpWjH2qjLbcUUj8+eZqYBK7ARuCF/xaazzP/Pk5yr4gJBS8fJM6vVemq
 vnzxJ57cZm3j7+vm4c0Ha3l7Q1ps/jNPMsm9br7oG/UQ3ys/nH6q+W5faLn00+faC8F7MhwH0UY
 V6NroHMnn73Ik07w1KL8QtLuzbi3Yw9UTpo5Oh3iI1dB/o/S6oeO1j2JXVvZj/1SnPn1bMT5mf4
 fGqqBBdAOwlpbpCq8YYwpP8fwOFfwbA5DuX6q0gykQWbV37/oYRrBKB45vYFDLaj90ZQ+XCbeau
 hCd4XAKt+UWKaeBSYMg==
X-Authority-Analysis: v=2.4 cv=Voa2kO2n c=1 sm=1 tr=0 ts=6b069ed8 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=xvfqbYfxAAAA:20 a=O76HWA22AAAA:20
 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8 a=NEAV23lmAAAA:8 a=JfrnYn6hAAAA:8
 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8
 a=pFyQfRViAAAA:8 a=_O3DOGVWAAAA:8 a=EUspDBNiAAAA:8 a=Epjr2bh0dWxRFF0fu90A:9
 a=MSi_79tMYmZZG2gvAgS0:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=oJz5jJLG1JtSoe7EL652:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: CEaCPJKL_xrg2MX1_AQCkW9UZtJ5LVk1
X-Proofpoint-ORIG-GUID: CEaCPJKL_xrg2MX1_AQCkW9UZtJ5LVk1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX20zsTh9PFWLB
 OnfWZmg3RDhRBaELQyYVqmuBSzpuNP10ZroPBIvhwkhuO1gzaPhoQ0PO/5RgVebwedyfHfmVTLW
 XhtJ34XTvGR9WZPvNfd4OsA0WafPv68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250034

This series enables Control Transfer Records extension support on riscv
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
v6:
- Rebased CTR driver and support files to Linux Kernel version 7.4 RC4
- Incorporated review comments and suggestions
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
 MAINTAINERS                                   |   2 +
 arch/riscv/include/asm/csr.h                  |  83 +++
 arch/riscv/include/asm/hwcap.h                |   4 +
 arch/riscv/kernel/cpufeature.c                |   2 +
 drivers/perf/Kconfig                          |  11 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/riscv_ctr.c                      | 608 ++++++++++++++++++
 drivers/perf/riscv_pmu.c                      |  21 +-
 drivers/perf/riscv_pmu_legacy.c               |   2 +
 drivers/perf/riscv_pmu_sbi.c                  |  87 ++-
 include/linux/perf/riscv_pmu.h                |  58 +-
 tools/perf/util/machine.c                     |  21 +-
 13 files changed, 917 insertions(+), 12 deletions(-)
 create mode 100644 drivers/perf/riscv_ctr.c

-- 
2.43.0

