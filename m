Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48D27470;
	Thu, 12 Mar 2026 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302899; cv=none; b=WYoPH+XboNrFykN/yKeR1JzD6+mvMxIkv8HUvPzxx6qOhn5fiRX7YqB0S1o4HQ5sTb9SglQY0xHJFIoOXidLcbY1R7Sn+ekS1AIovG1HhF3w9IZKGkgOikbsWtIYgF1Cl0tfcgqdgLX2WE59wbnY3kt/qfFpXyhnnGMOaCl2n34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302899; c=relaxed/simple;
	bh=8QAgi4tsYCemBagrhQjy0Y/ztU848dHP1HOW/hQnYak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd3ROnUiJrNzA7LWSplQ67qk4hd7hEqw2CQKPiAbWhajg4DyeJ02PGOGEexNvNGWeYeP8JkXD5LeuJP9tqV2y5/gwsCmBzE306UiE0qXyZMAMkiVUXoAxryhGWFgrXTXpFuyoflcbUjAD+pN4DdBVJPOYONT8sSrJxpQd/HbJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=teNq9ell; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="teNq9ell"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m+AGDKIE6hXp/8VOqIEg9/kQz3a6B7IfLZxRpsrZlLc=; b=teNq9ellKTdTiEw8CgadARx2XH
	LPBtCpFWtUVYzLAmUgMCs4SmnqQc7YNIefAvYFRu5CGx19swkhzNA/48Aivr3cwoA6P1sc8VE+znz
	K5GtiT5Gonw50+RiI7T69ZiWLfl4Tf8G0TTk+RNvgvwos2uZ+CbTxdrUFTUgHyjr3yl/wibf+xeWt
	qQTS4YUO5fxyWD0m9NYuLrYrAjmI/LNa4kupmAE4+yJmwX01LIMU5d4TijOf2heQkz5M6uQ6tpBRt
	FhBJceHidowKp3TUDdo4O2+bAeej0Xx6kiKGdcoz0dhNc5/3xMe30Fa4GlWxfIwzFbT8XyozdIOju
	TRYUjfHw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0b52-0000000B1Mc-2b9j;
	Thu, 12 Mar 2026 08:07:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 288A9301150; Thu, 12 Mar 2026 09:07:40 +0100 (CET)
Date: Thu, 12 Mar 2026 09:07:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Jens Remus <jremus@linux.ibm.com>, Juergen Gross <jgross@suse.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	David Kaplan <david.kaplan@amd.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	James Morse <james.morse@arm.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] static_call: use CFI-compliant return0 stubs
Message-ID: <20260312080740.GC606826@noisy.programming.kicks-ass.net>
References: <20260309223156.GA73501@google.com>
 <20260311225822.1565895-1-cmllamas@google.com>
 <20260311231406.GZ606826@noisy.programming.kicks-ass.net>
 <abIFwSF1RqhC96C2@google.com>
 <742d77a8-3c53-4814-9dd6-81e8317cd829@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <742d77a8-3c53-4814-9dd6-81e8317cd829@app.fastmail.com>

On Thu, Mar 12, 2026 at 08:40:11AM +0100, Ard Biesheuvel wrote:
> So far, we have managed to avoid the blessings of objtool on arm64,
> and the complexity associated with the inline patching is not really
> justified, given that on arm64, there is not really a need to avoid
> indirect calls (and as Peter says, we might end up with them anyway)
> 
> A while ago, I had a stab at implementing the out-of-line variety [0],
> but nobody cared enough to even respond. It is rather concise, and
> localised to arm64, so it is something we might consider for
> CONFIG_CFI builds. It is essentially the same sequence that arm64 uses
> for trampolines between modules and the kernel if they are out of
> direct branching range, with some .rodata patching to change the
> target. (arm64 basically only permits code patching without stopping
> the machine when it involves patching branch opcodes into NOPS or vice
> versa).
> 
> Doing so for only CONFIG_CFI makes sense because it removes the CFI
> overhead for all static calls, although it adds back some overhead for
> the trampoline. But there is currently no need to do this
> unconditionally.

Right, so your v3 is very simple and straight forward, and should work
as an end run around the CFI issue, by effectively doing that indirect
tail call in the trampoline outside of the compiler generated software
cfi things.

And I think I like your thing better because it handles all possible
cases, not just the ret0 oddity and isn't in fact much larger.
