Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F017BD6;
	Thu,  7 Nov 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006422; cv=none; b=BD7Wj5x7O/vpcnbEfb8orXbMbfW7Mq/ty2sl7AtboOKoiEGIxJZ+qZjKX+5YdGG4o+Ju+JTA9bIjYeB0Alb/dGfkRb461+SGreFdi34d+4I6gMnUIG8Uynp49MKzi7Ru00ZPk6PqhavBic0mbsDSnzdedxDrwPbGsvD+CU6CLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006422; c=relaxed/simple;
	bh=iwnv5zMijLqpqKCsX0O85wH67J4OkIK+JQBAPPB9ZHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cks157gua/LF/f0aredn/XySoVHbYI0h/M7k2/ZrN9FF+RS4Paq0/5aFwlRGbT1wd4370tmI91Wil5NsVTpFo8rV/T4loiWfvigX2GpyQDChzOfgtg2neBcsd2x8M2Zjsxpc4to50npA5kAKlz8TJYfBLGi97zWhVTdp3S0/1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtAi207g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtAi207g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F96C4CECC;
	Thu,  7 Nov 2024 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731006421;
	bh=iwnv5zMijLqpqKCsX0O85wH67J4OkIK+JQBAPPB9ZHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtAi207gGqu9cChCFk2Sx7GI1Ib34Hqeo5XEaFXeve77nrCK76HDJxYQBuzrmoyQ5
	 9PyU6qEwg5VttlfKuYYu0Rx1fAiLHtQn/RkbuV1r2PWwr8swnmzsxqFKL+Y91GshU5
	 RegYVYZqdFpqtqvP37d/kOk41AJxlkyjV233QDA/cOPatughz11LBL4Ld4l22r+kTa
	 02XFXcY4tMhogSYtGZE2uls85Tv6eGp0QRKe5rAFDmXo+QQO7x1EerxLR5/JMuQbRd
	 JUCUVGsdzOFpr/EwEcWiiWg+QDrR1/ARGEVxQE1edkxBz1wi9+hTmFWcNjSzal0BZo
	 QFkqo0Ki9Zvxw==
Date: Thu, 7 Nov 2024 11:07:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Expand metric+unit buffer size
Message-ID: <Zy0P1POgAe_fkLBF@google.com>
References: <20241106004818.2174593-1-irogers@google.com>
 <126ebac6-fb52-4c3c-b364-0b423e164d40@linux.intel.com>
 <CAP-5=fV3RuvU0N_bt7R-ZMs2nX1_wfKh30PA59u3MW0TF4nzBg@mail.gmail.com>
 <06c73597-5b23-4759-9101-6594cc13cabc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06c73597-5b23-4759-9101-6594cc13cabc@linux.intel.com>

Hi Kan,

On Wed, Nov 06, 2024 at 11:23:15AM -0500, Liang, Kan wrote:
> 
> 
> On 2024-11-06 11:04 a.m., Ian Rogers wrote:
> > On Wed, Nov 6, 2024 at 7:27 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 2024-11-05 7:48 p.m., Ian Rogers wrote:
> >>> Long metric names combined with units may exceed the metric_bf and
> >>> lead to truncation. Double metric_bf in size to avoid this.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/util/stat-shadow.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> >>> index 8c9292aa61d3..6b531d4f58a3 100644
> >>> --- a/tools/perf/util/stat-shadow.c
> >>> +++ b/tools/perf/util/stat-shadow.c
> >>> @@ -507,7 +507,7 @@ static void generic_metric(struct perf_stat_config *config,
> >>>       if (!metric_events[i]) {
> >>>               if (expr__parse(&ratio, pctx, metric_expr) == 0) {
> >>>                       char *unit;
> >>> -                     char metric_bf[64];
> >>> +                     char metric_bf[128];
> >>
> >> I thin there is already a MAX_EVENT_NAME.
> >> Can we similarly define a MAX_METRIC_NAME for it?
> > 
> > So in this case the buffer needs to be big enough to hold the metric
> > name, the unit from the scaleunit (e.g. the "%" from "100%"). I'd
> > prefer we used dynamic memory allocation to having hard coded limits,
> > just to avoid a "640K ought to be enough for anybody," moment.
> > Although this change is implicitly a hard coded limit, sigh. There is
> > also the metric only name length:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-stat.c?h=perf-tools-next#n160
> > That looked like it was planned to be dynamically computed but then
> > the patch adding that never materialized - meaning "standard"
> > metric-only output has its own cut-off rules at 20 characters. I'd
> > rather wait on doing a larger cleanup and do this quick fix for now,
> > mainly as I have enough to do.
> 
> OK

Can I assume it as Acked-by?

Thanks,
Namhyung

