From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 -next] tools build: Check return value of
 fwrite_unlocked in jvmti_agent.c
Date: Mon, 3 Aug 2020 08:41:58 -0700
Message-ID: <CAP-5=fWuKDt1piqnbefhungwm8tmZMFecrAqyoaq74qLP6V28w@mail.gmail.com>
References: <20200731114214.25654-1-bobo.shaobowang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200731114214.25654-1-bobo.shaobowang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: cj.chengjian@huawei.com, Arnaldo Carvalho de Melo <acme@kernel.org>, Li Bin <huawei.libin@huawei.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Jul 31, 2020 at 4:42 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Function jvmti_write_code called by compiled_method_load_cb may return
> error in using fwrite_unlocked, this failure should be captured and
> warned.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

Thanks, looks good now!

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/jvmti/jvmti_agent.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index 88108598d6e9..dfb6cb8564cb 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
>         struct jr_code_load rec;
>         size_t sym_len;
>         FILE *fp = agent;
> -       int ret = -1;
> +       int sret;
>
>         /* don't care about 0 length function, no samples */
>         if (size == 0)
> @@ -400,17 +400,24 @@ jvmti_write_code(void *agent, char const *sym,
>          */
>         rec.code_index = code_generation++;
>
> -       ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
> -       fwrite_unlocked(sym, sym_len, 1, fp);
> +       sret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
> +       if (sret != 1)
> +               goto error;
> +       sret = fwrite_unlocked(sym, sym_len, 1, fp);
> +       if (sret != 1)
> +               goto error;
>
> -       if (code)
> -               fwrite_unlocked(code, size, 1, fp);
> +       if (code) {
> +               sret = fwrite_unlocked(code, size, 1, fp);
> +               if (sret != 1)
> +                       goto error;
> +       }
>
>         funlockfile(fp);
> -
> -       ret = 0;
> -
> -       return ret;
> +       return 0;
> +error:
> +       funlockfile(fp);
> +       return -1;
>  }
>
>  int
> --
> 2.25.1
>
