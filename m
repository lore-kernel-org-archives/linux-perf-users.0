Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA632EAB71
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762902830; cv=none; b=iAmqlVEuh0C9HI4T0Tyw6rNytut7AA1w4wtxaH4e7DZqtUMSbP8a8RmPbqZvA8uPtdTpm5bmAO1PJBOxx8iadBTmuh1qXFJjXZecBXayO6Op4D2pdP++RkdIrK0WBxtkxMnYH0i9v9cmH93LlpkTGGLyn8SHcPXM8YOKkfaR+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762902830; c=relaxed/simple;
	bh=D3nHvnswNl2mFX7uH9XG2igYiV0KobD/gncY0h/faRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG+Nd9V9ugBamEEJUhepsUeqXCbv4nfScZsJqY7I4EgeqywH1S53fJypJbnPkhB7vC8fKr3t5UUOQTNvMxw9bTZDxSTSjFw1lpMmskrbZ4oUkYazA8uwB3za9LIOKCRqIjjpdAsHnziRmCE9ItnqA2ujrSfKkHK7LAx7SgSz7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HiVs9RrG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HiVs9RrG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2959197b68eso31615ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 15:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762902826; x=1763507626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jyb7jTrSOVpf+8hcCRY+v5Ij2OnodQ2bmBqE93tS0Wg=;
        b=HiVs9RrGB1pW4D3sq7EfUj5aU0Y0llrIa4QNNASGrIVqnloEvE2hGL4zaD4olMDtJR
         hxXLcSjdZ35OZA+UifxhagxbBByvxi1XMpi8zcic7n2lmu+6wikjLT3Xwefxbjhizeu7
         NR6+NDaR5pTOqBNvc4jdSSq50c2eJS6N+lUIv0u5wgTi/XgiAMq481oJenoIMF2UC0b5
         ki6W2RWz1Y2WEMPDn75PfhkP/L6bHxqei88o3WJlyNFiGJMhLpQwfRlOP5SnElUqwwzz
         uwLPyWTRjV2kENYpeG91HzbgP3Lgx6zSOuSU7roSgJ23L2U76x/Z3FV9bv5jS/QKtDMr
         jRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762902826; x=1763507626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jyb7jTrSOVpf+8hcCRY+v5Ij2OnodQ2bmBqE93tS0Wg=;
        b=iCRjCzNaeXZEjMTeUVQr0W3+dS/4bJwldWYaCePeFwpje2zX7Ckhx0d581Hjfd+WQJ
         zvvlZJAWlsEX6BhE5S9VjPXF0Pvfm07t1SZMHDijtzAyZ8Al2s1/YpFuzF9xnZ7Au5r+
         9D6QIG4WV4JIzvNksQrshDG2oqd6ub0wrOrHURzJMYlbIdf/u39WhwN0Aqg8U5X4e0Ga
         doUt1qA7n/9H48k85iKXZYZs/y59Bd5SqJyLU8drak8Gt1rtKpCiSzCMF6N5bahycQO4
         ei5s74H7npZRChpelb7xkIpWsphEMIaHMlhNiqIedd/sR2VU50EDvl00z4O6or/tIKHc
         NWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXqH61zJ1RZaYlsObFZ5xjGh9AaFhfvhf/yeSR6Tn8XT9eh/sAN25QtVMk31wS+gr43Ck4uuO0+b1Gab9irF2T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77EQLxi82VfSr7U6LF91TtpC4/YQGiUnCWjisbRUOS84H5gsx
	zQL02M5BFYdG6zaDppzN9Dceob+fdo9mbQuCcWW1B4OS6+zhSoKQI9HTQP3wnVW3Lxk2vcLx43S
	0+sbRpDK4bVu77OQF2AXrHFXeMzVtVh3bSPS6UVYC
X-Gm-Gg: ASbGncuEY9WZ0IOWLS6Ul6ba7sIKn2Il8HC38sTSLPZLiSGJLjPa50Sil2MkHuTz5hz
	9IcxxET+WFGokBGv9AiKimv7LtW3HLdrWbnOjA6nAzFovfZG1Dyx7B9V7joEROTd2Wl4ioHLFBn
	YTPMVyT5yVoVlccRexMSy4ZtgozllaGJDhGelUeUaFEfbjL0dH0Z0sZtH3QVFDYEqcrqrPkeXiB
	pl/e1f79hOa5A2nuGM/7H+/i8syjMjR7W/eVx18V62suvBWlB/Dzgo5grsj+WrKque42mph9w6p
	5lP4ifM/u/8IxCtAo7cBWbmdI3C/F0ZeRXrW
X-Google-Smtp-Source: AGHT+IH88LhmPgv1ToEnVMYi84K94UoNk7mqTEjkK/eUCEP6+b0gVDlRLaN+U+Y2KjR26XuFA1ccDiNukUPk1sz/FAA=
X-Received: by 2002:a17:902:f68a:b0:298:4819:f4d9 with SMTP id
 d9443c01a7336-2984f837146mr1733205ad.8.1762902826247; Tue, 11 Nov 2025
 15:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com> <aRO7vPpfuH7vzRg-@google.com>
In-Reply-To: <aRO7vPpfuH7vzRg-@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 15:13:35 -0800
X-Gm-Features: AWmQ_bmqpyb6rV1PN134KWPSwr6yA5C8pcc50K9xXDgDf2h2TGx0zTwhem7yti0
Message-ID: <CAP-5=fWQqsAHZvyxu6db5Qyfx0n-2pNeYDP7u_WtpxKr2TLHxA@mail.gmail.com>
Subject: Re: [PATCH v4 00/18]
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
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

On Tue, Nov 11, 2025 at 2:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Nov 11, 2025 at 01:21:48PM -0800, Ian Rogers wrote:
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
> >        429,978,120      branches                         #     26.8 M/s=
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
> > work for me (I was testing `perf record -e instructions,cycles`
> > with/without leader sampling and then `perf script -F metric` but saw
> > nothing but empty lines) but anyway I decided to fix it to the best of
> > my ability in this series. So the script side counters were removed
> > and the regular ones associated with the evsel used. The json metrics
> > were all searched looking for ones that have a subset of events
> > matching those in the perf script session, and all metrics are
> > printed. This is kind of weird as the counters are being set by the
> > period of samples, but I carried the behavior forward. I suspect there
> > needs to be follow up work to make this better, but what is in the
> > series is superior to what is currently in the tree. Follow up work
> > could include finding metrics for the machine in the perf.data rather
> > than using the host, allowing multiple metrics even if the metric ids
> > of the events differ, fixing pre-existing `perf stat record/report`
> > issues, etc.
> >
> > There is a lot of stat tests that, for example, assume '-e
> > instructions,cycles' will produce an IPC metric. These things needed
> > tidying as now the metric must be explicitly asked for and when doing
> > this ones using software events were preferred to increase
> > compatibility. As the test updates were numerous they are distinct to
> > the patches updating the functionality causing periods in the series
> > where not all tests are passing. If this is undesirable the test fixes
> > can be squashed into the functionality updates, but this will be kind
> > of messy, especially as at some points in the series both the old
> > metrics and the new metrics will be displayed.
> >
> > v4: K/sec to M/sec on branch frequency (Namhyung), perf script -F
> >     metric to-done a system-wide calculation (Namhyung) and don't
> >     crash because of the CPU map index couldn't be found. Regenerate
> >     commit messages but the cpu-clock was always yielding 0 on my
> >     machine leading to a lot of nan metric values.
>
> This is strange.  The cpu-clock should not be 0 as long as you ran it.
> Do you think it's related to the scale unit change?  I tested v3 and
> didn't see the problem.

It looked like a kernel issue. The raw counts were 0 before being
scaled. All metrics always work on unscaled values. It is only the
commit messages and the formatting is more important than the numeric
values - which were correct for a cpu-clock of 0.

Thanks,
Ian
