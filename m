Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20A16D4E0
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195582; cv=none; b=J8GcOzANqaChsX6wM3yJEZN5wIvKADm7UYFbO1veCSg0Aw9AyN1R15q/gm1p+bFiBC4CC/nFAI1YxAsq7T08PcwuCO0aBbRZnfE6Ag/x5a7XolVZslybH+O9elXgFLKGafuzHK5vv4En4870FHL5VR6xGdl6mfRZqGWnDTZ+A/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195582; c=relaxed/simple;
	bh=WNCGpS4SGjYDkiPK3WxsWQI0m/d+Q6ZN0tswo2NzimQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxX6zTCiCl0lqmFRt1+9X60Q5al/4FoFvJUIzm+JWbVfr+W3vWb15sX5b9Ydo6mRxfaEH0VQzIXN7jOstfEdMNhW1OoY96o74VR23RZEGR5kAV3FYfnFKE+yklDrU6/5c/2ituyqd18VOQwyCJembeCAT7U4/oa/9Cgd/Z/hCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snlK9dni; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snlK9dni"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3748a9fa84fso132745ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718195579; x=1718800379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2trM/DfDykMtRbHI6LRUGWsttJQkw6D+TvUuryK0TY=;
        b=snlK9dniR72V0NF0kv5wsKeEVPK/zeB0KfLwrMQcaFy25MVAZEL+DF3jChFuhi6ME1
         aloisD6wjmwC+EMf7RBwArggLHuATWdUqO2EUpv675ddBQBGp5Z9drEGHF3wkqHzOCan
         5bF1Qns78kdcdHSEV2ndRHZP402AKaSRm8cS1E5kAXlKUL85oY8NTWmjxSuqXR4dPtmG
         QrhfT4x7MomOSc7whtB/wXTve2JoMN0dBlE44O5WnEdaL53/lMXo8LdaORoyELgUR5IQ
         usKoXDdwD5C68MtmbyjtBF6cKcNBblJBdYWnGyGgB80w3coqyqYSKUkx9jXSjMzBmwCY
         lT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718195579; x=1718800379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2trM/DfDykMtRbHI6LRUGWsttJQkw6D+TvUuryK0TY=;
        b=hvhUuvzxoWJsUuU0ZUEbH7xfDx5CE0QhIsnzZA4YS+f44Uus46Lm1pfwQBsTkgA64l
         Jhmh1q1fineaTOHjOlEXuWuNuF9oDooYEP25ihtDcKpKj0w2IkxYoseHXVqeMDKbEvJH
         ikfYXssG12TpkYGxqDfswKtcrVmcETyAuUqTNz49npjJPU7hjt55YbXsHqlcVZfjBsVg
         JorVK8t0hrH9MtC7/z8Ls+RjP45BqJM6ez4BIyyHwyj9u+urJGQLOrEDEtvRzSa2K19s
         HfBpR+WoFfqFibPk5b6lO9sOLaEhGuXDupBhdSpYSUTae1AL/W7ILxUyz6vlhzNVrYzq
         8Shw==
X-Forwarded-Encrypted: i=1; AJvYcCXBeEnKwxJv9EVeBXVzG09MRPM65cNLRgrsME2jpSP+Couc4QA8r6slUoBHmRC2dNv/IRDQRp7F7MDkkJPgR/d7JhrmDpOzWObNsz5MgT8y0g==
X-Gm-Message-State: AOJu0YxSpC04t6a/8dCTLp34aHrOVqzaXsaQFnjnv1UZJT2ZolZMy57/
	OBmY96r/3bUmycLQuVqB6AJ9knCkDfX7wi1RHYI6c/EQ3vwaFIjoCMJCJ5CLL6bob/HEW1eqLVO
	J2PA+2ZzPoH55ywATpUFfhlzTcp7lnWvEEpqV
X-Google-Smtp-Source: AGHT+IES7VYQIcK2TsuxPA2moBtce25Log0wcrhxte9pqLuCfsIoH0kwVbtkdt27VBLNtr+GxKIzLlq4N+oMYEls7rw=
X-Received: by 2002:a05:6e02:3a83:b0:375:aec4:eaa8 with SMTP id
 e9e14a558f8ab-375cb4f5961mr2486005ab.8.1718195579301; Wed, 12 Jun 2024
 05:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515060114.3268149-1-irogers@google.com> <20240515060114.3268149-2-irogers@google.com>
 <ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com>
In-Reply-To: <ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Jun 2024 05:32:47 -0700
Message-ID: <CAP-5=fWxdZ1ibv7Pi0L38+NF-vNWZCtcDS9JVf6k3z9nDsrQQw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>, Mark Brown <broonie@kernel.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 4:19=E2=80=AFAM Aishwarya TCV <aishwarya.tcv@arm.co=
m> wrote:
>
>
>
> On 15/05/2024 07:01, Ian Rogers wrote:
> > The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
> > the previous PMU sorting/merging code assumes uncore PMU names start
> > with uncore_ and have a decimal suffix. Because of the previous
> > assumption it isn't possible to wildcard the mrvl_ddr_pmu.
> >
> > Modify pmu_name_len_no_suffix but also remove the suffix number out
> > argument, this is because we don't know if a suffix number of say 100
> > is in hexadecimal or decimal. As the only use of the suffix number is
> > in comparisons, it is safe there to compare the values as hexadecimal.
> > Modify perf_pmu__match_ignoring_suffix so that hexadecimal suffixes
> > are ignored.
> >
> > Only allow hexadecimal suffixes to be greater than length 2 (ie 3 or
> > more) so that S390's cpum_cf PMU doesn't lose its suffix.
> >
> > Change the return type of pmu_name_len_no_suffix to size_t to
> > workaround GCC incorrectly determining the result could be negative.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c  | 33 +++++++++++++--------
> >  tools/perf/util/pmus.c | 67 ++++++++++++++++++++++++------------------
> >  tools/perf/util/pmus.h |  7 ++++-
> >  3 files changed, 65 insertions(+), 42 deletions(-)
> >
>
> Hi Ian,
>
> Perf test "perf_all_PMU_test" is failing when run against
> next-master(next-20240612) kernel with Arm64 on JUNO in our CI. It looks
> like it is failing when run on JUNO alone. Verified by running on other
> boards like RB5 and Ampere_altra and confirming that it does not fail on
> these boards. Suspecting that the suffixed 'armv8_pmuv3_0' naming could
> be the reason of test failure.
>
> Reverting the change (3241d46f5f54) seems to fix it.
>
> This works fine on Linux version v6.10-rc3
>
> Failure log
> ------------
> 110: perf all PMU test:
> --- start ---
> test child forked, pid 8279
> Testing armv8_pmuv3/br_immed_retired/
> Event 'armv8_pmuv3/br_immed_retired/' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 1169.431 usec (+- 0.144 usec)
>   Average num. events: 35.000 (+- 0.000)
>   Average time per event 33.412 usec
>   Average data synthesis took: 1225.698 usec (+- 0.102 usec)
>   Average num. events: 119.000 (+- 0.000)
>   Average time per event 10.300 usec
>
>  Performance counter stats for 'perf bench internals synthesize':
>
>         3263664785      armv8_pmuv3_0/br_immed_retired/
>
>
>       25.472854464 seconds time elapsed
>
>        8.004791000 seconds user
>       17.060209000 seconds sys
> ---- end(-1) ----
> 110: perf all PMU test                                               :
> FAILED!

Hi Aishwarya,

Thanks for reporting an issue. The test should be pretty self
explanatory: it is doing a `perf stat -e
armv8_pmuv3/br_immed_retired/` and then looking for that in the
output. The event armv8_pmuv3/br_immed_retired/ comes from running
perf list. As you can see in the output the event did work, so perf
stat is working so nothing is actually broken here. What isn't working
is the perf stat output matching the command line event and this is
because of the unnecessary suffix on ARM's PMU name.

We have a problem that ARM have buggy PMU drivers, either from
introducing new naming conventions or by just being broken:
https://lore.kernel.org/lkml/CAP-5=3DfWNDkOpnYF=3D5v1aQkVDrDWsmw+zYX1pjS8ho=
iYVgZsRGA@mail.gmail.com/
I've also asked that ARM step up their testing, for example in the
event parsing testing the PMU is hardcoded to the x86 PMU name of
'cpu':
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/parse-events.c?h=3Dperf-tools-next#n2317
On a cortex A53, then PMU is named 'armv8_cortex_a53':
```
$ ls /sys/devices/armv8_cortex_a53/
caps  cpus  events  format  perf_event_mux_interval_ms  power
subsystem  type  uevent
```
This name appears better, so what's up with ARM's core PMU name?
Anyway, I'm tempted to fix this by just skipping the test on ARM given
ARM's overall broken state.

Further, can we escalate matters? It isn't right that these ARM issues
are coming back to me. ARM aren't stepping up to fix not just the 2
issues above but:
1) the broken Apple M? issue (ARM asked I fix this as it regressed due
to my fixes for the Intel hybrid code):
https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
2) opening events on BIG.little doesn't open the event on all core PMU type=
s:
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/
3) the broken 'cycles' event name in the arm_dsu PMU:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/perf/arm_dsu_pmu.c#n177
4) the ARM memory controller PMUs lacking cpumask causing events
opened on them to be opened on every CPU and thereby induce
multiplexing..
and so on..

Thanks,
Ian

> Thanks,
> Aishwarya
