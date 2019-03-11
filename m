From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v6 09/11] perf tools report: Add custom scripts to script
 menu
Date: Mon, 11 Mar 2019 15:10:21 -0300
Message-ID: <20190311181021.GT10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-10-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-10-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 11, 2019 at 07:45:00AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a way to define custom scripts through ~/.perfconfig, which
> are then added to the scripts menu. The scripts get the same
> arguments as perf script, in particular -i, --cpu, --tid.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-config.txt |  8 ++++++++
>  tools/perf/ui/browsers/scripts.c         | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 2d0fb7613134..c3323228d3d0 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -590,6 +590,14 @@ samples.*::
>  		Define how many ns worth of time to show
>  		around samples in perf report sample context browser.
>  
> +script.*::
> +
> +	Any option defines a script that is added to the scripts menu
> +	in the interactive perf browser and whose output is displayed.
> +	The name of the option is the name, the value is a script command line.
> +	The script gets the same options passed as a full perf script,
> +	in particular -i perfdata file, --cpu, --tid
> +

Isn't it better to use 'scripts' for those scripts and leave 'script'
for configuring the 'perf script' command like we have options for
annotate, etc?

- Arnaldo

>  SEE ALSO
>  --------
>  linkperf:perf[1]
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index cdba58447b85..5d407ab834b5 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -6,6 +6,7 @@
>  #include "../../util/symbol.h"
>  #include "../browser.h"
>  #include "../libslang.h"
> +#include "config.h"
>  
>  #define SCRIPT_NAMELEN	128
>  #define SCRIPT_MAX_NO	64
> @@ -53,6 +54,24 @@ static int add_script_option(const char *name, const char *opt,
>  	return 0;
>  }
>  
> +static int scripts_config(const char *var, const char *value, void *data)
> +{
> +	struct script_config *c = data;
> +
> +	if (!strstarts(var, "script."))
> +		return -1;
> +	if (c->index >= SCRIPT_MAX_NO)
> +		return -1;
> +	c->names[c->index] = strdup(var + 7);
> +	if (!c->names[c->index])
> +		return -1;
> +	if (asprintf(&c->paths[c->index], "%s %s", value,
> +		     c->extra_format) < 0)
> +		return -1;
> +	c->index++;
> +	return 0;
> +}
> +
>  /*
>   * When success, will copy the full path of the selected script
>   * into  the buffer pointed by script_name, and return 0.
> @@ -87,6 +106,7 @@ static int list_scripts(char *script_name, bool *custom,
>  			  &scriptc);
>  	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
>  			  &scriptc);
> +	perf_config(scripts_config, &scriptc);
>  	custom_perf = scriptc.index;
>  	add_script_option("Show samples with custom perf script arguments", "", &scriptc);
>  	i = scriptc.index;
> -- 
> 2.20.1

-- 

- Arnaldo
