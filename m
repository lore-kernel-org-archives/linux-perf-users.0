From: Shawn Landden <slandden@gmail.com>
Subject: Re: [PATCH 05/44] perf data: Fix 'strncat may truncate' build failure
 with recent gcc
Date: Mon, 27 May 2019 17:46:26 -0500
Message-ID: <CA+49okqviNfP087Z34-P4mJuMYc8_PiNJgTPz0xSAxqtp4iM0A@mail.gmail.com>
References: <20190527223730.11474-1-acme@kernel.org> <20190527223730.11474-6-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527223730.11474-6-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, May 27, 2019 at 5:38 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Shawn Landden <shawn@git.icu>
>
> This strncat() is safe because the buffer was allocated with zalloc(),
> however gcc doesn't know that. Since the string always has 4 non-null
> bytes, just use memcpy() here.
>
>     CC       /home/shawn/linux/tools/perf/util/data-convert-bt.o
>   In file included from /usr/include/string.h:494,
>                    from /home/shawn/linux/tools/lib/traceevent/event-pars=
e.h:27,
>                    from util/data-convert-bt.c:22:
>   In function =E2=80=98strncat=E2=80=99,
>       inlined from =E2=80=98string_set_value=E2=80=99 at util/data-conver=
t-bt.c:274:4:
>   /usr/include/powerpc64le-linux-gnu/bits/string_fortified.h:136:10: erro=
r: =E2=80=98__builtin_strncat=E2=80=99 output may be truncated copying 4 by=
tes from a string of length 4 [-Werror=3Dstringop-truncation]
>     136 |   return __builtin___strncat_chk (__dest, __src, __len, __bos (=
__dest));
>         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>
> Signed-off-by: Shawn Landden <shawn@git.icu>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> LPU-Reference: 20190518183238.10954-1-shawn@git.icu
> Link: https://lkml.kernel.org/n/tip-289f1jice17ta7tr3tstm9jm@git.kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/data-convert-bt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-con=
vert-bt.c
> index e0311c9750ad..9097543a818b 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -271,7 +271,7 @@ static int string_set_value(struct bt_ctf_field *fiel=
d, const char *string)
>                                 if (i > 0)
>                                         strncpy(buffer, string, i);
>                         }
> -                       strncat(buffer + p, numstr, 4);
> +                       memcpy(buffer + p, numstr, 4);
I took care to have enough context in my patch that you could see what
was going on. I wonder if there is a way to make that care
propate when people add Signed-off-by: lines.
>                         p +=3D 3;
>                 }
>         }
> --
> 2.20.1
>
