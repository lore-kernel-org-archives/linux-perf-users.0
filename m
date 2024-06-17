Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB816EB46;
	Mon, 17 Jun 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645301; cv=none; b=DBlvdGVlJhNx64lhud1jhxnbIveC9YXEemlHU2XVUe31k9Y0qtoESLFAWdLtS2k4HY4w+DZdLQ+2ERNSDwxE9sfGZJzQSnrY10Zyuhg8yuk95ttC5DJ4es02M4mhFBjoqQTCA0hxSmaNGbRSKTeBb8eJOIrjlHtmShraa1Oqozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645301; c=relaxed/simple;
	bh=IKOgUg4zcXbjo67A/2GMnXl420R2v0GOkOcdt+ti4qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X36TayuttHMZJmxb+08acPy1F8mjOj30GYIjxVNsRPKd18Er9JofvZU0UNidUuR3gl/I3Sxv7mwl85vTztcLx8k4agokjcUE0PvD030xgh5NM5F2FEYHu8le38b4bW+LTUTk4BPjGjphkoWoCBCW0ws7t3XiSJjk68xwtOcZbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq4HRtmo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq4HRtmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBF1C2BD10;
	Mon, 17 Jun 2024 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718645300;
	bh=IKOgUg4zcXbjo67A/2GMnXl420R2v0GOkOcdt+ti4qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq4HRtmoGBMHKg/cKbDuz2yF6q/Of50DlqO7vDUFbUAmC5vw0cWehniCmMqfcgDCc
	 QMc1ug1du8PzBgxDRsKPZ7klIIxhDQdzjPclopll1O7H0Rn7ODrXo/eI375SZsZPGq
	 5wmvUt81CpOfZ65JP+lTjGp1BEXeeGS7QX/o8Z+Hd+8ZokK4BuhRKOfw8QVefttCSA
	 /kH0sUuxHmGqdkIyBB6pH/kZ/aok5Kv/0FHl2aD9dwcRpXZDpGxYPd123NH/o5TeUi
	 rWindJ+tuyTQSnyJh4XvCKJuGdJHohpOrEk2AYy68kDb7rTXwMOqU+40PuuaNPSP9t
	 DW02Pvk7AE5ZQ==
Date: Mon, 17 Jun 2024 10:28:20 -0700
From: Kees Cook <kees@kernel.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <202406171019.9F0127F@keescook>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
 <202406121148.688240B@keescook>
 <20240612220821.GA18881@noisy.programming.kicks-ass.net>
 <202406121530.D9DB956C8@keescook>
 <20240614101708.GO8774@noisy.programming.kicks-ass.net>
 <c8234b8e2c9c1122eec73c97901e36586160f0cb.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8234b8e2c9c1122eec73c97901e36586160f0cb.camel@tugraz.at>

On Sat, Jun 15, 2024 at 06:09:07PM +0200, Martin Uecker wrote:
> Am Freitag, dem 14.06.2024 um 12:17 +0200 schrieb Peter Zijlstra:
> > On Wed, Jun 12, 2024 at 04:23:31PM -0700, Kees Cook wrote:
> > > On Thu, Jun 13, 2024 at 12:08:21AM +0200, Peter Zijlstra wrote:
> > > > On Wed, Jun 12, 2024 at 12:01:19PM -0700, Kees Cook wrote:
> > > > > I'm happy to take patches. And for this bikeshed, this would be better
> > > > > named under the size_*() helpers which are trying to keep size_t
> > > > > calculations from overflowing (by saturating). i.e.:
> > > > > 
> > > > > 	size_add_mult(sizeof(*p), sizeof(*p->member), num)
> > > > 
> > > > Fine I suppose, but what if we want something not size_t? Are we waiting
> > > > for the type system extension?
> > > 
> > > Because of C's implicit promotion/truncation, we can't do anything
> > > sanely with return values of arbitrary type size; we have to capture the
> > > lvalue type somehow so the checking can happen without C doing silent
> > > garbage.
> 
> What is the specific problem here?

This particular complaint is about not being able to "discover" the
lvalue type during an assignment, which means we can't create helper
macros that Just Work. For example, in:

	void foo(some_type arg);

	foo(add_mul(base, size, count));

There is no way to write "add_mul" so that it is checking for overflow
of the "some_type" type. The behavior of such a macro changes if it's
doing u8, int, size_t, etc.

The existing solution to this is to use macros (and builtins) that
cannot be composed:

	add_mul(base, size, count, &result);
	foo(result);

Here, the macro can examine the type of "result" and perform the correct
overflow handling for that type. But lots of developers (rightly)
dislike this style of "assignment side-effect".

Additionally, it can't be composed:

	add(base, mul(size, count));

But, using type attributes we have much more flexibility. Hence, the
proposed "wraps" attribute:
https://github.com/llvm/llvm-project/pull/86618

> This is likely a stupid question, but making it signed 
> wouldn't work?   Or is a signed size_t too small  
> or some architectures? Or would this change break too much?

The ssize_t gets used in some places already, but since size_t is used
for address calculations too, I don't think we can universally switch
it.

-- 
Kees Cook
