Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A53AAF43
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113775; cv=none; b=SGa0iS7Qy6nEk0vInNdoMb+bCFVtnEntvEnJoawsZG89AJkJo5ndkggLq8jcP5yAbdkFqCSXFUv3U78utX6/nUp7jwEiFsdoGvSib6Fn9anpbcv3G3fDpdVbf43TfMnnK54szQLec6IckCsJtLHj+MoTJpWrU5H7wB/4MQEHHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113775; c=relaxed/simple;
	bh=lbHE6//CK+PNxF5j4ZP0yvnoBvAs0F4psxcHk+eaeOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lH5ahLHZ//yoV6fqzSIT80AAhiUDKOHXJpsyKYl24SUio/SoQDC/cDCVfBLzG75GEghl2xPfg1ZSfdxXgs24HhF1U9k9rmxPGwqvU+J9367ZDz1KIsCkL6vbHq/cDRntnuULlI3DtMOBo/b/NJOqEA9+M+TMP7sMD9vEt2VZrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YK0qARf0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YK0qARf0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ClaqR3829109;
	Fri, 7 Aug 2026 14:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gBwlbhP0S1yCIiK5FokZEIz3xBqNZOSUz3qIWQ36N
	2c=; b=YK0qARf0CcAnEdQbct37rkZ6BLnLbP+YnxoPmM+lSGi7s7iSlRfykZjcI
	qJS+nnvU0nm+ExuX8PjQOdokiBaDmRV4IjGbAJeWDd5rOeC4c/HdTdvti67hYmOy
	Kulj+qbcMAPJaq6n20xRbdKqlzZEdXYmVaME3B7h+8sODRfetpLLqzVkE0fZxqzx
	F6+SZdvv8dLgOkk7AKtEXWmAP1ZMh6hYfW0/TyaCVvupZ9fh1LOKhJrOjJegfUNj
	68OLctqdn0oJzNAUQGwJ0pPwGnz+03CVXBbxQQ0QP8YINR3q717a9UIRh//r8c+M
	BxoiphsD+WmLPpi2uZ+8bvMWtno7g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01mbq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:41:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EfGmL024886;
	Fri, 7 Aug 2026 14:41:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyyu85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:41:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677EfiD749938746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:41:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FECD20043;
	Fri,  7 Aug 2026 14:41:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D60820040;
	Fri,  7 Aug 2026 14:41:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:41:40 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V5 0/6] tools/perf: Add powerpc HTM auxtrace support
Date: Fri,  7 Aug 2026 20:11:29 +0530
Message-Id: <20260807144135.2607-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zK2-L_LiOzddotOGhLr_c73cIiyDzVto
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfXzflt8LCBsyMy
 7FXi+cIKJpCvIsbSZOIKElelsp3k2D4C5yC7V7vNIcggBMJRd7ZDrvDtP7dGJF8NTdVtTh+FmGd
 y6eWPLzcjZM5bv+O9+pGoe0TnJl8tzM=
X-Proofpoint-ORIG-GUID: unhZJRsmQYdti7b7WNRdDW6NlV2_8rx2
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75eead cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Lql3lfElDkBJbt6mtbwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX4d5FYKPq8Z0O
 n/PHdn7OYCxJQGrSyn1o3l+QeqJpvK3d1oaytS4gNCm9g2mO4Md8Qxj3NGOV6y5ooGmQ5ig+0Lg
 NhTUczW0jYGTHmCD8rmqUuUJMOxtQZNnWbnQ0XwoaffoRR4SDrjxAbhkHD49zeLy7Zj0Wh9F8ui
 2B7mDlqhI3Ac8Iue2pZ+BzpIICXpBPhpvABbVoZ1xbe4Uki70IPR9OFkEQq9/xwYYw4rcjq0oBP
 VG6FGE0itC/2+//VbFNBSYUk7Hfg830mKwggRCSzsUrhhgwjo5YcGwfZCMvF2ilu+FUqzpCEth+
 qdQ9pg7JE5kcP8v58VcDXP+RlAq1HGbMKfZ1GvI/f/2zyrMhfy8ReZudZKPUB6zXFNXNpGlnphb
 D2RBuPfktygCov5sxo/teZUisfdWf1/zz+oay1nIWb0sJbFshKt1aUZX61J/id3e03GZTYqiDpQ
 Bt0tXSNGiQzi1Y5XZig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070112

Overview:
This series adds perf tool support for capturing and processing Hardware
Trace Macro (HTM) trace data on POWER systems.  HTM exposes raw bus-trace
data via the H_HTM hypervisor call.  The kernel-side HTM PMU driver
(submitted separately) streams this data into perf AUX buffers and emits
memory configuration as PERF_SAMPLE_RAW records.

This series wires up the record and report sides in the perf tool so that
'perf record' collects HTM data and 'perf report' writes the trace and
memory configuration to files ready for post-processing with htmdecode.

Patch overview:
Patch 1 refactors the existing powerpc auxtrace dispatch.  All VPA-DTL
recording logic is moved from arch/powerpc/util/auxtrace.c into its own
file, arch/powerpc/util/vpa-dtl.c, leaving auxtrace_record__init() as a
thin per-PMU dispatcher.  This is a prerequisite for adding the HTM
recording path cleanly.

Patch 2 adds the HTM recording path (arch/powerpc/util/htm.c and
util/powerpc-htm.h).  htm_recording_init() sets up the auxtrace_record
callbacks.  htm_info_fill() stores the PMU type and a (cpu, attr.config)
pair for each htm evsel into the PERF_RECORD_AUXTRACE_INFO priv[] area.
The decode side reads these back to map each AUX buffer to its
(node, chip, core) target using event->auxtrace.cpu.  PERF_SAMPLE_RAW is
also enabled here so that memory configuration records are captured
alongside the AUX stream.

Patch 3 adds a generic weak arch_perf_record__need_read() hook in
builtin-record.c.  When the hook returns non-zero, perf record performs
an extra mmap-read pass before disabling events.  The drain loop runs
until the hook returns 0 or no forward progress is made, then the events
are disabled and closed normally.

Patch 4 implements arch_perf_record__need_read() for powerpc.  It reads
event->count for all open htm evsels via perf_evsel__read() and
accumulates the values.  The kernel driver sets this count to the number
of 128-byte HTM trace records written on a successful dump, 1 when the
AUX buffer is temporarily full but the hypervisor stream is intact, and
0 once the stream is exhausted or a hard error occurs.  A non-zero total
causes the recording loop to perform another read pass.

Patch 5 adds PERF_AUXTRACE_POWERPC_HTM to the auxtrace_type enum and
wires the dispatch in perf_event__process_auxtrace_info().  It also
amends htm_info_fill() to set auxtrace_info->type now that the constant
is available.

Patch 6 adds the full HTM decode path in util/powerpc-htm.c.
powerpc_htm_process_auxtrace_info() reads the (cpu, config) pairs from
priv[] and builds a cpu_configs[] lookup table.  As each
PERF_RECORD_AUXTRACE event arrives, process_auxtrace_event() maps it to
the correct target and writes the data to htm.bin.nX.pX.cX.tX immediately.
PERF_RECORD_SAMPLE RAW records are written to translation.nX.pX.cX.tX by
process_event().  Per-run first-write tracking (htm_target_seen) ensures
O_TRUNC on the first write and O_APPEND on subsequent writes.

Patches not included in V2:
Three patches present in V1 are intentionally dropped from this series
and will be submitted as a follow-on once the core infrastructure gets
integrated:

  - htmdecode integration: V1 patch 6 invoked the external htmdecode
    tool via fork/exec after writing htm.bin.* to decode the raw
    bus-trace data in-process.  This is deferred because the interface
    between perf and an external decode tool needs more discussion.

  - Physical-to-logical address mapping: V1 patch 7 read the current
    partition ID from /proc/powerpc/lparcfg, parsed the translation.*
    memory map entries, and mapped physical addresses in the decoded
    trace to logical addresses within the LPAR.

  - Synthetic sample generation: V1 patches 8 and 9 created a
    PERF_TYPE_SYNTH event named "htm", injected synthetic perf samples
    with the translated logical addresses as sample IP, and wrote a
    separate .out.l file with logical addresses alongside the decoded
    trace.  The appropriate abstraction for synthetic HTM samples in the
    perf tool requires further discussion.

Usage example:
Collect HTM trace data from a single chip target:

  # perf record -C 9 -m,256 \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ sleep 3
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 256.277 MB perf.data ]

  # perf report

Output files written by perf report:

  htm.bin.n0.p2.c0.t1       raw HTM bus-trace data
  translation.n0.p2.c0.t1   memory configuration records

Multiple targets can be collected simultaneously:

  # perf record -m,256 \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1,cpu=8/ \
      -e htm/nodalchipindex=1,nodeindex=0,htm_type=1,cpu=9/ \
      -a sleep 10

Testing:
Tested on POWER11.  Both htm.bin.* and translation.* files are produced
correctly for single and dual target collection.

Note: Link to kernel patches:
https://lore.kernel.org/linuxppc-dev/20260807143734.1224-1-atrajeev@linux.ibm.com/T/#t

Athira Rajeev (6):
  tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file
  tools/perf: Add AUXTRACE recording support for powerpc HTM
  tools/perf: Add arch hook to drain remaining data before event close
  tools/perf: Add powerpc callback support for
    arch_perf_record__need_read
  tools/perf: Add powerpc HTM auxtrace event processing support
  tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE
    records

 tools/perf/arch/powerpc/util/Build      |   2 +
 tools/perf/arch/powerpc/util/auxtrace.c |  98 ++----
 tools/perf/arch/powerpc/util/evsel.c    |  77 ++++
 tools/perf/arch/powerpc/util/htm.c      | 185 ++++++++++
 tools/perf/arch/powerpc/util/vpa-dtl.c  |  96 +++++
 tools/perf/builtin-record.c             |  65 ++++
 tools/perf/util/Build                   |   1 +
 tools/perf/util/auxtrace.c              |   4 +
 tools/perf/util/auxtrace.h              |   1 +
 tools/perf/util/powerpc-htm.c           | 447 ++++++++++++++++++++++++
 tools/perf/util/powerpc-htm.h           |  43 +++
 tools/perf/util/powerpc-vpadtl.h        |   3 +
 tools/perf/util/record.h                |   4 +
 13 files changed, 954 insertions(+), 72 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/htm.c
 create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
 create mode 100644 tools/perf/util/powerpc-htm.c
 create mode 100644 tools/perf/util/powerpc-htm.h

-- 
2.53.0

