Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9240C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2B461052
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 13:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJTNQF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJTNQE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 09:16:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E1C061749
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 06:13:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i76so2909660pfe.13
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 06:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RtJrSfwgtT8YF0UzABCy/bW/wKJYVo6+C+buqqv0qRM=;
        b=q7xCqZuSLOyHPh4DSD5C5WeP2XY0+IKO9FUpBIuzlnqs/Pdrhi2E5FKTyNmLc0muw4
         1f2tqi5sf9lEpGeSx3vNDXHHltXGj2W3/m8DWQf7SFV9OZmWTf/3+TKZ6BZqAbH/0OyC
         xv067LrngqQ7LsK67NOCGqWimMdmcKIV7hS3WX+cIARG5Af1aD+ZwhYON1DC7de3XnYL
         ZWArvmYmCj/Lpn0b4tWHCyR7U0lsdwTH8Dgksa+60rCZ8l5AO8uoH8oFjpjjDWViewiI
         2dEiFaW7VXvniIU5hQnPZpVcx5NyRS6ZjetLVVAmz+jMIHMcstF1MThV6ZqC/whMjOW+
         D6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RtJrSfwgtT8YF0UzABCy/bW/wKJYVo6+C+buqqv0qRM=;
        b=0Ke9F9/MKubP+MJktHOZUTHEwH2k8Pczt6mQqosxrpFctF7lC9zLcNhFo+8zF1vcHB
         KsZJufj3eGSQo7A6/zqPIe9RnxSdaHP9JKrxCQYTIs1QKL8+8Odpr809f9TJrWbaa+86
         cI1uJ6XFofHC2wBPuP7o8KYuSFBeQTzPtRBkMsZ3SgT1cXaSqHobJgDFfsidnUOZqnTS
         +KK0nouywQW6TfuIGiwqnpz8EnDW9JBh31PnyPWCOLR5ibgFaIWT22hMLVx+DkZ1YKVY
         Ks2fMBqpSLCZgFnPINHF5oGFmWK5adbGPC02x70v7EfP4/8jtv4jE4izZ4f6GkGiebLJ
         zVwA==
X-Gm-Message-State: AOAM530jX4sOC62WhUOGxphfQh7EL2kDuIuvYfWQaSyotBpijvEj3mlN
        b+1dlaUgfyMXp6kl16lhpcS8Pw==
X-Google-Smtp-Source: ABdhPJxM5HvKzicLfYl4WLcVTSmueL+mPJWwOC7F+YSKiR/HLNlWXOat5ZyZDw6U8uxZm+oLIPbG0g==
X-Received: by 2002:a63:1266:: with SMTP id 38mr33378184pgs.219.1634735629999;
        Wed, 20 Oct 2021 06:13:49 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id x27sm2486978pfr.181.2021.10.20.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:13:49 -0700 (PDT)
Date:   Wed, 20 Oct 2021 21:13:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
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
Subject: Re: [PATCH 5/5] perf arm-spe: Snapshot mode test
Message-ID: <20211020131339.GG49614@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-5-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154635.1525-5-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 04:46:35PM +0100, German Gomez wrote:
> Shell script test_arm_spe.sh has been added to test the recording of SPE
> tracing events in snapshot mode.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/tests/shell/test_arm_spe.sh | 91 ++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_arm_spe.sh
> 
> diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
> new file mode 100755
> index 000000000000..9ed817e76f95
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_arm_spe.sh
> @@ -0,0 +1,91 @@
> +#!/bin/sh
> +# Check Arm SPE trace data recording and synthesized samples
> +
> +# Uses the 'perf record' to record trace data of Arm SPE events;
> +# then verify if any SPE event samples are generated by SPE with
> +# 'perf script' and 'perf report' commands.
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# German Gomez <german.gomez@arm.com>, 2021
> +
> +skip_if_no_arm_spe_event() {
> +	perf list | egrep -q 'arm_spe_[0-9]+//' && return 0
> +
> +	# arm_spe event doesn't exist
> +	return 2
> +}
> +
> +skip_if_no_arm_spe_event || exit 2
> +
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +glb_err=0
> +
> +cleanup_files()
> +{
> +	rm -f ${perfdata}
> +	trap - exit term int
> +	kill -2 $$ # Forward sigint to parent

I understand you copy this code from Arm cs-etm testing, but I found
the sentence 'kill -2 $$' will cause a failure at my side with the
command:

root@ubuntu:/home/leoy/linux/tools/perf# ./perf test 85 -v
85: Check Arm SPE trace data recording and synthesized samples      :
--- start ---
test child forked, pid 29053
Recording trace with snapshot mode /tmp/__perf_test.perf.data.uughb
Looking at perf.data file for dumping samples:
Looking at perf.data file for reporting samples:
SPE snapshot testing: PASS
test child finished with -1
---- end ----
Check Arm SPE trace data recording and synthesized samples: FAILED!

I changed to use below code and looks it works for me:

        if [[ "$1" == "int" ]]; then
                kill -SIGINT $$
        fi
        if [[ "$1" == "term" ]]; then
                kill -SIGTERM $$
        fi

Thanks,
Leo

> +	exit $glb_err
> +}
> +
> +trap cleanup_files exit term int
> +
> +arm_spe_report() {
> +	if [ $2 != 0 ]; then
> +		echo "$1: FAIL"
> +		glb_err=$2
> +	else
> +		echo "$1: PASS"
> +	fi
> +}
> +
> +perf_script_samples() {
> +	echo "Looking at perf.data file for dumping samples:"
> +
> +	# from arm-spe.c/arm_spe_synth_events()
> +	events="(ld1-miss|ld1-access|llc-miss|lld-access|tlb-miss|tlb-access|branch-miss|remote-access|memory)"
> +
> +	# Below is an example of the samples dumping:
> +	#	dd  3048 [002]          1    l1d-access:      ffffaa64999c __GI___libc_write+0x3c (/lib/aarch64-linux-gnu/libc-2.27.so)
> +	#	dd  3048 [002]          1    tlb-access:      ffffaa64999c __GI___libc_write+0x3c (/lib/aarch64-linux-gnu/libc-2.27.so)
> +	#	dd  3048 [002]          1        memory:      ffffaa64999c __GI___libc_write+0x3c (/lib/aarch64-linux-gnu/libc-2.27.so)
> +	perf script -F,-time -i ${perfdata} 2>&1 | \
> +		egrep " +$1 +[0-9]+ .* +${events}:(.*:)? +" > /dev/null 2>&1
> +}
> +
> +perf_report_samples() {
> +	echo "Looking at perf.data file for reporting samples:"
> +
> +	# Below is an example of the samples reporting:
> +	#   73.04%    73.04%  dd    libc-2.27.so      [.] _dl_addr
> +	#    7.71%     7.71%  dd    libc-2.27.so      [.] getenv
> +	#    2.59%     2.59%  dd    ld-2.27.so        [.] strcmp
> +	perf report --stdio -i ${perfdata} 2>&1 | \
> +		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
> +}
> +
> +arm_spe_snapshot_test() {
> +	echo "Recording trace with snapshot mode $perfdata"
> +	perf record -o ${perfdata} -e arm_spe// -S \
> +		-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
> +	PERFPID=$!
> +
> +	# Wait for perf program
> +	sleep 1
> +
> +	# Send signal to snapshot trace data
> +	kill -USR2 $PERFPID
> +
> +	# Stop perf program
> +	kill $PERFPID
> +	wait $PERFPID
> +
> +	perf_script_samples dd &&
> +	perf_report_samples dd
> +
> +	err=$?
> +	arm_spe_report "SPE snapshot testing" $err
> +}
> +
> +arm_spe_snapshot_test
> +exit $glb_err
> \ No newline at end of file
> -- 
> 2.17.1
> 
