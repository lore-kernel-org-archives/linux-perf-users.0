Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620752F88;
	Thu,  8 Aug 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149159; cv=none; b=X4D62AN36oxKNYLOQuql6QD+YUPjTvVmG4ZPwoBd0wpMJLALS76l7Ij79zoCqGoI7t3m0+uef8b/wbfnKvUJjffUfTz40bhlDIdly/g1hsZKsZpUCOee4/HaJhuy4BDM1uAXBIn6HC82P338IzuyaOmfEZO2KqzCaqi4JFzbH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149159; c=relaxed/simple;
	bh=rJGqi+Na8v3GfQ0y92F0ElfSsv6iJrHMY+un6SEJ+TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkMp+QIAz9JHSmlOVwbDk3slBi0UdvefLO5gyaThW8GKGz+ll5YZnaZdq4iKUW/Y3RZZlA4wovNuEduMrwtOi9MUOBhNRsKP/RTOHJJrfL7iQqdg8cX1GxtIDovyTKda4XqPkZHkRAy7p5pYUuXHsCwwumnLmjtRhOFWTZpago4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXEefZ2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXEefZ2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CD6C32782;
	Thu,  8 Aug 2024 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723149159;
	bh=rJGqi+Na8v3GfQ0y92F0ElfSsv6iJrHMY+un6SEJ+TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXEefZ2ewotY1UN2kljKPQsVwHs1vOdqNScWXj2FoJdgXD7beOebasb1XMGSBLRNj
	 +FLD0hM4LEFLyJZm7Eqy8OcT6saTqomckK3etEqZb1vJD+PJ+MrrlfUovpVv6AuJvQ
	 NvDR/LyRopUK8/lgg95qM1QPBYU1g1b8tbrR1dH2o1B21fRDzfVrL+FZolcrX/hhxJ
	 XwrM+LYwneMw9RTpiAIiGiAD2L/cAI5xZ9uMJcLeMSX5lRi+ZNsohODlYzb8kFIe0d
	 iM7eZ2805temCKLrgt5PVgV216QDMlKBrWUO5E2DTca57HhauNQtpZbGXH8glSJWQK
	 dNiB3/3EMyjaA==
Date: Thu, 8 Aug 2024 17:32:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Zixian Cai <fzczx123@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf script python: Add the ins_lat field to event
 handler
Message-ID: <ZrUrZOp1w5-8wjQM@x1>
References: <20240808133208.3577910-1-fzczx123@gmail.com>
 <8be2eeaf-9c85-4a77-b66d-53dd1b35bf91@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be2eeaf-9c85-4a77-b66d-53dd1b35bf91@intel.com>

On Thu, Aug 08, 2024 at 06:50:16PM +0300, Adrian Hunter wrote:
> On 8/08/24 16:32, Zixian Cai wrote:
> > For example, when using the Alder Lake PMU memory load event, the instruction latency is stored in ins_lat, while the cache latency is stored in weight.
> > 
> > This patch reports the ins_lat field for Python scripting.
> > 
> > Signed-off-by: Zixian Cai <fzczx123@gmail.com>
> 
> Minor comments, otherwise:
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, I'm then waiting for a v3 with those comments addressed and your
Reviewed-by tag collected,

Thanks,

- Arnaldo
 
> > ---
> > v2) rebase on top of perf-tools-next
> > 
> >  tools/perf/util/scripting-engines/trace-event-python.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> > index fb00f3ad6815..c9e8dbd6feb5 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -888,6 +888,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
> >  	set_sample_read_in_dict(dict_sample, sample, evsel);
> >  	pydict_set_item_string_decref(dict_sample, "weight",
> >  			PyLong_FromUnsignedLongLong(sample->weight));
> > +	pydict_set_item_string_decref(dict_sample, "ins_lat",
> > +			PyLong_FromUnsignedLongLong(sample->ins_lat));
> 
> ins_lat is u16 so it could be PyLong_FromUnsignedLong()
> 
> >  	pydict_set_item_string_decref(dict_sample, "transaction",
> >  			PyLong_FromUnsignedLongLong(sample->transaction));
> >  	set_sample_datasrc_in_dict(dict_sample, sample);
> > @@ -1317,7 +1319,7 @@ static void python_export_sample_table(struct db_export *dbe,
> >  	struct tables *tables = container_of(dbe, struct tables, dbe);
> >  	PyObject *t;
> > 
> > -	t = tuple_new(27);
> > +	t = tuple_new(28);
> > 
> >  	tuple_set_d64(t, 0, es->db_id);
> >  	tuple_set_d64(t, 1, es->evsel->db_id);
> > @@ -1346,6 +1348,7 @@ static void python_export_sample_table(struct db_export *dbe,
> >  	tuple_set_s32(t, 24, es->sample->flags);
> >  	tuple_set_d64(t, 25, es->sample->id);
> >  	tuple_set_d64(t, 26, es->sample->stream_id);
> > +	tuple_set_s32(t, 27, es->sample->ins_lat);
> 
> ins_lat is u16 so it could be tuple_set_u32()
> 
> > 
> >  	call_object(tables->sample_handler, t, "sample_table");
> > 
> > --
> > 2.25.1
> > 
