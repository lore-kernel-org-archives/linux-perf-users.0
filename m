Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334D51D521;
	Fri,  4 Sep 2026 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560620; cv=none; b=phJJzU6rCf3Wt7C1jMlPVINRuW9Yq4cnrz7E6wYrKTly0imBhioqDzf4EMkJQGONkzaobj9SltADcKPpOHs0pB/5baIz6xrC95/xhWuXenFsJAaOFGqpGHkVgZeSYWc6C6fJ7NmYnJiayKVbgzeQnPgNlEl4zTfP7AIrddsbcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560620; c=relaxed/simple;
	bh=DbrmJphkU+FtkqCo6KuJQyvB/0cK3sFrs5dE/Hr0Tjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKMWpe6qceXuWBsabkKvCdku+D8YVTxP7X206gm8TLqI/mJfvLBJojFWIyBNcYJq1frTgVfSlMYcTpHcwD/smvFqnNJrbFo8PFEdN3i1mmsqGMAr+lXYwp5cd/1IEljnAcDR2Syo431q0cZIhOnWOdthrSy9azkzU2/u6bOWwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okAzbGk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okAzbGk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E287C1F00A3D;
	Fri,  4 Sep 2026 22:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560610;
	bh=uBesz34PkuRI+A3kmsnVg/F1BggqGShtqUwBLMMecxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=okAzbGk+TptytfnDjSkTRfZvR09QKWYg+fpd7yZ/700ec3wTsDADGqB6Qtum9bxxh
	 um1Pe/KBim6/MIpyI6qmBer+EhjnQYZ+gSAKOlu4dGu3xbj9vL+hmywR7skHJb9O11
	 cq43hYZnJ/y39P0L02z31xN+y/h7JKVkpEee+cD6HZ9Jn7Z0Q/gjptuTq7b6Q5+To5
	 6pbounV8h1J0mkipKiZDDsFJuECpwXqAlttr+QvjYceyGl/ZRpHTo+Yxy/zUWYe7t9
	 zkiDYH9r9gtGSfQGieCUU12TOq+5QxVp/F77EYOH1gUzgu7qUr+EqWL6sAgMNJ0Obb
	 98H6iKcrMqK9Q==
Date: Fri, 4 Sep 2026 19:23:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>,
	"Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
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
Message-ID: <aptE3zO1DtInzbaP@x2>
References: <20260527221934.3830896-1-ctshao@google.com>
 <20260528001117.3BBF11F00A3A@smtp.kernel.org>
 <CAJpZYjUiNdN3a6y+8rs=YP2Mgtj6EQJnkiB9TN_suWd8fGkoEg@mail.gmail.com>
 <CAJpZYjUhw8+ouKTS82G6ih457=pHn18AtvwMCAcaTL9csKmdTg@mail.gmail.com>
 <CAP-5=fVAckZihxg4djQn7iTGbNNT1vFLXt2En8mm8+COSs3GcQ@mail.gmail.com>
 <29d02905-14fd-4c2a-86d0-a605e9d41b10@linux.intel.com>
 <CAJpZYjVoxEjxmut5AL6dOpfTSBj9VZOs3qaawofDxWyTeaa8Ug@mail.gmail.com>
 <apHBv6hhZN6CPlWE@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apHBv6hhZN6CPlWE@google.com>

On Fri, Aug 28, 2026 at 10:13:35AM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Aug 28, 2026 at 09:56:24AM -0700, Chun-Tse Shao wrote:
> > Thank you Ian for bringing this back. Zide gave a Reviewed-by tag on
> > v6, and v7 mainly addresses the Sashiko review.
> > 
> > To Arnaldo and Namhyung, Is this patch ready to be merged?
> 
> Please don't top-post.
> 
> > 
> > On Fri, Aug 28, 2026 at 1:11 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
> > >
> > >
> > > On 8/28/2026 1:28 PM, Ian Rogers wrote:
> > > > On Tue, Jun 9, 2026 at 11:44 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > > >> Ping for attention.
> > > > I suspect Arnaldo and Namhyung are waiting for feedback from Intel on
> > > > these patches. If someone could check them it would be appreciated.
> > >
> > > I suppose Zide has checked these patches and gave the "reviewed-by" tags. :)
> 
> Sorry for missing this.
> 
> Arnaldo, can you please pick this up?

Merged, and I added an "Acked-by: Namhyung", taking this "please pick
this up" as an ack.

Thanks!

- Arnaldo
