Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E7A35
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896512; cv=none; b=XTBgAbyzz9i4YNGkVFmBN/5kyhT8Wnj6nJyKW5tU/PX0b9YuY4VUcfI4y8epSdGt4MzlBjr5fZgcsdPCivTJtBhxDaIFwEj23teBv1eZ1d44KJTHcK/sjeu7U1PYy1Kqps2WYqIPzo/3Ccn+HSPomEgUxehB6Jyo2RGYAMC+aXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896512; c=relaxed/simple;
	bh=L4ekNnZJBJQCdBiJrurgbWZbl+dv+0cR5wcH0ZLHdLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUjYP3GPu0NcmIggdDgYxPvsq/3lHTQc8q6ibBHEvQd2kGIWxIT7Ty6tUllc+GD+iQx6L0zJvo6ExdHqygmQO78jCysMxWv+K1hgD4QdIiGiwDK8ZfKBPxBM7UK8dta8g5TbsO2BrpVQRjti+rVEzYlquzZmBFk3W7ifem8LkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClVEhYFk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClVEhYFk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1deddb82b43so85105ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Mar 2024 18:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710896510; x=1711501310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpWW1bFpJVMD3sRuOnLO32nSb544c3j1m+DkhHID8gY=;
        b=ClVEhYFkllBHJofQCDU3EklbyGkkqW2MaM+Zk3rcANnre4Wl/L5jTZd6FJ3RNx1qMx
         QhfA52vAXxFYSwDQZZApIlKPkHBZTfccEUUAcv8ulQOxDo/uljlt4+3hna8SwSncXCjj
         RNiET2A+7YfEz+fNTjI31SKjEU31LTzcuBG7r8TGX4KTrv5AUguIql/AJNfPKX0hHDvM
         QpdB+mIoH+6nJ3uMEVaIQgg/drGXVVQYA25v/N4GVXTHJKFaXy3I8PmvFcYuXIjlbjQs
         Rqfa9FLApSfLyFKQEBy9iyW/KJk3Etlndav4bf/LuNiBRbOgGttNi8svJzCJlAZaVUPS
         uALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710896510; x=1711501310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpWW1bFpJVMD3sRuOnLO32nSb544c3j1m+DkhHID8gY=;
        b=eUtCEohNM+cu2lWQiiYdSpOASYRa/AEAjrfUKNnY7zJtMs+z/3FsuB/WIc9ZULkHh6
         M9qU6zJwOk6P1e7hYmZ4t3/ZrzC4zl1BahLv5KMnfd1zIzooMQxRdl0z1RLso6e6DW17
         GHxmUcGUPaUwIkrJSLSHdPIZ2FHw9s5q4jkPjAlQreFabSXKboRWAqkaOGp6Xcq+9TBV
         2uy9wj7AV40G6IGU/i/iXkZVNNo0+mExKj+p30rMWdaMxfo6bW25cJz53w9FIvqloBdM
         /BfCbe5dKSoSe13h7Af7vhhAJyYmWcDmXqARNBnn8Fi862PNHXTmQUubRl8QIpod7wJJ
         t3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqLXXaFJEqCv0vzMjmEHmOh3d9w1pgUiMrSnLfirjkuJRR3HjLsGUbMPNuZAS1E9X5fcdlb3WEHSe4jVKcEMzuuH9Z7Bx17hn4V7sBl96Y0w==
X-Gm-Message-State: AOJu0YzEVE73TNhWEsQiAbE6aL9eQfxOfJWPP+K+EHAl7hLZqF2w4RoP
	wcg/7T3hzDiYPXRBBmCcWEo6B+3+NRb2Xyk2JIIASosU88bn79d2lxXlTC35dQCYmUcwaJl+UxH
	ji/U/2r89/3v++2IKoiZJT2CRVnHmv4VWMNX6
X-Google-Smtp-Source: AGHT+IG+L+f/SBk0W3esZ49IqdSRTH4MYcpaA1eBHDFF2MNr4SueBl3e/hceRKoL5PYiMH96Ek0i1g0Yqc1MG4JOGGc=
X-Received: by 2002:a17:902:e5cd:b0:1de:fbe1:beb1 with SMTP id
 u13-20020a170902e5cd00b001defbe1beb1mr80891plf.7.1710896510100; Tue, 19 Mar
 2024 18:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com> <89249fc5-6102-45d4-9345-5dd80d06e001@linux.intel.com>
 <CAP-5=fWGhZHnsBWo4=+9PdfaAPNEnx7u40G+BHAWR+4rPC2Udw@mail.gmail.com>
In-Reply-To: <CAP-5=fWGhZHnsBWo4=+9PdfaAPNEnx7u40G+BHAWR+4rPC2Udw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 18:01:35 -0700
Message-ID: <CAP-5=fXXACwattr9fEcmxoDfGNNi8zmzrDUc8RjUtuX5sV4M9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Extra verbose/perf-list details
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:34=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Mar 8, 2024 at 7:39=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>>
>>
>>
>> On 2024-03-07 7:19 p.m., Ian Rogers wrote:
>> > Add more encoding detail and raw event details in perf list. Add PMU
>> > name and reverse lookup from config to event name to
>> > perf_event_attr_fprintf. This makes the verbose output easier to read,
>> > and the perf list information more specific.
>> >
>> > v3. Fix to reverse lookup to ensure or aliases are loaded and if
>> >     getting the config value fails for an event/alias just continue to
>> >     the next one.
>> > v2. Address feedback from Kan Liang, "Raw hardware event descriptor"
>> >     becomes "Raw event descriptor" add assert to keep term numbers in
>> >     sync, fix a commit message.
>> >
>> > Ian Rogers (6):
>> >   perf list: Add tracepoint encoding to detailed output
>> >   perf pmu: Drop "default_core" from alias names
>> >   perf list: Allow wordwrap to wrap on commas
>> >   perf list: Give more details about raw event encodings
>> >   perf tools: Use pmus to describe type from attribute
>> >   perf tools: Add/use PMU reverse lookup from config to name
>>
>> The patch series look good to me.
>> I verified it on a hybrid machine. The new format is the same as the
>> advertise.
>>
>> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Ping.

Thanks,
Ian

>
> Thanks Kan! Just to add another feature of perf_event_attr_fprintf change=
s is that it shows up in perf trace output:
>
> ```
> $ perf trace -e perf_event_open perf stat -e data_read true
>      0.000 ( 0.011 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
4 (uncore_imc_free_running_0), size: 136, config: 0x20ff (unc_mc0_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1, exclude_guest: 1 }, pid: -1, group_=
fd: -1, flags: FD_CLOEXEC) =3D -1 EINVAL (Invalid argument)
>      0.014 ( 0.002 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
4 (uncore_imc_free_running_0), size: 136, config: 0x20ff (unc_mc0_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1, exclude_guest: 1 }, pid: -1, group_=
fd: -1) =3D -1 EINVAL (Invalid argument)
>      0.020 ( 0.008 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
4 (uncore_imc_free_running_0), size: 136, config: 0x20ff (unc_mc0_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, group_fd: -1) =3D 8
>      0.031 ( 0.006 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
5 (uncore_imc_free_running_1), size: 136, config: 0x20ff (unc_mc1_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1, exclude_guest: 1 }, pid: -1, group_=
fd: -1) =3D -1 EINVAL (Invalid argument)
>      0.044 ( 0.004 ms): :36857/36857 perf_event_open(attr_uptr: { type: 2=
5 (uncore_imc_free_running_1), size: 136, config: 0x20ff (unc_mc1_rdcas_cou=
nt_freerun), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, group_fd: -1) =3D 9
>
>  Performance counter stats for 'system wide':
>
>               5.07 MiB  data_read
>
>        0.001178187 seconds time elapsed
> ```
>
> Thanks,
> Ian
>
>>
>> Thanks,
>> Kan
>> >
>> >  tools/perf/builtin-list.c                 | 21 ++++-
>> >  tools/perf/util/perf_event_attr_fprintf.c | 26 +++++--
>> >  tools/perf/util/pmu.c                     | 82 +++++++++++++++++++-
>> >  tools/perf/util/pmu.h                     |  4 +
>> >  tools/perf/util/pmus.c                    | 94 ++++++++++++++++++++++=
+
>> >  tools/perf/util/pmus.h                    |  1 +
>> >  tools/perf/util/print-events.c            | 55 +++++++------
>> >  7 files changed, 242 insertions(+), 41 deletions(-)
>> >
