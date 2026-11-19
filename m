Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088935;
	b=LwFzP+cErtxKbYcJBu+p0N3MZd51twCO0vFi6zGhZcGfMhjTTm2W/A9jGXJOi6SKy9z1
	 9hc3gWmVjB38pHjsTcFGH/Cklj4UFwz8rRoz4+1Rq1MOcs+Btfg2/ODi6dztu/jio7pwL
	 +I5MpNe+92/QzXROCbCo8bohzuM9XiyURrc5vf78rtudDcZoQb6rbU9R9ymLRpeKtzYVp
	 gkjvxzGDehzWKFpN/aRu2oXRwWkhvgLRIFOetGlMSVC2oq0purtTsWQoH599dS+fAq4VA
	 zpf5hCYkefG1Ps5rCSEM9pIk/RIsRdN6MChCxkvpzUMpeFTOEJVVX4soHBkpECpBeFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088935;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GX5EKeuAhzbPF5m8dbBP6m1Hd+vMy/q+DnezhQCi8Is=;
	b=lvgC5bv0/52UZysXwhk/q86U1gMLGplYI47Ok5r0LjH+/ths5Q6RYM5pI8zyuo7we5Yy
	 kXoyCszpb3klGsYqgEWhEo0+tFW/6EjbgUl0mq6X2sAOzAZDxPUwVFAMfj7i34DDnLOV4
	 qvlyuhA0uvd4oLpUgzXFWjrJ0nFyqNrKtpAbR/T/wMuD6cG+dXtvTdCnXZrkCpLGpG7GI
	 mAIego2JlgtKY72yQuc6jocOU4TjajkAfEG4vZ6+dCcctZSjJNeuduZgWvUqCz+ZPtjsL
	 HlPYc6rZCH573mD4NGL5p6NDCM4gSCJC4Uisxmtm1PWY1AIVzvvjZ6onx11oZyH0E8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IEzlrrtA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="G/dN14RZ";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D4606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 11:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F8D4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IEzlrrtA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=G/dN14RZ
Date: Thu, 19 Nov 2026 12:48:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795088932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GX5EKeuAhzbPF5m8dbBP6m1Hd+vMy/q+DnezhQCi8Is=;
	b=IEzlrrtAMv/5GAsmB5edZ50qL2Y+Jv5RLvnSI02qlrUMEcdz6rYsB802UBAMq3fU479eAC
	r2pE35h7spnGK55oaEQKFcZDC8RlG9J0AJma031UXANGtBIbJQEdLM3WO29jkbFpFoWvZo
	xaoXDhaEDwgpTmqG9en/C0z+Iy0yYFF4I0BjLXAbH/qur43qD1DxI81Yf7SevgjzzmMKJS
	+dr5mLIu7vvchv3O2yOrSINxEjJ4GqKjxnq7pOr2sx0Zf6j0p2LSp0Xv9lpUJ9mCicyibI
	Fy5+7YXJ8pzbTWqAkC/J1HpavNeUxDIHfZaq7q5T60VxmR0G7dvBowyE7ROISg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795088932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GX5EKeuAhzbPF5m8dbBP6m1Hd+vMy/q+DnezhQCi8Is=;
	b=G/dN14RZQU1ovSnuTBPbozhnAKLPZ8tNq0dcNNAHktPzLkiYa0/Dsy4ev03A3v6MmrmYRJ
	Bc10XQDXEJM+tfBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261119114850.2dEaCmX1@linutronix.de>
References: <cover.1794914794.git.wutengda@huaweicloud.com>
 <cff9b939758dad9f16bb4eb0483c63b7787e62bb.1794914794.git.wutengda@huaweicloud.com>
 <sashiko-outbox-218736@kernel.org>
 <e940e69e-f7f6-4c37-a2f9-7caeaf9fb7c4@huaweicloud.com>
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
In-Reply-To: <e940e69e-f7f6-4c37-a2f9-7caeaf9fb7c4@huaweicloud.com>

On 2026-11-18 10:52:41 [+0800], Tengda Wu wrote:
> Hi Sebastian, what do you think?

The bot might has a point. I don't see how a pending event is removed. I
would prefer to keep this part.

> Thanks,
> Tengda

Sebastian
