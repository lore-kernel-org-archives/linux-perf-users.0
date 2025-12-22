Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875E32C927
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400237; cv=none; b=hQLDvSzlimrIBk378ybiS+ph3w5r5SeAmMG3KbR5rG4OpjYqbullgh9+mh6pDWyb3Gu+DqeU/kAmJVmbrUmEQ8hE3bd1MAV9zZIYksQJq0JreBXdq+WYaVmgETMCaeFsqouctM8ue3ygAxpKtMuVarKi9T0wSOHrlWu+x0F5Uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400237; c=relaxed/simple;
	bh=gIUWM9Fu07op/5WCXVtTnre/9wUkGlB1NAIs2kOV2yU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Oo3GXPqpb3YziKP1IKgtkCyOsjXdZcjl0SbI5N/P/IXgo4bK78mrVRYW4e8i3a/EzRheDTzWVgsQRLMCseJfzMqO/FtoB+yE4UwrxyJjsOmojdxRrlW8XZp87bKc1PVnaF/2cU8KDyduqgE/hSZWlchqQUEcE8WvtHlgr9YfscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ibQ/EW7T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjI+JSGo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ibQ/EW7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjI+JSGo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DA9551D000C9;
	Mon, 22 Dec 2025 05:43:54 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 05:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766400234;
	 x=1766486634; bh=9S6jrQH3/mYIWxfqJfOuabWpqho3FX73MIpk1SthbgU=; b=
	ibQ/EW7TzjusLZOHdidLs59PQQUuFIV2OTE8MOvbcyyb4U9TULe0C/Q3ZgZwB6in
	QEv9682Uix2Q65IDsRJib0OMH/O124gQrdC2aiRFLitdt54Eo1JKGhFTB91QByse
	gQVxu03LWbYYBUTizOMH1093GW67aShgXjFjxIqlFOi5EZ62rm9vh2/XoQ6uad97
	/EreT1SrA2jlx/CjgXLMQ9jitqG3SUTPdVdNUrQxG2kerYgdSKoIFjTkp2rwDqoD
	KQtsqrppcyhEg8Kb9pJep6gNl6FULUqQxODbT/Axnpr1YI3LtyIC3P8uZnX/qUyK
	iWCrA4Z7qpc3kVPm467MZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766400234; x=
	1766486634; bh=9S6jrQH3/mYIWxfqJfOuabWpqho3FX73MIpk1SthbgU=; b=P
	jI+JSGoIG5nxoTi0N9PvAw36w2IgH8RiXKLQ5WOGPI/U9dtGVFy8TYhNeI3O6fGY
	y25veIYSbfSkne41SVDnQ31yFEQfqL6hzYVPLZ07lrhxfIRlMcQWmZRmOpIWuqBC
	4IhPnYgUMJHOq2XiTr1tjAd5qs8RWDzJ0Uf6DG0K18J/9sUCjzVGYnoKhG1md5JB
	S2S792TtLotjlJefS1JE2m1Kukb9vZJxFBkTpGKySsP2jDJmQSFlgxrxw/CTO2w8
	RF9KEDZesePUGKVhOZcWo6ZPvGNmi9EdyVhgq2uZZQEv+jEPsbe+gTV3FxCvRPgh
	zV+MV/cv9pVHusd3t706w==
X-ME-Sender: <xms:6iBJaaSZ6c8G3AGd3VGtfAaARSgT9u2WeeCRrh-KRLwIGCYyLJnWnQ>
    <xme:6iBJaamWPh2fx7rDF-AFitn0ro8w9GedW9m1PQ9U97g8kqgpq-kWx93Hf1b1HmShR
    2twJuh99LKBGe0985Dp0xA2tTZcxTh-GJv_wGTX5fiXbs5MgX3-ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieejfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:6iBJaVRXu_jYaKbLAvVajMBeo-VTSWvgpcLdXIZAx1VT_Ar3f0-kbQ>
    <xmx:6iBJaaykYXJMLLYQ0toWXEqNfqZxCtKx0ZHNtETd_U1ZH5b-h7-lGA>
    <xmx:6iBJadD12OY2Xd3COiZvjVSZZVhDxjW0yJsR-_s9Wjmhy4Ox5xjuww>
    <xmx:6iBJaeFprWUmrPuOqlSxVdJi83uCdiSADngqFaQXx8ulZCu2X_bDgw>
    <xmx:6iBJaS_JMgOJ1QUYtPfNI0IBSx1z4n2jtKHx-jiohnj2rmSGGKaYqvsx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5FF89C40054; Mon, 22 Dec 2025 05:43:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AV8M3mJaQpUZ
Date: Mon, 22 Dec 2025 11:42:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>, "Joel May" <joel-linux@jmay.us>,
 "Leo Yan" <leo.yan@arm.com>
Cc: "Ian Rogers" <irogers@google.com>, linux-arm-kernel@lists.infradead.org,
 "Linux perf Profiling" <linux-perf-users@vger.kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Message-Id: <ce4e1210-94c2-4664-885b-e39106905e21@app.fastmail.com>
In-Reply-To: <a5448524-a147-4edb-9359-bcee3d780eb6@linaro.org>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
 <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
 <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
 <bda366b4-fa53-4feb-a7ce-ee47cfc404b5@linaro.org>
 <20251215112818.GB681384@e132581.arm.com>
 <c8161700-ad9d-43d3-8c45-cfc110ebcd49@app.fastmail.com>
 <a5448524-a147-4edb-9359-bcee3d780eb6@linaro.org>
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 22, 2025, at 11:05, James Clark wrote:
> On 21/12/2025 9:48 pm, Joel May wrote:
>> On Mon, Dec 15, 2025, at 03:28, Leo Yan wrote:
>> 
>> This is my first time contributing to the Linux kernel, so please bare with
>> my ignorance.  I don't know whether it's acceptable to consider patches
>> that conceptually improve something without an actual problem they're
>> solving.
>> 
>
> No worries, thanks for sending the fix. Yes I think it could be ok to 
> apply your patch anyway. I just wanted to make sure we were all on the 
> same page with both fixes fixing the same thing.

I still don't think that Leo's series is correct.

> You might want to drop the fixes tag though to avoid confusion if Leo's 
> one gets accepted, because then technically it doesn't fix anything any 
> more. Keeping Leo's fixes: tag is a bit better because it fixes 
> additional things and targets an older commit.

Before that gets applied, someone should explain why arm64 needs
any special treatment at all. A lot of work has gone into making
the syscall table handling consistent across architectures, so
whether we ship a copy of the generated header for perf, we
generate a new copy or we rely on 'make headers_install', should
should really be done the same way across every architecture.

     Arnd
