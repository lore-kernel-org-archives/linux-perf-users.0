Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8666FC2D0A3
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Nov 2020 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5812222C
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Nov 2020 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH/OS8Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgKPQsm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbgKPQsm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Nov 2020 11:48:42 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7568520776;
        Mon, 16 Nov 2020 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605545321;
        bh=huIVde31aGxs6ItzBWIQV7PmFtheju7nSHKfdUkoNQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eH/OS8LlBbrXjg1hbeBV+f+LOWSkV4iGHN/beSk8W0VkG+SZBEU9meTCnDSaEuAmr
         G4DwAnRLtyENzNWHnO5WVuQsdsSwx+JZk0SGRXG8NoMAwSnOC5pHIRcw1lFMdCX3Oi
         jDK0u8gtLX1XiV8oLcZ9hZr3twRCfh9p9k9phVyE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 41F44411D1; Mon, 16 Nov 2020 13:48:39 -0300 (-03)
Date:   Mon, 16 Nov 2020 13:48:39 -0300
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
Message-ID: <20201116164839.GD509215@kernel.org>
References: <83633eb2-04dc-4a13-3ad7-abd3a7459ac1@foss.arm.com>
 <b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com>
 <CAM9d7cgmQ552DFpPo6b8kCwq4B9faSPxGE3tTBW6jfJd1xMVwA@mail.gmail.com>
 <20201116164533.GC509215@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116164533.GC509215@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Nov 16, 2020 at 01:45:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 17, 2020 at 01:25:09AM +0900, Namhyung Kim escreveu:
> > On Sat, Nov 14, 2020 at 5:38 AM Al Grant <al.grant@foss.arm.com> wrote:
> > > Mismatching sample_types are seen with "perf record -e cs_etm//",
> > > where the AUX event has TID|TIME|CPU|IDENTIFIER and the dummy
> > > event has TID|TIME|IDENTIFIER. Perhaps they could be the same,
> > > but it isn't normally a problem if they aren't - perf has
> > > no problems reading the file. The sample_types have to agree on
> > > the position of IDENTIFIER, because that's how perf finds the
> > > right event descriptor in the first place, but they don't normally
> > > have to agree on other fields, and perf doesn't check that they do.
> > > The problem is specific to the way "perf inject" reorganizes the
> > > events and the way synthetic MMAP events are recorded with a zero
> > > identifier. A simple solution is to stop "perf inject" deleting
> > > the tracing event.

> > > Signed-off-by: Al Grant <al.grant@arm.com>
> > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> > While I'm ok with this change,
> 
> So, to make progress, I'll take your phrase as an Acked-by, as described
> in Documentation/process/submitting-patches.rst, ok?

But I'll have to apply by hand:

[acme@five perf]$ am /wb/1.patch
warning: Patch sent with format=flowed; space at the end of lines might be lost.
Applying: perf inject corrupts file by deleting event
error: patch failed: tools/perf/builtin-inject.c:791
error: tools/perf/builtin-inject.c: patch does not apply
Patch failed at 0001 perf inject corrupts file by deleting event
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
[acme@five perf]$
