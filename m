Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793782932;
	b=3s2WbZjW/OVLdMMInmBEIpojnyo2pDtIdXGAJ59dY0yU65b9Qz5cyzlnDRvLIZA/nP57
	 iby0DQR2sHvU8ThhrYR0h7C5JZ3VjvtkkG9VUy3CzkSnjX5/JK0b5yw2lPTundEw2jHJe
	 NpaaoYIWjixYmH4U7Z9RE+y4N1AVQ4FeQohtzBSnfxhw4CnhdzkdYDYUQ+3D/oqNWIO6S
	 tjv2TALshheTLf/Pr8M8ySqzqfhboO4GmxvqrlAnJUDA2jE8f77HMaQU2A+kVIMDbXAX/
	 VUczPg+1pHyysYceTbaXkiG3GZHPb6XKfvS+d9p7BUK/ghfAfD9+pLNI9fbpNCEY3JA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Mwg8ejIP9AknwB4N84ymkkwkqfDAgYFi8CLuYr+urxk=;
	b=Ap5EF5ty+J7pGHbe4b3BUBi7Mvkk1bnqpvvXEXsqcYLdd85Bp2WYLskR0rFcsFn5dJ+n
	 oMVu6UYjwtm/f+Ax3f2cbF+F/Y4evHOJGUm342QV2f2WzFQ/pw53SOKPCtfSHAD6oE7Ot
	 dKzI8TKpJIsA+l8l78HbRu61tlRi20RVFTt4jq87EgWVLJscsZVN0ub51WN9yFzUkaNLU
	 U8KExcq7pwcswMjLQspcSBKmdLc6ZQ6CG73iZHXxdOXpgGYlfhajjXVUkyZilkHLMBOCh
	 mQmzVdA20VogtI4fIkgyy6BmZ6qUMLX1FrYoJGHuuw/Cu2D6sOWW6SLr5z7aFXUuptA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mD5XFs7j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC1606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 09:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DCC1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mD5XFs7j
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b4e814214aso462045a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 01:02:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793782930; cv=none;
        d=google.com; s=arc-20260327;
        b=b3RjvR7dqzP9m9xzMYQnpvHI/PGm9XeO4c8pbKJ8Bby+NZzBElXxahsBtBh4PCV5eR
         YXbrdFBwz2hQB+PPChee2aV4+m9uvbCUWzYMow83zFXhKhcQ04mks2Fnv5uXfy4EDZcW
         X8BmDC18dytlyiONPurAioPZerHDhAeT/KFONPXFOS1VrZEYQ4xL4IzItEeKlnwE4F1v
         4ullbA8cqdJmvvkfkdQWAHRoqAhSiz8HKt1piTMsRJM88ILMk+L8QrLBpKaTHP2SZwog
         KbKNcAPWoiJpX5t2nm1DNHV7dXSdynFfPEsh4QBgG9R0N1+2sjjkqNeK2tg15HjyD0WH
         1NXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mwg8ejIP9AknwB4N84ymkkwkqfDAgYFi8CLuYr+urxk=;
        fh=MBFJOHQIl9WjqblQOKcVYBDcjPk7UJjU3kSNWYBZv3w=;
        b=X5INKXxCrDi85Elqy+hITSgz/uMzMfZuLqQK5a3XIMoKJ6JTFnEE/rGk5Qznn/9GNk
         1rYTWUhY9oEzOBr0klyJ9CZgJB+fiwtOxGOEzCKt4o+jCQFhBEOPQFPcSiCABx+m8Ug6
         eW/jhwjKfdxHHGiqXZcvsBdfLElHwk9xFVkch1p8/v/wtuf88EYhVEeB2kJfkyNfoB3F
         86YBxWCLaq4S7Bvf07fDDcInTnO482GER5cX8jTgYfQhnS4e72kahqDih32a2z9kgSpn
         I55VnSA00fgPCv/bBhVPqu2y1UiZ54EWmQLt7rD8Imax9As/6ev8VMA5A3uLEEOryF1v
         CiIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793782930; x=1794387730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mwg8ejIP9AknwB4N84ymkkwkqfDAgYFi8CLuYr+urxk=;
        b=mD5XFs7jqRYRgY9Vo/7sscQpFUouFjX4n+a6lyHIDN4UJh4hj+2L64aE2qEZHtez06
         nXnP7DXW2Wb0msSqfF7aEbSwC+Yj9fDmGSBYiljw3BYQzYoLKsyTgBQO2N7V7Pe54P3R
         b4CrZu3J9tIjMkFmuIG+sZmAhZgz9LlRr/I5pLKiEFOFHhX1gCm0Zi3Wgvfy+UKwQZ/U
         ASRqXyACQ03TBR41VpiRTcCC/imonGqg8LUnWbQ+0G6mtcPkW/ibMWZFv9OiXjrYJHvA
         HvAwfXe122fXYKLIBF2zpibQcsfgPY25ZBZU0P3XfY8Sy5ut3sgJCyMwWjiTNIVR2SLW
         BtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793782930; x=1794387730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mwg8ejIP9AknwB4N84ymkkwkqfDAgYFi8CLuYr+urxk=;
        b=K2p1KFLo/n8qprTQlEwwVEMlNm2zgUh9f+JpPL0pUxnPeMMTxmI7mqI+p9Tyl1hbKE
         B+hgRP1g+IUQAAp5KH346orsxZo9wFRyl4Pmmu8Ujs0uGxqZ6XFkqkXunFND5qi5xyF5
         ppVqccR81716NitezpTD3cSu0+KYbrknC+iSG6rddR70BD6cb/k7NPrQMMIEORInPx5y
         PNj16SOs9mLr02KaXDmwnFWqZO5b5qgLUyXQLOBzz7THS+nAhptMmf2xz5AZtoFEYC1t
         bMKW/vI6LyxNF0KYCqxDG/ILGK7uQFmay/+iKqRBdngMZmiQdf3797C+Boleu0phoMbb
         RDLA==
X-Forwarded-Encrypted: i=1; AKwUvBzobuLVnwJ/mlCx+XuZKMG2ajMOA6sj/DR4Z72WBufwLm9dsAuMBAil0TWBfDlhdP/caRjxPrcpRC6OpKZ12td/@vger.kernel.org
X-Gm-Message-State: APuU4Z+kSJl9OLkPgQ6Q6quQTbXhdjB7QNnJB1GQeOsN2UgR92oJrBO+
	S2hFfe4VatWIt5eoMDRxleu2cWlbtTEZL7AJ7whrDkcRALkv04ThGtENPF9q3VlP0nifCty4SNR
	udR0owkskJTiLyo546ZnHQax0iOxT8x8=
X-Gm-Gg: AYBFou3TZumcJcZ1GGXEAmdL0pX/RIREJ5nYivbSf86agOTwB65qr6SfT948785oJ7o
	haCg9DHNXlDZweCfUmuJrjYnbIhi1dQNp5yC5ORUhDu4ngywdF6yxUy4HkNd0/zGX/3Rc60fQzA
	xT5XO9NBeapSfYi8cSBjp9vZ37o67txlIB2D95mAD9PoQ2kAyeEIDj5gIqtldzLyJukZehIzmnI
	puupge4LVLdfw/mLfpn5Hq8o+kFj0EoWkbyFjVmigBVs1q7zEb0mwRLm/Bmm/26Eync80opO7eu
	wQaqrEc/z+GhnDc5X8I/6+p3nL8E8I8aowBbOZGdZ7UpAAcXQSgeVO4ATGDwpNKMUI9HU4pAAfH
	K+TDMYFLDrsmi40ehLukP59QU8fLT3s7nNrFd0CgLhSSwy6iFw8Lp9G52ZqfdOtTtbBBVew==
X-Received: by 2002:a05:6402:789:b0:6b1:8316:ba32 with SMTP id
 4fb4d7f45d1cf-6b4d46754a6mr9226911a12.17.1793782930241; Wed, 04 Nov 2026
 01:02:10 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com> <CAP-5=fVtMnaoF1JbVFJuiRqPx-2izJafs=+ov6eF_PYFE9Xrxg@mail.gmail.com>
In-Reply-To: <CAP-5=fVtMnaoF1JbVFJuiRqPx-2izJafs=+ov6eF_PYFE9Xrxg@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 4 Nov 2026 10:01:59 +0100
X-Gm-Features: AclHuK_p_kRsMuMD9ncCIho75MDP_bNAX_RiQ9ZE2nnbCaCy1tPAderdiMSmOj8
Message-ID: <CA+=Fv5SO2NF6834Dq9pV5tdLrECnV4-1oNPJnD38+Or9u54eLg@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] alpha/perf: add ProfileMe sampling
To: Ian Rogers <irogers@google.com>
Cc: Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian, Matt,

On Wed, Nov 4, 2026 at 12:42=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Nov 3, 2026 at 12:37=E2=80=AFPM Matt Turner <mattst88@gmail.com> =
wrote:
> >
> > The 21264 from EV67 on, and the 21364, have a second performance counte=
r
> > mode, ProfileMe, alongside the Aggregate mode that the driver uses toda=
y.
> > An Aggregate mode sample reports the PC where the overflow interrupt wa=
s
> > taken. On an EV7 that is anywhere from 15 instructions before to 12
> > after the one that overflowed the counter, which makes perf annotate
> > output close to useless. In ProfileMe mode the CPU picks one fetched
> > instruction, follows it down the pipeline, and reports its PC along wit=
h
> > what happened to it: whether it retired, whether it trapped and why,
> > whether it was a mispredicted branch, stalled before map, or was killed
> > on a wrong path, and what PCTR1 counted while it was in flight.
> >
> > Patch 1 fixes a constant passed to the wrong PALcode call, with no
> > functional change. Patch 2 adds the sysfs format and event attributes
> > the perf tool needs to name raw events. Patch 3 fixes counts lost when
> > an event is stopped before its first start, and patch 4 stops reporting
> > user registers that the entry code has not saved yet. Patch 5 adds
> > ProfileMe sampling, selected with precise_ip or a new profileme config
> > bit, so cycles:p and perf record's default event use it. Patch 6
> > attaches the status registers to each sample as PERF_SAMPLE_RAW data,
> > and patch 7 adds an option to randomize the sampling interval so that i=
t
> > cannot lock onto a loop. Patches 8 and 9 report what PCTR1 counted as
> > the sample weight and the data source of DTB misses. Patch 10 adds
> > filters that keep only retired, mispredicted or trapping instructions,
> > and patch 11 makes precise events sample only retired ones.
> >
> > A separate series for perf-tools-next adds a decoder for the raw data
> > to perf report -D and perf script -D, and a script that sums the status
> > by symbol or by instruction, in the style of DCPI.
> >
> > The two modes cannot run at the same time, because PCTR_CTL[SL0] sets
> > the mode for both counters. A ProfileMe event is scheduled alone, and
> > perf multiplexes it with any other hardware events. perf stat does not
> > ask for precise events, so it keeps using Aggregate mode.
> >
> > To try it:
> >
> >   perf record -e cycles:p -- ./workload
> >   perf annotate
> >
> > I tested this on an AlphaServer ES47 (EV7). Samples from a
> > 16-instruction loop land on all 16 instructions rather than on 4 PCs.
> > DTB misses and unaligned traps are attributed to the faulting load. A
> > branch on random data shows up as mispredicted in 21% of its samples,
> > and in 0% with sorted data. A 12 minute perf record -a while building
> > git took 4.45 million samples with no warnings. Sampling every 10000
> > instructions, which used to wedge the CPU, ran 66 times without a hang.
> > With precise_ip, killed instructions went from 67% of the samples of a
> > mispredicting loop to none. On two CPUs, this version survived 62 runs
> > that mix sampling, filters, context switches and multiplexing, with no
> > warnings.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
>
> Hi Matt,
>
> Thanks for v5, and for turning the suggestions around so quickly with
> measurements to back each one up. Patch 8 looks good to me; a few
> comments on the rest (appologies, I'm using Gemini to help me be
> cleverer than I am):
>
> Patch 5: I think Sashiko's report is right. With idx forced to 0 in
> ProfileMe mode, a PCTR1 overflow still pending when an Aggregate event
> is multiplexed out gets taken as a window close: it adds a bogus 2^20
> to the count and emits a sample from a stale PMPC, possibly another
> task's. That's the mirror image of the false sample the commit message
> documents for the other direction.
>
> In both cases the interrupt arrives for a counter that hasn't wrapped
> since it was last written, whereas after a real overflow or window
> close the counter sits just past zero. Could the handler drop an
> interrupt when the counter hasn't wrapped relative to prev_count? It
> would need some headroom: a counting event's period is 2^20 - 1, so
> its counter starts at 1, and a real overflow, which leaves it just
> past zero, would look unwrapped too. Capping left at half the counter
> range, as armpmu_event_set_period() does, keeps the two cases apart.
> That would fix both directions, and the caveat could come out of the
> commit message.
>
> Patch 9: Now that patch 11 drops DTB miss samples from cycles:p, it
> may be worth giving retired loads and stores a data source too. As
> PALcode fills the TB, an access that retired without a DTB miss trap
> must have hit, so mem_dtlb =3D PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT. The
> memory sort keys would then show DTB hits and misses side by side for
> cpu/cycles,profileme/. LDA/LDAH and the ldq_u UNOP would need leaving
> out, as they don't access memory.
>
> Loads into $31/$f31 need care either way. As the comment in
> do_page_fault() says, as of EV6 they're prefetches, which never fault
> (or are suppressed by the PALcode). If a prefetch that misses the DTB
> is dropped without a trap, they'd need leaving out of the hits too. If
> it does trap, patch 9 reports it as a LOAD, where PERF_MEM_OP_PFETCH
> would be more accurate. Running your one-word-per-page test with loads
> into $31 would show which.
>
> Patch 11: Kept samples still carry the full period, so with -F the
> sample rate, and perf report's approximate event count, fall by the
> killed fraction: to about a third on your mispredict loop. That seems
> the right trade-off, and it's what IBS's swfilt does with the samples
> it discards, but it may deserve a sentence in the commit message.
>
> For the next spin of the tools series, alpha-profileme.py wants the
> same PM_KILLED_BM check before it trusts TRP and MIS. Its example also
> records instructions:p, which after patch 11 has no killed samples, so
> the killed% and invalid% columns would always read 0;
> cpu/instructions,profileme/ keeps them.
>
> Two possible follow-ups, neither of which needs to hold up this
> series. perf mem has no Alpha events yet; cpu/cycles,trapped/p would
> be a natural default, or cpu/cycles,profileme/ if retired accesses get
> a data source. And as the driver already works out the profiled
> instruction's mode for the trap frame swap, ProfileMe events could
> honor exclude_user and exclude_kernel by dropping samples, as IBS's
> swfilt does, with PALmode counting as kernel. PERF_PMU_CAP_NO_EXCLUDE
> is PMU wide, so event_init would then reject the exclude bits itself
> for Aggregate events. That would let unprivileged users run perf
> record at the default perf_event_paranoid of 2, where the tool sets
> exclude_kernel for them.
>
> Thanks,
> Ian
>
>

One detail on the wrap check: alpha_perf_event_update() also advances
prev_count on an ordinary read. Should we cover the case where a read
has already accounted for a real wrap before its PMI is delivered?

On prefetches, the EV67 HRM, section 2.6 (p. 2-23), says loads to
R31/F31 may generate exceptions that PALcode must dismiss. So seeing
no Linux fault wouldn't by itself tell us the access hit in the DTB.

I also checked the saved ES40 recordings: 344 of 266425 samples had
both PM_KILLED_BM and TRP set, and 53 of those also had MIS set.
That confirms the Python decoder needs the killed check on EV67 too.

Thanks,
Magnus

>
>
> > ---
> > Changes in v5:
> > - Patch 5: refuse precise_ip 3, as a sample with a PALmode PMPC keeps
> >   the interrupted PC. Thanks to Magnus Lindholm.
> > - New patches 8 to 11, from Ian Rogers' suggestions: the sample weight,
> >   the data source of DTB misses, config1 filters, and retired-only
> >   precise samples. The last changes what a default perf record shows.
> > - Link to v4: https://patch.msgid.link/20261102-alpha-profileme-v4-0-61=
e00f5e1da8@gmail.com
> >
> > Changes in v4:
> > - Patch 4: move __entry_save_end past the r16-r18 stores in entSys,
> >   as PAL_callsys does not save them and interrupts are still enabled
> >   there.
> > - Patch 5: report the user registers when the profiled instruction is
> >   in the entry code but the interrupt was taken after it, since
> >   perf_get_regs_user() sees the PMPC rather than the interrupted PC.
> > - Link to v3: https://patch.msgid.link/20261101-alpha-profileme-v3-0-92=
d511b5a044@gmail.com
> >
> > Changes in v3:
> > - New patch 3: clear PERF_HES_UPTODATE when an event starts counting,
> >   so that a stop before the first start does not lose the count.
> > - New patch 4: report no user registers for a sample taken in the entry
> >   code, where the frame at task_pt_regs() is not complete. An interrupt
> >   nested on one taken there is still not caught.
> > - Patch 5: a user instruction whose interrupt is taken in the kernel no=
w
> >   reports its PC with no registers or user stack, as the frame at
> >   task_pt_regs() may not be built yet. Thanks to Magnus Lindholm for
> >   finding this and for the fix.
> > - Patch 5: also move the counter away from overflow when a ProfileMe
> >   event is removed, or stopped without PERF_EF_UPDATE, as
> >   alpha_pmu_del() does not go through alpha_pmu_stop().
> > - Patch 5: ignore an interrupt that was pending when the event was
> >   stopped. Document that rewriting a counter does not cancel one.
> > - Link to v2: https://patch.msgid.link/20261030-alpha-profileme-v2-0-c7=
02f1c65272@gmail.com
> >
> > Changes in v2:
> > - Patch 1: explain why bit 0 clear means all processes, although the
> >   Architecture Reference Manual says otherwise.
> > - Patch 3: fix a CPU wedge during high-rate ProfileMe sampling. The
> >   ProfileMe counters are now written twice, and a stopped counter is
> >   moved away from overflow, as EV67 HRM PALcode restrictions 32 and 38
> >   require.
> > - Patch 3: set the profiled PC in place in the trap frame of the
> >   instruction's mode instead of in a pt_regs copy on the stack, so
> >   sampled registers and stack values are those of the right frame.
> >   A kernel instruction whose interrupt is taken in user mode gets a
> >   per-CPU frame holding only its PC, so the user frame is not changed.
> > - Patch 4: drop the reserved field and pack the 64-bit fields of
> >   struct alpha_profileme_sample, so they are 8-byte aligned in the
> >   sample record and the record needs no padding. This changes the raw
> >   data layout.
> > - Patch 5: compute the jitter with mul_u64_u32_shr() and saturate the
> >   sum, so that large periods cannot overflow.
> > - Link to v1: https://patch.msgid.link/20261028-alpha-profileme-v1-0-d4=
4b52bf2500@gmail.com
> >
> > ---
> > Matt Turner (11):
> >       alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the logging options c=
all
> >       alpha/perf: add sysfs format and event attributes
> >       alpha/perf: clear PERF_HES_UPTODATE when an event starts counting
> >       alpha/perf: do not report user registers from the entry code
> >       alpha/perf: implement ProfileMe sampling
> >       alpha/perf: attach ProfileMe status as PERF_SAMPLE_RAW data
> >       alpha/perf: optionally randomize the ProfileMe sampling interval
> >       alpha/perf: report the ProfileMe window count as the sample weigh=
t
> >       alpha/perf: report the data source of ProfileMe DTB misses
> >       alpha/perf: add ProfileMe sample filters
> >       alpha/perf: sample only retired instructions for precise events
> >
> >  arch/alpha/include/asm/perf_event.h      |   2 +
> >  arch/alpha/include/asm/ptrace.h          |  12 +
> >  arch/alpha/include/asm/wrperfmon.h       |  36 +++
> >  arch/alpha/include/uapi/asm/perf_event.h |  31 ++
> >  arch/alpha/kernel/entry.S                |   9 +
> >  arch/alpha/kernel/perf_event.c           | 535 +++++++++++++++++++++++=
+++++++-
> >  arch/alpha/kernel/perf_regs.c            |  13 +
> >  7 files changed, 625 insertions(+), 13 deletions(-)
> > ---
> > base-commit: 330517c63aa9b48227b6ab45f01003effac77ae4
> > change-id: 20261024-alpha-profileme-6e98a977cb54
> >
> > Best regards,
> > --
> > Matt Turner <mattst88@gmail.com>
> >
