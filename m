From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v8 6/7] tools/perf: Enable Hz/hz prinitg for
 --metric-only option
Date: Thu, 2 Apr 2020 14:49:46 +0200
Message-ID: <20200402124946.GH2518490@krava>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
 <20200401203340.31402-7-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200401203340.31402-7-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 02, 2020 at 02:03:39AM +0530, Kajol Jain wrote:
> Commit 54b5091606c18 ("perf stat: Implement --metric-only mode")
> added function 'valid_only_metric()' which drops "Hz" or "hz",
> if it is part of "ScaleUnit". This patch enable it since hv_24x7
> supports couple of frequency events.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/util/stat-display.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 9e757d18d713..679aaa655824 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -237,8 +237,6 @@ static bool valid_only_metric(const char *unit)
>  	if (!unit)
>  		return false;
>  	if (strstr(unit, "/sec") ||
> -	    strstr(unit, "hz") ||
> -	    strstr(unit, "Hz") ||

will this change output of --metric-only for some setups then?

Andi, are you ok with this?

other than this, the patchset looks ok to me

thanks,
jirka

>  	    strstr(unit, "CPUs utilized"))
>  		return false;
>  	return true;
> -- 
> 2.21.0
> 
