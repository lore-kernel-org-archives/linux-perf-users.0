Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21125FA0A
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Nov 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189544; cv=none; b=AnlcYzagJXsbtm3BQuU76KMsxMHB+Q2XqDlPhkK/neBSoDMP+Oegtz4FcxsTjYdNeXaVFyee2tBmQi4OFkSsbym+lW4t0oBk3P366Ifr8kFzXLyDuhsEySwGBuRaYcgngpjaNJ5pot3mV7wHyQCFYiRQS4E3JK53lSzXf4xG87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189544; c=relaxed/simple;
	bh=Gtw8Ji0MiooGRLuhUMWiu8mUFCkokp2oJT0BpGYlqo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GRHqd/s3NmoFSCwqxNMHXg++xhkLWf3dJb+6/OvUZ5vpjIassi5P42Sj/JQU/P+hADgGrLUC9KHTU53wdOnzMH4FsDAXbtmDQmPIB3M1Ly9C6wr/txQP78pneOqDZr6s4OXaQz8srUP5BZfesdI6Yz4QqNWyIJrvlV6NPZpApvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNx9Wtrx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNx9Wtrx"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d67abd215so508245ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2025 09:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762189542; x=1762794342; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USUP+G8rxPZSNWnfCQ4g/UgmX4j5eyp+wl5nNOkjPO8=;
        b=PNx9Wtrx5/dOm43J+S8A1YAM9uDv7/b6BQc9hVsgckV/rwMobBaEHwImdtQTRkU/9B
         jU1xYVpdSo/hHrDAS3of5XTRd2GNvu55rAWK0O6BCN+P31/SatRr23LWYS3fPxBq0z2R
         BjYqS13VCzkuNU4h0FQiL+0ogVAzn7Cuo75dLT2arpX8qy5yDO315v70t/KaWVqV/v9m
         7thkz+nTFcqlPVWdrvcuM8wgh8SgtybxT4h9+LgVjHm2VoHIrYwwpHnrjQOffwIJJUK8
         c3DKvTCc4rX/Nt1uyap0knyQWKQgDc1SalUV1E4PF7+nSLoFY6j9Fhp5kfyHE8pMDnB/
         Az/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189542; x=1762794342;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USUP+G8rxPZSNWnfCQ4g/UgmX4j5eyp+wl5nNOkjPO8=;
        b=mhZoo//WTJ7EXFLIzscdsU8W6jXWMAd28cVhTXcaDHdmdj/OVdwitxWZuQ1IPO8klp
         LXBU7SZdQY5O6tzThP78GucWqdnYLAxt9Zam7pbBkCSLMc43PfsX7xUJO6eWlpP78I+A
         WNBemEXc3zvUQQ7u94zUG9TxTy+CZZGFfE1IIz6lW0Ld6XL7s/pj5H47GZSGwK6B/yVZ
         0XuHPrYdmGIH515WTGHeGH5oF5TVrkGCp/h2AgloLnfG/yzwnl0k4xlodlvXezHUBtSE
         OKJ7OCaLNzZ4qyEc75YkTd9/9IYvnqEJX9FFWLP0TdBFLjiZ7/k0HhpuWmWmRflzJlY5
         STJA==
X-Forwarded-Encrypted: i=1; AJvYcCX2tTV/+DJVn7TmhuMNJv60zLoJrrWIDaxwe/wq5KA30sYOq5i6GPPOCD67+FcpvA9OoyG5bHlMMmM6fhGzkWGl@vger.kernel.org
X-Gm-Message-State: AOJu0YytK353b0Uran6H9y4ScqbJMEkyMn86baQHoc5jkYPIoD1qYPbe
	gnxBvHWvRS6Ftw6TI07F9BH/x/kXidllLCP/yABtC6X9cntsxI6v2WBnC9IhqdzSzqGw8x7B2Ez
	9nA8rW0W731mbav+hoBG5MbO7jWxNLhAC3/QZdXTs
X-Gm-Gg: ASbGnctV7f0Y503H47RlZ5++MnBN0F8PuoQpnmVBn3uBohDnFx3jtD0WZF8ssdF8oeI
	4hOKNFbG5BoEiSMav/2eFM82eY3AgWhAvHWx7fxuZ/m4JjS1Ebr/s7MCXInqb3S/NNkMpr2QoZA
	epY16d2qxKgwikNwtxdeUrx9AN8xBeg3NHEDTHYXzi8zM5LDQt6mXM29AEl7K/81lFHF2Jl7vfw
	n7A8eqY2aFFeGemy0P/G31nRgv3rtnAHNzbP2DDxK4DXP3IYlK5nmA6CiI7RX3ykmxXa8sGCYeu
	8pCRxScIS3N9oo/rmTw78hCo0g==
X-Google-Smtp-Source: AGHT+IHUeJcXwth7WRuC/KtMXBd3AMpZZeAdXfIIk2Se/ptAhSSZ9BwxoPHztazmcH/OCEMedqk7rDIm4KTR0FQtNfA=
X-Received: by 2002:a17:902:ea11:b0:293:e5f:85c8 with SMTP id
 d9443c01a7336-295f8d2ed8fmr420065ad.9.1762189540911; Mon, 03 Nov 2025
 09:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com> <CAP-5=fUsK9+d0=f2RuTQBfooVZ6qTPZ=XQZ_z7DaH08FG6tV9w@mail.gmail.com>
In-Reply-To: <CAP-5=fUsK9+d0=f2RuTQBfooVZ6qTPZ=XQZ_z7DaH08FG6tV9w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 09:05:29 -0800
X-Gm-Features: AWmQ_bnCAOr91Os-HV-KKQ9l0h7G6XIzrQgrelPTuAef_aa802XCUTm0fnnNYA8
Message-ID: <CAP-5=fVd5OD2=hhfmGVLGXmnA6BbaSHkvOu5cAKOjV1UkUqxyw@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] Switch the default perf stat metrics to json
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:51=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Oct 24, 2025 at 10:59=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Prior to this series stat-shadow would produce hard coded metrics if
> > certain events appeared in the evlist. This series produces equivalent
> > json metrics and cleans up the consequences in tests and display
> > output. A before and after of the default display output on a
> > tigerlake is:
> >
> > Before:
> > ```
> > $ perf stat -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >     16,041,816,418      cpu-clock                        #   15.995 CPU=
s utilized
> >              5,749      context-switches                 #  358.376 /se=
c
> >                121      cpu-migrations                   #    7.543 /se=
c
> >              1,806      page-faults                      #  112.581 /se=
c
> >        825,965,204      instructions                     #    0.70  ins=
n per cycle
> >      1,180,799,101      cycles                           #    0.074 GHz
> >        168,945,109      branches                         #   10.532 M/s=
ec
> >          4,629,567      branch-misses                    #    2.74% of =
all branches
> >  #     30.2 %  tma_backend_bound
> >                                                   #      7.8 %  tma_bad=
_speculation
> >                                                   #     47.1 %  tma_fro=
ntend_bound
> >  #     14.9 %  tma_retiring
> > ```
> >
> > After:
> > ```
> > $ perf stat -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >              2,890      context-switches                 #    179.9 cs/=
sec  cs_per_second
> >     16,061,923,339      cpu-clock                        #     16.0 CPU=
s  CPUs_utilized
> >                 43      cpu-migrations                   #      2.7 mig=
rations/sec  migrations_per_second
> >              5,645      page-faults                      #    351.5 fau=
lts/sec  page_faults_per_second
> >          5,708,413      branch-misses                    #      1.4 %  =
branch_miss_rate         (88.83%)
> >        429,978,120      branches                         #     26.8 K/s=
ec  branch_frequency     (88.85%)
> >      1,626,915,897      cpu-cycles                       #      0.1 GHz=
  cycles_frequency       (88.84%)
> >      2,556,805,534      instructions                     #      1.5 ins=
tructions  insn_per_cycle  (88.86%)
> >                         TopdownL1                 #     20.1 %  tma_bac=
kend_bound
> >                                                   #     40.5 %  tma_bad=
_speculation      (88.90%)
> >                                                   #     17.2 %  tma_fro=
ntend_bound       (78.05%)
> >                                                   #     22.2 %  tma_ret=
iring             (88.89%)
> >
> >        1.002994394 seconds time elapsed
> > ```
> >
> > Having the metrics in json brings greater uniformity, allows events to
> > be shared by metrics, and it also allows descriptions like:
> > ```
> > $ perf list cs_per_second
> > ...
> >   cs_per_second
> >        [Context switches per CPU second]
> > ```
> >
> > A thorn in the side of doing this work was that the hard coded metrics
> > were used by perf script with '-F metric'. This functionality didn't
> > work for me (I was testing `perf record -e instructions,cycles` and
> > then `perf script -F metric` but saw nothing but empty lines) but
> > anyway I decided to fix it to the best of my ability in this
> > series. So the script side counters were removed and the regular ones
> > associated with the evsel used. The json metrics were all searched
> > looking for ones that have a subset of events matching those in the
> > perf script session, and all metrics are printed. This is kind of
> > weird as the counters are being set by the period of samples, but I
> > carried the behavior forward. I suspect there needs to be follow up
> > work to make this better, but what is in the series is superior to
> > what is currently in the tree. Follow up work could include finding
> > metrics for the machine in the perf.data rather than using the host,
> > allowing multiple metrics even if the metric ids of the events differ,
> > fixing pre-existing `perf stat record/report` issues, etc.
> >
> > There is a lot of stat tests that, for example, assume '-e
> > instructions,cycles' will produce an IPC metric. These things needed
> > tidying as now the metric must be explicitly asked for and when doing
> > this ones using software events were preferred to increase
> > compatibility. As the test updates were numerous they are distinct to
> > the patches updating the functionality causing periods in the series
> > where not all tests are passing. If this is undesirable the test fixes
> > can be squashed into the functionality updates.
>
> Hi,
>
> no comments on this series yet, please help! I'd like to land this
> work and then rebase the python generating metric work [1] on it. The
> metric generation work is largely independent of everything else but
> there are collisions in the json Makefile/Build files.

Just to also add that the default perf stat output in perf-tools-next
looks like this on an Alderlake:
```
$ perf stat -a sleep 1

Performance counter stats for 'system wide':

                0      cpu-clock                        #    0.000
CPUs utilized
           19,362      context-switches
              874      cpu-migrations
           10,194      page-faults
      633,489,938      cpu_atom/instructions/           #    0.69
insn per cycle              (87.25%)
    3,738,623,788      cpu_core/instructions/           #    2.05
insn per cycle
      923,779,727      cpu_atom/cycles/
                        (87.28%)
    1,821,165,755      cpu_core/cycles/
      102,969,608      cpu_atom/branches/
                        (87.41%)
      594,784,374      cpu_core/branches/
        4,376,709      cpu_atom/branch-misses/          #    4.25% of
all branches             (87.66%)
        7,886,194      cpu_core/branch-misses/          #    1.33% of
all branches
#     10.4 %  tma_bad_speculation
                                                 #     21.5 %
tma_frontend_bound
#     34.5 %  tma_backend_bound
                                                 #     33.5 %
tma_retiring
#     17.7 %  tma_bad_speculation
                                                 #     17.8 %
tma_retiring             (87.64%)
#     33.4 %  tma_backend_bound
                                                 #     31.1 %
tma_frontend_bound       (87.67%)

      1.004970242 seconds time elapsed
```
and this with the series:
```
$ perf stat -a sleep 1
 Performance counter stats for 'system wide':

            21,198      context-switches                 #      nan
cs/sec  cs_per_second
                 0      cpu-clock                        #      0.0
CPUs  CPUs_utilized
               989      cpu-migrations                   #      nan
migrations/sec  migrations_per_second
             6,642      page-faults                      #      nan
faults/sec  page_faults_per_second
         6,966,308      cpu_core/branch-misses/          #      1.3 %
branch_miss_rate
       517,064,969      cpu_core/branches/               #      nan
K/sec  branch_frequency
     1,602,405,292      cpu_core/cpu-cycles/             #      nan
GHz  cycles_frequency
     3,012,408,051      cpu_core/instructions/           #      1.9
instructions  insn_per_cycle
         4,727,342      cpu_atom/branch-misses/          #      4.8 %
branch_miss_rate         (49.79%)
        94,075,578      cpu_atom/branches/               #      nan
K/sec  branch_frequency     (50.14%)
       922,932,356      cpu_atom/cpu-cycles/             #      nan
GHz  cycles_frequency       (50.36%)
       513,356,622      cpu_atom/instructions/           #      0.6
instructions  insn_per_cycle  (50.36%)
             TopdownL1 (cpu_core)                 #     10.4 %
tma_bad_speculation
                                                  #     24.0 %
tma_frontend_bound
                                                  #     35.2 %
tma_backend_bound
                                                  #     30.4 %
tma_retiring
             TopdownL1 (cpu_atom)                 #     36.1 %
tma_backend_bound        (59.76%)
                                                  #     38.7 %
tma_frontend_bound       (59.57%)
                                                  #      8.8 %
tma_bad_speculation
                                                  #     16.4 %
tma_retiring             (59.57%)

       1.006937573 seconds time elapsed
```
That is the TopdownL1 default group name is missing in the current
tree, etc. So just fixing the default perf stat output would be a good
reason to land this. The also broken output at the top is from a
tigerlake non-hybrid system.

Thanks,
Ian

> [1]
> * Foundations: https://lore.kernel.org/lkml/20240228175617.4049201-1-irog=
ers@google.com/
> * AMD: https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@goog=
le.com/
> * Intel: https://lore.kernel.org/lkml/20240229001806.4158429-1-irogers@go=
ogle.com/
> * ARM: https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@goog=
le.com/
