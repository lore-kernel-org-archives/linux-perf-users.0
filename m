Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634256;
	b=Fs+71nIPOrZDcEuzhr+7O5wd3SeKBmH9VGPYE01isE3r8LMGqXMurgOcErUqpevs/gKv
	 7q8X2PqkbF9g9X3vu35SvkJfOzlDtiiSVRXryJC/zIt8khbXLp19hLFpuYVfYBS1V7F6n
	 67zcQ0B+n5YpEY81tcETyu/AMBvDY0XL9VoKSF+KZGmnQWVxC0mfXOfnOdrxcXgC8Mw/J
	 cIFKfjEbv1FujJ24nSHFM1qDb2nSJmf4BQO8TCi9euT5Z6Gb+0pcRapBm5iemVHJGIsY8
	 FhLOI/chtTNOHjrv07CPRZSysGilYy4lGnEicHJPohEhiILFcD1tq7z+o6XqyPl22aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
	b=p8FRDq2CYe8M16JjLzeQIIOSohYiBOjWTUHNmCt/nnstwUnoGt6FLGd07uL77YuB19U6
	 XQYPBFHpTiw68FVvf8bYewIImrlpdfV31JA3CaRKUhRjSFV8SubTwTOgnQHw/8V7s/5GN
	 6IuOjbT5azRroYwnEj7aSlvpxCr9cARaz9tdh/uW/P17lwQ/j6Jz09ctQhe3g+dkIDtLo
	 HOoeh0/D5q4A4hmSt/xr87ZNqwPQOgJlTIdgkHeofAGXmAnlES2ByiDm5IybDsJdcl21s
	 9WqapponIsHx88PKvRkTu8um7ThU+3lvFU01ox3Zxbp/GKd7qtzomSgdc+fQKcgDDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENH+XPCy;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A29606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 01:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A29606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENH+XPCy
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so838453a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634255; x=1793239055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
        b=ENH+XPCyJctxYy0tq/P/dNgxodBKniOt72zMFjcHfl88zP152hyucaTU7RJZf4QI1x
         1VpGfRQTR9BMTIjq7PqmW4d78toRZTLTxsmwNZLt56CIZqKfeDGwd7/hVLiAQGUE9xLn
         F6LDiVHHO3801WBDL3nqEPo57ozaTFsl5oZIT4EPDiOWTd41sFl/XYF6hvSs1r9WurX2
         LXE4lsm4XWPQo2UgKi2+Q6LrGO/06MLbgfsSUUp8N/mlZQyiDVupLjeRTdemuXbfK63X
         mPm1iX4y2RdwuUMCaRNX4Slq5YKvU1lf3YRAFvofA1yVVeHpFoFuPQvpIr8zc8Z0+B7Z
         wHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634255; x=1793239055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
        b=DHlxfCd5g1Z7trSxYGaUrzHg0ZqPFs0Xw6FDoi0nyWJyCkR+NRvPaELvo76CHM91a9
         COW5DU5/JGNgIeqMhFUax1gg37bjMo8vZ8myx5xlXdnL5chyXogwEoIWh052UqDDiawS
         7uRP07mdh0A7No6uCD4XKluJxO7Cy+JVi/ncZIQ13Cj9LkSRVYO+ZMBCBnNLuMEr3vL9
         g4TbkKT5B77j9aVUq/ZrIYwBFZ8NpefxRO7+InTWjzFCG9FZQm4UHs2PMW9x2hvtmKC3
         tpmrtgI3+RSmp1zyvPqgmgiYcXziGQbG2zh8CqS9iq1tj/ZH/aSCfDgUVKROPdzKL8KM
         8hIw==
X-Forwarded-Encrypted: i=1; AKwUvBwwNp+8WESEa4Ddhu8M95tFAZDjJFAia95zcxDQ/VReKLjwgp8DpX8tH6TjU0i1VJ9uMNnkOC8pVeUMeY/8lye2@vger.kernel.org
X-Gm-Message-State: AFq9FYL+pZAC6bKgwhasLOp2lW/lTRGWvHEf/1UORUbJqZO8eFxcMUsV
	b26mdgZKe4t2hqFIFvYDHhYlfvF7G1kHqrdcyvr2lP1FagffD1coNS72
X-Gm-Gg: AYBFou0w8inDOpHh377cKBQhlb+FsltC28msOXK6UImDCNSEEK6T4a90Ets8h4REtzT
	lyyClLEUUsaHVVJITtTyrS9G8sjOm3PJisUheaZ52ehF7LF1+mcbBA3CEw04Zn8rBrCGqiykr3H
	XfMv6XQyApEUFo7YoYCl+KinXW5Wsd7gd4d01HWdrXScY0k+9N8+gG7xPkpMHk88U6bGkEe2aY0
	FHMRa+8MD216wLSw0ePbrZZYQYbEJD0OrgjZf+YO6xTzVdJ8AIrdo4ZR+p0WL8p1qOaEQz9QOll
	FsUZBb3/zPekW0LNooGAcmmjziMsaLQdevfz4LvpfNRg0biqORVsPga2lzEmu/Pl7F8OTzD5Ulp
	qdZOFYHL82SMTQ29NkNVi7UEUlzY31APkMTx2qH+THVtDFrL9OzoDQoKHs7aKQUmUo9Ii6vQQLZ
	UQfDXJpLuyytD9zpTK649u3UQbN5gVNLOUBhi5Sjhooe+wQJpfxoKkTt43X0D29vvuqfAmmdZzL
	/9AmXpLZtmzwKJrcdSHB7lcxD7PwhHYfFbxFxbBazSEwoHjbH1YjNK7VWLP4vYnK2O0sXS36Cam
	1utpefTyfxhRQNcYKiddsCN+BiLxnarJIvAYW81O+xv6Lf740E5k4wpcBNg5h2rOBNVS906Ojyq
	1eJD7gKOfAAiqiET+v4UrbBXD
X-Received: by 2002:a17:90b:1dc4:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3ad86d4e4abmr2953396a91.40.1792634255162;
        Wed, 21 Oct 2026 18:57:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85fa6b87sm2978876a91.3.2026.10.21.18.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization which failed half-way
Date: Thu, 22 Oct 2026 01:57:06 +0000
Message-ID: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

int3_update_unoptimize() restores optimized nop10 in three writes:

  48 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%rsp; call tramp
  cc 8d 64 24 80 e8 d0 d1 d2 d3    1. trap new entries
  cc 2e 0f 1f 84 e8 d0 d1 d2 d3    2. restore bytes 1..4
  66 2e 0f 1f 84 e8 d0 d1 d2 d3    3. restore byte 0

uprobe_write() can fail with -ENOMEM, or with -EINTR when the task is being
killed. When the 2nd write fails the result of the 1st one stays. Byte 0 is
a breakpoint and it works. But the next set_orig_insn() doesn't find lea in
byte 0, takes it for a plain breakpoint and restores one byte:

  66 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%sp; call tramp

Nothing recognizes these bytes anymore. The process keeps the call into
uprobe trampoline, which can be unmapped already.

Teach is_optimized() to recognize the half-way state, and let the 1st write
of int3_update_unoptimize() skip what is already done.

The failure wasn't reproduced, but the state can be made by hand. Attach to
nop10, call it to get it optimized, write 0xcc over byte 0, detach.

"uprobes: Don't sleep on mmap_lock under dup_mmap_sem" needs this. There
fork() removes the breakpoint from its mm. When fork() is killed in
the middle register_for_each_vma() removes it for the second time.

Fixes: 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/kernel/uprobes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 65a2de82ecd2..62bbe41c6466 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -896,6 +896,9 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 	case EXPECT_OPTIMIZED:
 		if (is_opt_insns(&old_opcode[0]))
 			return 1;
+		/* An earlier attempt got this far and failed, nothing to write. */
+		if (is_swbp_opt_insns(&old_opcode[0]))
+			return 0;
 		break;
 	case EXPECT_SWBP_OPTIMIZED:
 		if (is_swbp_opt_insns(&old_opcode[0]))
@@ -1109,6 +1112,17 @@ static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned
 		s32 raddr;
 	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
 
+	/*
+	 * INT3 followed by the rest of the optimized instructions is what is
+	 * left if int3_update_optimize() or int3_update_unoptimize() failed
+	 * half-way. It works as a breakpoint, but to restore the original
+	 * instruction it has to be unoptimized like a completely optimized one.
+	 * The same has to be done if a debugger has put its INT3 on top of an
+	 * optimized uprobe. The trampoline can be gone already, so do not look
+	 * at the target of the call.
+	 */
+	if (is_swbp_opt_insns(insn))
+		return true;
 	if (!is_opt_insns(insn))
 		return false;
 	return __in_uprobe_trampoline(mm, vaddr + OPT_INSN_SIZE + call->raddr);
-- 
2.55.0

