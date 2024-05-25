Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225D1862
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716608893; cv=none; b=mTzAEoEKPk+xTJCqcV3y98nRok6bZwWKWtirX59JIafp4n/ul/cacaOlOy5KE2WPwgfn788nlpUHnI1V7LB8hWvogk7C7F9MzXXamggX+vhP7g17aenMB5FWRqKpWI+8oSJ+GsiTatGG4Qd9kZetdedZ7B04gANJPUasRckDbys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716608893; c=relaxed/simple;
	bh=9h+hPTeUfQOcpsBAA9XgOVwljDzYnUuEJMBxx2V+Zi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTjKlZ/ohKZE/9JlbDR7wH351tzHmxbaaeaTCfcGjG+7NqZ7xfrzP21WUvzoPK6dRWNzkZEDLmR9bplcyTFXGRUdn+onTgz4sJVQfhDtQBD4TBrAXRRaJrc4Wi8s3cza1tFBLW8LwBLMxA+V2925zQfzs+oC/7nQbTskcfiS5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVN9dcEE; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVN9dcEE"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36db863679bso40015ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716608891; x=1717213691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ae90xQD1JSfJyYVhaJGFBnlHi96JVOZGp7BSWxGOUA=;
        b=VVN9dcEE+Y/vTHZfXRCfWplD0Eb1BGvZgYBkBCOYBtmefvEdCXGAXAaemz+x+wDoYR
         YXmhVOIv/L9fuIi0KMqcVPtyCwJlzAWew9TipjTVo3G0z0aX9bpfInQ8/8Oc9imIWgVJ
         U4Q3rEhgUTghW6kCh05mhQplNZK9b2O7/zuf3+cRFPhUdwFp83RYgOoNP5Krohr/VRHm
         M0xKqjBfJYyzZt9LQNcRvj0Mm/1x+zJXbm+BLF8gj8j6WSB61ClDFsrl2u52WaM31i0U
         gLNCMXoo5zsaD1oLuC7A4IZbr0hawV3JutHkFky1MUHLkYJiCniZOZcq3aDSbe7kmWcp
         fqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716608891; x=1717213691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ae90xQD1JSfJyYVhaJGFBnlHi96JVOZGp7BSWxGOUA=;
        b=whAmqK+14wTZXfXJ+UEWxx1KRVhG5KKUkFrtsgVH++W8r6yAguvxz1EhV/iRnQCy95
         +tZoWxTPlsz0yPLMJCkfZDAmaPOS63n0bRYzWavCsRkfvoCPNYI7L8hv1qiSvIOVW1DP
         9l9k3ByGb8OSNdMIgKzt57OvA/2rlzPFmu/WuVX7UeQcNn0zVhHgZBpY3PCdA2NO/2U9
         qHd81ir4xRgQX4ym0V6IoIkpUmnNmXLk+ymlXu4fcZbZHcOVKdWDYN7wQ9ZPqywmHovu
         oDSV5gOp/YYUajepLLfw/FEa58DQyJN/XhhjNUchVjzQqfoe3GPOfiOV5o9UjYivHEEz
         fHww==
X-Forwarded-Encrypted: i=1; AJvYcCXsEXpGsenmt9fFTCKGZ4L4fotO/lCF0SxTSbgzyTi1B16CpvR3Rr0/5xAWOx72741Kycy5qopJhGa9HLPjfeFpm+7ClGU4zcsm1UaA8vBcAw==
X-Gm-Message-State: AOJu0YyP3NHMCIiI3/BEH9kpKvNlwrcvmdXYA0+q0/TMbMLhFUVfjavE
	UDebdTtMsNb/mIZCLevHWRdhLFxyW47jwFTzD95RaauAmE+Nzb+KeGokPKnn452UYb9/yaHalTJ
	1tRwRAFvCMonateKM8iR/FPX1A+ALS7BIhWgq
X-Google-Smtp-Source: AGHT+IH9AudXBRg06HeJ2lMfXh7iaMoDr8xto6pnVvEb6aUWVkk5wmCn5cRqO9PYpm8emOvieo6JJpoPBYDzbnlv0oM=
X-Received: by 2002:a92:cc08:0:b0:36d:cb9e:a0da with SMTP id
 e9e14a558f8ab-3738b350a12mr590685ab.25.1716608891228; Fri, 24 May 2024
 20:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1>
In-Reply-To: <ZlFGpxWGQskCTjeK@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 May 2024 20:47:59 -0700
Message-ID: <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 7:02=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, May 24, 2024 at 10:55:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, May 24, 2024 at 06:31:52PM -0700, Linus Torvalds wrote:
> > > On Tue, 21 May 2024 at 12:26, Arnaldo Carvalho de Melo <acme@kernel.o=
rg> wrote:
> > > >
> > > > perf tools fixes and improvements for v6.10:
> > >
> > > This actually broke 'perf' completely for me on arm64.
> > >
> > > With a 6.9 version of 'perf', I can do this:
> > >
> > >     perf record -e cycles:pp make -j199
> > >
> > > and it all works fine.
> > >
> > > With the current -git version, when I do the same, I instead get
> > >
> > >   Error:
> > >   cycles:pp: PMU Hardware doesn't support
> > > sampling/overflow-interrupts. Try 'perf stat'
> > >
> > > and after trying desperately to chase down what went wrong on the
> > > kernel side, I finally figured out that it wasn't a kernel change at
> > > all, it was the tooling that had changed.
> > >
> > > I did a 'git bisect', and it says
> > >
> > >   617824a7f0f73e4de325cf8add58e55b28c12493 is the first bad commit
> > >   commit 617824a7f0f73e4de325cf8add58e55b28c12493
> > >   Author: Ian Rogers <irogers@google.com>
> > >   Date:   Mon Apr 15 23:15:25 2024 -0700
> > >
> > >       perf parse-events: Prefer sysfs/JSON hardware events over legac=
y
> > >
> > > and very clearly this does *NOT* work at all for me.
> > >
> > > I didn't notice until now, simply because I had been busy with the
> > > merge window, so I hadn't been doing any profiles, but the merge
> > > window is calming down and the end is nigh, and I just wasted more
> > > time than I care to admit trying to figure out what went wrong in the
> > > kernel.
> > >
> > > And no, I don't speak JSON, and I have *no* idea what the legacy
> > > events are. Plus I'm not very familiar with the arm64 profiling etc
> > > anyway, so I'm just a clueless user here.
> > >
> > > I *can* confirm that just reverting that commit makes that trivial
> > > "perf record" work for me. So the bisect was good, and it reverts
> > > cleanly, but I don't know _why_ my arm64 setup hates it so much.

Thanks for the report. TL;DR try putting the PMU name with the event
name, so "cycles:pp" becomes "armv8_pmuv3_0/cycles/pp", where
armv8_pmuv3_0 is the name of the PMU from /sys/devices.

The perf tool has a number of inbuilt "legacy" event names, cycles is
one. Most events these days are either found in sysfs (this is on a
Raspberry Pi 5):
```
$ ls /sys/devices/armv8_cortex_a76/events/
br_mis_pred          exc_return        l1d_tlb_refill      l2d_tlb
        remote_access
br_mis_pred_retired  exc_taken         l1i_cache
l2d_tlb_refill      stall_backend
br_pred              inst_retired      l1i_cache_refill    l3d_cache
        stall_frontend
br_retired           inst_spec         l1i_tlb
l3d_cache_allocate  sw_incr
bus_access           itlb_walk         l1i_tlb_refill
l3d_cache_refill    ttbr_write_retired
bus_cycles           l1d_cache         l2d_cache           ll_cache_miss_rd
cid_write_retired    l1d_cache_refill  l2d_cache_allocate  ll_cache_rd
cpu_cycles           l1d_cache_wb      l2d_cache_refill    mem_access
dtlb_walk            l1d_tlb           l2d_cache_wb        memory_error
```
 or json that is turned into tables built into the perf tool.

ARM requested that sysfs and json events take priority over legacy
events. So 'armv8_cortex_a76/cycles/' should first try to open an
event in either sysfs or json, and if not present fallback on using
the legacy constants. Note that the event name has the PMU name first.
What should the behavior of the 'cycles' event with no PMU be? In
Linux 6.9 the behavior was that cycles without a PMU would be a legacy
encoding and only try to be on the core's PMU (generally cpu on Intel
or armv8... on ARM), but with a PMU it would prefer sysfs and json
tables.

RISC-V had asked that in the no PMU case they'd also like sysfs/json
to have priority so the driver could be more ignorant of event
encodings. It was also inconsistent that in Linux 6.9:

$ perf stat -e inst_retired.any true

was a sysfs/json event that we'd try to open on every PMU but:

$ perf stat -e instructions true

was a legacy event that would only be opened on the core PMU. (I'm
ignoring the complexity that BIG.little/hybrid adds).

The blamed patch does away with the inconsistency and makes it so that
legacy events are always the 2nd choice and we try to open every event
on every PMU. It is the 2nd point that I think is breaking you. I
think you have a PMU on your system with a cycles event, maybe an
uncore PMU with memory controller data or CXL, and the perf record is
trying to open the cycles event on that and the error message
correctly reports that sampling wouldn't be possible on that PMU.

Putting verbose flags on perf record:

$ perf record -vv ...

should hopefully give more breadcrumbs and confirm this. You could also do:

$ ls /sys/devices/*/events/cycles

If there are more than 1 sysfs cycles event then probably one of them
is the problem. Adding the PMU name removes the trying every PMU
behavior and so should be a fix. We could also change it so that when
we open multiple events for perf record we don't fail in a case like
this. Maybe it is a feature to fail.

Thanks,
Ian

> > That is a good data point, we probably could go with the revert, but I
> > think Ian submitted a few patches fixing this issue that came up close
> > to LSFMM/BPF and the merge window, so didn't have time to sit on
> > linux-next for a while, I'm looking those up now.
>
> Couldn't find it quickly, its late here, perhaps Ian can chime in and
> point those fixes here. I'll try and continue tomorrow.
>
> - Arnaldo
>
> > ARM64 eyes on this would also be good. Adding Mark Rutland and Leo Yan
> > to the CC list, maybe they can help us here with the best course of
> > action.
