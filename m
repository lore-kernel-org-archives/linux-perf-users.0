Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A92C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EB960F6C
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 13:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbhIANdA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244094AbhIANdA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 09:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63D8B60200;
        Wed,  1 Sep 2021 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630503123;
        bh=lQiT5sFGSvlcw0u0I3GnlEeTwSSvr9e7J58cF9izyrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B396PbUzQzsifGRVpXtlyFgazXL77NfdBfVM1v7etVbtLPpBQCz4fzgDSmD9VWcmT
         usKV5AW9RElDlLMxIk/E2e8yTGNioAZcOfuffDaLzPeGd7u9foYt9SzOoxdUOywo8x
         ySsv+HUft2gcFEzv0e+6gH0eqevy8OUCZqs+F5JeGZYx15t+zWdtyYgkcsw6MoD2z6
         ms5NYKY9HxQjcOrOVhMBuKA9/Zk+hvj1UZrmowyghcG9FkBSdSsnNHSRQFv3bMlnQD
         DsqIMR9/D7mMSi+ioGJyT+p2uqiCtr0LSigW+pHCc7znBDx/iPmXZORRGn+1rQT6HM
         BEh1kX2j6tOwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D52004007E; Wed,  1 Sep 2021 10:31:59 -0300 (-03)
Date:   Wed, 1 Sep 2021 10:31:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf script python: Allow reporting [un]throttle
Message-ID: <YS+AzzoPci74EmWp@kernel.org>
References: <20210817002133.48097-1-stephen.s.brennan@oracle.com>
 <YS55BApYslmJuqPh@krava>
 <3035e557-9752-9277-6a84-f6d65a6a119e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3035e557-9752-9277-6a84-f6d65a6a119e@oracle.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 31, 2021 at 02:47:47PM -0700, Stephen Brennan escreveu:
> On 8/31/21 11:46 AM, Jiri Olsa wrote:
> > On Mon, Aug 16, 2021 at 05:21:33PM -0700, Stephen Brennan wrote:
> > > perf_events may sometimes throttle an event due to creating too many
> > > samples during a given timer tick. As of now, the perf tool will not
> > > report on throttling, which means this is a silent error. Implement a
> > > callback for the throttle and unthrottle events within the Python
> > > scripting engine, which can allow scripts to detect and report when
> > > events may have been lost due to throttling.

> > > A python script could simply define throttle() and unthrottle()
> > > functions to begin receiving them, e.g.:

> > > ```
> > > from __future__ import print_function

> > > def process_event(param_dict):
> > >      print("event cpu={} time={}".format(
> > >          param_dict["sample"]["cpu"], param_dict["sample"]["time"]))

> > > def throttle(*args):
> > >      print("throttle(time={}, cpu={}, pid={}, tid={})".format(*args))

> > > def unthrottle(*args):
> > >      print("unthrottle(time={}, cpu={}, pid={}, tid={})".format(*args))
> > > ```

> > throttle event has also 'id' and 'stream_id' I guess you don't
> > need it, but maybe we should add it to be complete

> I tried adding these from struct perf_sample.id and struct
> perf_sample.sample_id respectively. I then tested these on a perf.data which
> contains a throttle event. The values which my python script reported were
> 0xFFFFFFFFFFFFFFFF -- is this expected? If so, I'll send my revised patch.

So, perf_sample.X is only defined if PERF_SAMPLE_X is in
perf_event_attr.sample_type, and for the perf.data file below it is:

  sample_type = IP|TID|TIME

So only perf_sample.ip, perf_sample.tid and perf_sample.time are set,
not perf_sample.id nor perf_sample.stream_id.

What Jiri suggests is to use the _fixed_ payload for
PERF_SAMPLE_THROTTLE/UNTHROTTLE, which is, according to
include/uapi/linux/perf_event.h:

         * struct {
         *      struct perf_event_header        header;
         *      u64                             time;          <<<<
         *      u64                             id;            <<<<
         *      u64                             stream_id;     <<<<
         *      struct sample_id                sample_id;
         * };
         */
        PERF_RECORD_THROTTLE                    = 5,
        PERF_RECORD_UNTHROTTLE                  = 6,
 

The 'time', 'id' and 'stream_id' should always be there, while what is
in 'sample_id' is documented in the same file at the beginning of the
'enum perf_event_type' definition:

         * If perf_event_attr.sample_id_all is set then all event types will
         * have the sample_type selected fields related to where/when
         * (identity) an event took place (TID, TIME, ID, STREAM_ID, CPU,
         * IDENTIFIER) described in PERF_RECORD_SAMPLE below, it will be stashed
         * just after the perf_event_header and the fields already present for
         * the existing fields, i.e. at the end of the payload. That way a newer
         * perf.data file will be supported by older perf tools, with these new
         * optional fields being ignored.
         *
         * struct sample_id {
         *      { u32                   pid, tid; } && PERF_SAMPLE_TID
         *      { u64                   time;     } && PERF_SAMPLE_TIME
         *      { u64                   id;       } && PERF_SAMPLE_ID
         *      { u64                   stream_id;} && PERF_SAMPLE_STREAM_ID
         *      { u32                   cpu, res; } && PERF_SAMPLE_CPU
         *      { u64                   id;       } && PERF_SAMPLE_IDENTIFIER
         * } && perf_event_attr::sample_id_all
         *
         * Note that PERF_SAMPLE_IDENTIFIER duplicates PERF_SAMPLE_ID.  The
         * advantage of PERF_SAMPLE_IDENTIFIER is that its position is fixed
         * relative to header.size.

There are artifacts here from the evolution of the perf_event subsystem,
i.e. throttle.id is equal to throttle.sample-id.id when PERF_SAMPLE_ID
is set in perf_event_attr.sample_type, ditto for 'time' and 'stream_id'.
entries.

But since 'time', 'id' and 'stream_id' are _always_ set in the
PERF_RECORD_THROTTLE event, we can as well make them available via perf
script python.

Take a look at ./kernel/events/core.c, function perf_log_throttle(), the
only one in the kernel that emits the PERF_RECORD_THROTTLE meta event
and see that it always set the 'time', 'id' and 'stream_id' fields:

static void perf_log_throttle(struct perf_event *event, int enable)
{
        struct perf_output_handle handle;
        struct perf_sample_data sample;
        int ret;

        struct {
                struct perf_event_header        header;
                u64                             time;
                u64                             id;
                u64                             stream_id;
        } throttle_event = {
                .header = {
                        .type = PERF_RECORD_THROTTLE,
                        .misc = 0,
                        .size = sizeof(throttle_event),
                },
                .time           = perf_event_clock(event),
                .id             = primary_event_id(event),
                .stream_id      = event->id,
        };

        if (enable)
                throttle_event.header.type = PERF_RECORD_UNTHROTTLE;

        perf_event_header__init_id(&throttle_event.header, &sample, event);

        ret = perf_output_begin(&handle, &sample, event,
                                throttle_event.header.size);
        if (ret)
                return;

        perf_output_put(&handle, throttle_event);
        perf_event__output_id_sample(event, &handle, &sample);
        perf_output_end(&handle);
}

So instead of doing:

+       tuple_set_u64(t, 0, sample->time);
+       tuple_set_s32(t, 1, sample->cpu);
+       tuple_set_s32(t, 2, sample->pid);
+       tuple_set_s32(t, 3, sample->tid);

That may not be set at all, you should do:

+       tuple_set_u64(t, 0, event->throttle.time);
+       tuple_set_u64(t, 1, event->throttle.id);
+       tuple_set_u64(t, 2, event->throttle.stream_id);

These can be left as is with 0xFFFFFFFFFFFFFFFF meaning its not set:

+       tuple_set_s32(t, 3, sample->cpu);
+       tuple_set_s32(t, 4, sample->pid);
+       tuple_set_s32(t, 5, sample->tid);

to confirm the user can look at perf_event_attr.sample_type |
PERF_SAMPLE_X.

- Arnaldo

> Thanks,
> Stephen
> 
> `perf report --header-only` from my testing perf.data:
> 
> # ========
> # captured on    : Wed Aug 11 11:55:44 2021
> # header version : 1
> # data offset    : 264
> # data size      : 18240
> # feat offset    : 18504
> # hostname : stepbren-ol7-2
> # os release : 5.4.17-2102.203.6.el7uek.x86_64
> # perf version : 5.4.17-2102.203.6.el7uek.x86_64
> # arch : x86_64
> # nrcpus online : 4
> # nrcpus avail : 4
> # cpudesc : Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
> # cpuid : GenuineIntel,6,85,4
> # total memory : 30522624 kB
> # cmdline : /usr/libexec/perf.5.4.17-2102.203.6.el7uek.x86_64 record -c
> 100000 -e cycles -- sh -c echo 2000 > /proc/irqoff_sleep_millis
> # event : name = cycles, , id = { 5, 6, 7, 8 }, size = 112, { sample_period,
> sample_freq } = 100000, sample_type = IP|TID|TIME, read_format = ID,
> disabled = 1, inherit = 1, mmap = 1, comm = 1, enable_on_exec = 1, task = 1,
> sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1,
> bpf_event = 1
> # CPU_TOPOLOGY info available, use -I to display
> # NUMA_TOPOLOGY info available, use -I to display
> # pmu mappings: software = 1, uprobe = 7, cpu = 4, breakpoint = 5,
> tracepoint = 2, kprobe = 6, msr = 8
> # CACHE info available, use -I to display
> # time of first sample : 228.321751
> # time of last sample : 230.362698
> # sample duration :   2040.947 ms
> # MEM_TOPOLOGY info available, use -I to display
> # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT
> CLOCKID DIR_FORMAT COMPRESSED CPU_PMU_CAPS CLOCK_DATA HYBRID_TOPOLOGY
> HYBRID_CPU_PMU_CAPS
> # ========
