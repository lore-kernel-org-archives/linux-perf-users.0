Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F2C2D0A3
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Nov 2020 17:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42CE221F8
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Nov 2020 17:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQOp7htm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbgKPQ7u (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729849AbgKPQ7u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Nov 2020 11:59:50 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0569920773;
        Mon, 16 Nov 2020 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605545989;
        bh=LT5+rTERX8jGWbyDUURv5hSfq1VyEiKCvmY5DnNwRSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQOp7htmt57QXwGTKfdrUxYTSN/7VZfN6WCRTX/QyXDs7mwjBWh9ea+s6WQQ2p2ji
         LRpITw0g9872umaKiXh8u50Pe4mYYy+gM0VN/VIgnLOC9kXoS/S5nI0xQ9zvlE1Dbl
         c2aki1NDdCiv36EvNZcwRGNQZH8JTOcUbVQA4rG4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B3A43411D1; Mon, 16 Nov 2020 13:59:46 -0300 (-03)
Date:   Mon, 16 Nov 2020 13:59:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Al Grant <al.grant@foss.arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf inject corrupts file by deleting event
Message-ID: <20201116165946.GE509215@kernel.org>
References: <83633eb2-04dc-4a13-3ad7-abd3a7459ac1@foss.arm.com>
 <b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com>
 <CAM9d7cgmQ552DFpPo6b8kCwq4B9faSPxGE3tTBW6jfJd1xMVwA@mail.gmail.com>
 <20201116164533.GC509215@kernel.org>
 <20201116164839.GD509215@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116164839.GD509215@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Nov 16, 2020 at 01:48:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 16, 2020 at 01:45:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Nov 17, 2020 at 01:25:09AM +0900, Namhyung Kim escreveu:
> > > On Sat, Nov 14, 2020 at 5:38 AM Al Grant <al.grant@foss.arm.com> wrote:
> > > > Mismatching sample_types are seen with "perf record -e cs_etm//",
> > > > where the AUX event has TID|TIME|CPU|IDENTIFIER and the dummy
> > > > event has TID|TIME|IDENTIFIER. Perhaps they could be the same,
> > > > but it isn't normally a problem if they aren't - perf has
> > > > no problems reading the file. The sample_types have to agree on
> > > > the position of IDENTIFIER, because that's how perf finds the
> > > > right event descriptor in the first place, but they don't normally
> > > > have to agree on other fields, and perf doesn't check that they do.
> > > > The problem is specific to the way "perf inject" reorganizes the
> > > > events and the way synthetic MMAP events are recorded with a zero
> > > > identifier. A simple solution is to stop "perf inject" deleting
> > > > the tracing event.
> 
> > > > Signed-off-by: Al Grant <al.grant@arm.com>
> > > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> > > While I'm ok with this change,
> > 
> > So, to make progress, I'll take your phrase as an Acked-by, as described
> > in Documentation/process/submitting-patches.rst, ok?
> 
> But I'll have to apply by hand:
> 
> [acme@five perf]$ am /wb/1.patch
> warning: Patch sent with format=flowed; space at the end of lines might be lost.
> Applying: perf inject corrupts file by deleting event
> error: patch failed: tools/perf/builtin-inject.c:791
> error: tools/perf/builtin-inject.c: patch does not apply
> Patch failed at 0001 perf inject corrupts file by deleting event
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> [acme@five perf]$

And you also forgot to update the comment and to remove the now unused
'evsel' variable, find the updated patch below, please check.

Thanks,

- Arnaldo

commit 2dd954d9ec9059f330799a32d1cfa507beb18e1a
Author: Al Grant <al.grant@foss.arm.com>
Date:   Fri Nov 13 20:38:26 2020 +0000

    perf inject: Fix file corruption due to event deletion
    
    "perf inject" can create corrupt files when synthesizing sample events from AUX
    data. This happens when in the input file, the first event (for the AUX data)
    has a different sample_type from the second event (generally dummy).
    
    Specifically, they differ in the bits that indicate the standard fields
    appended to perf records in the mmap buffer. "perf inject" deletes the first
    event and moves up the second event to first position.
    
    The problem is with the synthetic PERF_RECORD_MMAP (etc.) events created
    by "perf record".
    
    Since these are synthetic versions of events which are normally produced
    by the kernel, they have to have the standard fields appended as
    described by sample_type.
    
    "perf record" fills these in with zeroes, including the IDENTIFIER
    field; perf readers interpret records with zero IDENTIFIER using the
    descriptor for the first event in the file.
    
    Since "perf inject" changes the first event, these synthetic records are
    then processed with the wrong value of sample_type, and the perf reader
    reads bad data, reports on incorrect length records etc.
    
    Mismatching sample_types are seen with "perf record -e cs_etm//", where the AUX
    event has TID|TIME|CPU|IDENTIFIER and the dummy event has TID|TIME|IDENTIFIER.
    
    Perhaps they could be the same, but it isn't normally a problem if they aren't
    - perf has no problems reading the file.
    
    The sample_types have to agree on the position of IDENTIFIER, because
    that's how perf finds the right event descriptor in the first place, but
    they don't normally have to agree on other fields, and perf doesn't
    check that they do.
    
    The problem is specific to the way "perf inject" reorganizes the events
    and the way synthetic MMAP events are recorded with a zero identifier. A
    simple solution is to stop "perf inject" deleting the tracing event.
    
    Committer testing
    
    Removed the now unused 'evsel' variable, update the comment about the
    evsel removal not being performed anymore, and apply the patch manually
    as it failed with this warning:
    
      warning: Patch sent with format=flowed; space at the end of lines might be lost.
    
    Testing it with:
    
      $ perf bench internals inject-build-id
      # Running 'internals/inject-build-id' benchmark:
        Average build-id injection took: 8.543 msec (+- 0.130 msec)
        Average time per event: 0.838 usec (+- 0.013 usec)
        Average memory usage: 12717 KB (+- 9 KB)
        Average build-id-all injection took: 5.710 msec (+- 0.058 msec)
        Average time per event: 0.560 usec (+- 0.006 usec)
        Average memory usage: 12079 KB (+- 7 KB)
      $
    
    Signed-off-by: Al Grant <al.grant@arm.com>
    Acked-by: Adrian Hunter <adrian.hunter@intel.com>
    Acked-by: Namhyung Kim <namhyung@kernel.org>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    LPU-Reference: b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 14d6c88fed76f249..43937f4b399ad2ca 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -779,25 +779,15 @@ static int __cmd_inject(struct perf_inject *inject)
 			dsos__hit_all(session);
 		/*
 		 * The AUX areas have been removed and replaced with
-		 * synthesized hardware events, so clear the feature flag and
-		 * remove the evsel.
+		 * synthesized hardware events, so clear the feature flag.
 		 */
 		if (inject->itrace_synth_opts.set) {
-			struct evsel *evsel;
-
 			perf_header__clear_feat(&session->header,
 						HEADER_AUXTRACE);
 			if (inject->itrace_synth_opts.last_branch ||
 			    inject->itrace_synth_opts.add_last_branch)
 				perf_header__set_feat(&session->header,
 						      HEADER_BRANCH_STACK);
-			evsel = perf_evlist__id2evsel_strict(session->evlist,
-							     inject->aux_id);
-			if (evsel) {
-				pr_debug("Deleting %s\n", evsel__name(evsel));
-				evlist__remove(session->evlist, evsel);
-				evsel__delete(evsel);
-			}
 		}
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
