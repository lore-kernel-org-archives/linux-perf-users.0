From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 3/9] perf test: new testsuite: perf annotate tests
Date: Wed, 16 Dec 2015 12:51:33 +0100
Message-ID: <1450266693.3973.16.camel@redhat.com>
References: <1449514394.24573.253.camel@redhat.com>
	 <20151215120416.GF5074@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbbLPLvf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Dec 2015 06:51:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id B980E347A76
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Dec 2015 11:51:35 +0000 (UTC)
In-Reply-To: <20151215120416.GF5074@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Tue, 2015-12-15 at 13:04 +0100, Jiri Olsa wrote:
> On Mon, Dec 07, 2015 at 07:53:14PM +0100, Michael Petlan wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/testsuite/base_annotate/setup.sh b/tools/perf/testsuite/base_annotate/setup.sh
> > new file mode 100755
> > index 0000000..1a1bc41
> > --- /dev/null
> > +++ b/tools/perf/testsuite/base_annotate/setup.sh
> > @@ -0,0 +1,35 @@
> > +#!/bin/bash
> > +
> > +#
> > +#	setup.sh of perf annotate test
> > +#	Author: Michael Petlan <mpetlan@redhat.com>
> > +#
> > +#	Description:
> > +#
> > +#		FIXME - build C program
> > +#
> > +#
> > +
> > +# include working environment
> > +. ../common/init.sh
> > +. ./settings.sh
> > +
> > +THIS_TEST_NAME=`basename $0 .sh`
> > +
> > +make -s -C examples
> > +print_results $? 0 "building the example code"
> > +TEST_RESULT=$?
> > +
> > +# record some data
> > +$CMD_PERF record examples/load > /dev/null 2> setup_record.log
> > +PERF_EXIT_CODE=$?
> > +
> > +# check the perf record output
> > +../common/check_all_lines_matched.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < setup_record.log
> > +CHECK_EXIT_CODE=$?
> > +
> > +print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "record data"
> > +(( TEST_RESULT += $? ))
> > +
> > +print_overall_results $TEST_RESULT
> 
> so setup.sh script is already running some tests?
> 
> I thought it's just for seting up the test data
> or whatever environment the testcase needs..
> 
> jirka

It is setting up the test data or whatever environment the testcase
needs, but it of course self-checks its success or fail. If make fails,
it will be counted and it will be seen in the logs. The same about the
sample perf.data recording - if it fails, it is good to know it within
the setup phase.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
