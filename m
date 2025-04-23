Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3481F9413
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448552; cv=none; b=d+Nu3Zd0Tia63wK/7Hm6HaRnNfKGunwThhqlamSc8JcReomZTZOF1gcN2LMNvEdhO40eAezZsxvg8HavDvOLQF3sb9p/QBwUR0WJm5CcyVENPbxR3HtvNnxjR7vGC9s/5neyy37H/3xHLNR1WzMEJRBjUbzPBYlpxn8vpq+MotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448552; c=relaxed/simple;
	bh=1Gi0O3bymMAhwOE7EO9gUhKQ5ASLF7SPZ8b+OzOFjI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKt2PdBbnwVBXEJTYq1KrqT6EslfxDAdozmw+tOvRziwKf2z4Xx0fzZe5FGkVdKNdu+Ec8sNvE2PsfiU2HaZeZFCnGGmcOtoVTcXoWAEJRL7LSQG4kYOC/kuck8YZ77CbBkwTCu3F+XwODtAAfjlZODqg1rv4AYug9XrDp02Fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnWMNJ/a; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnWMNJ/a"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acacb8743a7so66946666b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745448549; x=1746053349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFqMsc9Cgrc/jOwHdKO+Q6o7jkhid+GmOd9W2mEHoHY=;
        b=cnWMNJ/a9UDVqY1QAMgi68edJFwQ0x4rKWKnWZszqmk6Vq2bdWGIRI30zlP3eYheUH
         wpHFf1TMsI6/8t5kk+gi//Ayv0S9OIH0Zn5kLEyqJMd0jG88bELti3yyWyaWR7z8BC/U
         tZv7Z8TPLxF8/JMd85DseQQUu6siXYS6F17igEw6uookl+kqPReG5pvwy6sZUqPuqEcz
         w2QenS40Zsdp/eltm55zG59cYfKXFiGOb+2kloyZ/2pAw/BinF/NNf+IUJx62m9lgnCG
         rd3NK1oqWFukaN/JoqY7Hpp59+vRFTMm3Xm4FUwqzPRGPQw3+intc82l4gEedIfvuoxs
         UBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745448549; x=1746053349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFqMsc9Cgrc/jOwHdKO+Q6o7jkhid+GmOd9W2mEHoHY=;
        b=lQHKbMaKm3YlyaQr41laXwOsieS3DZFE1q4RQ3yNHOFbkPqRtGIn9VXCQIYZWez7Xp
         NhANScLg/izeBWJzS0r4DiDC3aq/g1QTRGBRqpxfjQb8syLRsRhSRx0Gu04Rh5RR7trC
         pPlrW62yyghwGx6JOxfxf7UtZDnUyg0y3v0i76PvBKWLptiq1cS/W29DgS6dynk2hNxE
         p4MuI/9pbYpmXZivElVAlTjpO3LoINMmxcxsOpPv3cDJvaE7ZU9W77x915czV8de4Gf4
         efJUxUToVW2b8jwD6+UbRiOhOFQepHtvo9pRIPqZl08SybU+is8I4H3xUhVv2CudN1/Q
         3zKg==
X-Forwarded-Encrypted: i=1; AJvYcCVs+DtWJYKDrCsnZiC9gVTicq7WG7ZWSXF1keTVTSSXXFQ6lGqTar1Pi3vTqkl0uikg0wd7YOd6LvWs4l9zQXYy@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeVTWOOU4nOCgrcWX4yjCS5UONZs6JKJWkXqlzA4ZYTmuEhjz
	bURnbbJfGx0y1S/Nc5Fups2OjWmEFHKHZsDqEUEYFrgF9UFo9jv+ZBYOBoUaNxgBoMLTFJi9ouQ
	XJcM4QfknP0W7xMlooZ3p9Oul2+58kKMDmMHU
X-Gm-Gg: ASbGncvZI87JiQjGUg3pAIJTW04uezmNPiMY98QjRKK72xqewFdo5wg9sTK3jVQGui0
	WCI57WK41FGZxWzyILvcc7KSnQ0vCsEiDWRe4ODvB61WtvNJOZC2zoeLqQ5ifQlO2pmuJRRvRmx
	jXNeurYn46eAZUkaUyRZpLhfHqvzsQMiNmTexFDzb/s0BMkZM=
X-Google-Smtp-Source: AGHT+IF8vhtPElp2/qNIeSObRCOdb1stNKogQ7L4t9EfEQ/ciGeZ8TDp+qkyekR47NwH27EEaH1CJUxWIZvWrUjAuU0=
X-Received: by 2002:a17:907:2d13:b0:ace:395c:124d with SMTP id
 a640c23a62f3a-ace5a40501bmr9619966b.25.1745448549160; Wed, 23 Apr 2025
 15:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327225651.642965-1-ctshao@google.com> <20250327225651.642965-4-ctshao@google.com>
 <CAP-5=fU37XBFa-kft5JYPO+BCWP5zGnfZCkCqvzYW-yozF8o0g@mail.gmail.com>
In-Reply-To: <CAP-5=fU37XBFa-kft5JYPO+BCWP5zGnfZCkCqvzYW-yozF8o0g@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 23 Apr 2025 15:48:57 -0700
X-Gm-Features: ATxdqUGAMv_9OU25H2O9bUU4wBlTXm4ZUK_M0yXfJBA5sp3etcIw-e-NvW66MDk
Message-ID: <CAJpZYjXZGXFC8CwKahCya9sB6J6OOOdsX7=X9mdPfyxQ7DAGGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf test: Add stat uniquifying test
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, ak@linux.intel.com, howardchu95@gmail.com, 
	linux@treblig.org, yeoreum.yun@arm.com, james.clark@linaro.org, 
	weilin.wang@intel.com, asmadeus@codewreck.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 12:25=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Mar 27, 2025 at 4:01=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > The `stat+uniquify.sh` test retrieves all uniquified `clockticks` event=
s
> > from `perf list -v clockticks` and check if `perf stat -e clockticks -A=
`
> > contains all of them.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  .../tests/shell/stat+event_uniquifying.sh     | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh
> >
> > diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/p=
erf/tests/shell/stat+event_uniquifying.sh
> > new file mode 100755
> > index 000000000000..5ec35c52b7d9
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> > @@ -0,0 +1,69 @@
> > +#!/bin/bash
> > +# perf stat events uniquifying
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> > +perf_tool=3Dperf
> > +err=3D0
> > +
> > +test_event_uniquifying() {
> > +  # We use `clockticks` to verify the uniquify behavior.
> > +  event=3D"clockticks"
>
> This event is generally only available on Intel, not AMD or ARM, so we
> will need to skip if it isn't present.
>
> > +  # If the `-A` option is added, the event should be uniquified.
> > +  #
> > +  # $perf list -v clockticks
> > +  #
> > +  # List of pre-defined events (to be used in -e or -M):
> > +  #
> > +  #   uncore_imc_0/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_1/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_2/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_3/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_4/clockticks/                           [Kernel PMU e=
vent]
> > +  #   uncore_imc_5/clockticks/                           [Kernel PMU e=
vent]
> > +  #
> > +  #   ...
> > +  #
> > +  # $perf stat -e clockticks -A -- true
> > +  #
> > +  #  Performance counter stats for 'system wide':
> > +  #
> > +  # CPU0            3,773,018      uncore_imc_0/clockticks/
> > +  # CPU0            3,609,025      uncore_imc_1/clockticks/
> > +  # CPU0                    0      uncore_imc_2/clockticks/
> > +  # CPU0            3,230,009      uncore_imc_3/clockticks/
> > +  # CPU0            3,049,897      uncore_imc_4/clockticks/
> > +  # CPU0                    0      uncore_imc_5/clockticks/
> > +  #
> > +  #        0.002029828 seconds time elapsed
> > +
> > +  echo "stat event uniquifying test"
> > +  uniquified_event_array=3D()
> > +
> > +  # Check how many uniquified events.
> > +  while IFS=3D read -r line; do
> > +    uniquified_event=3D$(echo "$line" | awk '{print $1}')
> > +    uniquified_event_array+=3D("${uniquified_event}")
> > +  done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]"=
)
>
> Shouldn't the array contain every sysfs event that doesn't have a json
> component? They may or may not be uniquified so I think the array name
> is misleading.
>
> > +  perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- =
true"
> > +  $perf_command
> > +
> > +  # Check the output contains all uniquified events.
> > +  for uniquified_event in "${uniquified_event_array[@]}"; do
> > +    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
>
> Why not pass the file directly to grep?
> Should some of the events not show in the stat output as you only
> asked for the clockticks event? I'm not sure how this test can pass
> currently.
>
> Thanks,
> Ian
>
Thanks for your comment, Ian.

I tried to run `perf list -v clockticks` and grep for all events which
have `[Kernel PMU event]` tag.
Ideally, that should retrieve all uniquified clockticks events.
Then I ran `perf stat -e clockticks` to check if all events from `perf
list` are showing.

I randomly picked some machines from different arches and it seems
work. Let me know if you have a better idea.

-CT

> > +      echo "Event is not uniquified [Failed]"
> > +      echo "${perf_command}"
> > +      cat "${stat_output}"
> > +      err=3D1
> > +      break
> > +    fi
> > +  done
> > +}
> > +
> > +test_event_uniquifying
> > +rm -f "${stat_output}"
> > +exit $err
> > --
> > 2.49.0.472.ge94155a9ec-goog
> >
