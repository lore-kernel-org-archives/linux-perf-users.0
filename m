Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018A33CEB5
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869498; cv=none; b=SJ2gffbEhplwZzdwPEhZlxjMHynBHRzHHQ9sciZ44XRVSeHuCX6pgm2722WRpdB6n+JXsb/FUoWzHX/mTuWBS3lAhM59YEpWQtWgs41OidFUKWL89G5HaBZMc+FkbjN9xOwcsYy+FZ11k4DJ5EPD7cqnB8XMBv46ge74rlILsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869498; c=relaxed/simple;
	bh=6QVIo6OBuRbsAY5CFfJlz0pVf6nSg4EDSMzzsj+XY+Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nVUjD8LBd/BpxUpf3nl77kynryvVYQPHjHgT0JcH+aUvLKEfnslDF1A7XOB82zCnbkYRtj72xTX/UaeNn74+JJ2iX0DlzlNvypLRt1LSVYGSBKAkq+tSKX5oue4QTIhU3tclCZJZqmU0Km7NjEifsrwDsUVSr0wJfas8eoRCjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ee+eWgIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EtukkHQ2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ee+eWgIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtukkHQ2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 692C41D00149;
	Tue, 16 Dec 2025 02:18:13 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Tue, 16 Dec 2025 02:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765869493;
	 x=1765955893; bh=Lsgj8OuzqVfDWSQO7R1AiBs/4NDQw6VrhmnOAUFhsI8=; b=
	Ee+eWgIyyqGFQ2U++/CCQfKtX1+PBraLcFgCVSjRTmiHVd4v7cOAtqBISMUoZK2I
	/unVBNqkXUnAo7v369WXoBPr0PMwXRuymkveGrq3/4hyg/HDDDldn+AZ4gEMTPke
	jlQGjyCfSBTTKOmXCBALCZDeoqXO+363SVyzwOOvqz4ls3WkQCmjf+EpkjQDqxNL
	bEX5I4P0cn64xkyMLObLbRJ1bTLyOqOm+6GjWUabXIV8TU5M2u2xjqUG0zrjMk/F
	XWfYbYtd3GZQAf+CpHhWPdzk65twJNyidxo8Q/cBubC1wTyQidS1LPywta+9WRs6
	lcEDtPrH3vFA3d6P86j8eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765869493; x=
	1765955893; bh=Lsgj8OuzqVfDWSQO7R1AiBs/4NDQw6VrhmnOAUFhsI8=; b=E
	tukkHQ2YrviOGwMTrESN0wNEloj3aeZqQbLr5m6puuJ5ls/S8ly/IJ2/jPpxYaoQ
	FOlokDEf6OBcrJxWI9qtK9FbviUhH6FbGM2btFX2zMomhj8GV/DTVN6cAkI7LKEz
	CDCKK/8+ZhJkco98/VDUhHfGe1CYXUZGchJnXRQUyJfucLl6ouC4ZcA44FrlAeMc
	a11nOuMUC2dWY9McsBz6hkvr6Vti9DZ0s+th5ATlUEQTtuAmWjV7VbRFm0xt4eiZ
	qjk44MfELfAwYmjf4GaY0/qnwbElMv1QYaidkugtcju4rBcekQf9lebRnA1ymIdF
	Y0/c1Ug9lJmoPVU09EsFA==
X-ME-Sender: <xms:tQdBaTqci9f5MQlHxVNLOJ8o4-osZO0LrQ-E5CCFtSc5XiW3P4PLRw>
    <xme:tQdBaYd01GHiuDnL59bTT7eecpJrOZB606OKWEPhNrYM--rla-ekOotP_0zXNG-lK
    q3_mZxvmcwmffGz8_tZ2cLokNiu0tNjZEtNCMOrVLKxyMHu-mr_Wlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledtiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:tQdBabqlVGzyMXgvvDrOHVcNHcJCijQBB5LAKg_b-DLBZOfuODTprQ>
    <xmx:tQdBaRqqHyE3Pe5XM5WRM1GI1r6iILCQ6rZp3-7EjY-468z95MXsjw>
    <xmx:tQdBaaYZCmxy8JbVSwHT030E9CdK0dcvgOAGorPfCoOvqi-yTLtFyQ>
    <xmx:tQdBaf_vE98Sq-O-6NLIrSl9uRm1QVQeW6NdnKv5GYmQJOvX-iUtIA>
    <xmx:tQdBaQ3RztgEaVGa-htyM0sa-EZ0bLG4Hgv81PlMDG2VRjOJ_LPsefWQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EDB30C40071; Tue, 16 Dec 2025 02:18:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AV8M3mJaQpUZ
Date: Tue, 16 Dec 2025 08:17:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Leo Yan" <leo.yan@arm.com>
Cc: "James Clark" <james.clark@linaro.org>, "Joel May" <joel-linux@jmay.us>,
 "Ian Rogers" <irogers@google.com>, linux-arm-kernel@lists.infradead.org,
 "Linux perf Profiling" <linux-perf-users@vger.kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Message-Id: <67bafe7d-6761-4b1c-8742-628513e7e8bd@app.fastmail.com>
In-Reply-To: <20251215164920.GD681384@e132581.arm.com>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
 <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
 <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
 <bda366b4-fa53-4feb-a7ce-ee47cfc404b5@linaro.org>
 <20251215112818.GB681384@e132581.arm.com>
 <0076b248-9b23-408d-9448-701df3c8d952@app.fastmail.com>
 <20251215164920.GD681384@e132581.arm.com>
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 15, 2025, at 17:49, Leo Yan wrote:
> On Mon, Dec 15, 2025 at 01:22:04PM +0100, Arnd Bergmann wrote:
> As discussed in [1], I would prefer to drop these headers, but Ian
> noted that this could break builds with older toolchains.

I didn't find the reference to breaking, do you just mean it
would break when falling back to a header provided by the
toolchain's own asm/unistd.h, or a problem with the modern
generated version that is solved by using the old asm-generic
file?

> Generating the headers dynamically would avoid maintaining duplicated
> copies under tools/ and no need for periodic syncs.  However, this is a
> quite big effort, not just perf, we need to update makefiles to the path
> of the installed headers.  I'd like to hear opinions from tools
> (perf/bpf/selftest) maintainers before proceeding.

I see that we do ship the sources for generating headers on
most architectures in tools/perf/arch/*/entry/syscalls/syscall*.tbl,
the only exceptions being mips-o32, mips-n32 and x86.

I would also point out that s390 no longer needs a custom script
as of 6.19, since the last incompatibility between the s390 format
and the x86 format of the tbl files got resolved with the removal
of the s390 compat mode.

>> or we just stick with
>> the old asm-generic/unistd.h copy and use that on arm64 as well.
>
> I will proceed this way for now.  From a maintenance view, it is a
> pragmatic solution that only requires reverting a few patches and does
> not introduce any new code.

Note that if we ever need to update the
tools/include/uapi/asm-generic/unistd.h file for new syscalls,
that will get harder in the future once we remove the
kernel's own include/uapi/asm-generic/unistd.h. I'm sorry
I never sent that fix after the previous cleanup that introduced
the common script.

     Arnd
