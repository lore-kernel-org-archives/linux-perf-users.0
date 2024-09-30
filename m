Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF118755C;
	Mon, 30 Sep 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687084; cv=none; b=VvR5rbU6JlOaBIcaHylXR8H6jkHdbc9oPwgG3XtJkq59WUIOUCorjpz3n6cQYqSupkyAgb1venOi4Kftaozx1KyRHgPtheTCUIWWaCuZ7gD76R2xm8rrusHIulVQ62SVDASUpDqk0lckK6fVRdI1dOJiZ5/Zwbm5WSQa7hQWjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687084; c=relaxed/simple;
	bh=XrYPmYYT5XhC0wJNwhAXZC0DqK+5e+QiHm3ftF5vz5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj3bVDr14GBOT8QgE8Gk7Rwr0mGsw+NYCugRGQpW58s4JWzxBwG3hQe7WoeHJpal1nJSrJdy/4MfXxrQgH/NfHA6PZusZpcdrcGgpjtb8gDQc1DowpkeqQ9J5mRybM00k08g7EFZuSr/lG968xmnkzQECkAT33QSCbOEqLSFd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1D4ipIB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyiywLFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1D4ipIB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyiywLFg"
Date: Mon, 30 Sep 2024 11:04:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727687080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATbSZtloF6YXdAPUbDS3opKGPNzhV52ixLqKEGFxHo4=;
	b=o1D4ipIBwhYJ+g4OEeMm6+1jHREwaJP8pMldEPXbKrjRsiVTDjQPDaCNMlrGT6GZfaPNXb
	EZRCo0BkajBc2WI4r8gxLeU9goTop4aejdFK23drMXG8vyYPy7nnh7CLhjnCcvwZDzoYoi
	qwofgJBOTz4j+4xykkaC8V241GhYCmn9ldLPVC0QegnzJlcXti3ei5M7z094h/C06gMcGk
	5UZ4QAZwhgbVfmp0hYEK8eEnq7LCUEJChgn2nt5XNTOyGYKKY72jbvMGsM8N5e8fAZbzmk
	gYGoiAK0cqz60aqrnWnG2gy7atIiTLnWvR+QhgLLb4MX9vJMas/y2fWE0MLd2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727687080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATbSZtloF6YXdAPUbDS3opKGPNzhV52ixLqKEGFxHo4=;
	b=WyiywLFgaqeTDA/z9qhm+isxE6Irgu8pDDYLgft+JCH/jb67Z/mxO9VNuwFtoVk25JvTyK
	/HlhidouTPyq5kAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] perf: Fix event leak upon exec and file release
Message-ID: <20240930090439.3IgzQVzB@linutronix.de>
References: <5cc313bc-c44d-4f6c-80ee-5a9fe9356f43@stanley.mountain>
 <ZtYyXG4fYbUdoBpk@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtYyXG4fYbUdoBpk@pavilion.home>

On 2024-09-02 23:47:08 [+0200], Frederic Weisbecker wrote:
> Ah right.
> 
> So one possible fix is to possibly let the task work do the last reference
> decrement. This would mean that freeing children events can't be always assumed
> by the parent.
> 
> The below (only built tested) would do it?

This looks nice based on diffstat. I didn't look closed nor did any
testing so far. Do we like it and wait for Dan here or?

Sebastian
