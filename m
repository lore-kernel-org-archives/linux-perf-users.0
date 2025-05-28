Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE222F775;
	Wed, 28 May 2025 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476612; cv=none; b=nMU/boJCDAlunxY5IPZQ5oScjzag6aJcbKs/1vOIcOpdzOTT1alTPU6LyJjBYQpsXykd7UtzmiK9UAKKUuDhGi0uLxchP6vIfWsufzaXfIgbniP+3+DWz/kkJang9jPGV7GzCIcTECZHRUEfEucPjWSJGIuPB0LoryR6YVB9cVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476612; c=relaxed/simple;
	bh=domoQ2WEo/v1iV79MDw5+2KwD8eHeSnei6MfxgMxz20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVHP4mYuqJqf9TCYWiqmYw1dqbeAyBjVv1xkERsQrqL9JwA3CAematx+CHciJKtsgT6OQcTDK97XIXVsMrd293Tkk5AKBpRhx4QJyhN5DBqXwlmaCF2qGhjB+nHjZI/wSquBigsxDxNS2dpphUObTIbCcsQfsIDIZNXnPNc+WAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX+ZAPf2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX+ZAPf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976B1C4CEE3;
	Wed, 28 May 2025 23:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748476611;
	bh=domoQ2WEo/v1iV79MDw5+2KwD8eHeSnei6MfxgMxz20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gX+ZAPf28219dyQQWDTgBMjp0WVlvu/GEkPTfZAjB4OZWW2uhjrYDVq0Hh5MUqBp7
	 5xHg31YzsuOZn16xPl3Hn5/k6Q+/FMtIudqYj5fwjFFfMxXrZrwE9DQiQE7vre46Gv
	 KZzzkJIhrkyZY/jHWQkCfPT8dSALsIZWJepsMVKAWf+EqWL5ksGUKLLuvPx7jUnQy9
	 fs2SrKF2FgU14B1ehFMb2Qh10dzqfibgBARe8AWWzswq6YLbHIww8j8WtVdWD5kHxN
	 S9Ti+XP2wvJ87RbWLURjuxDSKu9scA4FdNtSDKeS/yB9FRcWnIEilvWLeTIofL1Y7B
	 ooAodzFNZIDKg==
Date: Wed, 28 May 2025 16:56:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	James Clark <james.clark@linaro.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zixian Cai <fzczx123@gmail.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] perf record: Make --buildid-mmap the default
Message-ID: <aDeiwDeDLXaLjlVN@google.com>
References: <20250428213409.1417584-1-irogers@google.com>
 <20250428213409.1417584-10-irogers@google.com>
 <aDd0Wqy6yw6Tu0vg@google.com>
 <CAP-5=fUMiWu5gSfBSTq+OnTRQ2E2gCw6gi7dmOxeTD-+UyYtFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUMiWu5gSfBSTq+OnTRQ2E2gCw6gi7dmOxeTD-+UyYtFw@mail.gmail.com>

On Wed, May 28, 2025 at 01:47:47PM -0700, Ian Rogers wrote:
> On Wed, May 28, 2025 at 1:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Apr 28, 2025 at 02:34:08PM -0700, Ian Rogers wrote:
> > > Support for build IDs in mmap2 perf events has been present since
> > > Linux v5.12:
> > > https://lore.kernel.org/lkml/20210219194619.1780437-1-acme@kernel.org/
> > > Build ID mmap events don't avoid the need to inject build IDs for DSO
> > > touched by samples as the build ID cache is populated by perf
> > > record. They can avoid some cases of symbol mis-resolution caused by
> > > the file system changing from when a sample occurred and when the DSO
> > > is sought. To disable build ID scanning
> > >
> > > Unlike the --buildid-mmap option, this doesn't disable the build ID
> > > cache but it does disable the processing of samples looking for DSOs
> > > to inject build IDs for. To disable the build ID cache the -B
> > > (--no-buildid) option should be used.
> > >
> > > Making this option the default was raised on the list in:
> > > https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-record.c        | 33 +++++++++++++++++++-----------
> > >  tools/perf/util/symbol_conf.h      |  2 +-
> > >  tools/perf/util/synthetic-events.c | 16 +++++++--------
> > >  3 files changed, 30 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index ba20bf7c011d..7b64013ba8c0 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -169,6 +169,7 @@ struct record {
> > >       bool                    no_buildid_cache_set;
> > >       bool                    buildid_all;
> > >       bool                    buildid_mmap;
> > > +     bool                    buildid_mmap_set;
> > >       bool                    timestamp_filename;
> > >       bool                    timestamp_boundary;
> > >       bool                    off_cpu;
> > > @@ -1795,6 +1796,7 @@ record__finish_output(struct record *rec)
> > >                       data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
> > >       }
> > >
> > > +     /* Buildid scanning disabled or build ID in kernel and synthesized map events. */
> > >       if (!rec->no_buildid) {
> > >               process_buildids(rec);
> > >
> > > @@ -2966,6 +2968,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
> > >                       rec->no_buildid = true;
> > >               else if (!strcmp(value, "mmap"))
> > >                       rec->buildid_mmap = true;
> > > +             else if (!strcmp(value, "no-mmap"))
> > > +                     rec->buildid_mmap = false;
> > >               else
> > >                       return -1;
> > >               return 0;
> > > @@ -3349,6 +3353,7 @@ static struct record record = {
> > >               .ctl_fd_ack          = -1,
> > >               .synth               = PERF_SYNTH_ALL,
> > >       },
> > > +     .buildid_mmap = true,
> > >  };
> > >
> > >  const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
> > > @@ -3514,8 +3519,8 @@ static struct option __record_options[] = {
> > >                  "file", "vmlinux pathname"),
> > >       OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
> > >                   "Record build-id of all DSOs regardless of hits"),
> > > -     OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
> > > -                 "Record build-id in map events"),
> > > +     OPT_BOOLEAN_SET(0, "buildid-mmap", &record.buildid_mmap, &record.buildid_mmap_set,
> > > +                     "Legacy record build-id in map events option which is now the default. Behaves indentically to --no-buildid. Disable with --no-buildid-mmap"),
> > >       OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
> > >                   "append timestamp to output filename"),
> > >       OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
> > > @@ -4042,19 +4047,23 @@ int cmd_record(int argc, const char **argv)
> > >               record.opts.record_switch_events = true;
> > >       }
> > >
> > > +     if (!rec->buildid_mmap) {
> > > +             pr_debug("Disabling build id in synthesized mmap2 events.\n");
> > > +             symbol_conf.no_buildid_mmap2 = true;
> > > +     } else if (rec->buildid_mmap_set) {
> > > +             /*
> > > +              * Explicitly passing --buildid-mmap disables buildid processing
> > > +              * and cache generation.
> > > +              */
> > > +             rec->no_buildid = true;
> > > +     }
> > > +     if (rec->buildid_mmap && !perf_can_record_build_id()) {
> > > +             pr_warning("Missing support for build id in kernel mmap events. Disable this warning with --no-buildid-mmap\n");
> > > +             rec->buildid_mmap = false;
> > > +     }
> > >       if (rec->buildid_mmap) {
> > > -             if (!perf_can_record_build_id()) {
> > > -                     pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
> > > -                     err = -EINVAL;
> > > -                     goto out_opts;
> > > -             }
> > > -             pr_debug("Enabling build id in mmap2 events.\n");
> > > -             /* Enable mmap build id synthesizing. */
> > > -             symbol_conf.buildid_mmap2 = true;
> > >               /* Enable perf_event_attr::build_id bit. */
> > >               rec->opts.build_id = true;
> > > -             /* Disable build id cache. */
> > > -             rec->no_buildid = true;
> > >       }
> > >
> > >       if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> > > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> > > index cd9aa82c7d5a..7a80d2c14d9b 100644
> > > --- a/tools/perf/util/symbol_conf.h
> > > +++ b/tools/perf/util/symbol_conf.h
> > > @@ -43,7 +43,7 @@ struct symbol_conf {
> > >                       report_individual_block,
> > >                       inline_name,
> > >                       disable_add2line_warn,
> > > -                     buildid_mmap2,
> > > +                     no_buildid_mmap2,
> > >                       guest_code,
> > >                       lazy_load_kernel_maps,
> > >                       keep_exited_threads,
> > > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > > index 69b98023ce74..638d7dd7fa4b 100644
> > > --- a/tools/perf/util/synthetic-events.c
> > > +++ b/tools/perf/util/synthetic-events.c
> > > @@ -532,7 +532,7 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
> > >               event->mmap2.pid = tgid;
> > >               event->mmap2.tid = pid;
> > >
> > > -             if (symbol_conf.buildid_mmap2)
> > > +             if (!symbol_conf.no_buildid_mmap2)
> >
> > I find the double negation confusing.  Can we keep it positive?
> 
> Agreed double negation is broadly bad. Here I changed buildid_mmap2 to
> no_buildid_mmap2 to convey that using build ID with mmap2 events was
> the default and needed opting out of. Getting rid of the 'no_' is of
> course possible, it will mean all symbol_confs will need to initialize
> the value to true (which has minor binary size implications), I also
> think it makes the intention of the code harder to understand.

Well I think perf record is the only place to set it.  But I won't
insist on it strongly.  Let's go with negative if you like.

Thanks,
Namhyung

