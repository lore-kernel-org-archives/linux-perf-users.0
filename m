Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38757C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160A2611C3
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhHFSfN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhHFSfM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 14:35:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7206D60F44;
        Fri,  6 Aug 2021 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628274896;
        bh=q2YnuvgVCxTHSzNPiweLic+RlcZKR5+VTHAZGxVEnO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDA67NgCkoCLY3XiYJRxHGcDd/KYhCZ08hREGVd/lO+NK02uwtUTzCYCmyyMyD9sh
         ESY1Lj97xMhYD2rWhnFa7SyUeM4UJOosTAnX2xriuRJmnywWQuWVqCMcLeu4iWtmtp
         DN2F2qgupfKxIKFbnRvFoirrVA7rntpv1wcFLNpG75wn6MqWcwgX0z0dn+lpm0pefk
         Sjw7I+/4oFJcf6Tq0Y+TjhSvr/jl+Sik1ObudF+1/nlzBUvy0ohgULHFmbPgwocKJG
         /FVfYNR0Gva3Lj4nMnz/vMQxqYgTZHYlmMDR+amXjGTIjyFVkBTZcgy+tySErd4LL4
         kBDdlWP9wR7Jg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0DE9B403F2; Fri,  6 Aug 2021 15:34:54 -0300 (-03)
Date:   Fri, 6 Aug 2021 15:34:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Claire Jensen <cjense@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, eranian@google.com
Subject: Re: [PATCH 1/1] perf test: Add test for CSV output.
Message-ID: <YQ2AzS3Az9Zfnu4I@kernel.org>
References: <20210805171431.940897-1-cjense@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805171431.940897-1-cjense@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Aug 05, 2021 at 05:14:31PM +0000, Claire Jensen escreveu:
> Add field checking tests for perf stat CSV output. Counts expected
> fields for various commands. No testing added for summary mode
> since it is broken.
> 
> An example of the summary output is:
> 
>          summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
> ,,,,,1.37,stalled cycles per insn
> 
> This should be:
> 
>          summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
>          summary,,,,,,1.37,stalled cycles per insn
> 
> The output has 7 fields when it should have 8. Additionally, the newline
> spacing is wrong, so it was excluded from testing until a fix is made.


You forgot to add your Signed-off-by: line as described in
Documentation/process/submitting-patches.rst.

Thanks for working on this, the more 'perf test' entries, the better :-)

Some more comments below.

- Arnaldo

> ---
>  .../tests/shell/lib/perf_csv_output_lint.py   |  55 ++++++++
>  tools/perf/tests/shell/stat+csv_output.sh     | 117 ++++++++++++++++++
>  2 files changed, 172 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
>  create mode 100644 tools/perf/tests/shell/stat+csv_output.sh
> 
> diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
> new file mode 100644
> index 000000000000..ef8a32c3523c
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
> @@ -0,0 +1,55 @@
> +#!/usr/bin/python
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from __future__ import print_function
> +import argparse
> +import sys
> +
> +# Basic sanity check of perf CSV output as specified in the man page.
> +# Currently just checks the number of fields per line in output.
> +
> +ap = argparse.ArgumentParser()
> +ap.add_argument('--no-args', action='store_true')
> +ap.add_argument('--interval', action='store_true')
> +ap.add_argument('--all-cpus-no-aggr', action='store_true')
> +ap.add_argument('--all-cpus', action='store_true')
> +ap.add_argument('--event', action='store_true')
> +ap.add_argument('--per-core', action='store_true')
> +ap.add_argument('--per-thread', action='store_true')
> +ap.add_argument('--per-die', action='store_true')
> +ap.add_argument('--per-node', action='store_true')
> +ap.add_argument('--per-socket', action='store_true')
> +ap.add_argument('--separator', const=',', nargs='?')
> +args = ap.parse_args()
> +
> +Lines = sys.stdin.readlines()
> +ch = args.separator
> +
> +
> +def check_csv_output(exp):
> +  for line in Lines:
> +    if 'failed' not in line:
> +      count = 0
> +      count = line.count(args.separator)
> +      if count != exp:
> +        sys.stdout.write(''.join(Lines))
> +        raise RuntimeError('wrong number of fields.'
> +                           ' expected {0} in {1}\n'.format(exp, line))
> +
> +try:
> +  if args.no_args or args.all_cpus or args.event:
> +    check_csv_output(6)
> +
> +  if args.interval or args.per_thread:
> +    check_csv_output(7)
> +
> +  if args.per_core or args.per_socket or args.per_node or args.per_die:
> +    check_csv_output(8)
> +
> +except:
> +  sys.stdout.write('Test failed for input: ' + ''.join(Lines))
> +  raise
> +
> +
> +
> +

Please avoid adding empty lines at the end of a file.

> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
> new file mode 100644
> index 000000000000..282f9547e7be
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -0,0 +1,117 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# perf stat csv output test
> +# Tests various perf stat CSV output commands for the
> +# correct number of fields and the CSV separator set to ','.
> +
> +set -e
> +
> +pythonchecker=$(dirname $0)/lib/perf_csv_output_lint.py
> +file="/proc/sys/kernel/perf_event_paranoid"
> +paranoia=$(cat "$file" | grep -o -E '[0-9]+')
> +echo $paranoia
> +
> +check_no_args()
> +{
> +	perf stat -x, sleep 1 2>&1 | \
> +	python $pythonchecker --no-args --separator
> +}
> +
> +if [ $paranoia -gt 0 ];
> +then

Please have the 'then' line at the end of the if one, following the
style of pre-existing shell tests such as
tools/perf/tests/shell/pipe_test.sh.

> +	echo check_all_cpus test skipped because of paranoia level.
> +else
> +	check_all_cpus()
> +	{
> +		perf stat -x, -a 2>&1 sleep 1 | \
> +		python $pythonchecker --all-cpus --separator
> +	}
> +	check_all_cpus
> +fi
> +
> +check_interval()
> +{
> +	perf stat -x, -I 1000 2>&1 sleep 1 | \
> +	python $pythonchecker --interval --separator
> +}
> +
> +check_all_cpus_no_aggr()
> +{
> +	perf stat -x, -A -a --no-merge 2>&1 sleep 1 | \
> +	python $pythonchecker --all-cpus-no-aggr --separator
> +}
> +
> +check_event()
> +{
> +	perf stat -x, -e cpu-clock 2>&1 sleep 1 | \
> +	python $pythonchecker --event --separator
> +}
> +
> +if [ $paranoia -gt 0 ];
> +then
> +	echo check_all_cpus test skipped because of paranoia level.
> +else
> +	check_per_core()
> +	{
> +		perf stat -x, --per-core -a 2>&1 sleep 1 | \
> +		python $pythonchecker --per-core --separator
> +	}
> +	check_per_core
> +fi
> +
> +if [ $paranoia -gt 0 ];
> +then
> +	echo check_all_cpus test skipped because of paranoia level.
> +else
> +	check_per_thread()
> +	{
> +		perf stat -x, --per-thread -a 2>&1 sleep 1 | \
> +		python $pythonchecker --per-thread --separator
> +	}
> +	check_per_thread
> +fi
> +
> +if [ $paranoia -gt 0 ];
> +then
> +	echo check_per_die test skipped because of paranoia level.
> +else
> +	check_per_die()
> +	{
> +		perf stat -x, --per-die -a 2>&1 sleep 1 | \
> +		python $pythonchecker --per-die --separator
> +	}
> +	check_per_die
> +fi
> +
> +if [ $paranoia -gt 0 ];
> +then
> +	echo check_per_node test skipped because of paranoia level.
> +else
> +	check_per_node()
> +	{
> +		perf stat -x, --per-node -a 2>&1 sleep 1 | \
> +		python $pythonchecker --per-node --separator
> +	}
> +	check_per_node
> +fi
> +
> +if [ $paranoia -gt 0 ];
> +then
> +	echo check_per_socket test skipped because of paranoia level.
> +else
> +	check_per_socket()
> +	{
> +		perf stat -x, --per-socket -a 2>&1 sleep 1 | \
> +		python $pythonchecker --per-socket --separator
> +	}
> +	check_per_socket
> +fi
> +
> +check_no_args
> +check_interval
> +check_all_cpus_no_aggr
> +check_event
> +
> +exit 0
> +

Also here, please remove this blank line at the end of the file.

> -- 
> 2.32.0.605.g8dce9f2422-goog
> 

-- 

- Arnaldo
