Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D71465A9;
	Wed,  4 Sep 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485191; cv=none; b=AefEika8HRD69rlc1Ht9wpTR10MAXogKRZ98sSyUNhNhUAxeBYg25h2KMJJf1Z3NTOVxWm3Xll9gBznSE4b/Ndj0avhTFywI7t6Nu3KoYs6vRkhW+S4okb1A2T8zzvMsBbIMfINmSB4UX6VRhzbDMN3a9Kz5elgs8SR5haITIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485191; c=relaxed/simple;
	bh=mf4VQrn0VgEfOY/aMVKQZ4Qws2HOsefc1rNJbuaD/jc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HUQ4F5B5B5otY4FaqNtA3b9yfmT+PFL+rO+MxUX3Z2cbIqReBII6opgsq5A5bM1x7RVskRfak8vnPvb96kTDYd/nto+0YDOanMSr3WAMatJcgv5pN/2ACAH+OCegCCXOv7OWTMkDQ/+wOC3J59GI8rOTfl9Y9WwGDaX2f/yvDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OcaWyDjk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OcaWyDjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C47BC4CEC5;
	Wed,  4 Sep 2024 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725485190;
	bh=mf4VQrn0VgEfOY/aMVKQZ4Qws2HOsefc1rNJbuaD/jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcaWyDjkVIwn3oYOYEjWujrjy8JCIgGqFSj4h1zVZ8gEhNSqXMRLm2WRRGp3Da4B8
	 7nyO0nLHvEnm4fyA8loPQ8xTUsykkgGXb7TeutJmADamZAkDOE10uz/3thBChGrpkq
	 zogMmfYdCIBgABcZB4DuAxQwHHq6um0+MZyf43sM=
Date: Wed, 4 Sep 2024 14:26:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
Message-Id: <20240904142628.988cb1c7de769e9488375eb2@linux-foundation.org>
In-Reply-To: <87v7zc5aw6.fsf@mail.lhotse>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
	<20240903073629.2442754-1-svens@linux.ibm.com>
	<yt9dikvd9nye.fsf@linux.ibm.com>
	<87v7zc5aw6.fsf@mail.lhotse>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Sep 2024 13:57:13 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:

> Sven Schnelle <svens@linux.ibm.com> writes:
> > Hi Michael,
> 
> Hi Sven,
> 
> > Sven Schnelle <svens@linux.ibm.com> writes:
> >
> >> The following KASAN splat was shown:
> >>
> >> [   44.505448] ==================================================================                                                                      20:37:27 [3421/145075]
> >> [   44.505455] BUG: KASAN: slab-use-after-free in special_mapping_close+0x9c/0xc8
> >> [   44.505471] Read of size 8 at addr 00000000868dac48 by task sh/1384
> ...
> >> [..]
> >
> > As this has a dependency on your special mapping close series, do you
> > want to carry that with your patches?
> 
> Andrew has my series in mm-stable, so I think this should go into mm as
> well. I assume he will pick it up.

yup, thanks.  Added, with

Fixes: 223febc6e557 ("mm: add optional close() to struct vm_special_mapping")

It appears that peterz is scooping up Sven's "uprobes: use kzalloc to
allocate xol area".

