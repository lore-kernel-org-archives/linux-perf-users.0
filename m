Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84292200BBC;
	Mon, 27 Oct 2025 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761541943; cv=none; b=gvRG0IDvPo/YaUhoqMA2DEeAe9xOIGdz7SsZFi+l/76xqouAzLAiWsMsYk4UeQjVKohMR9mc0otVeLf3U79uEgDrwy270qXgrRbri34+lMzmDD1hV1jYuKjWed6iKVrpF+gb2v9u+iP2JiaYUFNzIEfBuBC0hgHe3XRF4Y80Rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761541943; c=relaxed/simple;
	bh=A0q+CvQfamxlIZBjRtufx4OYKQoedhxJRf3w5vgrS8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geT5KQm7v2eVsY4MxAmDO3THEddQ+QF28OqGobErahN485Zd7/kE9TJfsoMkmuAs/Xi3xRyl3PlyMZO1yOhSpmz6StF34c2MS84vic5Mu8Ltjn8kJgBzJBMpfbvsIpf0F21gtZNN91IO3w4Ne5joLUkV5U8xq/aOmdZROH9ty70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lILmd1z4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lILmd1z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91404C4CEFB;
	Mon, 27 Oct 2025 05:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761541943;
	bh=A0q+CvQfamxlIZBjRtufx4OYKQoedhxJRf3w5vgrS8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lILmd1z4rEu7bhyvatmNKIBsObiAWVMayyIwUZ8VU+O3Spt4FbHL9MDnaHnn7ipwa
	 oEqRRKW+2NIUZZRLYTlwtipibAP6mR/ZTXIwZPxlfoE0sK2/BTec2g8uCmVCsA2b05
	 eSPwVgG0OV8PZ7aIwadLPv0lMbdgtN0Lg67sK1ZxjxcYm5WPnaKjV0VY7i6/iSU/dG
	 zWPaLox8OF/Gyo9a6tKBvkttdSGlw4Czs0dENshU1H9uRtm2zqxmjSzWDwceD1bety
	 G9zDVqnrjBLrZ2icomI5ZiOuJSRn8tosUI4XvkHSQgNkyd9DmLcTds0qDsTNxVBJ7w
	 QbSPD4XzYlubg==
Date: Sun, 26 Oct 2025 22:12:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dsos: Don't block when reading build IDs
Message-ID: <aP7_Ne-3JO9pB5Uh@google.com>
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
 <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>
 <aP1kSdZJKYIpnRia@google.com>
 <CAP-5=fUiO1uypnsw=G-FFj0xE=uCowG5FetaC9JGygOxybuGGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUiO1uypnsw=G-FFj0xE=uCowG5FetaC9JGygOxybuGGA@mail.gmail.com>

On Sat, Oct 25, 2025 at 09:52:01PM -0700, Ian Rogers wrote:
> On Sat, Oct 25, 2025 at 4:59 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Fri, Oct 24, 2025 at 11:26:18AM -0700, Ian Rogers wrote:
> > > On Wed, Oct 22, 2025 at 8:46 AM James Clark <james.clark@linaro.org> wrote:
> > > >
> > > > The following command will hang consistently when the GPU is being used
> > > > due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
> > > > being opened to read build IDs:
> > > >
> > > >  $ perf record -asdg -e cpu-clock -- true
> > > >
> > > > Change to non blocking reads to avoid the hang here:
> > > >
> > > >   #0  __libc_pread64 (offset=<optimised out>, count=0, buf=0x7fffffffa4a0, fd=237) at ../sysdeps/unix/sysv/linux/pread64.c:25
> > > >   #1  __libc_pread64 (fd=237, buf=0x7fffffffa4a0, count=0, offset=0) at ../sysdeps/unix/sysv/linux/pread64.c:23
> > > >   #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
> > > >   #3  read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:880
> > > >   #4  filename__read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:924
> > > >   #5  dsos__read_build_ids_cb (dso=0x5555562df1d0, data=0x7fffffffb750) at util/dsos.c:84
> > > >   #6  __dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:59
> > > >   #7  dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:503
> > > >   #8  dsos__read_build_ids (dsos=0x55555623de68, with_hits=true) at util/dsos.c:107
> > > >   #9  machine__read_build_ids (machine=0x55555623da58, with_hits=true) at util/build-id.c:950
> > > >   #10 perf_session__read_build_ids (session=0x55555623d840, with_hits=true) at util/build-id.c:956
> > > >   #11 write_build_id (ff=0x7fffffffb958, evlist=0x5555562323d0) at util/header.c:327
> > > >   #12 do_write_feat (ff=0x7fffffffb958, type=2, p=0x7fffffffb950, evlist=0x5555562323d0, fc=0x0) at util/header.c:3588
> > > >   #13 perf_header__adds_write (header=0x55555623d840, evlist=0x5555562323d0, fd=3, fc=0x0) at util/header.c:3632
> > > >   #14 perf_session__do_write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true, fc=0x0, write_attrs_after_data=false) at util/header.c:3756
> > > >   #15 perf_session__write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true) at util/header.c:3796
> > > >   #16 record__finish_output (rec=0x5555561838d8 <record>) at builtin-record.c:1899
> > > >   #17 __cmd_record (rec=0x5555561838d8 <record>, argc=2, argv=0x7fffffffe320) at builtin-record.c:2967
> > > >   #18 cmd_record (argc=2, argv=0x7fffffffe320) at builtin-record.c:4453
> > > >   #19 run_builtin (p=0x55555618cbb0 <commands+288>, argc=9, argv=0x7fffffffe320) at perf.c:349
> > > >   #20 handle_internal_command (argc=9, argv=0x7fffffffe320) at perf.c:401
> > > >   #21 run_argv (argcp=0x7fffffffe16c, argv=0x7fffffffe160) at perf.c:445
> > > >   #22 main (argc=9, argv=0x7fffffffe320) at perf.c:553
> > > >
> > > > Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
> > > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > > ---
> > > > I'm not actually sure if this is the right fix for this. Commit
> > > > 2c369d91d093 ("perf symbol: Add blocking argument to
> > > > filename__read_build_id") which added the blocking argument says that it
> > > > should be non-blocking reads for event synthesis, but the callstack here
> > > > is when writing the header out.
> > > >
> > > > There was also an is_regular_file() check added in commit c21986d33d6b
> > > > ("perf unwind-libdw: skip non-regular files"), which presumably falls
> > > > afoul of the "which unfortunately fails for symlinks" part of the other
> > > > linked commit message?
> > > >
> > > > So I can't tell if we should add the is_regular_file() check here too,
> > > > or just set it to non-blocking, or it needs some extra state to be
> > > > passed all the way down to dsos__read_build_ids_cb() to do different
> > > > things.
> > >
> > > The fix lgtm but I worry about making all the build ID reading
> > > non-blocking meaning build IDs getting lost.
> >
> > I'm not sure what non-blocking means for regular file system operations
> > on a block device.  But it may have some impact on regular files on a
> > network filesystem.
> 
> Agreed. Prior to using blocking we tried to imply from the file type
> from stat, but that skipped things like symlinks :-/
> 
> > > It seems that generating
> > > the build ID feature table is unnecessary if we have build ID mmap
> > > events, including synthesized ones that will have read the build IDs.
> > > I wonder if a better "fix" is:
> > > ```
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index cb52aea9607d..15f75c70eb76 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -1842,7 +1842,7 @@ static void record__init_features(struct record *rec)
> > >        for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
> > >                perf_header__set_feat(&session->header, feat);
> > >
> > > -       if (rec->no_buildid)
> > > +       if (rec->no_buildid || rec->buildid_mmap)
> > >                perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
> > >
> > >        if (!have_tracepoints(&rec->evlist->core.entries))
> > > ```
> > > that should disable the build ID feature table generation when build
> > > ID mmaps are in use (the default). Having the build IDs twice in the
> > > data file feels redundant. Or we could do your fix or both, wdyt?
> >
> > I'm ok to remove the header feature but I think it should update
> > build-ID cache even with this change.
> 
> Yeah, dropping the feature writing also impacts updating the build ID
> cache because:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/header.c?h=perf-tools-next#n338
> It is kind of strange that writing a header feature does this. What if
> I want to write a header with build IDs but not update the cache? It'd

There's -N/--no-buildid-cache option for that. :)


> make more sense, I think, for perf_session__cache_build_ids to be
> called explicitly. There is also the global no_buildid_cache
> controlling behavior:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/build-id.c?h=perf-tools-next#n43
> But that's kind of a hack as we may have >1 session such as with TPEBS.

Ouch.

> 
> > I'm also curious if the device has samples actually.  It should be
> > checked by dso->hit.

Anyway, --buildid-all would trigger the problem too.

> 
> In this case the header writing is happening after the samples have
> been processed, but it looks like marking of samples doesn't consider
> data addresses:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/build-id.c?h=perf-tools-next#n55
> just sample->ip and the callchain. If the marking was updated for data
> pages then just writing build IDs for marked dsos would make sense.

Makes sense.

> There could be callers not marking dsos so they'd need altering, or
> two versions of the code.

Hmm.. I think --buildid-mmap should enable caching by default while
skips the header feature.

How about this?


diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cb52aea9607d4612..ea778343f3c2d525 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1890,7 +1890,7 @@ record__finish_output(struct record *rec)
 	}
 
 	/* Buildid scanning disabled or build ID in kernel and synthesized map events. */
-	if (!rec->no_buildid) {
+	if (!rec->no_buildid || !rec->no_buildid_cache) {
 		process_buildids(rec);
 
 		if (rec->buildid_all)
@@ -3083,7 +3083,7 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 		else if (!strcmp(value, "no-cache"))
 			rec->no_buildid_cache = true;
 		else if (!strcmp(value, "skip"))
-			rec->no_buildid = true;
+			rec->no_buildid = rec->no_buildid_cache = true;
 		else if (!strcmp(value, "mmap"))
 			rec->buildid_mmap = true;
 		else if (!strcmp(value, "no-mmap"))
@@ -4192,16 +4192,6 @@ int cmd_record(int argc, const char **argv)
 		record.opts.record_switch_events = true;
 	}
 
-	if (!rec->buildid_mmap) {
-		pr_debug("Disabling build id in synthesized mmap2 events.\n");
-		symbol_conf.no_buildid_mmap2 = true;
-	} else if (rec->buildid_mmap_set) {
-		/*
-		 * Explicitly passing --buildid-mmap disables buildid processing
-		 * and cache generation.
-		 */
-		rec->no_buildid = true;
-	}
 	if (rec->buildid_mmap && !perf_can_record_build_id()) {
 		pr_warning("Missing support for build id in kernel mmap events.\n"
 			   "Disable this warning with --no-buildid-mmap\n");
@@ -4210,6 +4200,16 @@ int cmd_record(int argc, const char **argv)
 	if (rec->buildid_mmap) {
 		/* Enable perf_event_attr::build_id bit. */
 		rec->opts.build_id = true;
+		/* Disable build-ID table in the header */
+		rec->no_buildid = true;
+	} else {
+		pr_debug("Disabling build id in synthesized mmap2 events.\n");
+		symbol_conf.no_buildid_mmap2 = true;
+	}
+
+	if (rec->no_buildid_set && rec->no_buildid) {
+		/* -B implies -N for historic reason */
+		rec->no_buildid_cache = true;
 	}
 
 	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
@@ -4306,7 +4306,7 @@ int cmd_record(int argc, const char **argv)
 
 	err = -ENOMEM;
 
-	if (rec->no_buildid_cache || rec->no_buildid) {
+	if (rec->no_buildid_cache) {
 		disable_buildid_cache();
 	} else if (rec->switch_output.enabled) {
 		/*
