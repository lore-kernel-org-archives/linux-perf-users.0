Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387F26A1BE;
	Tue,  4 Nov 2025 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295381; cv=none; b=Nt6ig1RXiFgKKTNlQcuOgwIT3P9DBGar8JfCLLOxomTdUlzPlIZcgK/6kpV/1ewI7jGHiEja2Q0olRT0WryaXZZ96H4fyaoKP2CAvC8aYeY6xjOSVElyTumEAnRdoRoaHp9g/ikZYiaSBFu3K2CzW+AJwDiGqlFkLO2frd+9Dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295381; c=relaxed/simple;
	bh=Qa+bjiUUHg1qGWIAUBFii+aL3x1yVOk+hp/bWSOYsdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V36erc7woXj7c2Rzt8TD2dFyVOLyO+VViJznbc5MhvxtVHI7K/iRMan5vkYM/uaiLlOgCbDJmRZnsT2pgr7w3DUYgS4LkuxrDR7k1p7iM5o1eqHNu2R3UQ1ayx0COuCehBb8PtbAN5MqhbmsyNbASV4u4IThoVULZfaCnshxSx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks+yikkm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks+yikkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CD2C4CEF7;
	Tue,  4 Nov 2025 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762295381;
	bh=Qa+bjiUUHg1qGWIAUBFii+aL3x1yVOk+hp/bWSOYsdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ks+yikkmX739XRDNFWIkrpT76jIAK9yJvWbeW/4aMURpQBY8ut3Qkx8U8GMtNIC2A
	 LtheDcapqBKjt/Ec9rxaGgfojMLJDDs+LOb7yDdUOdzaTlCLj31aidlmt5JMxBzAbj
	 V5r7wFvJci3krFLmO7GXQGQx5PdgjoGecs6bghpZtXnYp9mBCxnDdPcwXe/FfZYZFq
	 UOkjGm3WrWx3n9h0dvdb0X4VgDs99W4YebL9wk5wAw08KRl2SyIU0jB/rrN1qwYENx
	 UGKNQx+Wuc16BQAcGH4o/5001tL114aBKpKSGPwvT/WGYsQJpfiiCMStEQMu8d720t
	 ozewmwD7dYBqw==
Date: Tue, 4 Nov 2025 14:29:38 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf record: Make sure to update build-ID cache
Message-ID: <aQp-UmG_4EGrgEHD@google.com>
References: <20251104042632.1560922-1-namhyung@kernel.org>
 <CAP-5=fWuAx-uKp0g__hy9zQQiir83_KCVY4XzjW8uob3Coox7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWuAx-uKp0g__hy9zQQiir83_KCVY4XzjW8uob3Coox7w@mail.gmail.com>

On Mon, Nov 03, 2025 at 09:15:57PM -0800, Ian Rogers wrote:
> On Mon, Nov 3, 2025 at 8:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Recent change on enabling --buildid-mmap by default brought an issue
> > with build-id handling.  With build-ID in MMAP2 records, we don't need
> > to save the build-ID table in the header are of a perf data file.
> 
> nit: s/are of/of/

Thanks, will fix in v2.

> 
> >
> > But the actual file contents still need to be cached in the debug
> > directory for annotation etc.  Split the build-ID header processing and
> > caching and make sure perf record to save hit DSOs in the build-ID cache
> > by moving perf_session__cache_build_ids() to the end of the record__
> > finish_output().
> 
> The changes to builtin-record look okay, but do we need to worry about
> `perf mem record` and similar? The header change will impact all
> perf.data file generation.
 
I believe all other codes just call cmd_record() in builtin-record.c to
share the logic.

Thanks,
Namhyung

> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-record.c | 30 +++++++++++++++---------------
> >  tools/perf/util/header.c    |  1 -
> >  2 files changed, 15 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index ffb94a8339b03ec2..fe10bb7f35cbea05 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1890,15 +1890,14 @@ record__finish_output(struct record *rec)
> >         }
> >
> >         /* Buildid scanning disabled or build ID in kernel and synthesized map events. */
> > -       if (!rec->no_buildid) {
> > +       if (!rec->no_buildid || !rec->no_buildid_cache) {
> >                 process_buildids(rec);
> >
> >                 if (rec->buildid_all)
> >                         perf_session__dsos_hit_all(rec->session);
> >         }
> >         perf_session__write_header(rec->session, rec->evlist, fd, true);
> > -
> > -       return;
> > +       perf_session__cache_build_ids(rec->session);
> >  }
> >
> >  static int record__synthesize_workload(struct record *rec, bool tail)
> > @@ -3083,7 +3082,7 @@ static int perf_record_config(const char *var, const char *value, void *cb)
> >                 else if (!strcmp(value, "no-cache"))
> >                         rec->no_buildid_cache = true;
> >                 else if (!strcmp(value, "skip"))
> > -                       rec->no_buildid = true;
> > +                       rec->no_buildid = rec->no_buildid_cache = true;
> >                 else if (!strcmp(value, "mmap"))
> >                         rec->buildid_mmap = true;
> >                 else if (!strcmp(value, "no-mmap"))
> > @@ -4192,24 +4191,25 @@ int cmd_record(int argc, const char **argv)
> >                 record.opts.record_switch_events = true;
> >         }
> >
> > -       if (!rec->buildid_mmap) {
> > -               pr_debug("Disabling build id in synthesized mmap2 events.\n");
> > -               symbol_conf.no_buildid_mmap2 = true;
> > -       } else if (rec->buildid_mmap_set) {
> > -               /*
> > -                * Explicitly passing --buildid-mmap disables buildid processing
> > -                * and cache generation.
> > -                */
> > -               rec->no_buildid = true;
> > -       }
> >         if (rec->buildid_mmap && !perf_can_record_build_id()) {
> >                 pr_warning("Missing support for build id in kernel mmap events.\n"
> >                            "Disable this warning with --no-buildid-mmap\n");
> >                 rec->buildid_mmap = false;
> >         }
> > +
> >         if (rec->buildid_mmap) {
> >                 /* Enable perf_event_attr::build_id bit. */
> >                 rec->opts.build_id = true;
> > +               /* Disable build-ID table in the header. */
> > +               rec->no_buildid = true;
> > +       } else {
> > +               pr_debug("Disabling build id in synthesized mmap2 events.\n");
> > +               symbol_conf.no_buildid_mmap2 = true;
> > +       }
> > +
> > +       if (rec->no_buildid_set && rec->no_buildid) {
> > +               /* -B implies -N for historic reasons. */
> > +               rec->no_buildid_cache = true;
> >         }
> >
> >         if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> > @@ -4306,7 +4306,7 @@ int cmd_record(int argc, const char **argv)
> >
> >         err = -ENOMEM;
> >
> > -       if (rec->no_buildid_cache || rec->no_buildid) {
> > +       if (rec->no_buildid_cache) {
> >                 disable_buildid_cache();
> >         } else if (rec->switch_output.enabled) {
> >                 /*
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 4f2a6e10ed5cc0bd..4de7ca16b5522c47 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -335,7 +335,6 @@ static int write_build_id(struct feat_fd *ff,
> >                 pr_debug("failed to write buildid table\n");
> >                 return err;
> >         }
> > -       perf_session__cache_build_ids(session);
> >
> >         return 0;
> >  }
> > --
> > 2.51.2.997.g839fc31de9-goog
> >
