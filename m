From: Martin Vuille <jpmv27@aim.com>
Subject: Re: [PATCH RESEND] perf annotate: Don't prepend symfs path to
 build_id_filename
Date: Fri, 23 Mar 2018 08:16:57 -0400
Message-ID: <3f18ff8d-ef93-a48c-2f27-c8780edc1bf7@aim.com>
References: <20180313135618.2900-1-jpmv27@aim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313135618.2900-1-jpmv27@aim.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Ping?


On 03/13/18 09:56, Martin Vuille wrote:
> build_id_filename already contains symfs path if applicable, so
> don't prepend it a second time.
>
> - dso__build_id_filename calls build_id_cache__linkname
> - build_id_cache__linkname uses buildid_dir
> - when symfs option is specified, symbol__config_symfs sets
>    buildid_dir to include the symfs directory
>
> Signed-off-by: Martin Vuille <jpmv27@aim.com>
> ---
>   tools/perf/util/annotate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 007170efa014..0b78cc4fb155 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1381,7 +1381,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>   
>   	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
>   	if (build_id_filename) {
> -		__symbol__join_symfs(filename, filename_size, build_id_filename);
> +		scnprintf(filename, filename_size, "%s", build_id_filename);
>   		free(build_id_filename);
>   	} else {
>   		if (dso->has_build_id)
