Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A2537F8
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264455; cv=none; b=f8OnkPDr8H45h9l2oaC9DttPHvrw16cl4RCKSofHwsme+gxViU+9QjGrU43xAFjcJyMMMaNPzQVMDx7vGlg2yuQ+KQnAecuCErcwYXeOacvg9s5hfJg4mj2llyBlV2lIln7hAWaNBNlst2J7IpT0rfq8D0WY54c5B9L/J/5cyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264455; c=relaxed/simple;
	bh=8OmiKAixvVd1qUodpWB5lP5+cBj7n2qE/sWCnAHwWYc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K+i2fkLKP63c6H3PN1p4PokouDR9EQFSYXdiAWi1eLaViOfMank12R12lkHbTtgHFTq0MT9OVPcx3mE5Q+MPw2AZlgOgxO6k6VNItEKSL0yTnS9DQoXSBiII7Ph7SS0emBOKsKrueYh0XKpV1RFKx9o+xMy152NQA7b/ABKoHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EZX5VuK/; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZX5VuK/"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fab979413fso42319706d6.2
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752264453; x=1752869253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PyWhAnCYCt4u7XeibLhzzMMy2HX/pV/921yEKYQT3nc=;
        b=EZX5VuK/u7S5M+aWGimT7F/hqXXdlXnl81r/teW4bP0JmqLJpQ85Qq7jbb80N//C8X
         KE9W+ji1Sy96Xfjg+Jm4cH+KXGVaAMxXvagu0dYR9JFgQCLEMEnPjc+5kZ9y93XxD5RO
         joUEKkhRAhRLqtsP8Op4GglVHV6AVMXajL9G7ftYPBEcstYGCsPlqBw0PmMtM/s03odB
         gi/fw5vkeXwyYB3FJw6Nim8eKUbj7SJDaMzxkvTQOEbqJVTA+3ktfGKiMaUVklwm2mTE
         diodX5RVp7Wc1eQ5UNfhULR2nvLBm1Nit8xGGjwCXTxTCyy1wbwIoWIdgAA3kApMQH5d
         JRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752264453; x=1752869253;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PyWhAnCYCt4u7XeibLhzzMMy2HX/pV/921yEKYQT3nc=;
        b=EqIGkqyJecYX8UOesxfB5G3OKYNyt0TC0g9ymR1WyL+GTkLbOkFhYbIVIOlQUKgj3a
         80c2yfTNZvLSceY+tACmQ4ma1ZpdY5O8IuopQ6bzuP0CjMrd2y2eRVvLZ6ukZfN5t0Sq
         NkkXLW0sAwipXwRwwVDRnfbvOf6G7x1+d6izzIHvAg4Zxxzgt6c26UDt0Q+WNHVEfInc
         hn1Hc9zhY7PbV/CY07UZZ+vQMicdOt7D/yKXRrDZtybbW7yEOXihV2C2h+UE2f8BLtd5
         r/XryoBWgjkvPGjjcGmLpRWYyP7suQi+iiZwDYg/yJKc/6NRFjTfv6LXRE8NbVMacqJw
         qHTw==
X-Gm-Message-State: AOJu0Yy+/3h4HxARb6XO0TgcJD0WHrD7HxtHENw0RxiaNrpzabNEK4QO
	QqQAoFNOvAC9sjmc9MiFwH8zcofY/2PWHr9u9usg80k58oZSUwwvHCIdEMIz4y48LvCVMZqHcQR
	NC4o+GpzwvYuCHMIwtD1B4GBzYvu5Sw==
X-Google-Smtp-Source: AGHT+IG3Murba99pf2Nruu8809aM7LvUkJqNwkECR/wtGoS6MccCGJJni4eGnXrjYnl4jQo30klzBClcQ70IO8if9b4=
X-Received: from qvvv14.prod.google.com ([2002:a05:6214:808e:b0:6fa:e85f:14f9])
 (user=mattgilbride job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2304:b0:704:8f24:f044 with SMTP id 6a1803df08f44-704a39c6951mr90664806d6.34.1752264452777;
 Fri, 11 Jul 2025 13:07:32 -0700 (PDT)
Date: Fri, 11 Jul 2025 20:07:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711200705.1545447-1-mattgilbride@google.com>
Subject: [PATCH 1/1] uprobes: relax valid_vma check for VM_MAYSHARE
From: Matt Gilbride <mattgilbride@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="UTF-8"

`valid_vma` returns false when registering a uprobe if the provided VMA
is writable (`VM_WRITE`) or sharable (`VM_MAYSHARE`). This causes
`perf_event_open` [1] sys calls to fail silently. A successful return
code is delivered to the caller even though the uprobe wasn't actually
attached [2][3].

Remove the latter restriction (`VM_MAYSHARE`) from this check to allow
registering uprobes on code that has been "dual mapped" into a
process' memory space. This is helpful when instrumenting just-in-time
compiled code such as that of Android Runtime (ART) [4]. ART maps a
memfd twice, once as RW and once as RX, to uphold W^X for security
(defense in depth), and also to provide better performance (no need to
call `mprotect` before and after writing) [5].

uprobes already work for code that is ahead-of-time (AOT) compiled by
the Android Runtime (ART), as it resides in a static ELF file [6]. In
order to attach to just-in-time (JIT) compiled code, the Android OS itself
can coordinate with ART to isolate to-be-instrumented code in a separate
memfd, which will be left untouched for the duration of a uprobe being
attached. Thus, while the VMAs inside the memfd will *technically* have
the `VM_MAYSHARE` flag, the system will ensure that they will not be
written to again until after any uprobe as been detached.

Link: https://man7.org/linux/man-pages/man2/perf_event_open.2.html [1]
Link: https://github.com/torvalds/linux/blob/088d13246a4672bc03aec664675138e3f5bff68c/kernel/events/uprobes.c#L1197-L1199 [2]
Link: https://github.com/torvalds/linux/blob/088d13246a4672bc03aec664675138e3f5bff68c/kernel/events/uprobes.c#L1256-L1268 [3]
Link: https://source.android.com/docs/core/runtime/jit-compiler [4]
Link: http://cs.android.com/android/platform/superproject/main/+/main:art/runtime/jit/jit_memory_region.cc;l=111-137?q=jit_memory_region.cc [5]
Link: https://source.android.com/docs/core/runtime#AOT_compilation [6]
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
We've created a working proof-of-concept in Android that demonstrates
what is described in the last paragraph of the commit message. Thus, we
introduce this patch to understand the reasoning behind the original
`VM_SHARED` (later converted to `VM_MAYSHARE`) restriction, and the risks
that may be associated with relaxing it. It's not clear to me why the
restriction is there, and we'd like to get feedback on why it is or is
not still relevant.

 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a8caaea07ac37..1ecb3fdb853b9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -123,7 +123,7 @@ struct xol_area {
  */
 static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 {
-	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
+	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC;
 
 	if (is_register)
 		flags |= VM_WRITE;
-- 
2.50.0.727.gbf7dc18ff4-goog

