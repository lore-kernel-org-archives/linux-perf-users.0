From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf script: allow extended console debug output
Date: Mon, 22 Oct 2018 11:40:33 +0200
Message-ID: <20181022094033.GF2452@krava>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181021191424.16183-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Sun, Oct 21, 2018 at 09:14:23PM +0200, Milian Wolff wrote:
> The script tool isn't using a browser, yet use_browser
> wasn't set explicitly to zero. This in turn lead to confusing
> output such as:
> 
> ```
> $ perf script -vvv ...
> ...
> overlapping maps in /home/milian/foobar (disable tui for more info)
> ...
> ```
> 
> Explicitly set use_browser to 0 now, which gives us the extended
> debug information now in perf script as expected.
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-script.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4da5e32b9e03..bd468b90801b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3417,8 +3417,10 @@ int cmd_script(int argc, const char **argv)
>  		exit(-1);
>  	}
>  
> -	if (!script_name)
> +	if (!script_name) {
>  		setup_pager();
> +		use_browser = 0;
> +	}
>  
>  	session = perf_session__new(&data, false, &script.tool);
>  	if (session == NULL)
> -- 
> 2.19.1
