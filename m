Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2126ED3D
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586428; cv=pass; b=Tmt9UDKG5ch+PbyMZIlprb29PFEg1GI/ArlbLX5VqxNiWW6YklSiYxjOBLsSDscBxpdEx6iLmDHpQ46o00kTyQibuGOpjnqxa9HH2eOuZuDw74z0Yf9tV0MN7MOUAkfqvnZ+mrMakqcWyTmwR3/skC5HXl5J0QY04dXd83JrnLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586428; c=relaxed/simple;
	bh=2Q/6xVnYL0LslTOAHjisVzOCd5mw8W2IlEzSY2g1H/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af167L1fqTfceMYyYGuIAUuNgXmh5NbRyCalZPUfyrx4WHR2fN0qDabTPbFlNDDeSet+iqdS0b68aod5I5WJothdxuwYQbEBxg8YPej9WRJyk0E/RzB6aJBRVK63YAfw8SUTu6ZNXchqCzEsnkDC4SDhVapp/ne2W7TYR28GrPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVN29G/e; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVN29G/e"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2591757fbso17695ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 11:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775586426; cv=none;
        d=google.com; s=arc-20240605;
        b=O6UVfflNFUUlbD/fmR5g0GO36TSX/pAApd/dBomushck/mfHkBnQMFlLEfdZGL4bjM
         kdqziIkdsxfqU1K3hukLlErRAa56dw1AyHsy95Ue0clJOBGDa6akXT6qKOkBTAR6Na4i
         09Di1MLcL7l6q7ojjSjR05tj+oP450/rp2r5HMUl2fACYGdBeMgjlY59ipNR2d+ufqe8
         wSzf0GegxqgAT+eJr1aWZCadY4lB8YmIdU36oCZa9zno6pWcxOhXt0tKoMIKjiglDv6J
         npcJRlr/gwLdiP1yrq37irofYOlCgGjCnm2L5PPOO9pMhCe2yagniJoJcWo21qPt5nhn
         kvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QLHmsMCJJe8XmVabY7ZwaMsB0JIhJoLXXK2dqS8qMgQ=;
        fh=52HVdM2ZUBt1gNbzPDcVzLJwcP4/2s5DhW/HMBUGEkw=;
        b=c+6rDdFOsxxIfYykcUG3YGzkCTEVj3/ujremPCoNICM3poPjUVIgphu5+JT8+sJAQ4
         VsElwLzVALKplx68ULC4pUK0EijtlOHg8wFGb813pGdRsGpMbhJFaPPLgYRXoJQ17k/h
         kc3mITT02g7bRAfgzuXCpOdNhdDZRj7HqcmCJrqBYACowVOQEQgapOVAuUy214Jv2aoI
         KWqbczW3f1GiaoWcUTuDvfDcys9lY8pb0o/se7LoO/KWWj4mdRrSuglSvbE2i00qx0VH
         UrEeYdcfsp0K1WOs6lrZDzT66jdyEHD0W20zLYy09uAyeNPuISBjTMlmx+tmTZuMMpGk
         EoVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775586426; x=1776191226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLHmsMCJJe8XmVabY7ZwaMsB0JIhJoLXXK2dqS8qMgQ=;
        b=AVN29G/eboAHrqKG/JZmITxx4Ayq00PTPOdVbhCDUrI5wIQLnnHQoEn36eimR3e8Ge
         U4dL+bAGEMC0dKXaAAnUbsH5MFs496pPVxbYC5dC6H8Ytt9rSE5w2JB5nhrQpC2F0QVm
         Uv2YDr5b6JZCJQBgvaMk+X5Jy6l2xIsoXSIJUGCh56FWH1wxaNTBfq5W/P580vMaIXdV
         XhIYfLmhx5qn0X6non5sLnXXtumJtu4573cAQCCT7aGGKEAVVBixMLZhy1RBkV/mlTSF
         wM/ZgknR6K7C/WjGxGDcqgsWsko64BPVCp/hudYKvHCx4SoYpGXpoZr50ygDKkFiyOgW
         7xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586426; x=1776191226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLHmsMCJJe8XmVabY7ZwaMsB0JIhJoLXXK2dqS8qMgQ=;
        b=ORQcoWbiEfwcpnVVxFUPLI57ER5QScJU4MAzS/wfai2vHltFaMPrSr/qEF58Vl1nn6
         SnH6fwQeJx3mTZij1jGo1Satd05ZuV4HXPpc5ycjRTQ1I9CCeRN8nTPbDhbSfsc2MN0a
         8dXBVKnl6F8Xczsr1830ZWHei5dHaR/sAhgnDINn2/RA5MD27zpvr5EzbajN8MNPSR5X
         AyJS5ciu7KdDv4qfFHIBNi+74N09Y3l+IHr5CdNdXiMLOTPf7Dh5922GERJxSyUOMnYv
         hz0fnRooVNcR/flFJyIktuUCNe+hqocyhgfdT4u/3SzQ66/1R1I2oDIyvrkJ8polezzT
         Qevw==
X-Forwarded-Encrypted: i=1; AJvYcCUxfdDsOZ0eXPfCNAaL5uQRDEMx6aGSpTmZhnx92SJzSBnCa/sYfWdGxZkEltVo7M2UBaNNTnTLlcM6vejiSvwm@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQGgnW61Yog62wSy9r+t0m3FNo9l7W84OD5Lkq/b9gXOLwdG8
	4Siu7LWuJ9bv8hfc5U+VsKT0WfcAJpZsJSoE+Dvn2SM0xqsnKM6n2d4iCErVH8VF8exfoyWNT5v
	sBgQ1wqIKDWcvXRTxK3lwZGdbLwxxzVkeoSdq+mIU
X-Gm-Gg: AeBDietuDn5zJXQ0bUv+KI88ziYnoQ9aLrjxP3pDOPurwAcsJcwm7voOzK3ozS8LBgm
	CSaZbjAypdgBO8KSSghMhTU3Plyq1nh0cvzdvlDLtBWioOWI1ohAIYSPOHsBIlxWnHYJxxO86BL
	NiScfBt+mpMaypg1zWEYxIHy0l14LtG/Vgrk3UL7i1mfkpEFKyFXSuXUsRGzEv+yxzqZa9sfmKF
	CYVkggZEpxta/AJbLRDvAJYlTRzttpgccJq1WqtnSLXvZv8e3U08zJKOvw//FPAD7pXTOlRUwZJ
	6eGTMBfvV4zKFYnuBfQbHBWtVDjL7oksmiTX
X-Received: by 2002:a17:902:f647:b0:2ae:80a3:98a9 with SMTP id
 d9443c01a7336-2b283fc0f40mr10621745ad.11.1775586425493; Tue, 07 Apr 2026
 11:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>
 <CAP-5=fVcYOJ_3TWd6won5FVaH2MH6QwLhCoCRnNzzeE-9PgO1Q@mail.gmail.com> <ee012f48-5d08-4004-b9d0-bcac825cb50c@linaro.org>
In-Reply-To: <ee012f48-5d08-4004-b9d0-bcac825cb50c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Apr 2026 11:26:53 -0700
X-Gm-Features: AQROBzCtdbFVyiAJhRZRvQJQgMdNiTWsARZ6zUAs6UuK9VaYot6HRhem4OrrgwU
Message-ID: <CAP-5=fXNb50wXT3YH0i=-U8bXwizzH4bv8EL8mC9BMQE0Anp9Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf arm_spe: Decode Arm N1 IMPDEF events
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 5:35=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 02/04/2026 4:26 pm, Ian Rogers wrote:
> > On Wed, Apr 1, 2026 at 7:26=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >>  From the TRM [1], N1 has one IMPDEF event which isn't covered by the
> >> common list. Add a framework so that more cores can be added in the
> >> future and that the N1 IMPDEF event can be decoded. Also increase the
> >> size of the buffer because we're adding more strings and if it gets
> >> truncated it falls back to a hex dump only.
> >>
> >> [1]: https://developer.arm.com/documentation/100616/0401/Statistical-P=
rofiling-Extension/implementation-defined-features-of-SPE
> >> Suggested-by: Al Grant <al.grant@arm.com>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >>   tools/perf/util/arm-spe-decoder/Build              |  2 +
> >>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 45 ++++++++++++=
++++++++--
> >>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  5 ++-
> >>   tools/perf/util/arm-spe.c                          | 13 ++++---
> >>   4 files changed, 54 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/a=
rm-spe-decoder/Build
> >> index ab500e0efe24..97a298d1e279 100644
> >> --- a/tools/perf/util/arm-spe-decoder/Build
> >> +++ b/tools/perf/util/arm-spe-decoder/Build
> >> @@ -1 +1,3 @@
> >>   perf-util-y +=3D arm-spe-pkt-decoder.o arm-spe-decoder.o
> >> +
> >> +CFLAGS_arm-spe-pkt-decoder.o +=3D -I$(srctree)/tools/arch/arm64/inclu=
de/ -I$(OUTPUT)arch/arm64/include/generated/
> >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/t=
ools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> index c880b0dec3a1..42a7501d4dfe 100644
> >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> @@ -15,6 +15,8 @@
> >>
> >>   #include "arm-spe-pkt-decoder.h"
> >>
> >> +#include "../../arm64/include/asm/cputype.h"
> >
> > Sashiko spotted:
> > https://sashiko.dev/#/patchset/20260401-james-spe-impdef-decode-v1-0-ad=
0d372c220c%40linaro.org
> > """
> > This isn't a bug, but does this include directive rely on accidental
> > path normalization?
> >
> > The relative path ../../arm64/include/asm/cputype.h does not exist rela=
tive
> > to arm-spe-pkt-decoder.c. It only compiles because the Build file adds
> > -I$(srctree)/tools/arch/arm64/include/ to CFLAGS.
> >
> > Would it be cleaner to use #include <asm/cputype.h> to explicitly rely =
on
> > the include path?
> > [ ... ]
> > """
> > I wouldn't use <asm/cputype.h> due to cross-compilation and the like,
> > instead just add the extra "../" into the include path.
> >
>
> Do you mean change the #include to this?
>
>    #include "../../../arm64/include/asm/cputype.h"
>
> I still need to add:
>
>    CFLAGS_arm-spe-pkt-decoder.o +=3D -I$(srctree)/tools/arch/arm64/includ=
e/
>
> To make the this include in cputype.h work:
>
>    #include <asm/sysreg.h>
>
> Which probably only works because there isn't a sysreg.h on other
> architectures. But I'm not sure what the significance of ../../ vs
> ../../../ is if either compile? arm-spe.c already does it with ../../
> which is what I copied.

Hmm.. maybe the path should be
"../../../arch/arm64/include/asm/cputype.h". The include preference is
for a path relative to the source file and
../../arm64/include/asm/cputype.h doesn't exist. It is kind of horrid
to add an include path and then use a relative path to escape into a
higher-level directory. arm-spe.c is a little different as it is one
directory higher in the directory layout.

Thanks,
Ian

> >> +
> >>   static const char * const arm_spe_packet_name[] =3D {
> >>          [ARM_SPE_PAD]           =3D "PAD",
> >>          [ARM_SPE_END]           =3D "END",
> >> @@ -307,6 +309,11 @@ static const struct ev_string common_ev_strings[]=
 =3D {
> >>          { .event =3D 0, .desc =3D NULL },
> >>   };
> >>
> >> +static const struct ev_string n1_event_strings[] =3D {
> >> +       { .event =3D 12, .desc =3D "LATE-PREFETCH" },
> >> +       { .event =3D 0, .desc =3D NULL },
> >> +};
> >> +
> >>   static u64 print_event_list(int *err, char **buf, size_t *buf_len,
> >>                              const struct ev_string *ev_strings, u64 p=
ayload)
> >>   {
> >> @@ -318,14 +325,44 @@ static u64 print_event_list(int *err, char **buf=
, size_t *buf_len,
> >>          return payload;
> >>   }
> >>
> >> +struct event_print_handle {
> >> +       const struct midr_range *midr_ranges;
> >> +       const struct ev_string *ev_strings;
> >> +};
> >> +
> >> +#define EV_PRINT(range, strings)                       \
> >> +       {                                       \
> >> +               .midr_ranges =3D range,           \
> >> +               .ev_strings =3D strings,  \
> >> +       }
> >> +
> >> +static const struct midr_range n1_event_encoding_cpus[] =3D {
> >> +       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> >> +       {},
> >> +};
> >> +
> >> +static const struct event_print_handle event_print_handles[] =3D {
> >> +       EV_PRINT(n1_event_encoding_cpus, n1_event_strings),
> >> +};
> >> +
> >>   static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
> >> -                                 char *buf, size_t buf_len)
> >> +                                 char *buf, size_t buf_len, u64 midr)
> >>   {
> >>          u64 payload =3D packet->payload;
> >>          int err =3D 0;
> >>
> >>          arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
> >> -       print_event_list(&err, &buf, &buf_len, common_ev_strings, payl=
oad);
> >> +       payload =3D print_event_list(&err, &buf, &buf_len, common_ev_s=
trings,
> >> +                                  payload);
> >> +
> >> +       /* Try to decode IMPDEF bits for known CPUs */
> >> +       for (unsigned int i =3D 0; i < ARRAY_SIZE(event_print_handles)=
; i++) {
> >> +               if (is_midr_in_range_list(midr,
> >> +                                         event_print_handles[i].midr_=
ranges))
> >> +                       payload =3D print_event_list(&err, &buf, &buf_=
len,
> >> +                                                  event_print_handles=
[i].ev_strings,
> >> +                                                  payload);
> >> +       }
> >>
> >>          return err;
> >>   }
> >> @@ -506,7 +543,7 @@ static int arm_spe_pkt_desc_counter(const struct a=
rm_spe_pkt *packet,
> >>   }
> >>
> >>   int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >> -                    size_t buf_len)
> >> +                    size_t buf_len, u64 midr)
> >>   {
> >>          int idx =3D packet->index;
> >>          unsigned long long payload =3D packet->payload;
> >> @@ -522,7 +559,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *pac=
ket, char *buf,
> >>                  arm_spe_pkt_out_string(&err, &buf, &blen, "%s", name)=
;
> >>                  break;
> >>          case ARM_SPE_EVENTS:
> >> -               err =3D arm_spe_pkt_desc_event(packet, buf, buf_len);
> >> +               err =3D arm_spe_pkt_desc_event(packet, buf, buf_len, m=
idr);
> >>                  break;
> >>          case ARM_SPE_OP_TYPE:
> >>                  err =3D arm_spe_pkt_desc_op_type(packet, buf, buf_len=
);
> >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/t=
ools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> >> index adf4cde320aa..17b067fe3c87 100644
> >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> >> @@ -11,7 +11,7 @@
> >>   #include <stddef.h>
> >>   #include <stdint.h>
> >>
> >> -#define ARM_SPE_PKT_DESC_MAX           256
> >> +#define ARM_SPE_PKT_DESC_MAX           512
> >>
> >>   #define ARM_SPE_NEED_MORE_BYTES                -1
> >>   #define ARM_SPE_BAD_PACKET             -2
> >> @@ -186,5 +186,6 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type=
);
> >>   int arm_spe_get_packet(const unsigned char *buf, size_t len,
> >>                         struct arm_spe_pkt *packet);
> >>
> >> -int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, siz=
e_t len);
> >> +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, siz=
e_t len,
> >> +                    u64 midr);
> >>   #endif
> >> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> >> index 7447b000f9cd..46f0309c092b 100644
> >> --- a/tools/perf/util/arm-spe.c
> >> +++ b/tools/perf/util/arm-spe.c
> >> @@ -135,7 +135,7 @@ struct data_source_handle {
> >>          }
> >>
> >>   static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
> >> -                        unsigned char *buf, size_t len)
> >> +                        unsigned char *buf, size_t len, u64 midr)
> >>   {
> >>          struct arm_spe_pkt packet;
> >>          size_t pos =3D 0;
> >> @@ -161,7 +161,7 @@ static void arm_spe_dump(struct arm_spe *spe __may=
be_unused,
> >>                          color_fprintf(stdout, color, "   ");
> >>                  if (ret > 0) {
> >>                          ret =3D arm_spe_pkt_desc(&packet, desc,
> >> -                                              ARM_SPE_PKT_DESC_MAX);
> >> +                                              ARM_SPE_PKT_DESC_MAX, m=
idr);
> >>                          if (!ret)
> >>                                  color_fprintf(stdout, color, " %s\n",=
 desc);
> >>                  } else {
> >> @@ -174,10 +174,10 @@ static void arm_spe_dump(struct arm_spe *spe __m=
aybe_unused,
> >>   }
> >>
> >>   static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *b=
uf,
> >> -                              size_t len)
> >> +                              size_t len, u64 midr)
> >>   {
> >>          printf(".\n");
> >> -       arm_spe_dump(spe, buf, len);
> >> +       arm_spe_dump(spe, buf, len, midr);
> >>   }
> >>
> >>   static int arm_spe_get_trace(struct arm_spe_buffer *b, void *data)
> >> @@ -1469,8 +1469,11 @@ static int arm_spe_process_auxtrace_event(struc=
t perf_session *session,
> >>                  /* Dump here now we have copied a piped trace out of =
the pipe */
> >>                  if (dump_trace) {
> >>                          if (auxtrace_buffer__get_data(buffer, fd)) {
> >> +                               u64 midr =3D 0;
> >> +
> >> +                               arm_spe__get_midr(spe, buffer->cpu.cpu=
, &midr);
> >
> > Sashiko claims to have spotted an issue here:
> > """
> > Is it possible for arm_spe__get_midr() to cause a segmentation fault he=
re?
> >
> > If the trace is from an older recording (metadata version 1) and the
> > environment lacks a CPUID string (such as during cross-architecture
> > analysis), perf_env__cpuid() returns NULL.
> >
> > It appears arm_spe__get_midr() then passes this NULL pointer to
> > strtol(cpuid, NULL, 16), which leads to undefined behavior.
> > """
> >
> > But this feels like, if this happens you're already having a bad time
> > and these changes aren't necessarily making things worse.
> >
> > Thanks,
> > Ian
> >
>
> Yeah I think it might be possible so I can add an error instead of a
> segfault. I'll check the rest of the Sashiko comments too.
>
> >>                                  arm_spe_dump_event(spe, buffer->data,
> >> -                                               buffer->size);
> >> +                                               buffer->size, midr);
> >>                                  auxtrace_buffer__put_data(buffer);
> >>                          }
> >>                  }
> >>
> >> --
> >> 2.34.1
> >>
>
