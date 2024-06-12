Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518F1C14;
	Wed, 12 Jun 2024 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218881; cv=none; b=OgloCB6/PQiZrC9Z9s7FY6I2hj7pGXFtPel18tKFEvid0rjk+84hyQEDku9ExAHUUqhuEMaoBRApWEoOKDzAGEuzVmo1MH4MpFBrTXmD5QwoEMhZkJCglgaMJ/Xzq0iA4xecpdjegf3BkOc6XquCACmwDeenRQp8I0dQr1T/4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218881; c=relaxed/simple;
	bh=24sykyomd1DMS8CZmtVl5X0WUSlfSVk5IR5O6L64EoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIvAuzzUqCZgnG1rE0FV3wHm/UW914W4YrBCqMbQSfnHOP/VnbcMKusmaLgPMCd6yW9ZIM+v6za0O7pKSDO+Ta+mAjT0jGQNLJ2I5iynvPMZRUrMCyJHyqB0tKck3h6w3E5glMZiy/1yN1/COOlYyBeCA2vMmRbaCrb9uC7mISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qESI8kaU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qESI8kaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6C6C116B1;
	Wed, 12 Jun 2024 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718218880;
	bh=24sykyomd1DMS8CZmtVl5X0WUSlfSVk5IR5O6L64EoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qESI8kaUn2eW+OIofh/MkBZmyVOjII6A94ZLEt/vq7eux00o+d5H/pQi7ZOlWQI+x
	 KgpTLGT0cB1UL4o//+Sq251Q0H7d8UJJeMXybHoMPV/J5CxCbOWj8iJZnCPAQaWkS6
	 Lgb0yUNc+4GtyaeJuZi3m2ouyxu1pEALc2P3A2L5QP+Ec6q/zcjMbgxIvPwVontK3T
	 9HiYoye3gVBniJTa4m3lDRradk4cUdQfJCNWSV1NM7X3UApBlK4zlblZI8rO0XdGrJ
	 y0FMd0D7wOrE4gi1Ngok9BWl92HvuH7m+s7l/DtcRZeH2+GmLzRsz8vKJmGSzOWzCp
	 QtyDcPv1IOLbw==
Date: Wed, 12 Jun 2024 12:01:19 -0700
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
Message-ID: <202406121148.688240B@keescook>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611075542.GD8774@noisy.programming.kicks-ass.net>

On Tue, Jun 11, 2024 at 09:55:42AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 10, 2024 at 02:46:09PM -0700, Kees Cook wrote:
> 
> > > I really detest this thing because it makes what was trivially readable
> > > into something opaque. Get me that type qualifier that traps on overflow
> > > and write plain C. All this __builtin_overflow garbage is just that,
> > > unreadable nonsense.
> > 
> > It's more readable than container_of(), 
> 
> Yeah, no. container_of() is absolutely trivial and very readable.
> container_of_const() a lot less so.

I mean, we have complex macros in the kernel. This isn't uncommon. Look
at cleanup.h. ;)

But that's why we write kern-doc:

 * struct_size() - Calculate size of structure with trailing flexible
 * array.
 * @p: Pointer to the structure.
 * @member: Name of the array member.
 * @count: Number of elements in the array.

> #define struct_size(p, member, num) \
> 	mult_add_no_overflow(num, sizeof(p->member), sizeof(*p))
> 
> would be *FAR* more readable. And then I still think struct_size() is
> less readable than its expansion. ]]

I'm happy to take patches. And for this bikeshed, this would be better
named under the size_*() helpers which are trying to keep size_t
calculations from overflowing (by saturating). i.e.:

	size_add_mult(sizeof(*p), sizeof(*p->member), num)

Generalized overflow handing (check_add/sub/mul_overflow()) helpers
already exist and requires a destination variable to determine type
sizes. It is not safe to allow C semantics to perform
promotion/truncation, so we have to be explicit.

> Some day I'll have to look at this FORTIFY_SOURCE and see what it
> actually does I suppose :/

LOL. It's basically doing compile-time (__builtin_object_size) and
run-time (__builtin_dynamic_object_size) bounds checking on destination
(and source) object sizes, mainly driven by the mentioned builtins:
https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html

> I coulnd't quickly find a single instance in the code I care about. So
> nothing is sailing afaict.

I have to care about all of Linux's code. :P We generally don't have to
defend the kernel from perf, so the hardening changes tend to end up in
core APIs along with compiler improvements.

Anyway! What about the patch that takes the 2 allocations down to 1?
That seems like an obvious improvement.

-Kees

-- 
Kees Cook
