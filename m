Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0F1B5819;
	Thu, 20 Jun 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908014; cv=none; b=u3yEJpakyXym3dOOlQMA5mon9aVoMYPQ3pNCaYN5v1DKKSOGlx4Q2FekyzJTTAMPSsHD612JLPC/YQGYhw2IIO7wHg9HSNVAqQz/FpSf/fh05Vr5/PD1jOG1ONpQaPpxMEdwweSf1ZRavmY77NKjaKLnt0YAWkjOOWya4fn+G9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908014; c=relaxed/simple;
	bh=LYqT1Uu1OecCU2BJJQ+Io08qzbyYl4zJUIcAQBPlWbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGsscAJIZ9oVFZERLY1GPSRGl3sZhBt811498urNLAxcdldypWk2wh1DXOzxaCh+g6kAcMyXXGEV8jA2tUzC/GmpL2rwZna59SpU2ZjkWFDg99MRJWBAD3+4YGe1Wmb+LahdltWsfNJL9hq8BiV/zBryZuNizjwABVwCEtSAriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g49SGkRN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g49SGkRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A53C4AF19;
	Thu, 20 Jun 2024 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718908013;
	bh=LYqT1Uu1OecCU2BJJQ+Io08qzbyYl4zJUIcAQBPlWbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g49SGkRN8S2Mavl5RmCW9iL6JIMmlqPrDdntU8UCFVwhWkThAc4SMvqtMJTwPd+PT
	 EOCOpfq+PKwzRJcCV5f61H10I75SKvULhS1vpydKnaI5RqC/WqJtlQNUj3ncCAX0A3
	 vYEyL/JSYCmoaByhW1MRhwnvrJz297pQiz1TdTH3bR3jXmAo2YQsA+BPVP7zTr/iyg
	 qW80cv3MIXoZahNSP11DW9rJkXZRopSfKhKZUagLlOuvyj6G+R3GqLp9ooQ/iitMOG
	 q8VyLLI4n5Oh/Zr8qdoeooQkaQt+d32NAGMSRmDLSdELiAGOwm756dTyyJhR6QB+5U
	 9+uYD4vgdDngg==
Date: Thu, 20 Jun 2024 11:26:52 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Martin Uecker <uecker@tugraz.at>,
	Erick Archer <erick.archer@outlook.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthew Wilcox <mawilcox@microsoft.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 0/3] Hardening perf subsystem
Message-ID: <202406201120.C1629ACFE@keescook>
References: <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
 <202406121148.688240B@keescook>
 <20240612220821.GA18881@noisy.programming.kicks-ass.net>
 <202406121530.D9DB956C8@keescook>
 <20240614101708.GO8774@noisy.programming.kicks-ass.net>
 <c8234b8e2c9c1122eec73c97901e36586160f0cb.camel@tugraz.at>
 <202406171019.9F0127F@keescook>
 <20240618082242.GC31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618082242.GC31592@noisy.programming.kicks-ass.net>

On Tue, Jun 18, 2024 at 10:22:42AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 17, 2024 at 10:28:20AM -0700, Kees Cook wrote:
> 
> > But, using type attributes we have much more flexibility. Hence, the
> > proposed "wraps" attribute:
> > https://github.com/llvm/llvm-project/pull/86618
> 
> So I still think that's going about things backwards.
> 
> unsigned explicitly wraps. signed is UB.
> 
> When using -fwrapv signed is well defined as 2s complement, which takes
> away the UB and makes it implicitly wrap.
> 
> When extending the language, it is important to not break existing code,
> so the default must remain wrap. This in turn means you need to add a
> 'nowrap' thingy.

Well, we still disagree about this, but I guess we'll see how the size_t
work comes along. Maybe I will come to agree with you. :)

> Also, I would very much not make this an attribute, but a full type
> qualifier. Furthermore, add type promotion rules to ensure nowrap takes
> precedence and is preserved throughout expressions. Such that:
> 
>   'long' + 'nowrap int' -> 'nowrap long'
> 
> Then, once you have this, you can go do things like:
> 
> typedef nowrap unsigned long size_t;
> #define sizeof(x) ((size_t)sizeof(x))
> 
> and things will just work. Hmm?

Right. Currently this is being plumbed through the sanitizers, so the
type selection will happen there (for this version of it). The current
experiment is to basically tell the sanitizers to ignore all types
except a given list, and our initial list will be just size_t.

Before this, Justin is finishing up the initial set of idiom exclusions.
.e.g.:

	size_t var, offset;
	...
	if (var + offset < var) { ... }

This will not freak out if "var + offset" wraps.


And "negative unsigned constants" will be ignored:

	#define MASK	-2ULL
	...
	size_t mask = MASK;


And loop post decrements wrapping will get ignored too:

	size_t count = ...;
	...
	while (count--) { ... }


After we get it all nailed down, we'll see if anything new pops up. :)

-- 
Kees Cook
