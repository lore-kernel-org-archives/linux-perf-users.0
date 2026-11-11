Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391819;
	b=pCA2nRnG5C6tP9Uz5RRodN5PAf1+CKCs7bikmVKmI/NciaP85soleC4GvSRq7JmxTTJ/
	 1nB9KgTW37268aqaN+01cakE/N4x7z6BUD7nexEwkPetxlPWuCoF5AMjyEo1P7C31dxCc
	 7X/tGLoQiR2IRx1sA2gCxUUvgiW90z8TXKpH+lhQjHf1+G6dKornUkUgjTlRIJG8n5jyB
	 OU04mZ3ep0JuuGjhCOYwp56RqWGih5ZkA1YZyAh7vFYxTo/YRASD06ci1TgDLBDaIF7oF
	 4VybH2DDo57zhyEZFSar9l6vXhFS7sGwM501B/a3dzJbXv6BvbDoEiWJDTY5Pl5vipA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391819;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=js7WqxYKCluqvGDJ1IWCYAh6RJ7zjo4+Kn1ZXmdzg7M=;
	b=PyoZ97mSyR/CNslb4344MB6QLvm4+1JLcasHqaGlTipP2aFKHpUXIjR8C0BXO0Bu9qoI
	 BjB2vhXuHaLYZFGvZi7K//EqeS81RdQLo910qAHtwG0266dAYeWzBN87gMPqr1YqEqFXX
	 ExI0BbTP/bIzxhAyVLAAvixhAEPb6mr0wN682VrYW1caE1zwgYe0gab8YfmOAIWNp2Gqc
	 tE0ZHEyKStcWYpQuzBjcZFWoWYBV8YF9xtco0uDKU9wz5inoIirEq7sQC2+uVECiE7HcC
	 tjSFL3Y6aGIqItYy6ZShcWII3hbAgKiWYqtNC198KH2HMTa9YaPKlHuozv68yYU46Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=jWfGZZxX;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8889606A330;
	Wed, 11 Nov 2026 10:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8889606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=jWfGZZxX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=js7WqxYKCluqvGDJ1IWCYAh6RJ7zjo4+Kn1ZXmdzg7M=; b=jWfGZZxXXQSDWOtETNVSfo2ZI7
	34CBfayudFEA5iFA6KVCccDn7oeOP9jJ5tXpPLB4PQQeAkUp21rthkWyPs79O9hGR8UZ3NeM7wu+p
	feqGsZzfs5JV8NfnrnZZEjzlj7oRUdkYOdih5iMVB7S+ypjZeB3fX20u/aEI0jRqzqdBd++LapaL9
	cDzHF1ZrYb5QLxxY+hqKpDUCFI/IX79k0DrkdaSnayqewzF++4jJhoN0WLRiv3jzF1KFCb4M9ukX4
	KOBGgX7qSJHIq4YIJzqqC9Ucofw6aDCsvyBg7F8V4FB88K8t9qfNHN++BmkBh+j33Mr6yZWKJt49a
	Kva7Wkzg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR5HT-000000090W1-0IIG;
	Wed, 11 Nov 2026 10:10:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7AE50303011; Wed, 11 Nov 2026 11:10:13 +0100 (CET)
Date: Wed, 11 Nov 2026 11:10:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
	yury.norov@gmail.com, linux-perf-users@vger.kernel.org,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	tglx@kernel.org, sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 0/5] cpumask: Use cpumask_intersects* APIs where
 applicable
Message-ID: <20261111101013.GH2668564@noisy.programming.kicks-ass.net>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111091644.GW2668804@noisy.programming.kicks-ass.net>
 <c1e22acc-dedf-4f07-8d97-a79649826b99@linux.ibm.com>
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
In-Reply-To: <c1e22acc-dedf-4f07-8d97-a79649826b99@linux.ibm.com>

On Wed, Nov 11, 2026 at 02:52:58PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 11/11/26 2:46 PM, Peter Zijlstra wrote:
> > On Wed, Nov 11, 2026 at 01:29:40PM +0530, Shrikanth Hegde wrote:
> > 
> > > Shrikanth Hegde (5):
> > 
> > >    cpuidle: Use cpumask_intersects_and where applicable
> > >    arch_topology: Use cpumask_intersects where applicable
> > >   drivers/base/arch_topology.c | 9 +--------
> > >   drivers/cpuidle/coupled.c    | 4 ++--
> > 
> > That's not actually code I maintain. That's rjw stuff.
> 
> Yes. Sorry, I should have cc'ed him.
> 
> Should I split this series and send it to each subsystem instead?

I've taken the first 3 patches since that's all tip stuff. Feel free to
resend the last two with appropriate Ccs. Its all independent patches
anyway.
