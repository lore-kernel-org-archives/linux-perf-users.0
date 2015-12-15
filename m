From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/9] perf test: new testsuite: perf annotate tests
Date: Tue, 15 Dec 2015 13:03:41 +0100
Message-ID: <20151215120341.GA5074@krava.brq.redhat.com>
References: <1449514394.24573.253.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60065 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965136AbbLOMDn (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Dec 2015 07:03:43 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 14F2968E24
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Dec 2015 12:03:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1449514394.24573.253.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Dec 07, 2015 at 07:53:14PM +0100, Michael Petlan wrote:

SNIP

> 
> diff --git a/tools/perf/testsuite/base_annotate/cleanup.sh b/tools/perf/testsuite/base_annotate/cleanup.sh
> new file mode 100755
> index 0000000..616873a
> --- /dev/null
> +++ b/tools/perf/testsuite/base_annotate/cleanup.sh
> @@ -0,0 +1,22 @@
> +#!/bin/bash
> +
> +#
> +#	cleanup.sh of perf annotate test
> +#	Author: Michael Petlan <mpetlan@redhat.com>
> +#
> +#
> +
> +# include working environment
> +. ../common/init.sh
> +. ./settings.sh
> +
> +THIS_TEST_NAME=`basename $0 .sh`
> +
> +make -s -C examples clean
> +
> +find . -name \*.log | xargs -r rm
> +find . -name \*.err | xargs -r rm
> +rm -f perf.data
> +
> +print_results 0 0 "clean-up logs"

could the test work over some temporary directory,
so it has its data stored in there?

it helps with paralel tests running and
is little bit cleaner solution

thanks,
jirka
