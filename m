Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF672F5B;
	Sat, 25 Oct 2025 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761436750; cv=none; b=onZTFoclGAVKEj8DWTqdcg+hEOQeA/3s3yrR0IKmdp03hT4PRg/nE2KzR3k5FCB0fPNYoGFoLoUAVp9ZLzzKO+xTzINLZ68JwEEOymCqu/XMSaQ+7xy7q/dlLswn7uJvMZeqXR75MXESDViZY4mUUtW0WPrV7+qnhWNqyXWQOxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761436750; c=relaxed/simple;
	bh=06zKdO6I7W5EZ/u4lGAMePBVjzLmVb5JfE/SpsSIUz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeTlelaN/zCIVt/OoL0SZS0vmwosAzMTe5N7YFq0WLsj4GJt6UolHLbKbgFMTaQLpdFSvoK64+FMqPmiP44GONC1WZr4bPjJlcbu/Sesu8HC1GlOSmz7/nFOe+M00YCqmu1t7iKg2ZWpDSf0mNKos36qcdG+73At4V+NPyvYfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ8F/zae; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ8F/zae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF94C4CEF5;
	Sat, 25 Oct 2025 23:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761436748;
	bh=06zKdO6I7W5EZ/u4lGAMePBVjzLmVb5JfE/SpsSIUz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZ8F/zaezdd8RK5F1IbDyfZVKVQ3LoqH5cEbdMROi36mprGMqmhdoK6CJNhfFecfP
	 3jFu0Cp+6J/RDUaThrRvFZYciv3QHR7N4vAL/wGCkqUHC80UypDYeNMYtbs69rPR1S
	 w0FRBtxWIEZyLIgTlRcUvu7Z3+sCAoRXPvsSKPBeeNKn4129BAALx6uj/Np6bJ26yO
	 NK0DE/FlpBbWBqsCAWrgZUAPtXzmQd25C/nLQmaucZB83vBPQIKHwTZtzF1wfkvKFp
	 tLJENk/s76/66PkFZXTAOZ+JfiVU/6eX43h5hnPyX6zF+FTarcpaKcIFwnC0WYqz4Z
	 WKrjUHNM50uzg==
Date: Sat, 25 Oct 2025 16:59:05 -0700
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
Message-ID: <aP1kSdZJKYIpnRia@google.com>
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
 <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>

Hello,

On Fri, Oct 24, 2025 at 11:26:18AM -0700, Ian Rogers wrote:
> On Wed, Oct 22, 2025 at 8:46 AM James Clark <james.clark@linaro.org> wrote:
> >
> > The following command will hang consistently when the GPU is being used
> > due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
> > being opened to read build IDs:
> >
> >  $ perf record -asdg -e cpu-clock -- true
> >
> > Change to non blocking reads to avoid the hang here:
> >
> >   #0  __libc_pread64 (offset=<optimised out>, count=0, buf=0x7fffffffa4a0, fd=237) at ../sysdeps/unix/sysv/linux/pread64.c:25
> >   #1  __libc_pread64 (fd=237, buf=0x7fffffffa4a0, count=0, offset=0) at ../sysdeps/unix/sysv/linux/pread64.c:23
> >   #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
> >   #3  read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:880
> >   #4  filename__read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:924
> >   #5  dsos__read_build_ids_cb (dso=0x5555562df1d0, data=0x7fffffffb750) at util/dsos.c:84
> >   #6  __dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:59
> >   #7  dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:503
> >   #8  dsos__read_build_ids (dsos=0x55555623de68, with_hits=true) at util/dsos.c:107
> >   #9  machine__read_build_ids (machine=0x55555623da58, with_hits=true) at util/build-id.c:950
> >   #10 perf_session__read_build_ids (session=0x55555623d840, with_hits=true) at util/build-id.c:956
> >   #11 write_build_id (ff=0x7fffffffb958, evlist=0x5555562323d0) at util/header.c:327
> >   #12 do_write_feat (ff=0x7fffffffb958, type=2, p=0x7fffffffb950, evlist=0x5555562323d0, fc=0x0) at util/header.c:3588
> >   #13 perf_header__adds_write (header=0x55555623d840, evlist=0x5555562323d0, fd=3, fc=0x0) at util/header.c:3632
> >   #14 perf_session__do_write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true, fc=0x0, write_attrs_after_data=false) at util/header.c:3756
> >   #15 perf_session__write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true) at util/header.c:3796
> >   #16 record__finish_output (rec=0x5555561838d8 <record>) at builtin-record.c:1899
> >   #17 __cmd_record (rec=0x5555561838d8 <record>, argc=2, argv=0x7fffffffe320) at builtin-record.c:2967
> >   #18 cmd_record (argc=2, argv=0x7fffffffe320) at builtin-record.c:4453
> >   #19 run_builtin (p=0x55555618cbb0 <commands+288>, argc=9, argv=0x7fffffffe320) at perf.c:349
> >   #20 handle_internal_command (argc=9, argv=0x7fffffffe320) at perf.c:401
> >   #21 run_argv (argcp=0x7fffffffe16c, argv=0x7fffffffe160) at perf.c:445
> >   #22 main (argc=9, argv=0x7fffffffe320) at perf.c:553
> >
> > Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> > I'm not actually sure if this is the right fix for this. Commit
> > 2c369d91d093 ("perf symbol: Add blocking argument to
> > filename__read_build_id") which added the blocking argument says that it
> > should be non-blocking reads for event synthesis, but the callstack here
> > is when writing the header out.
> >
> > There was also an is_regular_file() check added in commit c21986d33d6b
> > ("perf unwind-libdw: skip non-regular files"), which presumably falls
> > afoul of the "which unfortunately fails for symlinks" part of the other
> > linked commit message?
> >
> > So I can't tell if we should add the is_regular_file() check here too,
> > or just set it to non-blocking, or it needs some extra state to be
> > passed all the way down to dsos__read_build_ids_cb() to do different
> > things.
> 
> The fix lgtm but I worry about making all the build ID reading
> non-blocking meaning build IDs getting lost. 

I'm not sure what non-blocking means for regular file system operations
on a block device.  But it may have some impact on regular files on a
network filesystem.

> It seems that generating
> the build ID feature table is unnecessary if we have build ID mmap
> events, including synthesized ones that will have read the build IDs.
> I wonder if a better "fix" is:
> ```
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index cb52aea9607d..15f75c70eb76 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1842,7 +1842,7 @@ static void record__init_features(struct record *rec)
>        for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
>                perf_header__set_feat(&session->header, feat);
> 
> -       if (rec->no_buildid)
> +       if (rec->no_buildid || rec->buildid_mmap)
>                perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
> 
>        if (!have_tracepoints(&rec->evlist->core.entries))
> ```
> that should disable the build ID feature table generation when build
> ID mmaps are in use (the default). Having the build IDs twice in the
> data file feels redundant. Or we could do your fix or both, wdyt?

I'm ok to remove the header feature but I think it should update
build-ID cache even with this change.

I'm also curious if the device has samples actually.  It should be
checked by dso->hit.

Thanks,
Namhyung

> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/dsos.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> > index 64c1d65b0149..5e1c815d7cb0 100644
> > --- a/tools/perf/util/dsos.c
> > +++ b/tools/perf/util/dsos.c
> > @@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
> >                 return 0;
> >         }
> >         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> > -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0) {
> > +       /* Don't block in case path isn't for a regular file. */
> > +       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/false) > 0) {
> >                 dso__set_build_id(dso, &bid);
> >                 args->have_build_id = true;
> >         } else if (errno == ENOENT && dso__nsinfo(dso)) {
> >                 char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
> >
> > -               if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0) {
> > +               if (new_name && filename__read_build_id(new_name, &bid, /*block=*/false) > 0) {
> >                         dso__set_build_id(dso, &bid);
> >                         args->have_build_id = true;
> >                 }
> >
> > ---
> > base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
> > change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0
> >
> > Best regards,
> > --
> > James Clark <james.clark@linaro.org>
> >
