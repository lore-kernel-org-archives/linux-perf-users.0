Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394523ABA8
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230767; cv=pass; b=j+uomuF9jXgguhXGHG8YNJZUu8BlkaGWJrlY7mkSmgV41WtVVucoGYDYS5nY1c+ug48Qv0pAS48nAT1rd9VCb8sKUA46N0Wi9jeOP1Jzo9j9QdDhdK4U+tadZmAeF3mmTQjf9wc3r34k/wkV1+cQ6tzL2Vev7JontGraVBoYuyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230767; c=relaxed/simple;
	bh=FHsyMbg0FZTKl50XAM+xRDMKF852TM+wvnNu7d18Ji4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liTaMOT8QLoRAUg7ImkMQZwb99ibGXS3fHHknQqfmdkMbhvd7PTBZ9SvZsRnNPzsEcvBmPPofxTexLoiI/iSZ9rc5qiu4xBSeb3gOo614dZNZTi2hYZjJgASFtA7kbfvqNJxaWR2njZ9CEy7mEN7W2UGmJVC+yhQXsU0g3wzv3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Snxfsxdk; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Snxfsxdk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2591757fbso96285ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 08:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775230765; cv=none;
        d=google.com; s=arc-20240605;
        b=VS8CxqOmS3i+17VF62kK7pF4bhFydZA8Zdzxr5n+Vhr8KtUfczhsW4U5y8Hpyjnijs
         ziGE48U3KfNOlw0BxcVa8ITzFgLHU8WsEREvx3T7wgYMCR+BIxBAZLsfnduVvTFIPwY+
         EqCCenABb9wMXCxPBKkmTKDTz7DwF6U0Ip0u9s2poH+WK/uiXVOZM0E7MQXz6QJHy4Mk
         syU+q5hxnaHBfENWi+CDrZV86gY29tglR5Egcy8A5ZF4gfnZntvYXX1GxNNOLk4Bb1xM
         1UsZP1mv5kfoGxEJzvfbjf3QaXfDxKVwnC9ZH9t9IUx58Di1US9JeRKYmWpVDGK1QtYS
         yhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FhI+efbDFLiEonazJjgaQH+AZ3snthfw8f9lU+HywFw=;
        fh=JpVXpgEgaJjITdTezZKupiZJ/y8T76eyOguUZrbXnxM=;
        b=BrYvIapvmyPitMeNfO6Gj3c4t77nEssu5IXV6vsSA1kb+tY2oiEfFGrL5rKaVryEJQ
         lQuG/kaK6gHKsbsuGAZNbT058+eVnK1VzfVrPuib2piLW4RfGnHBUetSYO7mlRCSib9B
         REuPq96cwTyIE6eDqn1Pwx136pJx9gtNUCVbVRw5Io1J1l/TEEFVg7VVWXZkC5XkxsyQ
         ZltQDLH2uNReEtqqN1UFT6hb6GsoV3Q/aUmWXEBBaqYtzWYrS9YJhMkv7/l/bMl+NmMR
         ENzbMVnja3oCsPFHFVfGzoMAJH2qKqabvQWx/rtvWXWCQfV37oU0gYZXXLTQIyfsZwgD
         u5YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775230765; x=1775835565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhI+efbDFLiEonazJjgaQH+AZ3snthfw8f9lU+HywFw=;
        b=SnxfsxdkJ2LhwQuy+NviXk93kDrwSd4rAthFjQ55hYzz53njKJQnIv3BKEBe6hLJsI
         pS3vdGFoHnYsu7tTf9RuZWN2k1ivYgmiy7gpc9aV3C8dk3fn5chAvW25FxXZI6Cgn4g9
         CYacHV5MVxU8ZWQ98sfdCbiLrpiT6ljx+72U6s6JAC6sh1JmtLtPldsRfYCFzDkoc/9B
         QstCeIcHX/qojdKzFv8aaHIc4xCEIEAKtngMjvdsIIjhmjbx1vH/Q4P7ZBKw2wxTSYsC
         tqE4rBsrPtMdY+rCIA7m3peRqBXPios8WD72K08bVFqfX43BQ1AwzVqnW9UpLqcmPozP
         FZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230765; x=1775835565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhI+efbDFLiEonazJjgaQH+AZ3snthfw8f9lU+HywFw=;
        b=L0wCDXaeA5224Y4iQDRcn/1hyxc3aMsLoPWHMpoRxim/YMlxQc2kJcnVfu9NEPygpF
         LHyRzVpzJTKLSu/fu87EY4qPJFiqXbPXP+gbrfdimGsOS/fvTNlcbfAkpFO8qsR3FC+m
         8IIpknm6XqpS++PBA75o6CUrwQMY9wd2cN/SZMrwsp/JCZxyOjdWQqphODeC/bK1qAJZ
         Qe1bYXfBWT0MuzIuOwBF1R1+9R2Q9bm1DXIQ9/ep4WfRnLIdI8d5hBux4AxyHYUGPs1m
         T5ycIKr4tnglCKjYFQK5bef0++X1OXbi69IpmEYHXN2KPigN1je/CTygoC9XSRY2U4lB
         FoOw==
X-Forwarded-Encrypted: i=1; AJvYcCW/VnS3sE3yQpqxMEjeCaMYklEO/+Kk5fTusj7yzNZR0bb3iARQrgw8PttqLjYJJAI/00R3c4DR5FXfJE7wrbL9@vger.kernel.org
X-Gm-Message-State: AOJu0YyroCVmVdSiUl5TZlu4vwxt2trRyyk2I0D3LWoZqyO+WPcMbIS4
	JqOqRIR7b4uDyMs6ZxOvPjMvEnoQYpvFm0XsmTCji9s0YBgcmr1jaWbYLzboTao/YIScszWe1Ar
	weGYbLHKktlWUaare4gU6ihAsb+C3/pgTZY6YIJuv
X-Gm-Gg: AeBDievRiYk9z5N/OkDfIrApopUtwD+m11Sutp4iXjAlnHJmjgl4m4dQ3JlXny5QzCL
	b5bqDmLWETO6tSqHY6gtoFv3V6cktZtSEHldJQRxrvWjzEY3FrLBOjDg/d/WIO/7w0E7TW5LsWz
	h8AIDPObI0/96T6l71EqwBYOGOmH7uL94aZxpp7TZ3GAzZHTP4xk+5CSphwkQchgLO03b0olT+U
	Z9NmGdYOZ4JqWUSEvpOIwwn8I6q/2jax64pUWnUsLKZ81VcLrQgZ+1aU6D5iHc1ZTErPrb3VY3M
	ol9PMwiY
X-Received: by 2002:a17:903:22d1:b0:2ae:7fa2:6bda with SMTP id
 d9443c01a7336-2b283f049edmr1927905ad.1.1775230764064; Fri, 03 Apr 2026
 08:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com> <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ec33d914a3eb3f8cc1a0ad16bf877ff7284072c9.camel@intel.com> <cf702c86-7dea-44af-8dd2-0c27e19da1b5@linux.intel.com>
In-Reply-To: <cf702c86-7dea-44af-8dd2-0c27e19da1b5@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Apr 2026 08:39:10 -0700
X-Gm-Features: AQROBzA-FV3lZ8eXXN_-IIy5A-zCuhgDBacFdsKJ5rl_ORv9FOTKguhRMX3ukUY
Message-ID: <CAP-5=fWR6v7kKSMVD+ANwMTmOdc4zKLEVY+9tNR5n+kq0F=Mkg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, "Falcon, Thomas" <thomas.falcon@intel.com>, 
	"Kleen, Andi" <andi.kleen@intel.com>
Cc: "atrajeev@linux.ibm.com" <atrajeev@linux.ibm.com>, 
	"venkat88@linux.ibm.com" <venkat88@linux.ibm.com>, "Shivani.Nittor@ibm.com" <Shivani.Nittor@ibm.com>, 
	"tmricht@linux.ibm.com" <tmricht@linux.ibm.com>, 
	"hbathini@linux.vnet.ibm.com" <hbathini@linux.vnet.ibm.com>, "mpetlan@redhat.com" <mpetlan@redhat.com>, 
	"Tanushree.Shah@ibm.com" <Tanushree.Shah@ibm.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"maddy@linux.ibm.com" <maddy@linux.ibm.com>, "Chen, Zide" <zide.chen@intel.com>, 
	"vmolnaro@redhat.com" <vmolnaro@redhat.com>, "Tejas.Manhas1@ibm.com" <Tejas.Manhas1@ibm.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "acme@kernel.org" <acme@kernel.org>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>, 
	"namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 12:36=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 4/3/2026 1:32 AM, Falcon, Thomas wrote:
> > On Wed, 2026-04-01 at 13:40 -0700, Ian Rogers wrote:
> >> On Mon, Mar 23, 2026 at 3:40=E2=80=AFAM Venkat <venkat88@linux.ibm.com=
>
> >> wrote:
> >>>
> >>>
> >>>> On 15 Mar 2026, at 4:27=E2=80=AFPM, Athira Rajeev
> >>>> <atrajeev@linux.ibm.com> wrote:
> >>>>
> >>>> Currently in "perf all PMU test", for "perf stat -e <event>
> >>>> true",
> >>>> below checks are done:
> >>>> - if return code is zero, look for "not supported" to decide pass
> >>>>  scenario
> >>>> - check for "not supported" to ignore the event
> >>>> - looks for "No permission to enable" to skip the event.
> >>>> - If output has "Bad event name", fail the test.
> >>>> - Use "Access to performance monitoring and observability
> >>>> operations is
> >>>>  limited." to ignore fail due to access limitations
> >>>>
> >>>> If we failed to see event and it is supported, retries with
> >>>> longer
> >>>> workload "perf bench internals synthesize".
> >>>> - Here if output has <event>, the test is a pass.
> >>>>
> >>>> Snippet of code check:
> >>>>  ```
> >>>>  output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> >>>>  if echo "$output" | grep -q "$p"
> >>>>  ```
> >>>> - if output doesn't have event printed in logs, considers it
> >>>> fail.
> >>>>
> >>>> But this results in false pass for events in some cases.
> >>>> Example, if perf stat fails as below:
> >>>>
> >>>> # ./perf stat -e pmu/event/  true
> >>>> event syntax error: 'pmu/event/'
> >>>>                     \___ Bad event or PMU
> >>>>
> >>>> Unable to find PMU or event on a PMU of 'pmu'
> >>>> Run 'perf list' for a list of valid events
> >>>>
> >>>>  Usage: perf stat [<options>] [<command>]
> >>>>
> >>>>    -e, --event <event>   event selector. use 'perf list' to list
> >>>> available events
> >>>> # echo $?
> >>>> 129
> >>>>
> >>>> Since this has non-zero return code and doesn't have the
> >>>> fail strings being checked in the test, it will enter check using
> >>>> longer workload. and since the output fail log has event, it
> >>>> declares test as "supported".
> >>>>
> >>>> Since all the fail strings can't be added in the check, update
> >>>> the testcase to check return code before proceeding to longer
> >>>> workload run.
> >>>>
> >>>> Another missing scenario is when system wide monitoring is
> >>>> supported
> >>>> example:
> >>>> # ./perf stat -e pmu/event/ true
> >>>> Error:
> >>>> No supported events found.
> >>>>  Unsupported event (pmu/event/H) in per-thread mode, enable
> >>>> system wide with '-a'.
> >>>>
> >>>> Update testcase to check with "perf stat -a -e $p" as well
> >>>>
> >>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> >>>> ---
> >>> Tested this patch.
> >>>
> >>>
> >>> With this patch:
> >>>
> >>> Testing hv_24x7/CPM_ADJUNCT_INST/ -- perf stat failed with non-zero
> >>> return code
> >>> Testing hv_24x7/CPM_ADJUNCT_PCYC/ -- perf stat failed with non-zero
> >>> return code
> >>>
> >>>
> >>>
> >>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >> Testing on an Intel Alderlake the test is now failing:
> >> ```
> >> ...
> >> Testing offcore_requests_outstanding.l3_miss_demand_data_rd --
> >> supported
> >> Testing ocr.full_streaming_wr.any_response -- perf stat failed with
> >> non-zero return code
> >> Testing ocr.partial_streaming_wr.any_response -- perf stat failed
> >> with
> >> non-zero return code
> >> Testing ocr.streaming_wr.any_response -- supported
> >> ...
> >> ```
> >>
> >> Running `perf stat` manually reveals an issue with the event:
> >> ```
> >> $ sudo perf stat -vv -e ocr.full_streaming_wr.any_response -a sleep
> >> 1
> >> Using CPUID GenuineIntel-6-B7-1
> >> Attempt to add: cpu_atom/ocr.full_streaming_wr.any_response/
> >> ..after resolving event:
> >> cpu_atom/event=3D0xb7,period=3D0x186a3,umask=3D0x1,offcore_rsp=3D0x800=
0000100
> >> 00/
> >> ocr.full_streaming_wr.any_response ->
> >> cpu_atom/ocr.full_streaming_wr.any_response/
> >> Control descriptor is not initialized
> >> ------------------------------------------------------------
> >> perf_event_attr:
> >>  type                             10 (cpu_atom)
> >>  size                             144
> >> ------------------------------------------------------------
> >> perf_event_attr:
> >>  type                             0 (PERF_TYPE_HARDWARE)
> >>  config                           0xa00000000
> >> (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
> >>  disabled                         1
> >> ------------------------------------------------------------
> >> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
> >> ------------------------------------------------------------
> >> perf_event_attr:
> >>  type                             0 (PERF_TYPE_HARDWARE)
> >>  config                           0x400000000
> >> (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
> >>  disabled                         1
> >> ------------------------------------------------------------
> >> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
> >>  config                           0x1b7
> >> (ocr.demand_data_rd.l3_hit.snoop_hit_no_fwd)
> >>  sample_type                      IDENTIFIER
> >>  read_format
> >> TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >>  disabled                         1
> >>  inherit                          1
> >>  { bp_addr, config1 }             0x800000010000
> >> ------------------------------------------------------------
> >> sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8
> >> sys_perf_event_open failed, error -22
> >> switching off deferred callchain support
> >> Warning:
> >> ocr.full_streaming_wr.any_response event is not supported by the
> >> kernel.
> >> The sys_perf_event_open() syscall failed for event
> >> (ocr.full_streaming_wr.any_response): Invalid argument
> >> "dmesg | grep -i perf" may provide additional information.
> >>
> >> Error:
> >> No supported events found.
> >> The sys_perf_event_open() syscall failed for event
> >> (ocr.full_streaming_wr.any_response): Invalid argument
> >> "dmesg | grep -i perf" may provide additional information.
> >> ```
> >>
> >> This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?
>
> Hmm, it looks the error is caused by the invalid bitmask of OFFCORE_RSP_x
> MSRs. Currently the valid bitmask of OFFCORE_RSP_x MSR is set to
> 0x3fffffffff in intel_grt_extra_regs[], while the msr value is set
> 0x800000010000 for the ocr.full_streaming_wr.any_response event. The bit =
47
> is recognized an invalid bit and then abort the event creation.
>
> Base on the description "Table 21-56. MSR_OFFCORE_RSPx Request Type
> Definition" in SDM, bit 47 should be a valid bit now. Suppose bit 47 shou=
ld
> not be a valid bit when adding the ADL PMU support, but it's updated and
> becomes valid later.
>
> Along with the constant updates of perf event lists
> (https://github.com/intel/perfmon), we have noticed there are mismatches
> more or less between the driver hardcoded events and perfmon event list.
> Currently we are summarizing the mismatches. Once these mismatches are
> finalized. we would submit a patchset to fix these mismatches.

That's great, if it takes too long perhaps we could just remove the
events for now.

Thanks,
Ian

> Thanks.
>
> > +Dapeng, Zide, Andi
> >
> > Thanks,
> > Tom
> >
> >> Thanks,
> >> Ian
> >>
> >>> Regards,
> >>> Venkat.
> >>>
> >>>
> >>>
> >>>> tools/perf/tests/shell/stat_all_pmu.sh | 20 ++++++++++++++++++++
> >>>> 1 file changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh
> >>>> b/tools/perf/tests/shell/stat_all_pmu.sh
> >>>> index 9c466c0efa85..6c4d59cbfa5f 100755
> >>>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> >>>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> >>>> @@ -53,6 +53,26 @@ do
> >>>>     continue
> >>>>   fi
> >>>>
> >>>> +  # check with system wide if it is supported.
> >>>> +  output=3D$(perf stat -a -e "$p" true 2>&1)
> >>>> +  stat_result=3D$?
> >>>> +  if echo "$output" | grep -q "not supported"
> >>>> +  then
> >>>> +    # Event not supported, so ignore.
> >>>> +    echo "not supported"
> >>>> +    continue
> >>>> +  fi
> >>>> +
> >>>> +  # checked through possible access limitations and permissions.
> >>>> +  # At this step, non-zero return code from "perf stat" needs to
> >>>> +  # reported as fail for the user to investigate
> >>>> +  if [ $stat_result -ne 0 ]
> >>>> +  then
> >>>> +    echo "perf stat failed with non-zero return code"
> >>>> +    err=3D1
> >>>> +    continue
> >>>> +  fi
> >>>> +
> >>>>   # We failed to see the event and it is supported. Possibly the
> >>>> workload was
> >>>>   # too small so retry with something longer.
> >>>>   output=3D$(perf stat -e "$p" perf bench internals synthesize
> >>>> 2>&1)
> >>>> --
> >>>> 2.47.3
> >>>>
