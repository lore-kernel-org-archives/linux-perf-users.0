Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDFF18EFC9
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Aug 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167091; cv=none; b=RnnVnK3+Yn82J+avSpsxAjNbsWPiGxFWfUMYx3NrqSV4yb4tuEby+ESj3SsaaobN7jvT5NKp37WDOO8F0k0ZwAesI9/NrBlGuIASi566c64VHJ9O+XtpxmpaHWkR3IzTPhtNX8NpDMewc/kemC+hsQxN1XsZMQT1NUL8zl6gHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167091; c=relaxed/simple;
	bh=FnN5/suzVL2Cva0ZHkqQgBsCNk7qLoyougZpblbcotY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArUe9RJD7Rp7NF6LO/xNU2kLB6gPNfseo/4B+rOONE1wJ40aSghdMX2CnYqzIJI5J/fnZhaTEY0JrNVM3xbP06/mmRBtQMQqFTfx6q6Yj2qoeIbccWj9cYLu5c63b/NyYXp5JVWrMQyOCYaEsFGqOq45iNsOzLzGDq8b1LSGqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6qLqCJo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6qLqCJo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201fed75b38so97075ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Aug 2024 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724167089; x=1724771889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urAcmCCjiI5rmedKtqZs0p7Ogn4+RDAWlFm24KhnpUk=;
        b=D6qLqCJo4nPDCDTOJ78D2MMNdlssuy6xedoNIFQFIJ9tFfex6YMiNE5AWnj8M57+/U
         WpFol0UuagLZaO/WTYsO8IX43FXhwcB8HMJUQWTFzdlhRvW27ZUMsHC1YXuCGOPvUdQO
         w8ldST5UAMvWYMif9QbDh4IQQoGwlXf0/jpJOkhDkT4qBW301gJ9rhJ3oUq46bJXKqs4
         ISg+1UedVtTe2qv9YU6fs1J3w1kRNyifCx2IFbBPwrECc0+GstUC0Yq+4bWxa8OSGrpD
         jYcs82l1yr1iyn9WWAhi/yG8Y3EL5DHGfRxY77+NOZTch5e9m59+sYXupdyGV/OU8vti
         u+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167089; x=1724771889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urAcmCCjiI5rmedKtqZs0p7Ogn4+RDAWlFm24KhnpUk=;
        b=RiN4gv2IF2Eceb5V/YRt4r0s5+Y37hQnUvx+w7Hq4TVwTEKb5slEZxC2Gb8NqKoLg0
         LzwCnpzrEUxEEl9AcxnU3IZWkkhItrk2smsWoSOpb8rnK9enH9V7Pdus+O2RVjg/nr5u
         s0zmSSQ4m9j5spGeV8eLToZAWiSFd0LEd3jiD7yuoOU/Q0rqr2O0L0VALRmuHHqB7GSi
         z7Kf+lvYhDVEAnLLAl0NzJSvtamT9mpxCYuvDd6lonpcEE35MVHNxJ4u8XRQoRjNXhc2
         T/JpChjnol7eGkMl7pHAywHxBOHtlpoSqzB6ZErqZ2VlAVLXNoTuoy95cFIJEIkijBVq
         hwNA==
X-Forwarded-Encrypted: i=1; AJvYcCWcJSXUXhimN310l66S5bPM5bMZ2DFSocIXqeTpl41EZ3Y5BHtnAMvPdElAgYb4jzKzZUQyU44xeoLWCmeTh9YD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PE/5zQiTyJcqhAk1tfNK04vt9Zwb6sZz++D1T3Jvl98gWxwd
	9xhDWI5jxLHQ6wVO2elK7/UcePhoKf/VI5lRT0xSCa2sFoOwZc+QC/0XkCrEDQd097pTD3aR/Aq
	fcc9WkIsZ+SOfkRruYpZxSnalxrQ9cIyUWOBF
X-Google-Smtp-Source: AGHT+IGBuKYlyGvyMtwjB7GmMn9F6PQG1M2n1FofJFMl4pYMFx93UcVcYXMjA6H1/Apqzp82uCY/T9QmhnvQ1rUT5C4=
X-Received: by 2002:a17:902:ecca:b0:201:daee:6fac with SMTP id
 d9443c01a7336-202d5beb511mr1914625ad.16.1724167088460; Tue, 20 Aug 2024
 08:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05E55194-C265-4BDA-911D-B9E57EED3CBB@nutanix.com>
 <CAP-5=fUndbBhSLb35_bL-+Xu3erB6ssx-sAEYaf7mgxPawNEbA@mail.gmail.com> <65A24EAA-A348-4E77-AF5B-933B41C9CAB6@nutanix.com>
In-Reply-To: <65A24EAA-A348-4E77-AF5B-933B41C9CAB6@nutanix.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Aug 2024 08:17:56 -0700
Message-ID: <CAP-5=fVTB5DUybd7KnX-qb8yau+onkscm1a13izuZLH_WdXiyw@mail.gmail.com>
Subject: Re: Perf test failures for 10.2 PMU event map aliases
To: Jon Kohler <jon@nutanix.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 6:54=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Aug 20, 2024, at 1:41=E2=80=AFAM, Ian Rogers <irogers@google.com> wr=
ote:
> >
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > On Mon, Aug 19, 2024 at 7:06=E2=80=AFPM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >> Reaching out to the perf community for feedback on the following
> >> observed test failure. On 6.6.y, I see persistent failures with test
> >> 10.2 PMU event map aliases, complaining about testing aliases uncore
> >> PMU mismatches. I've included two outputs below, one with a bit of
> >> hacky print debugging.
> >>
> >> Using Intel(R) Xeon(R) Gold 6154 CPU:
> >>        10.2: PMU event map aliases                                    =
     :
> >>        --- start ---
> >>        test child forked, pid 962901
> >>        Using CPUID GenuineIntel-6-55-4
> >
> > Hi Jon,
> >
> > Sorry for the brief reply but I thought some quick hints might unblock
> > you on this. The CPUID lines up with a SkylakeX:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-2D=
events_arch_x86_mapfile.csv-3Fh-3Dperf-2Dtools-2Dnext-23n33&d=3DDwIFaQ&c=3D=
s883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661xzakrB42hsUsFD1=
HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DF-eXsmTASgRsptt5Gahro6fRyMw=
EQdjZ6PtY7vhzIKM&e=3D
> >
> >>        testing core PMU cpu aliases: pass
> >>        JKDBG: pmu nr total 3 pmu->sysfs_aliases 3 pmu->sys_json_aliase=
s 0
> >>        JKDBG: pmu cpu_aliases_added nr total 4 pmu->cpu_json_aliases 1
> >>        testing aliases uncore PMU uncore_imc_0: mismatch expected alia=
ses
> >>          (1) vs found (4)
> >>        test child finished with -1
> >>        ---- end ----
> >>        PMU events subtest 2: FAILED!
> >>
> >> Using Intel(R) Xeon(R) Platinum 8352Y:
> >>        10.2: PMU event map aliases                                    =
     :
> >>        --- start ---
> >>        test child forked, pid 1765070
> >>        Using CPUID GenuineIntel-6-6A-6
> >
> > This is an IcelakeX:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-2D=
events_arch_x86_mapfile.csv-3Fh-3Dperf-2Dtools-2Dnext-23n18&d=3DDwIFaQ&c=3D=
s883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661xzakrB42hsUsFD1=
HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3D6DwD4ZmywAtcwCnRjx7wRfmdW_G=
65wHIuyZJIc__2yc&e=3D
> >
> >>        testing core PMU cpu aliases: pass
> >>        testing aliases uncore PMU uncore_imc_free_running_0: mismatch
> >>          expected aliases (1) vs found (6)
> >>        test child finished with -1
> >>        ---- end ----
> >>        PMU events subtest 2: FAILED!
> >>
> >> Digging in more, looking at pmu_aliases_parse, I see that we'll discar=
d
> >> scale and unit files in pmu_alias_info_file, which leaves us with 3x
> >> aliases in the uncore_imc_0 in the first case and 5x aliases in the
> >> uncore_imc_free_running_0 second case.
> >>
> >> # From 6154-based system:
> >> ls -lhat /sys/devices/uncore_imc_0/events
> >
> > The "uncore_" prefix and the "_0" suffix are optional, the naming
> > matching is case insensitive. In the event json the events are listed
> > here:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-2D=
events_arch_x86_skylakex_uncore-2Dmemory.json-3Fh-3Dperf-2Dtools-2Dnext&d=
=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661x=
zakrB42hsUsFD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DFpAgVwLmTyXUF=
QIMZ_gbPlH9aXvrmcJ8CZaW3tKIaj4&e=3D
> >
> >> total 0
> >> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.scale
> >> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.unit
> >> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.scale
> >> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.unit
> >> -r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_read
> >> -r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_write
> >> -r--r--r--. 1 root root 4.0K Aug  9 15:30 clockticks
> >
> > This should be 3 sysfs events (I don't like the term alias), note that
> > we load the sysfs and json events lazily to avoid overhead.
> >
> >> drwxr-xr-x. 2 root root    0 Jul 17 03:40 .
> >> drwxr-xr-x. 5 root root    0 Jul 17 02:52 ..
> >>
> >> # From the 8352Y-based system:
> >> ls -lhat /sys/bus/event_source/devices/uncore_imc_free_running_0/event=
s
> >> total 0
> >> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.scale
> >> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.unit
> >> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.scale
> >> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.unit
> >> -r--r--r--. 1 root root 4.0K Aug 20 01:44 read.scale
> >> -r--r--r--. 1 root root 4.0K Aug 20 01:44 read.unit
> >> -r--r--r--. 1 root root 4.0K Aug 20 01:44 write.scale
> >> -r--r--r--. 1 root root 4.0K Aug 20 01:44 write.unit
> >> -r--r--r--. 1 root root 4.0K Aug 19 21:33 dclk
> >> -r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_read
> >> -r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_write
> >> -r--r--r--. 1 root root 4.0K Aug 19 21:33 read
> >> -r--r--r--. 1 root root 4.0K Aug 19 21:33 write
> >
> > This is 5 sysfs events, the json events are here:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-2D=
events_arch_x86_icelakex_uncore-2Dmemory.json-3Fh-3Dperf-2Dtools-2Dnext-23n=
134&d=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJ=
x661xzakrB42hsUsFD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DMrHuUCZF=
qrNrd05IPyq4fuZDH4_owkEw0xHcc7bvGvU&e=3D
> > Note, the "Unit", meaning the PMU should be imc_free_running to match
> > this device.
> >
> >> drwxr-xr-x. 2 root root    0 Aug 15 03:15 .
> >> drwxr-xr-x. 5 root root    0 Aug 15 02:42 ..
> >>
> >> Looking at the structure of __test_uncore_pmu_event_aliases, however,
> >> I'm not quite sure how this is supposed to work. I've annotated a walk
> >> through below to highlight where things are going off the rails.
> >>
> >> static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *t=
est_pmu)
> >> {
> >> ...
> >>        /* Count how many aliases we generated */
> >>        alias_count =3D perf_pmu__num_events(pmu);
> >>                // alias_count =3D=3D 4 in the 6154-based system
> >>                // alias_count =3D=3D 6 in the 8352Y-based system
> >>
> >>        /* Count how many aliases we expect from the known table */
> >>        for (table =3D &test_pmu->aliases[0]; *table; table++)
> >>                to_match_count++;
> >>                        // this is looking at aliases in struct perf_pm=
u_test_pmu
> >>                        // table, which for uncore_imc_0 is a single en=
try for
> >>                        // &uncore_imc_cache_hits.
> >>                        //
> >>                        // for the 8352Y case, likewise, we only have a=
 single alias
> >>                        // in the table for &uncore_imc_free_running_ca=
che_miss.
> >>                        //
> >>                        // in both cases, to_match_count =3D=3D 1
> >>
> >>        // Compare 4 vs 1 or 6 vs 1
> >>        if (alias_count !=3D to_match_count) {
> >>                pr_debug("testing aliases uncore PMU %s: mismatch expec=
ted aliases (%d) vs found (%d)\n",
> >>                         pmu_name, to_match_count /* 1 */, alias_count =
/* 4 */);
> >>                return -1;
> >>                        // we seemed doomed to hit this conditional alw=
ays, no?
> >>        }
> >> ...
> >> }
> >>
> >> I did a walkthrough of the latest mainline code, and don't see a marke=
d
> >> difference that jump off the page to me that'd correct this behavior,
> >> and would love a helping hand to point in the right direction on this.
> >>
> >> What am I missing here?
> >
> > I'll need some more time to dig into this. Hopefully the pointers above=
 help.
>
> Thanks for the quick reply and pointers, I appreciate it. The tricky bit =
still
> remains, as the code I posted to above seems to solely depend on the
> info filled into struct perf_pmu_test_pmu, right? If so, I don=E2=80=99t =
see how the
> dots connect from this test to the other events in sysfs/json=E2=80=99s.

So looking at the test it is using the testcpu:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/pmu-events.c?h=3Dperf-tools-next#n602
the json for that is here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/test/test_soc/cpu?h=3Dperf-tools-next
The names in the test are based on ones seen on real CPUs, so this may
be leading to the confusion.

Thanks,
Ian
