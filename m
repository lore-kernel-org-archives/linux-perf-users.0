Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B4392828
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202179; cv=none; b=QbavsAO8FUpHqN6t8bIA0VTwZAad1GxR800xTUmIiJ8Nd+E8W3Ab6bo1z77Ue1I/o7SLJXXb7JKhJmx8q4KnzVloAFCnIFj/IR+um0I2ZhDjh5JeZ7U85gRrFPvCZ8Lw9JIz5ZKg8CW2IAztajT+AkrKO85NGpPmupkwkWhuWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202179; c=relaxed/simple;
	bh=Wz3AynSRouhjdOCDf3ZwA/+MVGmp61qIW0ierhI97O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTH0h1fV0MtPW9nog11kcurcAgdWlMn7UdStp/jCoAyz0pSP+JeaG+0REwC+YsfG+4BtkA1uNfJeVaGM4YLm7ZPAd3Uk2vWL/oC2/YQQD9zSYGl2Ll1v2cG+vOeFK0M2Jy32ij60umy2eQvMYDx8K0FWx2QChM6pD34XkXW9TTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il3L/+7I; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il3L/+7I"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab3d3c5761so4172017b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 18:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792202174; x=1792806974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UaqrgWMwy8tCpgosdqPhUPyluySo43hO1tIzzayAGmQ=;
        b=il3L/+7I7mxcfA2VvtNp+Jf+OvDkvjfA2HjoQm2XTSdD2tkB6Rh+bRZ1cozRDmuDja
         KJpsrehU8XvBPvfyAJJDB81GbXLb18c/k7uRc8Wb87RI2BSWKhcu/GQZf0bEnbbMrrCu
         6iXLBB5cq6oWufex4z5NC0C08oxlxmJ7U1zWuAOWSnb/fzMUv7zgh9qFPMHxDYlPvgOh
         jzIGBAU+03/PLFmcNatsACOf0fcBjKzNPk0XkHhxfRp9sOzHHnG5UBKNE7ITK7dmRl+K
         wR8qsoRP8sRuiqWHZW5qXvlrndWG2jy5NkVHzCqLOPTTj00OSGOFZ4D94wQf2m2C0LYl
         FCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792202174; x=1792806974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaqrgWMwy8tCpgosdqPhUPyluySo43hO1tIzzayAGmQ=;
        b=iqqHl1/ESAEqXr3wJcC0LJ1N49RZRhndWwauZ5kZxp7Y/aHH1JpQ9FzB3FNOeJYouj
         IDcqre7Jbx2R2PMm/wXYN5AP4JfyKlGGuJlT+NSQtS1lvHtREdIROaAxI0WyjmnEUkms
         1tKEpMSoB2yFpCSJTwKCQJS6/h5/2ykYY9PIo96MYvUrJfBpciDpOsZvcHtAry7g7kV4
         tcyFuZgY6ympgqHJf34Xm/xfJ6R5usNGyxhJBiyIIQ+nW8TAxJuzfI0Wk6TKTu5NEsqE
         vwxc5qMvqzYXJaE/NzP3+K9PV9XoNfczxArc5kBnoSld2NTp31FdJQ+eAiKuFnBj3xDq
         H9og==
X-Forwarded-Encrypted: i=1; AKwUvBzXzYoR7vnm+f2RTxYrbCu2GVaVU+DtandF4GS5v7519ObfzAiPeNPMsPSM3eGMvnTSkOAy+boapMQb580RnTJY@vger.kernel.org
X-Gm-Message-State: AFq9FYK0Fcq2+Or26Q8h1s7n5Y/3hLVFFXnRf94YsybVZ8fz0U4UNN8Q
	Mo/G2fkqfPjLHr6KDoe+YLrlPLCE0uaJR08BWFF+ltVocnKTfe3QKWOu
X-Gm-Gg: AYBFou1aR2EdBm/GfXBcl+pfGZ5JwPQ+DUnKwoNMupOxXng9nU9Ksox61mBuVWoftAA
	ZPJ3r9F78PT4aSmSrvFG/ueexPle13YMiRNUqjKS7ZalEAzcuyy2oYwKG9BkLek7iRgrK4VSuiM
	XzCHuRfK6rQGVXc+mGg3AOCAkDiLuIpElrvhBKhe/63p+ePXAcetP715rQXz3+8DcTyN5TogX+l
	tMFPHvg7nVqt7DkpOiWNX32JQNbaTrQeRoGT59CsMp1JiK1XqTlmU6c/NT2w3J71PIDHDWy8raV
	ZeVEn86IOdDDN/wwM3KlPDk9IE+tHghgNy2mrKbWzyUAvHBRI8h9l5SWBxZzl+8n0hCycailyqg
	jNzYTT0J6wtT+rl9a5MLQIs+S6PNZEjHl/H4MoJ1qNoTB/3izK5oCkwhTUu3a0kWjiBKzauApBX
	kp1zu5VEJQ9bK2elbuuKdVobplJ+5K0Z7ztJARiurFTY6SqxwsQVCuyWAUuj/Gg6pDcd84uwPqK
	raJi4HJqawglAIskvQUz9wsArl+fK5V3u/Mh/3+uQClWZfQQq7uf0B/zxb5uI1ji9YOy9387a4v
	ebBgIpCpX4k/bh9eezUnJ0iDG0LY
X-Received: by 2002:a05:690c:6087:b0:8af:511e:3b11 with SMTP id 00721157ae682-8b0f21eadb4mr6904497b3.48.1792202174247;
        Fri, 16 Oct 2026 18:56:14 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net. [108.93.236.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e590f2b0sm16451427b3.32.2026.10.16.18.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:56:12 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 16 Oct 2026 21:55:49 -0400
Subject: [PATCH v2 3/5] alpha: use user_stack_pointer() in KSTK_ESP() and
 dump_elf_thread()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-alpha-perf-regs-v3-v2-3-17654742226a@gmail.com>
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Wz3AynSRouhjdOCDf3ZwA/+MVGmp61qIW0ierhI97O4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIuXV18oaedwXBtcNY/PU7ZgKh3l60cBdk2iay4Iudgv
 OkJ332Wjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLkmnYeR4e+2bUnzM4
 v8Feeqlt+s8DNP0IyQ03RvC3j369Ff4yc3mBkZdtYfW9l3r164yKCWw/lqS/eTvUU7frZzbxKyf
 2CyIr6KEQA=
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

