Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9E2C6AF
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339730; cv=none; b=GPvxYnM9dlOpgzs+Yc8doFzbR6aEen0GSW9PF3uCCAgv+YUk0AW2tp6NTsOmNvGQw6yKyn6bFgx3iFxnMvTUXfyQWhiqTstnTamr01tTXGVX7BOqyWLvVDPXzNdqf+c73dcdNC3w+PXVbE0BVvVfPXoWrhpvCfusiEB8I8vW/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339730; c=relaxed/simple;
	bh=BUzcI7OukSS13o2EOotZtgvbOMnfxnRYGYS1AuA8RtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZKaolTrwdO/GIEw+w4QOAmLSPQbVHU/B2TOV2vDbCWO3khQ4rMMT+Es/lKnvxJW61yQuKcMZeGWX2uagBa1p7qOCI4482P/WiVFhokoXZ5KL5HWM9xmtzDdHe8ye4vHACHpdMeJ5hIRvT18JWDLFXzIGh/t/0B83eLqLPhbPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCiRi6V5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCiRi6V5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202018541afso165865ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724339728; x=1724944528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lck+dKvH8IO6d/hyhyQtHkkuQFQqgFpWof7AZCeNw9c=;
        b=mCiRi6V5OYD6/cIdWyohJ6kPWdgwZvAlWko3k2veUEhm5Un+tb2ilasYX3OZiOekDL
         Jmt0t3LvvdGvyMewB6QPtCyqSHxdAg7gW+Wojj0Wueo1UmD4mczMvIaDxhHfNhbiWGrU
         j5LVavgwHNWtfKy3FkJEqlEOQCrYccvHyXrIZJKcvtTEvLPZ1SzMjJA7WLeztJg67q8x
         UIAsDoQVvnLXVINfBI4l9GICF5+xINhwgf/FP0c+xw6wZnXCECFPso6RO8uX7rzKZKLC
         qYvLUXcuwBrnu5woJ37Cg0WSyhYXw17bajPya+xafziun1KIB90hRj4GBre/sXoNfkVr
         TXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724339728; x=1724944528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lck+dKvH8IO6d/hyhyQtHkkuQFQqgFpWof7AZCeNw9c=;
        b=swFIIwl3gu7E5QrTiaR3kbF+6zg2gxl44RYAJ1JoBufxBSorEDN/vn05R0wF3tPMQs
         6y0Vl095dA4niD0XwkMlPSHoybu+DzMKZNZ04w93OP9EDMpNy+H0EG/ELoTxbQJ6lgG4
         wc8zhSVyh45S8vj7/Zsip+6aYSXwoMbVnPpgx509vMitCyIzJe/zb17VGcPoH94t/Y5I
         5Chzx8OtX70gP/Me4nIxu7n87uxUkwH8zIfsHmin7YUyK7+yLGcIuauX3xbDGKuFBtU4
         EUAv2wRD1PjqbObPLUHs1ncfig5Cm5EUaxwjfPuCm9CG6TgMRRPSVjprC7Sut9UytmPB
         K4+A==
X-Forwarded-Encrypted: i=1; AJvYcCVua5r1bh4KE7Mc6q336arez73jX72SIM5f3bGpI+vfobtqKNUzSwzt8VRfpS6TFu559mE7MbPqpZnOZbCNmS+z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29aeq34PxZDj08Mfnxv5UAYG6rokgFHhbtAco2JSF8ZCy7vyL
	Li7snAISt5B4Ypw6+wVnrnaV+UZOqVvDy9Y1Gp8YU4hqr5p+3Bg2HcM8Kq2m1wFEupw0jgVmL7m
	s4dIl9VhUGyye+0t2mUsOK9Pq5HzO8/+jkd/a
X-Google-Smtp-Source: AGHT+IHNIxkXRfs6rii3n8WwQKyCifwdGwWDQT62P2QnRmbheBcHUcPmp8diG+t5fKpMkFMff43JVN8PjuaoB4dtrLg=
X-Received: by 2002:a17:902:ec92:b0:1fa:fe30:8fce with SMTP id
 d9443c01a7336-203855b162bmr2936145ad.23.1724339727292; Thu, 22 Aug 2024
 08:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05E55194-C265-4BDA-911D-B9E57EED3CBB@nutanix.com>
 <CAP-5=fUndbBhSLb35_bL-+Xu3erB6ssx-sAEYaf7mgxPawNEbA@mail.gmail.com>
 <65A24EAA-A348-4E77-AF5B-933B41C9CAB6@nutanix.com> <CAP-5=fVTB5DUybd7KnX-qb8yau+onkscm1a13izuZLH_WdXiyw@mail.gmail.com>
 <067B5698-9C34-4283-888B-DC691F3462A8@nutanix.com>
In-Reply-To: <067B5698-9C34-4283-888B-DC691F3462A8@nutanix.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Aug 2024 08:15:05 -0700
Message-ID: <CAP-5=fVU_ngSOsDs_9Ma=pyOPzD3jr-MYQC9LeAirR--bfA-BQ@mail.gmail.com>
Subject: Re: Perf test failures for 10.2 PMU event map aliases
To: Jon Kohler <jon@nutanix.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:01=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Aug 20, 2024, at 11:17=E2=80=AFAM, Ian Rogers <irogers@google.com> w=
rote:
> >
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > On Tue, Aug 20, 2024 at 6:54=E2=80=AFAM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >>
> >>
> >>> On Aug 20, 2024, at 1:41=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
> >>>
> >>> !-------------------------------------------------------------------|
> >>> CAUTION: External Email
> >>>
> >>> |-------------------------------------------------------------------!
> >>>
> >>> On Mon, Aug 19, 2024 at 7:06=E2=80=AFPM Jon Kohler <jon@nutanix.com> =
wrote:
> >>>>
> >>>> Reaching out to the perf community for feedback on the following
> >>>> observed test failure. On 6.6.y, I see persistent failures with test
> >>>> 10.2 PMU event map aliases, complaining about testing aliases uncore
> >>>> PMU mismatches. I've included two outputs below, one with a bit of
> >>>> hacky print debugging.
> >>>>
> >>>> Using Intel(R) Xeon(R) Gold 6154 CPU:
> >>>>       10.2: PMU event map aliases                                   =
      :
> >>>>       --- start ---
> >>>>       test child forked, pid 962901
> >>>>       Using CPUID GenuineIntel-6-55-4
> >>>
> >>> Hi Jon,
> >>>
> >>> Sorry for the brief reply but I thought some quick hints might unbloc=
k
> >>> you on this. The CPUID lines up with a SkylakeX:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_pub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-=
2Devents_arch_x86_mapfile.csv-3Fh-3Dperf-2Dtools-2Dnext-23n33&d=3DDwIFaQ&c=
=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661xzakrB42hsUs=
FD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DF-eXsmTASgRsptt5Gahro6fR=
yMwEQdjZ6PtY7vhzIKM&e=3D
> >>>
> >>>>       testing core PMU cpu aliases: pass
> >>>>       JKDBG: pmu nr total 3 pmu->sysfs_aliases 3 pmu->sys_json_alias=
es 0
> >>>>       JKDBG: pmu cpu_aliases_added nr total 4 pmu->cpu_json_aliases =
1
> >>>>       testing aliases uncore PMU uncore_imc_0: mismatch expected ali=
ases
> >>>>         (1) vs found (4)
> >>>>       test child finished with -1
> >>>>       ---- end ----
> >>>>       PMU events subtest 2: FAILED!
> >>>>
> >>>> Using Intel(R) Xeon(R) Platinum 8352Y:
> >>>>       10.2: PMU event map aliases                                   =
      :
> >>>>       --- start ---
> >>>>       test child forked, pid 1765070
> >>>>       Using CPUID GenuineIntel-6-6A-6
> >>>
> >>> This is an IcelakeX:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_pub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-=
2Devents_arch_x86_mapfile.csv-3Fh-3Dperf-2Dtools-2Dnext-23n18&d=3DDwIFaQ&c=
=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661xzakrB42hsUs=
FD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3D6DwD4ZmywAtcwCnRjx7wRfmd=
W_G65wHIuyZJIc__2yc&e=3D
> >>>
> >>>>       testing core PMU cpu aliases: pass
> >>>>       testing aliases uncore PMU uncore_imc_free_running_0: mismatch
> >>>>         expected aliases (1) vs found (6)
> >>>>       test child finished with -1
> >>>>       ---- end ----
> >>>>       PMU events subtest 2: FAILED!
> >>>>
> >>>> Digging in more, looking at pmu_aliases_parse, I see that we'll disc=
ard
> >>>> scale and unit files in pmu_alias_info_file, which leaves us with 3x
> >>>> aliases in the uncore_imc_0 in the first case and 5x aliases in the
> >>>> uncore_imc_free_running_0 second case.
> >>>>
> >>>> # From 6154-based system:
> >>>> ls -lhat /sys/devices/uncore_imc_0/events
> >>>
> >>> The "uncore_" prefix and the "_0" suffix are optional, the naming
> >>> matching is case insensitive. In the event json the events are listed
> >>> here:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_pub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-=
2Devents_arch_x86_skylakex_uncore-2Dmemory.json-3Fh-3Dperf-2Dtools-2Dnext&d=
=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661x=
zakrB42hsUsFD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DFpAgVwLmTyXUF=
QIMZ_gbPlH9aXvrmcJ8CZaW3tKIaj4&e=3D
> >>>
> >>>> total 0
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_read
> >>>> -r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_write
> >>>> -r--r--r--. 1 root root 4.0K Aug  9 15:30 clockticks
> >>>
> >>> This should be 3 sysfs events (I don't like the term alias), note tha=
t
> >>> we load the sysfs and json events lazily to avoid overhead.
> >>>
> >>>> drwxr-xr-x. 2 root root    0 Jul 17 03:40 .
> >>>> drwxr-xr-x. 5 root root    0 Jul 17 02:52 ..
> >>>>
> >>>> # From the 8352Y-based system:
> >>>> ls -lhat /sys/bus/event_source/devices/uncore_imc_free_running_0/eve=
nts
> >>>> total 0
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 read.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 read.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 write.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 write.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 dclk
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_read
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_write
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 read
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 write
> >>>
> >>> This is 5 sysfs events, the json events are here:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_pub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-=
2Devents_arch_x86_icelakex_uncore-2Dmemory.json-3Fh-3Dperf-2Dtools-2Dnext-2=
3n134&d=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3D=
RJx661xzakrB42hsUsFD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DMrHuUC=
ZFqrNrd05IPyq4fuZDH4_owkEw0xHcc7bvGvU&e=3D
> >>> Note, the "Unit", meaning the PMU should be imc_free_running to match
> >>> this device.
> >>>
> >>>> drwxr-xr-x. 2 root root    0 Aug 15 03:15 .
> >>>> drwxr-xr-x. 5 root root    0 Aug 15 02:42 ..
> >>>>
> >>>> Looking at the structure of __test_uncore_pmu_event_aliases, however=
,
> >>>> I'm not quite sure how this is supposed to work. I've annotated a wa=
lk
> >>>> through below to highlight where things are going off the rails.
> >>>>
> >>>> static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu =
*test_pmu)
> >>>> {
> >>>> ...
> >>>>       /* Count how many aliases we generated */
> >>>>       alias_count =3D perf_pmu__num_events(pmu);
> >>>>               // alias_count =3D=3D 4 in the 6154-based system
> >>>>               // alias_count =3D=3D 6 in the 8352Y-based system
> >>>>
> >>>>       /* Count how many aliases we expect from the known table */
> >>>>       for (table =3D &test_pmu->aliases[0]; *table; table++)
> >>>>               to_match_count++;
> >>>>                       // this is looking at aliases in struct perf_p=
mu_test_pmu
> >>>>                       // table, which for uncore_imc_0 is a single e=
ntry for
> >>>>                       // &uncore_imc_cache_hits.
> >>>>                       //
> >>>>                       // for the 8352Y case, likewise, we only have =
a single alias
> >>>>                       // in the table for &uncore_imc_free_running_c=
ache_miss.
> >>>>                       //
> >>>>                       // in both cases, to_match_count =3D=3D 1
> >>>>
> >>>>       // Compare 4 vs 1 or 6 vs 1
> >>>>       if (alias_count !=3D to_match_count) {
> >>>>               pr_debug("testing aliases uncore PMU %s: mismatch expe=
cted aliases (%d) vs found (%d)\n",
> >>>>                        pmu_name, to_match_count /* 1 */, alias_count=
 /* 4 */);
> >>>>               return -1;
> >>>>                       // we seemed doomed to hit this conditional al=
ways, no?
> >>>>       }
> >>>> ...
> >>>> }
> >>>>
> >>>> I did a walkthrough of the latest mainline code, and don't see a mar=
ked
> >>>> difference that jump off the page to me that'd correct this behavior=
,
> >>>> and would love a helping hand to point in the right direction on thi=
s.
> >>>>
> >>>> What am I missing here?
> >>>
> >>> I'll need some more time to dig into this. Hopefully the pointers abo=
ve help.
> >>
> >> Thanks for the quick reply and pointers, I appreciate it. The tricky b=
it still
> >> remains, as the code I posted to above seems to solely depend on the
> >> info filled into struct perf_pmu_test_pmu, right? If so, I don=E2=80=
=99t see how the
> >> dots connect from this test to the other events in sysfs/json=E2=80=99=
s.
> >
> > So looking at the test it is using the testcpu:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_tests_=
pmu-2Devents.c-3Fh-3Dperf-2Dtools-2Dnext-23n602&d=3DDwIFaQ&c=3Ds883GpUCOChK=
OHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DupMgwNSdGAw5sdDUTdoyvXhLy4KhFUYqP=
dxZKx8Ov-ZxDYERFVy8PU040wwDAYPp&s=3DerGg8kUByjl_j5R0D0PxRZjTZhvazxwC9KW8rOT=
9Pp4&e=3D
> > the json for that is here:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-2D=
events_arch_test_test-5Fsoc_cpu-3Fh-3Dperf-2Dtools-2Dnext&d=3DDwIFaQ&c=3Ds8=
83GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DupMgwNSdGAw5sdDUTdoyvXh=
Ly4KhFUYqPdxZKx8Ov-ZxDYERFVy8PU040wwDAYPp&s=3Dz535_TbF_oJLjEoRuhbbqzB9Xo5Mw=
WWmOcP0pgMulWY&e=3D
> > The names in the test are based on ones seen on real CPUs, so this may
> > be leading to the confusion.
>
> Hey Ian,
> I was able to debug this a bit more. The following diff fixes this test o=
n my system.
>
> Even though we were supposed to be using the test data only, the sysfs en=
tries
> from my systems, which happened to have similar names, threw a wrench in
> this test.
>
> With this diff, we just use the JSON aliases that were added.
>
> Happy to send this out as a formal patch, but wanted to get the list=E2=
=80=99s 2cents
> first, as I feel like I=E2=80=99m missing something :)
>
> Jon
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index f5321fbdee79..893dc7afee76 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -584,6 +584,9 @@ static int __test_uncore_pmu_event_aliases(struct per=
f_pmu_test_pmu *test_pmu)
>         const struct pmu_events_table *events_table;
>         int res =3D 0;
>
> +       /* CPU events come from struct pmu_event pmu_events__test_soc_cpu
> +        * and sys events come from struct pmu_event pmu_events__test_soc=
_sys
> +        */
>         events_table =3D find_core_events_table("testarch", "testcpu");
>         if (!events_table)
>                 return -1;
> @@ -593,10 +596,14 @@ static int __test_uncore_pmu_event_aliases(struct p=
erf_pmu_test_pmu *test_pmu)
>         pmu->sysfs_aliases_loaded =3D true;
>         pmu_add_sys_aliases(pmu);
>
> -       /* Count how many aliases we generated */
> -       alias_count =3D perf_pmu__num_events(pmu);
> +       /* How many events we gathered for this PMU in test_soc.
> +        * Note: we specifically do not use perf_pmu__num_events as that =
may
> +        * include spurious system events from the system under test, whi=
ch
> +        * may have similarly named PMUs.

Thanks Jon, should we just rename the PMUs in the test json files? For
example, rather than "CBO" here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json?h=3Dperf-tools-=
next#n10
we can have "test_pmu1".

Thanks for investigating this!
Ian

> +        */
> +       alias_count =3D pmu->cpu_json_aliases + pmu->sys_json_aliases;
>
> -       /* Count how many aliases we expect from the known table */
> +       /* How many aliases we expect from struct perf_pmu_test_pmu test_=
pmus */
>         for (table =3D &test_pmu->aliases[0]; *table; table++)
>                 to_match_count++;
>
> >
> > Thanks,
> > Ian
>
