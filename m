Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3452C9A;
	Fri, 24 May 2024 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514899; cv=none; b=aEJMHRNI1rKnlc+sWnzYRbQcZ+uNhu4CMzOeyRXpIxTSJOKonSpWmcODHJ7sEnhAt1Uccd5T2UbbJ4zaneLfXa2D+9Vr89zNQFwSHG2plspvZpFaY1lUKBlPM+w+yCD5Ljsli2M9gt1K6sjmziTc8Ln3PbWzswkCOaOlGIgZ26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514899; c=relaxed/simple;
	bh=Gr69eyRY4A2sWWhxhR+iI5hpSOqo9bvnJuMiC63ff24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qj8t3Derb+mI9kJ5ydChtzHA10Uu7rQkbRf0fQ5QNgaME6kdp+/ZFf44zIlioxU0s8/7gwgj6k2hq0S0d/7ufVXPaqvpxAXn1DCNh0lqnHwbJHpgaE8En1JhX4PjK7YVozTySDyaQdC4uOA9az0Zsyj7hrGmjTflu5ZWFdU8MiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6818eea9c3aso311888a12.1;
        Thu, 23 May 2024 18:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716514897; x=1717119697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXJqG5ST2BaWDalAXGjoC1Wu2MFeuF+wibS7fRKnrDI=;
        b=RxtX/6F3coEVH1hP4ggtcuwpg+OvKj1oLBgBAk1I6dwzCQps31rEGfzSYdQC5oRGpc
         ITfafDfRmEolyO18JKWnPs25j+10P5fesTj7qGyqfvwG2EoT20Gg6w/rBUgiSmr3JYch
         nHQFgyx1/5rXqkOmxRfphPYH7L9lOW3+ajae6tqJXAnjNEBD8sE7x9kEERy5XAi4lmDV
         O71Ku9hhrde++hh67CrOEjDZ1a8Wx2n0Taugow5a2/ElbEKB4KEZ79/NT8Tg4UcdGmqQ
         4yfSSn34XIbVXABSnn9YF7hdzJjYpr7oqKZ+9Rbfe+KWgUVzXk47cFH5LKb1lXh/BweL
         kiCg==
X-Forwarded-Encrypted: i=1; AJvYcCUp9RYoUOJJQJELNOpvIvvT5kVAYcEJt8FLMUfe6s7kyCli2QNPM7lnmvS4cUEERa60+1jOKGzAxSPsAOHpR83z/JNyuF/TL21KrboupFzED6i6lO3MYYO7ePgIXHJCk7f9PymGHKMmAiRTXK1dWQ==
X-Gm-Message-State: AOJu0YxIANUKvzPY83uD+KYH8NFr1t6n4DxOYSLhV5vLBnshLyJnsACe
	FLZ9/ZZ3gd7I6mb3f83k+DXFlwEnpYbI5NMn4M7W2aH14/eXdI1FF0gQZCpA0GFzR3EydPnr3t+
	n09+0Isw1ZEcmXh3komtg3zQ0uNE=
X-Google-Smtp-Source: AGHT+IE0d+X+isDX4ebvm/Ec1O4u+2HLSkbp1FDQRJvF/bk+LyP7mY6gwBfRgQVdY35tPtb0wLYQCgqk4NZAb3bB+RY=
X-Received: by 2002:a17:90b:3006:b0:2bd:6a8f:4140 with SMTP id
 98e67ed59e1d1-2bf5e18b462mr874273a91.20.1716514896929; Thu, 23 May 2024
 18:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521133029.83654-1-ben.gainey@arm.com> <20240521133029.83654-5-ben.gainey@arm.com>
In-Reply-To: <20240521133029.83654-5-ben.gainey@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 23 May 2024 18:41:25 -0700
Message-ID: <CAM9d7chssov_fW3ZbpYqGRyhS=xuHLyJ7=rkxTNnJ6fkgEdGJQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when
 opening events
To: Ben Gainey <ben.gainey@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	james.clark@arm.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 6:30=E2=80=AFAM Ben Gainey <ben.gainey@arm.com> wro=
te:
>
> The tool will now default to this new mode if the user specifies a
> sampling group when not in system-wide mode, and when --no-inherit
> is not specified.
>
> This change updates evsel to allow the combination of inherit
> and PERF_SAMPLE_READ.
>
> A fallback is implemented for kernel versions where this feature is not
> supported.

But I'm afraid the test would fail on old kernels.  Maybe we need to
put it in the selftests.

Thanks,
Namhyung

>
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> ---
>  tools/perf/tests/attr/README                  |  2 +
>  .../tests/attr/test-record-group-sampling     | 39 ------------
>  .../tests/attr/test-record-group-sampling1    | 50 ++++++++++++++++
>  .../tests/attr/test-record-group-sampling2    | 60 +++++++++++++++++++
>  tools/perf/tests/attr/test-record-group2      |  9 +--
>  tools/perf/util/evsel.c                       | 19 +++++-
>  tools/perf/util/evsel.h                       |  1 +
>  7 files changed, 135 insertions(+), 45 deletions(-)
>  delete mode 100644 tools/perf/tests/attr/test-record-group-sampling
>  create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
>  create mode 100644 tools/perf/tests/attr/test-record-group-sampling2
>
> diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
> index 4066fec7180a8..67c4ca76b85d5 100644
> --- a/tools/perf/tests/attr/README
> +++ b/tools/perf/tests/attr/README
> @@ -51,6 +51,8 @@ Following tests are defined (with perf commands):
>    perf record --call-graph fp kill              (test-record-graph-fp-aa=
rch64)
>    perf record -e '{cycles,instructions}' kill   (test-record-group1)
>    perf record -e '{cycles/period=3D1/,instructions/period=3D2/}:S' kill =
(test-record-group2)
> +  perf record -e '{cycles,cache-misses}:S' kill (test-record-group-sampl=
ing1)
> +  perf record -c 10000 -e '{cycles,cache-misses}:S' kill (test-record-gr=
oup-sampling2)
>    perf record -D kill                           (test-record-no-delay)
>    perf record -i kill                           (test-record-no-inherit)
>    perf record -n kill                           (test-record-no-samples)
> diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/per=
f/tests/attr/test-record-group-sampling
> deleted file mode 100644
> index 97e7e64a38f07..0000000000000
> --- a/tools/perf/tests/attr/test-record-group-sampling
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -[config]
> -command =3D record
> -args    =3D --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null =
2>&1
> -ret     =3D 1
> -
> -[event-1:base-record]
> -fd=3D1
> -group_fd=3D-1
> -sample_type=3D343
> -read_format=3D12|28
> -inherit=3D0
> -
> -[event-2:base-record]
> -fd=3D2
> -group_fd=3D1
> -
> -# cache-misses
> -type=3D0
> -config=3D3
> -
> -# default | PERF_SAMPLE_READ
> -sample_type=3D343
> -
> -# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST
> -read_format=3D12|28
> -task=3D0
> -mmap=3D0
> -comm=3D0
> -enable_on_exec=3D0
> -disabled=3D0
> -
> -# inherit is disabled for group sampling
> -inherit=3D0
> -
> -# sampling disabled
> -sample_freq=3D0
> -sample_period=3D0
> -freq=3D0
> -write_backward=3D0
> diff --git a/tools/perf/tests/attr/test-record-group-sampling1 b/tools/pe=
rf/tests/attr/test-record-group-sampling1
> new file mode 100644
> index 0000000000000..9b87306266329
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-group-sampling1
> @@ -0,0 +1,50 @@
> +[config]
> +command =3D record
> +args    =3D --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null =
2>&1
> +ret     =3D 1
> +
> +[event-1:base-record]
> +fd=3D1
> +group_fd=3D-1
> +
> +# cycles
> +type=3D0
> +config=3D0
> +
> +# default | PERF_SAMPLE_READ
> +sample_type=3D343
> +
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_T=
OTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
> +read_format=3D28|31
> +task=3D1
> +mmap=3D1
> +comm=3D1
> +enable_on_exec=3D1
> +disabled=3D1
> +
> +# inherit is enabled for group sampling
> +inherit=3D1
> +
> +[event-2:base-record]
> +fd=3D2
> +group_fd=3D1
> +
> +# cache-misses
> +type=3D0
> +config=3D3
> +
> +# default | PERF_SAMPLE_READ
> +sample_type=3D343
> +
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_T=
OTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
> +read_format=3D28|31
> +task=3D0
> +mmap=3D0
> +comm=3D0
> +enable_on_exec=3D0
> +disabled=3D0
> +freq=3D0
> +
> +# inherit is enabled for group sampling
> +inherit=3D1
> +
> diff --git a/tools/perf/tests/attr/test-record-group-sampling2 b/tools/pe=
rf/tests/attr/test-record-group-sampling2
> new file mode 100644
> index 0000000000000..8e29fc13f6668
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-group-sampling2
> @@ -0,0 +1,60 @@
> +[config]
> +command =3D record
> +args    =3D --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/=
dev/null 2>&1
> +ret     =3D 1
> +
> +[event-1:base-record]
> +fd=3D1
> +group_fd=3D-1
> +
> +# cycles
> +type=3D0
> +config=3D0
> +
> +# default | PERF_SAMPLE_READ
> +sample_type=3D87
> +
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_T=
OTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
> +read_format=3D28|31
> +task=3D1
> +mmap=3D1
> +comm=3D1
> +enable_on_exec=3D1
> +disabled=3D1
> +
> +# inherit is enabled for group sampling
> +inherit=3D1
> +
> +# sampling disabled
> +sample_freq=3D0
> +sample_period=3D10000
> +freq=3D0
> +write_backward=3D0
> +
> +[event-2:base-record]
> +fd=3D2
> +group_fd=3D1
> +
> +# cache-misses
> +type=3D0
> +config=3D3
> +
> +# default | PERF_SAMPLE_READ
> +sample_type=3D87
> +
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_T=
OTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
> +read_format=3D28|31
> +task=3D0
> +mmap=3D0
> +comm=3D0
> +enable_on_exec=3D0
> +disabled=3D0
> +
> +# inherit is enabled for group sampling
> +inherit=3D1
> +
> +# sampling disabled
> +sample_freq=3D0
> +sample_period=3D0
> +freq=3D0
> +write_backward=3D0
> diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/=
attr/test-record-group2
> index cebdaa8e64e47..785892a54d9e1 100644
> --- a/tools/perf/tests/attr/test-record-group2
> +++ b/tools/perf/tests/attr/test-record-group2
> @@ -9,8 +9,9 @@ group_fd=3D-1
>  config=3D0|1
>  sample_period=3D1234000
>  sample_type=3D87
> -read_format=3D12|28
> -inherit=3D0
> +read_format=3D28|31
> +disabled=3D1
> +inherit=3D1
>  freq=3D0
>
>  [event-2:base-record]
> @@ -19,9 +20,9 @@ group_fd=3D1
>  config=3D0|1
>  sample_period=3D6789000
>  sample_type=3D87
> -read_format=3D12|28
> +read_format=3D28|31
>  disabled=3D0
> -inherit=3D0
> +inherit=3D1
>  mmap=3D0
>  comm=3D0
>  freq=3D0
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3536404e9447b..557d409c53d6c 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1156,7 +1156,15 @@ void evsel__config(struct evsel *evsel, struct rec=
ord_opts *opts,
>                  */
>                 if (leader->core.nr_members > 1) {
>                         attr->read_format |=3D PERF_FORMAT_GROUP;
> -                       attr->inherit =3D 0;
> +               }
> +
> +               /*
> +                * Inherit + SAMPLE_READ requires SAMPLE_TID in the read_=
format
> +                */
> +               if (attr->inherit) {
> +                       evsel__set_sample_bit(evsel, TID);
> +                       evsel->core.attr.read_format |=3D
> +                               PERF_FORMAT_ID;
>                 }
>         }
>
> @@ -1832,6 +1840,8 @@ static int __evsel__prepare_open(struct evsel *evse=
l, struct perf_cpu_map *cpus,
>
>  static void evsel__disable_missing_features(struct evsel *evsel)
>  {
> +       if (perf_missing_features.inherit_sample_read)
> +               evsel->core.attr.inherit =3D 0;
>         if (perf_missing_features.branch_counters)
>                 evsel->core.attr.branch_sample_type &=3D ~PERF_SAMPLE_BRA=
NCH_COUNTERS;
>         if (perf_missing_features.read_lost)
> @@ -1887,7 +1897,12 @@ bool evsel__detect_missing_features(struct evsel *=
evsel)
>          * Must probe features in the order they were added to the
>          * perf_event_attr interface.
>          */
> -       if (!perf_missing_features.branch_counters &&
> +       if (!perf_missing_features.inherit_sample_read &&
> +           evsel->core.attr.inherit && (evsel->core.attr.sample_type & P=
ERF_SAMPLE_READ)) {
> +               perf_missing_features.inherit_sample_read =3D true;
> +               pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not co=
mpatible with inherit, falling back to no-inherit.\n");
> +               return true;
> +       } else if (!perf_missing_features.branch_counters &&
>             (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COU=
NTERS)) {
>                 perf_missing_features.branch_counters =3D true;
>                 pr_debug2("switching off branch counters support\n");
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 517cff431de20..21b8b7e70e75e 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -192,6 +192,7 @@ struct perf_missing_features {
>         bool weight_struct;
>         bool read_lost;
>         bool branch_counters;
> +       bool inherit_sample_read;
>  };
>
>  extern struct perf_missing_features perf_missing_features;
> --
> 2.45.1
>
