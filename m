Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090362;
	b=wS4++BpGtB6SJvcIZLG8GgDN+QBBsjrHTakLO74UnYR0EyMzeqoCEAaHGY/StN65qB7T
	 rYqPPKccqSo4AFeqf39hmjZnJPxzIAHj99PNhckEO+yeKH0FHKuasAmhBVIGOJgmfpcyw
	 QnwuXrMT7QMkod09JTepYct+rm6RIi6WXNx1WdV814M25awF3t2yVL+gxaBTijel/vMax
	 FaQWivTveCYiV9vXEv5sucnQNDyTHlOKSWLK+hV+zZ34HAZMdds38B0imUhyCpxXmUa9q
	 qR8c2xoACF08mVnwLg2YqEZre4apDbZpytgQmLpZyACe4EtJOaOdTXbJ5hLco81G6Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090362;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=NDEwA6/SFI+KiEa2tg/iFeO8y0XtrsHPxYeu+Qe4yok=;
	b=BeuqJLDKYOh63LhO3AwUSQBXRG3inHnCZeE8HmczxzaQ/7PY/OyyPetMh0deaLiU085I
	 l37BdT31v6JI3L3khjxwpDN86lTGMDQIxwTn6ErX+tqCOJnTXQhnBME/66uSDEJBPNLvZ
	 8gRJrPfKE8I5Uj00J+EmIpJd+we7v0oecslcKTFzUq9CvicbITPgEP+qV3vsmiIl1vsAD
	 EnPrKPZ8AdYNHVLXvQiT8RpttTEvK8IVc9T+l1KD5HdZ8Qps9v818enI+eSJrA7P2Ef5D
	 QIJC2pF5JjQWIFvOA0TtJTuvg0sq7LQoaO88aTggvpPwZYt3hrjGoBxPVpc88R+IODQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xjCASOlW;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=p58rKimi;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B8606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC6B8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xjCASOlW;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=p58rKimi
Date: Thu, 19 Nov 2026 13:12:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795090360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDEwA6/SFI+KiEa2tg/iFeO8y0XtrsHPxYeu+Qe4yok=;
	b=xjCASOlWOwMeg/LoywkRMWcVkrkn+t/2WcNc5tTgGNgj0vHpL8BTYgKaRWC/WN1/C9Y6iT
	suFN4yDU7iD6N2O4abEsAQ+fXs8hhvO4G6Lu/215zvorC3Xmk/XeqTOR/beb1KRFV9bQi3
	f+WhB9XgeYzLOLARgzObN2L6QtjqDC9jY8ZuI/thPEbugwMTaYSXQRfJKNdFiCA3meTp18
	YiI0MoG/1KN9/LxNepgwvU28qq7rfh1FEY8KmdcEI9dKN4C1WmRiI1VUxJPHvVUQTjOFXl
	+6HRls3ly8fpfqBBTSruf8LMa8gidYenh9jQQASjWJKqnVuG2Hxp35fRUwqqqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795090360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDEwA6/SFI+KiEa2tg/iFeO8y0XtrsHPxYeu+Qe4yok=;
	b=p58rKimi4uqlwHRlGZXQP0n947crwYZa83Pibwywd+UHV44IbWpu0CZuLbUxhPmJnzo+s7
	TqEvpJSoaqZKKNDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261119121239.WLmhQpNv@linutronix.de>
References: <cover.1794914794.git.wutengda@huaweicloud.com>
 <cff9b939758dad9f16bb4eb0483c63b7787e62bb.1794914794.git.wutengda@huaweicloud.com>
 <sashiko-outbox-218736@kernel.org>
 <e940e69e-f7f6-4c37-a2f9-7caeaf9fb7c4@huaweicloud.com>
 <20261119114850.2dEaCmX1@linutronix.de>
 <cd37e569-8e6f-4b77-a87d-b97f53e3b8f8@huaweicloud.com>
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
In-Reply-To: <cd37e569-8e6f-4b77-a87d-b97f53e3b8f8@huaweicloud.com>

On 2026-11-19 20:09:21 [+0800], Tengda Wu wrote:
> Hi Sebastian,
> 
> On 2026/11/19 19:48, Sebastian Andrzej Siewior wrote:
> > On 2026-11-18 10:52:41 [+0800], Tengda Wu wrote:
> >> Hi Sebastian, what do you think?
> > 
> > The bot might has a point. I don't see how a pending event is removed. I
> > would prefer to keep this part.
> > 
> 
> I sent out v5 which restores the removal of the pending event that was
> dropped.
> 
> https://lore.kernel.org/all/cover.1795053619.git.wutengda@huaweicloud.com/
> 
> It would be an honor to have your Reviewed-by if you find it acceptable.

I just replied, I am a bit slow in the perf corner.

> Thanks,
> Tengda

Sebastian
