Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB12C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 13:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABCE61175
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 13:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhKIN3k (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 08:29:40 -0500
Received: from foss.arm.com ([217.140.110.172]:33872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhKIN3j (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 08:29:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A784D2B;
        Tue,  9 Nov 2021 05:26:53 -0800 (PST)
Received: from [10.57.46.99] (unknown [10.57.46.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3D253F70D;
        Tue,  9 Nov 2021 05:26:50 -0800 (PST)
Subject: Re: [PATCH 5/5] perf arm-spe: Snapshot mode test
To:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-5-german.gomez@arm.com>
 <20211020131339.GG49614@leoy-ThinkPad-X240s>
 <fd65eb63-d4ca-2105-74cb-c717ad2eb7d3@arm.com>
 <ef1d4b66-1743-529f-7c5b-fbc4ada7113b@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <5af799c3-5f39-9792-225e-1957c3da7b07@arm.com>
Date:   Tue, 9 Nov 2021 13:26:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ef1d4b66-1743-529f-7c5b-fbc4ada7113b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James, Leo,

Thank you for testing the patch.

On 02/11/2021 15:37, James Clark wrote:
> [...]
> Ok, it seems like I was relying on buggy dash behaviour for my original change. Even with this:
>
>         if [[ "$1" == "int" ]]; then
>                 kill -SIGINT $$
>         fi
>         if [[ "$1" == "term" ]]; then
>                 kill -SIGTERM $$
>         fi
>
> it still doesn't allow you to break out of running it in a while loop. This is only because of
> the exit code, rather than any kind of signal propagation. Actually it's possible to stop it
> with Ctrl-\ rather than Ctrl-C, and that doesn't require any extra handling in the script.
>
> For that reason I'm happy to go with Leo's original suggestion when I first added this which was
> to not have any extra kill at all.

Thanks for debugging the issue, I think I will consider this fix in the
re-submission.

Thanks,
German

>
> Another fix could be this, but I'm not too keen on it because I don't think any other tests behave
> like this:
>
>         [ "$1" = "int" ] || exit 1
>         [ "$1" = "term" ] || exit 1
>
>>>> +	exit $glb_err
>>>> +}
>>>> +
>>>> +trap cleanup_files exit term int
>>>> +
>>>> +arm_spe_report() {
>>>> +	if [ $2 != 0 ]; then
>>>> +		echo "$1: FAIL"
>>>> +		glb_err=$2
>>>> +	else
>>>> +		echo "$1: PASS"
>>>> +	fi
>>>> +}
>>>> +
>>>> +perf_script_samples() {
>>>> +	echo "Looking at perf.data file for dumping samples:"
>>>> +
>>>> +	# from arm-spe.c/arm_spe_synth_events()
>>>> +	events="(ld1-miss|ld1-access|llc-miss|lld-access|tlb-miss|tlb-access|branch-miss|remote-access|memory)"
>>>> +
>>>> +	# Below is an example of the samples dumping:
>>>> +	#	dd  3048 [002]          1    l1d-access:      ffffaa64999c __GI___libc_write+0x3c (/lib/aarch64-linux-gnu/libc-2.27.so)
>>>> +	#	dd  3048 [002]          1    tlb-access:      ffffaa64999c __GI___libc_write+0x3c (/lib/aarch64-linux-gnu/libc-2.27.so)
>>>> +	#	dd  3048 [002]          1        memory:      ffffaa64999c __GI___libc_write+0x3c (/lib/aarch64-linux-gnu/libc-2.27.so)
>>>> +	perf script -F,-time -i ${perfdata} 2>&1 | \
>>>> +		egrep " +$1 +[0-9]+ .* +${events}:(.*:)? +" > /dev/null 2>&1
>>>> +}
>>>> +
>>>> +perf_report_samples() {
>>>> +	echo "Looking at perf.data file for reporting samples:"
>>>> +
>>>> +	# Below is an example of the samples reporting:
>>>> +	#   73.04%    73.04%  dd    libc-2.27.so      [.] _dl_addr
>>>> +	#    7.71%     7.71%  dd    libc-2.27.so      [.] getenv
>>>> +	#    2.59%     2.59%  dd    ld-2.27.so        [.] strcmp
>>>> +	perf report --stdio -i ${perfdata} 2>&1 | \
>>>> +		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
>>>> +}
>>>> +
>>>> +arm_spe_snapshot_test() {
>>>> +	echo "Recording trace with snapshot mode $perfdata"
>>>> +	perf record -o ${perfdata} -e arm_spe// -S \
>>>> +		-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
>>>> +	PERFPID=$!
>>>> +
>>>> +	# Wait for perf program
>>>> +	sleep 1
>>>> +
>>>> +	# Send signal to snapshot trace data
>>>> +	kill -USR2 $PERFPID
>>>> +
>>>> +	# Stop perf program
>>>> +	kill $PERFPID
>>>> +	wait $PERFPID
>>>> +
>>>> +	perf_script_samples dd &&
>>>> +	perf_report_samples dd
>>>> +
>>>> +	err=$?
>>>> +	arm_spe_report "SPE snapshot testing" $err
>>>> +}
>>>> +
>>>> +arm_spe_snapshot_test
>>>> +exit $glb_err
>>>> \ No newline at end of file
>>>> -- 
>>>> 2.17.1
>>>>
