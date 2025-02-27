Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6475220687
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640372; cv=none; b=PEQGBVK25zwX82EvZmn5/7xrqc3KiF3nicnC6b0tOr8r7wqAEIsjjGNvWUePnNKfJDB8TgFiPdJepMq6jq5tg3EGEjywHHJ7oCjgugSRIoig+H6sk93bTJT/ye1n6UAV+IL+YEaEOFiD8F7zF30YsMpymvmxTauRO0tTDRWfPN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640372; c=relaxed/simple;
	bh=jcWM9NpGSNTS645q0+/uGnQujHJyt1o3XYGI9AHv8Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFn+coSLlgdXf2uspJSZ6OBIwXsXXnw1hhr7cskufZ2eRi1izMIhAA3QW6NMsojOJS1Xr8gU/vnt+SmRiL8NEP+iAgkRntm3iNN8ILCjNyuN21ycRM+BZLNzQasXdBVBcSz87yOuhXBo6NJ8IucuaBkxQL0KYQowoJeJ2ofazQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIuMrOgC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIuMrOgC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221ac1f849fso78815ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 23:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740640370; x=1741245170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhkOz7u1U3PreeWOEqe+niiEzqkjN6j7foSOEu5bfPk=;
        b=BIuMrOgCqZOuINp//rxTUp4DDbsh2mila12pT3vTFQt5T7ajtdeaVOrUDXVe7TPGlg
         ZVA3jSngfHnV+2vlUXS54Yl1on6YrHjstL2tC7EEN/PgFH697KfUZELPPk9+yn5T+u2G
         5naFdCB6dyzHkq6sUYUtDpT87/Bd/kGDZ/QaYBzvAq4VzujnFYXxZ6BF01HWuU89fLsK
         BbSCEdmC7eI4lynOR7QwMWrTeAhaknPUsFqXTiu1s53MXna9IjRicQPKrj+UtKcmOM7Z
         hMuuiSIrY7ECFvDChLeQVbIVlQwZV/kV+U9WKLgh2omCBPHbhQjNjxtht+Epcpmv/djO
         ZJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740640370; x=1741245170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhkOz7u1U3PreeWOEqe+niiEzqkjN6j7foSOEu5bfPk=;
        b=Ltzdm9k6TKDhN1yb6JwzIRR6O2t12oioFCH+9LguAJ5o/k7wIh3G9lRSJQ5sgxtFOH
         OGV3xPlwjEBlJ47mBrmyzoLV6bRwtaXeFSEcWl6Z5RRMNjEsId4D86ANOmBDHDD9aLC5
         Rg45oA1Gz/4YcvTBWYnJeX5ihEIcPQ/N6wSAG+sN0J6EKnbI4mA3tMHb02a61/nMEUlG
         3tAnkbr4eQrR3MbDrEKQEQ0dY/9DT7m1bMcL8hD6sYE1cc6a97UOw0NlfSvla49bhHZ6
         TNtDmp1MMaZf7RvyKzuLDUwmMaT5mso/GCN24JFo3QIYQzSQOZy4mFWEsDX/K2qCm6Fi
         DxeA==
X-Forwarded-Encrypted: i=1; AJvYcCUDsEgenEoO3PrNCIrXEyfwQi8OvJ9at4pFtQSVaM8shtt4/Kb3UvijZV2OQL27mYvIkauQPg4FYZ01+rPcJkYx@vger.kernel.org
X-Gm-Message-State: AOJu0YxLt+u3+SPiN79lT3cuTAduie2oRIXsUfBmMk5edNN5vh+YMDZj
	npDxy5XW4r/C/Gd+xTonT5I1SoDmq00xSkdMngWpS0AlW2UGGwLZnQijFHwzsqEhktkzQgCLlEi
	vnbcDYJBwFd7PcKXg/2svVOtfMl3AIfoT3GHl
X-Gm-Gg: ASbGnctRTBoE1iy5VPS8ptBow4gol94eRMy1Ba+TSURWNUQuqQQbHZBI1/TykM6GZIF
	pVOCPUJTrHcPj4WTCBrR6s0XO5Mgg6wPDgErNSxhLo/87NzUdOWlkGRT8OLJilqPC59SETT+3VS
	qB4W9bKZm6
X-Google-Smtp-Source: AGHT+IEDm1LEfkb0IAuPxTVJg0XP6FduTJY9xue38G9/rWT727qBQ0NS4uq+X1hnqmtdIg6PJj+VZ/Qkl2BT4iZ9z+Q=
X-Received: by 2002:a17:902:f68d:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-223517240eemr1291535ad.7.1740640369813; Wed, 26 Feb 2025
 23:12:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com>
In-Reply-To: <20250227053738.788153-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 23:12:37 -0800
X-Gm-Features: AQ5f1JpJmtwCkC475leJkHi8dbdwLRVdTLqfvU7KJU9f7qJHZsjzlPveTYpt5nQ
Message-ID: <CAP-5=fUU05CJhXJuSPt61+H8jC07YuVtkCZwf9Dcawa0AGffSg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	dvyukov@google.com, ak@linux.intel.com, james.clark@linaro.org, 
	christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:37=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> asan runtime error:
>
>   # Build with asan
>   $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g -fn=
o-omit-frame-pointer -fsanitize=3Dundefined"
>   # Test success with many asan runtime errors:
>   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
>    83: Zstd perf.data compression/decompression:
>   ...
>   util/session.c:1959:13: runtime error: member access within misaligned =
address 0x7f69e3f99653 for type 'union perf_event', which requires 13 byte =
alignment
>   0x7f69e3f99653: note: pointer points here
>    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 0=
0 00 00  00 00 00 ff 07 00 00
>                 ^
>   util/session.c:2163:22: runtime error: member access within misaligned =
address 0x7f69e3f99653 for type 'union perf_event', which requires 8 byte a=
lignment
>   0x7f69e3f99653: note: pointer points here
>    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 0=
0 00 00  00 00 00 ff 07 00 00
>                 ^
>   ...
>
> Since there is no way to align compressed data in zstd compression, this
> patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a field
> `data_size` to specify the actual compressed data size. The
> `header.size` contains the total record size, including the padding at
> the end to make it 8-byte aligned.
>
> Tested with `Zstd perf.data compression/decompression`
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt      |  1 +
>  tools/lib/perf/include/perf/event.h           | 12 ++++++++++
>  .../Documentation/perf.data-file-format.txt   | 17 +++++++++++---
>  tools/perf/builtin-record.c                   | 23 +++++++++++++++----
>  tools/perf/util/event.c                       |  1 +
>  tools/perf/util/session.c                     |  5 +++-
>  tools/perf/util/tool.c                        | 11 +++++++--
>  7 files changed, 59 insertions(+), 11 deletions(-)
>
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Do=
cumentation/libperf.txt
> index 59aabdd3cabf..4072bc9b7670 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -210,6 +210,7 @@ SYNOPSIS
>    struct perf_record_time_conv;
>    struct perf_record_header_feature;
>    struct perf_record_compressed;
> +  struct perf_record_compressed2;
>  --
>
>  DESCRIPTION
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include=
/perf/event.h
> index 37bb7771d914..09b7c643ddac 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -457,6 +457,16 @@ struct perf_record_compressed {
>         char                     data[];
>  };
>
> +/*
> + * `header.size` includes the padding we are going to add while writing =
the record.
> + * `data_size` only includes the size of `data[]` itself.
> + */
> +struct perf_record_compressed2 {
> +       struct perf_event_header header;
> +       __u64                    data_size;
> +       char                     data[];

Just to note that data_size has to be u16 or smaller due to
header.size, so I think you can save some bytes by using a u16 or u8
(for the u8 you could just count the amount of padding and: data_size
=3D header.size - padding_size).

Thanks,
Ian

> +};
> +
>  enum perf_user_event_type { /* above any possible kernel type */
>         PERF_RECORD_USER_TYPE_START             =3D 64,
>         PERF_RECORD_HEADER_ATTR                 =3D 64,
> @@ -478,6 +488,7 @@ enum perf_user_event_type { /* above any possible ker=
nel type */
>         PERF_RECORD_HEADER_FEATURE              =3D 80,
>         PERF_RECORD_COMPRESSED                  =3D 81,
>         PERF_RECORD_FINISHED_INIT               =3D 82,
> +       PERF_RECORD_COMPRESSED2                 =3D 83,
>         PERF_RECORD_HEADER_MAX
>  };
>
> @@ -518,6 +529,7 @@ union perf_event {
>         struct perf_record_time_conv            time_conv;
>         struct perf_record_header_feature       feat;
>         struct perf_record_compressed           pack;
> +       struct perf_record_compressed2          pack2;
>  };
>
>  #endif /* __LIBPERF_EVENT_H */
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/p=
erf/Documentation/perf.data-file-format.txt
> index 010a4edcd384..f5faceb0e248 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -604,6 +604,10 @@ contain information that otherwise would be in perf.=
data file's header.
>
>         PERF_RECORD_COMPRESSED                  =3D 81,
>
> +The header is followed by compressed data frame that can be decompressed
> +into array of perf trace records. The size of the entire compressed even=
t
> +record including the header is limited by the max value of header.size.
> +
>  struct compressed_event {
>         struct perf_event_header        header;
>         char                            data[];
> @@ -618,10 +622,17 @@ This is used, for instance, to 'perf inject' events=
 after init and before
>  regular events, those emitted by the kernel, to support combining guest =
and
>  host records.
>
> +       PERF_RECORD_COMPRESSED2                 =3D 83,
>
> -The header is followed by compressed data frame that can be decompressed
> -into array of perf trace records. The size of the entire compressed even=
t
> -record including the header is limited by the max value of header.size.
> +8-byte aligned version of `PERF_RECORD_COMPRESSED`. `header.size` indica=
tes the
> +total record size, including padding for 8-byte alignment, and `data_siz=
e`
> +specifies the actual size of the compressed data.
> +
> +struct perf_record_compressed2 {
> +       struct perf_event_header        header;
> +       __u64                           data_size;
> +       char                            data[];
> +};
>
>  Event types
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 9af3f21fd015..d07ad670daa7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -648,14 +648,27 @@ static int record__pushfn(struct mmap *map, void *t=
o, void *bf, size_t size)
>         struct record *rec =3D to;
>
>         if (record__comp_enabled(rec)) {
> +               struct perf_record_compressed2 *event =3D map->data;
> +               size_t padding =3D 0;
> +               u8 pad[8] =3D {0};
>                 ssize_t compressed =3D zstd_compress(rec->session, map, m=
ap->data,
>                                                    mmap__mmap_len(map), b=
f, size);
>
>                 if (compressed < 0)
>                         return (int)compressed;
>
> -               size =3D compressed;
> -               bf   =3D map->data;
> +               bf =3D event;
> +               thread->samples++;
> +
> +               /*
> +                * The record from `zstd_compress` is not 8 bytes aligned=
, which would cause asan
> +                * error. We make it aligned here.
> +                */
> +               event->data_size =3D compressed - sizeof(struct perf_reco=
rd_compressed2);
> +               event->header.size =3D PERF_ALIGN(compressed, sizeof(u64)=
);
> +               padding =3D event->header.size - compressed;
> +               return record__write(rec, map, bf, compressed) ||
> +                      record__write(rec, map, &pad, padding);
>         }
>
>         thread->samples++;
> @@ -1534,7 +1547,7 @@ static void record__adjust_affinity(struct record *=
rec, struct mmap *map)
>
>  static size_t process_comp_header(void *record, size_t increment)
>  {
> -       struct perf_record_compressed *event =3D record;
> +       struct perf_record_compressed2 *event =3D record;
>         size_t size =3D sizeof(*event);
>
>         if (increment) {
> @@ -1542,7 +1555,7 @@ static size_t process_comp_header(void *record, siz=
e_t increment)
>                 return increment;
>         }
>
> -       event->header.type =3D PERF_RECORD_COMPRESSED;
> +       event->header.type =3D PERF_RECORD_COMPRESSED2;
>         event->header.size =3D size;
>
>         return size;
> @@ -1552,7 +1565,7 @@ static ssize_t zstd_compress(struct perf_session *s=
ession, struct mmap *map,
>                             void *dst, size_t dst_size, void *src, size_t=
 src_size)
>  {
>         ssize_t compressed;
> -       size_t max_record_size =3D PERF_SAMPLE_MAX_SIZE - sizeof(struct p=
erf_record_compressed) - 1;
> +       size_t max_record_size =3D PERF_SAMPLE_MAX_SIZE - sizeof(struct p=
erf_record_compressed2) - 1;
>         struct zstd_data *zstd_data =3D &session->zstd_data;
>
>         if (map && map->file)
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index c23b77f8f854..80c9ea682413 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -77,6 +77,7 @@ static const char *perf_event__names[] =3D {
>         [PERF_RECORD_HEADER_FEATURE]            =3D "FEATURE",
>         [PERF_RECORD_COMPRESSED]                =3D "COMPRESSED",
>         [PERF_RECORD_FINISHED_INIT]             =3D "FINISHED_INIT",
> +       [PERF_RECORD_COMPRESSED2]               =3D "COMPRESSED2",
>  };
>
>  const char *perf_event__name(unsigned int id)
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 60fb9997ea0d..db2653322f9f 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1400,7 +1400,9 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>         int err;
>
>         perf_sample__init(&sample, /*all=3D*/true);
> -       if (event->header.type !=3D PERF_RECORD_COMPRESSED || perf_tool__=
compressed_is_stub(tool))
> +       if ((event->header.type !=3D PERF_RECORD_COMPRESSED &&
> +            event->header.type !=3D PERF_RECORD_COMPRESSED2) ||
> +           perf_tool__compressed_is_stub(tool))
>                 dump_event(session->evlist, event, file_offset, &sample, =
file_path);
>
>         /* These events are processed right away */
> @@ -1481,6 +1483,7 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                 err =3D tool->feature(session, event);
>                 break;
>         case PERF_RECORD_COMPRESSED:
> +       case PERF_RECORD_COMPRESSED2:
>                 err =3D tool->compressed(session, event, file_offset, fil=
e_path);
>                 if (err)
>                         dump_event(session->evlist, event, file_offset, &=
sample, file_path);
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 3b7f390f26eb..37bd8ac63b01 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -43,8 +43,15 @@ static int perf_session__process_compressed_event(stru=
ct perf_session *session,
>                 decomp->size =3D decomp_last_rem;
>         }
>
> -       src =3D (void *)event + sizeof(struct perf_record_compressed);
> -       src_size =3D event->pack.header.size - sizeof(struct perf_record_=
compressed);
> +       if (event->header.type =3D=3D PERF_RECORD_COMPRESSED) {
> +               src =3D (void *)event + sizeof(struct perf_record_compres=
sed);
> +               src_size =3D event->pack.header.size - sizeof(struct perf=
_record_compressed);
> +       } else if (event->header.type =3D=3D PERF_RECORD_COMPRESSED2) {
> +               src =3D (void *)event + sizeof(struct perf_record_compres=
sed2);
> +               src_size =3D event->pack2.data_size;
> +       } else {
> +               return -1;
> +       }
>
>         decomp_size =3D zstd_decompress_stream(session->active_decomp->zs=
td_decomp, src, src_size,
>                                 &(decomp->data[decomp_last_rem]), decomp_=
len - decomp_last_rem);
> --
> 2.48.1.658.g4767266eb4-goog
>
