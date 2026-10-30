Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358758;
	b=uYKL2q+yFBP1zjM8jWeVwbG99bBnIzD4sqW4TPWuN0HLPkL/VVPpyeqlobfULh2yVDvG
	 0Tw49vktmTN6x2/4plkB0uE56TsD7VCmVVfxc0kMuGgvnEWEBqh9Dh24QxQMYMI52tCkS
	 etM1hurKITOIHfXuGu1gU50aP5ShFbsxqSIydyHu/2T9khy91IMLfPFKlw1u3D/tQ0Kl/
	 k2fXEBFICBNmTnIY7MGeP/rVFCcSP1OBwOmmC3GqsHa7LByiZxPtEyANTWgPpx1mdR0PZ
	 Dnee9BgA7zx9ngg1a5bM4TyWwmFttQV+XHux8hpAyrcN8aAbicDx5ugKKEhKZZOAmbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358758;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2Nk3f1ZWjruFGIwd5hal19bn66v2e7zdR6KPnrJX3pE=;
	b=c3dOsLCD1bIuip2t0kz6nfnHGKT/+b8IIXUtknPaN4KI2HBgKL+TX5BXcuEmpxdF70Sq
	 bFq6UQUbtKf0giu7ABCzCVLkLhLMNp0gmAah7l/55t7jkmA2vx/SlKNy/tKv4JZ43AN7Q
	 uKkcFheouOiv2qv/TndbuGaS+jTlM1st5z1z5oSrdvO3eukVG5AC1xOo7qeGZ7VMsKPqf
	 L2AC8uc4tZPVCcQwozqBxB5YcjoIy5FDcVH0HH9kDW69gO2bZcQZxOHyX4UNpSQVEUSZ4
	 9WR4xMWnWcHYVqy/SpvFcFzbQAP5MX6IjIqZwQxrO8ZG9p3dQvnRkRZzJLDgMYq/q6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Ob/kANni";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3E606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 11:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB3E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ob/kANni
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9894E1595;
	Fri, 30 Oct 2026 04:12:33 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 624053F7B4;
	Fri, 30 Oct 2026 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793358756; bh=RV9VREhWtFmkMT3qPZSsIrKTFx5/ojmZmrkFWSiIKOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ob/kANni4b1AT5plW89Ctg/tC5nw4uIUWuRdNxfAIRU/J6FSrzJ73rC5/n5Zu1lnY
	 +7KtyKjRd95IRV3Pj3RN7g4SqClHiG8SWhT5ec9zh8vR8iLJXN4nk1B8SDgWrK2f5H
	 5VxRvc+zdJA5SYCw8nEzDtSCjBDuSHbSuFCznHMw=
Date: Fri, 30 Oct 2026 11:12:34 +0000
From: Leo Yan <leo.yan@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 10/14] perf cs-etm: Synthesize exception entries
 separately from branches
Message-ID: <20261030111234.GE9176@e132581.arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-10-6ab8c07a5455@arm.com>
 <20260923163605.3962C1F000FF@smtp.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923163605.3962C1F000FF@smtp.kernel.org>

On Wed, Sep 23, 2026 at 04:36:04PM +0000, sashiko-bot@kernel.org wrote:

[...]

> > +	/*
> > +	 * For A32 and A64, exception calls execute a four-byte SVC, HVC or
> > +	 * SMC and save the following PC. Other exceptions use the interrupted
> > +	 * or faulting PC, including traps on those instructions.
> > +	 *
> > +	 * With a shared branch target, no instruction has completed
> > +	 * at the target, so last_instr_size remains zero.
> > +	 */
> > +	if (elem->exception_number == CS_ETMV4_EXC_CALL)
> 
> [Severity: Medium]
> Does cs_etm_decoder__buffer_exception() miscalculate the instruction size for
> ETMv3 SVC and HYP call exceptions here?

It's possible. In practice, we don't have any known perf users relying
on ETMv3 support. I'd prefer to leave the code as is rather than
introduce additional complexity.
