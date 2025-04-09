Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484329A2
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169220; cv=none; b=ZC6abXtQPlV68cwbP2MTKzkimjQmn6UX8BQYyIbcX6ZnC2fZbr/CrKFwWpmZQQF25fmi/nKG/bduF3QgTRpGyJPF0W21JRWiKvUuhmX9xI/B/VudRjYIxwpPHSQh20ItfaA5Rcz8I+MHzbDRGvc/tSaj99r/G8Jz4j3rr/bBLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169220; c=relaxed/simple;
	bh=OD2qcHA3CgnT4RHwjLNxA04gjJLiGXA57H9o3zgjb9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTBnsQqaJY+GyCAzZjt59St+Kc+vkC8QCiZoPv+pojIIArJ7fVUqCDw+1bs1c/ppA33EJqRpLi0txYhZBAyESohdlc8CMWp8pUZjjF58U030exmI2K6y3Yxp1ix1i9mtGDHSxFq06kMMZCrX/EYKc6av2W/7t/rQJYqTdjsDl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3CxhSFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3CxhSFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A6DC4CEE3;
	Wed,  9 Apr 2025 03:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744169220;
	bh=OD2qcHA3CgnT4RHwjLNxA04gjJLiGXA57H9o3zgjb9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3CxhSFfsTkCBi5WNApeIpRGfLNZayUM1ssA3UgtgswqmatVQW/KSorIyLfApK2Fk
	 Cw7ur2NwRK8Psqs2J+d3F44ABOwZ2T3JPnJ/RNpJ20XbeBeF7q9asyrDxJwXc/NCk1
	 diQNSOZXdPVARV6Zvi8OQnZ7mDEQJxsWH1L+dX8i4qT77gb3VeNftx0cNzaXy7L/UD
	 rC9QRMZWHSjedygJs6hwsY5HpHfz7754Ye5zPmBe+pVz0ihKoxPGSSbW81Kni7CRic
	 pHllDhY+b/dPMDerj2c3vkjuv+8tYCOf5jxNsLo7hCJT3bSagb3ANGTIySh19pMR4+
	 iGBx0Up0OiKvA==
Date: Wed, 9 Apr 2025 00:26:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_XpADpc9WtUdbmX@x1>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_S_JB_L_t9viciV@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_S_JB_L_t9viciV@google.com>

On Mon, Apr 07, 2025 at 11:16:04PM -0700, Namhyung Kim wrote:
> On Mon, Apr 07, 2025 at 09:54:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > A quick test here with perf top without setting the above ends up with
> > the behaviour that Ingo reported, no source code is shown and 's'
> > doesn't work. Then if I set it to use objdump:

> > root@number:~# perf config annotate.disassemblers=objdump
> > root@number:~# perf config annotate.disassemblers
> > annotate.disassemblers=objdump
> > root@number:~# cat ~/.perfconfig 
> > # this file is auto-generated.
> > [annotate]
> > 	disassemblers = objdump
> > root@number:~#

> > It takes longer to show the annotated output but there is source code
> > and 's' works.

> Thanks for chasing it down, we miss source line support in the disasm
> using capstone and libllvm.  We can add that later but for now we may
> refresh the result and force to objdump when source line is requested.

That is a good idea, I thought about it as well and will check how to do
it on top of what I have at:

https://web.git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-annotate%2bbuild

- Arnaldo
