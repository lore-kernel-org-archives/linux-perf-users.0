Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83422874E3
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301234; cv=none; b=qkQ28X0a30kKMijvWETrkCoN8OOmMmzeaKIj/VdGDF7CaSwymdDOjHJNbj6SV7iMBK4eSPtS0PQAjOTSwtqpp3+FH/FF60fuKMMgBdMk5BExbwV3/t5W3EkRzAg4brpgQWcDjSNNDgczmff0rNuYYzpkFlLc+GC6YboS2rxaXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301234; c=relaxed/simple;
	bh=MPH+Wlcdqc/nXSFAck1cj/Cl/jlNamCFfr2noDau+VU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mGZ9QgAxSt02Uz4RKtgFGkkwzy/hrdTtKL+H04f+ZI+9w3OnM1qicoxoN13iqRO8L4LnfGzoQYX5tbrAvO1qwVvLdnrwLJi1USg16GN0DfPBXUznPs9vsWbVoyuRg/pUizKmsPvDguvPc8mB8GN+THBWcemoRgFaYYCaV/Sd5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivt9mQaJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivt9mQaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A82C4AF09;
	Thu, 12 Mar 2026 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773301234;
	bh=MPH+Wlcdqc/nXSFAck1cj/Cl/jlNamCFfr2noDau+VU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ivt9mQaJcF3/QQ1HcjOigqTVQrF5w7enYkeJxLQ3Dp+jqU0+czm4mJtp7O0ZaZV3K
	 R1XduIdB/eIEVo8UyRCXLGiZyZv2j8WkaOdaV8uVZAmcA1lbN1wmo+1Lzol5NJFJc2
	 Zwlidi0cMFzBgPQjGA7sD/lUdmjtEbumL0fFzkyuEscBKwqnL+9hpQ0yiTlPRgXKwW
	 5HnJbC3tmIFq2FuK9n8xuvnCZOKLyVyUQ9sWCnGx/vAOYBzbuH1QmPbctC1W+je8tc
	 IOJNtQpdNninBxW3xdMQh8w1wwntKtKx2UTBXRChexfyWs12nkN7+GMyunkIX6eZi3
	 aUe1lIuOQfjjA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54F96F40068;
	Thu, 12 Mar 2026 03:40:32 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 03:40:32 -0400
X-ME-Sender: <xms:8G2yaRYFFTYuhqShcfT0FtYjVE549HFV5Xiy2QcdT8VyvTWsUkciEA>
    <xme:8G2yaTPCW4nFahGxqqJADEDX42Jo_x99agIt0TFYQ8-Ob9AvhVOcAY-RvZLyJ1IFA
    CNDk67ZpqlBjAuLtco0om5BAqN0-kvFhWd0CnbXJ1pPNvTm7MFU23c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekvdffkefhgfegveekfedtieffhfelgeetiedvieffhfekfeeikeetueeg
    teetteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppe
    hkvghrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohep
    geejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjsggrrhhonhesrghkrghmrg
    hirdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggr
    vhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvg
    grmhesrghnughrohhiugdrtghomhdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhn
    rghssegrrhhmrdgtohhmpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnse
    grrhhmrdgtohhmpdhrtghpthhtohepjhgrmhgvshdrmhhorhhsvgesrghrmhdrtghomhdp
    rhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhope
    hmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomh
X-ME-Proxy: <xmx:8G2yaTgS_ddwOWPCAdSFy6-Y1mZdZ_iyvDw28nxREK10cmBDy1coXA>
    <xmx:8G2yaRguhnLKGcSdzAq9u1dc6XPUD9ZnyyTFoVCMZ8rp3WcW3SRxVQ>
    <xmx:8G2yabu-w1NWjXSEznGAtHVpjOTph5gIPqcPdmTEYE__Cibtihb3RA>
    <xmx:8G2yaSRKccsFYKU-tCk3MMA7iQG1AfH0GFwUGjJ1sKPR9B-SCOrRww>
    <xmx:8G2yaUEjiUDcY9_u-yuXIZDKbwLT_c8AH_z2rsE4bAPYd-iqA1IkwZtj>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18126700065; Thu, 12 Mar 2026 03:40:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZoFCyIUcobR
Date: Thu, 12 Mar 2026 08:40:11 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Carlos Llamas" <cmllamas@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Cc: "Sami Tolvanen" <samitolvanen@google.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Jason Baron" <jbaron@akamai.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "James Clark" <james.clark@linaro.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Kees Cook" <kees@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
 "Jens Remus" <jremus@linux.ibm.com>, "Juergen Gross" <jgross@suse.com>,
 "Conor Dooley" <conor.dooley@microchip.com>,
 "David Kaplan" <david.kaplan@amd.com>,
 "Lukas Bulwahn" <lukas.bulwahn@redhat.com>,
 "Jinjie Ruan" <ruanjinjie@huawei.com>,
 "James Morse" <james.morse@arm.com>, "Thomas Huth" <thuth@redhat.com>,
 "Sean Christopherson" <seanjc@google.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, "Will McVicker" <willmcvicker@google.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM"
 <linux-perf-users@vger.kernel.org>
Message-Id: <742d77a8-3c53-4814-9dd6-81e8317cd829@app.fastmail.com>
In-Reply-To: <abIFwSF1RqhC96C2@google.com>
References: <20260309223156.GA73501@google.com>
 <20260311225822.1565895-1-cmllamas@google.com>
 <20260311231406.GZ606826@noisy.programming.kicks-ass.net>
 <abIFwSF1RqhC96C2@google.com>
Subject: Re: [PATCH] static_call: use CFI-compliant return0 stubs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Carlos,

You've cc'ed around 50 people on this patch, which is a bit excessive. Better to take get_maintainer.pl with a grain of salt if it proposes a cc list like that.

On Thu, 12 Mar 2026, at 01:16, Carlos Llamas wrote:
> On Thu, Mar 12, 2026 at 12:14:06AM +0100, Peter Zijlstra wrote:
>> On Wed, Mar 11, 2026 at 10:57:40PM +0000, Carlos Llamas wrote:
>> > Architectures with !HAVE_STATIC_CALL (such as arm64) rely on the generic
>> > static_call implementation via indirect calls. In particular, users of
>> > DEFINE_STATIC_CALL_RET0, default to the generic __static_call_return0
>> > stub to optimize the unset path.
>> > 
>> > However, __static_call_return0 has a fixed signature of "long (*)(void)"
>> > which may not match the expected prototype at callsites. This triggers
>> > CFI failures when CONFIG_CFI is enabled. A trivial linux-perf command
>> > does it:
>> 
>> *sigh*...
>> 
>> And ARM64 can't really do the inline thing because its immediate range
>> is too small and it all turns into a mess constructing the address in a
>> register and doing an indirect call anyway, right?
>> 
>
> Right, the range for the jump is very limited. I _think_ tracepoints
> have managed to implement the trampoline work-around:
>   arch/arm64/kernel/ftrace.c
>
> So it looks do-able I think but a much complex route.
>

So far, we have managed to avoid the blessings of objtool on arm64, and the complexity associated with the inline patching is not really justified, given that on arm64, there is not really a need to avoid indirect calls (and as Peter says, we might end up with them anyway)

A while ago, I had a stab at implementing the out-of-line variety [0], but nobody cared enough to even respond. It is rather concise, and localised to arm64, so it is something we might consider for CONFIG_CFI builds. It is essentially the same sequence that arm64 uses for trampolines between modules and the kernel if they are out of direct branching range, with some .rodata patching to change the target. (arm64 basically only permits code patching without stopping the machine when it involves patching branch opcodes into NOPS or vice versa).

Doing so for only CONFIG_CFI makes sense because it removes the CFI overhead for all static calls, although it adds back some overhead for the trampoline. But there is currently no need to do this unconditionally.




[0] https://lore.kernel.org/linux-arm-kernel/20201120082103.4840-1-ardb@kernel.org/
