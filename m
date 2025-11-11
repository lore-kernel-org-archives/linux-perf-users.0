Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2233468B
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881643; cv=none; b=TTG36ei45QkSTiWKpy8PCPtpclad/AUWehRpkWhImr1QVTX4YPLGLS1AVaaSzuv5uJuIRg3E5G0oqi9xH4CccjaNXe9ZB77mTSHqdj2vaDqEvaQu4KChnDJsFFMzcUJWFk12u5SRz0aSKE+3L9JWOeig9hAX2Dmw9DAWrkOpgtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881643; c=relaxed/simple;
	bh=Ea0HQtp76cFTkTjjNdFmHXQwralfHu7jRHZMlC1su5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qjd028sTiChpkCKFUDKqowRWHH+h/OZdTu9j0mhDDLXBvaq0cpjWe79igndj+9ygHVLgyu9Ajy0wc0yUGEhr+NXCogdhICsivMk4jgHfZJW7QdHu3dTaPOj3OR2HYL3vKVuXXfcCUXMkKTJzAK1oEqdwnz0bG7WtAdSnAoNV7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aT4r4y75; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aT4r4y75"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2980343d9d1so209155ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762881641; x=1763486441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuqiAU6njLQzvwMnm5NjR5NkcPrTa0+hIMlqeny7nRE=;
        b=aT4r4y75ft0fWihB8hGI/zSDV/YawRvf3P1BXTz6xi6XDWP7D4Qc4c/1D2ZQSArPg3
         0x+jcV7XcYc4qBppZFknY/z7OYgCNXxess5h4HNOjk6jnABEVwOSt5X/Gnc0iaVo9uFn
         HeWcj8fs3kavr9biOysDZl+ZhlGmB6p3jL2RkgKMfQYdZV04r87oWRwWBJJEbcVP3yGM
         Hh8MkigicP3I1aiZc0PwR4PAxWyECACX0ISkl06+XcNt33ZtOD0X3EaLo7w6yWOJcKiu
         Qaztq05FmBWFM2j67EKhNeFGegzDx2gZcIL36iYFUmNWt/24qc6RpRnp665ZZW1klliV
         9BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881641; x=1763486441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XuqiAU6njLQzvwMnm5NjR5NkcPrTa0+hIMlqeny7nRE=;
        b=MJMeQH60STWVVW8qaMoHub34xt3CkxktF7Y2fzmZqRCUHHz3MBXybKdF81U+7oQqRu
         u6TL17AvzM08kOd7Mw0ASj61pVGm+7Yvr8UxTxqVoY6xqWlzEFI9k/Eyso9pcRnmVbGW
         u4XdIqvPGnqzBK86+xL7RiGHeG8cg6Z1CdCrYjvIJTAZ6ohnnmq2TCSp/yHMn2E9S1xC
         bfILWqDkIIa/fl1skg2eE2tYkzqJRuiSAUUARloEKJO8SI+mRTAzgA5HPdh3jUItA0JO
         vg+8C9AUFEwF9njG5zgSefikiZ88vaG/wAJp5qQZ3+z7EBzBx4JOC/+f6uKzg3SxyM6n
         UaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv+2Laa5JIUTGpbcZmV6uQSQm/2CWyLl3hQBQK1Ih38mHx1KhBR1bRXJ1jqtWPFho74TyGiYCP8sB9Fu/p4xxb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UL2Qpzq8UbmG6sTbbH+IT0Ih+mSTIxuqmbP0v43iMxMuIZm7
	G7e0fN28v1kmrl2yL2wPFPEww+v8W/TlKveQA7OdpoMgoq+CRuxKj3k1/0ySKHJGSNYgzfccAcz
	37G8iaaUGCbXeQG1mnQ1iM3LrdKQEr+ukR/8UpBgA
X-Gm-Gg: ASbGnctfqWQ3cek0H7yJ0DXKF0OiKWruuKXNvDBZF6OP47LzrzpU1oUltrPwj3JujLb
	g80dwrOAFpAzM55ATb4nDJazrgjuHDA+KR5ATEU8DFIEe7WcqVGyYAgiRIyVLdph1gVbvBdcx+d
	IGj1CKFmjCS9gwT9xFbiz+j+JBywcog2//wik8FYAzqZ4wj1M4TISxCL0dZynrGj39EIh9KQC98
	TH6+rddRosPwuyjAPEhlT1fMV8K6bOT4+cahD52Yjd6+hL6aUiCK3WsPkoa8gVjll2sr0NR1Y6O
	ei5QZO+TWQbKBDTqBYSzlGMdxw==
X-Google-Smtp-Source: AGHT+IGgeWz4q3klBcad1a8/ik5ZTtMnoBglCnwh8mpt7C9cn98lgz2wrQSDRJJTFRt0RZ/9qtbKtxdCNTdhsCu6Gt4=
X-Received: by 2002:a17:903:246:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-29841580f6emr5676315ad.6.1762881641167; Tue, 11 Nov 2025
 09:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com> <20251111040417.270945-2-irogers@google.com>
 <e0d29714-df04-48f9-8168-770bf05a0f7f@linux.intel.com>
In-Reply-To: <e0d29714-df04-48f9-8168-770bf05a0f7f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 09:20:30 -0800
X-Gm-Features: AWmQ_blhqsdu0pEFBeuHgEMF4isl1j0ZSrqJNUNsNdjggBQgjZSDio6o-ThKEhs
Message-ID: <CAP-5=fWWxbRS4D1GsPvSgr32cfCGaT68qV0Q6-FLQ90R-bhH3w@mail.gmail.com>
Subject: Re: [PATCH v3 01/18] perf metricgroup: Add care to picking the evsel
 for displaying a metric
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Chun-Tse Shao <ctshao@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Collin Funk <collin.funk1@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:15=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 11/11/2025 12:04 PM, Ian Rogers wrote:
> > Rather than using the first evsel in the matched events, try to find
> > the least shared non-tool evsel. The aim is to pick the first evsel
> > that typifies the metric within the list of metrics.
> >
> > This addresses an issue where Default metric group metrics may lose
> > their counter value due to how the stat displaying hides counters for
> > default event/metric output.
> >
> > For a metricgroup like TopdownL1 on an Intel Alderlake the change is,
> > before there are 4 events with metrics:
> > ```
> > $ perf stat -M topdownL1 -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >      7,782,334,296      cpu_core/TOPDOWN.SLOTS/          #     10.4 %  =
tma_bad_speculation
> >                                                   #     19.7 %  tma_fro=
ntend_bound
> >      2,668,927,977      cpu_core/topdown-retiring/       #     35.7 %  =
tma_backend_bound
> >                                                   #     34.1 %  tma_ret=
iring
> >        803,623,987      cpu_core/topdown-bad-spec/
> >        167,514,386      cpu_core/topdown-heavy-ops/
> >      1,555,265,776      cpu_core/topdown-fe-bound/
> >      2,792,733,013      cpu_core/topdown-be-bound/
> >        279,769,310      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.2 %  =
tma_retiring
> >                                                   #     15.1 %  tma_bad=
_speculation
> >        457,917,232      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     38.4 %  =
tma_backend_bound
> >                                                   #     34.2 %  tma_fro=
ntend_bound
> >        783,519,226      cpu_atom/TOPDOWN_FE_BOUND.ALL/
> >         10,790,192      cpu_core/INT_MISC.UOP_DROPPING/
> >        879,845,633      cpu_atom/TOPDOWN_BE_BOUND.ALL/
> > ```
> >
> > After there are 6 events with metrics:
> > ```
> > $ perf stat -M topdownL1 -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >      2,377,551,258      cpu_core/TOPDOWN.SLOTS/          #      7.9 %  =
tma_bad_speculation
> >                                                   #     36.4 %  tma_fro=
ntend_bound
> >        480,791,142      cpu_core/topdown-retiring/       #     35.5 %  =
tma_backend_bound
> >        186,323,991      cpu_core/topdown-bad-spec/
> >         65,070,590      cpu_core/topdown-heavy-ops/      #     20.1 %  =
tma_retiring
> >        871,733,444      cpu_core/topdown-fe-bound/
> >        848,286,598      cpu_core/topdown-be-bound/
> >        260,936,456      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.4 %  =
tma_retiring
> >                                                   #     17.6 %  tma_bad=
_speculation
> >        419,576,513      cpu_atom/CPU_CLK_UNHALTED.CORE/
> >        797,132,597      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     38.0 %  =
tma_frontend_bound
> >          3,055,447      cpu_core/INT_MISC.UOP_DROPPING/
> >        671,014,164      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     32.0 %  =
tma_backend_bound
> > ```
>
> It looks the output of cpu_core and cpu_atom events are mixed together,
> like the "cpu_core/INT_MISC.UOP_DROPPING/". Could we resort the events an=
d
> separate the cpu_core and cpu_atom events output? It would make the outpu=
t
> more read-friendly. Thanks.

So the metrics are tagged as to not group the events:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=3Dperf-t=
ools-next#n117
Running with each metric causes the output to be:
```
$ perf stat -M tma_bad_speculation,tma_backend_bound,tma_frontend_bound,tma=
_retiring
-a sleep 1

 Performance counter stats for 'system wide':

     1,615,145,897      cpu_core/TOPDOWN.SLOTS/          #      8.1 %
tma_bad_speculation
                                                  #     42.5 %
tma_frontend_bound       (49.89%)
       243,037,087      cpu_core/topdown-retiring/       #     34.5 %
tma_backend_bound        (49.89%)
       129,341,306      cpu_core/topdown-bad-spec/
                         (49.89%)
         2,679,894      cpu_core/INT_MISC.UOP_DROPPING/
                         (49.89%)
       696,940,348      cpu_core/topdown-fe-bound/
                         (49.89%)
       563,319,011      cpu_core/topdown-be-bound/
                         (49.89%)
     1,795,034,847      cpu_core/slots/
                         (50.11%)
       262,140,961      cpu_core/topdown-retiring/
                         (50.11%)
        44,589,349      cpu_core/topdown-heavy-ops/      #     14.4 %
tma_retiring             (50.11%)
       160,987,341      cpu_core/topdown-bad-spec/
                         (50.11%)
       778,250,364      cpu_core/topdown-fe-bound/
                         (50.11%)
       622,499,674      cpu_core/topdown-be-bound/
                         (50.11%)
        90,849,750      cpu_atom/TOPDOWN_RETIRING.ALL/   #      8.1 %
tma_retiring
                                                  #     17.2 %
tma_bad_speculation
       223,878,243      cpu_atom/CPU_CLK_UNHALTED.CORE/
       423,068,733      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     37.8 %
tma_frontend_bound
       413,413,499      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     36.9 %
tma_backend_bound
```
so you can see that it is the effect of not grouping the events that
leads to the cpu_core and cpu_atom split.

The code that does sorting/fixing/adding of events, primarily to fix
topdown, is parse_events__sort_events_and_fix_groups:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2030
but I've tried to make that code respect the incoming evsel list order
because if a user specifies an order then they generally expect it to
be respected (unless invalid or because of topdown events). For
--metric-only the event order doesn't really matter.

Anyway, I think trying to fix this is out of scope for this patch
series, although I agree with you about the readability. The behavior
here matches old behavior such as:
```
$ perf --version
perf version 6.16.12
$ perf stat -M TopdownL1 -a sleep 1

 Performance counter stats for 'system wide':

    11,086,754,658      cpu_core/TOPDOWN.SLOTS/          #     27.1 %
tma_backend_bound
                                                  #      7.5 %
tma_bad_speculation
                                                  #     36.5 %
tma_frontend_bound
                                                  #     28.9 %
tma_retiring
     3,219,475,010      cpu_core/topdown-retiring/
       820,655,931      cpu_core/topdown-bad-spec/
       418,883,912      cpu_core/topdown-heavy-ops/
     4,082,884,459      cpu_core/topdown-fe-bound/
     3,012,532,414      cpu_core/topdown-be-bound/
     1,030,171,196      cpu_atom/TOPDOWN_RETIRING.ALL/   #     17.4 %
tma_retiring
                                                  #     16.5 %
tma_bad_speculation
     1,185,093,601      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     29.8 %
tma_backend_bound
                                                  #     36.4 %
tma_frontend_bound
     2,154,914,153      cpu_atom/TOPDOWN_FE_BOUND.ALL/
        14,988,684      cpu_core/INT_MISC.UOP_DROPPING/
     1,763,486,868      cpu_atom/TOPDOWN_BE_BOUND.ALL/

       1.004103365 seconds time elapsed
```
ie the cpu_core and cpu_atom mixing of events isn't a regression
introduced here. There isn't a simple fix for the ordering, as we
don't want to mess up the non-metric cases. I'm happy if you think
things can be otherwise to make a change.

Thanks,
Ian
