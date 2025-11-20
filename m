Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B82DFF04;
	Thu, 20 Nov 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665897; cv=none; b=FbFvD547buIrjBFfrXsNLcRZYbwIdS6ARq3vTgxlq3n2aCkB4Doiq1I+1h0rdPYJwIQNuau8ZDlHk5nLob+AOUDYJMizRFPM5NW7VHfTdeFgRjO/WeAUw0A4SS+MQzMRgRzs6HFzUGvBnQfGx5O9cwVeNjqI5tF+HC6+TLsoFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665897; c=relaxed/simple;
	bh=EJGjcOwpuilPCorYj7pXBDNcjFxuVQ7TIwc/ZYdTU1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7Sm0iytYV+GHvwmzBOnyYwPEqP9q6P0gV5U9yBdG4Yns3v4X8J1pKYP2Q4PhYGAYAjaU0tErnw1LU92qdzQ5TzpQA+IVQD1gWK/0aw4ObpVYlKQJFX3Gro2La3QHd2k/vjtw+36Ajw+LvwEXmrWxSaUq37O6eijGODkE3Ehs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocJACiWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocJACiWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1855C4CEF1;
	Thu, 20 Nov 2025 19:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665896;
	bh=EJGjcOwpuilPCorYj7pXBDNcjFxuVQ7TIwc/ZYdTU1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocJACiWCnqu6d6LWBkrzPSHS77UJPVaofqKRccoWKwKT0lpH2iijo0DVki2Hc39O9
	 JFBnaj64PfeLwhD8pG7Q2THWDjQPuSbo9ZnvOKbdj63zkSJc/MjX2ELe471F4rWPeC
	 hzMkf47qlBjDqOboybjvPWhp2KSw2n7i/4Vvxwjkvup3Zy/gL7i5JoTA8bygbeteiN
	 PQaKN6q3HoqgkAiQGCDA5PvXZ+dT76QbLWEkZYMx0RmhsNdLrdE/8/5knPuwNk++6W
	 JwHm89Nin0Z/JIACgRrrJJW+JgsOPdHnPQVGC4RPdhKacRCYA/+m34gzZi1k3rNiiD
	 xlDv/8G1yhz/g==
Date: Thu, 20 Nov 2025 11:11:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf list: Support filtering in JSON output
Message-ID: <aR9n5qgwryvJaexY@google.com>
References: <20251120004726.61660-1-namhyung@kernel.org>
 <20251120004726.61660-3-namhyung@kernel.org>
 <CAP-5=fWHTGSZPDO06FJENFLW0AtS1Fukk1jqFeHqyGFa+HLhMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWHTGSZPDO06FJENFLW0AtS1Fukk1jqFeHqyGFa+HLhMw@mail.gmail.com>

On Wed, Nov 19, 2025 at 09:42:51PM -0800, Ian Rogers wrote:
> On Wed, Nov 19, 2025 at 4:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Like regular output mode, it should honor command line arguments to
> > limit to a certain type of PMUs or events.
> >
> >   $ perf list -j hw
> >   [
> >   {
> >           "Unit": "cpu",
> >           "Topic": "legacy hardware",
> >           "EventName": "branch-instructions",
> >           "EventType": "Kernel PMU event",
> >           "BriefDescription": "Retired branch instructions [This event is an alias of branches]",
> >           "Encoding": "cpu/event=0xc4\n/"
> >   },
> >   {
> >           "Unit": "cpu",
> >           "Topic": "legacy hardware",
> >           "EventName": "branch-misses",
> >           "EventType": "Kernel PMU event",
> >           "BriefDescription": "Mispredicted branch instructions",
> >           "Encoding": "cpu/event=0xc5\n/"
> 
> I think these newlines can be fixed by changing:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n643
> ```
> ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
> if (ret) {
>    ...
> }
> ```
> to something like:
> ```
> ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
> if (ret) {
>     ...
> }
> if (alias->terms[line_len - 1] == '\n')
>     alias->terms[line_len - 1] = '\0';
> ```

Yep, will do in a separate patch.

> 
> >   },
> >   ...
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your review!
Namhyung
 
> > ---
> >  tools/perf/builtin-list.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index 6c5913f129f39c94..5cbca0bacd35237e 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -373,6 +373,23 @@ static void json_print_event(void *ps, const char *topic,
> >         FILE *fp = print_state->common.fp;
> >         struct strbuf buf;
> >
> > +       if (deprecated && !print_state->common.deprecated)
> > +               return;
> > +
> > +       if (print_state->common.pmu_glob &&
> > +           (!pmu_name || !strglobmatch(pmu_name, print_state->common.pmu_glob)))
> > +               return;
> > +
> > +       if (print_state->common.exclude_abi && pmu_type < PERF_TYPE_MAX &&
> > +           pmu_type != PERF_TYPE_RAW)
> > +               return;
> > +
> > +       if (print_state->common.event_glob &&
> > +           (!event_name || !strglobmatch(event_name, print_state->common.event_glob)) &&
> > +           (!event_alias || !strglobmatch(event_alias, print_state->common.event_glob)) &&
> > +           (!topic || !strglobmatch_nocase(topic, print_state->common.event_glob)))
> > +               return;
> > +
> >         strbuf_init(&buf, 0);
> >         fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
> >         print_state->need_sep = true;
> > @@ -449,6 +466,13 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
> >         FILE *fp = print_state->common.fp;
> >         struct strbuf buf;
> >
> > +       if (print_state->common.event_glob &&
> > +           (!print_state->common.metrics || !name ||
> > +            !strglobmatch(name, print_state->common.event_glob)) &&
> > +           (!print_state->common.metricgroups || !group ||
> > +            !strglobmatch(group, print_state->common.event_glob)))
> > +               return;
> > +
> >         strbuf_init(&buf, 0);
> >         fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
> >         print_state->need_sep = true;
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
