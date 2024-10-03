Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C915E86;
	Thu,  3 Oct 2024 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727923025; cv=none; b=rXxGrdLn48k2vl3qMllLJwFsY0zwZTpHqztNbLVED5ZJ46nweZQPKSj4pCwSwHWI4An2L0DZsakIhfcNnEG/Vv7OjWpYj+EFW2qBuIh8hfEwf5/WbP+a2x7gp+oiM+WMYz9F1+pX8E90pf1B6ZHw6O2QSxLM184P18cfIi0hpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727923025; c=relaxed/simple;
	bh=GkfnGe2cK7EV3mLR2o+TRSDtxXNQyNtZCKEmUSyyFDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNFeWnLctgrcji8ABo7//Iit7xTszLWX9aWtLztE4HhEwHWPjzVq85iE82OWJ8mIzCnE9wtxd+dy3QtRaqRedAeeIyyjXAr6hSOpg+x/yvjTski2NzQeFrcHZQeyQKL5YgM8gGZJcvuzyqJs5HXIsfqLpm5NmTxdeKgemIyrWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1RV7HF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1RV7HF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D397C4CEC2;
	Thu,  3 Oct 2024 02:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727923024;
	bh=GkfnGe2cK7EV3mLR2o+TRSDtxXNQyNtZCKEmUSyyFDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1RV7HF3loobpYs2oMqmMEFzvZlebbfX34ENPBf7Xo5ExY5Cu/jteXsHilSuyJEWi
	 WI7ORlZqoG1b1dZ4TPtv3aCNiFuQ8rgjkdP2idzjD2bZqV0e5Cx+K3PiOl8goMG0fh
	 2nURw2Y4/PFGUlpxa+uwM7lxUFeNz2fYWsi5V0tlZTAK8xQP7brEDVrlUoFDVOL6N9
	 Q0HUFc/yrsFmTAKZG15uM2i9ZwEhs9V3g3YVETRiFFzwHsnSa1K15TuarwqIKufFpD
	 R1RnvTfaYQ9/xRnoOwUD3/52To/3vXVSTfsHuE51mCLw+CB6quy9s4kSkcvvnTkNG+
	 5KaCKhX0rEN9Q==
Date: Wed, 2 Oct 2024 19:37:02 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
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
	Sam James <sam@gentoo.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20241003023702.4bam6cj5opcz24em@treble>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
 <20240915111111.taq3sb5xzqamhb7f@treble>
 <20240916140856.GB4723@noisy.programming.kicks-ass.net>
 <20240916153953.7fq5fmch5uqg7tjj@treble>
 <20241002223125.2d610510@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002223125.2d610510@gandalf.local.home>

On Wed, Oct 02, 2024 at 10:31:25PM -0400, Steven Rostedt wrote:
> +++ b/kernel/unwind/user.c
> @@ -177,7 +181,8 @@ int unwind_user_deferred(struct unwind_callback *callback, u64 *ctx_cookie)
>  
>  		cookie = __this_cpu_read(ctx_ctr);
>  		cookie &= ((1UL << 48) - 1);
> -		cookie |= ((cpu << 48) + 1);
> +		cookie |= cpu << 48;
> +		cookie++;
>  		__this_cpu_write(ctx_ctr, cookie);
>  
>  		current->unwind_ctx_cookie = cookie;
> 
> As the cookie never got incremented.

Ha, that might help ;-)

> That was just one issue. Things are still not working but I'll debug the
> rest later.

If you don't want to run on the bleeding edge, I'll be testing it soon
myself once I get the coding done for my v3.

-- 
Josh
