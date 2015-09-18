From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH perf/core ] [BUGFIX] perf probe: Fix a segfault when
 removing uprobe events
Date: Fri, 18 Sep 2015 16:24:10 -0500
Message-ID: <55FC80FA.6020007@us.ibm.com>
References: <20150916125241.4446.44805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150916125241.4446.44805.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>
List-Id: linux-perf-users.vger.kernel.org

On 09/16/2015 07:52 AM, Masami Hiramatsu wrote:
> Fix a segfault bug and a small mistake in perf probe -d.
>
> Since the "ulist" in perf_del_probe_events is never initialized,
> strlist__add(ulist, *) always causes a segfault when removing
> uprobe events by perf probe -d.
>
> Also, the "str" local variable is never released if fail to
> allocate the "klist". This fixes it too.
>
> This has been introduced by the commit e607f1426b58 ("perf probe:
> Print deleted events in cmd_probe()").
>
> Reported-by: Milian Wolff <milian.wolff@kdab.com>
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> ---
>   tools/perf/builtin-probe.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 94385ee..f7882ae 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -380,8 +380,11 @@ static int perf_del_probe_events(struct strfilter *filter)
>   		goto out;
>
>   	klist = strlist__new(NULL, NULL);
> -	if (!klist)
> -		return -ENOMEM;
> +	ulist = strlist__new(NULL, NULL);
> +	if (!klist || !ulist) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}

Newbie here, but if one of "strlist__new()" calls succeeds, don't you 
need a corresponding strlist__delete() ?

PC
