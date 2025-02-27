Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916161B4250
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680515; cv=none; b=Ix2Nsxqz4k6pzVv2WbDVsfCMmje7juYaFLSzYNOoMprjN5sTxLtvJEe5Z+9N8uFB4rGA1FLjHrbGBCWCQmLzwSQHuFyVfgEh8lQOiD5+MYnWl5jCXqExzQpOex/QGkOewKJkRaQ6HVRG2JMiwVJy+zkVnUsjlMhVcu4dHwE62QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680515; c=relaxed/simple;
	bh=QWDO1e1shJVDCb1GSZyvp8J6tlabqkVyUA6I/bO95ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6m4uzMCQ0t49XTkDGB24EWuzYa1gNs0CTYcK4pEpLVf/eNLsHM37gJnJUya/dS1QTm6YOoh4d9iG06HFmSzUe72N6mHfdaXqtHd58wYg+Vd3wFji35DxpC9+acawQYCxonswUx4BFN3JI/tv597z6DA2etnNK5EY5SRmjPuGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nde+9e5b; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nde+9e5b"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbd96bef64so210937466b.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740680511; x=1741285311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol0ZRTN6kcATXeTr76xNFmdSj9gMYwq5K7wqpQOxJVg=;
        b=Nde+9e5beR0uBMy9dHKKeAT4yC1hh8s0GT5PsGEbQc+0UNsWdq2BDCc6Z1wZ1ntDe/
         llSC7C5acMBx1ZBqdI9DKp75pe/7/PlGd+I0AIXKnYLQKa0ObkdCxR/Z5w9vHw2ldW4o
         B6TdM5Wj/5jv2vMiGc0t6BxuUDMHpvbdbKOETwhPvPK98ZXEb6i3RFf7J94XNIEcPZNK
         gaQO9XL69xtMdEeCb0BXAx6f1e+lAyrQDnWCoY1/WRQKhiIX4CfDkO0d8UjqKtCEbe/G
         Kd9TK5CGdyQkAaKuR5437zzx+NO8UG4AIEKJ7zwuZVxiXonVZMYNNmjZ600L4okcVfAb
         kuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680511; x=1741285311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol0ZRTN6kcATXeTr76xNFmdSj9gMYwq5K7wqpQOxJVg=;
        b=woUIXyPKHsUw87MySfZOkBoxIOs1D74Vh7AKFH3ThsUTy+Cb0Y12CP8/UOJ99fWQbK
         MLOiFKljBu9GA2VxxPg82bA7S9RAlgPwafBHTkZ+nE1sLbyIavMsvtYkIKx5AbIEthWp
         iUinymeRDP9FTPL5Ktvc25KUxiP/Fdm4MqlJRplTXLnkwhfVV5ZWELm0d4a5r4SpY1Ke
         W2ZC4TXDZJWte4XrWy9w6O3LBccVrm20Ycy4WgX299RN448KU19nYYVASfjQvf30gkOV
         tm4+uF+pNgiWRyWNE71Dsln4bwi3YKMIP/aIUMwCIxWhN/g9nIpLdSnRw2WJ25n00zMS
         UoWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYMXO6mbRjCoRDLtjXrQAVZqWY0Famxc1tNdOfn8DFWtnRyiU3sEQPSiLknd1y/5gfPvHuEogR2DK9vo1sVG57@vger.kernel.org
X-Gm-Message-State: AOJu0YyLS1XVfGfJEQzxsnhtLmRX63a8XGkOZ2LoGpgpIouIH7cgKTK1
	ODwzs2Z9Q8cR+1qvk8wxQtiVdD8oLOmraNYc5cxTuALFH6MYGnH0M+Q3vbg0dZbr1xs3aScrCo+
	gUp2XEvkt/UArDs7F4gvEk7OOgSnjuCAg/TrQ
X-Gm-Gg: ASbGncs6zO1tTOEgCM7idj9tBuqr2qu6KNcPaFjVTzJWCbdMP4cz4271Z6KiaBIPi18
	igN5aR2paNhGZbq+wlR85w2ghXb7AGE8aF1jKTWOOH7V0c/z5oEX5NFyVEEzjE+L+/JF7l8DHov
	FcFBtN8DhuV9NkxBpRQxFz8QWMRqkpB5dhEL8KuYE=
X-Google-Smtp-Source: AGHT+IFdJxZjTeKXHqk4VQO0mJdhppztUBerqGuv1cKf5tV9kj/c8LgRdwrwKegnpCV2P64KehdfUebfmmBECZAPOfo=
X-Received: by 2002:a17:907:70a:b0:abb:b1a4:b0fe with SMTP id
 a640c23a62f3a-abf25da2d29mr45655066b.1.1740680510612; Thu, 27 Feb 2025
 10:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com> <CAP-5=fUU05CJhXJuSPt61+H8jC07YuVtkCZwf9Dcawa0AGffSg@mail.gmail.com>
 <Z8AjtizjixQb3qB6@google.com>
In-Reply-To: <Z8AjtizjixQb3qB6@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 27 Feb 2025 10:21:38 -0800
X-Gm-Features: AQ5f1JpRZXK75Wat68gde5nLE_5aEwd2BfxJVMfOxmwVAila5nrlGiOw-w2ni6I
Message-ID: <CAJpZYjXm9BrSwTSri3qvoj0JarAgUqH6w_4PjanTsLTTNanZYQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	dvyukov@google.com, ak@linux.intel.com, james.clark@linaro.org, 
	christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Feb 26, 2025 at 11:12:37PM -0800, Ian Rogers wrote:
> > On Wed, Feb 26, 2025 at 9:37=E2=80=AFPM Chun-Tse Shao <ctshao@google.co=
m> wrote:
> > >
> > > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can ca=
use
> > > asan runtime error:
> > >
> > >   # Build with asan
> > >   $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g=
 -fno-omit-frame-pointer -fsanitize=3Dundefined"
> > >   # Test success with many asan runtime errors:
> > >   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -v=
v
> > >    83: Zstd perf.data compression/decompression:
> > >   ...
> > >   util/session.c:1959:13: runtime error: member access within misalig=
ned address 0x7f69e3f99653 for type 'union perf_event', which requires 13 b=
yte alignment
> > >   0x7f69e3f99653: note: pointer points here
> > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 =
00 00 00 00  00 00 00 ff 07 00 00
> > >                 ^
> > >   util/session.c:2163:22: runtime error: member access within misalig=
ned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 by=
te alignment
> > >   0x7f69e3f99653: note: pointer points here
> > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 =
00 00 00 00  00 00 00 ff 07 00 00
> > >                 ^
> > >   ...
> > >
> > > Since there is no way to align compressed data in zstd compression, t=
his
> > > patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a fi=
eld
> > > `data_size` to specify the actual compressed data size. The
> > > `header.size` contains the total record size, including the padding a=
t
> > > the end to make it 8-byte aligned.
> > >
> > > Tested with `Zstd perf.data compression/decompression`
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > ---
> > >  tools/lib/perf/Documentation/libperf.txt      |  1 +
> > >  tools/lib/perf/include/perf/event.h           | 12 ++++++++++
> > >  .../Documentation/perf.data-file-format.txt   | 17 +++++++++++---
> > >  tools/perf/builtin-record.c                   | 23 +++++++++++++++--=
--
> > >  tools/perf/util/event.c                       |  1 +
> > >  tools/perf/util/session.c                     |  5 +++-
> > >  tools/perf/util/tool.c                        | 11 +++++++--
> > >  7 files changed, 59 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/per=
f/Documentation/libperf.txt
> > > index 59aabdd3cabf..4072bc9b7670 100644
> > > --- a/tools/lib/perf/Documentation/libperf.txt
> > > +++ b/tools/lib/perf/Documentation/libperf.txt
> > > @@ -210,6 +210,7 @@ SYNOPSIS
> > >    struct perf_record_time_conv;
> > >    struct perf_record_header_feature;
> > >    struct perf_record_compressed;
> > > +  struct perf_record_compressed2;
> > >  --
> > >
> > >  DESCRIPTION
> > > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/inc=
lude/perf/event.h
> > > index 37bb7771d914..09b7c643ddac 100644
> > > --- a/tools/lib/perf/include/perf/event.h
> > > +++ b/tools/lib/perf/include/perf/event.h
> > > @@ -457,6 +457,16 @@ struct perf_record_compressed {
> > >         char                     data[];
> > >  };
> > >
> > > +/*
> > > + * `header.size` includes the padding we are going to add while writ=
ing the record.
> > > + * `data_size` only includes the size of `data[]` itself.
> > > + */
> > > +struct perf_record_compressed2 {
> > > +       struct perf_event_header header;
> > > +       __u64                    data_size;
> > > +       char                     data[];
> >
> > Just to note that data_size has to be u16 or smaller due to
> > header.size, so I think you can save some bytes by using a u16 or u8
> > (for the u8 you could just count the amount of padding and: data_size
> > =3D header.size - padding_size).
>
> I was about to suggest using the header.misc in the existing
> perf_record_compress.  As the padding is up to 7 byte, we could
>
>   header.type =3D PERF_RECORD_COMPRESS;
>   header.size =3D PERF_ALIGN(real_size, 8);
>   header.misc =3D header.size - real_size;
>
> Assuming the old data doesn't set the misc field and have 0.  Then it
> would be compatible with old data and get the real size in new data.

I was thinking the same way and realized the uninitialized `misc`
problem while I was testing this implementation.
Also I think it would be good to have a new type, at least if
something wrong happens unexpectedly, we know that it is caused by old
or new compressed event.

>
> But unfortunately, I found process_comp_header() didn't reset the misc
> field so it may have garbage in old data.  Then the above won't work. :(
>
> Thanks,
> Namhyung
>
> >
> > Thanks,
> > Ian
> >
> > > +};
> > > +
> > >  enum perf_user_event_type { /* above any possible kernel type */
> > >         PERF_RECORD_USER_TYPE_START             =3D 64,
> > >         PERF_RECORD_HEADER_ATTR                 =3D 64,
> > > @@ -478,6 +488,7 @@ enum perf_user_event_type { /* above any possible=
 kernel type */
> > >         PERF_RECORD_HEADER_FEATURE              =3D 80,
> > >         PERF_RECORD_COMPRESSED                  =3D 81,
> > >         PERF_RECORD_FINISHED_INIT               =3D 82,
> > > +       PERF_RECORD_COMPRESSED2                 =3D 83,
> > >         PERF_RECORD_HEADER_MAX
> > >  };
> > >
> > > @@ -518,6 +529,7 @@ union perf_event {
> > >         struct perf_record_time_conv            time_conv;
> > >         struct perf_record_header_feature       feat;
> > >         struct perf_record_compressed           pack;
> > > +       struct perf_record_compressed2          pack2;
> > >  };
> > >
> > >  #endif /* __LIBPERF_EVENT_H */
> > > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/too=
ls/perf/Documentation/perf.data-file-format.txt
> > > index 010a4edcd384..f5faceb0e248 100644
> > > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > > @@ -604,6 +604,10 @@ contain information that otherwise would be in p=
erf.data file's header.
> > >
> > >         PERF_RECORD_COMPRESSED                  =3D 81,
> > >
> > > +The header is followed by compressed data frame that can be decompre=
ssed
> > > +into array of perf trace records. The size of the entire compressed =
event
> > > +record including the header is limited by the max value of header.si=
ze.
> > > +
> > >  struct compressed_event {
> > >         struct perf_event_header        header;
> > >         char                            data[];
> > > @@ -618,10 +622,17 @@ This is used, for instance, to 'perf inject' ev=
ents after init and before
> > >  regular events, those emitted by the kernel, to support combining gu=
est and
> > >  host records.
> > >
> > > +       PERF_RECORD_COMPRESSED2                 =3D 83,
> > >
> > > -The header is followed by compressed data frame that can be decompre=
ssed
> > > -into array of perf trace records. The size of the entire compressed =
event
> > > -record including the header is limited by the max value of header.si=
ze.
> > > +8-byte aligned version of `PERF_RECORD_COMPRESSED`. `header.size` in=
dicates the
> > > +total record size, including padding for 8-byte alignment, and `data=
_size`
> > > +specifies the actual size of the compressed data.
> > > +
> > > +struct perf_record_compressed2 {
> > > +       struct perf_event_header        header;
> > > +       __u64                           data_size;
> > > +       char                            data[];
> > > +};
> > >
> > >  Event types
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.=
c
> > > index 9af3f21fd015..d07ad670daa7 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -648,14 +648,27 @@ static int record__pushfn(struct mmap *map, voi=
d *to, void *bf, size_t size)
> > >         struct record *rec =3D to;
> > >
> > >         if (record__comp_enabled(rec)) {
> > > +               struct perf_record_compressed2 *event =3D map->data;
> > > +               size_t padding =3D 0;
> > > +               u8 pad[8] =3D {0};
> > >                 ssize_t compressed =3D zstd_compress(rec->session, ma=
p, map->data,
> > >                                                    mmap__mmap_len(map=
), bf, size);
> > >
> > >                 if (compressed < 0)
> > >                         return (int)compressed;
> > >
> > > -               size =3D compressed;
> > > -               bf   =3D map->data;
> > > +               bf =3D event;
> > > +               thread->samples++;
> > > +
> > > +               /*
> > > +                * The record from `zstd_compress` is not 8 bytes ali=
gned, which would cause asan
> > > +                * error. We make it aligned here.
> > > +                */
> > > +               event->data_size =3D compressed - sizeof(struct perf_=
record_compressed2);
> > > +               event->header.size =3D PERF_ALIGN(compressed, sizeof(=
u64));
> > > +               padding =3D event->header.size - compressed;
> > > +               return record__write(rec, map, bf, compressed) ||
> > > +                      record__write(rec, map, &pad, padding);
> > >         }
> > >
> > >         thread->samples++;
> > > @@ -1534,7 +1547,7 @@ static void record__adjust_affinity(struct reco=
rd *rec, struct mmap *map)
> > >
> > >  static size_t process_comp_header(void *record, size_t increment)
> > >  {
> > > -       struct perf_record_compressed *event =3D record;
> > > +       struct perf_record_compressed2 *event =3D record;
> > >         size_t size =3D sizeof(*event);
> > >
> > >         if (increment) {
> > > @@ -1542,7 +1555,7 @@ static size_t process_comp_header(void *record,=
 size_t increment)
> > >                 return increment;
> > >         }
> > >
> > > -       event->header.type =3D PERF_RECORD_COMPRESSED;
> > > +       event->header.type =3D PERF_RECORD_COMPRESSED2;
> > >         event->header.size =3D size;
> > >
> > >         return size;
> > > @@ -1552,7 +1565,7 @@ static ssize_t zstd_compress(struct perf_sessio=
n *session, struct mmap *map,
> > >                             void *dst, size_t dst_size, void *src, si=
ze_t src_size)
> > >  {
> > >         ssize_t compressed;
> > > -       size_t max_record_size =3D PERF_SAMPLE_MAX_SIZE - sizeof(stru=
ct perf_record_compressed) - 1;
> > > +       size_t max_record_size =3D PERF_SAMPLE_MAX_SIZE - sizeof(stru=
ct perf_record_compressed2) - 1;
> > >         struct zstd_data *zstd_data =3D &session->zstd_data;
> > >
> > >         if (map && map->file)
> > > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > > index c23b77f8f854..80c9ea682413 100644
> > > --- a/tools/perf/util/event.c
> > > +++ b/tools/perf/util/event.c
> > > @@ -77,6 +77,7 @@ static const char *perf_event__names[] =3D {
> > >         [PERF_RECORD_HEADER_FEATURE]            =3D "FEATURE",
> > >         [PERF_RECORD_COMPRESSED]                =3D "COMPRESSED",
> > >         [PERF_RECORD_FINISHED_INIT]             =3D "FINISHED_INIT",
> > > +       [PERF_RECORD_COMPRESSED2]               =3D "COMPRESSED2",
> > >  };
> > >
> > >  const char *perf_event__name(unsigned int id)
> > > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > > index 60fb9997ea0d..db2653322f9f 100644
> > > --- a/tools/perf/util/session.c
> > > +++ b/tools/perf/util/session.c
> > > @@ -1400,7 +1400,9 @@ static s64 perf_session__process_user_event(str=
uct perf_session *session,
> > >         int err;
> > >
> > >         perf_sample__init(&sample, /*all=3D*/true);
> > > -       if (event->header.type !=3D PERF_RECORD_COMPRESSED || perf_to=
ol__compressed_is_stub(tool))
> > > +       if ((event->header.type !=3D PERF_RECORD_COMPRESSED &&
> > > +            event->header.type !=3D PERF_RECORD_COMPRESSED2) ||
> > > +           perf_tool__compressed_is_stub(tool))
> > >                 dump_event(session->evlist, event, file_offset, &samp=
le, file_path);
> > >
> > >         /* These events are processed right away */
> > > @@ -1481,6 +1483,7 @@ static s64 perf_session__process_user_event(str=
uct perf_session *session,
> > >                 err =3D tool->feature(session, event);
> > >                 break;
> > >         case PERF_RECORD_COMPRESSED:
> > > +       case PERF_RECORD_COMPRESSED2:
> > >                 err =3D tool->compressed(session, event, file_offset,=
 file_path);
> > >                 if (err)
> > >                         dump_event(session->evlist, event, file_offse=
t, &sample, file_path);
> > > diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> > > index 3b7f390f26eb..37bd8ac63b01 100644
> > > --- a/tools/perf/util/tool.c
> > > +++ b/tools/perf/util/tool.c
> > > @@ -43,8 +43,15 @@ static int perf_session__process_compressed_event(=
struct perf_session *session,
> > >                 decomp->size =3D decomp_last_rem;
> > >         }
> > >
> > > -       src =3D (void *)event + sizeof(struct perf_record_compressed)=
;
> > > -       src_size =3D event->pack.header.size - sizeof(struct perf_rec=
ord_compressed);
> > > +       if (event->header.type =3D=3D PERF_RECORD_COMPRESSED) {
> > > +               src =3D (void *)event + sizeof(struct perf_record_com=
pressed);
> > > +               src_size =3D event->pack.header.size - sizeof(struct =
perf_record_compressed);
> > > +       } else if (event->header.type =3D=3D PERF_RECORD_COMPRESSED2)=
 {
> > > +               src =3D (void *)event + sizeof(struct perf_record_com=
pressed2);
> > > +               src_size =3D event->pack2.data_size;
> > > +       } else {
> > > +               return -1;
> > > +       }
> > >
> > >         decomp_size =3D zstd_decompress_stream(session->active_decomp=
->zstd_decomp, src, src_size,
> > >                                 &(decomp->data[decomp_last_rem]), dec=
omp_len - decomp_last_rem);
> > > --
> > > 2.48.1.658.g4767266eb4-goog
> > >
