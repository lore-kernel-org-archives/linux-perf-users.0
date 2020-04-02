From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf script: fix invalid read
Date: Thu, 2 Apr 2020 12:15:37 -0300
Message-ID: <20200402151537.GA8736@kernel.org>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402124337.419456-1-agerstmayr@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200402124337.419456-1-agerstmayr@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Apr 02, 2020 at 02:43:38PM +0200, Andreas Gerstmayr escreveu:
> closedir(lang_dir) frees the memory of script_dirent->d_name, which
> gets accessed in the next line in a call to scnprintf().
> 
> Valgrind report:
> 
> Invalid read of size 1
> ==413557==    at 0x483CBE6: strlen (vg_replace_strmem.c:461)
> ==413557==    by 0x4DD45FD: __vfprintf_internal (vfprintf-internal.c:1688)
> ==413557==    by 0x4DE6679: __vsnprintf_internal (vsnprintf.c:114)
> ==413557==    by 0x53A037: vsnprintf (stdio2.h:80)
> ==413557==    by 0x53A037: scnprintf (vsprintf.c:21)
> ==413557==    by 0x435202: get_script_path (builtin-script.c:3223)
> ==413557==  Address 0x52e7313 is 1,139 bytes inside a block of size 32,816 free'd
> ==413557==    at 0x483AA0C: free (vg_replace_malloc.c:540)
> ==413557==    by 0x4E303C0: closedir (closedir.c:50)
> ==413557==    by 0x4351DC: get_script_path (builtin-script.c:3222)

Thanks, applied to perf/urgent.

- Arnaldo
 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 656b347f6dd8..170af13b4d53 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3218,10 +3218,10 @@ static char *get_script_path(const char *script_root, const char *suffix)
>  			__script_root = get_script_root(script_dirent, suffix);
>  			if (__script_root && !strcmp(script_root, __script_root)) {
>  				free(__script_root);
> -				closedir(lang_dir);
>  				closedir(scripts_dir);
>  				scnprintf(script_path, MAXPATHLEN, "%s/%s",
>  					  lang_path, script_dirent->d_name);
> +				closedir(lang_dir);
>  				return strdup(script_path);
>  			}
>  			free(__script_root);
> -- 
> 2.25.1
> 

-- 

- Arnaldo
