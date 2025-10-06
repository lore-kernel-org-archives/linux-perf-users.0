Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3CB2DCC01;
	Mon,  6 Oct 2025 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781003; cv=none; b=WAup/JauAujm8lGJAl/qOC+FYUfdX+VZoL0rzq0nBxG43xE6x0Qg4DntlbopcOzIM+dKvNT2UytLOcLmt2Gm4My6UwrLn/2oZQ8Vm7iEwimniyW1kuNajJ9uKfPWpkat5jHP7rqD1zgy53nQJKDsX03EJ0ZZ+BIWhkffLTUznZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781003; c=relaxed/simple;
	bh=Jb2U3zm3DqlxlAs18U3OQ+1rjupm7LjmojbDEOd1xYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdUqDKKcjYjcFQ8xAAjqPBC0h/2+3xc72IbqSwOh79FW7KAmUG/8esli5z9H1O6YJNqT9qsJtZYp7FlK3BQnSQnglPlYaUPhjoo1geMoSd5tKqvcjhtpHQa204/q+kNvu1NT1Xnie++YnGLtPJ33GlmYs5hYyLXCs7MyqNGy+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrrIoPKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrrIoPKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6D5C116B1;
	Mon,  6 Oct 2025 20:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759781003;
	bh=Jb2U3zm3DqlxlAs18U3OQ+1rjupm7LjmojbDEOd1xYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrrIoPKSZ2xC/VASVdxf7qDyVjjETOYocZmRXAP9axn6G8biokawmkAlqUKmAhxyA
	 3QNNoHu1wRLbZi/KybojeTDItmR/gG4RxT3P1AHBjscdglPgBJDx/S98qik58phwa/
	 9HMV3TKp2CglpsjOHmWAX8Q/3ipLjHouml4lxGtA8iaI4Q5tWTlh/v3QS+TRnRkJvK
	 CyYE9niUzYrxhxXQecW0xrgdGWaS0L3109yT8gx355GoCsi6wpTKvcYr98MRrJQt5Q
	 KXre1M4vtMInIeYW+1pFgsQJGvfv56GcknttEfX5OkxGIkV77P1o32bnmu1FGgEWHY
	 NTLnzPa7RKCdg==
Date: Mon, 6 Oct 2025 17:03:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
Message-ID: <aOQgiN0IlSso_L6d@x1>
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>

On Mon, Oct 06, 2025 at 08:21:12AM -0700, Ian Rogers wrote:
> On Mon, Oct 6, 2025 at 6:11 AM James Clark <james.clark@linaro.org> wrote:
> > We already only test each kcore map once, but on slow systems
> > (particularly with network filesystems) even the non-kcore maps are
> > slow. The test can test the same objump output over and over which only
> > wastes time. Generalize the skipping mechanism to track all DSOs and
> > addresses so that each section is only tested once.
> >
> > On a fully loaded Arm Juno (simulating a parallel Perf test run) with a
> > network filesystem, the original runtime is:
> >
> >   real  1m51.126s
> >   user  0m19.445s
> >   sys   1m15.431s
> >
> > And the new runtime is:
> >
> >   real  0m48.873s
> >   user  0m8.031s
> >   sys   0m32.353s
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
