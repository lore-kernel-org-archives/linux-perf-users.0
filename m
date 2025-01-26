Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E05672;
	Sun, 26 Jan 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737924736; cv=none; b=DIMwIaevyBLlt6NRFGhjp6cwdnEigkusaLHkCXsOYeEs0WfHGR1JjEup2dWlAxZ/fF7Cd7tUZkSI7mprEyRif/yCyoeZXY8fgbLrme6zbFjlN9WGs4mN1CE4DOI/IyXMh4w4G/I6AlEuOmc0ZxRk1XzU4ORqfDVdITtt1ydijbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737924736; c=relaxed/simple;
	bh=lffJd18ez6S24Qh1EMgIimwEWPfRWGdSO6qEYI6HIGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVsjn7yNftQbNWT/6T0zYZU0ejRvlq4+5CYVGK7NHu/q5CpLSuVaFE1faDaJ/dxfDEh2Uj52bYqU2zdY2us583rnWaxb1Pi1jGS+V4Fr2zpUvgRh4ig+uhn/QQgTm8sssbsqQwU2PYOSfVjVyiujxehpU+ZfcUEzsJdLtQUCvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAmN/7d8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAmN/7d8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673E3C4CED3;
	Sun, 26 Jan 2025 20:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737924735;
	bh=lffJd18ez6S24Qh1EMgIimwEWPfRWGdSO6qEYI6HIGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAmN/7d8ba95lIW5ltCozGpVTSaxxXiQd/6LNxZ7xbUnaUBW4p85K8wAHkrIShDz+
	 Z5alhBF3Vak6bU2vKEpXbBiREhKyFQZft4GLlmwC3U5Ttozy5v+A5gLkTi3IYqMnCa
	 AeBmaYpQcYBAUUvSEtP2Tz50nlcsTFr5BPfSiFl/tE8rpM5Mwbej+27lM8M+Fw3+Mu
	 giNdFuUH4gUT+Ljji6NutSd1tJwqCQCscHP1TG1w9s6DEaUo8l6kp2cw7GjwNHXQNY
	 4qIWO/h6DX/eQ7v3NFhcBizGr02HdvaiSotI+WR4Y6ylqIIaVfWEzRrMHw0tgy9ddx
	 wAB3ZEHaHdf1A==
Date: Sun, 26 Jan 2025 12:52:13 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 3/6] perf build: Add mypy build tests
Message-ID: <Z5agfIGq8h7OlPOl@google.com>
References: <20241025172303.77538-1-irogers@google.com>
 <20241025172303.77538-4-irogers@google.com>
 <Z5QngQQZBIekSl_v@google.com>
 <CAP-5=fW8sGBQ_KRSRKhpUH8fzjy_PG7S-75O-YF1xGj0agoe6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW8sGBQ_KRSRKhpUH8fzjy_PG7S-75O-YF1xGj0agoe6A@mail.gmail.com>

On Fri, Jan 24, 2025 at 06:10:09PM -0800, Ian Rogers wrote:
> On Fri, Jan 24, 2025 at 3:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Oct 25, 2024 at 10:23:00AM -0700, Ian Rogers wrote:
> > > If MYPY=1 is passed to the build then run mypy over python code in
> > > perf. Unlike shellcheck this isn't default on as there are currently
> > > too many errors.
> >
> > Can you please add an example output in the commit log?  Also you need
> > to add a comment to describe the build option.
> 
> It feels more of a developer option, so I'm not sure we should
> advertise it. Ideally we'd just default it like the shellcheck case.

Yep, but I think we need some (brief) explanation even for a default
developer option.

> I'm not sure of the benefit of snapshotting mypy errors, a quick
> internet search will show what mypy does and I'd prefer the patch set
> focus on the build infrastructure changes.

You are introducing a new thing so you need to explain what it is, how
to use it and how the output look like.

> 
> > Is it ok to pass the option on a system that doesn't have mypy?
> 
> I'd expect the shell/which assignment to MYPY would leave it
> undefined, in which case the behavior would match not building with
> MYPY=1. It's basically the same logic as with shellchecks. I didn't
> test/optimize for people requesting a build option with dependencies
> missing.

Ok, I'm good as long as it handles the case.

Thanks,
Namhyung

