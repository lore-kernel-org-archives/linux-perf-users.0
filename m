Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE04B923E
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333360; cv=none; b=ktPLASW462outCwxepis1NjSZUgCqX1kXiLfwA5zHB9IPOBd/X6aQdhLqH6gmeh5kJa/6v9gbquH0qklsnC8s7PQ7811caUWM2J+Q4VrqbjnhP5kux85VcjmL4ru0j6ToQZRStZePSmpUl1puXzpcToNqROeJ4n2YxS31O1lBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333360; c=relaxed/simple;
	bh=Wz3AynSRouhjdOCDf3ZwA/+MVGmp61qIW0ierhI97O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8BZIioPATPZ3WKWJz36kaZV5R4wWjCLYX0IfPKO4PqjuE8aGF+3XN6rH71XA/3WDo7g0vGa6vhgPBOm1KYAU3JIAAzIkgRdfOO3bx3WbChJ7IqgYjHZsBK9tW6QBQ14MRnf2juo1ShbTAtK8phtNibgjRcxbO9hKelXAHw31S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AelEXoD/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AelEXoD/"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab43af5e97so12906717b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792333358; x=1792938158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UaqrgWMwy8tCpgosdqPhUPyluySo43hO1tIzzayAGmQ=;
        b=AelEXoD/jFpzvxBjDq/fog/6V/zesn10H46n+uSfcpdMdsmkKch2HoJQjl7lzOarFI
         vW/s8lQi8f3zyrimnOVSmS5rMewI8/LXC6QTVYsyDlXeMKw0p1CD/k2oQ8JZK+c/NQVF
         5L00tS10iApcgVk/nV/Hx1nMa9jQvyJQLDGadmhCnnxMceOBJCRH4A71jZPqcApH9QEw
         1j+Gmxx/4mpjL7cn/rI7hURQy6EzPSTKREkMhPxAS5SN3n+KUOHhb8DaYOMSuegMbFHZ
         4nhPEoh6sih9WPJlXbkKiWxfGb+pUnj3wrCcJ0JMtRUBo1Rcs84j5QjHN7riLslUg/Nz
         eY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792333358; x=1792938158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaqrgWMwy8tCpgosdqPhUPyluySo43hO1tIzzayAGmQ=;
        b=OrILkoeg8HqSYa2prMyyW9Skl4OU3DGMnM/DJuReGXck6kfDNJHFhsfdqRnveunTGq
         OzpBkHho74JwDVzabv1HWfjnZzG87Dl7z1+sDdQjMI+i1eAQ3uBpRbT1bsIC3ioXBB+8
         c98rQeTxfAekIWQtwao80s/J3V7pHvWUbY8TCatpD8wBPBym0LiVMQLsim2VBwuFhhBM
         p1jr5d4K1Y/dZxEwCnKqFVaB2tbPA9N0aIY6cKL6NOJ/At0n5H7iMgi+lI1xrpkPAGJB
         EllCPe64b84euPBk2ip8B0nxlW4MtFuNV9mIAzvn6JIWojfCXLJn6E/eeoCaAda7nW9r
         hzng==
X-Forwarded-Encrypted: i=1; AKwUvBwiD2NDqdcaJWWjhJJS1uebHKMzzatQspI8HSb1rmEhiFfvK0vjXKTlZ2Tf7to1j69nTYfJIC25Jk2Glb5KyPfo@vger.kernel.org
X-Gm-Message-State: AFq9FYI3hiFNyEaF32uKefuNx7NGuPVl12+F4YFfuydWefD6IUzLs0UI
	2yXy1hyMLsv1K89vNedY5tsvx+kzeXzQpBqHBvHchO7f57djciy9YQeK
X-Gm-Gg: AYBFou2zaHJ1xKoesxc18WchLF7OYy436D5SB3i4HBSdv/6R+bH95U8zZCl7nrlp7Eu
	JQsAu56E2vjmzBqVr5Ue0fDLZGwfOupXKyCh+T31iS4ePbRAGU5PhnLnWwENVJjjJY5NzSUCUhB
	fsgd5keF2taGVFARET9qbhRwVOPm/IxmQLCrBrKZ/XjxGl0rO4C2tozPiaJpq71U6a38pI99O6e
	VJYzHtINQpM8O3mujzk2bel+ilct0ZPdb7A4R96JBDDjTHua0f3xgzZFoxXKMYfwoWl0inUnRKM
	EpQaoa1YC1CMVViiVFhA0j3AC+/V0u/AI/5XdinhvmfzDnNV7fLSHwrvJbMZcqgVKNe0pwP30hX
	XSdnzLA+G/BZJfQ4X3+E+4YuFP3v8hp47uJ7QS8LPukY5/cJe9RAaKlkGhgBGes63GRpYBO5+W0
	ZcV5MArPjZ5Da6MlQeJ0pIR+JWaVAl2sq3xbzCsiUusZXC4R2fhJBdeWCCXpSpjfTkv+N42TAUS
	eUKAH5FccZmpygdfhUdTGjGl9WoXctvYCH5hUbDHx/HJVDAaHGqlvSM2U93EzguY+BNaP9V354D
	JoWMu0vYK1Fuj5eM4gIkc0CAspK1Cw==
X-Received: by 2002:a05:690c:b83:b0:8b0:a5d3:71c1 with SMTP id 00721157ae682-8b0e2e6c2camr28200027b3.37.1792333358446;
        Sun, 18 Oct 2026 07:22:38 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net. [108.93.236.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e5888374sm30064117b3.9.2026.10.18.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:22:36 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 18 Oct 2026 10:22:03 -0400
Subject: [PATCH v3 3/5] alpha: use user_stack_pointer() in KSTK_ESP() and
 dump_elf_thread()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-alpha-perf-regs-v3-v3-3-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Wz3AynSRouhjdOCDf3ZwA/+MVGmp61qIW0ierhI97O4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKuXOM0nLfE6+wE3UYWDfllErc8VFat3D6l4cPGHZFfN
 pyIlWNV6fjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhrWp8wMuw48G0dr4
 HQU+nXD7snpn56+Xe/bdfNJw+D6h6kXrtfevkEw3/PLq+qlXGyRw4z377+UM71z49SLzbLaAOmw
 30LFilrGjIDAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Both open-code the same PCB lookup.

Assisted-by: Claude:claude-opus-5-5
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/processor.h | 3 +--
 arch/alpha/kernel/process.c        | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index c461a26d47b3..73251cd671e0 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -43,8 +43,7 @@ unsigned long __get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk) (task_pt_regs(tsk)->pc)
 
-#define KSTK_ESP(tsk) \
-  ((tsk) == current ? rdusp() : task_thread_info(tsk)->pcb.usp)
+#define KSTK_ESP(tsk) user_stack_pointer(task_pt_regs(tsk))
 
 #define cpu_relax()	barrier()
 
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 06522451f018..7861c9e767b7 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -318,7 +318,7 @@ dump_elf_thread(elf_greg_t *dest, struct pt_regs *pt, struct thread_info *ti)
 	dest[27] = pt->r27;
 	dest[28] = pt->r28;
 	dest[29] = pt->gp;
-	dest[30] = ti == current_thread_info() ? rdusp() : ti->pcb.usp;
+	dest[30] = user_stack_pointer(pt);
 	dest[31] = pt->pc;
 
 	/* Once upon a time this was the PS value.  Which is stupid

-- 
2.55.0

