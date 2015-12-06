From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf buildid-list: Fix return value of perf buildid-list
 -k
Date: Sun, 6 Dec 2015 16:51:40 -0200
Message-ID: <20151206185140.GD2493@redhat.com>
References: <1449080871.24573.145.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57094 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182AbbLFSvp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 6 Dec 2015 13:51:45 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 1C88742E5DA
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Dec 2015 18:51:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1449080871.24573.145.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Wed, Dec 02, 2015 at 07:27:51PM +0100, Michael Petlan escreveu:
> The buildid string length is returned by perf buildid-list -k command.
> Since a non-zero return value means an error, perf buildid-list -k cmd
> should return 0 when successful instead.
> 
> Before:
> 
> 	# perf buildid-list -k
> 	39356d74e96e02346fe0ec1f3f162b6c522bac62
> 	# echo $?
> 	41

Thanks, applied.
 
> After:
> 
> 	# perf buildid-list -k
> 	39356d74e96e02346fe0ec1f3f162b6c522bac62
> 	# echo $?
> 	0
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/builtin-buildid-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> index 918b4de..6419f57 100644
> --- a/tools/perf/builtin-buildid-list.c
> +++ b/tools/perf/builtin-buildid-list.c
> @@ -110,7 +110,7 @@ int cmd_buildid_list(int argc, const char **argv,
>  	setup_pager();
>  
>  	if (show_kernel)
> -		return sysfs__fprintf_build_id(stdout);
> +		return !(sysfs__fprintf_build_id(stdout) > 0);
>  
>  	return perf_session__list_build_ids(force, with_hits);
>  }
> 
