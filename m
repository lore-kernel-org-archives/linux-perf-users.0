From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH -next] tools build: Check return value of fwrite_unlocked
 in jvmti_agent.c
Date: Wed, 29 Jul 2020 16:47:36 -0700
Message-ID: <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
References: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: cj.chengjian@huawei.com, Li Bin <huawei.libin@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Jul 24, 2020 at 3:07 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Function jvmti_write_code called by compiled_method_load_cb may return
> error in using fwrite_unlocked, this failure should be captured and
> warned.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  tools/perf/jvmti/jvmti_agent.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index 88108598d6e9..a1fe6aa16b6d 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
>         struct jr_code_load rec;
>         size_t sym_len;
>         FILE *fp = agent;
> -       int ret = -1;
> +       int ret;
>
>         /* don't care about 0 length function, no samples */
>         if (size == 0)
> @@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
>         rec.code_index = code_generation++;
>
>         ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
> -       fwrite_unlocked(sym, sym_len, 1, fp);
> +       if (ret)
> +               goto error;

Sorry, it seems I lost a reply to this. Won't ret here be the number
of items written and not an error code? Consequently all writes will
immediately goto error?

Thanks,
Ian

> +       ret = fwrite_unlocked(sym, sym_len, 1, fp);
> +       if (ret)
> +               goto error;
>
> -       if (code)
> -               fwrite_unlocked(code, size, 1, fp);
> +       if (code) {
> +               ret = fwrite_unlocked(code, size, 1, fp);
> +               if (ret)
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
> 2.17.1
>
