Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A7C5519F
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Nov 2020 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D4C222B9
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Nov 2020 16:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgKPQZW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:25:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33173 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKPQZW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Nov 2020 11:25:22 -0500
Received: by mail-qt1-f196.google.com with SMTP id i12so13268029qtj.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2020 08:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=331BjM9xP6BwgcVZn6GKoy9/jzT3BhLEnoVD+T4DmVI=;
        b=doGMTxdf3Ol8qxflPupiA5z0SwGtoq+5weCMKrwCsQmMbECqPe4mWsrdCPSEfeBSKO
         lY+cAhtY2fVo3ogXZS8mNreHiY7/IgjKU7T1vjpT5deG9H1nBpKgqtrswHi+lU+J246g
         JhmuNuBYG74ObhW6r/WkB3kQxywV1Dyb2GNSwN4tZ0376BS5/IADBdwFEKabQQgKfYtR
         a/2SyzWndNDvB+C9e2THIO3nwpESu3s9YTk1+/UENMqQ3+EW+14s3vl2OPilL97HbG2J
         fnAbJEVrdZOhEND7HOA3IMfqyBc5s2/sKyqjoD7jEYyJQsDvBGMGJ5SZmx0+SRpn0s7R
         HxgQ==
X-Gm-Message-State: AOAM531FqdZNd0yKokAtJJsDU03nv4JBSwu9flqjY7MZZqk/OS0N1off
        n4lbDjpOMuGERmYIXmvXUVtiTZPjsIAR8OGFxoI=
X-Google-Smtp-Source: ABdhPJyaxdGZrLLyK38/ZQNhB1mxQO3ed85jsKaxkcFR3VZULE7RVw8dAnSL/aYPYsdrWjRhYRAuUFsH7aWuMBnsjlk=
X-Received: by 2002:ac8:4d92:: with SMTP id a18mr14981074qtw.256.1605543920856;
 Mon, 16 Nov 2020 08:25:20 -0800 (PST)
MIME-Version: 1.0
References: <83633eb2-04dc-4a13-3ad7-abd3a7459ac1@foss.arm.com> <b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com>
In-Reply-To: <b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 Nov 2020 01:25:09 +0900
Message-ID: <CAM9d7cgmQ552DFpPo6b8kCwq4B9faSPxGE3tTBW6jfJd1xMVwA@mail.gmail.com>
Subject: Re: [PATCH] perf inject corrupts file by deleting event
To:     Al Grant <al.grant@foss.arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Sat, Nov 14, 2020 at 5:38 AM Al Grant <al.grant@foss.arm.com> wrote:
>
> "perf inject" can create corrupt files when synthesizing sample
> events from AUX data. This happens when in the input file, the
> first event (for the AUX data) has a different sample_type from
> the second event (generally dummy). Specifically, they differ in
> the bits that indicate the standard fields appended to perf
> records in the mmap buffer. "perf inject" deletes the first event
> and moves up the second event to first position. The problem is
> with the synthetic PERF_RECORD_MMAP (etc.) events created by
> "perf record". Since these are synthetic versions of events which
> are normally produced by the kernel, they have to have the
> standard fields appended as described by sample_type. "perf record"
> fills these in with zeroes, including the IDENTIFIER field;
> perf readers interpret records with zero IDENTIFIER using the
> descriptor for the first event in the file. Since "perf inject"
> changes the first event, these synthetic records are then
> processed with the wrong value of sample_type, and the perf
> reader reads bad data, reports on incorrect length records etc.
>
> Mismatching sample_types are seen with "perf record -e cs_etm//",
> where the AUX event has TID|TIME|CPU|IDENTIFIER and the dummy
> event has TID|TIME|IDENTIFIER. Perhaps they could be the same,
> but it isn't normally a problem if they aren't - perf has
> no problems reading the file. The sample_types have to agree on
> the position of IDENTIFIER, because that's how perf finds the
> right event descriptor in the first place, but they don't normally
> have to agree on other fields, and perf doesn't check that they do.
> The problem is specific to the way "perf inject" reorganizes the
> events and the way synthetic MMAP events are recorded with a zero
> identifier. A simple solution is to stop "perf inject" deleting
> the tracing event.
>
> Signed-off-by: Al Grant <al.grant@arm.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>

While I'm ok with this change, I think we can put the dummy events
to the front of the evlist (during record) so that we can make sure that
tracking records would refer to them in order to parse the data.

And I also think that we should omit the dummy events from the
perf report output.

Thanks,
Namhyung


> ---
>   tools/perf/builtin-inject.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 452a75fe68e5..f4968ebf5f3a 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -791,13 +791,6 @@ static int __cmd_inject(struct perf_inject *inject)
>                              inject->itrace_synth_opts.add_last_branch)
>                                  perf_header__set_feat(&session->header,
>                                                        HEADER_BRANCH_STACK);
> -                       evsel = perf_evlist__id2evsel_strict(session->evlist,
> -                                                            inject->aux_id);
> -                       if (evsel) {
> -                               pr_debug("Deleting %s\n", evsel__name(evsel));
> -                               evlist__remove(session->evlist, evsel);
> -                               evsel__delete(evsel);
> -                       }
>                  }
>                  session->header.data_offset = output_data_offset;
>                  session->header.data_size = inject->bytes_written;
