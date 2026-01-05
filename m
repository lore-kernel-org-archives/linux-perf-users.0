Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564431AF1F
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767580731; cv=none; b=X+1mZnUH4YgXS1B0bSNk3MGZ/vBsEgaOT6eda9IDEBqH/+gqyE4xDniBe81droxb97NA89i9uWAqTD2zML/R6FJqSOEbJcKDlZOXBrJ60EhFuYyaNsiz58TX3F0J2ME13x2MW7GyBXKzyH/AYtxebLH24FPjbtW3pmANW0qMp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767580731; c=relaxed/simple;
	bh=6/acNCX7vjm0NM8sd8jjQdUv18qEJnBBW6xmNTJlIJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EN5RRe/hxyfdIjP9bTdZ/hvpBPWhVGnpDvRxHbzQSyyRwI88g/h2XFY7crUd3MPF3uCiKwnnkW93HTAHzHv3yuXAm3fjORmlBSr6ZMRmqC2W8BxJM4tSKQW0fj9gwkD/79Z4kDDhADJxVd5mjtK8eJXZpp8o0GLY3DR2hKqb484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAtQCGF/; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAtQCGF/"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0a33d0585so123424635ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jan 2026 18:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767580729; x=1768185529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ltBIrcQzwz+TGu1FSwRd7xy+jtxW8km5l5/wzkRfIg=;
        b=WAtQCGF/tk3avh41SqEa/hWUZHsCnPDb4ZiPvE/GIqLqWjZiarl3D0gQMssdptHyN9
         micp8bXVsoY6/thnLB1Qc8ocspUTdGQEhaO/FSfzuP4CIZr73Y6UFjTXewVkAQ8dMW33
         1+E1bdbQLMeC8xX5yb8OFH7ACfk6sANpf8BaKICCXMYQgRcBhnkVvSVhCu0Npb6fZ1KE
         lVcQ4lUiWFPK8ju9Kh2prydQrnaFIP31nPRdmj5ZSpoSDIQ6CrpcvoVulgFnXomes9cv
         VUreuytTQ4HhpBNO9ewPXHI6DJ7HeDbg7UJQ8HDfRklj4CrcoXlV9DwO4WbFcypF/UTe
         e3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767580729; x=1768185529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ltBIrcQzwz+TGu1FSwRd7xy+jtxW8km5l5/wzkRfIg=;
        b=krtaUTF/Gxu0up3H+7aRIIdEaEBknVo7/0NMU5TEFb/u48ZbsqzHMsJ3GnC4FHzo8E
         KKhHp7o5XX8Ou8UAl0SuyG9ebBwEPJfrYU+Qh2aoUSfxOFyaRMAMElzEhhPZAh2+iWsL
         aPbuY3rgl7W/VXrJHW2CXOrq03OvjU3mRjzph1eSS7pa9JXjNJcOXnub2OLhfWkplZnR
         lfFDvzrglWocqs40SkFuGaWXOWUjvrB33OG+JS+x9kq8sT7xZkxDngSnCsCdcEt4Uhe9
         RTQwOVwJ2RMz+CrNat0phLfgGQruG5fmkDTuK4uMW6K+GHhvVCeS65vmF0rtYx3fqPeQ
         VZlA==
X-Forwarded-Encrypted: i=1; AJvYcCXyccCuX2/Q28srx+yUkrhJerkozDDuhFcmu+Dq6P/KGnwdzU4D0S0XjjydvqTmoYBzJhNi05kzfCqbvFUo/6VM@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtyQMYF/2jj8K3/Z0uI6JMhkvVkexT+rLdxD11vWQctbRGQqw
	PRjNJ+GafLnCvPRlPoZbYgkLTrsqcsoNFir0jLqLLbcS3pSzgKXQNlu2
X-Gm-Gg: AY/fxX6bkTe5qXQGDPD/zzKFPxlKG8bs0yD915b1P2wOMKcHaWjKcYGgKhPbsO2dud9
	1Ve10lQloy0rUPu8P80F9dOy2/4Y+ScuA04acEPZaqBVPqyVuAu18fsxfEGm9gIoQ4V2tsonYhn
	ikB48ch3/PKznDFXCwPM3v07hgC2f2kSYZok3Dwxr94StN7hGLAuVlYBVSROyfuqdmQnVVmv8bp
	xnk4aJEaExDbtxMTqN/I/e0+q8E63quYqOZrml1h2qia2k1SAwiluGl9fpw/qaqjlPvzNwEmAX3
	ZDOJ/WYMgXJ0b+Z77rEIpHuhg4vNaYXJk709Y/0UF6lmMUwXTQGJBnqwuupmCDRxvOz9tThzmC7
	h/5c9cxaGdymWVB2EMLbDg/kw2LJUTW0DqgY9mss41AeIdOipJYiD8MEeiGLoARhR63fgGxFAir
	D03QMMlQfZMDOv0m6b3k2fn8gSFIpFYehlGSs2MA==
X-Google-Smtp-Source: AGHT+IHkPLTkF7fQWPd2p62Rv/D6yyxahxmeMXUfRBuO1yoXeRazXHIrZvENtli2a8EDJfpEsk0qOg==
X-Received: by 2002:a17:903:3c50:b0:2a0:9040:637b with SMTP id d9443c01a7336-2a2f2423178mr500699145ad.26.1767580729318;
        Sun, 04 Jan 2026 18:38:49 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d74bbbsm435854135ad.94.2026.01.04.18.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 18:38:48 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+e0378d4f4fe57aa2bdd0@syzkaller.appspotmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __task_pid_nr_ns
Date: Mon,  5 Jan 2026 10:38:42 +0800
Message-Id: <20260105023842.1739283-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6891c7b8.050a0220.7f033.001f.GAE@google.com>
References: <6891c7b8.050a0220.7f033.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8e..72b9b37a96c8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1975,6 +1975,7 @@ __latent_entropy struct task_struct *copy_process(
 	struct file *pidfile = NULL;
 	const u64 clone_flags = args->flags;
 	struct nsproxy *nsp = current->nsproxy;
+	struct signal_struct *free_sig = NULL;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -2501,8 +2502,11 @@ __latent_entropy struct task_struct *copy_process(
 		mmput(p->mm);
 	}
 bad_fork_cleanup_signal:
-	if (!(clone_flags & CLONE_THREAD))
-		free_signal_struct(p->signal);
+	if (!(clone_flags & CLONE_THREAD)) {
+		free_sig = p->signal;
+		p->signal = NULL;
+		free_signal_struct(free_sig);
+	}
 bad_fork_cleanup_sighand:
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
diff --git a/kernel/pid.c b/kernel/pid.c
index a31771bc89c1..1a012e033552 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -329,9 +329,9 @@ EXPORT_SYMBOL_GPL(find_vpid);
 
 static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
 {
-	return (type == PIDTYPE_PID) ?
-		&task->thread_pid :
-		&task->signal->pids[type];
+	if (type == PIDTYPE_PID)
+		return &task->thread_pid;
+	return task->signal ? &task->signal->pids[type] : NULL;
 }
 
 /*
-- 
2.34.1


