Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBE1741D2;
	Thu, 23 Jan 2025 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662094; cv=none; b=Pn8+f5Luq8cs0re/Y+ehqql0hna4HrQDe+t4yIzRgScd5ixQWV0kSNdlo3xMI1g5rX55YeMz4Td5UmUoDp7S99SpZzQCzULrMnLJ1Y9SScBoKlZ/xls/QLwYcWXpfSNAbxmcQZCrS3+QA5/geuip38ZbYO3Exk5l2lXxUnh9Cr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662094; c=relaxed/simple;
	bh=/YSpLDFXDiY62kESVn9AJy4fOeTfbL5FyIDo7ugyZoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqYUS1sgtgGhy+Jmzs9E8DAHUsrk1BsMjMa2/6xg8Ah5K4jBUo6zsKG/GkMxBHmvgGvFOevh4hsmOxfS1zRU32vrfEZ+ADE4jxp2/eNP1ypt9Btc5EzeNloI9ji9n+Ki80YrQd0kOtK0RWsLhx4c4s+wzu+/IZYNk5l5I3Y8u+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvJ86tXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvJ86tXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B22C4CED3;
	Thu, 23 Jan 2025 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737662093;
	bh=/YSpLDFXDiY62kESVn9AJy4fOeTfbL5FyIDo7ugyZoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvJ86tXz2P44/RLKhQ/mY5CHqaBEpObsRrlOWNhaYXtTAt+sb6Nn6ImEI4brqcUgT
	 hzzHVET+BwZaA/7ztV9txeGBXImpRSO6Sr5edcGZgeFNBzpcMAh4KGf38BG3/bMXWy
	 7XL04Gt+EPW+mAab/zekLdHTYWUqQGqqePV8a4Vp1Kqf/0PZbcY6eZWuXYkyl4NvsH
	 UW91dY12oeGN3bsjFLql5+D1nKRtfTnn6wP9ZsVWob3Ou9o+oPmLWG4y9Qn+sTlD/c
	 nPZfiXeGfV9BWBSxheVFbMsbTMjBHRErtpVvr1QhngObWDAvv+jjSKog/sR3asAxzB
	 nrMQlS2TY2xnQ==
Date: Thu, 23 Jan 2025 11:54:51 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250123195451.f2a4jfu5tkfklwf2@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122141505.GT7145@noisy.programming.kicks-ass.net>
 <20250122224902.hhpmhi7r3azz3a4x@jpoimboe>
 <20250123084026.GF3808@noisy.programming.kicks-ass.net>
 <20250123194807.2mn54dsk2ef5i4iy@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123194807.2mn54dsk2ef5i4iy@jpoimboe>

On Thu, Jan 23, 2025 at 11:48:10AM -0800, Josh Poimboeuf wrote:
> On Thu, Jan 23, 2025 at 09:40:26AM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 22, 2025 at 02:49:02PM -0800, Josh Poimboeuf wrote:
> > > But also, the nmi_cookie is still needed for the case where the NMI
> > > arrives before info->cookie gets cleared by early entry-from-user.
> > 
> > So how about we clear cookie (and set nr_entries to -1) at
> 
> I think we could set nr_entries to 0 instead of -1?
> 
> > return-to-user, after we've done the work loop and have interrupts
> > disabled until we hit userspace.
> >
> > Any NMI that hits there will have to cause another entry anyway.
> 
> But there's a cookie mismatch:
> 
>     // return-to-user: IRQs disabled
>     <NMI>
> 	current->unwind_info.cookie = 0x1234
>     </NMI>
>     unwind_exit_to_user_mode()
> 	current->unwind_info.cookie = 0
>     IRET
> <IRQ>
>     task_work()
>         callback(@cookie=WRONG)

Though, assuming we're keeping the unwind_work struct, there's a simpler
alternative to nmi_cookie: store the cookie in the unwind_work.  Then
the task work can just use that instead of current->unwind_info.cookie.

-- 
Josh
