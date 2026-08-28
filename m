Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D636606A;
	Fri, 28 Aug 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937218; cv=none; b=PvM1nlmI7rbm2pr1eAVBbK6wi5YE+IxcuF3uZYpAsW/6qyE9/i9Ly6bEwbygsDpapRRYK2ENuXup5e4IiklSzmMmK5g7p23T6a3o2rvuvr8EP33Ky0lcv45Jhbz34on1pd7SwP6nXxrHEGOSSkp8JOWQQW9+aTw0qSoEpWWkj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937218; c=relaxed/simple;
	bh=dZhx/0HQyznvL8R2I+AP4lJGz5aKK1IX3Tp7naxeaPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBhec9rmSBLMoqKuil5OxcAZglWGmgHHyF+qzmcfK+oscNxC8WXNblSUu35Qbajg15fHIpL9mDV/cNyMQ8+jsLVAdCxcLcHDgja8qX+OB0qKwZuxaBgZ/FoTJHYGcHSfhAMBnhzg09U8Wn8HTVPs/4iJepnSSL91vfKfkC9xSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Itp5KKni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itp5KKni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A51C1F00A3D;
	Fri, 28 Aug 2026 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787937217;
	bh=6HzkT6FDMtlpaJ1w0zW4faKtYQoVM7AO1hh8/76KOs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Itp5KKniAYjUzhZsXtDOJrf6JBMs5TJXWOs9dtX43elS3y83JyVVwySHJYawmyfHW
	 IzqGsiYCShuUp3hpyj9+Ocm80iYJRWk3Fn76CW0llgWoAO7AmP6xuz1v+IWQBEBab0
	 dz2gdpDuna10AObBcZJBJlduerJh8UxMiAPEj7seXjvV7yn90xTDheQdQSXVVh1+2F
	 pr9EUOp2t40L8LomyKOMnGJW6i53Hcu02n+4UtdHt+lOSPoFl1PqWxoKMUzZRvGemq
	 RMF3KQ4iH/UlMuZgYYaTF1KyP//fa+ojNRoRRMuCTebbd1N+xAh6Rd2hDoiRDIWcOu
	 A5ptjl37HXBhw==
Date: Fri, 28 Aug 2026 10:13:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Zide Chen <zide.chen@intel.com>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v7 1/2] perf pmu intel: Generalize SNC cpumask
 adjustment for multiple platforms
Message-ID: <apHBv6hhZN6CPlWE@google.com>
References: <20260527221934.3830896-1-ctshao@google.com>
 <20260528001117.3BBF11F00A3A@smtp.kernel.org>
 <CAJpZYjUiNdN3a6y+8rs=YP2Mgtj6EQJnkiB9TN_suWd8fGkoEg@mail.gmail.com>
 <CAJpZYjUhw8+ouKTS82G6ih457=pHn18AtvwMCAcaTL9csKmdTg@mail.gmail.com>
 <CAP-5=fVAckZihxg4djQn7iTGbNNT1vFLXt2En8mm8+COSs3GcQ@mail.gmail.com>
 <29d02905-14fd-4c2a-86d0-a605e9d41b10@linux.intel.com>
 <CAJpZYjVoxEjxmut5AL6dOpfTSBj9VZOs3qaawofDxWyTeaa8Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjVoxEjxmut5AL6dOpfTSBj9VZOs3qaawofDxWyTeaa8Ug@mail.gmail.com>

Hello,

On Fri, Aug 28, 2026 at 09:56:24AM -0700, Chun-Tse Shao wrote:
> Thank you Ian for bringing this back. Zide gave a Reviewed-by tag on
> v6, and v7 mainly addresses the Sashiko review.
> 
> To Arnaldo and Namhyung, Is this patch ready to be merged?

Please don't top-post.

> 
> On Fri, Aug 28, 2026 at 1:11 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
> >
> >
> > On 8/28/2026 1:28 PM, Ian Rogers wrote:
> > > On Tue, Jun 9, 2026 at 11:44 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > >> Ping for attention.
> > > I suspect Arnaldo and Namhyung are waiting for feedback from Intel on
> > > these patches. If someone could check them it would be appreciated.
> >
> > I suppose Zide has checked these patches and gave the "reviewed-by" tags. :)

Sorry for missing this.

Arnaldo, can you please pick this up?

Thanks,
Namhyung

