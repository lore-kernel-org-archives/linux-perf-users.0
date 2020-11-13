Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EB6C55ABD
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 20:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058592223C
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 20:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKMUia (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:38:30 -0500
Received: from foss.arm.com ([217.140.110.172]:45242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMUia (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Nov 2020 15:38:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93AD51042;
        Fri, 13 Nov 2020 12:38:29 -0800 (PST)
Received: from [10.57.54.165] (unknown [10.57.54.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6ACA83F73C;
        Fri, 13 Nov 2020 12:38:28 -0800 (PST)
Subject: [PATCH] perf inject corrupts file by deleting event
From:   Al Grant <al.grant@foss.arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <83633eb2-04dc-4a13-3ad7-abd3a7459ac1@foss.arm.com>
Message-ID: <b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com>
Date:   Fri, 13 Nov 2020 20:38:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <83633eb2-04dc-4a13-3ad7-abd3a7459ac1@foss.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

"perf inject" can create corrupt files when synthesizing sample
events from AUX data. This happens when in the input file, the
first event (for the AUX data) has a different sample_type from
the second event (generally dummy). Specifically, they differ in
the bits that indicate the standard fields appended to perf
records in the mmap buffer. "perf inject" deletes the first event
and moves up the second event to first position. The problem is
with the synthetic PERF_RECORD_MMAP (etc.) events created by
"perf record". Since these are synthetic versions of events which
are normally produced by the kernel, they have to have the
standard fields appended as described by sample_type. "perf record"
fills these in with zeroes, including the IDENTIFIER field;
perf readers interpret records with zero IDENTIFIER using the
descriptor for the first event in the file. Since "perf inject"
changes the first event, these synthetic records are then
processed with the wrong value of sample_type, and the perf
reader reads bad data, reports on incorrect length records etc.

Mismatching sample_types are seen with "perf record -e cs_etm//",
where the AUX event has TID|TIME|CPU|IDENTIFIER and the dummy
event has TID|TIME|IDENTIFIER. Perhaps they could be the same,
but it isn't normally a problem if they aren't - perf has
no problems reading the file. The sample_types have to agree on
the position of IDENTIFIER, because that's how perf finds the
right event descriptor in the first place, but they don't normally
have to agree on other fields, and perf doesn't check that they do.
The problem is specific to the way "perf inject" reorganizes the
events and the way synthetic MMAP events are recorded with a zero
identifier. A simple solution is to stop "perf inject" deleting
the tracing event.

Signed-off-by: Al Grant <al.grant@arm.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
  tools/perf/builtin-inject.c | 7 -------
  1 file changed, 7 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 452a75fe68e5..f4968ebf5f3a 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -791,13 +791,6 @@ static int __cmd_inject(struct perf_inject *inject)
                             inject->itrace_synth_opts.add_last_branch)
                                 perf_header__set_feat(&session->header,
                                                       HEADER_BRANCH_STACK);
-                       evsel = perf_evlist__id2evsel_strict(session->evlist,
-                                                            inject->aux_id);
-                       if (evsel) {
-                               pr_debug("Deleting %s\n", evsel__name(evsel));
-                               evlist__remove(session->evlist, evsel);
-                               evsel__delete(evsel);
-                       }
                 }
                 session->header.data_offset = output_data_offset;
                 session->header.data_size = inject->bytes_written;
