Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1272D3220
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262048; cv=none; b=d5P7HujOwpZTfgXjr5/WC55+5lfRq1SyKLnfME4wCF/fv9zyogG+6ba/gyvnY9OOUOxv6eH3SD4cG44w2GjxzSdCT2KIInq6BAuCxoRCmDeXgjFoUm551Av46rOgRUuDS3zfhjZjA9gHN77VQm+oY0JGwGsKepSSgjsUpIEbMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262048; c=relaxed/simple;
	bh=F3QceEUmd042wBwqLETocWNTZ8fZDWp/VY6V0DCyS5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTDEaDs0kwpBcyJicVHrx5dgWB3IclT8jojJ3Kt4pE1fRGspJpvF9HlE6GgW9t6h1DPFxb4kLA0/0sGPtkocmFbMi4b0VpUJHCutvFNcFpkt5OIdZtJf803+joffyf9tU15tlDns4vB1H1WsG7H1Dm+DlZm/8nqoM+7ftIkwSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1ceIirJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1ceIirJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D048C4CEF7;
	Wed, 11 Mar 2026 20:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773262047;
	bh=F3QceEUmd042wBwqLETocWNTZ8fZDWp/VY6V0DCyS5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1ceIirJ9lqO4GluNR+oDBn+ds/70OQX9xsqG+OZ8EWa+5Fn6ff54vZdcdH/sQKQg
	 hoE17PFKktfuetVDk/OeM9/yu5PX5/xBsnF2RPx5iPytkGsv1AZorNKj/NnzRSC4Wh
	 1NN2SQl6wDIxFfXCWa0Ug/U5nFJP24NrYWGz0cfxJghYlTPpg8oRpLdecNRKO7Dxnz
	 UTsw0frgca3Eibtg0rpiITlYLr/0GtrQm3TtgF774tNAGkqL4g5m5xJ818TKoFNLa4
	 v4lnyzPL8j8VhM3MuwFY1fbmgPmrksfeF8ySvKpH0Nm0PkIS9n3OLpqCCow89xTXmP
	 3rZVpgMbeUsvA==
Date: Wed, 11 Mar 2026 17:47:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chuck Lever <cel@kernel.org>, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] perf synthetic-events: Fix stale build ID in module
 MMAP2 records
Message-ID: <abHU3K-eTNk91iqh@x1>
References: <20260310175951.29500-1-cel@kernel.org>
 <CAP-5=fUA0BiCfgqgy_ik8iAhABQxYtFhKiUiEGrOCcF2jAqhfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUA0BiCfgqgy_ik8iAhABQxYtFhKiUiEGrOCcF2jAqhfQ@mail.gmail.com>

On Tue, Mar 10, 2026 at 12:32:00PM -0700, Ian Rogers wrote:
> On Tue, Mar 10, 2026 at 10:59 AM Chuck Lever <cel@kernel.org> wrote:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > perf_event__synthesize_modules() allocates a single union
> > perf_event and reuses it across every kernel module callback.
> > After the first module is processed,
> > perf_record_mmap2__read_build_id() sets
> > PERF_RECORD_MISC_MMAP_BUILD_ID in header.misc and writes that
> > module's build ID into the event. On subsequent iterations the
> > callback overwrites start, len, pid, and filename for the next
> > module but never clears the stale build ID fields or the
> > MMAP_BUILD_ID flag. When perf_record_mmap2__read_build_id()
> > runs for the second module it sees the flag, reads the stale
> > build ID into a dso_id, and __dso__improve_id() permanently
> > poisons the DSO with the wrong build ID. Every module after
> > the first therefore receives the first module's build ID in
> > its MMAP2 record. On a system with the sunrpc and nfsd modules
> > loaded, this causes perf script and perf report to show
> > [unknown] for all module symbols.
> >
> > The latent bug has existed since commit d9f2ecbc5e47 ("perf
> > dso: Move build_id to dso_id") introduced the
> > PERF_RECORD_MISC_MMAP_BUILD_ID check in
> > perf_record_mmap2__read_build_id(). Commit 53b00ff358dc ("perf
> > record: Make --buildid-mmap the default") then exposed it to
> > all users by making the MMAP2-with-build-ID path the default.
> > Both commits were merged in the same series.
> >
> > Clear the MMAP_BUILD_ID flag and zero the build_id union
> > before each call to perf_record_mmap2__read_build_id() so
> > that every module starts with a clean slate.
> >
> > Fixes: d9f2ecbc5e47 ("perf dso: Move build_id to dso_id")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  tools/perf/util/synthetic-events.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index ef79433ebc3a..ddf1cbda1902 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -703,6 +703,11 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
> >
> >                 memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
> >
> > +               /* Clear stale build ID from previous module iteration */
> > +               event->mmap2.header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
> > +               memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
> > +               event->mmap2.build_id_size = 0;
> > +
> >                 perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
> 
> Thanks for the report and fix. One thing this change will fix is the
> dso lookup, as the previous mmap2 event's build id would be read by
> perf_record_mmap2__read_build_id for the dso_id. The other fix
> addresses the written out mmap2 event, which now won't contain data
> from the last event when reading a module's build ID fails. If reading
> the build ID fails, since the build id misc bit is clear we should
> probably write the maj, min, ino and ino_generation fields. In
> perf_event__synthesize_mmap_events these are populated by the reading
> of the /proc/pid/maps file but in
> perf_event__synthesize_modules_maps_cb and
> __perf_event__synthesize_kernel_mmap we probably need to stat the file
> if possible - mind you the non-build ID code there uses an mmap event
> rather than an mmap2 event, where these fields aren't present.
> 
> So:
> Reviewed-by: Ian Rogers <irogers@google.com>
> But I think we can improve the perf_record_mmap2__read_build_id when
> filename__read_build_id fails.

Sure, but lets get this reviewed fix in for now, thanks to you both,

Thanks, applied to perf-tools, for v7.0.

- Arnaldo
 
> Thanks,
> Ian
> 
> >         } else {
> >                 size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
> > --
> > 2.53.0
> >
