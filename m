Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583E15DBD3
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967908; cv=none; b=XYk6wajF+mQwADpfh0m7Q3wpLYbyyuT/IuE5UPAz1gjCyZoodCEaixJ/iaiEvEUXDoGhqr1SEtcRLFAsMYYDbp1fz6HhF8d+oU3F+q3/fW9XxAhiU/R2aY1gL9oACOZt1eJPpNzo7CGZW37VRj/Lq1L4Ns0ct35iY+jgiCX0NFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967908; c=relaxed/simple;
	bh=UZAx2nJq6vqzAZwmr3EzvygwU/wfz0KU8NeBr38qNQ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPV+KQQB1UiX215URP79XPaV0iaBjqUeKVoyT+JX/jRkkW3+s3sejE2yGqBrzlZgKFtl4idumfdlvcDlNJrhoQFjO4rKw5z4P025IaOJNK/74WvB5HICcfrRP/+QN998Hev845Yu1ML2B0DFj4OyZi2BhCEb6EDDfhw762vmXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBmExSPt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBmExSPt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso4794841b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2024 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713967907; x=1714572707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfiemKXJi5pMLJ2Wia9A+4BjCX44VO8MUqVuxnh0Agc=;
        b=bBmExSPtlhrVQPmDHXnTW1HttRMnVrH1SAmRQvnmxww5hC+h7bzIlIV+oqikmuQjuu
         IkEIETv2FgotHxNbUfzkWUa8tSLzFsVt1qwkHdD/wTw//91WdIZ2xwY1mWYy4SEOhvh6
         cqz6TggEldyKuMc4m8o5FMOXmidXHJkyhbavdShDtp5udjF4X4NVExx86j1xho0K4hJ7
         s81jS3XQVEb8VTM/5KmzBeiZlIdeYGMo939IBiGHSGHY1Hxl+Pml07Ph+nU1tnTNMTrl
         KRSfUJEjs4o2pupGageuhJi5CvrduypIhesEujz+Khea+auXJlgPMOAD+eLlDmLOxHmq
         W2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967907; x=1714572707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfiemKXJi5pMLJ2Wia9A+4BjCX44VO8MUqVuxnh0Agc=;
        b=Pmd1vj0DSqiyPusaBf7OgMTqYnTLnLFQ6j45og686Q3fU/kEmL6oU7U8WptZKRLZPF
         e/jmA4WWP/9uxeX519PxHsvTm9fFy5d47Rf01Apr38sgs0iSwJPuZQHaR0/W4PUNYbVM
         T8itplJER96T9eUEZxFU94nlypNiJJrw9BHsJmtYbI6qhTexrfqm2aaKSRLLydGQFlp/
         wWD1/sGo2kaMSzSYKZyccc27Hl5eLYCHMuURIDvOLRRuU+lzui34ZeC+w6eGFn4zyZh2
         +dPgZKRTmeVJ4VQPs8qgqNT6l9Swh5tvJUMrZmrY502WnrWqvC+MVp9epNWi7/BF8nVR
         1IMw==
X-Forwarded-Encrypted: i=1; AJvYcCUyIg8lDF+zR8BQCxlQwBMj0FobzUIS9wB7brC9XPz6NK4ztpvUDU9cBj+6w08ae0Zrw3To/+0jZZW2NUADz3Oted6PC4JXtpr13u1NmUpkyw==
X-Gm-Message-State: AOJu0Yz8WL8Rd+IMJin/otGdrUYiKZVb+EGId105d79psfcyuvjtiCo0
	NA31LoQynduL2ymMBvnGdEQ77qf1RCit9HfH9OQrHd99yhbf9cJ0
X-Google-Smtp-Source: AGHT+IHJqBTsTkgXThBpzfpF1ZxOx7yc0dvsL7kplUOYeaVjzM0pjuiOIITL51O96TsfF/Dn1ssn1g==
X-Received: by 2002:a05:6a21:4988:b0:1a7:a3ba:4252 with SMTP id ax8-20020a056a21498800b001a7a3ba4252mr2452448pzc.31.1713967906724;
        Wed, 24 Apr 2024 07:11:46 -0700 (PDT)
Received: from localhost ([36.155.101.137])
        by smtp.gmail.com with ESMTPSA id fr9-20020a056a00810900b006ea8cc9250bsm11473122pfb.44.2024.04.24.07.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:11:46 -0700 (PDT)
From: chenqiwu <qiwuchen55@gmail.com>
X-Google-Original-From: chenqiwu <qiwu.chen@transsion.com>
Date: Wed, 24 Apr 2024 22:11:35 +0800
To: Will Deacon <will@kernel.org>
Cc: chenqiwu <qiwuchen55@gmail.com>, catalin.marinas@arm.com,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, kaleshsingh@google.com, ardb@kernel.org,
	alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [RESEND v3] arm64: Add USER_STACKTRACE support
Message-ID: <20240424141135.GA3664@rlk>
References: <20231219022229.10230-1-qiwu.chen@transsion.com>
 <20240419130921.GA3148@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419130921.GA3148@willie-the-truck>

On Fri, Apr 19, 2024 at 02:09:21PM +0100, Will Deacon wrote:
> On Tue, Dec 19, 2023 at 10:22:29AM +0800, chenqiwu wrote:
> > Currently, userstacktrace is unsupported for ftrace and uprobe
> > tracers on arm64. This patch uses the perf_callchain_user() code
> > as blueprint to implement the arch_stack_walk_user() which add
> > userstacktrace support on arm64.
> > Meanwhile, we can use arch_stack_walk_user() to simplify the
> > implementation of perf_callchain_user().
> > This patch is tested pass with ftrace, uprobe and perf tracers
> > profiling userstacktrace cases.
> > 
> > changes in v3:
> >   - update perf_callchain_user() to use arch_stack_walk_user()
> >     and delete the redundant code as Mark's suggestion in v2.
> >   - update the commit message.
> > 
> > Tested-by: chenqiwu <qiwu.chen@transsion.com>
> > Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
> > ---
> >  arch/arm64/Kconfig                 |   1 +
> >  arch/arm64/kernel/perf_callchain.c | 118 +---------------------------
> >  arch/arm64/kernel/stacktrace.c     | 120 +++++++++++++++++++++++++++++
> >  3 files changed, 125 insertions(+), 114 deletions(-)
> 
> This mostly looks good to me, with one potential issue:
> 
> > @@ -107,35 +25,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
> >  		return;
> >  	}
> >  
> > -	perf_callchain_store(entry, regs->pc);
> > -
> > -	if (!compat_user_mode(regs)) {
> > -		/* AARCH64 mode */
> > -		struct frame_tail __user *tail;
> > -
> > -		tail = (struct frame_tail __user *)regs->regs[29];
> > -
> > -		while (entry->nr < entry->max_stack &&
> 
> The old code is checking entry->nr against entry->max_stack here...
> 
> > +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> > +					const struct pt_regs *regs)
> > +{
> > +	if (!consume_entry(cookie, regs->pc))
> > +		return;
> > +
> > +	if (!compat_user_mode(regs)) {
> > +		/* AARCH64 mode */
> > +		struct frame_tail __user *tail;
> > +
> > +		tail = (struct frame_tail __user *)regs->regs[29];
> > +		while (tail && !((unsigned long)tail & 0x7))
> > +			tail = unwind_user_frame(tail, cookie, consume_entry);
> 
> ... but it looks like you've dropped that with the rework. Why is that ok?
> 
It's no necessary to check entry->nr in arch_stack_walk_user(), because the caller function
stack_trace_save_user() registers the consume_entry callback for saving user stack traces into
a storage array, checking entry->nr against entry->max_stack is put into stack_trace_consume_entry().
Qiwu
