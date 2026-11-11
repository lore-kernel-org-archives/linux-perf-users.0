Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388610;
	b=SeegkbNFZ02KiKp+TRw/lqiHkmAVaJsT/LkwJoJfSQ5xM/g9z/Q3t4+TI0CBB+wl/HCy
	 xx149D2BWvmBP5d4MekylVEzZRzFTaYDkG4GHipJRNRVQhZ/mudJwwIgAKV6b7PVcSjgL
	 zW41vhfTIPWtS8l8Zg1iC+aIYbsf85cKR+81f8riq4xHdXY7oFVKxU1QPBjcyMGkRidg9
	 4btccbblbpfXfBMYLYq0N6aB9reQM7gcLyKDeKk5fSl4PXXmjGa0ztsu6eokITgcKovA2
	 J4vYqtjDLYTxZDtEWEHfUxJraMXhSFPmkgf4JFnL51Lc9idDwvJg/bRSevtV0aQMZcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388610;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=w+8gffM9pBG1sxQLRYggSN/g+Ts9H9BUGYDhUHnOgAk=;
	b=hO8OfHnWm1imCXVUaWrc+xMz62uEaMNIRmqtK56ensT47nQuxt8ESB1DMyVWuboWf4YX
	 VFzD3KEDkU0/OfO2On9RT46e1kuPV5cin/5wDP2pPX1Vzwm74MU3manUi6Mb1FCoxzmor
	 qOEei4UmSjFKVDstylj7M/jkUfK8f0k8ZRbqNFAK4dtHStg8gwjz0tjljqlbX0IG2SD1e
	 MvATE9//IinemQcPDvIaTGZww5UxQRBrhBzyfbz/AW1fpNdt7y+56JjTz7ftfPR/Vtgxy
	 IdWoIrWJjLs295fIu/hMlv9EAtYUa/GCW1uOkEuVDovqoiFlHEgahKHXRxdhN2o4Dfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="Xpa1mH/N";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C9606A324;
	Wed, 11 Nov 2026 09:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9C9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Xpa1mH/N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w+8gffM9pBG1sxQLRYggSN/g+Ts9H9BUGYDhUHnOgAk=; b=Xpa1mH/N2jMqrlncBL+rVQVd5P
	UFdbVF1oye3L2HckTPl5lkHk4KdDSfV2mIh0ZzVnxi7Gc4dTRRNMLtSEcI8QP3H982ZIrwCCIDr/s
	s8BdOlRN/xVxRAgGp847jYjFU7mt/IRWkMju50tdPRuT/jIueIID7tlrgKtNgCHTUTpbLJ9lo5tAy
	kiRoh+mBx16v08IaCp4nAcrMj2Up/8r7YPiDqw0LmTdGoTcDSAPc/eXonq9LAxiLmktDNJOpW/VOj
	Q7Wm7Xc7Nhd9SrTxgPV56pveZG/vQzIRA080IWCFSYzRvxuN3j77AhdCKeyU8KsJJ2eQCvqP71cB7
	H4JhwNLg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR4Rg-00000008DKQ-36mn;
	Wed, 11 Nov 2026 09:16:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4CE7E3005AF; Wed, 11 Nov 2026 10:16:44 +0100 (CET)
Date: Wed, 11 Nov 2026 10:16:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
	linux-perf-users@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
	sudeep.holla@kernel.org, linux@rasmusvillemoes.dk,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] cpumask: Use cpumask_intersects* APIs where
 applicable
Message-ID: <20261111091644.GW2668804@noisy.programming.kicks-ass.net>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
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
In-Reply-To: <20261111075945.3930230-1-sshegde@linux.ibm.com>

On Wed, Nov 11, 2026 at 01:29:40PM +0530, Shrikanth Hegde wrote:

> Shrikanth Hegde (5):

>   cpuidle: Use cpumask_intersects_and where applicable
>   arch_topology: Use cpumask_intersects where applicable
 
>  drivers/base/arch_topology.c | 9 +--------
>  drivers/cpuidle/coupled.c    | 4 ++--

That's not actually code I maintain. That's rjw stuff.
