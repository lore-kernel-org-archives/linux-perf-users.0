Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93EA926
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Mar 2025 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789376; cv=none; b=Racr1XSfrT1gATrZ+FHtYpvOSR0gsDR5yNbtchwIzgL1H2ZZ9JXxZmFOQ9cCfFR7QMf3ECToJYTc+tVw0VkULkOVMKJ9SXQPrCm1twlfW22ZrnoTELfv9MzlLOQpSK0IsmyhLcoyWxAyJC+74BhhtDEEjBotjDep5qEpqMMPntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789376; c=relaxed/simple;
	bh=2BrZxxNprGoxzLNC8/zcwyN9B35uloLJtrb+1opII4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NONeWWTk4O1Adn44Ta5f1GTV41M3YwfnekWIjLv8TEGj/yS6zGO8HMKA2nx9r3r1LlNyXT9mM7IXZfLIvg9b4IlWSyh7LUYwNGa1c8gdy3w4N/79EaQvrRV2sVej2ZdUkhdaXc6SwsIC5pZDCSG3V9Xh0i45jjD74b5KFpCfPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQgdwNKW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQgdwNKW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212222d4cdso68205ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 16:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740789374; x=1741394174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhZuBN/9mPGzSLbve08MvU9t9kKFyaph33uC3d3/RVo=;
        b=hQgdwNKW82yV5eCuyXHNuHgecbQ2P+5ROODqnbBCQZK/TVElnVbFuMB1II7RKOspeZ
         5z0yOr0Z1bKaZcRY7H8ZSVA82n2M1Y2YpqE5i7dXhHso7Ghb4mCz5SfOhddhdHyqCCmv
         qZLyjpAlTmrc6DlEGDChuP6UI6COZPR6O6eiSxYhhh0pT8oZWGiL6bNIU7W4E2Urqns2
         qTed/b0rzIb7DOSAIUi+b7vJtrhZc48XqUvVUmLxvtjcE5tiGSahTCaMyqIeDU2Vvnrs
         ZpAwxC0bJD/JBp85zuVdnK5+rjScVor9SpR1Ui6Y8uKEmNvCq5ELb8ax/pVKvNlprKU+
         bGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740789374; x=1741394174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhZuBN/9mPGzSLbve08MvU9t9kKFyaph33uC3d3/RVo=;
        b=NkUTgyXkSGqZUKRz7zi62lwOSdOtVUtTUHtJ/PTuTEXpA0YSa6YM4RdYp37Jb0Otgd
         CqUAPB5/K3j/fmzFKq7WQ31xdI2EKxSVGQjPdFBvThitcGbWVY9/xoU6dgqeqT8Ulg5X
         kt1ZR6SLdI6ulsNKjgn53fueAGfYtDRn0VX3/Os8ogeztor/JLafEjsY+9hl/DUeQMl6
         DubrIvbf2cQd9wgu006gR97rn1044xt0hG5rXdnRujToJOlf3VBOzfZmMO13/rUccVMY
         +pML8wTyUrCxRM1kEU4MVVBtWxgS7JJFUtAi1qfdKkr/LnVMGxMT+FiAsY4g6TnEjAOB
         xOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Djfv9nXDiLURjcBfSu2rJvsdGqU8C6m/A3rWvZKCBPhloDJsBVM3SIYINDj2qVTPtpqtsg0jMu3MJvjZMYrc@vger.kernel.org
X-Gm-Message-State: AOJu0YxznTLzG87gtOJlvJzlXf2CMa9SCN5QCPlBGuHsePi2zEqW5zcc
	s44kCGARrKPRZGkLg0ixNgZi1bcNlDOvCiiKmlYIJJAjBq0Bf9QvoW4tCacSK5GulGdy1wrvd9r
	RTntuqXiJ6K04HofUMCR7PvPmWZU/mwjeKWZw
X-Gm-Gg: ASbGncsDOn/6IRHaYADT04mcjQrkWfFNyGZDRNoCGZaKJeTBj5MOE6PgpdNd2WNs8HM
	0pnqBQUrxMY59ghJNgi6kypazoNIJZ+l2XF2NMtHmWCDepJGGziYxAAZaCgttwTr2paVPAE3bq3
	1y2QKoElj45c5hejpqP705bF2z7Fc=
X-Google-Smtp-Source: AGHT+IH6/MjikxHqgtWJQlJWlCRLE9/MgRb8A6dWMHQRW5SnmhLBv0G/33lLfpQgGnGpA2izds5R7swz/srEB5Hwek8=
X-Received: by 2002:a17:903:44d:b0:223:7f8f:439b with SMTP id
 d9443c01a7336-22385a296a5mr498795ad.29.1740789373454; Fri, 28 Feb 2025
 16:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228062241.303309-1-tmricht@linux.ibm.com> <Z8JRC2oSs8i53t_s@google.com>
In-Reply-To: <Z8JRC2oSs8i53t_s@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Feb 2025 16:36:02 -0800
X-Gm-Features: AQ5f1Jo27S9_o_sqEYMlEN5u8ZrPMA3seerGcVGPfEDIZhYh_atDNzd8GgwU5_8
Message-ID: <CAP-5=fUqs=mxdgQX0Vx=D0weQSitXh6a8DcW2FycDEk6J-=RtA@mail.gmail.com>
Subject: Re: [PATCH] perf/test: Skip leader sampling for s390
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Fri, Feb 28, 2025 at 07:22:41AM +0100, Thomas Richter wrote:
> > In tree linux-next
> > the perf test case 114 'perf record tests' has a subtest
> > named 'Basic leader sampling test' which always fails on s390.
> > Root cause is this invocation
> >
> >  # perf record -vv -e '{cycles,cycles}:Su' -- perf test -w brstack
> >
> >  ...
> >  In the debug output the following 2 event are installed:
> >
> >  ------------------------------------------------------------
> >  perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   { sample_period, sample_freq }   4000
> >   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFI=
ER
> >   read_format                      ID|GROUP|LOST
> >   disabled                         1
> >   exclude_kernel                   1
> >   exclude_hv                       1
> >   freq                             1
> >   sample_id_all                    1
> >  ------------------------------------------------------------
> >  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 5
> >  ------------------------------------------------------------
> >  perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFI=
ER
> >   read_format                      ID|GROUP|LOST
> >   exclude_kernel                   1
> >   exclude_hv                       1
> >   sample_id_all                    1
> >  ------------------------------------------------------------
> >  sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8 =3D 6
> >  ...
> >
> > The first event is the group leader and is installed as sampling event.
> > The secound one is group member and is installed as counting event.
> >
> > Namhyung Kim confirms this observation:
> > > Yep, the syntax '{event1,event2}:S' is for group leader sampling whic=
h
> > > reduces the overhead of PMU interrupts.  The idea is that those event=
s
> > > are scheduled together so sampling is enabled only for the leader
> > > (usually the first) event and it reads counts from the member events
> > > using PERF_SAMPLE_READ.
> > >
> > > So they should have the same counts if it uses the same events in a
> > > group.
> >
> > However this does not work on s390. s390 has one dedicated sampling PMU
> > which supports only one event. A different PMU is used for counting.
> > Both run concurrently using different setups and frequencies.
> >
> > On s390x a sampling event is setup using a preset trigger and a large
> > buffer. The hardware
> >  - writes a samples (64 bytes) into this buffer
> >    when a given number of CPU instructions has been executed.
> >  - and triggers an interrupt when the buffer gets full.
> > The trigger has just a few possible values.
> >
> > On s390x the counting event cycles is used to read out the numer of
> > CPU cycles executed.
> >
> > On s390 above invocation created 2 events executed on 2 different
> > PMU and the result are diffent values from two independently running
> > PMUs which do not match in a consistent and reliably as on Intel:
> >
> >  # ./perf record  -e '{cycles,cycles}:Su' -- perf test -w brstack

Hi Thomas,

Thanks for reporting this! Could you try adding --count=3D100000 so that
we're not using frequency mode and we expect the counts to look like
100,000. For example, on my x86 laptop:
```
$ perf record --count=3D100000 -e '{cycles,cycles}:Su' -- perf test -w brst=
ack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.047 MB perf.data (712 samples) ]
$ perf script
            perf  635952 290271.436115:     100007 cycles:
ffffffffada00080 [unknown] ([unknown])
           perf  635952 290271.436115:     100007 cycles:
ffffffffada00080 [unknown] ([unknown])
           perf  635952 290271.436650:     100525 cycles:
7f86352b01b3 _dl_map_object_from_fd+0x553
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.436650:     100525 cycles:
7f86352b01b3 _dl_map_object_from_fd+0x553
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.437088:      99866 cycles:
7f86352cb827 strchr+0x27
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.437088:      99866 cycles:
7f86352cb827 strchr+0x27
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.437376:      99912 cycles:
7f86352cba74 strcmp+0x54
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.437376:      99912 cycles:
7f86352cba74 strcmp+0x54
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.437509:     100279 cycles:
7f86352cba3a strcmp+0x1a
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.437509:     100279 cycles:
7f86352cba3a strcmp+0x1a
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.437559:      99760 cycles:
7f86352bc39f _dl_check_map_versions+0x50f
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
           perf  635952 290271.437559:      99760 cycles:
7f86352bc39f _dl_check_map_versions+0x50f
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
...
```
I'm particularly concerned if we see the cycles count very deviant
from the 100000.

> >    ...
> >  # ./perf script
> >    perf 2799437 92568.845118:  5508000 cycles:  3ffbcb898b6 do_lookup_x=
+0x196
> >    perf 2799437 92568.845119:  1377000 cycles:  3ffbcb898b6 do_lookup_x=
+0x196
> >    perf 2799437 92568.845120:  4131000 cycles:  3ffbcb897e8 do_lookup_x=
+0xc8
> >    perf 2799437 92568.845121:  1377000 cycles:  3ffbcb8a37c _dl_lookup_=
symbol
> >    perf 2799437 92568.845122:  1377000 cycles:  3ffbcb89558 check_match=
+0x18
> >    perf 2799437 92568.845123:  2754000 cycles:  3ffbcb89b2a do_lookup_x=
+0x40a
> >    perf 2799437 92568.845124:  1377000 cycles:  3ffbcb89b1e do_lookup_x=
+0x3fe
> >
> > As can be seen the result match very often but not all the time
> > make this test on s390 failing very, very often.

Actually this is much more deviation than I'd expect. If we use
task-clock softer/timer based event I see:
```
$ perf record --count=3D100000 -e '{task-clock,task-clock}:Su' -- perf
test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.047 MB perf.data (712 samples) ]
$ perf script
            perf  636643 290571.807049:     801858 task-clock:
7fdf48643439 _dl_map_object_from_fd+0x7d9
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  636643 290571.807049:     804012 task-clock:
7fdf48643439 _dl_map_object_from_fd+0x7d9
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  636643 290571.807549:     499833 task-clock:
7fdf4863eb9b _dl_map_object_deps+0x3eb
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  636643 290571.807549:     498236 task-clock:
7fdf4863eb9b _dl_map_object_deps+0x3eb
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
```
So the count deviates by a few hundred, but your output seems to
deviate by 4 million.

So, I think the test needs to be more tolerant that should help your
case. As Namhyung mentions I think there may be another bug lurking.

Thanks,
Ian

> > This patch bypasses this test on s390.
> >
> > Output before:
> >  # ./perf test 114
> >  114: perf record tests                       : FAILED!
> >  #
> >
> > Output after:
> >  # ./perf test 114
> >  114: perf record tests                       : Ok
> >  #
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
>
> Thanks for the fix.  I think Ian saw the same problem on other archs
> too.  Maybe we need to enable it on supported archs only.
>
> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/tests/shell/record.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index ba8d873d3ca7..98b69820bc5f 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -231,6 +231,12 @@ test_cgroup() {
> >
> >  test_leader_sampling() {
> >    echo "Basic leader sampling test"
> > +  if [ "$(uname -m)" =3D s390x ]
> > +  then
> > +    echo "Leader sampling skipped"
> > +    ((skipped+=3D1))
> > +    return
> > +  fi
> >    if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
> >      perf test -w brstack 2> /dev/null
> >    then
> > --
> > 2.45.2
> >
