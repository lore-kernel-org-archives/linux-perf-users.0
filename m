Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793676592;
	b=jNXP/bC1B7mnvkTrRsC7Dn/25gt33+GmDF81YXzWvD1j3M/mcmzktPPCiseOvh64hDe/
	 0YdYPd7EQgSVl0SUS0CIoBLaYFMIgwx+c7D/MW2FiSxOZtnsYrp/dSUetVRWQGw8GblDk
	 HKx3GwGqfOgwhe2PK2iAK2IssTHPzg5XCzgmmILT03AYkVGu3UANbh9OsiGhaBLEaLvzZ
	 erzOv3Z/I3akP6oX12bNZbfoHwQx0sQLWpEsZQcj4jIBfNsumfz1yzE3uFONwWcGWJKhE
	 vhs6rR4o8polMWS7HtNJ5GhA/4WLQKCeBtli8CT7ZfIL5ftBpJHp8QMsK5BmSOdNM9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3/jVVaijRUiYgguhdxxzqQy/vf/qXuWMp4fiYE9hRio=;
	b=mpvhTRnE1AsG1Mdm8OfikZLTsl/y1OC/+p3prKIrsUY5EPAMoFe3bHufnpOeupS0947s
	 vB4OhOmFLHCCmUs4hedckagTBH2iRipCmxPFBGqhE7VOw9sHBAMwhAZrnZUP5NVKv9h+h
	 jvTsnUW+M3YiQuoZp8HQLzPLJaq9nUHozEdF8/B6eYit22kWeyCUtRq6TEgm7O/VxlPXh
	 SoGDjmMmjwprvzYTreIk0SmwkFAMzb6Pwl0s5CN7YhkhmqYZQotFBVd/QGf0Cd1GBSSk9
	 DCkSGWjy2gP65NY3ifqX19jUSBN24w9zXjP4akDuwntvwsJsoKpBfxvzaNeZ9x4vyyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oRQlatYQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58949606A32E
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58949606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oRQlatYQ
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5383c97c8cfso76021cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 19:29:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793676590; cv=none;
        d=google.com; s=arc-20260327;
        b=G1Tw2sX7k82hnSRsUjk058qau5Z4LoZJwnCWuSplfgY6zPnB5L5h1We8ZeXS3EC0Ai
         ouQ8cfj2kCS2ECHIMWrCUKtef239dTZR/k38HY16RZ7m418j6WprwswBHpq1fevQPc06
         WgDwtHv80Zz06Q0/agXONbyZ1N84dI7ODQKXbg++WUfIEace1YLANlYxw8ELZbJ9acen
         5Fv8Z/uFeJ++LrTCWEuwLrV5N2Lk3+5+f8ACQb1O4aiwqbTMvgRKuoVZxl9UUGTK2+Dk
         SuAqCzDq4rNLYTC2sniiofGWqumCMH6prynoKt17W5tFS4ycLOztYGhWW/WpG94s8XXq
         V/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3/jVVaijRUiYgguhdxxzqQy/vf/qXuWMp4fiYE9hRio=;
        fh=NGs23CCQCF6VlXJukoZ2ZAJGJVpQO9FPW9biQobXGQY=;
        b=BTLcW6MnvuzQR1kzOGaZtEwUnWWvM6cELhoF9iIBmKxK+jSOmgiYJz9Oa+LzmC4duR
         nKSgF1n8UQZBL50Kvdmil/vgG7PLkVoOPEFpz43NLSoUG1APfhi7qCtfCwLUBMLZnlD6
         PrfIe3PbSMmgI9nUClrBq6R8M11cGV7CHk8CRQIGt6eWdeiCj2tnTUhuZSkLA4f37Hqp
         INTck8JmN9EIWAaHeHl/5I9EARvA4zf688xsvVrryLazNCPMjv8tjQ349Ie0Zsw3pq5z
         Z4Y0YGaf7jwxp4azhGN9/KhrHJIlz0oeCYaxa2qh8nUX47XPBekub4OmvW8QjenZI9jz
         2YNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793676590; x=1794281390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3/jVVaijRUiYgguhdxxzqQy/vf/qXuWMp4fiYE9hRio=;
        b=oRQlatYQ4V/cKWLoECQKAVt3ves50NtB5jDiQpMB4Qgk+/BmgvlFm5RIte/Wj8MsAB
         JdFOZzgvx1MAAXhcC2IIKEmvPmtm+4AWRGTwjVZZb3m8LWkMrAjrF2vBsYTgEpFi671v
         d65vvGo9tIMSp3g4NlP1jBLNMV9rFJF9kOS7vwM5afHRzXlxp2mOOpqu2LCFRmdYavgP
         StpHiZck9i85eNeBTfamyuB+cBmWO0BAALf8rOhjB6BW9NLyxiAGeLTuLl0OZw56sexE
         ctZqW12uvD8Y7tzvtbEIb/ATSHxVWfSAoMv7QAi0D5ygwK/qBNs0rSrLnzGnzdNs/ikJ
         S99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676590; x=1794281390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/jVVaijRUiYgguhdxxzqQy/vf/qXuWMp4fiYE9hRio=;
        b=csMGjHcnEUM5oGQeMAvaJ1d2K3pzzA+BDvaDxmXfG5hOi4TS2FH9sc9ZrM5mSMfIIA
         YixUK5T8LZMu8rsc/MiLRFq149azPq02tlP5V837KS4Zg6B4DVpL1H+b7BEVkID1Jo5r
         Wlj1yppHhzf7WhUf9QGHTd3+dDOt9wNY69LuHm7hJ/rY5yyt1UUWLYtAnqs+APPsXUaD
         163LnI7l+VWUlXZcK7C6BzaMNlIEY97vuwLlzlByyETG2ivTE8NpFxNlI01MP1v6LJB6
         F0bzqZUNIMuxQNFUg4XGPcG8ZUWfavEGluKmwV+nEB/WHC7je5QQE7jvT4hvXmxPfpFv
         eJQg==
X-Forwarded-Encrypted: i=1; AKwUvBxntDw6aSgkGTtTnAhzf7sPbzia51MlNszQI28Z3K94+Phc1LU/ttL5Q7KxEq1TYkP2Y0gjU2w0A/AsIobU3Rfl@vger.kernel.org
X-Gm-Message-State: AFq9FYJhYz/2ZNQG7lHg78i7uM5GL3TVmvK5Catc9sEcPL3H875HUpSc
	1EV1QbfVZOHoqnieC7l2+NcZFJhlrd1VVAkX8Qh4rGegckXDFSDwAECJncq51t21VrgFnnZdmlR
	5tT3MDGRJzXWEKBIg45h3gk8jOXzogdoQ9zzX1TPe
X-Gm-Gg: AYBFou0G398JGg83hCwDeFawp5PDw/LS8ZUfr3pYblEBwlfEugCsjpjK+qu+Owf+beT
	FYteO0xjdl2wXBD6LqBUymDaByTggpvlOz9oJnDO21NHjPcrJ4d4DhcR9p+I080XGfwBtG19IVw
	OlrZcWOPXuYHotBx0/Fd2MAcRISMw/Xq09s5aoUM5tKhvC7jVn5irwZTW0LNvc/lV3DdfmAzZFR
	tCdWvo9PMkjfVGfVX9DvNzWG2GPl428oKxzjZ9mjota59RG5MTUocetMLb9Kt/h0wBE/3i8VbKL
	fMMBFHaWBdVgMYkxumV8jPgIc/NFumFDNsYVlPmdsDDr2XEX1C+764Zhp7GUxbZ4Lj3mQPSOSpM
	U/iE3jBBmi1i2yplRJhhMAtX7qnel6Y7xzSVBEg==
X-Received: by 2002:a05:622a:2447:b0:530:e335:4ef with SMTP id
 d75a77b69052e-549ba0e24f1mr10891801cf.2.1793676589342; Mon, 02 Nov 2026
 19:29:49 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
In-Reply-To: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Nov 2026 19:29:36 -0800
X-Gm-Features: AclHuK904JHTfUNnVjrkcp3Pq4YdxAo-LcsUdxHpRJ4GokkVa24QE-DbUgehNDw
Message-ID: <CAP-5=fWC7AM9aAsHaZvQVXznYzVp5FRQtH=vu2xxQys7QWvCQg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] alpha/perf: add ProfileMe sampling
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:01=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> The 21264 from EV67 on, and the 21364, have a second performance counter
> mode, ProfileMe, alongside the Aggregate mode that the driver uses today.
> An Aggregate mode sample reports the PC where the overflow interrupt was
> taken. On an EV7 that is anywhere from 15 instructions before to 12
> after the one that overflowed the counter, which makes perf annotate
> output close to useless. In ProfileMe mode the CPU picks one fetched
> instruction, follows it down the pipeline, and reports its PC along with
> what happened to it: whether it retired, whether it trapped and why,
> whether it was a mispredicted branch, stalled before map, or was killed
> on a wrong path, and what PCTR1 counted while it was in flight.
>
> Patch 1 fixes a constant passed to the wrong PALcode call, with no
> functional change. Patch 2 adds the sysfs format and event attributes
> the perf tool needs to name raw events. Patch 3 fixes counts lost when
> an event is stopped before its first start, and patch 4 stops reporting
> user registers that the entry code has not saved yet. Patch 5 adds
> ProfileMe sampling, selected with precise_ip or a new profileme config
> bit, so cycles:p and perf record's default event use it. Patch 6
> attaches the status registers to each sample as PERF_SAMPLE_RAW data,
> and patch 7 adds an option to randomize the sampling interval so that it
> cannot lock onto a loop.
>
> A separate series for perf-tools-next adds a decoder for the raw data
> to perf report -D and perf script -D, and a script that sums the status
> by symbol or by instruction, in the style of DCPI.
>
> The two modes cannot run at the same time, because PCTR_CTL[SL0] sets
> the mode for both counters. A ProfileMe event is scheduled alone, and
> perf multiplexes it with any other hardware events. perf stat does not
> ask for precise events, so it keeps using Aggregate mode.
>
> To try it:
>
>   perf record -e cycles:p -- ./workload
>   perf annotate
>
> I tested this on an AlphaServer ES47 (EV7). Samples from a
> 16-instruction loop land on all 16 instructions rather than on 4 PCs.
> DTB misses and unaligned traps are attributed to the faulting load. A
> branch on random data shows up as mispredicted in 21% of its samples,
> and in 0% with sorted data. A 12 minute perf record -a while building
> git took 4.45 million samples with no warnings. Sampling every 10000
> instructions, which used to wedge the CPU, ran 66 times without a hang.
> On two CPUs, this version survived 26 runs that mix sampling, context
> switches and multiplexing, with no warnings.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Hi Matt,

Thanks for v4, this is great to see. Attributing precise samples to
PMPC is the big win here: it puts the most important part of the
ProfileMe data, the IP, in a generic field, so perf report, annotate,
etc. just work. I have a suggestion about the rest of the data, which
is currently only reachable through PERF_SAMPLE_RAW. Raising it now
since it's easier to shape before the uapi lands.

The I_STAT status and the PCTR1 window count are only really usable
via alpha-profileme.py. IBS was in the same position for years, until
the perf mem/c2c work started filling in the generic sample fields
alongside the raw record (perf_ibs_parse_ld_st_data() [1]). The same
seems worthwhile here: keep the raw record as is for full fidelity,
and set the generic fields where the data maps cleanly.

The PCTR1 window count looks like a natural fit for
PERF_SAMPLE_WEIGHT_STRUCT. It's 20 bits, so it fits var1_dw without
saturating, and var1_dw is what the weight and local_weight sort keys
read. What the weight means is already PMU specific (IBS puts the DC
miss latency there, and tag-to-retire cycles in var2_w), so for
cycles:p it would be the inum retire delay. var3_w, where x86 puts
retire latency, may be closer in meaning, but it's only 16 bits and
its sort keys are enabled per arch in the tool. Something like:

if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
  /* not initialized by perf_sample_data_init() */
  data.weight.full =3D 0;
  data.weight.var1_dw =3D pctr1;
  data.sample_flags |=3D PERF_SAMPLE_WEIGHT_TYPE;
}

As Alpha is little-endian, that's also the right value for plain
PERF_SAMPLE_WEIGHT, which is what perf record -W asks for unless the
arch opts in to the struct, so it'd work without a tools change. I'd
keep the I_STAT bits out of var2_w/var3_w though, as the tool sums
and averages weights. One wrinkle is the PALmode samples, where the
IP stays as the interrupted PC, so the window count would be charged
to an instruction it doesn't belong to; it may be best to leave the
weight unset for those.

Similarly, if any I_STAT trap types identify a memory event, a DTB
miss on a load or store say, setting PERF_SAMPLE_DATA_SRC (mem_op,
mem_dtlb) for those samples would make them visible to the memory
sort keys. If nothing maps cleanly, I wouldn't force it.

The remaining status bits (retired/killed, mispredict, trap) don't
have a generic home, but they'd make useful filters: format bits,
in config1 say, for retired-only, mispredict-only and trapped-only,
with the driver dropping samples that don't match. Arm SPE's
event_filter does much the same in hardware, with retired and
mispredicted among its bits. Retired-only would also stop killed,
wrong-path instructions showing up as hot spots in a plain perf
report. Since PEBS and IBS op only sample retired instructions, it
may even make sense for precise_ip to imply retired-only, leaving the
profileme bit for the unfiltered view. That one changes what a
default perf record gives on Alpha, so it's worth deciding before
merge rather than after.

All of this is additive to the raw format and alpha-profileme.py, so
it could equally be a follow-up if you'd rather not grow the series.

Thanks,
Ian

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/x86/events/amd/ibs.c#n1274

> ---
> Changes in v4:
> - Patch 4: move __entry_save_end past the r16-r18 stores in entSys,
>   as PAL_callsys does not save them and interrupts are still enabled
>   there.
> - Patch 5: report the user registers when the profiled instruction is
>   in the entry code but the interrupt was taken after it, since
>   perf_get_regs_user() sees the PMPC rather than the interrupted PC.
> - Link to v3: https://patch.msgid.link/20261101-alpha-profileme-v3-0-92d5=
11b5a044@gmail.com
>
> Changes in v3:
> - New patch 3: clear PERF_HES_UPTODATE when an event starts counting,
>   so that a stop before the first start does not lose the count.
> - New patch 4: report no user registers for a sample taken in the entry
>   code, where the frame at task_pt_regs() is not complete. An interrupt
>   nested on one taken there is still not caught.
> - Patch 5: a user instruction whose interrupt is taken in the kernel now
>   reports its PC with no registers or user stack, as the frame at
>   task_pt_regs() may not be built yet. Thanks to Magnus Lindholm for
>   finding this and for the fix.
> - Patch 5: also move the counter away from overflow when a ProfileMe
>   event is removed, or stopped without PERF_EF_UPDATE, as
>   alpha_pmu_del() does not go through alpha_pmu_stop().
> - Patch 5: ignore an interrupt that was pending when the event was
>   stopped. Document that rewriting a counter does not cancel one.
> - Link to v2: https://patch.msgid.link/20261030-alpha-profileme-v2-0-c702=
f1c65272@gmail.com
>
> Changes in v2:
> - Patch 1: explain why bit 0 clear means all processes, although the
>   Architecture Reference Manual says otherwise.
> - Patch 3: fix a CPU wedge during high-rate ProfileMe sampling. The
>   ProfileMe counters are now written twice, and a stopped counter is
>   moved away from overflow, as EV67 HRM PALcode restrictions 32 and 38
>   require.
> - Patch 3: set the profiled PC in place in the trap frame of the
>   instruction's mode instead of in a pt_regs copy on the stack, so
>   sampled registers and stack values are those of the right frame.
>   A kernel instruction whose interrupt is taken in user mode gets a
>   per-CPU frame holding only its PC, so the user frame is not changed.
> - Patch 4: drop the reserved field and pack the 64-bit fields of
>   struct alpha_profileme_sample, so they are 8-byte aligned in the
>   sample record and the record needs no padding. This changes the raw
>   data layout.
> - Patch 5: compute the jitter with mul_u64_u32_shr() and saturate the
>   sum, so that large periods cannot overflow.
> - Link to v1: https://patch.msgid.link/20261028-alpha-profileme-v1-0-d44b=
52bf2500@gmail.com
>
> ---
> Matt Turner (7):
>       alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the logging options cal=
l
>       alpha/perf: add sysfs format and event attributes
>       alpha/perf: clear PERF_HES_UPTODATE when an event starts counting
>       alpha/perf: do not report user registers from the entry code
>       alpha/perf: implement ProfileMe sampling
>       alpha/perf: attach ProfileMe status as PERF_SAMPLE_RAW data
>       alpha/perf: optionally randomize the ProfileMe sampling interval
>
>  arch/alpha/include/asm/perf_event.h      |   2 +
>  arch/alpha/include/asm/ptrace.h          |  12 +
>  arch/alpha/include/asm/wrperfmon.h       |  14 ++
>  arch/alpha/include/uapi/asm/perf_event.h |  31 +++
>  arch/alpha/kernel/entry.S                |   9 +
>  arch/alpha/kernel/perf_event.c           | 382 +++++++++++++++++++++++++=
++++--
>  arch/alpha/kernel/perf_regs.c            |  13 ++
>  7 files changed, 450 insertions(+), 13 deletions(-)
> ---
> base-commit: 330517c63aa9b48227b6ab45f01003effac77ae4
> change-id: 20261024-alpha-profileme-6e98a977cb54
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>
