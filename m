Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7271145FEF;
	Mon, 10 Jun 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040533; cv=none; b=aohNyqK1Xy37WfTp00oCeRsml1JLSme8FiGO5XBDBjfOYcAsUQZStPJIrPDhL2T02zJtN5d+ED8EXyxGPPq2QDk2d6QjUpO9a4Zt09ehNEK0EC7hRoyadSFANzixoBtY/A1pi/cc/blfiZwMjyHvPtOI5V9ql1idTJazEBwWBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040533; c=relaxed/simple;
	bh=hsXdp2QwbthzBhOSFd6YbbgLNTqyXSDvwcDh62NNNiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNpc9Vhw66yefjY3JIvi0ZZ5Q3xqfmTSvDagfbYrAFQVXC/utjgbhH54e0Jckhg1qa0Ev7uqIzK9lSBxmwMZk/1pAsosZJl6w4tMC52WivIwr8LxU/2hY6RBMnTmBJQCrP5TTPNFDxpfaIOG4y8owxz46XQWeiCz/TmADJSZPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNpdFrgy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNpdFrgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D87C2BBFC;
	Mon, 10 Jun 2024 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718040533;
	bh=hsXdp2QwbthzBhOSFd6YbbgLNTqyXSDvwcDh62NNNiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNpdFrgy5Zza1DDVY23kZJNbw/0JA56+1KNloDqPZnNNfPbTnlj+hn4pOK4Czyakl
	 /mOUHYorQi9awPhEnKK70KmfiZViAMbYcH7p/uuDpVqq+RsHyylTJp1EIZDPGb4n7M
	 L2UZeq/Vv0BDdJwq9PsThFKWQX7c9U0hzvbtX8AoIMUEMKXqHuyfx82Ltmhb2ql5Qw
	 rwP7azFkzipdwQanc/NhpRb7JaqUFsQhRjsVZiYPXxzQoRmJZFC732CmFuKeuubuI5
	 zdBKP4p1y+1aWACQ75TI5Ta2ITCt4yWds0rtsqyvm+HYlZedAG8K5ODb1zqGI6Z5hy
	 MY6Yi5AEWDmng==
Date: Mon, 10 Jun 2024 10:28:52 -0700
From: Kees Cook <kees@kernel.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <202406101010.E1C77AE9D@keescook>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, Jun 01, 2024 at 06:56:15PM +0200, Erick Archer wrote:
> Hi everyone,
> 
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].

I didn't actually see these 3 patches in this thread nor via lore.

> In the first patch, the "struct amd_uncore_ctx" can be refactored to
> use a flex array for the "events" member. This way, the allocation/
> freeing of the memory can be simplified. Then, the struct_size()
> helper can be used to do the arithmetic calculation for the memory
> to be allocated.

I like this patch because it reduces the allocation from 2 to 1. This
isn't what Peter might see as "churn": this is an improvement in resource
utilization.

I think it's here:
https://lore.kernel.org/linux-hardening/AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com/

> In the second patch, as the "struct intel_uncore_box" ends in a
> flexible array, the preferred way in the kernel is to use the
> struct_size() helper to do the arithmetic instead of the calculation
> "size + count * size" in the kzalloc_node() function.

This is
https://lore.kernel.org/linux-hardening/AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com/

I prefer this style, as it makes things unambiguous ("this will never
wrap around") without having to check the associated types and doesn't make
the resulting binary code different in the "can never overflow" case.

In this particular case:

int size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);

"int numshared" comes from struct intel_uncore_type::num_shared_regs,
which is:

        unsigned num_shared_regs:8;

And the struct sizes are:

$ pahole -C intel_uncore_box gcc-boot/vmlinux | grep size:
        /* size: 488, cachelines: 8, members: 19 */
$ pahole -C intel_uncore_extra_reg gcc-boot/vmlinux | grep size:
        /* size: 96, cachelines: 2, members: 5 */

So we have:

s32 size = 488 + u8 * 96

Max size here is 24968 so it can never overflow an s32, so I can see
why Peter views this as "churn".

I still think the patch is a coding style improvement, but okay.

> In the third patch, as the "struct perf_buffer" also ends in a
> flexible array, the preferred way in the kernel is to use the
> struct_size() helper to do the arithmetic instead of the calculation
> "size + count * size" in the kzalloc_node() functions. At the same
> time, prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute.

This is
https://lore.kernel.org/linux-hardening/AS8PR02MB72379B4807F3951A1B926BA58BE02@AS8PR02MB7237.eurprd02.prod.outlook.com/

This provides __counted_by coverage, and I think this is important to
gain in ever place we can. Given that this is part of a ring buffer
implementation that is arbitrarily sized, this is exactly the kind of
place I'd like to see __counted_by used. This is a runtime robustness
improvement, so I don't see this a "churn" at all.


Peter, for patches 1 and 3, if you'd prefer not to carry them, I could
put them in the hardening tree to keep them out of your way. It seems
clear you don't want patch 2 at all.

-Kees

-- 
Kees Cook
