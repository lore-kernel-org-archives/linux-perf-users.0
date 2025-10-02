Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EE242D83
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427940; cv=none; b=ZVm8aFkYig7E1qU4pDt8HR7P3Lqz1ktO01g3eF1U26QuBJJ3SLiASSU2bAn78VprhwQxRiTHUuV5Say8AHyoof4Z+3ROA4vgZRaqPVyjPCRWCeg6cAXyNhqeewMAfbOuk+Pko21ngoiIA3zAVczehlQemmXxBEQdldKF0qzm1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427940; c=relaxed/simple;
	bh=lxlDkedrz9oqpXqARGQmT+dhJdzWmgzp43fklQ5+Hcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8x4dRqMKCycA1QpTT4j+lXHc9ivuRDHdh1t41yc9aU/QM8kCobXko0aarHlcHtbDt8PqkfU+CJ37oYGxcJpONl0Ec7c+tMKZ7YMfsg6aXI/wUBcMYzo30dzIT5yiDX+nqBdrH1zE76swBSXggKGrlNVYaR4gSlAAg9HYGrTFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eh403pUp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eh403pUp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2731ff54949so17785ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759427937; x=1760032737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2HuMX23oR1ybmj3EOnbxuhO7pKjmQOHAtr9QbVF37g=;
        b=eh403pUpxBRrkUbZwHMl9cHZFFZR+TnPK3rShN4rY//86DzENnQL7X7rEWuHS8i4F8
         bbBtFYOVXc/vz09jWzuGLWQwndG0Kk5r0vD4zwBdClO/QyBbxHq6OKaB32IYuRqxSLFT
         1KJ5P+PeyPXNxnHw91mxIgvNQk9AXdnEAGb00AlOtXre0dRl6wNLnZKlTYZHwDYGY0hG
         mFoo9CbYcqSf7zIHN9avqyZFWFL5CyHkp4iugM5KwySLwCCLY09wokyVWpAd/ePpgn/f
         5tyTql3RtFmboqiK0kxD/2+xijupxgpWa2xYgqDQ3NXu1CU3kVTncHEtD3NHSxlu7KgK
         ToEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759427937; x=1760032737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2HuMX23oR1ybmj3EOnbxuhO7pKjmQOHAtr9QbVF37g=;
        b=M5YSeIpDkkdwVNPHFF2Dv2GWwOoY/4bW8quQQSYfNRJbebfQvA1U1bxBV3+6ESwVoA
         F/pz0ZP0LfPspQP5i0McvdOuVXYkDl8LejeQvEfBg7bEXY6rZCX5P3WpA3ZYg7YeVsvJ
         gy1SyDSQWL0Yny+oa2SDKQ/1+s+0nMOEC/vU2GVcNDMamTdV02djUJIM8ty0wCH1zkKH
         24rvP+MOGdNWZ+TYKF6A2FaP3tmpBrzUH/4ZPEPFOQ9oCJOuI72qmMUdc4W0YlKJ3rpd
         Qz37f0g6QcJlQMs0sFKWKiE0+BVc9XGQpcL3L5O6iYZvNJqDxQq9QmK5ygEgMfi/vVWJ
         cMMA==
X-Forwarded-Encrypted: i=1; AJvYcCV+kd30siw9uanFVjZ3KyClID7DQTgfaQYRJTEIyVK6rq92tKBS/QZWYhy0o2gqcLkbt13K+gqf2LNRjnsygpfI@vger.kernel.org
X-Gm-Message-State: AOJu0YyJefInk+q0kAWIJnY35KuJEkhkcYZdVSONJ0qMs5ZnOWMtGq1h
	7FEl4ASwwS7T8i1dbgme0GgXO4MENldfAX0iy7dSgT4mSpEPL2wGpYImrI/md9mFJ+RwfhiNpHq
	iuoa5L1xTtHxjQ6qCKe4WIQEtD8msg7qjGez6ec9u
X-Gm-Gg: ASbGncucyxOqGf8uFHT9aMMqM+rd2wg80cEANVpxwzjJCkakL5fgdc52HuS7Yii9iRo
	TpX6uf+lyq6rk1vzhKRTNS/r/F4sVRpoRsMigglWKDSfCYcn+ap5fGWZJeMemTW7y+obf1LLQUj
	n4pdiFBYnEkehDcqhJv+r82tKvkSsYIuEekNiUzlMXySDCN20uzMkrKW3ljHiMKP3jr3y7nHSfB
	3naFZrqxpROAsljB2Rv3dP6VCJmTf0u3g9402v7/W85SPaAWVfehjm/uR6zY/LzAPzX
X-Google-Smtp-Source: AGHT+IHabVtNRWx3bvqwXu4AGUhOq1y1Fl1YL328p+pqCrpBDgz/v10zNkzI5+7hkn2rtvbN2kChyAV4K7Zc7N1hMOI=
X-Received: by 2002:a17:902:d552:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-28e9a72a006mr162995ad.9.1759427936547; Thu, 02 Oct 2025
 10:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com> <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
 <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
 <CAP-5=fWUVycpDss_+MNQ_DM93AYKWED8aYOUBKLziYTOn68QJA@mail.gmail.com>
 <cf050a7f-b341-4e14-bc46-8bd30e366b19@linaro.org> <CAP-5=fW_WfAzb=qm+AnA-xSn8MOHjmTMcpEvXB6uVi+0Cr0=fg@mail.gmail.com>
In-Reply-To: <CAP-5=fW_WfAzb=qm+AnA-xSn8MOHjmTMcpEvXB6uVi+0Cr0=fg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 10:58:44 -0700
X-Gm-Features: AS18NWBckJLbAzlr6nfgv_4kPA8J2sMAF-0lEYPzPKCzUhxa-X6u5pNZfaA-MQQ
Message-ID: <CAP-5=fV0Qqi1m72-7us9rw7K3hbh05fAzutVtcazY7iTu3g3+w@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:46=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Oct 2, 2025 at 7:05=E2=80=AFAM James Clark <james.clark@linaro.or=
g> wrote:
> >
> > On 01/10/2025 9:55 pm, Ian Rogers wrote:
> > > On Wed, Oct 1, 2025 at 8:12=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >>
> > >> On Wed, Oct 1, 2025 at 6:38=E2=80=AFAM James Clark <james.clark@lina=
ro.org> wrote:
> > >>>
> > >>> On 23/09/2025 11:32 pm, Ian Rogers wrote:
> > >>>> Mirroring similar work for software events in commit 6e9fa4131abb
> > >>>> ("perf parse-events: Remove non-json software events"). These chan=
ges
> > >>>> migrate the legacy hardware and cache events to json.  With no har=
d
> > >>>> coded legacy hardware or cache events the wild card, case
> > >>>> insensitivity, etc. is consistent for events. This does, however, =
mean
> > >>>> events like cycles will wild card against all PMUs. A change doing=
 the
> > >>>> same was originally posted and merged from:
> > >>>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.=
com
> > >>>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> > >>>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due=
 to
> > >>>> his dislike for the cycles behavior on ARM with perf record. Earli=
er
> > >>>> patches in this series make perf record event opening failures
> > >>>> non-fatal and hide the cycles event's failure to open on ARM in pe=
rf
> > >>>> record, so it is expected the behavior will now be transparent in =
perf
> > >>>> record on ARM. perf stat with a cycles event will wildcard open th=
e
> > >>>> event on all PMUs, however, with default events the cycles event w=
ill
> > >>>> only be opened on core PMUs.
> > >>>>
> > >>>> The key motivation for these patches is so that if, for example, y=
ou
> > >>>> run `perf stat -e cpu-cycles ...` on a hybrid x86 and the results =
are
> > >>>> printed out with "cpu_core/cpu-cycles/" and "cpu_atom/cpu-cycles/"=
,
> > >>>> the perf_event_attr for cpu-cycles and cpu_core/cpu-cycles/ be the
> > >>>> same, similarly for the cpu_atom event. Prior to these patches the
> > >>>> event with a PMU prefers sysfs/json over legacy encodings while wi=
th
> > >>>> no PMU legacy encodings are preferred - these are different encodi=
ngs
> > >>>> on x86.
> > >>>>
> > >>>> The change to support legacy events with PMUs was done to clean up
> > >>>> Intel's hybrid PMU implementation. Having sysfs/json events with
> > >>>> increased priority to legacy was requested by Mark Rutland
> > >>>>    <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken leg=
acy
> > >>>> events on that PMU. It is believed the PMU driver is now fixed, bu=
t
> > >>>> this has only been confirmed on ARM Juno boards. It was requested =
that
> > >>>> RISC-V be able to add events to the perf tool json so the PMU driv=
er
> > >>>> didn't need to map legacy events to config encodings:
> > >>>> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivos=
inc.com/
> > >>>> This patch series achieves this.
> > >>>>
> > >>>> A previous series of patches decreasing legacy hardware event
> > >>>> priorities was posted in:
> > >>>> https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@googl=
e.com/
> > >>>> Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
> > >>>> software events can be implemented similarly:
> > >>>> https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
> > >>>> and this patch series achieves this.
> > >>>>
> > >>>> Note, patch 2 (perf parse-events: Fix legacy cache events if event=
 is
> > >>>> duplicated in a PMU) fixes a function deleted by patch 17 (perf
> > >>>> parse-events: Remove hard coded legacy hardware and cache
> > >>>> parsing). Adding the json exposed an issue when legacy cache (not
> > >>>> legacy hardware) and sysfs/json events exist. The fix is necessary=
 to
> > >>>> keep tests passing through the series. It is also posted for backp=
orts
> > >>>> to stable trees.
> > >>>>
> > >>>> The perf list behavior includes a lot more information and events.=
 The
> > >>>> before behavior on a hybrid alderlake is:
> > >>>> ```
> > >>>> $ perf list hw
> > >>>>
> > >>>> List of pre-defined events (to be used in -e or -M):
> > >>>>
> > >>>>     branch-instructions OR branches                    [Hardware e=
vent]
> > >>>>     branch-misses                                      [Hardware e=
vent]
> > >>>>     bus-cycles                                         [Hardware e=
vent]
> > >>>>     cache-misses                                       [Hardware e=
vent]
> > >>>>     cache-references                                   [Hardware e=
vent]
> > >>>>     cpu-cycles OR cycles                               [Hardware e=
vent]
> > >>>>     instructions                                       [Hardware e=
vent]
> > >>>>     ref-cycles                                         [Hardware e=
vent]
> > >>>> $ perf list hwcache
> > >>>>
> > >>>> List of pre-defined events (to be used in -e or -M):
> > >>>>
> > >>>>
> > >>>> cache:
> > >>>>     L1-dcache-loads OR cpu_atom/L1-dcache-loads/
> > >>>>     L1-dcache-stores OR cpu_atom/L1-dcache-stores/
> > >>>>     L1-icache-loads OR cpu_atom/L1-icache-loads/
> > >>>>     L1-icache-load-misses OR cpu_atom/L1-icache-load-misses/
> > >>>>     LLC-loads OR cpu_atom/LLC-loads/
> > >>>>     LLC-load-misses OR cpu_atom/LLC-load-misses/
> > >>>>     LLC-stores OR cpu_atom/LLC-stores/
> > >>>>     LLC-store-misses OR cpu_atom/LLC-store-misses/
> > >>>>     dTLB-loads OR cpu_atom/dTLB-loads/
> > >>>>     dTLB-load-misses OR cpu_atom/dTLB-load-misses/
> > >>>>     dTLB-stores OR cpu_atom/dTLB-stores/
> > >>>>     dTLB-store-misses OR cpu_atom/dTLB-store-misses/
> > >>>>     iTLB-load-misses OR cpu_atom/iTLB-load-misses/
> > >>>>     branch-loads OR cpu_atom/branch-loads/
> > >>>>     branch-load-misses OR cpu_atom/branch-load-misses/
> > >>>>     L1-dcache-loads OR cpu_core/L1-dcache-loads/
> > >>>>     L1-dcache-load-misses OR cpu_core/L1-dcache-load-misses/
> > >>>>     L1-dcache-stores OR cpu_core/L1-dcache-stores/
> > >>>>     L1-icache-load-misses OR cpu_core/L1-icache-load-misses/
> > >>>>     LLC-loads OR cpu_core/LLC-loads/
> > >>>>     LLC-load-misses OR cpu_core/LLC-load-misses/
> > >>>>     LLC-stores OR cpu_core/LLC-stores/
> > >>>>     LLC-store-misses OR cpu_core/LLC-store-misses/
> > >>>>     dTLB-loads OR cpu_core/dTLB-loads/
> > >>>>     dTLB-load-misses OR cpu_core/dTLB-load-misses/
> > >>>>     dTLB-stores OR cpu_core/dTLB-stores/
> > >>>>     dTLB-store-misses OR cpu_core/dTLB-store-misses/
> > >>>>     iTLB-load-misses OR cpu_core/iTLB-load-misses/
> > >>>>     branch-loads OR cpu_core/branch-loads/
> > >>>>     branch-load-misses OR cpu_core/branch-load-misses/
> > >>>>     node-loads OR cpu_core/node-loads/
> > >>>>     node-load-misses OR cpu_core/node-load-misses/
> > >>>> ```
> > >>>> and after it is:
> > >>>> ```
> > >>>> $ perf list hw
> > >>>>
> > >>>> legacy hardware:
> > >>>>     branch-instructions
> > >>>>          [Retired branch instructions [This event is an alias of b=
ranches].
> > >>>>           Unit: cpu_atom]
> > >>>>     branch-misses
> > >>>>          [Mispredicted branch instructions. Unit: cpu_atom]
> > >>>>     branches
> > >>>>          [Retired branch instructions [This event is an alias of
> > >>>>           branch-instructions]. Unit: cpu_atom]
> > >>>>     bus-cycles
> > >>>>          [Bus cycles,which can be different from total cycles. Uni=
t: cpu_atom]
> > >>>>     cache-misses
> > >>>>          [Cache misses. Usually this indicates Last Level Cache mi=
sses; this is
> > >>>>           intended to be used in conjunction with the
> > >>>>           PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache =
miss rates.
> > >>>>           Unit: cpu_atom]
> > >>>>     cache-references
> > >>>>          [Cache accesses. Usually this indicates Last Level Cache =
accesses but
> > >>>>           this may vary depending on your CPU. This may include pr=
efetches and
> > >>>>           coherency messages; again this depends on the design of =
your CPU.
> > >>>>           Unit: cpu_atom]
> > >>>>     cpu-cycles
> > >>>>          [Total cycles. Be wary of what happens during CPU frequen=
cy scaling
> > >>>>           [This event is an alias of cycles]. Unit: cpu_atom]
> > >>>>     cycles
> > >>>>          [Total cycles. Be wary of what happens during CPU frequen=
cy scaling
> > >>>>           [This event is an alias of cpu-cycles]. Unit: cpu_atom]
> > >>>>     instructions
> > >>>>          [Retired instructions. Be careful,these can be affected b=
y various
> > >>>>           issues,most notably hardware interrupt counts. Unit: cpu=
_atom]
> > >>>>     ref-cycles
> > >>>>          [Total cycles; not affected by CPU frequency scaling. Uni=
t: cpu_atom]
> > >>>>     branch-instructions
> > >>>>          [Retired branch instructions [This event is an alias of b=
ranches].
> > >>>>           Unit: cpu_core]
> > >>>>     branch-misses
> > >>>>          [Mispredicted branch instructions. Unit: cpu_core]
> > >>>>     branches
> > >>>>          [Retired branch instructions [This event is an alias of
> > >>>>           branch-instructions]. Unit: cpu_core]
> > >>>>     bus-cycles
> > >>>>          [Bus cycles,which can be different from total cycles. Uni=
t: cpu_core]
> > >>>>     cache-misses
> > >>>>          [Cache misses. Usually this indicates Last Level Cache mi=
sses; this is
> > >>>>           intended to be used in conjunction with the
> > >>>>           PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache =
miss rates.
> > >>>>           Unit: cpu_core]
> > >>>>     cache-references
> > >>>>          [Cache accesses. Usually this indicates Last Level Cache =
accesses but
> > >>>>           this may vary depending on your CPU. This may include pr=
efetches and
> > >>>>           coherency messages; again this depends on the design of =
your CPU.
> > >>>>           Unit: cpu_core]
> > >>>>     cpu-cycles
> > >>>>          [Total cycles. Be wary of what happens during CPU frequen=
cy scaling
> > >>>>           [This event is an alias of cycles]. Unit: cpu_core]
> > >>>>     cycles
> > >>>>          [Total cycles. Be wary of what happens during CPU frequen=
cy scaling
> > >>>>           [This event is an alias of cpu-cycles]. Unit: cpu_core]
> > >>>>     instructions
> > >>>>          [Retired instructions. Be careful,these can be affected b=
y various
> > >>>>           issues,most notably hardware interrupt counts. Unit: cpu=
_core]
> > >>>>     ref-cycles
> > >>>>          [Total cycles; not affected by CPU frequency scaling. Uni=
t: cpu_core]
> > >>>> $ perf list hwcache
> > >>>>
> > >>>> legacy cache:
> > >>>>     branch-load-misses
> > >>>>          [Branch prediction unit read misses. Unit: cpu_atom]
> > >>>>     branch-loads
> > >>>>          [Branch prediction unit read accesses. Unit: cpu_atom]
> > >>>>     dtlb-load-misses
> > >>>>          [Data TLB read misses. Unit: cpu_atom]
> > >>>>     dtlb-loads
> > >>>>          [Data TLB read accesses. Unit: cpu_atom]
> > >>>>     dtlb-store-misses
> > >>>>          [Data TLB write misses. Unit: cpu_atom]
> > >>>>     dtlb-stores
> > >>>>          [Data TLB write accesses. Unit: cpu_atom]
> > >>>>     itlb-load-misses
> > >>>>          [Instruction TLB read misses. Unit: cpu_atom]
> > >>>>     l1-dcache-loads
> > >>>>          [Level 1 data cache read accesses. Unit: cpu_atom]
> > >>>>     l1-dcache-stores
> > >>>>          [Level 1 data cache write accesses. Unit: cpu_atom]
> > >>>>     l1-icache-load-misses
> > >>>>          [Level 1 instruction cache read misses. Unit: cpu_atom]
> > >>>>     l1-icache-loads
> > >>>>          [Level 1 instruction cache read accesses. Unit: cpu_atom]
> > >>>>     llc-load-misses
> > >>>>          [Last level cache read misses. Unit: cpu_atom]
> > >>>>     llc-loads
> > >>>>          [Last level cache read accesses. Unit: cpu_atom]
> > >>>>     llc-store-misses
> > >>>>          [Last level cache write misses. Unit: cpu_atom]
> > >>>>     llc-stores
> > >>>>          [Last level cache write accesses. Unit: cpu_atom]
> > >>>>     branch-load-misses
> > >>>>          [Branch prediction unit read misses. Unit: cpu_core]
> > >>>>     branch-loads
> > >>>>          [Branch prediction unit read accesses. Unit: cpu_core]
> > >>>>     dtlb-load-misses
> > >>>>          [Data TLB read misses. Unit: cpu_core]
> > >>>>     dtlb-loads
> > >>>>          [Data TLB read accesses. Unit: cpu_core]
> > >>>>     dtlb-store-misses
> > >>>>          [Data TLB write misses. Unit: cpu_core]
> > >>>>     dtlb-stores
> > >>>>          [Data TLB write accesses. Unit: cpu_core]
> > >>>>     itlb-load-misses
> > >>>>          [Instruction TLB read misses. Unit: cpu_core]
> > >>>>     l1-dcache-load-misses
> > >>>>          [Level 1 data cache read misses. Unit: cpu_core]
> > >>>>     l1-dcache-loads
> > >>>>          [Level 1 data cache read accesses. Unit: cpu_core]
> > >>>>     l1-dcache-stores
> > >>>>          [Level 1 data cache write accesses. Unit: cpu_core]
> > >>>>     l1-icache-load-misses
> > >>>>          [Level 1 instruction cache read misses. Unit: cpu_core]
> > >>>>     llc-load-misses
> > >>>>          [Last level cache read misses. Unit: cpu_core]
> > >>>>     llc-loads
> > >>>>          [Last level cache read accesses. Unit: cpu_core]
> > >>>>     llc-store-misses
> > >>>>          [Last level cache write misses. Unit: cpu_core]
> > >>>>     llc-stores
> > >>>>          [Last level cache write accesses. Unit: cpu_core]
> > >>>>     node-load-misses
> > >>>>          [Local memory read misses. Unit: cpu_core]
> > >>>>     node-loads
> > >>>>          [Local memory read accesses. Unit: cpu_core]
> > >>>> ```
> > >>>>
> > >>>> v6. Fix x86 hybrid mismatched number of evsels for the case a PMU =
is
> > >>>>       specified. Add patches to make failures in the parse-events =
test
> > >>>>       easier to diagnose. Reorder the perf stat default events pat=
ch to
> > >>>>       come earlier.
> > >>>>
> > >>>> v5. Add patch for retrying default events, fixing regression when
> > >>>>       non-root and paranoid. Make cycles to cpu-cycles test event =
change
> > >>>>       (to avoid non-core ARM events) the default on all architectu=
res
> > >>>>       (suggested by Namhyung). Switch all non-test cases to specif=
ying a
> > >>>>       PMU. Improvements to the parse-events test including core PM=
U
> > >>>>       parsing support for architectures without a "cpu" PMU.
> > >>>>       https://lore.kernel.org/lkml/20250923041844.400164-1-irogers=
@google.com/
> > >>>>
> > >>>> v4: Fixes for matching hard coded metrics in stat-shadow. Make the
> > >>>>       default "cycles" event string on ARM "cpu-cycles" which is t=
he
> > >>>>       same legacy event but avoids name collisions on ARM PMUs. To
> > >>>>       support this, use evlist__new_default for the no command lin=
e
> > >>>>       event case in `perf record` and `perf top`. Make
> > >>>>       evlist__new_default only scan core PMUs.
> > >>>>       https://lore.kernel.org/lkml/20250914181121.1952748-1-iroger=
s@google.com/#t
> > >>>>
> > >>>> v3: Deprecate the legacy cache events that aren't shown in the
> > >>>>       previous perf list to avoid the perf list output being too v=
erbose.
> > >>>>       https://lore.kernel.org/lkml/20250828205930.4007284-1-iroger=
s@google.com/
> > >>>>
> > >>>
> > >>> Hi Ian,
> > >>>
> > >>> Did you drop the change to ignore failures to open events in favour=
 of
> > >>> switching the default from "cycles" to "cpu-cycles" instead? I'm tr=
ying
> > >>> to follow the changelog but couldn't see it.
> > >>
> > >> Hi James,
> > >>
> > >> your example is using `perf stat` whilst the behavior to ignore
> > >> failing to open events is for `perf record` and added in:
> >
> > Oh right yeah I was getting record and stat mixed up.
> >
> > >> https://lore.kernel.org/lkml/20250923223312.238185-6-irogers@google.=
com/
> > >> Changing the behavior for `perf stat` hasn't been in scope for makin=
g
> > >> the behavior of legacy events consistent in any patch series. The
> > >> whole '<not counted>' vs '<not supported>' vs an early exit is
> > >> something where not changing behavior has been the name of the game
> > >> for many years due to potential reliance on the behavior.
> >
> > I don't see the exact issue here? v3 perf stat reported "<not
> > supported>" for the uncore event, which is accurate, and continued on
> > with the working event. Which seemed consistent with the change in perf
> > record.
> >
> > What use case would break exactly if we don't do the same for perf stat=
?
> > If a user isn't specific about a PMU it should attempt to open wherever
> > it can, if all fail then exit early.
>
> I've not argued against the idea, this patch series and many prior
> have been put upon to add quirks for the sake of a certain vendor's
> PMU drivers having events named the same as legacy events and them
> being too belligerent to rename them. I don't want supporting vendor
> PMU event naming quirks to cause things to be more complicated than is
> absolutely necessary. The key part of this series to me is:
> https://lore.kernel.org/lkml/20250923223312.238185-18-irogers@google.com/
> that is removing 362 lines of the parsing logic. Doing this but
> filling the rest of the code base up with new special cases isn't
> achieving the simplicity, consistency, .. that I'm hoping for. It is
> bad enough that there is a major change to perf record's behavior in
> the series, I expect complaints about this :-(
>
> I'm not sure why you are seeing a difference of behavior between v3
> and v6 given the code you are testing didn't change. I'm wondering if
> a different change in the tree is the issue. Doing a quick comparison
> between v6.12 perf and perf-tools-next running not as root and using
> an uncore event I see:
> ```
> $ perf --version
> perf version 6.12.35
> $ perf stat -e data_read true
>
> Performance counter stats for 'system wide':
>
>   <not supported> MiB  data_read:u
>
>       0.001779459 seconds time elapsed
>
> $ /tmp/perf/perf --version
> perf version 6.17.rc6.gd18020cf1e92
> $ /tmp/perf/perf stat -e data_read true
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (data_read:u).
> "dmesg | grep -i perf" may provide additional information.
> ```

From bisecting, this change came from commit 9eac5612da1c ("perf stat:
Don't skip failing group events"):
https://lore.kernel.org/lkml/20250825211204.2784695-3-irogers@google.com/
Taking a look.

Thanks,
Ian

> with the behavior with these patches matching that of perf-tools-next.
> I'll dig into this but I'm off in the weeds tracking down issues for
> the sake of a certain vendor again and failing to land clean up.
>
> Fwiw, I don't think there's any chance of this making it into v6.18
> but getting it into perf-tools-next for an eventual v6.19 would mean
> we can work through teething issues.
>
> Thanks,
> Ian
>
> > >>
> > >> Fwiw, this series migrates legacy events to json we should be able t=
o
> > >> do the same with the legacy hard coded metrics in `perf stat` once i=
t
> > >> lands. Removing the hard coded metrics will give better metrics as w=
e
> > >> can use event groups, share events between metrics, .. and only
> > >> display requested metrics when metrics are requested. My point is th=
at
> > >> there is further `perf stat` clean up that this work moves us toward
> > >> but at 28 patches already I'd like not to start work on making perf
> > >> stat a better place. Getting consensus on what that better place is
> > >> given the existing fragmentic behavior will be a challenge, but at
> > >> least these days we have some form of tests, albeit they tend to fla=
ke
> > >> all the time. To solve your problems below where you're specifically
> > >> picking an event that can wildcard, give the PMU or use cpu-cycles, =
or
> > >> one of the many other names ARM already has to mean this. Overloadin=
g
> > >> the event 'cycles' wasn't something introduced in this series and th=
e
> > >> fact changing the name hasn't happened in the drivers is really very
> > >> frustrating.
> > >>
> > >> Thanks,
> > >> Ian
> > >>
> > >>
> > >>> In v3 I got <not supported> for the uncore cycles event, but in v6 =
I get
> > >>> a complete failure:
> > >>>
> > >>>    -> sudo perf-v3 stat -e cycles -- true
> > >>>
> > >>>    Performance counter stats for 'true':
> > >>>
> > >>>              1732478      cycles
> > >>>
> > >>>      <not supported>      arm_cmn_0/cycles/
> > >>>
> > >>>
> > >>>    -> sudo perf-v6 stat -e cycles -- true
> > >>>    Error:
> > >>>    Invalid event (cycles) in per-thread mode, enable system wide wi=
th '-
> > >>>    a'.
> > >>>
> > >>> The verbose output shows that it tries both, but doesn't ignore the
> > >>> error on arm_cmn_0 anymore:
> > >>>
> > >>> -> sudo perf-v6 stat -e cycles -vvv -- true
> > >>> Control descriptor is not initialized
> > >>> Opening: cycles
> > >>> ------------------------------------------------------------
> > >>> perf_event_attr:
> > >>>     type                             0 (PERF_TYPE_HARDWARE)
> > >>>     size                             136
> > >>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >>>     sample_type                      IDENTIFIER
> > >>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_=
RUNNING
> > >>>     disabled                         1
> > >>>     inherit                          1
> > >>>     enable_on_exec                   1
> > >>> ------------------------------------------------------------
> > >>> sys_perf_event_open: pid 9646  cpu -1  group_fd -1  flags 0x8 =3D 3
> > >>> Opening: cycles
> > >>> ------------------------------------------------------------
> > >>> perf_event_attr:
> > >>>     type                             11 (arm_cmn_0)
> > >>>     size                             136
> > >>> Required parameter 'wp_dev_sel' not specified
> > >>> Required parameter 'wp_dev_sel' not specified
> > >>>     config                           0x3 (cycles)
> > >>>     sample_type                      IDENTIFIER
> > >>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_=
RUNNING
> > >>>     disabled                         1
> > >>>     inherit                          1
> > >>>     enable_on_exec                   1
> > >>> ------------------------------------------------------------
> > >>> sys_perf_event_open: pid 9646  cpu 0  group_fd -1  flags 0x8
> > >>> sys_perf_event_open failed, error -22
> > >>> switching off exclude_guest for PMU arm_cmn_0
> > >>> Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit=
,
> > >>> falling back to no-inherit.
> > >>> Warning:
> > >>> cycles event is not supported by the kernel.
> > >>> Error:
> > >>> Invalid event (cycles) in per-thread mode, enable system wide with =
'-a'.
> > >
> > > Re v3 vs v6:
> > >
> > > v3 series here has no changes to perf stat:
> > > https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.=
com/
> > > the v6 does change perf stat in the "add_default_events" function:
> > > https://lore.kernel.org/lkml/20250923223312.238185-5-irogers@google.c=
om/
> > > but you are reporting an issue with an event specified, so not using
> > > default events. The evsel changes in v6 are for the evsel__match
> > > function that isn't used during event opening.
> > >
> > > Thanks,
> > > Ian
> > >
> >
> > Maybe there are no direct changes to perf stat, but the user facing
> > behavior still changes. Now perf record ignores the bad uncore event,
> > but perf stat doesn't, making it inconsistent. V3 was better in this re=
gard.
> >
> > I'm not sure if you are saying that you wouldn't expect there to be
> > _any_ change to perf stat in V3? Or just that perf stat itself wasn't
> > changed but things that it depends on were? I just want to make sure
> > I've tested the right thing and we're talking about the same thing.
> >
> > I double checked and rebuilt 20250828205930.4007284-1-irogers@google.co=
m
> > (v3) and still see the different behavior in perf stat that I posted ab=
ove.
> >
> > >>>
> > >>>> v2: Additional details to the cover letter. Credit to Vince Weaver
> > >>>>       added to the commit message for the event details. Additiona=
l
> > >>>>       patches to clean up perf_pmu new_alias by removing an unused=
 term
> > >>>>       scanner argument and avoid stdio usage.
> > >>>>       https://lore.kernel.org/lkml/20250828163225.3839073-1-iroger=
s@google.com/
> > >>>>
> > >>>> v1: https://lore.kernel.org/lkml/20250828064231.1762997-1-irogers@=
google.com/
> > >>>>
> > >>>> Ian Rogers (28):
> > >>>>     perf stat: Allow retry for default events
> > >>>>     perf parse-events: Fix legacy cache events if event is duplica=
ted in a
> > >>>>       PMU
> > >>>>     perf perf_api_probe: Avoid scanning all PMUs, try software PMU=
 first
> > >>>>     perf stat: Avoid wildcarding PMUs for default events
> > >>>>     perf record: Skip don't fail for events that don't open
> > >>>>     perf jevents: Support copying the source json files to OUTPUT
> > >>>>     perf pmu: Don't eagerly parse event terms
> > >>>>     perf parse-events: Remove unused FILE input argument to scanne=
r
> > >>>>     perf pmu: Use fd rather than FILE from new_alias
> > >>>>     perf pmu: Factor term parsing into a perf_event_attr into a he=
lper
> > >>>>     perf parse-events: Add terms for legacy hardware and cache con=
fig
> > >>>>       values
> > >>>>     perf jevents: Add legacy json terms and default_core event tab=
le
> > >>>>       helper
> > >>>>     perf pmu: Add and use legacy_terms in alias information
> > >>>>     perf jevents: Add legacy-hardware and legacy-cache json
> > >>>>     perf print-events: Remove print_hwcache_events
> > >>>>     perf print-events: Remove print_symbol_events
> > >>>>     perf parse-events: Remove hard coded legacy hardware and cache=
 parsing
> > >>>>     perf record: Use evlist__new_default when no events specified
> > >>>>     perf top: Use evlist__new_default when no events specified
> > >>>>     perf evlist: Avoid scanning all PMUs for evlist__new_default
> > >>>>     perf evsel: Improvements to __evsel__match
> > >>>>     perf test parse-events: Use evsel__match for legacy events
> > >>>>     perf test parse-events: Without a PMU use cpu-cycles rather th=
an
> > >>>>       cycles
> > >>>>     perf test parse-events: Remove cpu PMU requirement
> > >>>>     perf test: Switch cycles event to cpu-cycles
> > >>>>     perf test: Clean up test_..config helpers
> > >>>>     perf test parse-events: Add evlist test helper
> > >>>>     perf test parse-events: Add evsel test helper
> > >>>>
> > >>>>    tools/perf/Makefile.perf                      |   21 +-
> > >>>>    tools/perf/arch/x86/util/intel-pt.c           |    2 +-
> > >>>>    tools/perf/builtin-list.c                     |   34 +-
> > >>>>    tools/perf/builtin-record.c                   |   97 +-
> > >>>>    tools/perf/builtin-stat.c                     |  171 +-
> > >>>>    tools/perf/builtin-top.c                      |    8 +-
> > >>>>    tools/perf/pmu-events/Build                   |   24 +-
> > >>>>    .../arch/common/common/legacy-hardware.json   |   72 +
> > >>>>    tools/perf/pmu-events/empty-pmu-events.c      | 2771 ++++++++++=
++++++-
> > >>>>    tools/perf/pmu-events/jevents.py              |   32 +
> > >>>>    tools/perf/pmu-events/make_legacy_cache.py    |  129 +
> > >>>>    tools/perf/pmu-events/pmu-events.h            |    1 +
> > >>>>    tools/perf/tests/code-reading.c               |    2 +-
> > >>>>    tools/perf/tests/keep-tracking.c              |    2 +-
> > >>>>    tools/perf/tests/parse-events.c               | 2010 ++++++----=
--
> > >>>>    tools/perf/tests/perf-time-to-tsc.c           |    4 +-
> > >>>>    tools/perf/tests/pmu-events.c                 |   24 +-
> > >>>>    tools/perf/tests/pmu.c                        |    3 +-
> > >>>>    tools/perf/tests/switch-tracking.c            |    2 +-
> > >>>>    tools/perf/util/evlist.c                      |   18 +-
> > >>>>    tools/perf/util/evsel.c                       |   21 +-
> > >>>>    tools/perf/util/parse-events.c                |  282 +-
> > >>>>    tools/perf/util/parse-events.h                |   22 +-
> > >>>>    tools/perf/util/parse-events.l                |   54 +-
> > >>>>    tools/perf/util/parse-events.y                |  114 +-
> > >>>>    tools/perf/util/perf_api_probe.c              |   27 +-
> > >>>>    tools/perf/util/pmu.c                         |  309 +-
> > >>>>    tools/perf/util/print-events.c                |  112 -
> > >>>>    tools/perf/util/print-events.h                |    4 -
> > >>>>    29 files changed, 4523 insertions(+), 1849 deletions(-)
> > >>>>    create mode 100644 tools/perf/pmu-events/arch/common/common/leg=
acy-hardware.json
> > >>>>    create mode 100755 tools/perf/pmu-events/make_legacy_cache.py
> > >>>>
> > >>>
> >
