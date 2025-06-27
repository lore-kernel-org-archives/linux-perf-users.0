Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881D1DE2A7;
	Fri, 27 Jun 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049497; cv=none; b=TaUSxS/bktzEU5Vto1p7a/iHet2DoOp1Ls3djG2llFGR70JMQQ877XYlCEvhrRJ/qU8ZXOAOd0EkmndLyDa7umhcwLsql3gpSlAq0FZr20Bci2c5HNwSwMc6Mro6eMCyqgyUt6SEfx3dgINvbl23yJjLrnd2IoiiMJVUTb2yQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049497; c=relaxed/simple;
	bh=b/arh6v5GkSC0H6OoWL24mZLuTJjYuwjpj8erXAvGDY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nX9xzFO07j1mUbDk/FnGljRohUv6LNgjY6r7FPMhVi+IFNO8JHqufTvBhEgzw1HXKJTXjhWJEWE4XTQR3FqdkFACkLdKKLS+600Uyp6CFcCsuNDds6EF6Wwvg/F+HKlGPLN0ECYFSL+vnXp3fiScbkw0LCybxEuYw3r4s05X7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=a6KsZrUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSLsWnPd; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="a6KsZrUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSLsWnPd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 25E7FEC009A;
	Fri, 27 Jun 2025 14:38:15 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 27 Jun 2025 14:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751049495;
	 x=1751135895; bh=EppjiZBFLpymW3k0IoAM4ktKeyibh2YCqj0MSCFFTf8=; b=
	a6KsZrUCgZnWxbdrELTCArv/39jaYVF74eSy5JiWDgkgJ8XlHte8XLkaQdkWvcCx
	A6htij8o7fjjygnvKP6J2Fjz3Y4oKXpVh9Q2mShKvNLPSyGiFDXYyNLI7EceD86k
	aUXA0Yxzb5z3PqceDYoHtGj6oors5HcXGEuiGJJSoKZQEuf5j45gJq2w+lgXqRFx
	MnTvTQqTiRKno5KkfGPrIZbQBxIKXPcoFcjYsRdhrAxXJN3tsZXWDj4dj13/NqxV
	g/8Jzk4bhiqDG2KAhB4LkKD+3sOcVLsgIE1iUPp8nWB8dYIV6S+Sz85EPz8zHCCq
	QGFpMX69nI5BnOSADAcd5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751049495; x=
	1751135895; bh=EppjiZBFLpymW3k0IoAM4ktKeyibh2YCqj0MSCFFTf8=; b=N
	SLsWnPddwalUg1e39Uu1dNo5RbqMj1u1SAbieq8Umd5MQBzITI2RHHoaN/I4VE3J
	1QZ62SAmJ2aeNSx8Rl9nFXapnuxhUWG5lS6jTo+/FlTFyDNFqXUgM/424kvSi9dD
	7iMWw+5UYOiJCdz/C+HYtUe2SiWc8s7TQgQ9sY6h0GrFIZrl6XgeShcDeWlK9Wza
	br9JgtCuERvS3ScT8uc6WVT3KVED+8BDpLUp6X62aEjC6U8lCoz/afYqFEI4tZYL
	pIbgXKJDLYgkwG/jXHO5el0NrjlSsn4gX/eGOcI/RA/MWmHYdfHjpFG3UID8V0HG
	ULVYajeAUBvvVzLc0gyWQ==
X-ME-Sender: <xms:FuVeaJRvr5wbXtftmiEUBvm9h1hLau66XG1G-qpqs_GGtF3VogjSnw>
    <xme:FuVeaCyWV9HbocBPKxWTct1J3P7Qoyj_-aQk4RHHkBNipYWXFTEdK5CzhINfeY1t4
    hRPrRFj72X2eLWYqmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefhnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphht
    thhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhkrdhruhhtlh
    grnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhm
    rdgtohhmpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhope
    grrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdho
    rhhg
X-ME-Proxy: <xmx:FuVeaO3QJmNs3FqhuuDJfVl0DxYb2aACaSXSRcboFClgl2urwEv4Yg>
    <xmx:FuVeaBBPm3zvX6bceLK_mdpepxsRuOuzfV7bnQ73pMKqq92rj-ekRA>
    <xmx:FuVeaCjOLJYbynMg_7YPN24VgvWp4V5sEyPjLw2zQhpeLrNVjzcZXQ>
    <xmx:FuVeaFpTEnCzndnktMCO0IIFJJGmoODmHyxWZvO9XA7HHjOqptExFA>
    <xmx:F-VeaIpKXgEsEPXQWHynHa3_noFGIfugOmUKAnaDjXyZUK6PyqF5_haU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5527D700063; Fri, 27 Jun 2025 14:38:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T5c964ff673f056b0
Date: Fri, 27 Jun 2025 20:37:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Robin Murphy" <robin.murphy@arm.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Nathan Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Ilkka Koskinen" <ilkka@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <0952a73f-3f3d-4531-a3ca-d68478a86e11@app.fastmail.com>
In-Reply-To: <39117e6a-ebb6-4c92-a19c-2033c4e590cd@arm.com>
References: <20250620115149.132845-1-arnd@kernel.org>
 <39117e6a-ebb6-4c92-a19c-2033c4e590cd@arm.com>
Subject: Re: [PATCH] perf/arm-cmn: reduce stack usage in arm_cmn_probe()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jun 27, 2025, at 19:57, Robin Murphy wrote:
> On 20/06/2025 12:51 pm, Arnd Bergmann wrote:
>
> At that point, though, it seems like we may as well just disable the 
> warning :/

I had a couple of cases like this, where the same large stack
happens on both gcc and clang, and adding noinline makes clang
behave the same way as gcc, so neither of them warns. Leaving
the warning enabled at this point at least ensures that we catch
it if it ever increases further.

There is a different type of problem (mostly on powerpc and mips,
but sometimes on arm64) where the 'noinline' helps clang to not
produce some really bad object code with unnecessary temporaries
on the stack.

> Fortunately it's not actually that hard to improve matters here, so I've 
> just sent that patch:
>
> https://lore.kernel.org/r/e7dd41bf0f1b098e2e4b01ef91318a4b272abff8.1751046159.git.robin.murphy@arm.com/T/#u

Nice, your version reduces the stack size from 1360 to 784 bytes
for my test randconfig, so that's clearly better than my version.

While attempting to reproduce this now, I also found that another
patch I had avoided the warning: I added -finline-max-stacksize=128
to the KASAN cflags, to work around some overeager inlining on
powerpc, and this had the same effect as my patch, but without
actually having to modify the sources.

     Arnd
