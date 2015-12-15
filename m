From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 4/9] perf test: new testsuite: perf buildid-list tests
Date: Tue, 15 Dec 2015 13:04:22 +0100
Message-ID: <20151215120422.GG5074@krava.brq.redhat.com>
References: <1449514398.24573.254.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59479 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964955AbbLOMEY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Dec 2015 07:04:24 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 2702C8E222
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Dec 2015 12:04:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1449514398.24573.254.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Dec 07, 2015 at 07:53:18PM +0100, Michael Petlan wrote:

SNIP

> diff --git a/tools/perf/testsuite/base_buildid/settings.sh b/tools/perf/testsuite/base_buildid/settings.sh
> new file mode 100644
> index 0000000..87052dc
> --- /dev/null
> +++ b/tools/perf/testsuite/base_buildid/settings.sh
> @@ -0,0 +1,23 @@
> +#
> +#	settings.sh of perf buildid test
> +#	Author: Michael Petlan <mpetlan@redhat.com>
> +#
> +#	Description:
> +#		FIXME
> +#
> +#
> +
> +export TEST_NAME="perf_buildid-cache"
> +export MY_ARCH=`arch`
> +export MY_HOSTNAME=`hostname`
> +export MY_KERNEL_VERSION=`uname -r`
> +export MY_CPUS_ONLINE=`nproc`
> +export MY_CPUS_AVAILABLE=`cat /proc/cpuinfo | grep processor | wc -l`
> +
> +# FIXME look for the cache dir to /etc/perfconfig
> +export BUILDIDDIR="$HOME/.debug"
> +
> +clear_buildid_cache()
> +{
> +	rm -rf $BUILDIDDIR/*
> +}

I understand it's supposed to run on developers servers,
but cleaning ~/.debug is not a good idea

you could use './perf --buildid-dir DIR' and use
some temporary directory for the buildid cache

thanks,
jirka
