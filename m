From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf test 6: Fix missing kvm module load for s390
Date: Fri, 7 Jun 2019 16:50:30 -0300
Message-ID: <20190607195030.GQ21245@kernel.org>
References: <20190604053504.43073-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604053504.43073-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jun 04, 2019 at 07:35:04AM +0200, Thomas Richter escreveu:
> Command
> 
>    # perf test -Fv 6
> 
> fails with error
> 
>    running test 100 'kvm-s390:kvm_s390_create_vm' failed to parse
>     event 'kvm-s390:kvm_s390_create_vm', err -1, str 'unknown tracepoint'
>     event syntax error: 'kvm-s390:kvm_s390_create_vm'
>                          \___ unknown tracepoint

Thanks, applied,

- Arnaldo
 
> when the kvm module is not loaded or not built in.
> 
> Fix this by adding a valid function which tests if the module
> is loaded. Loaded modules (or builtin KVM support) have a
> directory named
>   /sys/kernel/debug/tracing/events/kvm-s390
> for this tracepoint.
> 
> Check for existence of this directory.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  tools/perf/tests/parse-events.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 4a69c07f4101..8f3c80e13584 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -18,6 +18,32 @@
>  #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
>  			     PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
>  
> +#if defined(__s390x__)
> +/* Return true if kvm module is available and loaded. Test this
> + * and retun success when trace point kvm_s390_create_vm
> + * exists. Otherwise this test always fails.
> + */
> +static bool kvm_s390_create_vm_valid(void)
> +{
> +	char *eventfile;
> +	bool rc = false;
> +
> +	eventfile = get_events_file("kvm-s390");
> +
> +	if (eventfile) {
> +		DIR *mydir = opendir(eventfile);
> +
> +		if (mydir) {
> +			rc = true;
> +			closedir(mydir);
> +		}
> +		put_events_file(eventfile);
> +	}
> +
> +	return rc;
> +}
> +#endif
> +
>  static int test__checkevent_tracepoint(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel = perf_evlist__first(evlist);
> @@ -1642,6 +1668,7 @@ static struct evlist_test test__events[] = {
>  	{
>  		.name  = "kvm-s390:kvm_s390_create_vm",
>  		.check = test__checkevent_tracepoint,
> +		.valid = kvm_s390_create_vm_valid,
>  		.id    = 100,
>  	},
>  #endif
> -- 
> 2.21.0

-- 

- Arnaldo
