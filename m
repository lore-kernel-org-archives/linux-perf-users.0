Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8B1BC3F;
	Wed, 29 May 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990934; cv=none; b=maViRtqBbS3H2WrQwBn/3VI2iEX2aYtdG68ZqhWlBLOsSvW8zUug2TjgP+Il6eNMveVsf9P8NLFitEeP05UdyCwZ0lJZ3f4oD5LReBafXdRJFZIuR6nFY3B7jgzK4m2AOmcBRArKzIkk3zqcwUJNn6DfdW7aVGOJv4HzMtfF1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990934; c=relaxed/simple;
	bh=6jcQNsCvY+JpvW9FVjrFNk/SKoKnw/YncD30kThmSWA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a9v8MB1Ibu/5AZyqjXjZDDJ+7tAuFjrtKLOuYmFxr1V/0b5egvPrH8/0O5PzUmKW9rXYiB0qY2tUbKKe/7CNSyzmDuAkMpKB4RG99LAOcdZpGaxP1tr5Yy4WTdigugi4Xyc7ewuaS08XJrIJRzbDyy4qwJhRLUTt5iGTxF955D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lCKDd6q+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCKDd6q+"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44T6IE8V011830;
	Wed, 29 May 2024 13:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=cc:date:from:message-id:subject:to; s=corp-2023-11-20;
 bh=vTFAiKTF41qcxLLU9YlRgqd6sEZTYzENFGNRbzhew58=;
 b=lCKDd6q+h1yU5xXiw0rRGezFigyNyYTIFWezAJbAVuCKCUDjo47H9c+oIW+fhTyN0BQ3
 ReoBCMdv9OETbAbjmfYq5ZWMcmweiH7P/E1jD6y21BGsyBz630SaHHvEGWw+855jgGeE
 eVVYILo6W3dHjmArYKO3uwvbnXMwv/qRoj1cyJoA34ZTTMsJiintLuYeSKa8/005zYRs
 AQFiq9o7ZiXBlm/w99zlMGzIlSlKJqFyO6SLcN4j/c7ycFBqH/eJJOP9C/CCZO0cg+yc
 wIIpZUAwrnNJnMO1tBYBGml0PN4NeR6lGNKmomk88tHm5uY3vA8Y8qAbCSPlau6y6kwx Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fcer4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 13:54:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TDRE4U014920;
	Wed, 29 May 2024 13:54:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc536sx6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 13:54:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TDq573016635;
	Wed, 29 May 2024 13:54:52 GMT
Received: from gkennedy-linux.us.oracle.com (gkennedy-linux.us.oracle.com [10.152.170.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc536swjj-1;
	Wed, 29 May 2024 13:54:52 +0000
From: George Kennedy <george.kennedy@oracle.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: george.kennedy@oracle.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] perf/x86/amd: check event before enable to avoid GPF
Date: Wed, 29 May 2024 08:50:59 -0500
Message-Id: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290095
X-Proofpoint-GUID: nMcBeBaGM9W4L_m2-VslMQ1wen67bpr4
X-Proofpoint-ORIG-GUID: nMcBeBaGM9W4L_m2-VslMQ1wen67bpr4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Events can be deleted and the entry can be NULL.
Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
This appears to be an AMD only issue.

Syzkaller reported a GPF in amd_pmu_enable_all.

INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.170
    msecs
perf: interrupt took too long (191950 > 156435), lowering
    kernel.perf_event_max_sample_rate to 1000
Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000034: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000001a0-0x00000000000001a7]

Call Trace:
 <IRQ>
amd_pmu_enable_all (arch/x86/events/amd/core.c:1341)
x86_pmu_enable (arch/x86/events/core.c:1276 arch/x86/events/core.c:1335)
__pmu_ctx_sched_out (kernel/events/core.c:8314 (discriminator 1))
ctx_sched_out (kernel/events/core.c:8328)
__perf_install_in_context (kernel/events/core.c:6235)
remote_function (./arch/x86/include/asm/atomic64_64.h:20)
__flush_smp_call_function_queue (kernel/smp.c:189 (discriminator 20)
    kernel/smp.c:197 (discriminator 20) kernel/smp.c:540 (discriminator 20))
__sysvec_call_function_single (arch/x86/kernel/smp.c:193 (discriminator 1))
sysvec_call_function_single (lib/maple_tree.c:3155 (discriminator 2))
asm_sysvec_call_function_single (./arch/x86/include/asm/idtentry.h:709)

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 arch/x86/events/amd/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 1fc4ce44e743..0ead72d3e206 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
 
-		amd_pmu_enable_event(cpuc->events[idx]);
+		if (cpuc->events[idx])
+			amd_pmu_enable_event(cpuc->events[idx]);
 	}
 }
 
-- 
2.39.3

