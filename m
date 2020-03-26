From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
Date: Thu, 26 Mar 2020 16:32:26 -0500
Message-ID: <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com>
References: <20200325164053.10177-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325164053.10177-1-tonyj@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 3/25/20 11:40 AM, Tony Jones wrote:
> The method of unwinding for kernel space is defined by the kernel config, 
> not by the value of --call-graph.   Improve the documentation to reflect 
> this.

> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 8ead55593984..88cf35fbedc5 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -405,14 +405,16 @@ ui.*::
>  		This option is only applied to TUI.
> 
>  call-graph.*::
> -	When sub-commands 'top' and 'report' work with -g/—-children
> -	there're options in control of call-graph.
> +	The following controls the handling of call-graphs (obtained via the
> +	-g/--callgraph options).
> 
>  	call-graph.record-mode::
> -		The record-mode can be 'fp' (frame pointer), 'dwarf' and 'lbr'.
> -		The value of 'dwarf' is effective only if perf detect needed library
> -		(libunwind or a recent version of libdw).
> -		'lbr' only work for cpus that support it.
> +		The mode for user space can be 'fp' (frame pointer), 'dwarf'
> +		and 'lbr'.  The value 'dwarf' is effective only if libunwind
> +		(or a recent version of libdw) is present on the system;
> +		the value 'lbr' only works for certain cpus. The method for
> +		kernel space is controlled not by this option but by the
> +		kernel config (CONFIG_UNWINDER_*).

Your changes are just copying the old text, so this isn't a criticism of your patches.

Do we have information to replace "a recent version of libdw", which will quickly get stale?

PC
