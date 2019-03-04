From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 01/11] perf tools: Add utility function to fetch
 executable
Date: Mon, 4 Mar 2019 15:48:19 +0100
Message-ID: <20190304144819.GH30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-2-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-2-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:40AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a utility function to fetch executable code. Convert one
> user over to it. There are more places doing that, but they
> do significantly different actions, so they are not
> easy to fit into a single library function.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/Build       |  1 +
>  tools/perf/util/fetch.c     | 28 ++++++++++++++++++++++++++++
>  tools/perf/util/fetch.h     |  7 +++++++
>  tools/perf/util/intel-bts.c | 21 +++------------------
>  4 files changed, 39 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/util/fetch.c
>  create mode 100644 tools/perf/util/fetch.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8dd3102301ea..649321fc3fb9 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -65,6 +65,7 @@ perf-y += trace-event-scripting.o
>  perf-y += trace-event.o
>  perf-y += svghelper.o
>  perf-y += sort.o
> +perf-y += fetch.o
>  perf-y += hist.o
>  perf-y += util.o
>  perf-y += xyarray.o
> diff --git a/tools/perf/util/fetch.c b/tools/perf/util/fetch.c
> new file mode 100644
> index 000000000000..1430083e7eca
> --- /dev/null
> +++ b/tools/perf/util/fetch.c
> @@ -0,0 +1,28 @@
> +#include "perf.h"
> +#include "machine.h"
> +#include "thread.h"
> +#include "symbol.h"
> +#include "map.h"
> +#include "fetch.h"
> +
> +int fetch_exe(u64 ip, struct thread *thread, struct machine *machine,
> +	      char *buf, int len, bool *is64bit)
> +{
> +	struct addr_location al;
> +	u8 cpumode;
> +	long offset;
> +
> +	if (machine__kernel_ip(machine, ip))
> +		cpumode = PERF_RECORD_MISC_KERNEL;
> +	else
> +		cpumode = PERF_RECORD_MISC_USER;
> +	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
> +		return -1;
> +	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR)
> +		return -1;
> +	map__load(al.map);
> +	offset = al.map->map_ip(al.map, ip);
> +	if (is64bit)
> +		*is64bit = al.map->dso->is_64_bit;
> +	return dso__data_read_offset(al.map->dso, machine, offset, (u8 *)buf, len);
> +}
> diff --git a/tools/perf/util/fetch.h b/tools/perf/util/fetch.h
> new file mode 100644
> index 000000000000..7b77b8cee55a
> --- /dev/null
> +++ b/tools/perf/util/fetch.h
> @@ -0,0 +1,7 @@
> +#ifndef FETCH_H
> +#define FETCH_H 1
> +
> +int fetch_exe(u64 ip, struct thread *thread, struct machine *machine,
> +	      char *buf, int len, bool *is64bit);
> +
> +#endif
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 0c0180c67574..915f4662e52e 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -38,6 +38,7 @@
>  #include "auxtrace.h"
>  #include "intel-pt-decoder/intel-pt-insn-decoder.h"
>  #include "intel-bts.h"
> +#include "fetch.h"
>  
>  #define MAX_TIMESTAMP (~0ULL)
>  
> @@ -328,35 +329,19 @@ static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
>  {
>  	struct machine *machine = btsq->bts->machine;
>  	struct thread *thread;
> -	struct addr_location al;
>  	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
>  	ssize_t len;
> -	int x86_64;
> -	uint8_t cpumode;
> +	bool x86_64;
>  	int err = -1;
>  
> -	if (machine__kernel_ip(machine, ip))
> -		cpumode = PERF_RECORD_MISC_KERNEL;
> -	else
> -		cpumode = PERF_RECORD_MISC_USER;
> -
>  	thread = machine__find_thread(machine, -1, btsq->tid);
>  	if (!thread)
>  		return -1;
>  
> -	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
> -		goto out_put;
> -
> -	len = dso__data_read_addr(al.map->dso, al.map, machine, ip, buf,
> -				  INTEL_PT_INSN_BUF_SZ);
> +	len = fetch_exe(ip, thread, machine, (char*)buf, INTEL_PT_INSN_BUF_SZ, &x86_64);
>  	if (len <= 0)
>  		goto out_put;
>  
> -	/* Load maps to ensure dso->is_64_bit has been updated */
> -	map__load(al.map);
> -
> -	x86_64 = al.map->dso->is_64_bit;
> -
>  	if (intel_pt_get_insn(buf, len, x86_64, &btsq->intel_pt_insn))
>  		goto out_put;
>  
> -- 
> 2.17.2
> 
