Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074CF32BF47
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769572518; cv=none; b=J9wCEkmdVmbPUgciLuf9JwfTD3zBySY99Cb6f/Sw1pt30KjKoMoQlf4Z86w+2qMqAOCjI/9n+ZbJo533kWMmrvrwUlTcvKX4O42rwuW+/MTG+e2etQG2ixokEAuwWfgzGUaTgNUxnBSioALFEStMezULy6kGSKJ9dqqlcp5Sxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769572518; c=relaxed/simple;
	bh=5XHkihF9gAuzs5H0t3ZJTPCDGmTEqi1qzaU/bcuplUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ue2H1jU5eAft0cDYSuOtQOG7Ksp92MvRjYaW5m8FAoPz6byOeZIJ5J9UUkfAHZBWqXOloA0XlOoQ6Tj+OyFdqNOAgiENUI9tiuxmci9Ed1xe5+F5AI4fY1aVbYqMCOy0/gbnamxTF9GVSndO7b3KDF40HEKOZtH4D0ep6BG2WxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bngtXuII; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bngtXuII"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso3960736a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 19:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769572516; x=1770177316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtNlArvxgYAFVn81Dj8mmoJZHV823pAprWaDRjsr45Q=;
        b=bngtXuIIA3LQryQEWQRGW4OKB0DWFzgjmisfQ55hP6CPCQpSgNhRSLQ2MaEuFp4NLG
         X1ekpXi4YKAUf+LfkoNAWjZYlsVqMVAyeTvgjmFLFGIz+Uc9cLHgz1O2kKYwAdlZGge2
         RZbpaaL8B2KzAOKhyXfMtgj+diwlWLfqICICf2BDHDXl+BfgZBM8KwSOewSfS/REBp5W
         88V8d2p3iK0KQK3oNGRlsfZ2A0Ovm5WBwxlOYUiS5DkItcQ4a+tNYlepaQesVgPJIwHu
         ynu5Y/FkJMQaHUYvsaiWJIUVB1M156gK6U+uLdqsfgAkTDFDsAEQbiVJlXk2nJU/WpnZ
         P1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769572516; x=1770177316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DtNlArvxgYAFVn81Dj8mmoJZHV823pAprWaDRjsr45Q=;
        b=GOBZ/qHVeaQtkcF0OAI9MLffKMnuoL0ITtQdAENQCpLUdNmUyy3bEKNtgJc87arwMI
         EpA+PipLyJBdTSv+rfkC4es/IprUxE+20wEpl8D/Q6LjF0Qa+b743R7w1DJwJ+4ydzWF
         AqSVB+9ueS0yR+Zjd1vp3NxZ6E0wBTcFYAF+gS0WRpNb3kYg89kszGTx5+z25awysDxk
         PeMF0K1mXGvCOFTwszUC5nRHYcHju/PIDRBqZA9xhcA3iu62n93S9fkp768EQEo9DekC
         ad60xGnqkMyvEHW/XsTw4QHjeLtAS0x1MGHI3KUnOHYKP+RyKahOM+vi4m3T4ghwvv1z
         lLdg==
X-Forwarded-Encrypted: i=1; AJvYcCWli49e/vWJ0bymHrxcEQNz5lrVLK9qA2YBbvIkkaeU98adIiCnz/mVOtjoP3muFStJOqHYswHxw9faCTFraWCn@vger.kernel.org
X-Gm-Message-State: AOJu0YwngbCe+1Izg+WQ2rHHAPEfea9xDOBe04KCd4w2yaU0WFddaTPY
	FPqVqtld+gBI2vIH3QaDC5BhYXjKi07tGn6wTqKDhqBkMuNVC9S5pvNO
X-Gm-Gg: AZuq6aJC2DAqMp0l6ogk1l5hc/ATg3Vg4VJmewvjuWnI88SParf9GqitTGuMKSJ6StN
	RIvyxZUkTxkRLuP66OWdH1fyzSeKdtK6b31OJGEqat07+HHbKyYC89oLRoJ7amHUXpAcLDdXjn+
	Gw2yURUJ14wKpzNDKCPfNbreZL/jfUD6JXydgFi2mGiHWzMsjBMTzKJiYuIOuLGemTxdHl2TtM7
	K8NpXHNSHJ+o0mqWCaz61KAE6SkvRqW/vNRBmZu66XwlKsUX79WH6mwFv5T4hLQ6RnnT5AOnJlT
	ENIXyltdx2dWA8+1yvHEHQc659isWqgOsHRUu6H5GtH+UceWdhXV9+a+5fZyP4+3YrTdZ9J40q1
	dgkpelXWfstytWLzSbGJg5ZjkGPoee+ZaSipyM71E0X+H6a4gunLP6dRYK4a/vUjgyhHOBhgequ
	f0GezkOfIWmhhjH9SK+xEei2g32amYvpxj+NE+vg==
X-Received: by 2002:a17:902:ce8c:b0:2a2:ecb6:55ac with SMTP id d9443c01a7336-2a870d4cca5mr40087085ad.7.1769572516282;
        Tue, 27 Jan 2026 19:55:16 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414066sm7649705ad.26.2026.01.27.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 19:55:15 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] WARNING: suspicious RCU usage in get_callchain_entry
Date: Wed, 28 Jan 2026 11:55:08 +0800
Message-Id: <20260128035508.1840613-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000fe324606174e1f9e@google.com>
References: <000000000000fe324606174e1f9e@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..f97d4aa9d038 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -460,7 +460,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
-	if (may_fault)
+	if (!trace_in)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
 
 	if (trace_in) {
@@ -474,7 +474,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
+		if (!trace_in)
 			rcu_read_unlock();
 		goto err_fault;
 	}
@@ -494,7 +494,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	/* trace/ips should not be dereferenced after this point */
-	if (may_fault)
+	if (!trace_in)
 		rcu_read_unlock();
 
 	if (user_build_id)

