Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6319AA57;
	Mon, 30 Sep 2024 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726370; cv=none; b=sS3Na0xY0b0UU/GAuBA7YDFQ5yygyM057hXuUHS2vdEhteOiH5qPAQ+NQI/A3BI+So60XKJrpN1zw3rhpldBnf8v10OI5HHT0wJvWzrlru1WVmWDvomzh7BfaceKS5hZd9LnsZf0McWvou8m9g4sb5jmQj78/VwiCe/E/C8F3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726370; c=relaxed/simple;
	bh=5NmmrEnK8EnrwqH2ZUDZJZXTyYw4hqS9UFPj1sY55Pw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tLi48+eEbJz1WvkJ/C7DH/cFuI9H4oH+0JA1rabicI/dEp7HoSIHv1+fmpFpUNTy/Fzs3dcfhRvPyldFTXbc812RRaJ2Ir1e8RzD4kPCrIh2llfKkR6y3w1ybLrEXXi8PdjKL1dRTIXtyPak0azzML6Fgn9E/GvP4BrECIaOTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KLdnS7Kf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KLdnS7Kf"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UJu9D1024103;
	Mon, 30 Sep 2024 19:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=yQxDUX
	TCMj1G4qCKFF7q4BFUmsa0iyHbrnl2P10jhq4=; b=KLdnS7KfiVG7YblgMlCFGM
	bf3P4s0yf61W2hGsHgAgthWc2OXcg59TWahrxycM54rdafJ3CEQSOSta7NE8pWns
	CSXk/W1vvJsuqDvutV3yei4JehivSdgg9C5W/VspkyLksAKUL92lVTN1khIquT9q
	PgcCfdqJgjZnFiGiP4O4MZZpaqiOi00SnoWcTMhmbAQHPG1BjzOTyADKlyY8mMeI
	5u3Sj8EydOIo51yp2xpp0YDjT/JfDzrj4vX8zCPkUBzjjrJ76SM//nc+SimXuNws
	/aP6cf7tFxPjue1tKUIhGM9lWu2Y9UWOHa+TR0USAB6KRs6pk36yTZXvACVEc7hg
	==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k34q13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 19:58:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UJkuIo028453;
	Mon, 30 Sep 2024 19:58:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x886sa9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 19:58:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJu2cs033321;
	Mon, 30 Sep 2024 19:58:44 GMT
Received: from gkennedy-linux.us.oracle.com (gkennedy-linux.us.oracle.com [10.152.170.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x886sa6q-1;
	Mon, 30 Sep 2024 19:58:43 +0000
From: George Kennedy <george.kennedy@oracle.com>
To: ravi.bangoria@amd.com
Cc: george.kennedy@oracle.com, harshit.m.mogalapalli@oracle.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, dongli.zhang@oracle.com
Subject: [PATCH] [PATCH v2] perf/x86/amd: check event before enable to avoid GPF
Date: Mon, 30 Sep 2024 14:52:27 -0500
Message-Id: <1727725947-18058-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=901 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300144
X-Proofpoint-GUID: focYdnfSSzFjVpzzfX-Rnspnb2JJ5py3
X-Proofpoint-ORIG-GUID: focYdnfSSzFjVpzzfX-Rnspnb2JJ5py3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

On AMD machines cpuc->events[idx] can become NULL in a subtle race
condition with NMI->throttle->x86_pmu_stop().

Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
This appears to be an AMD only issue.

Syzkaller reported a GPF in amd_pmu_enable_all.

INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.143
    msecs
Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000034: 0000  PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000001a0-0x00000000000001a7]
CPU: 0 UID: 0 PID: 328415 Comm: repro_36674776 Not tainted 6.12.0-rc1-syzk
RIP: 0010:x86_pmu_enable_event (arch/x86/events/perf_event.h:1195
    arch/x86/events/core.c:1430)
RSP: 0018:ffff888118009d60 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000034 RSI: 0000000000000000 RDI: 00000000000001a0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88811802a440 R14: ffff88811802a240 R15: ffff8881132d8601
FS:  00007f097dfaa700(0000) GS:ffff888118000000(0000) GS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 0000000103d56000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
amd_pmu_enable_all (arch/x86/events/amd/core.c:760 (discriminator 2))
x86_pmu_enable (arch/x86/events/core.c:1360)
event_sched_out (kernel/events/core.c:1191 kernel/events/core.c:1186
    kernel/events/core.c:2346)
__perf_remove_from_context (kernel/events/core.c:2435)
event_function (kernel/events/core.c:259)
remote_function (kernel/events/core.c:92 (discriminator 1)
    kernel/events/core.c:72 (discriminator 1))
__flush_smp_call_function_queue (./arch/x86/include/asm/jump_label.h:27
    ./include/linux/jump_label.h:207 ./include/trace/events/csd.h:64
    kernel/smp.c:135 kernel/smp.c:540)
__sysvec_call_function_single (./arch/x86/include/asm/jump_label.h:27
    ./include/linux/jump_label.h:207
    ./arch/x86/include/asm/trace/irq_vectors.h:99 arch/x86/kernel/smp.c:272)
sysvec_call_function_single (arch/x86/kernel/smp.c:266 (discriminator 47)
    arch/x86/kernel/smp.c:266 (discriminator 47))
 </IRQ>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
Ravi requested patch resend with the following:
  /*
   * FIXME: cpuc->events[idx] can become NULL in a subtle race
   * condition with NMI->throttle->x86_pmu_stop().
   */

 arch/x86/events/amd/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 920e3a640cad..3a8b8db878f6 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -762,7 +762,8 @@ static void amd_pmu_enable_all(int added)
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
 
-		amd_pmu_enable_event(cpuc->events[idx]);
+		if (cpuc->events[idx])
+			amd_pmu_enable_event(cpuc->events[idx]);
 	}
 }
 
-- 
2.39.3

