Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00F1459F6
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Aug 2024 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724132524; cv=none; b=QPjeLSjgwI9pDtrVu3B05c/IzaQMNqYpgVR4+6IGTy6/VUdaUKWwClAS3CZl9IZF03zIqGOQAUTIFN6xQFw0LEQrw4SrhSQnWPUbOc8h1nHF4o2UKaoOgVxCzvro3RBnElG1RWYPkNpGsgTjQKDARvzj7XWj+9teDRY3vvtJ63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724132524; c=relaxed/simple;
	bh=5mECyQMWCA4UoldcrDVE778to70b3gZuWOt0A2mVTgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qY3luyPSEYfkAUSNDbGkQaJA9IQEGnp4nAFTFL6T7byfKi+hOB7qDzlN7RcjOcYTPzXNi4lPwN2fTJP1GyxEbBziUj3NxpfVa6dzmfCD0EEL47CnvEbz35pMm0cSI8SKot6Mllv50ml5WZk7vwCla6qsexZYCVdka6WHf52ZqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4TGZEFr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4TGZEFr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-202018541afso46315ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 22:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724132522; x=1724737322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sXlKMgezFk9YmzRqDAumjH2NXxbyGsXE/M0JdVh6XI=;
        b=i4TGZEFrIO6MFN8eFPMUEEAX9XzxrNz08yllNsWXiSbbrHmm19Sb1x+v2Q2QXcQxKv
         Wss3TTKXamZRI9pGOzbuX0neOv0g05ZaBGAKxoAY3Dy5Nq5Obmf78TGmWAgXheaQ73Qa
         nk0MjOrTHkHjoymGOArYl4CqyzPGJLNcVJ0itMR+Gd6Wv85RI23Z3UMRGq5BJoqmSZSX
         ZOqQcSkS7/6Q4tOSxRSIRgEz2v42vzPE6hYYRObKff7tsV8MXTd+CjdqLAIko7z5T8j1
         fY02mSRKKEz3pv3690+MWlETrnvMfqlKvjC4w6qOwawNgXdUHS4daDlzrrimwQhS1L5r
         5qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724132522; x=1724737322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sXlKMgezFk9YmzRqDAumjH2NXxbyGsXE/M0JdVh6XI=;
        b=f98RJLeKEZhknsvGp+pQXATCtzLOmo2zz5f7fTqZ/g06yCoCtMeG7Z2ZUx05kwoZqt
         3Gik27Nt1z9Aszvu555TBXkpXWd5e8Uw6Bk0o00p0abtp1CTOSqdOciCmJEeSDS368BA
         0hZ5tjgjcRONiMGcAwawk1aDrIBMOKZJFawZtGHVC2FGVNFQmpMo2QkzILSBqMGj7Bhf
         XxIWoH4MjqEaoD4RMVFNvvtmqO7yB5IfyRW+O96022j+hLwGRmE5GocMFnFtnewu77xo
         qI+L0it54DJ+8Wxp/TqOfOiNersQT5Gw4Xt+tDcuk1ZELIQRi7gVQtdc6/8hvELoFmpx
         ij0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT7xjuFzml/REra9a0Hy3yNjxFvrdbwEjj7R5xWNTPSeBT9di7a6sv9gLWUCcTVvGpno1zABPoYhHp/EbAS57Om+7HkrwbqGdQyEn7NuqWTQ==
X-Gm-Message-State: AOJu0YwwpSTO6xdi3j0Y5uTXl2bRdJE68NrV9Lxk3HfIZfdPc9bkNXv6
	Mvg7lfZNr7k+EBDBZUbYeynWkerUXayRUVh5QYVE/pWZvRvq5X1tmuaibLWfiGsBXXE6YKYklJw
	DHCDf5VHpoPpw6t1oeJJ0jYfSMx4uBfw3+PsM
X-Google-Smtp-Source: AGHT+IF4A/aUKQUbevp/C7WmTZ8eYCM8cnrCJmPc2q7c7pOtV9iekmj8oJhbOQgDd8ORQb+thaUpWv3h/iMKvFu0YsA=
X-Received: by 2002:a17:902:ec83:b0:1fd:6c5b:afcd with SMTP id
 d9443c01a7336-202e629dfb1mr823495ad.22.1724132521033; Mon, 19 Aug 2024
 22:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05E55194-C265-4BDA-911D-B9E57EED3CBB@nutanix.com>
In-Reply-To: <05E55194-C265-4BDA-911D-B9E57EED3CBB@nutanix.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Aug 2024 22:41:49 -0700
Message-ID: <CAP-5=fUndbBhSLb35_bL-+Xu3erB6ssx-sAEYaf7mgxPawNEbA@mail.gmail.com>
Subject: Re: Perf test failures for 10.2 PMU event map aliases
To: Jon Kohler <jon@nutanix.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 7:06=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
> Reaching out to the perf community for feedback on the following
> observed test failure. On 6.6.y, I see persistent failures with test
> 10.2 PMU event map aliases, complaining about testing aliases uncore
> PMU mismatches. I've included two outputs below, one with a bit of
> hacky print debugging.
>
> Using Intel(R) Xeon(R) Gold 6154 CPU:
>         10.2: PMU event map aliases                                      =
   :
>         --- start ---
>         test child forked, pid 962901
>         Using CPUID GenuineIntel-6-55-4

Hi Jon,

Sorry for the brief reply but I thought some quick hints might unblock
you on this. The CPUID lines up with a SkylakeX:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/mapfile.csv?h=3Dperf-tools-next#n33

>         testing core PMU cpu aliases: pass
>         JKDBG: pmu nr total 3 pmu->sysfs_aliases 3 pmu->sys_json_aliases =
0
>         JKDBG: pmu cpu_aliases_added nr total 4 pmu->cpu_json_aliases 1
>         testing aliases uncore PMU uncore_imc_0: mismatch expected aliase=
s
>           (1) vs found (4)
>         test child finished with -1
>         ---- end ----
>         PMU events subtest 2: FAILED!
>
> Using Intel(R) Xeon(R) Platinum 8352Y:
>         10.2: PMU event map aliases                                      =
   :
>         --- start ---
>         test child forked, pid 1765070
>         Using CPUID GenuineIntel-6-6A-6

This is an IcelakeX:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/mapfile.csv?h=3Dperf-tools-next#n18

>         testing core PMU cpu aliases: pass
>         testing aliases uncore PMU uncore_imc_free_running_0: mismatch
>           expected aliases (1) vs found (6)
>         test child finished with -1
>         ---- end ----
>         PMU events subtest 2: FAILED!
>
> Digging in more, looking at pmu_aliases_parse, I see that we'll discard
> scale and unit files in pmu_alias_info_file, which leaves us with 3x
> aliases in the uncore_imc_0 in the first case and 5x aliases in the
> uncore_imc_free_running_0 second case.
>
> # From 6154-based system:
> ls -lhat /sys/devices/uncore_imc_0/events

The "uncore_" prefix and the "_0" suffix are optional, the naming
matching is case insensitive. In the event json the events are listed
here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json?h=3Dperf-tool=
s-next

> total 0
> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.scale
> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.unit
> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.scale
> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.unit
> -r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_read
> -r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_write
> -r--r--r--. 1 root root 4.0K Aug  9 15:30 clockticks

This should be 3 sysfs events (I don't like the term alias), note that
we load the sysfs and json events lazily to avoid overhead.

> drwxr-xr-x. 2 root root    0 Jul 17 03:40 .
> drwxr-xr-x. 5 root root    0 Jul 17 02:52 ..
>
> # From the 8352Y-based system:
> ls -lhat /sys/bus/event_source/devices/uncore_imc_free_running_0/events
> total 0
> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.scale
> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.unit
> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.scale
> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.unit
> -r--r--r--. 1 root root 4.0K Aug 20 01:44 read.scale
> -r--r--r--. 1 root root 4.0K Aug 20 01:44 read.unit
> -r--r--r--. 1 root root 4.0K Aug 20 01:44 write.scale
> -r--r--r--. 1 root root 4.0K Aug 20 01:44 write.unit
> -r--r--r--. 1 root root 4.0K Aug 19 21:33 dclk
> -r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_read
> -r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_write
> -r--r--r--. 1 root root 4.0K Aug 19 21:33 read
> -r--r--r--. 1 root root 4.0K Aug 19 21:33 write

This is 5 sysfs events, the json events are here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json?h=3Dperf-tool=
s-next#n134
Note, the "Unit", meaning the PMU should be imc_free_running to match
this device.

> drwxr-xr-x. 2 root root    0 Aug 15 03:15 .
> drwxr-xr-x. 5 root root    0 Aug 15 02:42 ..
>
> Looking at the structure of __test_uncore_pmu_event_aliases, however,
> I'm not quite sure how this is supposed to work. I've annotated a walk
> through below to highlight where things are going off the rails.
>
> static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test=
_pmu)
> {
> ...
>         /* Count how many aliases we generated */
>         alias_count =3D perf_pmu__num_events(pmu);
>                 // alias_count =3D=3D 4 in the 6154-based system
>                 // alias_count =3D=3D 6 in the 8352Y-based system
>
>         /* Count how many aliases we expect from the known table */
>         for (table =3D &test_pmu->aliases[0]; *table; table++)
>                 to_match_count++;
>                         // this is looking at aliases in struct perf_pmu_=
test_pmu
>                         // table, which for uncore_imc_0 is a single entr=
y for
>                         // &uncore_imc_cache_hits.
>                         //
>                         // for the 8352Y case, likewise, we only have a s=
ingle alias
>                         // in the table for &uncore_imc_free_running_cach=
e_miss.
>                         //
>                         // in both cases, to_match_count =3D=3D 1
>
>         // Compare 4 vs 1 or 6 vs 1
>         if (alias_count !=3D to_match_count) {
>                 pr_debug("testing aliases uncore PMU %s: mismatch expecte=
d aliases (%d) vs found (%d)\n",
>                          pmu_name, to_match_count /* 1 */, alias_count /*=
 4 */);
>                 return -1;
>                         // we seemed doomed to hit this conditional alway=
s, no?
>         }
> ...
> }
>
> I did a walkthrough of the latest mainline code, and don't see a marked
> difference that jump off the page to me that'd correct this behavior,
> and would love a helping hand to point in the right direction on this.
>
> What am I missing here?

I'll need some more time to dig into this. Hopefully the pointers above hel=
p.

Thanks,
Ian
