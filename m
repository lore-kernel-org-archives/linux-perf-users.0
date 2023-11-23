Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qniZOHEQ"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0FF30FE
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 07:28:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so14124a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700753286; x=1701358086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CesA/7N50xL1uQBnNLC2vxjnkcnpOsfgplKMc4isbHY=;
        b=qniZOHEQwAoSnht+qBuqbepNWmY8WNJC7qm3oMBFVfFELnx5cEvApJ6OPoYd1qoQeW
         R4T/SRKsH8Z5VvOk6UG25N4LzwGURuhtCBxOfYctCt6QYXTVCvaievTr/zy4680Rwea1
         J9P2J7eRLWPD7D47m/1JIwCjFsWyjfJxyFZxSIIDnLPi4yuq72S+3QWhm7aJPA3v8sDY
         zcipMg7p4cB/EDNVAbH5F6jOasAMWVIw22569pNl4E8fA1bBChk4z/LyZHCa4Vlh2Mrl
         PutKLW436YfxBCtAiokJyv8wOMYWfjxinhqLewhzL7dGa3oTIZ8TKzYz6sT4e39BJhxe
         nUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753286; x=1701358086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CesA/7N50xL1uQBnNLC2vxjnkcnpOsfgplKMc4isbHY=;
        b=ebC3TUnv1Jh66Cjfgh8FCRi8VSetFl4x8X/VQSrfs9ePTqfMQwR6Z70RTnYur0rWWD
         rcO8naM27DoXEcJPA68NQENk8PNGA5r31MZbXq1iTIHV3qlwV5hWRBNSss3KFDFoFdtb
         Y9oUXmwF+pO+1vUqDVQuVwUaeXFxw6q0etqPp6fORfS94mrJIJnT3slK2tbdiX9R15tx
         Tc9GBQb3YLwnhiriWQR8e+j7/3CFOKpiApGy3E2nuRo631zOEv6IfmRoGnS3a4HI70KA
         NFXCqFZndrg2GUMypUT9yE5/NkxvwGlSGceecHRVgxqP0JEE/tlzIOT+M4pDE5BUbu00
         FSDQ==
X-Gm-Message-State: AOJu0YxfY4nfpFfzrORTR1kPKkE0+AZuWzs/CtSZWLZiqfPHpI48n38J
	Rgh/BQyjtEMDLiZRdK2iFLVWZP96wuKnnbjuoGN+Ug==
X-Google-Smtp-Source: AGHT+IEntc8T1yjNYBEbWr/Qcr+znmI/DVr0fbX0aZgsLaTN5s4HFwvAy1dK8PejTAVX8bjtdNEI6YCUjZsoz/RnwBw=
X-Received: by 2002:a05:6402:b83:b0:544:e249:be8f with SMTP id
 cf3-20020a0564020b8300b00544e249be8fmr246420edb.1.1700753286282; Thu, 23 Nov
 2023 07:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123042922.834425-1-irogers@google.com> <86cyw0zeiu.wl-maz@kernel.org>
In-Reply-To: <86cyw0zeiu.wl-maz@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Nov 2023 07:27:54 -0800
Message-ID: <CAP-5=fXjX2pNmmX3WOY=m0BqUHTR2YPKVki6bbgG3g1Btc2=Ng@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Hector Martin <marcan@marcan.st>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 7:16=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Thu, 23 Nov 2023 04:29:22 +0000,
> Ian Rogers <irogers@google.com> wrote:
> >
> > The perf tool has previously made legacy events the priority so with
> > or without a PMU the legacy event would be opened:
> >
> > ```
> > $ perf stat -e cpu-cycles,cpu/cpu-cycles/ true
> > Using CPUID GenuineIntel-6-8D-1
> > intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branc=
h
> > Attempting to add event pmu 'cpu' with 'cpu-cycles,' that may result in=
 non-fatal errors
> > After aliases, add event pmu 'cpu' with 'cpu-cycles,' that may result i=
n non-fatal errors
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 833967  cpu -1  group_fd -1  flags 0x8 =3D 3
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > ...
> > ```
> >
> > Fixes to make hybrid/BIG.little PMUs behave correctly, ie as core PMUs
> > capable of opening legacy events on each, removing hard coded
> > "cpu_core" and "cpu_atom" Intel PMU names, etc. caused a behavioral
> > difference on Apple/ARM due to latent issues in the PMU driver
> > reported in:
> > https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marca=
n.st/
> >
>
> What issue? So far, I don't see anything that remotely looks like a
> kernel issue.
>
> > As part of that report Mark Rutland <mark.rutland@arm.com> requested
> > that legacy events not be higher in priority when a PMU is specified
> > reversing what has until this change been perf's default
> > behavior. With this change the above becomes:
> >
> > ```
> > $ perf stat -e cpu-cycles,cpu/cpu-cycles/ true
> > Using CPUID GenuineIntel-6-8D-1
> > Attempt to add: cpu/cpu-cycles=3D0/
> > ..after resolving event: cpu/event=3D0x3c/
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 827628  cpu -1  group_fd -1  flags 0x8 =3D 3
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             4 (PERF_TYPE_RAW)
> >   size                             136
> >   config                           0x3c
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > ...
> > ```
> >
> > So the second event has become a raw event as
> > /sys/devices/cpu/events/cpu-cycles exists.
> >
> > A fix was necessary to config_term_pmu in parse-events.c as
> > check_alias expansion needs to happen after config_term_pmu, and
> > config_term_pmu may need calling a second time because of this.
> >
> > config_term_pmu is updated to not use the legacy event when the PMU
> > has such a named event (either from json or sysfs).
> >
> > The bulk of this change is updating all of the parse-events test
> > expectations so that if a sysfs/json event exists for a PMU the test
> > doesn't fail - a further sign, if it were needed, that the legacy
> > event priority was a known and tested behavior of the perf tool.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Reported-by:, Link: and Fixes: tags would be appreciated.
>
> > ---
> > This is a large behavioral change:
> > 1) the scope of the change means it should bake on linux-next and I
> > don't believe should be a 6.7-rc fix.
>
> I entirely disagree. Distros are shipping a broken perf tool.
>
> > 2) a fixes tag and stable backport I don't think are appropriate. The
> > real reported issue is with the PMU driver. A backport would bring the
> > risk that later fixes, due to the large behavior change, wouldn't be
> > backported and past releases get regressed in scenarios like
> > hybrid. Backports for the perf tool are also less necessary than say a
> > buggy PMU driver, as distributions should be updating to the latest
> > perf tool regardless of what Linux kernel is being run (the perf tool
> > is backward compatible).
>
> Again, perf gets shipped in distros, and not necessary as the latest
> version. Rather, they tend to ship the version matching the kernel. No
> backport, buggy perf.

Please complain to the distros. I complained to Debian, we got rid of
the horrible wrapper script thing they did. I complained to two
separate Ubuntu people over the last two weeks as they still have
broken packaging even though they derive from Debian. Fedora is of
course perfect as Arnaldo oversees it :-)

> And again, I don't see a bug in the PMU driver.

Whether the PMU driver is requested a legacy cycles event or the
cycles event as an event code, the PMU driver should support it.
Supporting legacy events is just something core PMU drivers do. This
workaround wouldn't be necessary were it not for this PMU bug.

This change impacts every user of perf not just a partial fix to
workaround ARM PMU driver issues, see the updated parse-events test
for a list of what a simple test sees as a behavior change.

Thanks,
Ian

> Now, in the interest of moving forward: this patch seems to address
> the basic problems I was seeing on both M1/M2 (running any kernel
> version) and Juno (running an older kernel), so:
>
> Tested-by: Marc Zyngier <maz@kernel.org>
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
