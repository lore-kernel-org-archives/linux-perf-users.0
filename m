Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65545FBF6;
	Fri, 24 Jan 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737598; cv=none; b=JP++GEXFJpOUw9w+G03t/lUIFuBSxtAubr4LDvfqat1jrTBBO0/Or52NFzwZpeZOu9od14nu+aoit4CYenhLEUYcJaII9/9wpILiEVVIBF8YZZ9EwzlraACNAgzBSxlIxq/rYi3RR2TXdS5RQmwYWvK/1yJEdeUFpELIwlGOMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737598; c=relaxed/simple;
	bh=qPIOFO8bGBTpcv1DPcqFGcSO5s4HmGRpDM85BVyuP/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt6Uba7Yos1ofBGmUqpSiDplW2ASVc5jJ6iIVV2KWrGVL96v6r3sS5C29jQ3GOjya2r8XPPUC5xSTD2N0Zznaz7hcJfA41JNrqRWlO+GxkWHh/4i6y4oSWquyVS+KC0YaZCQtFuauVPFr95uWnB04jfebELjmvBOgvbNN0fiXUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/eK8ohY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/eK8ohY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A51C4CED2;
	Fri, 24 Jan 2025 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737737595;
	bh=qPIOFO8bGBTpcv1DPcqFGcSO5s4HmGRpDM85BVyuP/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/eK8ohYjDpCLLf1GgkezqxYbPa2x2gEjJvuKsnTR561Cmch60BijnsvWwwpuhnBa
	 EECeD16eRvYhJWkoIhhbTK6axd/MKH0hvDLIECk99IC5/2tq7zJVNGVhNie6GhJfr/
	 Zd7a6EnjXBauCgN8BTPZ7SLrKFikzNa4qkq8PlJEQaf4EBs0+5XOO7sOItUMbZh/Tu
	 ZkztVhJw9KZET03TTJQ8a1+ytbRTsi+1HV34OCDVbUpIHRxKNSSiGE+ItM/iKx8B+g
	 fDDgk8HtY940+aXLxEw5PRzj3jMABI7HJv0kgC0CqEdwdiZ2B3bKDo/YJdmc/fvUzV
	 5ASMzoQT89rjA==
Date: Fri, 24 Jan 2025 08:53:13 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 09/39] x86/vdso: Enable sframe generation in VDSO
Message-ID: <20250124165313.aejzzy5c5siqbnfq@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <c93fbd53f01c2c86f747af27040ac11f16dee032.1737511963.git.jpoimboe@kernel.org>
 <cde90a82-6bdd-4a12-872a-7b39edf3eac8@linux.ibm.com>
 <20250124164332.gqgzimfix3vk4bsw@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124164332.gqgzimfix3vk4bsw@jpoimboe>

On Fri, Jan 24, 2025 at 08:43:35AM -0800, Josh Poimboeuf wrote:
> On Fri, Jan 24, 2025 at 05:00:27PM +0100, Jens Remus wrote:
> > On 22.01.2025 03:31, Josh Poimboeuf wrote:
> > > +#ifdef __x86_64__
> > 
> > #if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
> > 
> > AFAIK the kernel has a minimum binutils requirement of 2.25 [1]
> > and assembler option "--gsframe" as well as directive
> > ".cfi_sections .sframe" were introduced with 2.40.
> 
> True, I'll change it to just '#ifdef CONFIG_AS_SFRAME' since that's what
> really matters (and 32-bit doesn't support it anyway).

Actually, just CONFIG_AS_CFAME didn't work as 64-bit still compiles some
32-bit asm files.  I'll go with your suggestion.

-- 
Josh
