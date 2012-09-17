From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3] memory leak fix while calling system_path
Date: Mon, 17 Sep 2012 12:51:34 +0900
Message-ID: <87haqx8fy1.fsf@sejong.aot.lge.com>
References: <CADu=CFrGDZ7waQbigcm43_Jm0NE2BAnmr0263iNAm-=A8erwBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADu=CFrGDZ7waQbigcm43_Jm0NE2BAnmr0263iNAm-=A8erwBA@mail.gmail.com>
	(liang xie's message of "Fri, 14 Sep 2012 11:14:13 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: liang xie <xieliang007@gmail.com>
Cc: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, balbi@ti.com, a.p.zijlstra@chello.nl, mingo@elte.hu, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi,

On Fri, 14 Sep 2012 11:14:13 +0800, liang xie wrote:
> memory leak fix while calling system_path
>
> Since v1: Remove an unnecessary null pointer check per Felipe's comments
> Since v2: Make system_path&perf_exec_path always return dynamically
> allocated string
>
> Signed-off-by: xieliang <xieliang@xiaomi.com>
> ---
>  tools/perf/builtin-help.c   |   12 +++++++++---
>  tools/perf/builtin-script.c |   13 ++++++++++---
>  tools/perf/perf.c           |    8 ++++++--
>  tools/perf/util/config.c    |   16 +++++-----------
>  tools/perf/util/exec_cmd.c  |   26 +++++++++++++++-----------
>  tools/perf/util/exec_cmd.h  |    4 ++--
>  tools/perf/util/help.c      |    6 ++++--
>  7 files changed, 51 insertions(+), 34 deletions(-)
>
> diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
> index 6d5a8a7..180a5bd 100644
> --- a/tools/perf/builtin-help.c
> +++ b/tools/perf/builtin-help.c
> @@ -321,12 +321,13 @@ static void setup_man_path(void)
>  {
>  	struct strbuf new_path = STRBUF_INIT;
>  	const char *old_path = getenv("MANPATH");
> +	char *man_path = system_path(PERF_MAN_PATH);

I think the return value of system_path and perf_exec_path should be
checked since they can return NULL as strdup() does.


[snip]
> diff --git a/tools/perf/util/exec_cmd.c b/tools/perf/util/exec_cmd.c
> index 7adf4ad..1ace941 100644
> --- a/tools/perf/util/exec_cmd.c
> +++ b/tools/perf/util/exec_cmd.c
> @@ -9,17 +9,19 @@
>  static const char *argv_exec_path;
>  static const char *argv0_path;
>
> -const char *system_path(const char *path)
> +char *system_path(const char *path)
>  {
> -	static const char *prefix = PREFIX;
> -	struct strbuf d = STRBUF_INIT;
> +	char *new_path = NULL;
>
>  	if (is_absolute_path(path))
> -		return path;
> +		return strdup(path);
>
> -	strbuf_addf(&d, "%s/%s", prefix, path);
> -	path = strbuf_detach(&d, NULL);
> -	return path;
> +	new_path = malloc((strlen(PREFIX) + strlen(path) + 2));
> +	if (!new_path)
> +		die("malloc");
> +
> +	sprintf(new_path, "%s/%s", PREFIX, path);
> +	return new_path;

AFAIK strbuf allocates memory internally, so why this code is needed?

Thanks,
Namhyung
