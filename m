Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7CC04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 11:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiG1Lot (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 07:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiG1Los (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 07:44:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CC426591
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 04:44:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A31106F;
        Thu, 28 Jul 2022 04:44:47 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EFAC3F73B;
        Thu, 28 Jul 2022 04:44:46 -0700 (PDT)
Message-ID: <891abd4d-6108-01eb-f280-70306c503581@foss.arm.com>
Date:   Thu, 28 Jul 2022 12:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/14] perf test: Add CoreSight shell lib shared code for
 future tests
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
 <20220712135750.2212005-3-carsten.haitzler@foss.arm.com>
 <CAJ9a7VjBSouo23J2Ws8hw1Gck2b7W4sbxGN+PzjsLHhDAxSP1Q@mail.gmail.com>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <CAJ9a7VjBSouo23J2Ws8hw1Gck2b7W4sbxGN+PzjsLHhDAxSP1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 7/13/22 13:49, Mike Leach wrote:
> Hi Carsten,
> 
> On Tue, 12 Jul 2022 at 14:58, <carsten.haitzler@foss.arm.com> wrote:
>>
>> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>>
>> This adds a library of shell "code" to be shared and used by future
>> tests that target quality testing for Arm CoreSight support in perf
>> and the Linux kernel.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   tools/perf/tests/shell/lib/coresight.sh | 129 ++++++++++++++++++++++++
>>   1 file changed, 129 insertions(+)
>>   create mode 100644 tools/perf/tests/shell/lib/coresight.sh
>>
>> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
>> new file mode 100644
>> index 000000000000..8c254d2185bc
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/lib/coresight.sh
>> @@ -0,0 +1,129 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +# This is sourced from a driver script so no need for #!/bin... etc. at the
>> +# top - the assumption below is that it runs as part of sourcing after the
>> +# test sets up some basic env vars to say what it is.
>> +
>> +# perf record options for the perf tests to use
>> +PERFRECMEM="-m ,16M"
>> +PERFRECOPT="$PERFRECMEM -e cs_etm//u"
>> +
>> +TOOLS=$(dirname $0)
>> +DIR="$TOOLS/$TEST"
>> +BIN="$DIR/$TEST"
>> +# If the test tool/binary does not exist and is executable then skip the test
>> +if ! test -x "$BIN"; then exit 2; fi
>> +DATD="."
>> +# If the data dir env is set then make the data dir use that instead of ./
>> +if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
>> +       DATD="$PERF_TEST_CORESIGHT_DATADIR";
>> +fi
>> +# If the stat dir env is set then make the data dir use that instead of ./
>> +STATD="."
>> +if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
>> +       STATD="$PERF_TEST_CORESIGHT_STATDIR";
>> +fi
>> +
>> +# Called if the test fails - error code 2
>> +err() {
>> +       echo "$1"
>> +       exit 1
>> +}
> 
> comment and exit 1 don't tie up

Aaah my bad - yeah. exit 2 is for skip test. That's handled higher up 
already. Oopsie here but code is right.

>> +
>> +# Check that some statistics from our perf
>> +check_val_min() {
>> +       STATF="$4"
>> +       if test "$2" -lt "$3"; then
>> +               echo ", FAILED" >> "$STATF"
>> +               err "Sanity check number of $1 is too low ($2 < $3)"
>> +       fi
>> +}
>> +
>> +perf_dump_aux_verify() {
>> +       # Some basic checking that the AUX chunk contains some sensible data
>> +       # to see that we are recording something and at least a minimum
>> +       # amount of it. We should almost always see F3 atoms in just about
>> +       # anything but certainly we will see some trace info and async atom
>> +       # chunks.
>> +       DUMP="$DATD/perf-tmp-aux-dump.txt"
>> +       perf report --stdio --dump -i "$1" | \
>> +               grep -o -e I_ATOM_F3 -e I_ASYNC -e I_TRACE_INFO > "$DUMP"
>> +       # Simply count how many of these atoms we find to see that we are
>> +       # producing a reasonable amount of data - exact checks are not sane
>> +       # as this is a lossy  process where we may lose some blocks and the
>> +       # compiler may produce different code depending on the compiler and
>> +       # optimization options, so this is rough  just to see if we're
>> +       # either missing almost all the data or all of it
>> +       ATOM_F3_NUM=`grep I_ATOM_F3 "$DUMP" | wc -l`
>> +       ATOM_ASYNC_NUM=`grep I_ASYNC "$DUMP" | wc -l`
>> +       ATOM_TRACE_INFO_NUM=`grep I_TRACE_INFO "$DUMP" | wc -l`
>> +       rm -f "$DUMP"
>> +
> 
> Please use correct terminology for the tech - ATOM is a specific form
> of trace packet,
> "ATOM_TRACE_INFO_NUM" makes no sense - TRACE_INFO_NUM is sufficient.
> Same for ATOM_ASYNC_NUM.=> ASYNC_NUM  - and all occurrences below.

done - i just thought of them as the same thing - a chunk/atom of data, 
but can rename them

> Moreover it would be better to just search for all atoms i.e. I_ATOM.
> This way you avoid hardware variations where an platform
> implementation may give different ratios between the different atom
> types for the same trace run.

yup. can just look at any ATOM_Fx - that also does the job - point is 
that we are getting some stream of sensible data and not just empty or 
only trace info's etc. - decoding of this back to instruction streams is 
something other tests are looking at.

> 
>> +       # Arguments provide minimums for a pass
>> +       CHECK_F3_MIN="$2"
>> +       CHECK_ASYNC_MIN="$3"
>> +       CHECK_TRACE_INFO_MIN="$4"
>> +
>> +       # Write out statistics, so over time you can track results to see if
>> +       # there is a pattern - for example we have less "noisy" results that
>> +       # produce more consistent amounts of data each run, to see if over
>> +       # time any techinques to  minimize data loss are having an effect or
>> +       # not
>> +       STATF="$STATD/stats-$TEST-$DATV.csv"
>> +       if ! test -f "$STATF"; then
>> +               echo "ATOM F3 Count, Minimum, ATOM ASYNC Count, Minimum, TRACE INFO Count, Minimum" > "$STATF"
>> +       fi
>> +       echo -n "$ATOM_F3_NUM, $CHECK_F3_MIN, $ATOM_ASYNC_NUM, $CHECK_ASYNC_MIN, $ATOM_TRACE_INFO_NUM, $CHECK_TRACE_INFO_MIN" >> "$STATF"
>> +
>> +       # Actually check to see if we passed or failed.
>> +       check_val_min "ATOM_F3" "$ATOM_F3_NUM" "$CHECK_F3_MIN" "$STATF"
>> +       check_val_min "ASYNC" "$ATOM_ASYNC_NUM" "$CHECK_ASYNC_MIN" "$STATF"
>> +       check_val_min "TRACE_INFO" "$ATOM_TRACE_INFO_NUM" "$CHECK_TRACE_INFO_MIN" "$STATF"
>> +       echo ", Ok" >> "$STATF"
>> +}
>> +
>> +perf_dump_aux_tid_verify() {
>> +       # Specifically crafted test will produce a list of Tread ID's to
>> +       # stdout that need to be checked to  see that they have had trace
>> +       # info collected in AUX blocks in the perf data. This will go
>> +       # through all the TID's that are listed as CID=0xabcdef and see
>> +       # that all the Thread IDs the test tool reports are  in the perf
>> +       # data AUX chunks
>> +
>> +       # The TID test tools will print a TID per stdout line that are being
>> +       # tested
>> +       TIDS=`cat "$2"`
>> +       # Scan the perf report to find the TIDs that are actually CID in hex
>> +       # and build a list of the ones found
>> +       FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
>> +                       grep -o "CID=0x[0-9a-z]\+" | sed 's/CID=//g' | \
>> +                       uniq | sort | uniq`
>> +       # No CID=xxx found - maybe your kernel is reporting these as
>> +       # VMID=xxx so look there
>> +       if test -z "$FOUND_TIDS"; then
>> +               FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
>> +                               grep -o "VMID=0x[0-9a-z]\+" | sed 's/VMID=//g' | \
>> +                               uniq | sort | uniq`
>> +       fi
>> +
>> +       # Iterate over the list of TIDs that the test says it has and find
>> +       # them in the TIDs found in the perf report
>> +       MISSING=""
>> +       for TID2 in $TIDS; do
>> +               FOUND=""
>> +               for TIDHEX in $FOUND_TIDS; do
>> +                       TID=`printf "%i" $TIDHEX`
>> +                       if test "$TID" -eq "$TID2"; then
>> +                               FOUND="y"
>> +                               break
>> +                       fi
>> +               done
>> +               if test -z "$FOUND"; then
>> +                       MISSING="$MISSING $TID"
>> +               fi
>> +       done
>> +       if test -n "$MISSING"; then
>> +               err "Thread IDs $MISSING not found in perf AUX data"
>> +       fi
>> +}
>> --
>> 2.32.0
>>
> 
> I haven't seen it mentioned anywhere but these tests will only work on
> ETMv4 / ETE. Platforms with ETMv3.x and PTM have different output
> packet types.

I'll put that at the top - deal with that bridge when/if we ever get to it.

> We don't need to support these at present - and maybe never, but it
> does need to be explicitly stated which trace technologies the tests
> are compatible with.
> 
> Regards
> 
> Mike
> 
> 
