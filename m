Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CF36E342;
	Thu, 30 Oct 2025 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850650; cv=none; b=fMB3MsIPhH3Mwr0jrvrmMwgSlSJT5GXEKi86NsSeBuPOViPEjkE+XlMoIpEejPcHs51K9TR/9kG8p7u+N9PJFxrrWkasuZ+F4d77tWVeEWO4W1cUYYsGI3BYE4qgniCEbC7VZOtKTxhK+8fOqZksjkfgYH7wFele+cdLKabpEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850650; c=relaxed/simple;
	bh=DPN3R+jNqmq2nzo8zU5Q6weJpi9cFGa1aTDCxjEzbXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3y8HFOdY70NsP/bLS8EfcreR0KyDXP6c/FFXBo3ORM+2DOZWx5UXoCof+CDgwDbhyFC8satW//nlBPy3yt/hOaA1sSSxXk2wU+SAoDbRIHVzYA0HPivxvd252bmZ/UeZTxA61l4mP08ybBiM7sT7H1+pr+kMpLelVLIrpvgpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kXeQN4T/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kXeQN4T/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DPN3R+jNqmq2nzo8zU5Q6weJpi9cFGa1aTDCxjEzbXU=; b=kXeQN4T/MrS523pclpe0pc40fz
	dlvTiBkT+cDZ4/4pZvYiPGw2buLmXbnU9aUnz4X00FnJ0PUazFkW72u52hkNrUUtJtw5T/yPdL53K
	9nnuZ5EBCWNw9k8ihjszAOrhCtDypG6M7oyTOmG/3HWQg8RCTXQ6QtfGzHuE3HGOr40qHqd5TSRKK
	pGpjyckPRrc/rqYV1s5lb3Ap2b0HiRFRbx8G+F0uFyGf5NtrUa1xWMuAKtNZ3KIDMbQ37yjKZEWy6
	c9rz3MSebsDi8UTeWc1HrravwEOd5fbCBIng9QXIwfcQQcUevuo+1Z+svU832I1QWAVezpj/Rp83q
	u7WQWKMA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEWyA-00000009n9Q-3mvE;
	Thu, 30 Oct 2025 18:01:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5D93830029E; Thu, 30 Oct 2025 19:57:25 +0100 (CET)
Date: Thu, 30 Oct 2025 19:57:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Mark Brown <broonie@kernel.org>, Fangrui Song <maskray@sourceware.org>,
	linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <20251030185725.GC2989771@noisy.programming.kicks-ass.net>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <87zf982s52.fsf@linux.intel.com>
 <bdda89a7-ff60-46b0-8ce3-28ffec1fac2a@sirena.org.uk>
 <aQOvCugzYe/2DcNW@firstfloor.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQOvCugzYe/2DcNW@firstfloor.org>

On Thu, Oct 30, 2025 at 11:31:38AM -0700, Andi Kleen wrote:

> Not on x86 at least. All my x86 systems have it, except for a few old
> skylakes.

About half of my systems have CET, but I just checked, none of them
seem to actually use userspace shadow stacks.

AFAICT Debian hasn't build their packages with this stuff on.

But yeah, thanks for reminding me, we should definitely build a shstk
unwinder.
