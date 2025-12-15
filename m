Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC241862A
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801348; cv=none; b=l3DmlXgrb+DCkf0H4jtM6HcvSbCUWIt1mFeQbk4d4rZqg2qPD/0CbL0RcWcojlZTKZQ62x1ctdx8JgrQaIgWyF/JGHm3I9udD2Bj9uhFaAaPkR47YQvn7wBEnpDZCElI+z6BNLDHg9Z8CFJfD0mFzvNnb1SPeMuO87djMcNE2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801348; c=relaxed/simple;
	bh=YOJ0HYToPgSjx158nOPtgYnl2XVx6oObpuIoBERNKLg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rrfLlO9XrMOE70xnhGIokROtMXJoc5TKwzjj8aefan3D6kZ6/dtJLOr/SYD1aq5fsrPEPVTRKZulJcxki5+zSrXs6bfpl4TICi0rtuf5UanbSQpAVPeEfbPAqqrP8sGAAI05ErCPZfemuk2dYWR4gXpoMTm7j8sFFrdN2Uz/IRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QdTO6WX4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ukb2r1ZF; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QdTO6WX4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ukb2r1ZF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 483D1130013E;
	Mon, 15 Dec 2025 07:22:25 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 15 Dec 2025 07:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765801345;
	 x=1765808545; bh=nX3FD3M4ElDf5gKwO+rrIIt9v74oINUi/KijGikZ1qc=; b=
	QdTO6WX4YcXk7bXnZKwsFTY528xx7OGmujUKGMPJhniWiXbt1XE+JWeXRsIiuIi4
	Y1wl3UJ+yRITA2xOwZ0VaLV+IoR2iG8xm2MjHNGPcw0/jDqywKBiMpl1qzFY5nWU
	wk+6PVgItm3ZM3K8PvpKQizgw2WoNhhiP/Qa/h6xWUY+VSLUQdmUBVz6HMNMxr0e
	YEpN6JdelDi9eMuhcRQf7NegEXwahQGjT9Gtn/kQ2V0pBElg2Ecs1uIzSJXq3OYs
	4ihh7u/BZiG0m5W05q9Sk4R5a6RmLlqgOLDZyxq1MFz4l14/sFGOAkfl8ZwweD0S
	q8RHDRJ69LuZjfm/lFbZFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765801345; x=
	1765808545; bh=nX3FD3M4ElDf5gKwO+rrIIt9v74oINUi/KijGikZ1qc=; b=u
	kb2r1ZFHXhXrNhY5RqiCKkQXPcZNYTk3qcti8FAAnaTGsMPgKWKZNCyOGSPHZcI7
	fru62djvwPJgEUyNoI1N+qxsytur9rm0jsX4x3UwfaLuIE7/RMaGzo4b4wGHJw3A
	s7CUdpbdGD9OenjNnkKIQvHNTyyAhHsdo3GXAaiomeZy+onlNNzNAGQd/3WHm1qO
	jorVv+RgKMyHYVYUoUtQ8pkotNTNpTqd3GsuweywiKSmPFrxjsoGsv5FD1v+3KYr
	w3WWRwgTDtfaf3/8ZDxW0NVIF+1iOhRnpr6GojjCB/ge+2Z6vZL+NX+dgR/f5hik
	sByvndAUptbc/gF8QNERw==
X-ME-Sender: <xms:gP0_acFLbb_GMfqpajTVQ1RvZ3yTg_AZPoUVtlrxwK5GR2WQfH23QQ>
    <xme:gP0_aQJ7E8Of-BBQlR7HFtYFQQL5_zIr0MXfF_8R-7gmHqYT12GrgAu7irU7jaU_P
    ROBgSQRXpri3BvbeytywK0FEJ9gmm2qG5jNht_jfcj9dsGEjml5Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefieektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpth
    htoheplhgvohdrhigrnhesrghrmhdrtghomhdprhgtphhtthhopehirhhoghgvrhhssehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehjohgvlhdqlhhinhhugiesjhhmrgihrdhush
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgv
    shdrtghlrghrkheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqphgvrhhfqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gP0_aUmWdGnoGSoI2Xn0APXiPrU1sIZ9qr7K_jZqm7ZrC7vOkiAhpw>
    <xmx:gP0_af2QrV9dUU7LmCWJj2er0UxYWPCjLKvWZoUW1dB3FJ82g1PklQ>
    <xmx:gP0_aU1aKT_qhkjHOGIyHRjkkA7xQlCFm73BLDTm9s--uZlpp4imBg>
    <xmx:gP0_aRqBbEM0-pAsSwlHBKcbpzPhCjXUtRJla45oqev5yZIeBKFN6g>
    <xmx:gf0_aeS4nynp-ToJtmWSudM-NDnjTGbDzmQnlrIV07pa4sJsUM_i5nOP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6C4BC40072; Mon, 15 Dec 2025 07:22:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AV8M3mJaQpUZ
Date: Mon, 15 Dec 2025 13:22:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Leo Yan" <leo.yan@arm.com>, "James Clark" <james.clark@linaro.org>
Cc: "Joel May" <joel-linux@jmay.us>, "Ian Rogers" <irogers@google.com>,
 linux-arm-kernel@lists.infradead.org,
 "Linux perf Profiling" <linux-perf-users@vger.kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Message-Id: <0076b248-9b23-408d-9448-701df3c8d952@app.fastmail.com>
In-Reply-To: <20251215112818.GB681384@e132581.arm.com>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
 <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
 <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
 <bda366b4-fa53-4feb-a7ce-ee47cfc404b5@linaro.org>
 <20251215112818.GB681384@e132581.arm.com>
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 15, 2025, at 12:28, Leo Yan wrote:
> On Mon, Dec 15, 2025 at 12:52:24PM +0200, James Clark wrote:
>> On 15/12/2025 11:33, Arnd Bergmann wrote:
>> > On Mon, Dec 15, 2025, at 09:47, James Clark wrote:
>> > > The first commit has an older fixes: tag and also fixes some other
>> > > issues so it might be better to take that one rather than this one.
>> > 
>> > I don't understand that other "fix", doesn't that just work around
>> > the arm64 build issue by adding another special case for arm64?
>> > 
>> > If we want the tools directory to have a copy of the generated unistd.h
>> > files instead of generating them, it should at the minimum be done
>> > the same across all architectures.
>> 
>> I don't think it's a special case, the other architectures already have a
>> copy of their syscall headers in tools/ don't they?
>
> Correct.  Most of architectures simply include
>
>     tools/include/uapi/asm-generic/unistd.h
>
> x86 includes their own unistd_32/64.h; only arm64 attempted to generate
> unistd_64.h dynamically, but this is problem for build dependency - when
> build perf, feature tests in tools/build/feature/ run before libperf and
> fail if unistd_64.h has not yet been generated by libperf Makefile.

Ah, I see now that arc/hexagon/loongarch/riscv just use an old
copy of the header based on the and no longer update them. I only
saw that they have the stub version but hadn't realized that they
never updated past the point where we started generating the
ones for the uapi.

Still, I would suggest using the same method across all architectures:
either we figure out how to use the generated headers on all of them
(including x86, which uses yet another method), or we just stick with
the old asm-generic/unistd.h copy and use that on arm64 as well.

     Arnd
