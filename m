Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D85198;
	Wed, 29 Nov 2023 17:29:08 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c60026e8dbso378636a12.0;
        Wed, 29 Nov 2023 17:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701307748; x=1701912548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOl8DUMCpga09pAsZWl99kTY8aL8HbXXUUGHs0qmH6s=;
        b=t76zUpJcp+iCVDo7kspGC13uQyKsy7EEs164APKG84uhHnXSHIT5lz1vaMizapkLlt
         SAOkwcQRfrSWKbBFRC/nRC/sm/PDM9Jyk6lNHNJOCqUoaS/xGxCEyfVXWNReQ/DSchwE
         PWGVzgbcqhwwII8xhY5BtzvAbZ1V9+weWAqmOJZkXxoyqbN68MPycma8Jb0KzBALHUxD
         RlkHD6S3DXcUqqjAofzvs/XF6DmmI7NFtcb9argYNmDee48tIenq6en9sEpeOwNxT2We
         8ioEAbgQtEi5WD+c2w6Z2+hXCQKJvaLiRBW+jMjq1phvL7AKFGSGKUyL9Apb0noloXWf
         W05Q==
X-Gm-Message-State: AOJu0YyeCPr4eTNyc+gtFDy0CQq9MnMnEbMchWFkIO2ZRDGWdmkBw0z1
	EdS7cpooPEpc8iGqm4sYFKF0O62Efhh6JAG40i8=
X-Google-Smtp-Source: AGHT+IFS+FLpGEP6ZzUePrPZmnTO62GV81uASGemgRr5j+Dtnl+K8yj7yN0oJA95SWO6A1c4xd6QTVg3LtzKWkjjdd8=
X-Received: by 2002:a17:90b:4b82:b0:286:2e8f:4780 with SMTP id
 lr2-20020a17090b4b8200b002862e8f4780mr2445375pjb.10.1701307748140; Wed, 29
 Nov 2023 17:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-4-irogers@google.com>
In-Reply-To: <20231127220902.1315692-4-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 Nov 2023 17:28:56 -0800
Message-ID: <CAM9d7cg8TRiBVQCO_zKjb+D==06o5a=CH_gF_wDW7_PJtZfHKw@mail.gmail.com>
Subject: Re: [PATCH v5 03/50] perf mmap: Lazily initialize zstd streams
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Zstd streams create dictionaries that can require significant RAM,
> especially when there is one per-CPU. Tools like perf record won't use
> the streams without the -z option, and so the creation of the streams
> is pure overhead. Switch to creating the streams on first use.

I think this one is already in the perf-tools-next.

Thanks,
Namhyung

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 26 ++++++++++-----
>  tools/perf/util/compress.h  |  6 ++--
>  tools/perf/util/mmap.c      |  5 ++-
>  tools/perf/util/mmap.h      |  1 -
>  tools/perf/util/zstd.c      | 63 +++++++++++++++++++------------------
>  5 files changed, 58 insertions(+), 43 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8ec818568662..9b4f3805ca92 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -270,7 +270,7 @@ static int record__write(struct record *rec, struct m=
map *map __maybe_unused,
>
>  static int record__aio_enabled(struct record *rec);
>  static int record__comp_enabled(struct record *rec);
> -static size_t zstd_compress(struct perf_session *session, struct mmap *m=
ap,
> +static ssize_t zstd_compress(struct perf_session *session, struct mmap *=
map,
>                             void *dst, size_t dst_size, void *src, size_t=
 src_size);
>
>  #ifdef HAVE_AIO_SUPPORT
> @@ -405,9 +405,13 @@ static int record__aio_pushfn(struct mmap *map, void=
 *to, void *buf, size_t size
>          */
>
>         if (record__comp_enabled(aio->rec)) {
> -               size =3D zstd_compress(aio->rec->session, NULL, aio->data=
 + aio->size,
> -                                    mmap__mmap_len(map) - aio->size,
> -                                    buf, size);
> +               ssize_t compressed =3D zstd_compress(aio->rec->session, N=
ULL, aio->data + aio->size,
> +                                                  mmap__mmap_len(map) - =
aio->size,
> +                                                  buf, size);
> +               if (compressed < 0)
> +                       return (int)compressed;
> +
> +               size =3D compressed;
>         } else {
>                 memcpy(aio->data + aio->size, buf, size);
>         }
> @@ -633,7 +637,13 @@ static int record__pushfn(struct mmap *map, void *to=
, void *bf, size_t size)
>         struct record *rec =3D to;
>
>         if (record__comp_enabled(rec)) {
> -               size =3D zstd_compress(rec->session, map, map->data, mmap=
__mmap_len(map), bf, size);
> +               ssize_t compressed =3D zstd_compress(rec->session, map, m=
ap->data,
> +                                                  mmap__mmap_len(map), b=
f, size);
> +
> +               if (compressed < 0)
> +                       return (int)compressed;
> +
> +               size =3D compressed;
>                 bf   =3D map->data;
>         }
>
> @@ -1527,10 +1537,10 @@ static size_t process_comp_header(void *record, s=
ize_t increment)
>         return size;
>  }
>
> -static size_t zstd_compress(struct perf_session *session, struct mmap *m=
ap,
> +static ssize_t zstd_compress(struct perf_session *session, struct mmap *=
map,
>                             void *dst, size_t dst_size, void *src, size_t=
 src_size)
>  {
> -       size_t compressed;
> +       ssize_t compressed;
>         size_t max_record_size =3D PERF_SAMPLE_MAX_SIZE - sizeof(struct p=
erf_record_compressed) - 1;
>         struct zstd_data *zstd_data =3D &session->zstd_data;
>
> @@ -1539,6 +1549,8 @@ static size_t zstd_compress(struct perf_session *se=
ssion, struct mmap *map,
>
>         compressed =3D zstd_compress_stream_to_records(zstd_data, dst, ds=
t_size, src, src_size,
>                                                      max_record_size, pro=
cess_comp_header);
> +       if (compressed < 0)
> +               return compressed;
>
>         if (map && map->file) {
>                 thread->bytes_transferred +=3D src_size;
> diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
> index 0cd3369af2a4..9eb6eb5bf038 100644
> --- a/tools/perf/util/compress.h
> +++ b/tools/perf/util/compress.h
> @@ -3,6 +3,7 @@
>  #define PERF_COMPRESS_H
>
>  #include <stdbool.h>
> +#include <stdlib.h>
>  #ifdef HAVE_ZSTD_SUPPORT
>  #include <zstd.h>
>  #endif
> @@ -21,6 +22,7 @@ struct zstd_data {
>  #ifdef HAVE_ZSTD_SUPPORT
>         ZSTD_CStream    *cstream;
>         ZSTD_DStream    *dstream;
> +       int comp_level;
>  #endif
>  };
>
> @@ -29,7 +31,7 @@ struct zstd_data {
>  int zstd_init(struct zstd_data *data, int level);
>  int zstd_fini(struct zstd_data *data);
>
> -size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst=
, size_t dst_size,
> +ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *ds=
t, size_t dst_size,
>                                        void *src, size_t src_size, size_t=
 max_record_size,
>                                        size_t process_header(void *record=
, size_t increment));
>
> @@ -48,7 +50,7 @@ static inline int zstd_fini(struct zstd_data *data __ma=
ybe_unused)
>  }
>
>  static inline
> -size_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_un=
used,
> +ssize_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_u=
nused,
>                                        void *dst __maybe_unused, size_t d=
st_size __maybe_unused,
>                                        void *src __maybe_unused, size_t s=
rc_size __maybe_unused,
>                                        size_t max_record_size __maybe_unu=
sed,
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 49093b21ee2d..122ee198a86e 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -295,15 +295,14 @@ int mmap__mmap(struct mmap *map, struct mmap_params=
 *mp, int fd, struct perf_cpu
>
>         map->core.flush =3D mp->flush;
>
> -       map->comp_level =3D mp->comp_level;
>  #ifndef PYTHON_PERF
> -       if (zstd_init(&map->zstd_data, map->comp_level)) {
> +       if (zstd_init(&map->zstd_data, mp->comp_level)) {
>                 pr_debug2("failed to init mmap compressor, error %d\n", e=
rrno);
>                 return -1;
>         }
>  #endif
>
> -       if (map->comp_level && !perf_mmap__aio_enabled(map)) {
> +       if (mp->comp_level && !perf_mmap__aio_enabled(map)) {
>                 map->data =3D mmap(NULL, mmap__mmap_len(map), PROT_READ|P=
ROT_WRITE,
>                                  MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
>                 if (map->data =3D=3D MAP_FAILED) {
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index f944c3cd5efa..0df6e1621c7e 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -39,7 +39,6 @@ struct mmap {
>  #endif
>         struct mmap_cpu_mask    affinity_mask;
>         void            *data;
> -       int             comp_level;
>         struct perf_data_file *file;
>         struct zstd_data      zstd_data;
>  };
> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index 48dd2b018c47..57027e0ac7b6 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -7,35 +7,9 @@
>
>  int zstd_init(struct zstd_data *data, int level)
>  {
> -       size_t ret;
> -
> -       data->dstream =3D ZSTD_createDStream();
> -       if (data->dstream =3D=3D NULL) {
> -               pr_err("Couldn't create decompression stream.\n");
> -               return -1;
> -       }
> -
> -       ret =3D ZSTD_initDStream(data->dstream);
> -       if (ZSTD_isError(ret)) {
> -               pr_err("Failed to initialize decompression stream: %s\n",=
 ZSTD_getErrorName(ret));
> -               return -1;
> -       }
> -
> -       if (!level)
> -               return 0;
> -
> -       data->cstream =3D ZSTD_createCStream();
> -       if (data->cstream =3D=3D NULL) {
> -               pr_err("Couldn't create compression stream.\n");
> -               return -1;
> -       }
> -
> -       ret =3D ZSTD_initCStream(data->cstream, level);
> -       if (ZSTD_isError(ret)) {
> -               pr_err("Failed to initialize compression stream: %s\n", Z=
STD_getErrorName(ret));
> -               return -1;
> -       }
> -
> +       data->comp_level =3D level;
> +       data->dstream =3D NULL;
> +       data->cstream =3D NULL;
>         return 0;
>  }
>
> @@ -54,7 +28,7 @@ int zstd_fini(struct zstd_data *data)
>         return 0;
>  }
>
> -size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst=
, size_t dst_size,
> +ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *ds=
t, size_t dst_size,
>                                        void *src, size_t src_size, size_t=
 max_record_size,
>                                        size_t process_header(void *record=
, size_t increment))
>  {
> @@ -63,6 +37,21 @@ size_t zstd_compress_stream_to_records(struct zstd_dat=
a *data, void *dst, size_t
>         ZSTD_outBuffer output;
>         void *record;
>
> +       if (!data->cstream) {
> +               data->cstream =3D ZSTD_createCStream();
> +               if (data->cstream =3D=3D NULL) {
> +                       pr_err("Couldn't create compression stream.\n");
> +                       return -1;
> +               }
> +
> +               ret =3D ZSTD_initCStream(data->cstream, data->comp_level)=
;
> +               if (ZSTD_isError(ret)) {
> +                       pr_err("Failed to initialize compression stream: =
%s\n",
> +                               ZSTD_getErrorName(ret));
> +                       return -1;
> +               }
> +       }
> +
>         while (input.pos < input.size) {
>                 record =3D dst;
>                 size =3D process_header(record, 0);
> @@ -96,6 +85,20 @@ size_t zstd_decompress_stream(struct zstd_data *data, =
void *src, size_t src_size
>         ZSTD_inBuffer input =3D { src, src_size, 0 };
>         ZSTD_outBuffer output =3D { dst, dst_size, 0 };
>
> +       if (!data->dstream) {
> +               data->dstream =3D ZSTD_createDStream();
> +               if (data->dstream =3D=3D NULL) {
> +                       pr_err("Couldn't create decompression stream.\n")=
;
> +                       return 0;
> +               }
> +
> +               ret =3D ZSTD_initDStream(data->dstream);
> +               if (ZSTD_isError(ret)) {
> +                       pr_err("Failed to initialize decompression stream=
: %s\n",
> +                               ZSTD_getErrorName(ret));
> +                       return 0;
> +               }
> +       }
>         while (input.pos < input.size) {
>                 ret =3D ZSTD_decompressStream(data->dstream, &output, &in=
put);
>                 if (ZSTD_isError(ret)) {
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
