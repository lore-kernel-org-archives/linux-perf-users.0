From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core 22/22] perf: Fix write_numa_topology to put
 cpu_map instead of free
Date: Wed, 9 Dec 2015 12:26:05 -0300
Message-ID: <20151209152605.GM15864@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209021135.10245.79046.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54433 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbbLIP0J (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 10:26:09 -0500
Content-Disposition: inline
In-Reply-To: <20151209021135.10245.79046.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Em Wed, Dec 09, 2015 at 11:11:35AM +0900, Masami Hiramatsu escreveu:
> Fix write_numa_topology to put cpu_map instead of free because
> cpu_map is managed based on refcnt.

thanks, applied!
 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> ---
>  tools/perf/util/header.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4383800..5ac7bdb 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -724,7 +724,7 @@ static int write_numa_topology(int fd, struct perf_header *h __maybe_unused,
>  done:
>  	free(buf);
>  	fclose(fp);
> -	free(node_map);
> +	cpu_map__put(node_map);
>  	return ret;
>  }
>  
