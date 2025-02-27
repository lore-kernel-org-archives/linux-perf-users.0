Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986613A3F2;
	Thu, 27 Feb 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645305; cv=none; b=rg/iRMHSFvIVpd9uBkKXhS1nJ/OBdyD48Qrs/gy4F7FJEjPn1lYKhskbTGCQ59kH99Lwlv3cBq+86cq2ysySSe7Rr3l9komcyAo6gNnJBALJ7kZpAF8ORlMji4PwFgGdg1aZa0NjmXsBvjBDRPyVIlx3zHRyxGwrcyyto8Cl1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645305; c=relaxed/simple;
	bh=UcyULhq7yqITVDHZoLeF5il1UlAsbJjL5UeznDMQ6oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEohGZjw6N2YNMQIbnDrIVG08YK0/BoxvaIlBukPazBZSV3F1/NJyeDJHb5aEK/F4WR4K4L0991m0xA9CSvt8MqNXkBtF2F/swqQnsIadGrlN1mRgE39qqOn5dS5dFHIMzUQgxTXZSayl0DqcduiG+XBAoff89toaFtoKf6qQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyACTFLA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyACTFLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37074C4CEDD;
	Thu, 27 Feb 2025 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740645304;
	bh=UcyULhq7yqITVDHZoLeF5il1UlAsbJjL5UeznDMQ6oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyACTFLAdeZEPR2t2Zd3MiGPtAqpsKqWNG5D1M3J5X71sFMmGEbbUdQELCQuwxZY4
	 PuEFSON6gxiPCq4tvxexE5jTS5Pi0zq7VH/UqeVSxL8iYcstmnlG+rCmYkfrUFlspi
	 PLPeOrYcOCIl4YeLMXoLWxT3o1xs9gtjwfGW0yOIvTckzDLB4Ydf6E/oDJEMPpHtQj
	 V8kziX3M2LieNah/dQ1JehxWSfISuuL7Vly065bTvAxPmJEpEMXnQFbZJjlCa32OOz
	 o0+jkw8+u7N6yobyXOQxDo9UvgEh7tOV8mKb65JJmxXqtJgmdaa/YJ11J1RKKBErDm
	 M/Vyv8v5czkzw==
Date: Thu, 27 Feb 2025 00:35:02 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, james.clark@linaro.org,
	christophe.leroy@csgroup.eu, ben.gainey@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z8AjtizjixQb3qB6@google.com>
References: <20250227053738.788153-1-ctshao@google.com>
 <CAP-5=fUU05CJhXJuSPt61+H8jC07YuVtkCZwf9Dcawa0AGffSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUU05CJhXJuSPt61+H8jC07YuVtkCZwf9Dcawa0AGffSg@mail.gmail.com>

On Wed, Feb 26, 2025 at 11:12:37PM -0800, Ian Rogers wrote:
> On Wed, Feb 26, 2025 at 9:37 PM Chun-Tse Shao <ctshao@google.com> wrote:
> >
> > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> > asan runtime error:
> >
> >   # Build with asan
> >   $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
> >   # Test success with many asan runtime errors:
> >   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
> >    83: Zstd perf.data compression/decompression:
> >   ...
> >   util/session.c:1959:13: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 13 byte alignment
> >   0x7f69e3f99653: note: pointer points here
> >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> >                 ^
> >   util/session.c:2163:22: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 byte alignment
> >   0x7f69e3f99653: note: pointer points here
> >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> >                 ^
> >   ...
> >
> > Since there is no way to align compressed data in zstd compression, this
> > patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a field
> > `data_size` to specify the actual compressed data size. The
> > `header.size` contains the total record size, including the padding at
> > the end to make it 8-byte aligned.
> >
> > Tested with `Zstd perf.data compression/decompression`
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/lib/perf/Documentation/libperf.txt      |  1 +
> >  tools/lib/perf/include/perf/event.h           | 12 ++++++++++
> >  .../Documentation/perf.data-file-format.txt   | 17 +++++++++++---
> >  tools/perf/builtin-record.c                   | 23 +++++++++++++++----
> >  tools/perf/util/event.c                       |  1 +
> >  tools/perf/util/session.c                     |  5 +++-
> >  tools/perf/util/tool.c                        | 11 +++++++--
> >  7 files changed, 59 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > index 59aabdd3cabf..4072bc9b7670 100644
> > --- a/tools/lib/perf/Documentation/libperf.txt
> > +++ b/tools/lib/perf/Documentation/libperf.txt
> > @@ -210,6 +210,7 @@ SYNOPSIS
> >    struct perf_record_time_conv;
> >    struct perf_record_header_feature;
> >    struct perf_record_compressed;
> > +  struct perf_record_compressed2;
> >  --
> >
> >  DESCRIPTION
> > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> > index 37bb7771d914..09b7c643ddac 100644
> > --- a/tools/lib/perf/include/perf/event.h
> > +++ b/tools/lib/perf/include/perf/event.h
> > @@ -457,6 +457,16 @@ struct perf_record_compressed {
> >         char                     data[];
> >  };
> >
> > +/*
> > + * `header.size` includes the padding we are going to add while writing the record.
> > + * `data_size` only includes the size of `data[]` itself.
> > + */
> > +struct perf_record_compressed2 {
> > +       struct perf_event_header header;
> > +       __u64                    data_size;
> > +       char                     data[];
> 
> Just to note that data_size has to be u16 or smaller due to
> header.size, so I think you can save some bytes by using a u16 or u8
> (for the u8 you could just count the amount of padding and: data_size
> = header.size - padding_size).

I was about to suggest using the header.misc in the existing
perf_record_compress.  As the padding is up to 7 byte, we could

  header.type = PERF_RECORD_COMPRESS;
  header.size = PERF_ALIGN(real_size, 8);
  header.misc = header.size - real_size;

Assuming the old data doesn't set the misc field and have 0.  Then it
would be compatible with old data and get the real size in new data.

But unfortunately, I found process_comp_header() didn't reset the misc
field so it may have garbage in old data.  Then the above won't work. :(

Thanks,
Namhyung

> 
> Thanks,
> Ian
> 
> > +};
> > +
> >  enum perf_user_event_type { /* above any possible kernel type */
> >         PERF_RECORD_USER_TYPE_START             = 64,
> >         PERF_RECORD_HEADER_ATTR                 = 64,
> > @@ -478,6 +488,7 @@ enum perf_user_event_type { /* above any possible kernel type */
> >         PERF_RECORD_HEADER_FEATURE              = 80,
> >         PERF_RECORD_COMPRESSED                  = 81,
> >         PERF_RECORD_FINISHED_INIT               = 82,
> > +       PERF_RECORD_COMPRESSED2                 = 83,
> >         PERF_RECORD_HEADER_MAX
> >  };
> >
> > @@ -518,6 +529,7 @@ union perf_event {
> >         struct perf_record_time_conv            time_conv;
> >         struct perf_record_header_feature       feat;
> >         struct perf_record_compressed           pack;
> > +       struct perf_record_compressed2          pack2;
> >  };
> >
> >  #endif /* __LIBPERF_EVENT_H */
> > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> > index 010a4edcd384..f5faceb0e248 100644
> > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > @@ -604,6 +604,10 @@ contain information that otherwise would be in perf.data file's header.
> >
> >         PERF_RECORD_COMPRESSED                  = 81,
> >
> > +The header is followed by compressed data frame that can be decompressed
> > +into array of perf trace records. The size of the entire compressed event
> > +record including the header is limited by the max value of header.size.
> > +
> >  struct compressed_event {
> >         struct perf_event_header        header;
> >         char                            data[];
> > @@ -618,10 +622,17 @@ This is used, for instance, to 'perf inject' events after init and before
> >  regular events, those emitted by the kernel, to support combining guest and
> >  host records.
> >
> > +       PERF_RECORD_COMPRESSED2                 = 83,
> >
> > -The header is followed by compressed data frame that can be decompressed
> > -into array of perf trace records. The size of the entire compressed event
> > -record including the header is limited by the max value of header.size.
> > +8-byte aligned version of `PERF_RECORD_COMPRESSED`. `header.size` indicates the
> > +total record size, including padding for 8-byte alignment, and `data_size`
> > +specifies the actual size of the compressed data.
> > +
> > +struct perf_record_compressed2 {
> > +       struct perf_event_header        header;
> > +       __u64                           data_size;
> > +       char                            data[];
> > +};
> >
> >  Event types
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 9af3f21fd015..d07ad670daa7 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -648,14 +648,27 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
> >         struct record *rec = to;
> >
> >         if (record__comp_enabled(rec)) {
> > +               struct perf_record_compressed2 *event = map->data;
> > +               size_t padding = 0;
> > +               u8 pad[8] = {0};
> >                 ssize_t compressed = zstd_compress(rec->session, map, map->data,
> >                                                    mmap__mmap_len(map), bf, size);
> >
> >                 if (compressed < 0)
> >                         return (int)compressed;
> >
> > -               size = compressed;
> > -               bf   = map->data;
> > +               bf = event;
> > +               thread->samples++;
> > +
> > +               /*
> > +                * The record from `zstd_compress` is not 8 bytes aligned, which would cause asan
> > +                * error. We make it aligned here.
> > +                */
> > +               event->data_size = compressed - sizeof(struct perf_record_compressed2);
> > +               event->header.size = PERF_ALIGN(compressed, sizeof(u64));
> > +               padding = event->header.size - compressed;
> > +               return record__write(rec, map, bf, compressed) ||
> > +                      record__write(rec, map, &pad, padding);
> >         }
> >
> >         thread->samples++;
> > @@ -1534,7 +1547,7 @@ static void record__adjust_affinity(struct record *rec, struct mmap *map)
> >
> >  static size_t process_comp_header(void *record, size_t increment)
> >  {
> > -       struct perf_record_compressed *event = record;
> > +       struct perf_record_compressed2 *event = record;
> >         size_t size = sizeof(*event);
> >
> >         if (increment) {
> > @@ -1542,7 +1555,7 @@ static size_t process_comp_header(void *record, size_t increment)
> >                 return increment;
> >         }
> >
> > -       event->header.type = PERF_RECORD_COMPRESSED;
> > +       event->header.type = PERF_RECORD_COMPRESSED2;
> >         event->header.size = size;
> >
> >         return size;
> > @@ -1552,7 +1565,7 @@ static ssize_t zstd_compress(struct perf_session *session, struct mmap *map,
> >                             void *dst, size_t dst_size, void *src, size_t src_size)
> >  {
> >         ssize_t compressed;
> > -       size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
> > +       size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed2) - 1;
> >         struct zstd_data *zstd_data = &session->zstd_data;
> >
> >         if (map && map->file)
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index c23b77f8f854..80c9ea682413 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -77,6 +77,7 @@ static const char *perf_event__names[] = {
> >         [PERF_RECORD_HEADER_FEATURE]            = "FEATURE",
> >         [PERF_RECORD_COMPRESSED]                = "COMPRESSED",
> >         [PERF_RECORD_FINISHED_INIT]             = "FINISHED_INIT",
> > +       [PERF_RECORD_COMPRESSED2]               = "COMPRESSED2",
> >  };
> >
> >  const char *perf_event__name(unsigned int id)
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 60fb9997ea0d..db2653322f9f 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1400,7 +1400,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
> >         int err;
> >
> >         perf_sample__init(&sample, /*all=*/true);
> > -       if (event->header.type != PERF_RECORD_COMPRESSED || perf_tool__compressed_is_stub(tool))
> > +       if ((event->header.type != PERF_RECORD_COMPRESSED &&
> > +            event->header.type != PERF_RECORD_COMPRESSED2) ||
> > +           perf_tool__compressed_is_stub(tool))
> >                 dump_event(session->evlist, event, file_offset, &sample, file_path);
> >
> >         /* These events are processed right away */
> > @@ -1481,6 +1483,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
> >                 err = tool->feature(session, event);
> >                 break;
> >         case PERF_RECORD_COMPRESSED:
> > +       case PERF_RECORD_COMPRESSED2:
> >                 err = tool->compressed(session, event, file_offset, file_path);
> >                 if (err)
> >                         dump_event(session->evlist, event, file_offset, &sample, file_path);
> > diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> > index 3b7f390f26eb..37bd8ac63b01 100644
> > --- a/tools/perf/util/tool.c
> > +++ b/tools/perf/util/tool.c
> > @@ -43,8 +43,15 @@ static int perf_session__process_compressed_event(struct perf_session *session,
> >                 decomp->size = decomp_last_rem;
> >         }
> >
> > -       src = (void *)event + sizeof(struct perf_record_compressed);
> > -       src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
> > +       if (event->header.type == PERF_RECORD_COMPRESSED) {
> > +               src = (void *)event + sizeof(struct perf_record_compressed);
> > +               src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
> > +       } else if (event->header.type == PERF_RECORD_COMPRESSED2) {
> > +               src = (void *)event + sizeof(struct perf_record_compressed2);
> > +               src_size = event->pack2.data_size;
> > +       } else {
> > +               return -1;
> > +       }
> >
> >         decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
> >                                 &(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
> > --
> > 2.48.1.658.g4767266eb4-goog
> >
