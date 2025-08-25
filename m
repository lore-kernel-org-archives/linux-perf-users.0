Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D418DF62;
	Mon, 25 Aug 2025 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102425; cv=none; b=RKuKNen3FvX4a9XPlP0nYu07SqmvbWJW+u+9i+sVssCSgx9VKC0kjCJeF4DeLTNr91fB6HQf9yNZ+T8flrE765sw/ULsDQ/5LfWkYeIanhYK+u3RFEtZP3UHADdSoGnopKfgjBdleQMptSK26UCEcMlSUIHrUxVEcLfFahFZ5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102425; c=relaxed/simple;
	bh=xL/wfTZE59TZruXlPkYR+9AazibCZMjAqAiETRoNGHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+563U1ODxIygoEldCDc1Rpygtz1jfEhyxtcdFR7GA/eJfGPWPwaiBlU7ltNMIvSxOMwTX31lRTbVgnboUEVwzwwobUR6yAuutY07qfZa4YtNe5t7YZZUrAaA4dCzhE4Zc+4bWZv58rdQfai25q0NeMWKM/NlQRq1reCrY/UvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF3ihf4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF3ihf4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E073C4CEED;
	Mon, 25 Aug 2025 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756102425;
	bh=xL/wfTZE59TZruXlPkYR+9AazibCZMjAqAiETRoNGHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MF3ihf4iHTDmwdgfAiHRsLoUwCr1BFsFnrJJKEoPKF8IOvQ3AjdqefskKEQe4XeQM
	 a9kwFnrdv7zTevE3SqTYAIH6JwtIgXEEwHIb6gaz8H4UMrdUsxjzsau4r+yXAVfaYU
	 QwYFsrJKaykDmCD4F7eq/b7Q1HBomLm4wd/DxtDMULU4La/HS23A7wdNAarAubwrG+
	 BTip0TrbTWRjVBO+67Zrq7GYqnXY5YK+UjoO5dw0cw7bq71rzZPjkfECJKTOCi68yk
	 H7nnh7yCAYt0sMf+ihrtXbPA8S8/oLbF3JJpc4qh4YDr3XkrLfKldvniE71yj+4s82
	 nARgQ+FUOvfSw==
Date: Sun, 24 Aug 2025 23:13:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
Message-ID: <aKv_FjtkPIR86inu@google.com>
References: <aKYEpf7xp3NnkBWm@x1>
 <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>

Hello,

On Wed, Aug 20, 2025 at 06:14:08PM -0700, Dmitry Vyukov wrote:
> On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.
> >
> > Not combining entries in 'perf top', so we're getting multiple lines for
> > the same symbol, with the same address.
> >
> > To test it, simply run 'perf top', then do /acpi to see just symbols
> > starting with acpi_ and notice that there are various lines with the
> > same symbol, press V to see the address and its the same.
> 
> With this revert, does it show 1 entry but with a wrong percent?
> I am not sure why there are 2 entries for the same symbol, but if we
> merge them, we can sum of percents. Is it the right thing to do?

I don't think it'd have a wrong percent.  The hists maintain stats for
filtered entries separately.

Based on the position of filtered entries in the RB tree, I think it
might not merge correct samples together and create multiple entries
with the same info.

Filtering by unused sort keys would be undefined.  We probably want to
warn users instead.

Thanks,
Namhyung

