From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/9] perf test: new testsuite: perf annotate tests
Date: Tue, 15 Dec 2015 13:04:16 +0100
Message-ID: <20151215120416.GF5074@krava.brq.redhat.com>
References: <1449514394.24573.253.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60280 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964955AbbLOMES (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Dec 2015 07:04:18 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 1EF29C0B930D
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Dec 2015 12:04:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1449514394.24573.253.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Dec 07, 2015 at 07:53:14PM +0100, Michael Petlan wrote:

SNIP

> diff --git a/tools/perf/testsuite/base_annotate/setup.sh b/tools/perf/testsuite/base_annotate/setup.sh
> new file mode 100755
> index 0000000..1a1bc41
> --- /dev/null
> +++ b/tools/perf/testsuite/base_annotate/setup.sh
> @@ -0,0 +1,35 @@
> +#!/bin/bash
> +
> +#
> +#	setup.sh of perf annotate test
> +#	Author: Michael Petlan <mpetlan@redhat.com>
> +#
> +#	Description:
> +#
> +#		FIXME - build C program
> +#
> +#
> +
> +# include working environment
> +. ../common/init.sh
> +. ./settings.sh
> +
> +THIS_TEST_NAME=`basename $0 .sh`
> +
> +make -s -C examples
> +print_results $? 0 "building the example code"
> +TEST_RESULT=$?
> +
> +# record some data
> +$CMD_PERF record examples/load > /dev/null 2> setup_record.log
> +PERF_EXIT_CODE=$?
> +
> +# check the perf record output
> +../common/check_all_lines_matched.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < setup_record.log
> +CHECK_EXIT_CODE=$?
> +
> +print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "record data"
> +(( TEST_RESULT += $? ))
> +
> +print_overall_results $TEST_RESULT

so setup.sh script is already running some tests?

I thought it's just for seting up the test data
or whatever environment the testcase needs..

jirka
