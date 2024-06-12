Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1093391;
	Wed, 12 Jun 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230231; cv=none; b=pbCmbZs619+22K4Y71sb7sS/0HDQGUllM7WUqhamFt3yBsyl7hmKyD48jrFdMlNDBW6HX4oOve4eW0AcPfWW5cD8hIzPeG7GQEq/ZeEVkbUKx9JGX04LwWOlLyLn1zNP3VJaHxwcs42PKFNNePtl5F7bWc2PNCZmlUgC0FIcsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230231; c=relaxed/simple;
	bh=bt3bBjmTxibuENDeAjA9wUy5gOZzKPk6baZegf+NdyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyvYeFT1S05wUuvF/yMXds+1B4YLMojZHa+V8wis7DIKDAo1Ez7hdtqBVtnkuOLOZrlc2cf6mx0XLViRYzWaiTP5wlm6ndma/Zy+297Lbvq5B8zOHDeS1xwdjFFp4uoo4PHeZFAjQ1TqhIcuCnO+IdcM05n6SNjJZ9kRsNxlDDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jgrN9W1Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jgrN9W1Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AFaVBKZW4nApoB1IbTkcTuuDnuMN7hTpew8VlBI1fH8=; b=jgrN9W1QQsKRfHkAcQPZP4HPh6
	nAwtS1F7uTHlvAUy/NvEJWLOlFwnjQU3TxkFJnMsf85PjKZSjKSp4DLSLryi+DiAe8arrQMB+XIFt
	/+aVFF3nC16ci5dCVbIm8KIZcwe+Zu+QGKwy4Uelh0BBEpJWQv2TTuIEiuamqc7cIQBcje1ksQcmV
	byDRyLMqXMoMT1g7N1e3RmOedTr+mnwalafQDuh0n+0nJGl0LcuJTQ9iG22Vch6nlMpFTm/J3SXpO
	RUm/t4CwRoEbn4LKM7rK7qEQzC117Z49EScE6DVmzNR1+KmOwrgilC5FTgbcLXQ2yQQWNNIdjmbJu
	pH2zHPWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHW8s-00000003A4E-17sI;
	Wed, 12 Jun 2024 22:09:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 416D7300592; Thu, 13 Jun 2024 00:08:21 +0200 (CEST)
Date: Thu, 13 Jun 2024 00:08:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20240612220821.GA18881@noisy.programming.kicks-ass.net>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
 <202406121148.688240B@keescook>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406121148.688240B@keescook>

On Wed, Jun 12, 2024 at 12:01:19PM -0700, Kees Cook wrote:
> On Tue, Jun 11, 2024 at 09:55:42AM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 10, 2024 at 02:46:09PM -0700, Kees Cook wrote:
> > 
> > > > I really detest this thing because it makes what was trivially readable
> > > > into something opaque. Get me that type qualifier that traps on overflow
> > > > and write plain C. All this __builtin_overflow garbage is just that,
> > > > unreadable nonsense.
> > > 
> > > It's more readable than container_of(), 
> > 
> > Yeah, no. container_of() is absolutely trivial and very readable.
> > container_of_const() a lot less so.
> 
> I mean, we have complex macros in the kernel. This isn't uncommon. Look
> at cleanup.h. ;)

Yeah, but in those cases the macro actually saves a lot of typing. A
mult and add is something you shouldn't be needing a macro for.
	
> But that's why we write kern-doc:

Right, but reading comments is asking for trouble. That is, I really
don't even see comments -- I have a built-in pre-processor that filters
them out. I've been burned too many times by misleading or flat out
wrong comments.

> > #define struct_size(p, member, num) \
> > 	mult_add_no_overflow(num, sizeof(p->member), sizeof(*p))
> > 
> > would be *FAR* more readable. And then I still think struct_size() is
> > less readable than its expansion. ]]
> 
> I'm happy to take patches. And for this bikeshed, this would be better
> named under the size_*() helpers which are trying to keep size_t
> calculations from overflowing (by saturating). i.e.:
> 
> 	size_add_mult(sizeof(*p), sizeof(*p->member), num)

Fine I suppose, but what if we want something not size_t? Are we waiting
for the type system extension?

Anyway, I'll take the patch with the above. That at least is readable.

The saturating thing is relying in the allocators never granting INT_MAX
(or whatever size_t actually is) bytes?

> Generalized overflow handing (check_add/sub/mul_overflow()) helpers
> already exist and requires a destination variable to determine type
> sizes. It is not safe to allow C semantics to perform
> promotion/truncation, so we have to be explicit.

Yeah, those are a sodding trainwreck, much like the
__builtin_*_overflow() garbage. Can't we simply have them trap on
overflow and do away with that most terrible calling convention?

If we want to be really fancy we can have a #UD instruction that encodes
a destination register to clear/saturate/whatever.

> > Some day I'll have to look at this FORTIFY_SOURCE and see what it
> > actually does I suppose :/
> 
> LOL. It's basically doing compile-time (__builtin_object_size) and
> run-time (__builtin_dynamic_object_size) bounds checking on destination
> (and source) object sizes, mainly driven by the mentioned builtins:
> https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html

Right, I got that far. I also read most of:

  https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safety/70854

But none of that is showing me generated asm for the various cases. As
such, I don't consider myself informed enough.

> Anyway! What about the patch that takes the 2 allocations down to 1?
> That seems like an obvious improvement.

Separate it from the struct_size() nonsense and Cc the author of that
code (Sandipan IIRC) and I might just apply it.
