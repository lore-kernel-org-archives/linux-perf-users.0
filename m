Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B14657D0
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749820; cv=none; b=abBztUy54l0d4HQ1jBlniQT5abliIDbBKY6XjLGNIa7kpOq29r2UUHN/lRe7t77lnU788ZnAg1hj3CVlXohGeghJIHdqM+rcM2NeAKzOGnm8lf3cIsHMRN33Yo2rD5t8LKo3ekeyGO0NaYnlZ3WI6eXlBdn95XjxHZ6At4SCXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749820; c=relaxed/simple;
	bh=EK/AHmbH1n+ZAeHspiEn4hLS0GOcVytyzjbFj3NwaoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5s4Ss+7VfPdPAd5hPYTwhYlUa7ZBxe6tSzBBv9JA06NjqmDCAxxUIua2c/DfAOW0xV9UIDH650EwFh919iVYWk9cGc3yag+uU2nETKpRMR9eMMv/FSxtowU98en/xRANRXmRlMPQnudlCIk0BqJcau1Ru4m4fnZchnUieno6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPC+t28l; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPC+t28l"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67699afea08so689005d50.3
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791749815; x=1792354615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QDGl5tBxqOySAH/1T+QSowfg3OeZNJKzvcjJapnD0fA=;
        b=iPC+t28lknvSbybHRaYhiojnh1vHxRe9RlhN81mUnSnhFXY1y/u9/VGuNdcCytG4sN
         yu++I2OupkUeHtgnykNoysE9JWxxBdeZOe9SisaiGjRaPvPhA5ANCzvVdt8eh4Z72vHB
         0jS3nHINfBqTRPWepnioO0fZDedx+/9AkgI8D5LeTXmAkzsg6axVVG6LxhBsjGQcv2Ad
         5NFbqzAeJqxfBbK7cyxg0HL5+GziK+cSF8mcIwaJUey+bln5u00TddlMdpfkcS+ka19L
         20WewqphX1EM2aOk+4QxGIl4dzkZVCMLA0/dq+gGivKuAYvISitV3YU1ntMDzJVC9lZZ
         O2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791749815; x=1792354615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QDGl5tBxqOySAH/1T+QSowfg3OeZNJKzvcjJapnD0fA=;
        b=Hd4i7ofGsNb0Eg9v1ByyGD0IOzzHH6SRzGeh0pGe+X1mVARray2TmmMqu2VBbU2p5H
         c4Cm3lFvl7WEdF+A96iAv8vAP9X6wwv5wGxC4m2V0sFZipshbOYWzuDRM7Vdh1OcEjG5
         ni1yfQ0AF756/xeb5+PUDMGHq0yOvQtMh1BdfUJQjD3LVnsKq5LXcmHzcSsqkQIEGIHi
         znf4pmUl5nsYdSDoLcQ9cWA9CFODuqksXSO0SPyr7zIpWdja7CUcKYWrtrh3il13amTI
         uysTkDbQzPFknv0xmQMIGUW8rZ5TjLbO8Mrj8PMDTNdTSsfWyh2vCqQahW7XZyTvDYL3
         8P3w==
X-Forwarded-Encrypted: i=1; AKwUvBxcurLN2LbJ3S3NdF2b9mzE8On5gGR80t8mnl9SwDHwkVBToO/p7Puu1i2haNTr5ElEwPPZ+MHPXYbp/tk1Emyj@vger.kernel.org
X-Gm-Message-State: AFq9FYIje6SAt1zMU4M+xjzaR/KRA4FraJ31ZQABWCJpPdxbe9uYt8xp
	Kb8dTVIrsCGLiB9GtLM9Gy2ZJNHMVuFMqcuiJNjomrEMqX18duLzUbB6
X-Gm-Gg: AYBFou0mtWFkM3kmDOH8JqxIqWqa15Ws25P8fWD0S/0xtzX9Nwe3ICEU5fTJ0ClSegF
	WG49I9Zkf6HKSK2+GAWWs4sbLlSl6i4pmioVLLfTFV8o5cQa5aKEl3UvAp/7pocia258m2LxjBW
	LJxxVz54dzgjB91b8toj1bGkw4toxAwDa0EtRHYm+MzuYlWac5dnspi8yIWdN7OamxHxtv67THa
	Zk0LjVnY0J/yhfkqLG9UAM2OLZdyBldSqYzTJX4b0RC1Y3CcUXUZ5EbYTLl45GemR1cTGYqaPQB
	Lc/3nMJdUwcwQqWPFYisevLUklORXFp/iXAIYtY3RhPVYUAUxlpwF6FlJYXAVnzyIHWHGcsv8P3
	nf8sca8ICVc1rD8yQA/JlVJmcDzWgB2UWzmMsvMckse79uEUD563AvVUxhSw++0GPo9kKkxEdgj
	SuFav3sXhCc4wfZNU2Yt6lSiEtu5udspv3c9m2k9omc4yFfuhvZnkOpzrnu7UcvFSP7IDjriv0y
	OEWS3+LtMioUPIPsxKdHUzTI8qZJzdA4YuCDGIgec9qqNSzoEE3SIxC
X-Received: by 2002:a05:690e:14c1:b0:675:40a6:142c with SMTP id 956f58d0204a3-67935f1c770mr2510955d50.22.1791749814894;
        Sun, 11 Oct 2026 13:16:54 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679356ffbecsm2995049d50.23.2026.10.11.13.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 13:16:51 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 11 Oct 2026 16:16:43 -0400
Subject: [PATCH 3/4] alpha: use user_stack_pointer() in KSTK_ESP() and
 dump_elf_thread()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-alpha-perf-regs-v3-v1-3-eaa625a39712@gmail.com>
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=EK/AHmbH1n+ZAeHspiEn4hLS0GOcVytyzjbFj3NwaoY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJOv1slrzqtPdz4pVV3ZCSTN2vLQi/23yz2efO+50UGW
 emsPfu94yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK5JaGD4X68+m2dhze
 Ffk+RmJ/evOFBn7f/2mPOxd3MNwrc8qZy1LJ7hr8wLI+O81eF552fzcfNsPtvFIXbu+7NbF9Qvf
 Ba+2MEhwAgA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Both open-code the same PCB lookup.

Assisted-by: Claude:claude-opus-5-5
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

