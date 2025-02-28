Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8098276D02
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705415; cv=none; b=YH1PisGOzq9FWucIOKfpqATHMAdFCvHG+gjkI1l9IONU3uo6Rt9Rf9tHn2rO6/XB/vtMvTz1QEb7hSs6QyZGpQc9uzR1wcicATECHJi7/ebiDccwI4LsL+VW4EaWCgqmTpAXMjCMDli65wQfY/QAKhqar387Or3G9O+JcleDS+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705415; c=relaxed/simple;
	bh=k2ZTSXkbreeSGSIlG8rK4tM65oAyxohT+aY/Zpn+8G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0WPySiBQFW8u0axJnqlmuK/TOpB0j2wK2JcNBoznaVs/FGu3UJm7gpRP0CD2btyl69l4Yarihpe2xy0VW+d959FJ/ocq3HEsbRDdm0gEsQ6DjWi58tfNK3UDaDQiWt2K2yhLzSHBy45EIRSj8TfuQbq/m4eDFxqkzr2cbuLz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmw1YwcG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmw1YwcG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2212222d4cdso68645ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 17:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740705413; x=1741310213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsPN2U4i/7+tuUpMneffNky/ZJwaVylxgwYzLMQe4ZE=;
        b=qmw1YwcGuj3z9gq/D3lvs/CqsoDWZgqe1NPwyz48gu9dfs1NjOWnhBTk2VWj7MLbIn
         g2c/VD+U8VUQDmel/Nm58RM2ziUD1CUFxWH6/WZfMUUg7I6QhxwTadDE763Oxk070TeM
         qLnOltgDdJhyXAFDBrONwl5J3xy6307HFLRRUuaOeiRoWae+XSgYAjIES7fd4l4Ainli
         YpaWe5qaZd2A4ViHiXsHdus7grgrMJ3Vfzua9n/pmoFDCex7pOph5E8jWfjy5RgbYkOM
         39oKARf7Whb02/Gle52cg4dANUf9/IonDLDZ3khnYamBoXxO1dPlPjOr03GJ8Cto2Ztg
         ZyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740705413; x=1741310213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsPN2U4i/7+tuUpMneffNky/ZJwaVylxgwYzLMQe4ZE=;
        b=d0mXCBX5TMGAH1SemcsxLbWbVY+hk9WkR7BZxk2HMeCAGxKcr1wZ5HYQQ8ckG/EhqE
         6TsysXY5Xhv0QnbexY9vcaXqzUdSHkiFu9aUlQ6lO7lV2cAKgTM71b/u/ko2pOTwzHs/
         S7MxVEOFi/ampjBuqwkJjuXKVW3QxwTPzX8flOrG7tQbqkJZasspcitKHt8UHY1pY4/i
         f3kwjpSb2UvcNzbGX1rlIfleS0K3rJI6OX1GPmPXa1t9KMs4U+9A9jrsymfI6C5rCJAk
         MXLozGC2H8R8gXivG6915KzeulViWgrDPg3yUn83lfDJ8mYCFUK2tmQ2a5uN1zJbmfZ1
         WC6w==
X-Forwarded-Encrypted: i=1; AJvYcCVwW+QQREDvYJD1+f0TrRyH1IbAjHYwzuPi3eKdtnLpsrOD5b/KG9pf9Dv4diLv03RVoFQMy2+DZochmq3PNye/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3eDd8PH+4chrIv8b5HNIzPLuam+GKjL7T1hTOFgMpPDPr9F7t
	IvFv1YR+dPtXzDHgKzQPTlOK38LYqQiQ/2x5LF8OY1GCuWCIPEjjyxA0IwINbpUUUH+6EbpkegQ
	yVdZTXM34VmRwDCVmMTMFg8qV/HGhOreNpFzD
X-Gm-Gg: ASbGncuk+DL5Nodna1P+TKXULv+oNJCrdb1giQMPB/1dPyEEa7LJpnh6Hj1vOjzWm3I
	ZJ5gjC4sfgZ2SBwIHLCfx5GyxpsQXJefC3hO5Dvk12pk8SeAjkpNjNxqzjR4XWyDem+R2F2EQyz
	UOkSZaOlkf
X-Google-Smtp-Source: AGHT+IGjsxqOFBcmRTJx0axfWN5ELYiIJ+SwJ4BMIK1X0w7I3rB0KIUrDWd5JBZC2HbVzjACEOoQt+oSTbTh5/687Ok=
X-Received: by 2002:a17:903:3289:b0:216:6ecd:8950 with SMTP id
 d9443c01a7336-2236cfcc5ddmr700695ad.19.1740705412715; Thu, 27 Feb 2025
 17:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227215455.30514-1-acme@kernel.org> <20250227215455.30514-2-acme@kernel.org>
 <CAP-5=fUqLyCt4=4XgoCjTkmeO4yrHTvEU1Hw48-+S3Szi20x5g@mail.gmail.com> <CA+JHD924rCBDbK1f_7=0c-Pp_tPj7vcXjaMFQdE_OB6CGOTtUQ@mail.gmail.com>
In-Reply-To: <CA+JHD924rCBDbK1f_7=0c-Pp_tPj7vcXjaMFQdE_OB6CGOTtUQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Feb 2025 17:16:41 -0800
X-Gm-Features: AQ5f1Jo1sBou9b_zfA8EYzFZ41xR0ry6ciD03c5EBxSXzdStx_d5NoIEqsQqDCU
Message-ID: <CAP-5=fUd_0Pf1ceo7LFws_HBNdOxkSJYMDrGrKLd1_CChu5NxQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] perf maps: Introduce map__set_kmap() for kernel maps
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 3:54=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Thu, Feb 27, 2025, 8:27=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>>
>> On Thu, Feb 27, 2025 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> >
>> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> >
>> > We need to set it in other places than __maps__insert(), so that we ca=
n
>> > have access to the 'struct kmap' from a kernel 'struct map'.
>> >
>> > When building perf with 'DEBUG=3D1' we can notice it failing a consist=
ency
>> > check done in the check_invariants() function:
>> >
>> >   root@number:~# perf record -- perf test -w offcpu
>> >   [ perf record: Woken up 1 times to write data ]
>> >   [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
>> >   perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=
=3D map__end(map)' failed.
>> >   Aborted (core dumped)
>> >   root@number:~#
>> >
>> > The investigation on that was happening bisected to 876e80cf83d10585
>> > ("perf tools: Fixup end address of modules"), and the following patche=
s
>> > will plug the problems found, this patch is just legwork on that
>> > direction.
>> >
>> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>> > Cc: Adrian Hunter <adrian.hunter@intel.com>
>> > Cc: Ian Rogers <irogers@google.com>
>> > Cc: Ingo Molnar <mingo@kernel.org>
>> > Cc: James Clark <james.clark@linaro.org>
>> > Cc: Jiri Olsa <jolsa@kernel.org>
>> > Cc: Kan Liang <kan.liang@linux.intel.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Stephane Eranian <eranian@google.com>
>> > Link: https://lore.kernel.org/lkml/Z74V0hZXrTLM6VIJ@x1
>> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> > ---
>> >  tools/perf/util/maps.c | 29 +++++++++++++++++++++--------
>> >  1 file changed, 21 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
>> > index 09c9cc326c08d435..e21d29f5df01c6f7 100644
>> > --- a/tools/perf/util/maps.c
>> > +++ b/tools/perf/util/maps.c
>> > @@ -428,11 +428,29 @@ static unsigned int maps__by_name_index(const st=
ruct maps *maps, const struct ma
>> >         return -1;
>> >  }
>> >
>> > +static void map__set_kmap(struct map *map, struct maps *maps)
>>
>> I'm not sure this is the right function name. The kmap is created when
>> the map is created, so perhaps `map__set_kmap_maps(..)` is more
>> accurate.
>>
>> Fwiw, kmap is:
>> ```
>> #define KMAP_NAME_LEN 256
>>
>> struct kmap {
>> struct ref_reloc_sym *ref_reloc_sym;
>> struct maps      *kmaps;
>> char      name[KMAP_NAME_LEN];
>> };
>> ```
>>
>> The name is pretty chunky, perhaps it should be a strdup-ed pointer.
>> ref_reloc_sym is used in the context of a machine, so perhaps there
>> should be a hashmap from map to ref_reloc_sym.
>> The kmaps variable seems to largely be unnecessary, things like
>> addr_location and map_symbol carry around a map and the associated
>> maps, so when kmaps is needed it was probably already one of the
>> arguments to the calling function and could have just been passed
>> through.
>> So I think there is a cleanup to:
>> 1) remove kmaps - just pass down an associated maps
>> 2) make ref_reloc_sym and name things looked up from a hashmap
>> 3) get rid of kmap altogether so that invariants don't need to be
>> maintained and issues like this shouldn't repeat.
>
>
> Can we work on these naming and further cleanups on top of this series?

The intention for the fwiw on the kmap stuff was to imply it is really
doing more than what this series does and can be follow up. The
function name is up to you and Namhyung as to whether it is worth
fixing in the series.

Thanks,
Ian
