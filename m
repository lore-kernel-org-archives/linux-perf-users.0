Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66441371065;
	Wed, 11 Mar 2026 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270886; cv=none; b=Y/QIkjly2stTkkF18VCqmcdFC6jdvnm1Kze4KqiQrvrrxjhOH7FoWSq+b9yHa+53lS8JlLyU7e2JAW90FImLC+obEcroE923FO73YvNXF5p8iGkOwt21JR3bGewYpN5eKe2TsfSMumYpxtECJbDKQwfYy86ctt6KBU6w90ABWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270886; c=relaxed/simple;
	bh=NVgUS1So8HdI8OyVagR+CBKuJke/Faip4sa1fvT5/bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEZs7uiIA0XIU5ALjLuzMmE+S9EhSYqUd2L60YUQ5xydg7Vxac7AaCopqNAv4zDQQgyS2G3XJuzG56shCH9ttRsD3/Q9cMCq3CRgmlJ2jcX2mo4hL1+7IrDetfOuWZ8YK0j0Se0P2Pl8ZuXy1a88gxrovPNilgnGn6iWoy5jiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UfpF0uo0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UfpF0uo0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eVXn+Bxh0tcCavT748ERcPpFO7MJkNREEPJ3NP1c5Qg=; b=UfpF0uo0FDgd7R0MDjKkcRKS7U
	cdQhSBvIrBkvZ7epa1i/Av2klUvrcaXeRJ10syoBuITEGN8rgFnxXrwtKA8y4f2FsOUZH2/KldYls
	Ddwye10mIBnhxYaC+US4Mc5xlsA7aCPM8flPYoxAvfVlgbns7R0wGM9U//5bjPN3yKA6H3HqpIUeA
	G9olTQ1p9+h5su/n5Qc9gMiGqYmMSmuf2HCJTyhye0HX0xwlIi+LddV+oivZa8Ti8jy9rOnOemlsJ
	5J7Q1DgOhij7XsHdLEmSGzFFKGLCl4uF2LXIDiW3kZq/chpZlUtM6BwVOMTnHQT2zRdb2abYL+4Uq
	uxoL5nxw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Skh-0000000ARqF-2AyW;
	Wed, 11 Mar 2026 23:14:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F0C0C301150; Thu, 12 Mar 2026 00:14:06 +0100 (CET)
Date: Thu, 12 Mar 2026 00:14:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
	"Borislav Petkov (AMD)" <bp@alien8.de>,
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
Message-ID: <20260311231406.GZ606826@noisy.programming.kicks-ass.net>
References: <20260309223156.GA73501@google.com>
 <20260311225822.1565895-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311225822.1565895-1-cmllamas@google.com>

On Wed, Mar 11, 2026 at 10:57:40PM +0000, Carlos Llamas wrote:
> Architectures with !HAVE_STATIC_CALL (such as arm64) rely on the generic
> static_call implementation via indirect calls. In particular, users of
> DEFINE_STATIC_CALL_RET0, default to the generic __static_call_return0
> stub to optimize the unset path.
> 
> However, __static_call_return0 has a fixed signature of "long (*)(void)"
> which may not match the expected prototype at callsites. This triggers
> CFI failures when CONFIG_CFI is enabled. A trivial linux-perf command
> does it:

*sigh*...

And ARM64 can't really do the inline thing because its immediate range
is too small and it all turns into a mess constructing the address in a
register and doing an indirect call anyway, right?


I'll stare at it in more detail tomorrow.
