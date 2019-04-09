From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf/report: [RFC] Handling OOM in perf report
Date: Tue, 9 Apr 2019 12:42:05 +0200
Message-ID: <20190409104205.GB29688@krava>
References: <20190401142000.17679-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401142000.17679-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Apr 01, 2019 at 04:20:00PM +0200, Thomas Richter wrote:

SNIP

> perf_session__process_event() returns to its caller, where -ENOMEM is
> changed to -EINVAL and processing stops:
> 
>  if ((skip = perf_session__process_event(session, event, head)) < 0) {
>       pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> 	     head, event->header.size, event->header.type);
>       err = -EINVAL;
>       goto out_err;
>  }
> 
> This occured in the FINISHED_ROUND event when it has to process some
> 10000 entries and ran out of memory.
> 
> I understand that my perf.data file might just be too big, but I would
> like to see some error message indicating OOM error instead of
> processing failure of a unrelated event.

you can limit the size of the report queue via ~/.perfconfig file:

[report]
queue-size=1M

above should use only 1M for the queue management data the data
for sample still get allocated thought.. but it could help

> 
> However this patch just does what the pr_debug() statement indicates,
> the event is skipped and processing continues.
> But at least the root cause is indicated and also shows up in the
> GUI.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/builtin-report.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 4054eb1f98ac..7a27b815f7a8 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -283,8 +283,13 @@ static int process_sample_event(struct perf_tool *tool,
>  		al.map->dso->hit = 1;
>  
>  	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		pr_debug("problem adding hist entry, skipping event\n");
> +		if (ret == -ENOMEM) {
> +			pr_err("Running out of memory\n");
> +			ret = 0;
> +		}
> +	}


I think we can propagate the error completely (like below),
and even warn about ENOMEM specificaly

but I think we should bail out in case of ENOMEM, because
the data are incomplete and misleading

jirka


---
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..eea247a26ad8 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1933,7 +1933,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 		       file_offset + head, event->header.size,
 		       event->header.type);
-		err = -EINVAL;
+		err = skip;
 		goto out;
 	}
 
