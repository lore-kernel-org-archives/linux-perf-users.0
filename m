Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887335B138
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076062; cv=pass; b=vCUAjW10WfVCn5vERj046JgI8dY1Lh8gMoCMwijdAfytU0is3euExC+meWtsFyi05z9ZEjwcfaWb4AbLtzEMpZiRf0SR3YfbYtR8lkUp+Yap7r1W90xPAzCkC7Lo2K8M87Jrg439d0PWJMjBiIgi2W2+4qEtxmOA21gEPyNUfQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076062; c=relaxed/simple;
	bh=1GCNYeJaTGrTTC6MOMS3VIk+Hr3glBrGSPbjTinHeYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSNnKulLO7j4MasGdnoSapc3ATFzO28Zr+q8K5XoqqplGBpve9Dz2s75lvV5K+L4njiTuQkBED1F2iN3b0xy3n6SaHS0KWQKd1hh61kMXKA8iamaNuepcK7LVK6opgacQwjA8Y7FckSpFQO4aUFx1gaQs/tIhRihs8pgRBJiqLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WP0mqj+E; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WP0mqj+E"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2591757fbso33515ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 13:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775076060; cv=none;
        d=google.com; s=arc-20240605;
        b=Ct+mwkmcEEyG1v/ETheZHyYoykGrUAs6VkoKRa4qRt8GRDUprnomhfks4O2U8LYSSv
         BXSzIK3h83VpfzonaF6fz07rObekRpUtJDSehU+gmUrKmdyy1kBfYwkCmpTJuETFP8pQ
         sfkjcxDNnsl8F0Rpl1OkZbr44s80Om0B+oEloFHnGyYVNDIgXweu0xVuWRC7sAWKCUYo
         Xu2W1TbCqy8VMJ435arNWRj0DYZoxjooqF+tlyP5/04TfVvyS0345dFc/gPaflhf5h+o
         r5KCAUZ69qez+Ad03FmeddG2jzQ6qaSEWslkEDbLampAmIkQDP/dbA3ioqjGjZIZj8GP
         aNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=951WrjawRqq3nzkew3xFf8UWz29OPoL5LGFETUE8lmQ=;
        fh=hnDnY2oo86r1wvsaJlGX+MxYm/0e23n+NB8WYTS+MVg=;
        b=L/NvEfGfriszRlgzQ/u/NAgDjA/jJWoX3BlzYIThwGMyc/esMxJ1IrksRGk1ZdzVfW
         fI5TI7GQ3zpEYenUbwX1tvKZnWphBE0+ydaQWjRpiSwAJfiMdGoE37fUtqFJREh05+NO
         5EoCu2YnwuN1rU3p/QPvMVeq81l+V2TVj2gW3vibgspSK3ifLqWG7gs6tCbT4ZAsFG5I
         JviHFwVBw4rAhbIZXI9nKNMo8+fQXE7ftfSelxQMKR2Hx9VKDiz2EOKR9wKuSA6kDywe
         UcgZ7Fg8SJmWY75uL2nRycyDf/LOTPDK2nIsFbKJPbU/3oUJx8K5BQyq/1F/Kkm3Wg9Q
         oyYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775076060; x=1775680860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=951WrjawRqq3nzkew3xFf8UWz29OPoL5LGFETUE8lmQ=;
        b=WP0mqj+ETn3nHyzlbeq1BshaSTBQQggCcdgHyWsrz+iH+CXfbvqGhmDxD4IoGiDKJ+
         MjgH1Jo73jyLWuJSBSOeBR56Pe7/99p1lyP8lrsjFFZE7CK4kJpISDq/KVKDS9pE/fHe
         /9ATV1SASmPzH1ZvIBYuyCIpdF/8IkjCxfqMZ2XVqkGfoqwu1UiBh7vQWPFMpl2B0/bA
         nPBgvmgZ0arGYBJFBb0Ji2Rl/BFWNb7EWUzC0QAF2X98F+1mRPbu/WPA2RAKkwJIZp2p
         IXW5qzFRy1RmtmPj1KY6dhIYkvzrdBFq1rjgOVe6Mzupirp+XSuGV6f/xWpryCcf08yB
         qFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076060; x=1775680860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=951WrjawRqq3nzkew3xFf8UWz29OPoL5LGFETUE8lmQ=;
        b=nh53oePeKSU3RV0MhuQYSDZi+zPFXCVuMLgnHnbkLX/muIxCeWLimFGHcqEu39xSeV
         pNIp1wHht2G/OFiQtCtBjJac7QrreTb08v8ZEIF8ALs9Adjajt86r5WBaxqVE73QZl3O
         JoRlnRQe45cq7e9AcojvXBoIf2WlRMWYc7aU7wYRbjKwSuOfLN1XZPRsMOsBEiFEkPc5
         kKFGw55ZBoopIpS2lqZe19JxaCytWfA+qP3BqxqDqbwCmeGczfOsau0DAqNHRPOewZJL
         dqzeRn9sOC9m1cdqF0BV58GaDD0JrIPBvLRp6KFjV0KEwB+8QXxIgUaZ99ppohop/Rhb
         7bvw==
X-Forwarded-Encrypted: i=1; AJvYcCXJkD+G9XYMBcCJKfPTkAorZIrajCb9XhMX49WvosZZS1YsMp28/vdVaQmAD1cJGGDYg6OHi6zXua8bekqHRhiC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx36sCreM5ZcdMuQk5n0jPoluMuaHHiXMgoB0cbueFELQmCbDPf
	74CrTBVncdC0n2b5MsKCPMDAC988WZPP+p5sg8L85MdytyE0tGb7qvegX7bAo/WihffmVFSES7P
	DVEAw+vJkBhSflA1DrNX/aCqX1Yy+FZX+iey4bYGA
X-Gm-Gg: ATEYQzwGeNV2DgglDX+TF4psm+0yASGY7db2zJxxBbaNqO4eZ3LB+VX/xUqj3Iwbvyk
	W2ZPOTfzp+A4VrOLvFQp1HdG9xkDm5LFbA2y/K388lKHw0p0uaKTofHhu0rFY8svIt9BwplZ1x9
	rFRxxuT2yZe4t26JWqsPENsDKARTtt+pW4TyByQGJa+ITzkOMXGXWURcM4xeVZmFxpp4SUOfB3Z
	WftNoUKttslu4GfLVXhFJNgD1llkrLCx31aPPaiDZMcS5bCkaqr4KI2JYApik1CEusMIORJEFgc
	jpqXCL449+QKwScKFDoFFuKOYyzzRkAQx6JNTkeDTtz1RxE=
X-Received: by 2002:a17:903:1a2d:b0:2ae:7fa2:6bda with SMTP id
 d9443c01a7336-2b2769b0742mr500905ad.1.1775076059588; Wed, 01 Apr 2026
 13:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315105751.86835-1-atrajeev@linux.ibm.com> <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
In-Reply-To: <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:40:47 -0700
X-Gm-Features: AQROBzCsIQ5u20S1ffg6GKC2eZ2mM6neoKCEoseeulqZUJEM_EM8Ddw4PtA3mMI
Message-ID: <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
To: Venkat <venkat88@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 3:40=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
>
>
> > On 15 Mar 2026, at 4:27=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
> >
> > Currently in "perf all PMU test", for "perf stat -e <event> true",
> > below checks are done:
> > - if return code is zero, look for "not supported" to decide pass
> >  scenario
> > - check for "not supported" to ignore the event
> > - looks for "No permission to enable" to skip the event.
> > - If output has "Bad event name", fail the test.
> > - Use "Access to performance monitoring and observability operations is
> >  limited." to ignore fail due to access limitations
> >
> > If we failed to see event and it is supported, retries with longer
> > workload "perf bench internals synthesize".
> > - Here if output has <event>, the test is a pass.
> >
> > Snippet of code check:
> >  ```
> >  output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> >  if echo "$output" | grep -q "$p"
> >  ```
> > - if output doesn't have event printed in logs, considers it fail.
> >
> > But this results in false pass for events in some cases.
> > Example, if perf stat fails as below:
> >
> > # ./perf stat -e pmu/event/  true
> > event syntax error: 'pmu/event/'
> >                     \___ Bad event or PMU
> >
> > Unable to find PMU or event on a PMU of 'pmu'
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >    -e, --event <event>   event selector. use 'perf list' to list availa=
ble events
> > # echo $?
> > 129
> >
> > Since this has non-zero return code and doesn't have the
> > fail strings being checked in the test, it will enter check using
> > longer workload. and since the output fail log has event, it
> > declares test as "supported".
> >
> > Since all the fail strings can't be added in the check, update
> > the testcase to check return code before proceeding to longer
> > workload run.
> >
> > Another missing scenario is when system wide monitoring is supported
> > example:
> > # ./perf stat -e pmu/event/ true
> > Error:
> > No supported events found.
> >  Unsupported event (pmu/event/H) in per-thread mode, enable system wide=
 with '-a'.
> >
> > Update testcase to check with "perf stat -a -e $p" as well
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> > ---
>
> Tested this patch.
>
>
> With this patch:
>
> Testing hv_24x7/CPM_ADJUNCT_INST/ -- perf stat failed with non-zero retur=
n code
> Testing hv_24x7/CPM_ADJUNCT_PCYC/ -- perf stat failed with non-zero retur=
n code
>
>
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Testing on an Intel Alderlake the test is now failing:
```
...
Testing offcore_requests_outstanding.l3_miss_demand_data_rd -- supported
Testing ocr.full_streaming_wr.any_response -- perf stat failed with
non-zero return code
Testing ocr.partial_streaming_wr.any_response -- perf stat failed with
non-zero return code
Testing ocr.streaming_wr.any_response -- supported
...
```

Running `perf stat` manually reveals an issue with the event:
```
$ sudo perf stat -vv -e ocr.full_streaming_wr.any_response -a sleep
1
Using CPUID GenuineIntel-6-B7-1
Attempt to add: cpu_atom/ocr.full_streaming_wr.any_response/
..after resolving event:
cpu_atom/event=3D0xb7,period=3D0x186a3,umask=3D0x1,offcore_rsp=3D0x80000001=
0000/
ocr.full_streaming_wr.any_response ->
cpu_atom/ocr.full_streaming_wr.any_response/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
 type                             10 (cpu_atom)
 size                             144
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 config                           0xa00000000
(cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
 disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 config                           0x400000000
(cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
 disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
 config                           0x1b7
(ocr.demand_data_rd.l3_hit.snoop_hit_no_fwd)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 { bp_addr, config1 }             0x800000010000
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off deferred callchain support
Warning:
ocr.full_streaming_wr.any_response event is not supported by the kernel.
The sys_perf_event_open() syscall failed for event
(ocr.full_streaming_wr.any_response): Invalid argument
"dmesg | grep -i perf" may provide additional information.

Error:
No supported events found.
The sys_perf_event_open() syscall failed for event
(ocr.full_streaming_wr.any_response): Invalid argument
"dmesg | grep -i perf" may provide additional information.
```

This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?

Thanks,
Ian

> Regards,
> Venkat.
>
>
>
> > tools/perf/tests/shell/stat_all_pmu.sh | 20 ++++++++++++++++++++
> > 1 file changed, 20 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/=
shell/stat_all_pmu.sh
> > index 9c466c0efa85..6c4d59cbfa5f 100755
> > --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > @@ -53,6 +53,26 @@ do
> >     continue
> >   fi
> >
> > +  # check with system wide if it is supported.
> > +  output=3D$(perf stat -a -e "$p" true 2>&1)
> > +  stat_result=3D$?
> > +  if echo "$output" | grep -q "not supported"
> > +  then
> > +    # Event not supported, so ignore.
> > +    echo "not supported"
> > +    continue
> > +  fi
> > +
> > +  # checked through possible access limitations and permissions.
> > +  # At this step, non-zero return code from "perf stat" needs to
> > +  # reported as fail for the user to investigate
> > +  if [ $stat_result -ne 0 ]
> > +  then
> > +    echo "perf stat failed with non-zero return code"
> > +    err=3D1
> > +    continue
> > +  fi
> > +
> >   # We failed to see the event and it is supported. Possibly the worklo=
ad was
> >   # too small so retry with something longer.
> >   output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> > --
> > 2.47.3
> >
>
