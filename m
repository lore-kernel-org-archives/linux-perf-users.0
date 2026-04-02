Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B333ADA8
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143633; cv=pass; b=gSK1Elq3mnoNtrCTVWBUq112QxAsCEYrKtWnErDKiqR06Bz3vN7DSuY13M5gGoLo3wKEaw0PkKFR48JV3ALxZUYX6M91oV+JaFs+apB1YwDF9ia7cTtxUvKGfcv1ptimQ1xrmP5YsnLVkHsMUh4m77IPDQ+ZzxdduWJyBHi6QpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143633; c=relaxed/simple;
	bh=kGf9sbyWrxAyCWnz0C8mXUti/kFwGhKtsrHzpE+m/Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmvs9suR9mPeQe4NPuY0pscZDayQxzKpOtXLoy0oQyfZoWsNucdp+VHkRfRFs+fQqj79vv8YLZIS76iHk78mcs0dIVVqkajWXg5RZ1PHxiCF8M2O3RZJwv49yssadNyZvYMHoqN2kOIw1ENhMRYyLWJZt5iLaoqbqhYeY/bYDQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbSY9F5P; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbSY9F5P"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0c12be0ecso104335ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 08:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775143631; cv=none;
        d=google.com; s=arc-20240605;
        b=GtDqbXLJ/w8k1JlNveMs9tUOeVakifiuF4UvTPUx8fQlN+Qe/OIgjUtQvpdGCQav7n
         tJQ3N616VU6T3aVlAyS+sE+n5N1NP/4zsgqqVXdI7HCW0vDusXOdDSCGAyIkrbAK3iTV
         fd4qoM1dHP/wuIXkVzA6Nb9iF5jLjYjZe7b2CZOpdWN+NiwL3aTLEBYrmldH6/CLqBoo
         6FljNOxptf6FhtaCyEqTJ8fj7io5IeHRME+3x2/7/thuUN7XrsYnOEvhijEPTAHRgdoH
         /dJXcJGB85AwHyZFfnDm7g/OsPUXlrLzq6aZB+mX9s0U6j9DQFFd0W+iRlPUQ0MNIIuq
         H4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obs00e+wrJFs2sWumo70dIrKKwlJrD6vLf8ObLD+lkA=;
        fh=2Fzq7r2uihaLIdOydyXZXr5yX51Q2HjxV7O7VnP98EQ=;
        b=eRfKljbaONsZZ+8NDypi5meHd2OxvEskqAkeL8BQ5zq4Q9RZCJ1XjzX9hCz3x/4GeC
         kMw4IhK9TDtdyyfH+2j843BwwAv1/TfAo20DnPRCcaXJI9ygD/dSBaNNOqxRXmXAgGEk
         cPtuKnrwMgwUoIt4Kb4CZcQk/YXeIUpo2iG8IluB2cG44da3fjbALMu8q+dqyw30B3+e
         xsqP+Pyych71KVQQW3vPQzoFUR2FemsgrRtn908yYZIjeFBvPrAIF9NXu6YjwhNtZPx9
         0tBUtzmqs4p2rFp6bf87h/ETGv9UgcJWRkjHc1V/lexS1Ba//ED0BrsFd+doE2d7jsaF
         BGHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775143631; x=1775748431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obs00e+wrJFs2sWumo70dIrKKwlJrD6vLf8ObLD+lkA=;
        b=tbSY9F5PCQRAWRp3dFByDzGKpvpJixEEUSBH4hbhjTXiCgWI6Qkq84qZmi5GqlNYVy
         mMXgWsLVRNd8cXoLNy3F5Kvd8wjjmHvk9rMzv/G8A1kJEQJC7GdKXd1WmkwdqFRVIkO0
         De3xAXRlVL78hiOPC0VO+v81pgco+Jryd0lo9r2lNHNui08pkjJRlDt+7SU6DRUdWkRj
         DlexhNC1ZOP72ceLlIVrqjAZzFJmSHH+CGEe2McSrfKaLIKlQmU/r13I6jpP8iSSrbgM
         wVAlDGBh+KF+42uXGuzvRTJ9NP7+/kIxNvgG41CZN8r0KSm6F9QEkyMRM6JnnQwFHOSc
         DdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143631; x=1775748431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obs00e+wrJFs2sWumo70dIrKKwlJrD6vLf8ObLD+lkA=;
        b=gCjGPGXwvjg8tzwRVia0mIvz9PCvXxo4VAZZAh1/z1cUqbXgwT16KimxpFZb1kLopV
         Rk9MQuRqBFiThdFjKYEPH+NgOc25xblho+WdlkfLsaGE3TvkSPw5Ldd5/M7yKt/MuKZY
         fFUTTzuD9aGvL1q4fiIzGcETr/NRD7mkvSNC+l+seZRNi470LkPJO+d59m5DZ/6mD2Bl
         R3QITiI270jo5zbJj6X/ait4GIVniWXrbCrokY1JYZW7zbJ4DaWprPUJMHgwRnECWbvG
         Tot5UCX8JErDiI6fjEOoTOEzVnumIqWx+Cn383Otq1NulaIyCP+JUO+32FFVCxpFJ8Qd
         j8gg==
X-Forwarded-Encrypted: i=1; AJvYcCXv4bc4FoaZQ2ySfJMTUYKb7uod+b4P3c+m/rcj+GZ8S6I5Up8Wyjps2MI1zVoxnqHraANX+UgJllYHCd3l9SAx@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjNwKQNJMWneonxRnAQ2ElM9zIw1LJPhh5RdvAXloe1ZJfHkP
	v3VNd29EXzBshmMSFsrtHA+iub7nBqd6OshF9jyu7RFBU+bcknKikYIZF9dpYW2vKymkPuwzGEZ
	khtP3XM7Oi/8SdcPO4nR1T6ALsKXnmF6AKe+5WVIi
X-Gm-Gg: AeBDiet0RsCtrflOiI3Do2GMuYNrUMvu5rSBgyELJz4l/2sgC08JUVuUbhBInZ/HsIl
	aRmlwgP94GdqJuT7mqcwOHrgMKl6Gv0dN3iAydUyqerdWfmGU9MT1QPneNjm293bMQEzOVVUtXp
	aryl+Rf9W4ufJgjcTnHI2qW267thOfbcMM2m1wFud9Ldv4MtRxSSc7uDxUS8uC8nUu7Kl1qd9Z1
	dxefITB5UM0uJjVkQje9JNavRKjj7p471CsbwXh89ViUxoTGkVY4gEK0tWNykIPU+9RfBOI00L/
	lRmGAS4uoK+wKHUqW/6v2TisAD71pLvJEHiS
X-Received: by 2002:a17:902:e74e:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2b2784835cemr2064795ad.9.1775143630848; Thu, 02 Apr 2026
 08:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org> <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>
In-Reply-To: <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Apr 2026 08:26:59 -0700
X-Gm-Features: AQROBzAMz7khfd74Y0zsjFeuyutU7U6Voo59fVJW6yu6K4lYUjWspkQFbEqalcU
Message-ID: <CAP-5=fVcYOJ_3TWd6won5FVaH2MH6QwLhCoCRnNzzeE-9PgO1Q@mail.gmail.com>
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

On Wed, Apr 1, 2026 at 7:26=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> From the TRM [1], N1 has one IMPDEF event which isn't covered by the
> common list. Add a framework so that more cores can be added in the
> future and that the N1 IMPDEF event can be decoded. Also increase the
> size of the buffer because we're adding more strings and if it gets
> truncated it falls back to a hex dump only.
>
> [1]: https://developer.arm.com/documentation/100616/0401/Statistical-Prof=
iling-Extension/implementation-defined-features-of-SPE
> Suggested-by: Al Grant <al.grant@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/arm-spe-decoder/Build              |  2 +
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 45 ++++++++++++++++=
++++--
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  5 ++-
>  tools/perf/util/arm-spe.c                          | 13 ++++---
>  4 files changed, 54 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-=
spe-decoder/Build
> index ab500e0efe24..97a298d1e279 100644
> --- a/tools/perf/util/arm-spe-decoder/Build
> +++ b/tools/perf/util/arm-spe-decoder/Build
> @@ -1 +1,3 @@
>  perf-util-y +=3D arm-spe-pkt-decoder.o arm-spe-decoder.o
> +
> +CFLAGS_arm-spe-pkt-decoder.o +=3D -I$(srctree)/tools/arch/arm64/include/=
 -I$(OUTPUT)arch/arm64/include/generated/
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tool=
s/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index c880b0dec3a1..42a7501d4dfe 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -15,6 +15,8 @@
>
>  #include "arm-spe-pkt-decoder.h"
>
> +#include "../../arm64/include/asm/cputype.h"

Sashiko spotted:
https://sashiko.dev/#/patchset/20260401-james-spe-impdef-decode-v1-0-ad0d37=
2c220c%40linaro.org
"""
This isn't a bug, but does this include directive rely on accidental
path normalization?

The relative path ../../arm64/include/asm/cputype.h does not exist relative
to arm-spe-pkt-decoder.c. It only compiles because the Build file adds
-I$(srctree)/tools/arch/arm64/include/ to CFLAGS.

Would it be cleaner to use #include <asm/cputype.h> to explicitly rely on
the include path?
[ ... ]
"""
I wouldn't use <asm/cputype.h> due to cross-compilation and the like,
instead just add the extra "../" into the include path.

> +
>  static const char * const arm_spe_packet_name[] =3D {
>         [ARM_SPE_PAD]           =3D "PAD",
>         [ARM_SPE_END]           =3D "END",
> @@ -307,6 +309,11 @@ static const struct ev_string common_ev_strings[] =
=3D {
>         { .event =3D 0, .desc =3D NULL },
>  };
>
> +static const struct ev_string n1_event_strings[] =3D {
> +       { .event =3D 12, .desc =3D "LATE-PREFETCH" },
> +       { .event =3D 0, .desc =3D NULL },
> +};
> +
>  static u64 print_event_list(int *err, char **buf, size_t *buf_len,
>                             const struct ev_string *ev_strings, u64 paylo=
ad)
>  {
> @@ -318,14 +325,44 @@ static u64 print_event_list(int *err, char **buf, s=
ize_t *buf_len,
>         return payload;
>  }
>
> +struct event_print_handle {
> +       const struct midr_range *midr_ranges;
> +       const struct ev_string *ev_strings;
> +};
> +
> +#define EV_PRINT(range, strings)                       \
> +       {                                       \
> +               .midr_ranges =3D range,           \
> +               .ev_strings =3D strings,  \
> +       }
> +
> +static const struct midr_range n1_event_encoding_cpus[] =3D {
> +       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> +       {},
> +};
> +
> +static const struct event_print_handle event_print_handles[] =3D {
> +       EV_PRINT(n1_event_encoding_cpus, n1_event_strings),
> +};
> +
>  static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
> -                                 char *buf, size_t buf_len)
> +                                 char *buf, size_t buf_len, u64 midr)
>  {
>         u64 payload =3D packet->payload;
>         int err =3D 0;
>
>         arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
> -       print_event_list(&err, &buf, &buf_len, common_ev_strings, payload=
);
> +       payload =3D print_event_list(&err, &buf, &buf_len, common_ev_stri=
ngs,
> +                                  payload);
> +
> +       /* Try to decode IMPDEF bits for known CPUs */
> +       for (unsigned int i =3D 0; i < ARRAY_SIZE(event_print_handles); i=
++) {
> +               if (is_midr_in_range_list(midr,
> +                                         event_print_handles[i].midr_ran=
ges))
> +                       payload =3D print_event_list(&err, &buf, &buf_len=
,
> +                                                  event_print_handles[i]=
.ev_strings,
> +                                                  payload);
> +       }
>
>         return err;
>  }
> @@ -506,7 +543,7 @@ static int arm_spe_pkt_desc_counter(const struct arm_=
spe_pkt *packet,
>  }
>
>  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> -                    size_t buf_len)
> +                    size_t buf_len, u64 midr)
>  {
>         int idx =3D packet->index;
>         unsigned long long payload =3D packet->payload;
> @@ -522,7 +559,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet=
, char *buf,
>                 arm_spe_pkt_out_string(&err, &buf, &blen, "%s", name);
>                 break;
>         case ARM_SPE_EVENTS:
> -               err =3D arm_spe_pkt_desc_event(packet, buf, buf_len);
> +               err =3D arm_spe_pkt_desc_event(packet, buf, buf_len, midr=
);
>                 break;
>         case ARM_SPE_OP_TYPE:
>                 err =3D arm_spe_pkt_desc_op_type(packet, buf, buf_len);
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tool=
s/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index adf4cde320aa..17b067fe3c87 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -11,7 +11,7 @@
>  #include <stddef.h>
>  #include <stdint.h>
>
> -#define ARM_SPE_PKT_DESC_MAX           256
> +#define ARM_SPE_PKT_DESC_MAX           512
>
>  #define ARM_SPE_NEED_MORE_BYTES                -1
>  #define ARM_SPE_BAD_PACKET             -2
> @@ -186,5 +186,6 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>  int arm_spe_get_packet(const unsigned char *buf, size_t len,
>                        struct arm_spe_pkt *packet);
>
> -int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t=
 len);
> +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t=
 len,
> +                    u64 midr);
>  #endif
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 7447b000f9cd..46f0309c092b 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -135,7 +135,7 @@ struct data_source_handle {
>         }
>
>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
> -                        unsigned char *buf, size_t len)
> +                        unsigned char *buf, size_t len, u64 midr)
>  {
>         struct arm_spe_pkt packet;
>         size_t pos =3D 0;
> @@ -161,7 +161,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_=
unused,
>                         color_fprintf(stdout, color, "   ");
>                 if (ret > 0) {
>                         ret =3D arm_spe_pkt_desc(&packet, desc,
> -                                              ARM_SPE_PKT_DESC_MAX);
> +                                              ARM_SPE_PKT_DESC_MAX, midr=
);
>                         if (!ret)
>                                 color_fprintf(stdout, color, " %s\n", des=
c);
>                 } else {
> @@ -174,10 +174,10 @@ static void arm_spe_dump(struct arm_spe *spe __mayb=
e_unused,
>  }
>
>  static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *buf,
> -                              size_t len)
> +                              size_t len, u64 midr)
>  {
>         printf(".\n");
> -       arm_spe_dump(spe, buf, len);
> +       arm_spe_dump(spe, buf, len, midr);
>  }
>
>  static int arm_spe_get_trace(struct arm_spe_buffer *b, void *data)
> @@ -1469,8 +1469,11 @@ static int arm_spe_process_auxtrace_event(struct p=
erf_session *session,
>                 /* Dump here now we have copied a piped trace out of the =
pipe */
>                 if (dump_trace) {
>                         if (auxtrace_buffer__get_data(buffer, fd)) {
> +                               u64 midr =3D 0;
> +
> +                               arm_spe__get_midr(spe, buffer->cpu.cpu, &=
midr);

Sashiko claims to have spotted an issue here:
"""
Is it possible for arm_spe__get_midr() to cause a segmentation fault here?

If the trace is from an older recording (metadata version 1) and the
environment lacks a CPUID string (such as during cross-architecture
analysis), perf_env__cpuid() returns NULL.

It appears arm_spe__get_midr() then passes this NULL pointer to
strtol(cpuid, NULL, 16), which leads to undefined behavior.
"""

But this feels like, if this happens you're already having a bad time
and these changes aren't necessarily making things worse.

Thanks,
Ian

>                                 arm_spe_dump_event(spe, buffer->data,
> -                                               buffer->size);
> +                                               buffer->size, midr);
>                                 auxtrace_buffer__put_data(buffer);
>                         }
>                 }
>
> --
> 2.34.1
>
