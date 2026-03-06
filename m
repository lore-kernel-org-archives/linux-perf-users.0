Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067F2ECE91;
	Fri,  6 Mar 2026 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837185; cv=none; b=BnZSm7P5jy2+uoJcw7aCsnSVogs3DfYfReE91pUh0SerKdTIVTxglZRINSKjb/Px8qWqS7T9nImrVVF7evhuBMW48SIB646YSaM5yB7NLdGaHXogU+vcbwYBi1gx45O5KnL1T3MyBJBJKgYHcWxnu4KDRmeJdMfMeFK1JEOyWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837185; c=relaxed/simple;
	bh=cN+KiMWcwhEO2xQFiecg1z69XlvH9EP+MIkD7Sl6y8g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dWCBJhw92vLhChB2CuTzCtJ19OsSB2J8CGnxjAWOPwFZVszpWURk/NimWbBwY+3kzrs5W6GlHdwHyqv41Z1AMEx8bWmuJSRY180habZr+4S/t2R4nlBi6qnYOuZcrwyj0D0cSbGDftg5iSKi4L0OI9D+rULvvd7e11Wv+SEJLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSWDslwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSWDslwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA35FC19425;
	Fri,  6 Mar 2026 22:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772837185;
	bh=cN+KiMWcwhEO2xQFiecg1z69XlvH9EP+MIkD7Sl6y8g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hSWDslwYB/Dg+F2//bUKmZINVawinjvaZwTBS7zbEhKeKaIomVxxWwkdYmXj42mCc
	 wTCrwpf7GgMDDYiIP+nMIgPWuscsvOza+VA4JDBV8XqAhKog/a2NZltfeah8Kbt9pz
	 zs26i/U7+ijbu9cUl34ERqE92lNmBSbKiFXiIVFG9KicLpiiv3BHzxUsPwCjzQW17r
	 dkvAxav9kdtzILRZT+/2ZPdpkZtXgQZtOpCapbZSWV4aWtIg5neqFFVFo18NxNT3Nm
	 lFgsQIjiYbib+gjo6GXRr/Yijm3CnBpmgOR9oSfC0CxTyTz1QthcK5ZItnB+8YUwZs
	 kKc7VhNM8GD9w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D1414F40068;
	Fri,  6 Mar 2026 17:46:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 06 Mar 2026 17:46:23 -0500
X-ME-Sender: <xms:P1mraQuQHAAkDAKpiIjzDiSFKKSZZgY_HHrvoD6wap0-6TVGyQ2zMw>
    <xme:P1mraUBAXR_SS5Htak9STTGmwRwLV1nX-5ld9d4DIuPjS8vuP7gc5RbeCdv39RzdQ
    kNCGDgxcoPnFpsDHWh9gdolrBLad5qy08qnEdj_TSuuA_p8s0s96ms>
X-ME-Received: <xmr:P1mradc4UfJpSDOQ9OSIDOqOD0BE9NYAOLtdCv4Bt5DJuHrT9wYgxhyVkD0Qgc3B3YR4UatlxTF8NfkuXBsNshWHK7NnA1Ge>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfuehoqhhu
    nhcuhfgvnhhgfdcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepudevieejudektefgvdefjeeuleevkeeutefgueelgfetfedvkedtleefheelheel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedtleekgeejuddq
    udejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvghlrdhorhhgsehfihigmhgvrdhnrg
    hmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhuthhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgdqmhgrrhhirg
    eslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrnhhivg
    hlrdhlvgiitggrnhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhi
    tgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomh
X-ME-Proxy: <xmx:P1mracqvya_rDQExYVYpF5b8v2GRVlkVyd6VMJtSaljoEy4gGzd4Ww>
    <xmx:P1mraR6NvWuGwQtXQItwVRhqz5ExbAuMH5djGnhStbMxTT8gX4E6cQ>
    <xmx:P1mraUD-hGINmlzk5LM5oT0O1D4gqVem9Y18g1uTDsogNoP4ZNEjeQ>
    <xmx:P1mrabaY3843a9-EXomKUPbh_OOWbL7GeC2ZBUbzuOWMzdP5nVq5Ow>
    <xmx:P1mraQLSe8dQyzwld4R5GcNff84218jbh_jnNgAoky5qYHWGGOfKklO_>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 17:46:23 -0500 (EST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 14:46:22 -0800
Message-Id: <DGW2BYAJBIIH.38RQFJI57PW82@kernel.org>
Cc: "Andy Lutomirski" <luto@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>, "Juri
 Lelli" <juri.lelli@redhat.com>, <linux-perf-users@vger.kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Waiman Long" <longman@redhat.com>,
 "Will Deacon" <will@kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add references to tip tree handbook
From: "Boqun Feng" <boqun@kernel.org>
To: "Dave Hansen" <dave.hansen@linux.intel.com>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20260305212215.3188399-1-dave.hansen@linux.intel.com>
In-Reply-To: <20260305212215.3188399-1-dave.hansen@linux.intel.com>

On Thu Mar 5, 2026 at 1:22 PM PST, Dave Hansen wrote:
> The tip tree handbook is a pretty handy reference for keeping the
> various tip maintainers happy. But there are no references to it
> in the MAINTAINERS file.
>
> Add a references to the handbook for a number of subsystems. I've
> added these for all of the obvious subsystems that list T:.../tip.git
> and are likely to follow the tip rules.
>
> This will be useful both for humans digging in the MAINTAINERS file
> and our new AI bot overlords.
>
> I'm cc'ing all the M:'s and L:'s listed for the subsystems but leaving
> off the R:'s because the cc list is already out of control. I'll
> commit this to *some* tip branch if there's general consensus that
> this is a good idea.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: x86@kernel.org
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---

Acked-by: Boqun Feng <boqun@kernel.org>

Thanks!

Regards,
Boqun

>  MAINTAINERS | 12 ++++++++++++
[...]
