Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084F15624D;
	Wed, 24 Sep 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707840; cv=none; b=EMwttufRj3oeoyB9c/PKia37xG093DrnNl83ys4Jl5lvDgyGLiSHNkwLbMJ6TpFfDBo4K0yGAtcRVXejDHxcSJSTgVLWcD55NByq4VQ6gC+XbJ95AzlhzF5vTvrvhSWH+sBBYPwTjjmKx5MtsHE53R06UsOSO8S8wCy0EG9QeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707840; c=relaxed/simple;
	bh=SS41FRb6aDAQjk9Oc/EVenUGngwNPleBuE2EELyQavs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7nI1syZVhgMtPF6A9wBOyRShwVQbD5hdl5c4NEYFy3lQyuLglPRQtRsj2rTcNjoLhG7vUwA6712Auuwka0acS89+TQn/397Pp2fl4z3GNM+g8nBOu9RAIE7MWM+36SnNvczG7kfwuQ3Hh1dyyQPvWW2tIeNw7lMjNOKgWB2m5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1AHgoyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1AHgoyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D276BC16AAE;
	Wed, 24 Sep 2025 09:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758707839;
	bh=SS41FRb6aDAQjk9Oc/EVenUGngwNPleBuE2EELyQavs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1AHgoyxv+oqClooEAztfJG1krtTp1D1mXGJH+axrUHxDz3WH3DCul7MQ2xEisAgu
	 YAQ2wIb2VLdlkJkD1lsrKOVM0NuCy2zBG6chXd2ws4vPP5BBn+mwJlUmrnfJWUX7sQ
	 56NEeUIJ3c6OgU411bAws45IvoBENW8YbI5/YkNQOXlqu1aSKxbtP9H3fD74C1/XDt
	 zXB+IjpWE5FAPnw/maUFJvSe+faMCmSYu2oTFTwhVX5V1EAYBCs0TuEn412Aya9snU
	 XA26TVEbMFu3xttrKzc+E+1p9MiJ3A5ci/FqxaJeW77Zsu9oiX10Xb2PWaOBi/q8Yu
	 xC53FNAwxjDTg==
Date: Wed, 24 Sep 2025 06:57:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Test fixes and debug logging
Message-ID: <aNPAc7wW5Rgpskap@x1>
References: <20250914182900.1960567-1-irogers@google.com>
 <aM3BCr9DbBxnL5rV@x1>
 <CAP-5=fXOMLLFmn_06nBGjzbeD4=TLGPExP+K8x_pNRqKO-z-KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXOMLLFmn_06nBGjzbeD4=TLGPExP+K8x_pNRqKO-z-KQ@mail.gmail.com>

On Sat, Sep 20, 2025 at 08:21:43AM -0700, Ian Rogers wrote:
> On Fri, Sep 19, 2025 at 1:46 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Sun, Sep 14, 2025 at 11:28:56AM -0700, Ian Rogers wrote:
> > > Ian Rogers (4):
> > >   perf test: Be tolerant of missing json metric none value
> > >   perf parse-events: Add debug logging to perf_event
> > >   perf test: Don't fail if user rdpmc returns 0 when disabled
> > >   perf stat-shadow: Display metric-only for 0 counters

> > Thanks, applied to perf-tools-next,
 
> there was some follow up in:
> https://lore.kernel.org/lkml/20250914182140.1958530-1-irogers@google.com/
> I think I've also noticed that logging introducing newlines that
> impacts the tests column counts. I'll take a further look as we tried
> to harden against that with an output file option.

I'll make sure I get the most uptodate version, if/when available.

I'm attending Kernel Recipes, so there is an additional delay on
processing patches, but I should be back processing patches RSN.

- Arnaldo
