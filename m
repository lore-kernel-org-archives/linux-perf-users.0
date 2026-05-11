Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABC4C9549
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526116; cv=pass; b=ccXvK4aYk4z0ZH+u17KFMal5BfXNdYr3GL2E7Vjq2tIhWFPrQbpEV69qjTrQEzSrXtcFeJKnMiXdtQKZ1MKoXEvC+MXoK+t2oSuGkmOEA1niUHD6DIB2tmy0efCxb3bRMe3pjVZ9ZD+HH65RkYOAcUixTS/w2e44Ysqd75lK8eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526116; c=relaxed/simple;
	bh=4i5DjxxvA9Vr+ZZwT1kklAl7IFDfzRJVv9doKQh7Cgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLo2a2F3bgplKOZx0VXBlmlP8QDJfnXp07D3I6RgIaNQoNuqh6ByQ+V7vTPnFovtJktk5pQJgxuEsVtmqQ6mO5gzFvGqP+GH7D4r6AqRpn67JW2b0T5NrzGwWyneBQzJkhAp1lTIUwThzP142vKvXfJBYSzqCoQvMNL8Ou2RGUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1t37Os8; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1t37Os8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso13015ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 12:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778526113; cv=none;
        d=google.com; s=arc-20240605;
        b=bO+z8A3B3rhC5336M8nH2rvwmSYT1WGVj2AzsqalFRtKI2ZsyxBJq3ATmh4xgXSrMo
         z1AENiGeJYqfVtKxeqYxeR7NmpFmkMyes34xX4uW70zzm8pxs8NvSnqn6aOR3CE0NMcN
         Bxwp5ZigaL+WbvMlOWhZf2A7tIgvF2vSdQGnLAGNZNoyIlWFlwvDtlpJOamuFpFMXXbt
         exnVUuMy9TQbd/zcD6/aNHUVio23XZCmVtjx1U5bX5dCaQKZmo+eG5UEFM+t+OPt1vqJ
         MUSJTUhYX/UMWp6/2r8g1gsj6Wrla/zlflRThJB99NjG7tdmiBIf9ZDi6ySKFBb+mCco
         oA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAUCERFRJQbrrjJg8R7ZKKRRZ2G9Qt+fFPInl7iUIq4=;
        fh=3BDwUrqsVuFkKMXRjLtWq8B7ORY1y+IhlITENPC+KSk=;
        b=BY4PE2dCwY8nYmcWQ+dTsrZBjTsKzXJtTjQ24xp16aHr0pMpH4H2gqhFiyN9V07AbS
         TqPxy/tzSiqM8ZTXX3znPYvVNW2ovwlKBs73ET1p1Lq9Qs4awW3BG8LKU14VoAqKD0eO
         jCvZ1CIeUj+Ox1dQWLzZ0JCgGTY2AMTB7S0viCm48JDOxRHkfu0uzGZmKbSoOkpRDplL
         Ru+b5UCTei6YT/UykiwLyLaw8iyJ/adaeXlDCgmGDLOYBaEz1z9hZfFv90yN2zs57P7i
         J7xrZVTBMgqfAoTtqjmr7vT9ZyFSa+82C+EAS+YYcbs7hl/D6CTk5sUvlC4jvmxUpHgh
         QWhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778526113; x=1779130913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAUCERFRJQbrrjJg8R7ZKKRRZ2G9Qt+fFPInl7iUIq4=;
        b=S1t37Os8SC9euSYo1c8wFrOl1PxY+S2SRwHAXLOCfTO3CzX0yVVh8MA62Vvo6c5ar4
         jDUZceuKvRtjM3G2Ra4OjWipzLVxEXpB6b6QHu+atzPAP57vJCXXRy6zs+KzVrChPnMp
         ErW4uKjxEOhzaBn7Fmx51/+XMrvnO/oE3lQQJ7L43zSBtIUgurx5cYNbsEivW+9odyvY
         sabhAK80r5F124WH2hspNB49YySmP1kwAH734kHrzjpQjH6HspbMFcRF7jA29OAx0HH5
         8Hi47TalQX0U10NN+nupzrrL+lOmxUIGy/G15wqea0MCbeRF+CpMGmPtEqTB1d+EXR3J
         /XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778526113; x=1779130913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAUCERFRJQbrrjJg8R7ZKKRRZ2G9Qt+fFPInl7iUIq4=;
        b=oHAf/w76CPMChteJJJqpmQ2KsNRVp/vc0cMx6yB8hu3Vr9/Uohajd3ewsX7tm4a9TQ
         xfittLslHATFouByOqw6yJWrwUECK2WUaJ1+vXSRv/LMjNDLY5k7kvGTCgoGqfQX/Kz7
         FjnoUYgMHfoe7UDl354+1I8aK9ZjNzZRZVY4Yo/xOYZQzvot5ErHM8qbJtgkl0rIMNup
         XTO5NY9V7Qpy89JyXMwPsre3IzdEv2fxqt1/Hrbpds82IhM+PLK2ZapXt4WI8BGPlLH5
         6iZ2lzdMXpvW+vgSN1XeiwuA4gBF6eQXw/of35yy4Lko7LyaCcSe9RZKs/yWoSNYw9CP
         Xoeg==
X-Forwarded-Encrypted: i=1; AFNElJ+064+hVrLnfhOJ4T3O8EJNDz6saEoYwTKqmSEBcBNibKrquMDyyWL8iV+fdOTdY8cElHHQaIUNhixvbf+TUfam@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mEkmhw3WXi5m9qbarhLQ8XxS9Z9vhMSUlem7k2Togci6wzXd
	KYP0SVf/EixhLJyF1qzO7zn2U4chby6QdeaiWoPq/pRMV1gIRKAhNEV11KwgN9RU12k97IQ0rzt
	Z7rXudyp1drxkQMZa6ZilfqZYf+FaTqoGphoFuP5W
X-Gm-Gg: Acq92OGVo2hbL1cHIglS3CeHOgjj6cenH0C26LaRjp7y/YjVYs/zTVyKQNWSGSKQtsl
	QxEY/lqoH4tTdgJpQFWoDBn/AxN4W3oOgxdxCZn+qGQSkzpc2eSdGf6PTZ2pzKpmEw813d5Wv2I
	hgAZylOv/KbCJfG9MpEV74PLos3hvv6Vreu7EvZDEVX/MJe0w6i1mnQtuM9ysfoQi0N5+avB3ef
	7AUPPQUmsngFT5BqPw2wxJX2E0QA9lAPTUBaGWGSUEHuaNublGZf5KPtphL1tOo/Oil4h/FmzcC
	PXI9oym2GzLNP5b10gxkTdxax4nNFTSmJTsxgsuMhCrAI80WdNsU8Woyfoo=
X-Received: by 2002:a17:903:3890:b0:2ba:4749:c9a2 with SMTP id
 d9443c01a7336-2bcfe66d032mr931545ad.2.1778526112621; Mon, 11 May 2026
 12:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510033424.255812-1-acme@kernel.org> <20260510033424.255812-2-acme@kernel.org>
In-Reply-To: <20260510033424.255812-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 May 2026 12:01:41 -0700
X-Gm-Features: AVHnY4KmCsWsP4tZ4nzLdRuM9PwJ6zB4j7rK5mdszDm-HLHMDtXu6amZ08dLT38
Message-ID: <CAP-5=fVEYO4QHeeKjvzqVU8f5U8Pp0kE4HU2dsMqep5pvjR4iw@mail.gmail.com>
Subject: Re: [PATCH 01/28] perf session: Add minimum event size validation table
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, sashiko-bot@kernel.org, 
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 8:34=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Add a per-type minimum size table (perf_event__min_size[]) and
> enforce it before swap and processing, so that both cross-endian
> and native-endian paths are protected from accessing fields past
> the event boundary.
>
> The table uses offsetof() for types with trailing variable-length
> fields (filenames, strings, msg arrays) and sizeof() for
> fixed-size types.  Zero entries mean no minimum beyond the 8-byte
> header already enforced by the reader.
>
> Undersized events are skipped with a warning in process_event
> and rejected in peek_event =E2=80=94 both checked before the swap
> handler runs, preventing OOB access on crafted event fields.
>
> Also guard event_swap() against crafted event types >=3D
> PERF_RECORD_HEADER_MAX to prevent OOB reads on the
> perf_event__swap_ops[] array.
>
> Reported-by: sashiko-bot@kernel.org # Running on a local machine
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/session.c | 121 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index fe0de2a0277f09f9..aae0651fb6f025a1 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1759,10 +1759,88 @@ int perf_session__deliver_synth_attr_event(struct=
 perf_session *session,
>         return perf_session__deliver_synth_event(session, &ev.ev, NULL);
>  }
>
> +/*
> + * Minimum event sizes indexed by type.  Checked before swap and
> + * processing so that both cross-endian and native-endian paths
> + * are protected from accessing fields past the event boundary.
> + * Zero means no minimum beyond the 8-byte header (already
> + * enforced by the reader).
> + */
> +static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] =3D {
> +       /*
> +        * offsetof() for types with a trailing variable-length string
> +        * (filename, comm, path, name, msg): sizeof() includes a
> +        * PATH_MAX or fixed-size array, but valid events only need
> +        * the fixed fields.  Null-termination is checked separately.
> +        *
> +        * PERF_RECORD_SAMPLE is omitted: all64_swap is bounded by
> +        * header.size, and the internal layout varies by sample_type
> +        * so a fixed minimum is not meaningful.
> +        */
> +       [PERF_RECORD_MMAP]                =3D offsetof(struct perf_record=
_mmap, filename),
> +       [PERF_RECORD_LOST]                =3D sizeof(struct perf_record_l=
ost),
> +       [PERF_RECORD_COMM]                =3D offsetof(struct perf_record=
_comm, comm),
> +       [PERF_RECORD_EXIT]                =3D sizeof(struct perf_record_f=
ork),
> +       [PERF_RECORD_THROTTLE]            =3D sizeof(struct perf_record_t=
hrottle),
> +       [PERF_RECORD_UNTHROTTLE]          =3D sizeof(struct perf_record_t=
hrottle),
> +       [PERF_RECORD_FORK]                =3D sizeof(struct perf_record_f=
ork),
> +       /*
> +        * The kernel dynamically sizes PERF_RECORD_READ based on
> +        * attr.read_format =E2=80=94 the minimum has just pid + tid + va=
lue.
> +        */
> +       [PERF_RECORD_READ]                =3D offsetof(struct perf_record=
_read, time_enabled),
> +       [PERF_RECORD_MMAP2]               =3D offsetof(struct perf_record=
_mmap2, filename),

Should this be +1 as the '\0' given the path is a string? Arguably for
just a mmap2 with build ID we don't need the path.

> +       [PERF_RECORD_LOST_SAMPLES]        =3D sizeof(struct perf_record_l=
ost_samples),
> +       [PERF_RECORD_AUX]                 =3D sizeof(struct perf_record_a=
ux),
> +       [PERF_RECORD_ITRACE_START]        =3D sizeof(struct perf_record_i=
trace_start),
> +       [PERF_RECORD_SWITCH]              =3D sizeof(struct perf_event_he=
ader),
> +       [PERF_RECORD_SWITCH_CPU_WIDE]     =3D sizeof(struct perf_record_s=
witch),
> +       [PERF_RECORD_NAMESPACES]          =3D sizeof(struct perf_record_n=
amespaces),
> +       [PERF_RECORD_CGROUP]              =3D offsetof(struct perf_record=
_cgroup, path),
> +       [PERF_RECORD_TEXT_POKE]           =3D sizeof(struct perf_record_t=
ext_poke_event),
> +       [PERF_RECORD_KSYMBOL]             =3D offsetof(struct perf_record=
_ksymbol, name),
> +       [PERF_RECORD_BPF_EVENT]           =3D sizeof(struct perf_record_b=
pf_event),
> +       [PERF_RECORD_HEADER_ATTR]         =3D sizeof(struct perf_event_he=
ader) + PERF_ATTR_SIZE_VER0,
> +       [PERF_RECORD_HEADER_EVENT_TYPE]   =3D sizeof(struct perf_record_h=
eader_event_type),
> +       [PERF_RECORD_HEADER_TRACING_DATA] =3D sizeof(struct perf_record_h=
eader_tracing_data),
> +       [PERF_RECORD_AUX_OUTPUT_HW_ID]    =3D sizeof(struct perf_record_a=
ux_output_hw_id),
> +       [PERF_RECORD_AUXTRACE_INFO]       =3D sizeof(struct perf_record_a=
uxtrace_info),
> +       [PERF_RECORD_AUXTRACE]            =3D sizeof(struct perf_record_a=
uxtrace),
> +       [PERF_RECORD_AUXTRACE_ERROR]      =3D offsetof(struct perf_record=
_auxtrace_error, msg),
> +       [PERF_RECORD_THREAD_MAP]          =3D sizeof(struct perf_record_t=
hread_map),
> +       /* Smallest valid variant is RANGE_CPUS: header(8) + type(2) + ra=
nge(6) */
> +       [PERF_RECORD_CPU_MAP]             =3D sizeof(struct perf_event_he=
ader) +
> +                                           sizeof(__u16) +
> +                                           sizeof(struct perf_record_ran=
ge_cpu_map),
> +       [PERF_RECORD_STAT_CONFIG]         =3D sizeof(struct perf_record_s=
tat_config),
> +       [PERF_RECORD_STAT]                =3D sizeof(struct perf_record_s=
tat),
> +       [PERF_RECORD_STAT_ROUND]          =3D sizeof(struct perf_record_s=
tat_round),
> +       /* Union inflates sizeof; use fixed header fields as minimum */
> +       [PERF_RECORD_EVENT_UPDATE]        =3D offsetof(struct perf_record=
_event_update, scale),
> +       [PERF_RECORD_TIME_CONV]           =3D offsetof(struct perf_record=
_time_conv, time_cycles),
> +       [PERF_RECORD_ID_INDEX]            =3D sizeof(struct perf_record_i=
d_index),
> +       [PERF_RECORD_HEADER_BUILD_ID]     =3D sizeof(struct perf_record_h=
eader_build_id),
> +       [PERF_RECORD_HEADER_FEATURE]      =3D sizeof(struct perf_record_h=
eader_feature),
> +       [PERF_RECORD_COMPRESSED2]         =3D sizeof(struct perf_record_c=
ompressed2),
> +       [PERF_RECORD_BPF_METADATA]        =3D sizeof(struct perf_record_b=
pf_metadata),
> +       [PERF_RECORD_CALLCHAIN_DEFERRED]  =3D sizeof(struct perf_event_he=
ader) + sizeof(__u64),
> +       /*
> +        * SCHEDSTAT events have a version-dependent union after the
> +        * fixed header fields; the minimum is the base (pre-union)
> +        * portion so old and new versions both pass.
> +        */
> +       [PERF_RECORD_SCHEDSTAT_CPU]       =3D offsetof(struct perf_record=
_schedstat_cpu, v15),
> +       [PERF_RECORD_SCHEDSTAT_DOMAIN]    =3D offsetof(struct perf_record=
_schedstat_domain, v15),
> +};
> +
>  static void event_swap(union perf_event *event, bool sample_id_all)
>  {
>         perf_event__swap_op swap;
>
> +       /* Prevent OOB read on perf_event__swap_ops[] from crafted type *=
/
> +       if (event->header.type >=3D PERF_RECORD_HEADER_MAX)
> +               return;
> +
>         swap =3D perf_event__swap_ops[event->header.type];
>         if (swap)
>                 swap(event, sample_id_all);
> @@ -1780,6 +1858,20 @@ int perf_session__peek_event(struct perf_session *=
session, off_t file_offset,
>         if (session->one_mmap && !session->header.needs_swap) {
>                 event =3D file_offset - session->one_mmap_offset +
>                         session->one_mmap_addr;
> +
> +               /* Every event must at least contain its own header */
> +               if (event->header.size < sizeof(struct perf_event_header)=
)
> +                       return -1;
> +
> +               /* Reject undersized events on the native-endian fast pat=
h */
> +               if (event->header.type < PERF_RECORD_HEADER_MAX) {
> +                       u32 min_sz =3D perf_event__min_size[event->header=
.type];

Using an array means we always need to bounds check the accesses which
is pretty repetetive. For `perf_event__sample_event_size`, we already
have a function. Would using a function here keep the code more
concise? A function could also be passed attr.sample_id_all and
sample_type so that the event size minimum can take these into
account.

Note, this has come up in some of my posted patches I think because
the LLMs are keen on bounds checking. Minimum size variable for python
event processing:
https://lore.kernel.org/lkml/20260428071903.1886173-16-irogers@google.com/
Branch stack sample event size fix:
https://lore.kernel.org/lkml/20260429181136.2712655-2-irogers@google.com/

Thanks,
Ian

> +
> +                       if (min_sz && event->header.size < min_sz) {
> +                               *event_ptr =3D event;
> +                               return -1;
> +                       }
> +               }
>                 goto out_parse_sample;
>         }
>
> @@ -1810,6 +1902,20 @@ int perf_session__peek_event(struct perf_session *=
session, off_t file_offset,
>         if (readn(fd, buf, rest) !=3D (ssize_t)rest)
>                 return -1;
>
> +       /* Reject undersized events before swapping */
> +       if (event->header.type < PERF_RECORD_HEADER_MAX) {
> +               u32 min_sz =3D perf_event__min_size[event->header.type];
> +
> +               if (min_sz && event->header.size < min_sz) {
> +                       pr_warning("WARNING: peek_event: %s event size %u=
 too small (min %u)\n",
> +                                  perf_event__name(event->header.type),
> +                                  event->header.size, min_sz);
> +                       /* Expose so peek_events can advance past it */
> +                       *event_ptr =3D event;
> +                       return -1;
> +               }
> +       }
> +
>         if (session->header.needs_swap)
>                 event_swap(event, evlist__sample_id_all(session->evlist))=
;
>
> @@ -1860,6 +1966,21 @@ static s64 perf_session__process_event(struct perf=
_session *session,
>         const struct perf_tool *tool =3D session->tool;
>         int ret;
>
> +       if (event->header.type < PERF_RECORD_HEADER_MAX) {
> +               u32 min_sz =3D perf_event__min_size[event->header.type];
> +
> +               /*
> +                * Skip rather than abort: a crafted file may have
> +                * isolated bad events among otherwise valid data.
> +                */
> +               if (min_sz && event->header.size < min_sz) {
> +                       pr_warning("WARNING: %s event size %u too small (=
min %u), skipping\n",
> +                                  perf_event__name(event->header.type),
> +                                  event->header.size, min_sz);
> +                       return 0;
> +               }
> +       }
> +
>         if (session->header.needs_swap)
>                 event_swap(event, evlist__sample_id_all(evlist));
>
> --
> 2.54.0
>
