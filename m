Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB38246335;
	Wed, 11 Dec 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939312; cv=none; b=kdz1H/TpUg7aFOQ9Zw9hNUcokr7Hjui/wg9UBY7qss/JH55oBsGoHt4o8pGX+afD/ElXQ4l59EFOLMtWqT1Pg6TI+c1FYxwxl8N6H62Ar0zhvo4pCjxXQaFTAg1VOH7dF3JP0xOvF5w7wjaJYxsT+ALzuoktk9g/zhC2eGJtdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939312; c=relaxed/simple;
	bh=C3jdAMDUKCSbHx0c0FGHkPQ6TCnn3KZhOtYPiraikqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRxxYWXzg67pCUcJRARNqgZdH7AsWpSEXaCFHLOxMKOE00UsdaBq3hy5JWdiGGXAV7GaCYKrYRq5KMywQPRbRHyz1cYVN9eVHAz20c/iru2GNcyRMCfrYvAycHmAwJ0qJDa+hQDv8yeyytyxcqiEWXZIKyiDCIHtVzJ86nLyG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYsYsDTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYsYsDTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE44C4CED2;
	Wed, 11 Dec 2024 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733939312;
	bh=C3jdAMDUKCSbHx0c0FGHkPQ6TCnn3KZhOtYPiraikqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYsYsDTVgfkyGOmgXDtMKsXf2WJjfVCtBCzNgLdlPMyuE8SqkA6daRM+XCQqoVT1y
	 s1URlUyFSBozW59ceyK8zumRAYKvu2eNfh2ykjD/8n/xJ8Sk9P2SqNJgsyTIiM4nqb
	 Y1bUOhro157b73l3POT0Egce0MOisXWuy473s8Tp3EGIb+F5bPoXP7/T1zrx5YkjnM
	 vQA3Gvs6PG5yaf52PRmR6WrDHBgMzEik/iS94vuoENctJdwnLmdApA8SD51UrhvY0h
	 kzZYMlAKrYsozN/WClbdfGDEnZevuVy1Str++VRAwXIWbdC21YJxLpbPXrRCty0NlX
	 lUWAlGZazRGhQ==
Date: Wed, 11 Dec 2024 09:48:30 -0800
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 07/19] unwind: Add user space unwinding API
Message-ID: <20241211174830.3l3kxbjg6ctyxnqq@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <f89a9137e983902f22611e5379606062a64b2382.1730150953.git.jpoimboe@kernel.org>
 <978a9ecd-47e9-442b-8daa-aee8f3d93dbb@linux.ibm.com>
 <20241209205458.vzwkh3ubch5sx5c7@jpoimboe>
 <c74dc535-a09d-48bc-816e-7e465211fa64@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c74dc535-a09d-48bc-816e-7e465211fa64@linux.ibm.com>

On Wed, Dec 11, 2024 at 03:53:26PM +0100, Jens Remus wrote:
> On 09.12.2024 21:54, Josh Poimboeuf wrote:
> > if (cfa <= state->sp)
> > 	goto the_end;
> 
> Assuming the x86 definition of the CFA (CFA == SP at call site) this
> translates into:
> 
> if (sp <= state->sp)
> 	goto the_end;
> 
> That won't work for architectures that pass the return address in a
> register instead of on the stack, such as s390. At least in the
> topmost frame the unwound SP may be unchanged. For instance when in
> the function prologue or when in a leaf function.
> 
> One of my patches for s390 support introduces a state->first flag,
> indicating whether it is the topmost user space frame. Using that
> your check could be extended to:
> 
> if ((state->first && sp < state->sp) || (!state->first && sp <= state->sp))
> 	goto the_end;
> 
> Which could be simplified to:
> 
> if (sp <= state->sp - state->first)
> 	goto the_end;

Since my patches are x86-only, how about I leave the "sp <= state->sp"
check and then you add something like that in your patches on top?

> Btw. neither would work for architectures with an upwards-growing
> stack, such as hppa. Not sure if that needs to be considered.

I don't think that's needed until if/when sframe becomes supported for
such an arch.

-- 
Josh
