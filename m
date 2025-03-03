Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAC20EB
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Mar 2025 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978804; cv=none; b=qODkjzWGJpBAXQVqt05lUznIap0SxzGbrCRDSbFIBD+L79CKQmGuFJ81KEFuuCajdZNPUE0i6KSMztWEi5cBV+oD1IXMH8+Ntr3u0kQh24wTGHFerJhuNj5UOXutW7dHFc3VEfA5MTuf8Y473N+hGUGxUmM2mnsZ54vmsL+BpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978804; c=relaxed/simple;
	bh=jlDXL/1BQawrkH5hO9rUk4oc5+NT8nR8HF+b1j5EE7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pl813bvhEme21DoSd2yFL6t9Zy2kbqTguQ+u1caR17xDVOcDn1VC4F/ghLSNjoGHhEuwydNvZYz6lbt+uJF8uMnXAzHCDIfOidlBfX9YibrL/aJIUMOo9z0/FA7lpo1rUAkp9rO6qRmoAidJ9L8A3uyYgOvzKZq3n3IG4dzx38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXuW7MaR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXuW7MaR"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeec07b705so641834966b.2
        for <linux-perf-users@vger.kernel.org>; Sun, 02 Mar 2025 21:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740978801; x=1741583601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE4zM1uANQ9XU2C4Jr4pHc4L2vcAZpw17viLGnHmBaY=;
        b=NXuW7MaRBYvbfQjuhOcy7lxgXmpW6JIlSrpV2VthzvuONI6ZWyl2jOi9/3WIvG0AgD
         XQrqyozSBGI5VP7GgMICLHjnoCx6LMydFWTwCo0k2gmdAU3Z3HBCmv8UGmN3tQyzxmqN
         3bmiSeWXz5ByHcBtWuoYhuveKSFXj1AOb3Y/vahMz4n6uYcFUo6tnuvgWEM8HEMZzag3
         Q1EjryWBknAubqit3oaiP+qb9BWE9Kbdddo/Eki4JpOBTZzal1JQC4FlT1SZM2bn3D60
         kZ3WfMTgMlufAm9WvJZw5kKEwuT8MNMXPhFJ+jMBwlpWAJ/PVXEOuAQSer66ha+Wb6iQ
         DA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978801; x=1741583601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE4zM1uANQ9XU2C4Jr4pHc4L2vcAZpw17viLGnHmBaY=;
        b=wYrjavfV5wMKeOaM04GYisCSOK6MxwefG3ehN5tov6FTDcFyGZoGltiu7R/dgKdNuT
         7neM/UWR6aKRr4M2m++kyoMzGbJ6/TsP8bNPaWrSa67NyanunTRYafXHwrTECXA5Bm+f
         1yQIn+u8kCDxT1Pvnm23GUDkLBi5EITYxCfqrlILWRxTQgQhYQ89xy1X4dRiuwmTqFsx
         vVVRcEsbP1C7zQRM1QQKZgiCKgI26ieYzfso8kAhTu9b9mXpmD20rlTcqtMo9hoAg8mK
         IFfJ42SdvZJY445vy6FjMb5nKJs7IUk12ApcP3TZa1DNeNhp+3AyetKp4BmZf0X1NdU6
         UPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCrmyJW42Cm62qFnU/BXCioE0ur//DFG2U0cUZ1Lwcq9Xvc5lU8Uycmhib93Hp69uQ6nlX36XePlzHlyleoyQ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6bcHMMGCMyJ84PigUTrqK6Ze5y5LNkHsP17rrShWuD62CvMeq
	5qa15g/290VhThzhP6HbqG+JCOSpRnSjJsqBhsSPvO1rQRvLZnHqIWQ3TLsxHMfX06IAF/Rm2sQ
	ym5lNce5GdusSxKYyhOtKJPF4MdTXdt4309jq
X-Gm-Gg: ASbGncuv0YqpKhLrMpJlDAnbaVX6DL6UfixqbRwvi2IfLh7z1Wihj6QOwKauDd4w4Sl
	lZH5jWdu2XWpmhL8+SByQ2e+3hJn5EvhtW4650TA//ahkTUeR95mlzbJOMspDiVovEUkvB/pgxy
	7Pbxc6+zhcQ2z8CYRtIKMSH3GC
X-Google-Smtp-Source: AGHT+IGxyH/p2EfUdWtT6tIFvJaMrURXoGWdDzWpRnR1SktIasi0Y9vr3K48hz2LzDdf3KImaoEwsr8VLquZnT/ecx0=
X-Received: by 2002:a17:907:c297:b0:abf:6f87:c732 with SMTP id
 a640c23a62f3a-abf6f87cb5dmr412804066b.20.1740978800612; Sun, 02 Mar 2025
 21:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com> <CAP-5=fUU05CJhXJuSPt61+H8jC07YuVtkCZwf9Dcawa0AGffSg@mail.gmail.com>
 <Z8AjtizjixQb3qB6@google.com> <CAJpZYjXm9BrSwTSri3qvoj0JarAgUqH6w_4PjanTsLTTNanZYQ@mail.gmail.com>
 <Z8JVqOZbFE6QwDv9@google.com>
In-Reply-To: <Z8JVqOZbFE6QwDv9@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Sun, 2 Mar 2025 21:13:09 -0800
X-Gm-Features: AQ5f1JpvhgAFPmJ4G2lTORn4EY5KOECtBL_2PLWQDMBhcOuc1B5hkvIHB7qgG9o
Message-ID: <CAJpZYjVcX6+Svwz+3CX2sjj23Xnv2G=sucxsPvcYVM6xJ8TwRw@mail.gmail.com>
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

On Fri, Feb 28, 2025 at 4:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Feb 27, 2025 at 10:21:38AM -0800, Chun-Tse Shao wrote:
> > On Thu, Feb 27, 2025 at 12:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Wed, Feb 26, 2025 at 11:12:37PM -0800, Ian Rogers wrote:
> > > > On Wed, Feb 26, 2025 at 9:37=E2=80=AFPM Chun-Tse Shao <ctshao@googl=
e.com> wrote:
> > > > >
> > > > > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which ca=
n cause
> > > > > asan runtime error:
> > > > >
> > > > >   # Build with asan
> > > > >   $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O=
0 -g -fno-omit-frame-pointer -fsanitize=3Dundefined"
> > > > >   # Test success with many asan runtime errors:
> > > > >   $ /tmp/perf/perf test "Zstd perf.data compression/decompression=
" -vv
> > > > >    83: Zstd perf.data compression/decompression:
> > > > >   ...
> > > > >   util/session.c:1959:13: runtime error: member access within mis=
aligned address 0x7f69e3f99653 for type 'union perf_event', which requires =
13 byte alignment
> > > > >   0x7f69e3f99653: note: pointer points here
> > > > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00=
 44 00 00 00 00  00 00 00 ff 07 00 00
> > > > >                 ^
> > > > >   util/session.c:2163:22: runtime error: member access within mis=
aligned address 0x7f69e3f99653 for type 'union perf_event', which requires =
8 byte alignment
> > > > >   0x7f69e3f99653: note: pointer points here
> > > > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00=
 44 00 00 00 00  00 00 00 ff 07 00 00
> > > > >                 ^
> > > > >   ...
> > > > >
> > > > > Since there is no way to align compressed data in zstd compressio=
n, this
> > > > > patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds =
a field
> > > > > `data_size` to specify the actual compressed data size. The
> > > > > `header.size` contains the total record size, including the paddi=
ng at
> > > > > the end to make it 8-byte aligned.
> > > > >
> > > > > Tested with `Zstd perf.data compression/decompression`
>
> Do you mean `perf test Zstd`?

Yes, `Zstd perf.data compression/decompression` is the full name.

>
> > > > >
> > > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > > > ---
> > > > >  tools/lib/perf/Documentation/libperf.txt      |  1 +
> > > > >  tools/lib/perf/include/perf/event.h           | 12 ++++++++++
> > > > >  .../Documentation/perf.data-file-format.txt   | 17 +++++++++++--=
-
> > > > >  tools/perf/builtin-record.c                   | 23 +++++++++++++=
++----
> > > > >  tools/perf/util/event.c                       |  1 +
> > > > >  tools/perf/util/session.c                     |  5 +++-
> > > > >  tools/perf/util/tool.c                        | 11 +++++++--
> > > > >  7 files changed, 59 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib=
/perf/Documentation/libperf.txt
> > > > > index 59aabdd3cabf..4072bc9b7670 100644
> > > > > --- a/tools/lib/perf/Documentation/libperf.txt
> > > > > +++ b/tools/lib/perf/Documentation/libperf.txt
> > > > > @@ -210,6 +210,7 @@ SYNOPSIS
> > > > >    struct perf_record_time_conv;
> > > > >    struct perf_record_header_feature;
> > > > >    struct perf_record_compressed;
> > > > > +  struct perf_record_compressed2;
> > > > >  --
> > > > >
> > > > >  DESCRIPTION
> > > > > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf=
/include/perf/event.h
> > > > > index 37bb7771d914..09b7c643ddac 100644
> > > > > --- a/tools/lib/perf/include/perf/event.h
> > > > > +++ b/tools/lib/perf/include/perf/event.h
> > > > > @@ -457,6 +457,16 @@ struct perf_record_compressed {
> > > > >         char                     data[];
> > > > >  };
> > > > >
> > > > > +/*
> > > > > + * `header.size` includes the padding we are going to add while =
writing the record.
> > > > > + * `data_size` only includes the size of `data[]` itself.
> > > > > + */
> > > > > +struct perf_record_compressed2 {
> > > > > +       struct perf_event_header header;
> > > > > +       __u64                    data_size;
> > > > > +       char                     data[];
> > > >
> > > > Just to note that data_size has to be u16 or smaller due to
> > > > header.size, so I think you can save some bytes by using a u16 or u=
8
> > > > (for the u8 you could just count the amount of padding and: data_si=
ze
> > > > =3D header.size - padding_size).
> > >
> > > I was about to suggest using the header.misc in the existing
> > > perf_record_compress.  As the padding is up to 7 byte, we could
> > >
> > >   header.type =3D PERF_RECORD_COMPRESS;
> > >   header.size =3D PERF_ALIGN(real_size, 8);
> > >   header.misc =3D header.size - real_size;
> > >
> > > Assuming the old data doesn't set the misc field and have 0.  Then it
> > > would be compatible with old data and get the real size in new data.
> >
> > I was thinking the same way and realized the uninitialized `misc`
> > problem while I was testing this implementation.
> > Also I think it would be good to have a new type, at least if
> > something wrong happens unexpectedly, we know that it is caused by old
> > or new compressed event.
>
> Ok, makes sense.
>
> >
> > >
> > > But unfortunately, I found process_comp_header() didn't reset the mis=
c
> > > field so it may have garbage in old data.  Then the above won't work.=
 :(
> > >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > +};
> > > > > +
> > > > >  enum perf_user_event_type { /* above any possible kernel type */
> > > > >         PERF_RECORD_USER_TYPE_START             =3D 64,
> > > > >         PERF_RECORD_HEADER_ATTR                 =3D 64,
> > > > > @@ -478,6 +488,7 @@ enum perf_user_event_type { /* above any poss=
ible kernel type */
> > > > >         PERF_RECORD_HEADER_FEATURE              =3D 80,
> > > > >         PERF_RECORD_COMPRESSED                  =3D 81,
> > > > >         PERF_RECORD_FINISHED_INIT               =3D 82,
> > > > > +       PERF_RECORD_COMPRESSED2                 =3D 83,
> > > > >         PERF_RECORD_HEADER_MAX
> > > > >  };
> > > > >
> > > > > @@ -518,6 +529,7 @@ union perf_event {
> > > > >         struct perf_record_time_conv            time_conv;
> > > > >         struct perf_record_header_feature       feat;
> > > > >         struct perf_record_compressed           pack;
> > > > > +       struct perf_record_compressed2          pack2;
> > > > >  };
> > > > >
> > > > >  #endif /* __LIBPERF_EVENT_H */
> > > > > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b=
/tools/perf/Documentation/perf.data-file-format.txt
> > > > > index 010a4edcd384..f5faceb0e248 100644
> > > > > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > > > > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > > > > @@ -604,6 +604,10 @@ contain information that otherwise would be =
in perf.data file's header.
> > > > >
> > > > >         PERF_RECORD_COMPRESSED                  =3D 81,
> > > > >
> > > > > +The header is followed by compressed data frame that can be deco=
mpressed
> > > > > +into array of perf trace records. The size of the entire compres=
sed event
> > > > > +record including the header is limited by the max value of heade=
r.size.
>
> Maybe we can say it's deprecated now.  New files should use COMPRESSED2
> to guarantee 8-byte alignment.

Thank you, I will send a new patchset with this comment.

>
> Thanks,
> Namhyung
>
> > > > > +
> > > > >  struct compressed_event {
> > > > >         struct perf_event_header        header;
> > > > >         char                            data[];
> > > > > @@ -618,10 +622,17 @@ This is used, for instance, to 'perf inject=
' events after init and before
> > > > >  regular events, those emitted by the kernel, to support combinin=
g guest and
> > > > >  host records.
> > > > >
> > > > > +       PERF_RECORD_COMPRESSED2                 =3D 83,
> > > > >
> > > > > -The header is followed by compressed data frame that can be deco=
mpressed
> > > > > -into array of perf trace records. The size of the entire compres=
sed event
> > > > > -record including the header is limited by the max value of heade=
r.size.
> > > > > +8-byte aligned version of `PERF_RECORD_COMPRESSED`. `header.size=
` indicates the
> > > > > +total record size, including padding for 8-byte alignment, and `=
data_size`
> > > > > +specifies the actual size of the compressed data.
> > > > > +
> > > > > +struct perf_record_compressed2 {
> > > > > +       struct perf_event_header        header;
> > > > > +       __u64                           data_size;
> > > > > +       char                            data[];
> > > > > +};
> > > > >
> > > > >  Event types
> > > > >
> > > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-rec=
ord.c
> > > > > index 9af3f21fd015..d07ad670daa7 100644
> > > > > --- a/tools/perf/builtin-record.c
> > > > > +++ b/tools/perf/builtin-record.c
> > > > > @@ -648,14 +648,27 @@ static int record__pushfn(struct mmap *map,=
 void *to, void *bf, size_t size)
> > > > >         struct record *rec =3D to;
> > > > >
> > > > >         if (record__comp_enabled(rec)) {
> > > > > +               struct perf_record_compressed2 *event =3D map->da=
ta;
> > > > > +               size_t padding =3D 0;
> > > > > +               u8 pad[8] =3D {0};
> > > > >                 ssize_t compressed =3D zstd_compress(rec->session=
, map, map->data,
> > > > >                                                    mmap__mmap_len=
(map), bf, size);
> > > > >
> > > > >                 if (compressed < 0)
> > > > >                         return (int)compressed;
> > > > >
> > > > > -               size =3D compressed;
> > > > > -               bf   =3D map->data;
> > > > > +               bf =3D event;
> > > > > +               thread->samples++;
> > > > > +
> > > > > +               /*
> > > > > +                * The record from `zstd_compress` is not 8 bytes=
 aligned, which would cause asan
> > > > > +                * error. We make it aligned here.
> > > > > +                */
> > > > > +               event->data_size =3D compressed - sizeof(struct p=
erf_record_compressed2);
> > > > > +               event->header.size =3D PERF_ALIGN(compressed, siz=
eof(u64));
> > > > > +               padding =3D event->header.size - compressed;
> > > > > +               return record__write(rec, map, bf, compressed) ||
> > > > > +                      record__write(rec, map, &pad, padding);
> > > > >         }
> > > > >
> > > > >         thread->samples++;
> > > > > @@ -1534,7 +1547,7 @@ static void record__adjust_affinity(struct =
record *rec, struct mmap *map)
> > > > >
> > > > >  static size_t process_comp_header(void *record, size_t increment=
)
> > > > >  {
> > > > > -       struct perf_record_compressed *event =3D record;
> > > > > +       struct perf_record_compressed2 *event =3D record;
> > > > >         size_t size =3D sizeof(*event);
> > > > >
> > > > >         if (increment) {
> > > > > @@ -1542,7 +1555,7 @@ static size_t process_comp_header(void *rec=
ord, size_t increment)
> > > > >                 return increment;
> > > > >         }
> > > > >
> > > > > -       event->header.type =3D PERF_RECORD_COMPRESSED;
> > > > > +       event->header.type =3D PERF_RECORD_COMPRESSED2;
> > > > >         event->header.size =3D size;
> > > > >
> > > > >         return size;
> > > > > @@ -1552,7 +1565,7 @@ static ssize_t zstd_compress(struct perf_se=
ssion *session, struct mmap *map,
> > > > >                             void *dst, size_t dst_size, void *src=
, size_t src_size)
> > > > >  {
> > > > >         ssize_t compressed;
> > > > > -       size_t max_record_size =3D PERF_SAMPLE_MAX_SIZE - sizeof(=
struct perf_record_compressed) - 1;
> > > > > +       size_t max_record_size =3D PERF_SAMPLE_MAX_SIZE - sizeof(=
struct perf_record_compressed2) - 1;
> > > > >         struct zstd_data *zstd_data =3D &session->zstd_data;
> > > > >
> > > > >         if (map && map->file)
> > > > > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > > > > index c23b77f8f854..80c9ea682413 100644
> > > > > --- a/tools/perf/util/event.c
> > > > > +++ b/tools/perf/util/event.c
> > > > > @@ -77,6 +77,7 @@ static const char *perf_event__names[] =3D {
> > > > >         [PERF_RECORD_HEADER_FEATURE]            =3D "FEATURE",
> > > > >         [PERF_RECORD_COMPRESSED]                =3D "COMPRESSED",
> > > > >         [PERF_RECORD_FINISHED_INIT]             =3D "FINISHED_INI=
T",
> > > > > +       [PERF_RECORD_COMPRESSED2]               =3D "COMPRESSED2"=
,
> > > > >  };
> > > > >
> > > > >  const char *perf_event__name(unsigned int id)
> > > > > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.=
c
> > > > > index 60fb9997ea0d..db2653322f9f 100644
> > > > > --- a/tools/perf/util/session.c
> > > > > +++ b/tools/perf/util/session.c
> > > > > @@ -1400,7 +1400,9 @@ static s64 perf_session__process_user_event=
(struct perf_session *session,
> > > > >         int err;
> > > > >
> > > > >         perf_sample__init(&sample, /*all=3D*/true);
> > > > > -       if (event->header.type !=3D PERF_RECORD_COMPRESSED || per=
f_tool__compressed_is_stub(tool))
> > > > > +       if ((event->header.type !=3D PERF_RECORD_COMPRESSED &&
> > > > > +            event->header.type !=3D PERF_RECORD_COMPRESSED2) ||
> > > > > +           perf_tool__compressed_is_stub(tool))
> > > > >                 dump_event(session->evlist, event, file_offset, &=
sample, file_path);
> > > > >
> > > > >         /* These events are processed right away */
> > > > > @@ -1481,6 +1483,7 @@ static s64 perf_session__process_user_event=
(struct perf_session *session,
> > > > >                 err =3D tool->feature(session, event);
> > > > >                 break;
> > > > >         case PERF_RECORD_COMPRESSED:
> > > > > +       case PERF_RECORD_COMPRESSED2:
> > > > >                 err =3D tool->compressed(session, event, file_off=
set, file_path);
> > > > >                 if (err)
> > > > >                         dump_event(session->evlist, event, file_o=
ffset, &sample, file_path);
> > > > > diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> > > > > index 3b7f390f26eb..37bd8ac63b01 100644
> > > > > --- a/tools/perf/util/tool.c
> > > > > +++ b/tools/perf/util/tool.c
> > > > > @@ -43,8 +43,15 @@ static int perf_session__process_compressed_ev=
ent(struct perf_session *session,
> > > > >                 decomp->size =3D decomp_last_rem;
> > > > >         }
> > > > >
> > > > > -       src =3D (void *)event + sizeof(struct perf_record_compres=
sed);
> > > > > -       src_size =3D event->pack.header.size - sizeof(struct perf=
_record_compressed);
> > > > > +       if (event->header.type =3D=3D PERF_RECORD_COMPRESSED) {
> > > > > +               src =3D (void *)event + sizeof(struct perf_record=
_compressed);
> > > > > +               src_size =3D event->pack.header.size - sizeof(str=
uct perf_record_compressed);
> > > > > +       } else if (event->header.type =3D=3D PERF_RECORD_COMPRESS=
ED2) {
> > > > > +               src =3D (void *)event + sizeof(struct perf_record=
_compressed2);
> > > > > +               src_size =3D event->pack2.data_size;
> > > > > +       } else {
> > > > > +               return -1;
> > > > > +       }
> > > > >
> > > > >         decomp_size =3D zstd_decompress_stream(session->active_de=
comp->zstd_decomp, src, src_size,
> > > > >                                 &(decomp->data[decomp_last_rem]),=
 decomp_len - decomp_last_rem);
> > > > > --
> > > > > 2.48.1.658.g4767266eb4-goog
> > > > >
