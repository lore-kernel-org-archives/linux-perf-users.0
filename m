Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3AFC2BB48
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Dec 2020 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC69224B1
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Dec 2020 09:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgLOJtY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Dec 2020 04:49:24 -0500
Received: from foss.arm.com ([217.140.110.172]:58272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgLOJtR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Dec 2020 04:49:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FCFE1FB;
        Tue, 15 Dec 2020 01:48:35 -0800 (PST)
Received: from [10.57.62.191] (unknown [10.57.62.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CED473F66E;
        Tue, 15 Dec 2020 01:48:33 -0800 (PST)
Subject: Re: [PATCH] perf inject corrupts file by deleting event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <83633eb2-04dc-4a13-3ad7-abd3a7459ac1@foss.arm.com>
 <b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com>
 <CAM9d7cgmQ552DFpPo6b8kCwq4B9faSPxGE3tTBW6jfJd1xMVwA@mail.gmail.com>
 <20201116164533.GC509215@kernel.org> <20201116164839.GD509215@kernel.org>
 <20201116165946.GE509215@kernel.org>
From:   Al Grant <al.grant@foss.arm.com>
Message-ID: <5d085d2a-7f76-88ab-25c4-1370f7e1589e@foss.arm.com>
Date:   Tue, 15 Dec 2020 09:48:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20201116165946.GE509215@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 16/11/2020 16:59, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 16, 2020 at 01:48:39PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Nov 16, 2020 at 01:45:33PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Tue, Nov 17, 2020 at 01:25:09AM +0900, Namhyung Kim escreveu:
>>>> On Sat, Nov 14, 2020 at 5:38 AM Al Grant <al.grant@foss.arm.com> wrote:
>>>>> Mismatching sample_types are seen with "perf record -e cs_etm//",
>>>>> where the AUX event has TID|TIME|CPU|IDENTIFIER and the dummy
>>>>> event has TID|TIME|IDENTIFIER. Perhaps they could be the same,
>>>>> but it isn't normally a problem if they aren't - perf has
>>>>> no problems reading the file. The sample_types have to agree on
>>>>> the position of IDENTIFIER, because that's how perf finds the
>>>>> right event descriptor in the first place, but they don't normally
>>>>> have to agree on other fields, and perf doesn't check that they do.
>>>>> The problem is specific to the way "perf inject" reorganizes the
>>>>> events and the way synthetic MMAP events are recorded with a zero
>>>>> identifier. A simple solution is to stop "perf inject" deleting
>>>>> the tracing event.
>>
>>>>> Signed-off-by: Al Grant <al.grant@arm.com>
>>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>>>> While I'm ok with this change,
>>>
>>> So, to make progress, I'll take your phrase as an Acked-by, as described
>>> in Documentation/process/submitting-patches.rst, ok?
>>
>> But I'll have to apply by hand:
>>
>> [acme@five perf]$ am /wb/1.patch
>> warning: Patch sent with format=flowed; space at the end of lines might be lost.
>> Applying: perf inject corrupts file by deleting event
>> error: patch failed: tools/perf/builtin-inject.c:791
>> error: tools/perf/builtin-inject.c: patch does not apply
>> Patch failed at 0001 perf inject corrupts file by deleting event
>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>> [acme@five perf]$
> 
> And you also forgot to update the comment and to remove the now unused
> 'evsel' variable, find the updated patch below, please check.

Thanks for tidying it up, it looks good to me. Do you need me to resubmit
or can you take it as it is now with your changes?

Al


> 
> Thanks,
> 
> - Arnaldo
> 
> commit 2dd954d9ec9059f330799a32d1cfa507beb18e1a
> Author: Al Grant <al.grant@foss.arm.com>
> Date:   Fri Nov 13 20:38:26 2020 +0000
> 
>      perf inject: Fix file corruption due to event deletion
>      
>      "perf inject" can create corrupt files when synthesizing sample events from AUX
>      data. This happens when in the input file, the first event (for the AUX data)
>      has a different sample_type from the second event (generally dummy).
>      
>      Specifically, they differ in the bits that indicate the standard fields
>      appended to perf records in the mmap buffer. "perf inject" deletes the first
>      event and moves up the second event to first position.
>      
>      The problem is with the synthetic PERF_RECORD_MMAP (etc.) events created
>      by "perf record".
>      
>      Since these are synthetic versions of events which are normally produced
>      by the kernel, they have to have the standard fields appended as
>      described by sample_type.
>      
>      "perf record" fills these in with zeroes, including the IDENTIFIER
>      field; perf readers interpret records with zero IDENTIFIER using the
>      descriptor for the first event in the file.
>      
>      Since "perf inject" changes the first event, these synthetic records are
>      then processed with the wrong value of sample_type, and the perf reader
>      reads bad data, reports on incorrect length records etc.
>      
>      Mismatching sample_types are seen with "perf record -e cs_etm//", where the AUX
>      event has TID|TIME|CPU|IDENTIFIER and the dummy event has TID|TIME|IDENTIFIER.
>      
>      Perhaps they could be the same, but it isn't normally a problem if they aren't
>      - perf has no problems reading the file.
>      
>      The sample_types have to agree on the position of IDENTIFIER, because
>      that's how perf finds the right event descriptor in the first place, but
>      they don't normally have to agree on other fields, and perf doesn't
>      check that they do.
>      
>      The problem is specific to the way "perf inject" reorganizes the events
>      and the way synthetic MMAP events are recorded with a zero identifier. A
>      simple solution is to stop "perf inject" deleting the tracing event.
>      
>      Committer testing
>      
>      Removed the now unused 'evsel' variable, update the comment about the
>      evsel removal not being performed anymore, and apply the patch manually
>      as it failed with this warning:
>      
>        warning: Patch sent with format=flowed; space at the end of lines might be lost.
>      
>      Testing it with:
>      
>        $ perf bench internals inject-build-id
>        # Running 'internals/inject-build-id' benchmark:
>          Average build-id injection took: 8.543 msec (+- 0.130 msec)
>          Average time per event: 0.838 usec (+- 0.013 usec)
>          Average memory usage: 12717 KB (+- 9 KB)
>          Average build-id-all injection took: 5.710 msec (+- 0.058 msec)
>          Average time per event: 0.560 usec (+- 0.006 usec)
>          Average memory usage: 12079 KB (+- 7 KB)
>        $
>      
>      Signed-off-by: Al Grant <al.grant@arm.com>
>      Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>      Acked-by: Namhyung Kim <namhyung@kernel.org>
>      Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>      Cc: Jiri Olsa <jolsa@redhat.com>
>      Cc: Mark Rutland <mark.rutland@arm.com>
>      Cc: Peter Zijlstra <peterz@infradead.org>
>      LPU-Reference: b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com
>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 14d6c88fed76f249..43937f4b399ad2ca 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -779,25 +779,15 @@ static int __cmd_inject(struct perf_inject *inject)
>   			dsos__hit_all(session);
>   		/*
>   		 * The AUX areas have been removed and replaced with
> -		 * synthesized hardware events, so clear the feature flag and
> -		 * remove the evsel.
> +		 * synthesized hardware events, so clear the feature flag.
>   		 */
>   		if (inject->itrace_synth_opts.set) {
> -			struct evsel *evsel;
> -
>   			perf_header__clear_feat(&session->header,
>   						HEADER_AUXTRACE);
>   			if (inject->itrace_synth_opts.last_branch ||
>   			    inject->itrace_synth_opts.add_last_branch)
>   				perf_header__set_feat(&session->header,
>   						      HEADER_BRANCH_STACK);
> -			evsel = perf_evlist__id2evsel_strict(session->evlist,
> -							     inject->aux_id);
> -			if (evsel) {
> -				pr_debug("Deleting %s\n", evsel__name(evsel));
> -				evlist__remove(session->evlist, evsel);
> -				evsel__delete(evsel);
> -			}
>   		}
>   		session->header.data_offset = output_data_offset;
>   		session->header.data_size = inject->bytes_written;
> 
