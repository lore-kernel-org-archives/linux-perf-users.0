From: Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH] perf/report: Report OOM in perf report status line
Date: Mon, 15 Apr 2019 12:17:28 +0200
Message-ID: <20190415101728.GA6966@linux.ibm.com>
References: <20190415094617.30150-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415094617.30150-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Thomas,

On Mon, Apr 15, 2019 at 11:46:17AM +0200, Thomas Richter wrote:
[...]

> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Jiri Olsa <jolsa@redhat.com>
> ---
>  tools/perf/util/session.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b17f1c9bc965..e89716175588 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1930,10 +1930,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> 
>  	if (size < sizeof(struct perf_event_header) ||
>  	    (skip = rd->process(session, event, file_pos)) < 0) {
> -		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> +		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
>  		       file_offset + head, event->header.size,
> -		       event->header.type);
> -		err = -EINVAL;
> +		       event->header.type, strerror(-skip));
> +		err = skip;
>  		goto out;
>  	}
> 

Thanks for solving this issue.

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
