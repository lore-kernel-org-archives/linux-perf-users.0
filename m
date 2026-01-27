Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC631342512
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510181; cv=none; b=ub5Z+dBAHcEDtOzwBqE1h/Nrf32RaVpDR7D6h8XhS6fp0ppBaZgPnVgKhR3P5BkUpHQ7wkn/9OlYzdYoew5w3kI1HV8MhoG9TtKuaWEhN7/vIzRijLd25nzt/v5NBiqOiwU9pIQhEtLqxlFk+AnNDSg70C0wzTpI7xPnkryOR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510181; c=relaxed/simple;
	bh=mRx0iQv3PiuSaQo8w7pxGjSVgDGKqcDTuVp7jGR291s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snPraWlVAlqtXNP0CiX4ULlsnTIeAuvHXSgGmUcqFf0XScJCatZR1CC7MShRpxsQ3UA1FWsnN2YoTLFBQfrle1yeTa+j4QG7EkxSoXiskhiFgy1NQeGei7IfUlCkUMQ+4Lr6O2LyHzFnLdAaaV5Chfyue/ygY9h1GpugJbT9ce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hfy+9a/8; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfy+9a/8"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f30233d8aso37247995ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769510179; x=1770114979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHE5hW/yBCOwQBGEU1rDXh4Q8ebk3Q+UWNv/AlJZ5Y4=;
        b=Hfy+9a/8eplwazNU6KKcmNvmO1HAxR3AGPeGEugfriNJKPNMjsL4FUR2mjmtbi3vmK
         yC4lVS2bwOndl7uLJX2KXzs01W21F32PV40tYDx7FS7XYayyhkciAWfRTi/UNdx6km7D
         nKvXxC8Bkz1emhsY86Mh8npnVUGnn+Q8+gQ7OT2aTrOy7stsy/+6Yasm3nRVlR30/NQP
         FXHdBn+ZYgmfuciWk1UlIEJJCci6AVzWXZBybgr9hGt7xiFDT9lUTBYuXmQRBuhBEJ0r
         4DEx0IJdwWCaK5kozGFyiNbb83a3ThU4Og7ginK6c+MTJYHPG4/btr0Xn/6R+39Nij3C
         1QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510179; x=1770114979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHE5hW/yBCOwQBGEU1rDXh4Q8ebk3Q+UWNv/AlJZ5Y4=;
        b=lD7MK3i8yHqzeIa/YzfL2SoP9+u7xNAHW9f4ZAfx4QHo6UB7HNtyEQLaK9PNFJhOez
         4zJVlV9awnoYGZ11irnC+rMOh/0xRhNvP5k5UvuJbqWUtKK4qcAAkKHGQjQNB8H8Ol1s
         jtDlmhyl0Hu3LNTeF4HQgIcjUD/7neq+7OqzTpGTTuJqm+D7sk3d5vzHYhsE3i/LGipW
         tTS7mCSO04mVj9nbt8sazGnzibGE22KhVKAHvXNzw5R9xyL7ad6+0gQfZPCjzBuwJ0f0
         u9ETa4rFrtSNXiFvnMmb0sWWTe1ZU+e5FOXt4Bs54NHFCiZXnHSRvBTc9t6st5Fd6EV+
         aW3w==
X-Forwarded-Encrypted: i=1; AJvYcCV6S/Lj1ABGxwbE8p3EuilcuERSB+cI6TUJ1vjm15dll9deu1xomlKfvOvWGc7drcyLBGlejL2pO8tvYCuTrqRf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz375Ec9j34Lzz0+WYHSKXAUWmnhqGfbrrM3SmgKoeRgMR1GWtv
	0CdhgiIzKkrvHlKZ3bfI5mo8/nGnqX+IszvQPmpE3g5002isw5fRbEPU
X-Gm-Gg: AZuq6aKOlLEBZ6lcmWNpv5Nv2EzxiaGhpzPBYwj4XB/BD/90hPuoJlJtQkBv8JBGOkJ
	P5YAsTzMSYXhHmuuW/6nywPWD2Cg20vzwwTxGq3p9x9p1m1iqGs+sh/YP0LjBEd0zx1I69U4OdE
	Nk0LkzCmmyqpzowdaBLE8bEDfPMuM/lYcSUZ0HNzETlR0oW09GKh4sMKasSN7dWMEmRwy5Nfagc
	oT9mzEwIFjurdYmOJ4hlXHAt+/NIDjFtftYU8EpJYagUfocGJO99surJcpTEPHiUE1FI0rNnHZy
	UB0DbiwZqZI9EFYUDahL5tHJnM/ipryNkesukOhIyxY5kauWdkhEn/Gvg7PJRF6Nl/zUd6FT9yD
	1MblW5LCTZbn54dWzccSRZEvh8BVRQFCWv8f1Zejn+7xzuhrf9dDD5B6eA1hyhyAsWz8vTXlH3d
	lsz9eaj3WIWFI2CnZDRK156UKjzLP9z2SEuq/Drg==
X-Received: by 2002:a17:902:f70e:b0:2a1:1f28:d7ee with SMTP id d9443c01a7336-2a870eab09emr12821025ad.57.1769510179129;
        Tue, 27 Jan 2026 02:36:19 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a142e71sm10791792a12.11.2026.01.27.02.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:36:18 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: henryzhangjcle@gmail.com
Cc: acme@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	zeri@umich.edu
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
Date: Tue, 27 Jan 2026 18:36:13 +0800
Message-Id: <20260127103613.1407024-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127023618.1469937-1-zeri@umich.edu>
References: <20260127023618.1469937-1-zeri@umich.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Jan 2026 at 16:37, Qing Wang <wangqing7171@gmail.com> wrote:
> On Tue, 27 Jan 2026 at 10:36, Henry Zhang <henryzhangjcle@gmail.com> wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index a0fa488bce84..1f3ed9e87507 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
> >  		return -EPROTO;
> >  	}
> >  
> > -	event->prog = prog;
> > +	WRITE_ONCE(event->prog, prog);
> >  	event->bpf_cookie = bpf_cookie;
> >  	return 0;
> >  }
> > @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_event *event,
> >  	if (event->attr.aux_pause)
> >  		perf_event_aux_pause(event->aux_event, true);
> >  
> > -	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > +	struct bpf_prog *prog = READ_ONCE(event->prog);
> > +
> > +	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> >  	    !bpf_overflow_handler(event, data, regs))
> >  		goto out;
> 
> Looking at this code, I guess there may be an serious issue: a potential
> use-after-free (UAF) risk when accessing event->prog in __perf_event_overflow.
> 
> CPU 0 (interrupt context)               CPU 1 (process context)
> read event->prog
>                                         perf_event_free_bpf_handler()
>                                             put(prog)
>                                                 free(prog)
> access memory pointed to by prog
> 
> This scenario need to be more analysis.
> 
> --
> Qing

This is my idea for solving the problem of data competition and potential UAF.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a0fa488bce84..3abf3689157d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10291,7 +10291,12 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+/*
+ * Execute the attached BPF program. Caller must ensure prog is non-NULL
+ * and of type BPF_PROG_TYPE_PERF_EVENT under RCU protection.
+ */
 static int bpf_overflow_handler(struct perf_event *event,
+				struct bpf_prog *prog,
 				struct perf_sample_data *data,
 				struct pt_regs *regs)
 {
@@ -10299,22 +10304,17 @@ static int bpf_overflow_handler(struct perf_event *event,
 		.data = data,
 		.event = event,
 	};
-	struct bpf_prog *prog;
 	int ret = 0;
 
 	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
 		goto out;
-	rcu_read_lock();
-	prog = READ_ONCE(event->prog);
-	if (prog) {
-		perf_prepare_sample(data, event, regs);
-		ret = bpf_prog_run(prog, &ctx);
-	}
-	rcu_read_unlock();
+
+	perf_prepare_sample(data, event, regs);
+	ret = bpf_prog_run(prog, &ctx);
+
 out:
 	__this_cpu_dec(bpf_prog_active);
-
 	return ret;
 }
 
@@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
 		return -EPROTO;
 	}
 
-	event->prog = prog;
+	WRITE_ONCE(event->prog, prog);
 	event->bpf_cookie = bpf_cookie;
 	return 0;
 }
@@ -10361,13 +10361,14 @@ static inline void perf_event_free_bpf_handler(struct perf_event *event)
 	if (!prog)
 		return;
 
-	event->prog = NULL;
+	WRITE_ONCE(event->prog, NULL);
 	bpf_prog_put(prog);
 }
 #else
 static inline int bpf_overflow_handler(struct perf_event *event,
-				       struct perf_sample_data *data,
-				       struct pt_regs *regs)
+				struct bpf_prog *prog,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
 {
 	return 1;
 }
@@ -10407,9 +10408,19 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (event->attr.aux_pause)
 		perf_event_aux_pause(event->aux_event, true);
 
-	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
-	    !bpf_overflow_handler(event, data, regs))
+	/*
+	 * For BPF-based overflow handling. If a BPF_PROG_TYPE_PERF_EVENT
+	 * program is attached, execute it and skip default overflow handling.
+	 */
+	rcu_read_lock();
+	struct bpf_prog *prog = rcu_dereference(event->prog);
+
+	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
+	    !bpf_overflow_handler(event, prog, data, regs)) {
+		rcu_read_unlock();
 		goto out;
+	}
+	rcu_read_unlock();
 
 	/*
 	 * XXX event_limit might not quite work as expected on inherited

What do you think about this solution? Looking forward to your review.
--
Qing
