Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175208;
	b=JFyYbyFQ6j91+9/UbBSXXkAextTEXJpDWf814VlyxnHHf9khCnJ2EnJ6hdCIjRXBaY5J
	 1Lw2jqw/B3qah8t3tPFJ8WUi95ZtUaIzLX5Ijnh+mYk7ccsYtJI7EKZS3DbuamGV/iY3x
	 cx+d/zcmtuoVZUP4eMJ4EMeedwVHutPVce6uixpqHAcs2Bm44zCBpPcH0FBk5lK4B9Wcm
	 M0fMf0KiGBiYlipooHVaCchyseOd+hsgbekKEh/R5eGcyjQX0AGFnS350F2E7tROuoHSS
	 IEu1Bs2y/0N9rxZdF7lFRnQQzuGvHNnRPPY2ZV1Gwn/vCADCtSkXNF/Ouli/cIipL0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175208;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=RGVl29uymQl+NYGzhhAdRoCGDhPq1p2bxTDg+kAVmWM=;
	b=emTQm2yh3UzFqBlEVdR+GKFsXzGJgowkyxWy/qXL9z5l40swj7ceyahDCQiPZ34SUenP
	 dtUVY8eMM0p53Gp/GC0B33xpnmztinQRbuZEUHDfW8apW/TwBpCsgCb3/089cRr5+WzsZ
	 CUTODLzJPXWbjlzChKrK/QcMnyudzINgb1hFYHFWlON7xujkJk8TlyJHTskDH+QQ7PhHR
	 +rDBNeVIYJQpJHZxK1gxidjiozdMyFohjUxLjyDrbOiAwnSXiWOEXHayAxhnjbVxp/Tt9
	 OVxD4RbfIXiK0k+JsvyzSQ0OAvk2s3D5k57A9UFxuH5q2H389YHatWs/vA9velgc5qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="rHhy/kRK";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cAQGnN0T;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A44606A32A;
	Fri, 20 Nov 2026 11:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A44606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rHhy/kRK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cAQGnN0T
Date: Fri, 20 Nov 2026 12:46:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795175205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGVl29uymQl+NYGzhhAdRoCGDhPq1p2bxTDg+kAVmWM=;
	b=rHhy/kRKnxoBZ3C1Vy5q3goQ0Sa9M+bemSoPX9upOJRj6LOKbB5S5lqUKtRlJuckMTEl+B
	rXQRrvPp00nOlR6J9GoMM3MvV4VW8KeHR0SJMOpDOIwSdcKSug7p4acBgevoe3/D64rlFE
	apjWVP22W6DHaL1QyJu1leNaCknMy0tmqTOk9kvmWblgYuapxOSTYUsjK3XmnokDG3X5uk
	pjuEVB/l57RTLbOD696RcHYP7ttuoVeaEPF+e3QwGYYqT+FCh1o7NQsAC1ycHkeVEOP60A
	0mDji8l9oiJ9am784yJ5nJPNYB9RaJ2I0NTU8F7VDtGiezMJOgJeeMNwHuBUuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795175205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGVl29uymQl+NYGzhhAdRoCGDhPq1p2bxTDg+kAVmWM=;
	b=cAQGnN0TqodF+ppjAKq8R2iG0HYEJu6K7ZLFa9loTjpPu89w7sQzBwgYjZCrtscRZJ5w1q
	PWb+YPfS5gtQmLBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Fu Chao-Ying <chao-ying.fu@globalfoundries.com>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 1/7] mips: {cm,cpc}: Make cm_core_lock, cpc_core_lock
 raw spinlocks
Message-ID: <20261120114644.VM_HFf9o@linutronix.de>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
 <20261119-i6500-cm3-pmu-v3-1-c86410934b51@mobileye.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119-i6500-cm3-pmu-v3-1-c86410934b51@mobileye.com>

On 2026-11-19 19:51:27 [+0200], Vladimir Kondratiev wrote:
> From: Paul Burton <paul.burton@mips.com>
> 
> cm_core_lock and cpc_core_lock are used to protect access to a CPU's
> core-other/redirect CM and CPC register blocks. Since each CPU sees
> its own copy of this block, we need to ensure that critical sections
> holding a cm_core_lock run on one CPU - ie. we need to disable
> preemption.
> 
> Use raw_spinlock_t to implement cm_core_lock and cpc_core_lock in
> order to provide the guarantees we need on PREEMPT_RT systems.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> [added CPC part]
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

The perf interrupts should be per-CPU and not threaded so this is the
right to do. However mips does not have ARCH_SUPPORTS_RT set. Is this a
longterm goal? Otherwise it doesn't matter since without it set even
lockdep dose not complain where it would otherwise.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
