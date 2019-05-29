From: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 17/41] perf trace beauty clone: Handle CLONE_PIDFD
Date: Wed, 29 May 2019 16:49:16 +0200
Message-ID: <20190529144915.xe5ug7r3u2efuzme@brauner.io>
References: <20190529133605.21118-1-acme@kernel.org>
 <20190529133605.21118-18-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190529133605.21118-18-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 29, 2019 at 10:35:41AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> In addition to the older flags. This will allow something like this to
> be implemented in 'perf trace"
> 
>   perf trace -e clone/PIDFD in flags/
> 
> I.e. ask for strace like tracing, system wide, looking for 'clone'
> syscalls that have the CLONE_PIDFD bit set in the 'flags' arg.
> 
> For now we'll just see PIDFD if it is set in the 'flags' arg.
> 
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-drq9h7s8gcv8b87064fp6lb0@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  tools/perf/trace/beauty/clone.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
> index 6eb9a6636171..1a8d3be2030e 100644
> --- a/tools/perf/trace/beauty/clone.c
> +++ b/tools/perf/trace/beauty/clone.c
> @@ -25,6 +25,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
>  	P_FLAG(FS);
>  	P_FLAG(FILES);
>  	P_FLAG(SIGHAND);
> +	P_FLAG(PIDFD);
>  	P_FLAG(PTRACE);
>  	P_FLAG(VFORK);
>  	P_FLAG(PARENT);
> -- 
> 2.20.1
> 
