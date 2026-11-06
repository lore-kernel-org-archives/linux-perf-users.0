Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986850;
	b=Mts/yqWc9TWJdsFpvxVHbV87HAHy34/4lwQlymcmWyT9jM0rAXZQLWXpG05gOZjT6WKP
	 99zr0lD84HcZ4z7uMXJmadiM9I9Zt4D6BymSTp2UlW+plWcLOBYLoWKvsx422b5l846aI
	 ndnLHYbLKciLFfJ5cXGZRHUzSpJW0KPUWChGYntDCRhTx7OZ9kTpGvlmlg8vLTpjG5OIM
	 0CBcjEXmlsQpgS6oryWNKXG8RdhdJ0YEHYL7uE7Vwe5AeiUM+kcujXcgG4Ay9wZHUeTYK
	 INZeUU76y3AEyqjFYah14++2qgM5I9P6C0t/xqijeO17pV0qWnxLy8vd8bFjSz56wrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986850;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FPRuH7qzdqQGMCK0jcZ+GIXGwO/WWgLOpsOvQkYd/CU=;
	b=C0YTVgsL/alHkgxCrj+bBHpss9Du8OSh4mEPVvTlQX1OXSnlPl0miUIYeC6ZU+aKFlAG
	 /B6TmeJdSFaKuaXYbD/9k17Ua20iEfZqFg4k28Cb6hW3gtQz67+taLlCL8mi/d5IpW8pP
	 ETfWLmLEaLjKjyKghE+e4Xtyq04gF+x+M2Ot7kX+wqf6U6V1aRLbel0LjPpcN1vBOlb5w
	 IgCbJXgE4hdEfzD9NL/dPhjUxBRwGTPh1C9DertWdmbKq5fHPW1PxkrZP2pbF1ahtJlhv
	 kVuD3GySHULf4GohrFDjIpACrFYwlo3KRGOIUsLGwhWtc5y1sWHPVntYBUui9wk67Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B4BWXdQS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A7606A33A;
	Fri,  6 Nov 2026 17:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3A7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B4BWXdQS
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Exw5w3722896;
	Fri, 6 Nov 2026 17:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FPRuH7qzdqQGMCK0jcZ+GIXGwO/WWgLOpsO
	vQkYd/CU=; b=B4BWXdQSLUV4CvbQBXS3gNFJJOQ0jV1Cy7+JrUiw86zpoDkh8DS
	FRzCL1vimQ6WgQpGDRVRvT4xNkM7WgDUBsfFSfOrs34njgu/gLZ6mFBk9FmCmJyT
	MiYGGwHfKZj24Kgq771OhVgwolgejfOcSnkXXwVszPrNJW5BBx3RnrB6pH+nL301
	YobNt+y7KGEP3ysFMEpjf2zi5V0kcV9Hq6pZiL1vOcFVXKT9iN+3RM846q2To4oN
	cor4lvn3s8+9QAW+WtFCKvBPKNabxTTiQcu/iBCdoNME7QbAnVd3F+jTRdLu+e0O
	JtWGXXVnNQWy+V08leh0uTvlPmqI48UAnZA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9kwhk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:40:21 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HeII73084411;
	Fri, 6 Nov 2026 17:40:18 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A6HeIdB3084365
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:40:18 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id DF724248A1; Fri,  6 Nov 2026 23:10:17 +0530 (+0530)
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <anup.patel@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Beeman Strong <beeman@rivosinc.com>
Cc: Vikram Singh <vikram.singh3@oss.qualcomm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/7] riscv: pmu: Add support for Control Transfer Records Ext. 
Date: Fri,  6 Nov 2026 23:09:35 +0530
Message-ID: <20261106173942.3175069-1-vikram.singh3@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: AJ0EHmOcNbLN-b8h9eCfXKlOwzIMKLgz
X-Proofpoint-GUID: AJ0EHmOcNbLN-b8h9eCfXKlOwzIMKLgz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX1eAcMBD/3LQz
 QA8vgbedlMA183wbSDF90jTmbm/90TW5Y1J6arWVM3Qt1gXAT5WBfgzJpciu6bugOE7Y3zxewwY
 8MaomBGDQblMMOARG7y04PC3AQNOklY=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aee1106 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=xvfqbYfxAAAA:20 a=O76HWA22AAAA:20
 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8 a=NEAV23lmAAAA:8 a=JfrnYn6hAAAA:8
 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8
 a=pFyQfRViAAAA:8 a=_O3DOGVWAAAA:8 a=EUspDBNiAAAA:8 a=Epjr2bh0dWxRFF0fu90A:9
 a=MSi_79tMYmZZG2gvAgS0:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=oJz5jJLG1JtSoe7EL652:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX9JApodlP6pYo
 SVRlEm5qDmj5G2MtthGqH+XNw9G08jm0qZHMVXT0qmxukoEu2sQAf6v02UzeaNBVb7EyV3xQebj
 zW40+PA52odB1YhbLHIJJymj7W0HS03b1KpXKhpwegKrHTRHvpsdqiwEnAL62KswMaH0wUCN6VZ
 5/OO4ssxlwy/0e3uU0of0j42RkPwJE1Y9U2YUKj+b4GUd5puNYG00j0yx2I77oON7XaFK06zSYO
 oGjZJnYrV6EdTyY9pFO88RwTdd2OUJtzYhvAsXo8DnfgzoGhWYBftMY8OiMaldOL+h8NB2FILgK
 MUwmm8SvzpvNesFQVhCEkEX68att32jieJxrHHRu1l58azrglXQbEiSvufjdnGJpWZV6NUWC/dJ
 eh1TftiZok6M1Tus+guHvRSMK6t5eBAuclVJPo+DfHgHjH35ucC5eu+4ome8YjZSOMJselDCD6i
 p4j+AQo2L1T6hdGS9Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060070

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

Qemu patches are merged upstream and is available with latest version

Opensbi patch is merged upstream and is available with latest version

[0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag/v1.0
[1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/tag/v1.0.0
[2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v1.0.0
[3]: https://lore.kernel.org/lkml/20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com/
[4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: Liang, Kan <kan.liang@linux.intel.com>
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
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org

---
Changelog:
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
 MAINTAINERS                                   |   4 +
 arch/riscv/include/asm/csr.h                  |  85 +++
 arch/riscv/include/asm/csr_indirect.h         |  50 ++
 arch/riscv/include/asm/hwcap.h                |   9 +-
 arch/riscv/kernel/cpufeature.c                |   2 +
 drivers/perf/Kconfig                          |  16 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/riscv_ctr.c                      | 609 ++++++++++++++++++
 drivers/perf/riscv_pmu.c                      |  21 +-
 drivers/perf/riscv_pmu_legacy.c               |   2 +
 drivers/perf/riscv_pmu_sbi.c                  |  85 +++
 include/linux/perf/riscv_pmu.h                |  55 +-
 tools/perf/util/machine.c                     |  21 +-
 14 files changed, 979 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/include/asm/csr_indirect.h
 create mode 100644 drivers/perf/riscv_ctr.c

-- 
2.43.0
