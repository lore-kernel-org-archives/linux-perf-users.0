Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183F308F28
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765900221; cv=none; b=c1hnsHRRa3WvJbSOHRCc3zsTl6mKXsYmjU36Db1/7N/IpzES5NFW8E+FN8NX/Au2ed48XM42u0T377WUfrfKkdiQ65TE53pdvKpWHy4KioRNkFEevkr+FksOEQaHMSkaKDuTmtWZid3dugQ726nhKQwMvQA0qVUeC+rgQmlkBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765900221; c=relaxed/simple;
	bh=/J6SJIgVFXi6M7XjQHV29kxITg2wGyGnqWzglUUHx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTaabpar2mCJ99dW1pg9G8yyFDdK5MwCcZm2kTiiDZvlbzcaZjD+bWVPavyhdRhCMu3YqHSTpCZ4NP3LD7gu5XVg/cR0i+Y4+JDEBFI3PluhJKzEcnhxDfGxrJys54qvnsOLyEh8JYF582alxqo4FDoLZKk0SkTmuvuNu8CSqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGV/CYXM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGV/CYXM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo5501924b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765900219; x=1766505019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AezLWqLpD6CrSSZ20H0ppmyNNXbXENPGR4Qr/3w4H5M=;
        b=bGV/CYXMtgbehq5c4PcpZ1TUatnxDo+paxHNbJnmZrGo+JtqVS/FS+Ai+d35k4wRn3
         615M26PUGby9OUXQFfmT7Sen4qS/ju6ezEJPGI1jeUY4fQNZjzSYme279xLmi8UaXonu
         rDRcH58sNFQBX5xVNy/0o5KpuhNDXBAZGf0xOicZahW7HCwsK4HEbYeir1pwilRxa9Au
         jBSWTc3i7j1Vp/TEhQDsiomkYLxMduJseNsfcf+V9cnCMboBWfOlE0+YF+dDnElxA1rV
         qjHZO1i21uWaHhONLCO0UirdVOKaMEL12QAA+7yAqALQBSGqv2mElBYPYS2ahFMz0HJe
         q62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765900219; x=1766505019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AezLWqLpD6CrSSZ20H0ppmyNNXbXENPGR4Qr/3w4H5M=;
        b=cqT3fd/KdabVsz0l/1AzjVV6AlZomKEN4XZ1klpolorUQcy6ltmpchQPJmS3jfG1La
         5a2+TD2dNYU65k43SHbvHHE7O8zAPeib0J+dMgGoBQNxx/ZBFuB+KRV8GrkZlKJCQw0m
         RV4dQaVN6WV0KLOLJ4JufDjC00SOCJm9A5I/AHknv4x/lrKFqlmDjkrwo/ZyaME3J+yA
         XTBukblXPQVYZoM7pf2biB1LrLxmpuW72Shh0HsbKaWmL/Zns3fuSndm6FmNjqFCC4Wt
         lA0texO01BT2xlMxmi6qUrjIrdg+20Uh1o4bdM6R7MJfl37t9Gimq9mqFrr0kpOABlyg
         nd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6LZQOTjBaKrcvipKrVnmJOKNwSkpe/BISuXHv/1FwTGETdn388EwNJp+1kBJ+4IHSy6iwiAyLNXFfHU08pDua@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXAHqMAUrNRSIWI7slH7VmrfvPjEW2lxE/sZ3ePcmE05OP3KY
	nDAIUmWDtLR1ELkWJOHnSsWjE1TzHqksFyEZ2464QIywOIDUy8MdA5U6
X-Gm-Gg: AY/fxX5xuCuxBv0OlXsJXOo1rrFv3L4a3FmVVO46eUK1rwN9UMpQzx6JEgydXYYUkZW
	zCdFd+TK3y0W84sLZyzSJT8P9Jbl6XmjJ8Z8kAK+ioCWf6vD7r3JQjWvURVf5XCz2v8ko0t1r7V
	/T79Uw4ShGns/L9L68d3mjiLSE9e0so1WIntuhAMiRZfC9M7J6AVldi/5eeiODz/H36QrF6riEe
	4lsU12HzBVyUyBAmiO11v6V2HNx8ZTM+HPq8etweEBEj8WJWXcVzni2fpI0UVc1UVsZVmL5mDf3
	r5jVY6OLPPpRT934jG/QvwaAFdCzzPyvVmCOSwDKyz2ZcV89blw0iRyTO0PKrgiG+bpUnfLFTUo
	PFCcpuMziteL5p07zWLpioymtu8fVNKlC2k3vSgFJe7N9vLbz4WRC3wW3aYCPM/Zq0C2lRkcbFk
	QMWNkYYjuynoRl2L9i/j0iRbQQxzsgR1g=
X-Google-Smtp-Source: AGHT+IEoNHdZ1DEBYEdZ8Fi4jzaSzQZOk4zYX1IY5OzpnLVZluq/HgR2KLlvGI9RonLCmUXvHnMZDA==
X-Received: by 2002:a05:6a20:258b:b0:366:c321:9fc6 with SMTP id adf61e73a8af0-369afa082a3mr14434795637.48.1765900218667;
        Tue, 16 Dec 2025 07:50:18 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c5093a4bsm15829494b3a.50.2025.12.16.07.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:50:17 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	llvm@lists.linux.dev,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	x86@kernel.org
Subject: Re: [PATCH v5 1/3] x86/mm/tlb: Make enter_lazy_tlb() always inline on x86
Date: Tue, 16 Dec 2025 23:49:51 +0800
Message-ID: <20251216154951.631-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87345beoq2.ffs@tglx>
References: <87345beoq2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Dec 2025 16:42:13 +0100, Thomas Gleixner wrote:
> These Reported-by and Closes tags are just wrong. This is a new patch
> and the robot reported failures against earlier versions. The robot
> report is very clear about that:
>
>   "If you fix the issue in a separate patch/commit (i.e. not just a new version of
>    the same patch/commit), kindly add following tags
>      Reported-by:...
>      Closes:..."
>
> No?
>
> [...]
>
> Please move the '#define enter_....' under the inline function. That's
> way simpler to read.

Thanks for replying, I will improve it in the V6 patch.

>> +/*
>> + * Please ignore the name of this function.  It should be called
>> + * switch_to_kernel_thread().
>
> And why is it not renamed then?
>
>> + *
>> + * enter_lazy_tlb() is a hint from the scheduler that we are entering a
>
> We enter a kernel thread? AFAIK the metaverse has been canceled.
>
>> + * kernel thread or other context without an mm.  Acceptable implementations
>> + * include doing nothing whatsoever, switching to init_mm, or various clever
>> + * lazy tricks to try to minimize TLB flushes.
>> + *
>> + * The scheduler reserves the right to call enter_lazy_tlb() several times
>> + * in a row.  It will notify us that we're going back to a real mm by
>
> It will notify us by sending email or what?

I didn't write any comments, I just moved its location.

As for the content of the comment, I think it has nothing to do with this
patch. If the content of the comment needs to be modified, it should be
modified in another patch?

Thanks!
