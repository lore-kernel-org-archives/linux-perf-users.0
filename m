Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732212D766;
	Wed, 12 Jun 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234613; cv=none; b=fV/9wSFQFQkYYRKFQ31JOSVZa+MaUYA/qSWb1MGhvlLrbukS+MExpZ11t5T6ikcjG2b9J5uoJ2K4bvMaDK/yKKC22wxB9w+7d7hNsSFjqR636fjsoSf5vHoohop4pHnRTNysDCbdGcaHeigC3dPW80jYK4oF01n+TDxaUH+7HDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234613; c=relaxed/simple;
	bh=osO3snio/Biz5ce4MVIPMmlqg+lPXsWqRxu6r/Yyymw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhk9PGwb5fIxLdMkdD8AprQHgNwHcgUGQ6CAh7FqLlY0NFfHYVGq3z5fTlUmrC/7VmsCsbEcT74CXi+1DE/fVv5GJjf+zMPaGyIoUSytXBl0hC26Yernp3UQsZEMiNph7JvLUOGsunvTr7yM4Ts8mL9iox4O7Jk98z47W9xNmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmewgSg0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmewgSg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D63AC116B1;
	Wed, 12 Jun 2024 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718234612;
	bh=osO3snio/Biz5ce4MVIPMmlqg+lPXsWqRxu6r/Yyymw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmewgSg0pq7QujPTIHRe74qBY+8RJaYeSdQHcsSP9Kc8LrJVFB4Jtw8p9gNII/uix
	 zGYR33D3z6eWobQ+5cW99F+yIIoeVC3eQXR8ryOPZzB21Dfi1M5G5COp914wDR3Hk9
	 A7qQO0Gk2HPh/FzVL1Xlko4CAXc7vLW4uAYJLCHuCQLaB/Wp7vWE93HD+d66hFgljD
	 oj+S+47+c5UO93bGqOYcIIVnHM4pJQwlNecfW1Y1Gs5bHw1ZdouDpsTcmeYxm3Rbw0
	 nylKNCRkhAVS1vK0TTNd7CEsyu6gkL1IdkHfdwMsXu6pmEKJqs1EYfZVKuxhjHiROp
	 JRHS3lJLPeBiQ==
Date: Wed, 12 Jun 2024 16:23:31 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <202406121530.D9DB956C8@keescook>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
 <202406121148.688240B@keescook>
 <20240612220821.GA18881@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612220821.GA18881@noisy.programming.kicks-ass.net>

On Thu, Jun 13, 2024 at 12:08:21AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 12, 2024 at 12:01:19PM -0700, Kees Cook wrote:
> > I'm happy to take patches. And for this bikeshed, this would be better
> > named under the size_*() helpers which are trying to keep size_t
> > calculations from overflowing (by saturating). i.e.:
> > 
> > 	size_add_mult(sizeof(*p), sizeof(*p->member), num)
> 
> Fine I suppose, but what if we want something not size_t? Are we waiting
> for the type system extension?

Because of C's implicit promotion/truncation, we can't do anything
sanely with return values of arbitrary type size; we have to capture the
lvalue type somehow so the checking can happen without C doing silent
garbage.

> The saturating thing is relying in the allocators never granting INT_MAX
> (or whatever size_t actually is) bytes?

The max of size_t is ULONG_MAX, but yes, most of the allocators will
refuse >INT_MAX, but I think vmalloc() is higher, but certainly not
SIZE_MAX, which is the entire virtual memory space. ;)

The saturating thing is two-fold: that we never wrap around SIZE_MAX,
and that the allocator will refuse a SIZE_MAX allocation.

> > LOL. It's basically doing compile-time (__builtin_object_size) and
> > run-time (__builtin_dynamic_object_size) bounds checking on destination
> > (and source) object sizes, mainly driven by the mentioned builtins:
> > https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html
> 
> Right, I got that far. I also read most of:
> 
>   https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safety/70854

Oh wow, that's serious extra credit. :) It'll also probably be a while
before most of that stuff is even landed in Clang, much less implemented
in GCC. What we _do_ have is the "counted_by" attribute. This was added
to Clang a little while ago and just landed last week in GCC for GCC 15.

> But none of that is showing me generated asm for the various cases. As
> such, I don't consider myself informed enough.

Gotcha. For the compile-time stuff it's all just looking at
known-at-compile-time sizes. So for something like this, we get a
__compiletime_warning() emitted:

	const char src[] = "Hello there";
	char dst[10];

	strscpy(dst, src); /* Compiler yells since src is bigger than dst. */

For run-time checks it's basically just using the regular WARN()
infrastructure with __builtin_dynamic_object_size(). Here's a simplified
userspace example with assert():

https://godbolt.org/z/zMrKnMxn5

The kernel's FORTIFY_SOURCE is much more complex in how it does the
checking, how it does the reporting (for helping people figure out what's
gone weird), etc.

> > Anyway! What about the patch that takes the 2 allocations down to 1?
> > That seems like an obvious improvement.
> 
> Separate it from the struct_size() nonsense and Cc the author of that
> code (Sandipan IIRC) and I might just apply it.

Okay, thanks!

-Kees

-- 
Kees Cook
