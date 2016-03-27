From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/9] perf test: Adding an entry for the perftool-testsuite
Date: Sun, 27 Mar 2016 14:24:02 +0200
Message-ID: <20160327122402.GI4015@krava.sund.root.ku.dk>
References: <cover.1458134357.git.mpetlan@redhat.com>
 <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbcC0MYF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 27 Mar 2016 08:24:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

On Wed, Mar 16, 2016 at 02:50:59PM +0100, Michael Petlan wrote:

SNIP

> +	dp = opendir("./");
> +	if (dp != NULL) {
> +
> +		while ((ep = readdir(dp))) {
> +			if (strncmp(ep->d_name, "base_", 5))
> +				continue;
> +			failures += run_group(ep->d_name);
> +		}
> +		closedir(dp);
> +	}
> +	else
> +		test_status = TEST_SKIP;
> +
> +	ret = chdir(cwd);
> +	ret = ret;
> +	free(cwd);
> +
> +	if(failures || fatal_occured)

you propage all the error all the way through, so what's
the point of having extra global fatal_occured variable?

thanks,
jirka
