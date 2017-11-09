From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf buildid-cache: update help text for purge command
Date: Thu, 9 Nov 2017 16:16:22 -0300
Message-ID: <20171109191622.GS4333@kernel.org>
References: <20171107144853.12925-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdKITQY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Nov 2017 14:16:24 -0500
Content-Disposition: inline
In-Reply-To: <20171107144853.12925-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com

Em Tue, Nov 07, 2017 at 03:48:53PM +0100, Thomas Richter escreveu:
> From: tmricht <tmricht@linux.vnet.ibm.com>
> 
> Clarify the perf buildid-cache help text for the purge operation.
> The purge subcommand takes a list of files (binaries) as
> option parameter. Make the wording the same as for the add
> and remove operation.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/builtin-buildid-cache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index 9eba7f1add1f..ee4fdb458e26 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -307,8 +307,8 @@ int cmd_buildid_cache(int argc, const char **argv)
>  		   "file", "kcore file to add"),
>  	OPT_STRING('r', "remove", &remove_name_list_str, "file list",
>  		    "file(s) to remove"),
> -	OPT_STRING('p', "purge", &purge_name_list_str, "path list",
> -		    "path(s) to remove (remove old caches too)"),
> +	OPT_STRING('p', "purge", &purge_name_list_str, "file list",
> +		    "file(s) to remove (remove old caches too)"),
>  	OPT_STRING('M', "missing", &missing_filename, "file",
>  		   "to find missing build ids in the cache"),
>  	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
> -- 
> 2.13.4
