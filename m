From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf buildid-cache: update help text for purge command
Date: Sun, 29 Oct 2017 01:15:30 +0900
Message-ID: <20171029011530.5371d73ef81c571141cf47a5@kernel.org>
References: <20171027110126.72520-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdJ1QPd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 28 Oct 2017 12:15:33 -0400
In-Reply-To: <20171027110126.72520-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

On Fri, 27 Oct 2017 13:01:26 +0200
Thomas Richter <tmricht@linux.vnet.ibm.com> wrote:

> Clarify the perf buildid-cache help text for the purge operation.
> The purge subcommand takes a list of files (binaries) as
> option parameter. Make the wording the same as for the add
> and remove operation.
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-buildid-cache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index bcd2b0e..04164d5 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -336,8 +336,8 @@ int cmd_buildid_cache(int argc, const char **argv)
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
> 2.9.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
