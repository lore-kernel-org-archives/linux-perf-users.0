Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236128F0
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545431; cv=none; b=ODxhIR/XXFEvuhNj3Sra8DZNu/YaVRPcQf2sUeGKiJBqKIh5zncmFYl4sOMly4L1jUO6RVXDIsnddc0rcWEE9qQA3BGy+qgrqetqdAmk8vM4aPUqjwqHgOr5j5f3orNhI395kpKGsek7LDxO3UUbxegjp3e3CAsFHVj8seA6RyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545431; c=relaxed/simple;
	bh=uCTwr+l8pAuwdbnVlesuJHBvAEYzp6sA/w6BOaOeW30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AeuDNb2bG8tY4hcsyaeMbXnfM1ptDQN7Qvu9gMULb7KcaJmK10oNU6+mb/ZuYyVBo5Gvip0b9OjyOd1aVYO73iKkjSk1YVZ34/l7mgo3krXwy7BUymPa+uZZOYqNyrSWLZcpquKqzOLtDu+cdVyHIUkVIRAENovSRrZi8y0d0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nvtpii6m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZmpQFYWj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nvtpii6m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZmpQFYWj"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713545428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCTwr+l8pAuwdbnVlesuJHBvAEYzp6sA/w6BOaOeW30=;
	b=nvtpii6meDGYXmLV54st7z/20wNatwWxMXJiu+qBAzelcJazBzifRylUWtKCnAYOS3h1Z2
	EZZBwlnn0PmmxQ+bOoHi3VcpsUD1d++m1AKn0z7UGJTxA9SvQxYWO6lVenZNSSL6/yxGJG
	shE6LnsQZONLKMLSxpJHcl50jL7KL7dfONV+rK0HWd+IcFpJ9glCPyv7iF3W2ibB7NEiyq
	I6+C5NavZTB7Z/s5//98H60xKuO92CZEi8Y5IRFoY8dIwkRC+biXQnaddT/mRg1Vfib6m6
	yWfjBadv1vAYCNbXp/6qGC/l/atglFf7sedpSSgcDn6nQPEv5McvmDH4rGEmsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713545428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCTwr+l8pAuwdbnVlesuJHBvAEYzp6sA/w6BOaOeW30=;
	b=ZmpQFYWjsOkMzHAagzvrtMdlLUd8MYa+hvTNmV9H/PVnrtf/v5iIuWh6nU93u8rCd/9jT2
	GZp2y76bh7QF2UAw==
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 05/13] x86/irq: Reserve a per CPU IDT vector for
 posted MSIs
In-Reply-To: <875xwdbfby.fsf@linux.intel.com>
References: <87jzkuxaqv.ffs@tglx> <875xwdbfby.fsf@linux.intel.com>
Date: Fri, 19 Apr 2024 18:50:23 +0200
Message-ID: <87plulwb3k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 19 2024 at 07:24, Andi Kleen wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>
> Dropping CC of a bazillion people and adding Arnaldo who owns perf trace
> which has the vector decoding code.

He was already on Cc.
