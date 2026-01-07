Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8483590C7;
	Wed,  7 Jan 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799375; cv=none; b=oLk1si2Tp6wDhRq5/IBBNiaaNf20BtgmBw+IaNBtbNAx8p4PxDKh2R5M50DOr8VOKBThrvXDN/19Uv6moEJibkKYv/cqzusNDqi8uykzeKrqQWmGYTOxhgkhG0SG8cD9UYOchnxaOwfOesN7+6OJk+UWCiDBCjZz0/iMlxfShkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799375; c=relaxed/simple;
	bh=t+tRKJGI0KggV9HxD5mo3mUn+t2KgLMLklvnMze72oE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YzcpRhu9oHSIXp3HwnaidVH8i0fcFoL207cz4lSODF0E9HHgHNceydaQGZFWkC5B4Jrj6TovI4hpy5KOIKnwpEDefZnVI9EkkTN+A5Ek1M9nfH4XxfiELAkvekULQLJLcS3MaAcrchJ8+gHVC5ih4Qzdd2hhgGujPjFjAFQ8hIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=E7zKK9O8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dj6ymVRd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="E7zKK9O8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dj6ymVRd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6576FEC01C4;
	Wed,  7 Jan 2026 10:22:51 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 07 Jan 2026 10:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767799371;
	 x=1767885771; bh=0B0l+Tn1h4mZVReAN2vgIxtUiQSYwqERyiGqQE29qN0=; b=
	E7zKK9O8H2JhA2LWJ5aGZMLNjbwkL0/eIDtr5oKQ3fvQ7CqfsVrYxPaU9OnJvNgQ
	7YHPwuT69cpMGh17NAeLuXm2X82Q8GbcRO9ImklfZDkLo9MBbOq+7xJ50lHlBk1G
	hfK9wPdNXiEjrs3vrSVBrJ57LO88CaXu9VR6vyGB2d2meCZllt6u0cV9k9iOrzSP
	eDAn/PH4hcBvjJwec5Ca2FrAbNPCvc5b3s11P2AGG+Dltz5u2+Ha2NMgjcr5YxDr
	5onM+BckO33WI1lB8/b6YLhzabJyMOB07kkC1DxY6MFVbZUQ84Lo9kEPWjRv8Sfo
	GIQ68+i8d+eNz94b4PfwQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767799371; x=
	1767885771; bh=0B0l+Tn1h4mZVReAN2vgIxtUiQSYwqERyiGqQE29qN0=; b=D
	j6ymVRdCJnpqLnZO7m4sK1RYykE97tccSMytjwdzzvXWA2C+WztSxlqaSt+S4dmJ
	0IxSRnywI99u/uCEuBTVX6TxVOu3NVgOUglTSVRrzCzf0v/irHmNVGmXjlbnYi8P
	BlqlXICzISMD3oDkg2VXz6HqT0+blVN5X6wNXtx9dtjzB6CSkMMzvDTZ3kBb0k4+
	yusmwu8qa0gKosPyK71v2nkxvlcq2AsPYkYeriQUhHC4RwjCTo2QQrJqQLzHBw9x
	83ms6NMv3moByfwMkpL5cPxlPet+9eC45nRUDQq7LRlljECjZGXHJZqLKLNO6zms
	UVSm4cRUqFAtb1ZVoeh6g==
X-ME-Sender: <xms:S3peaR8ris70EOHdkgGnxQCKNIRjYZi1l5821KqHoZEDXFDnvxu0Yw>
    <xme:S3peaQgKtZF2hdYJOhQCTVeEwSPKM9f4xyvxEhhU50FpR4FJ-aTJ_xZkCwOXKtpyL
    pChacbRhwqXeuahO7Y-hF-gsrAEkWZ169Q_GhzuWuYGk4MOqAqFPGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhgvohdrhigrnhesrghrmhdrtghomhdprhgtphhtthhopehirhhogh
    gvrhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghr
    sehinhhtvghlrdgtohhmpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghmhhih
    uhhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshdrtghlrghrkheslh
    hinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgvrhhfqdhushgvrhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:S3peaUP1yunq2vS5XuvvG8dNPw5i7b6-ctgyx0AhNlRfTpDKdCLkkQ>
    <xmx:S3peabZVKikFtu1nBy7gqlOJ0BVblcDw6oRvcAm9gzz8W0Gy54gULw>
    <xmx:S3peab_-1jBrjaPmsWzrTGNWIMuoqtYvDxa3_uHpZLsGOv7CuEx0_g>
    <xmx:S3peaUT4SeZGIhLA65dA7fZ94y6i-JcS5EmKuPzehUjxAEHGXENM5A>
    <xmx:S3pead6AihSP4SHeSCT_a5sGl2ykUfFsb6gYIjAXtZz1HW2UEHNr1Q_j>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F1288700065; Wed,  7 Jan 2026 10:22:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AogT6V0FABx7
Date: Wed, 07 Jan 2026 16:21:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Leo Yan" <leo.yan@arm.com>, "James Clark" <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ian Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>
Message-Id: <b50402a1-f1e2-46dc-b0f8-a08326b02c96@app.fastmail.com>
In-Reply-To: <20260107144806.GC336318@e132581.arm.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
 <20251222-perf_fix_syscall_header-v3-1-eb4a8b9dfe66@arm.com>
 <58e432e4-5825-4f2e-9aba-29be63eac56f@linaro.org>
 <20260107144806.GC336318@e132581.arm.com>
Subject: Re: [PATCH v3 1/3] tools headers: Go back to include asm-generic/unistd.h for
 arm64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 7, 2026, at 15:48, Leo Yan wrote:
> On Wed, Dec 24, 2025 at 01:47:51PM +0000, James Clark wrote:
>> > To fix the issue, it restores to include asm-generic/unistd.h.  This is
>> 
>> Would this prevent us from using any Arm64 specific syscalls in the future?
>
> I hope the perf code can be general enough so don't call arch specific
> syscalls.
>
>> I think that's a downside of this approach vs copying the generated output
>> that should be noted here.
>
> From pragmatic view, I don't see any issue with using the
> asm-generic/unistd.h on Arm64 at current stage.
>
> If later we need to support new syscalls, I assume it is very likely not
> an issue for Arm64 specific, we need to resolve common issue either
> updating asm-generic/unistd.h or change to use dynamic generated headers.

Right, the arm64 table is currently shared with arc/hexagon/loongarch/riscv.

There won't be any new arm64 specific syscalls, but the kernel's
own uapi/asm-generic/unistd.h file is going away, so the
tools/include/uapi/asm-generic/unistd.h copy will become harder
to keep in sync with scripts/syscall.tbl in the future.

>> I'm still a bit lost about why Arm64 copying
>> the generated header is considered a special case when we already have these
>> x86 ones.
>
> If arm64 maintains its own unistd.h, there is a concern that other
> architectures will do the same, and we will end up maintaining
> fragmented headers for each architecture.
>
> Later, if we need to support architecture specific syscalls, we should
> explore better approaches, such as using generated headers (e.g.,
> make headers) to provide UAPI headers instead.

I think the more important issue with the current code is that
we don't support the older architectures besides x86: arm32, powerpc,
s390, mips, etc all have a custom syscall.tbl file like x86 but
don't have any asm/unistd.h installed in tools. If we want to
support any of them in the future, we should start generating the
files the same way we do for the kernel. There is already a copy
of the syscall.tbl files in tools/perf/arch/*/entry/syscalls/syscall*.tbl
and the arch/mips/kernel/syscalls/Makefile
just not the corresponding scripts/syscallhdr.sh.

     Arnd
