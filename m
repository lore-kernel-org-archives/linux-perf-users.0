Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9EF379975
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646142; cv=pass; b=DfvyQ/txb0tKtD3WheU5ILjSSCrXw2V+Wxgwwa+ZBG7CWPdcUIaMw8bLxjz5kkAt/9hbdUo2HL63ZZoxVA3rvLmW+Ky0/e9OrH2EPRkBrZSIOgupEOBRlXI5PL7kzFAiSWTqLIVI26tOVnU8YZcVtCxmHhRgNP7ghsO6z6qskuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646142; c=relaxed/simple;
	bh=j63XlsvTx4Ayhjt5Qej8AXZXz0sVo0Sn8JdGK4fF+kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBaPprtLioxzxFvnP89zDFjKG3U988N2nEA/r7vp4iPgv1R9TBBxUcoJI2hGvtPuKGzibeckPjgufQJy73ZA6Uw63xv2Teb+pWsOG2Vkt5O3oZhaxQUlrGWtHwBywXhHoTXZVEUEbXHfjXuqHc4MS11b7knxbc22j+0/8ln8uVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fY8vB3nq; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fY8vB3nq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae49120e97so625ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 09:42:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772646141; cv=none;
        d=google.com; s=arc-20240605;
        b=WE6FpnSUc8tjXkNq2j4ABaPH7V+U1mx8W1knchQEF0LcWaysd/qXK765H/vyfnbhb+
         nAZ1hpQHeSbJwE5/9wFx1XoeyB2WINaj/IOe3g9F/Y63ir/y6WE/F6T6Ap9BbBBzDHVI
         zZZItpb/Gim6RZDFAn7GQHeH6KBSZXLW9xBmW53X3HBbTQkTsn1JFuRG+rzYxlWAhkJY
         RnRKCgsYeswdxj5XDjM6+2uXYy2tVPmo2xxHA1m01P3ZYOnzbG7e65k5TZYAV40g0QYu
         bX5vtriZiQU9ZHcmwwlYlGT/dcJ0Bq4gZukBwffSN2IoUlRo4AqpsOkB1eS7kOEsfiRN
         3qsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vqCBL+XG+lWoxifv/voc24J4n0Wa3dovePTqI5pndwQ=;
        fh=Om3I8H9+wpMW1/ELKtIn96KalaEBkl+eV8CyIHShCp0=;
        b=Of9wT9UY2ywr4260kTK7acYEbqrYRKzxHHqCf0a8BwR4jnGigmipwIevq4g3JugaEW
         CUxPscN0KDOyftljXkhdCX029cipDVCIqOuJ+Kp74wAbg5AxxuLCxB40RpNP9vovorNm
         xBP1CrgoQznSplWkA3Bj8/ZcZsmvFgiLKewSQ5zWJUZgmUxJzXutIAMEz2RzANn+/8F/
         tW6Nf6f7CU0pAiMucVOFReK81rFyfOY7FPN1lj4npJCktV3vQ8hEb1t/YyPvj8dWGwiq
         HPk57CnF3Dmj+nqVzZQ/Jkk2MTcbx8H/FukF2FKy+Rg3calRj6Fy6Bwho3hhkeS06Y4f
         v/9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772646141; x=1773250941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqCBL+XG+lWoxifv/voc24J4n0Wa3dovePTqI5pndwQ=;
        b=fY8vB3nqwWhO1GCGworh5OCwS7Xj/eU8ZLF2Aa0oa82nf+wGv5/XeC88xbIG5G2ikh
         XKtwoQuPePbjFBY/WfKEJz/YQsXHDC4glPQ+saZFz+px+HGyWbCqREFUOzvZ8fCey8wq
         XBkl1oGwhWmpK6UIlTrP89sJymUgmPXMU9rsptUtL6tYKWZAofh2okQjDIuP94QrBjRi
         rnFUMwHhc5oy7DOAz+DaO6N3z691/R2pUpO7g8UhEP+Fzcgiza5sk9XL2YxMDTZ2ZZA2
         sf3KbT7L4piO20i9QNBA46Vp3l+y7StFqm+jYUcILZmmug7KMKYu09zvgFR/iW0yp3hi
         HHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772646141; x=1773250941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vqCBL+XG+lWoxifv/voc24J4n0Wa3dovePTqI5pndwQ=;
        b=M7KlXbzq+JOVj/RL3eifT5uK7WUqvyiRAfWit3oi993z0Cx/lS+SMtJUt+a7rKBshD
         H4KP0sTWEG2a5DXVuNRECusL1w4wD/5jpsuM9JPZcp7Sif3kWa63tomvbskkjm9ePZJ4
         5sHweccLKIrVnYcSjdNNViaXnfh0ZcDu2IPuuAfAsQgoJhsS79/PWEO5YyfKoXFo78WF
         NYqM0jlNqYpbPIx8oSt2SsHD44YjdpFqv808X/eYCAknriPdC6DdSsb1MZAz+uL534Wf
         NzvE07CB+7++VYSbEqDv2ciYms3c+HK2gPj2VmEhAlOn5bxwQIfioAQa/y2MmQ+BFFv5
         xWZA==
X-Gm-Message-State: AOJu0YzfXZEzG//dFt5JwLnC61pu9uXZqt7/+QMTj9ZN6VeVy/zhntf0
	/X7lprlQ+/cYLx/bMz3o3rgn4P1YbqSBItq+2uTius3zKqHLANmQ1y30edz6ab1JFo6DPSFopP3
	rduDTaTRHOan8SHOhROCsRiiv5Sk4fNZ7N7QRfMv7bKtf/M0qqrlMx5Ftgcg=
X-Gm-Gg: ATEYQzxnsQx2PcoXefp1JbSyfektXek09lMYZiPAxjlUhzOi21Z0TGFB9ipifdWJZ1Z
	gUQifPmNXBp3rH1lk8KHC3bmk0VC+BPzZT4VnQrIha8oNDfa68/Pig2Dpbnw7l8HI6v8Pjl9mhr
	vT6WbyCp/r17vfzCxu2snOVLJkw8edKAuYngzyrRfSpW+W0ZoXyDx5VSJQutEDpjE6s9v9OeTdL
	7fHfzl7jf4tgr0lTcRoC+NW4mdUkVPp6H26Bkn9dfbgxt74geJ8xzZSIN4lDU2kgIKVDN5jT4LX
	MTNV+C6gDXs1qWTkbOQhLqoYqDS/VoKXn0ORow==
X-Received: by 2002:a17:902:d2c7:b0:2ae:507b:6f9e with SMTP id
 d9443c01a7336-2ae7260c03emr337485ad.8.1772646140208; Wed, 04 Mar 2026
 09:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOS8N5C+gSubTGww4Fcom9_+OTFTyBPnoBkt-YnG+Nti6F4GmA@mail.gmail.com>
In-Reply-To: <CAOS8N5C+gSubTGww4Fcom9_+OTFTyBPnoBkt-YnG+Nti6F4GmA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Mar 2026 09:42:09 -0800
X-Gm-Features: AaiRm51LARPI-M6HoLF3fUBgZGym7K2ofUUnZt2iuHH6OSZVxwLGd47oLcQ9ei4
Message-ID: <CAP-5=fUEO7Af1LQNjoLTaiZcXQVbi19obAK_dGj=fShLYm-XiA@mail.gmail.com>
Subject: Re: potential bug -- ignoring frequency for Intel hardware events?
To: Andrew Hunter <ahunter@janestreet.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:02=E2=80=AFAM Andrew Hunter <ahunter@janestreet.c=
om> wrote:
>
> Hi all --
>
> I believe that there's a bug in the logic for initializing sample
> rates for Intel hardware events, and I'm hoping someone can confirm,
> or explain why this is intentional if I'm wrong.  I did these
> experiments with perf 6.12; it's logistically difficult for me
> currently to validate HEAD but I don't think this logic has changed
> much; I can look into replicating it if someone thinks this is a known
> issue. I did most of my experimenting on a Sapphire Rapids machine but
> the basic problem replicates on all the Intel hardware I have access
> to.
>
> In particular: I noticed that the sampling rate for
> [br_misp_retired.all_branches] was quite low; attempting to pass [-F
> 2000] did not seem to affect it, nor did using
> [br_misp_retired.all_branches/freq=3D2000/].  In particular, using
> strace, with either of those settings, I saw [perf_event_open] called
> with freq=3D0 and sample_period=3D400009.
>
> [perf record -vv -F 2000 /bin/ls] shows:
>
> Using CPUID GenuineIntel-6-8F-8
> Attempt to add: cpu/br_inst_retired.all_branches/
> ..after resolving event: cpu/event=3D0xc4,period=3D0x61a89/
> (and a perf_event_attr that matches what I saw in strace.)
>
> I'm not an expert in how perf initializes events, but poking in the
> code I think what happens is here:
>
> https://github.com/torvalds/linux/blob/master/tools/perf/util/evsel.c#L11=
89
>
>
> case EVSEL__CONFIG_TERM_PERIOD:
> if (!(term->weak && opts->user_interval !=3D ULLONG_MAX)) {
> attr->sample_period =3D term->val.period;
> attr->freq =3D 0;
>
> We're picking up the hard-coded default period from the compiled-in
> event definitions.  We check that the user didn't pass -c (and leave
> it be if so) but we stomp on the user's `-F`.   (Passing [perf record
> -c 1000 -e br_misp_retired.all_branches] does appear to sample at the
> high rate I expect.)
>
> I suspect this (and the similar TERM_FREQ below) should check both
> user_interval and user_freq.

Mixing the options I think is messy and broken in some cases. However,
in this case I think the period that gets set is overriden here:
https://github.com/torvalds/linux/blob/master/tools/perf/util/evsel.c#L1537
```
/*
* We default some events to have a default interval. But keep
* it a weak assumption overridable by the user.
*/
if ((evsel->is_libpfm_event && !attr->sample_period) ||
    (!evsel->is_libpfm_event && (!attr->sample_period ||
opts->user_freq !=3D UINT_MAX ||
opts->user_interval !=3D ULLONG_MAX)))
evsel__set_default_freq_period(opts, attr);
```

> The other surprising thing I noticed is that the same logic appears to
> stomp on modifiers passed directly to the event.  For example if I
> run:
>
> $  perf record -vv  -e br_inst_retired.all_branches/period=3D2000/
> /bin/ls  2>&1 | head -n 100
> Using CPUID GenuineIntel-6-8F-8
> Attempt to add: cpu/period=3D0x7d0,br_inst_retired.all_branches/
> ..after resolving event: cpu/period=3D0x7d0,event=3D0xc4,period=3D0x61a89=
/
> br_inst_retired.all_branches -> cpu/period=3D0x7d0,br_inst_retired.all_br=
anches/
> DEBUGINFOD_URLS=3D
> Lowering default frequency rate from 4000 to 2000.
> Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             136
>   config                           0xc4 (branch-instructions)
>   { sample_period, sample_freq }   400009
>
> This I'm less confident of the fix for, but thought I'd mention.  My
> best guess is from this line:
>
> > ..after resolving event: cpu/period=3D0x7d0,event=3D0xc4,period=3D0x61a=
89/
>
> which suggests that the event definition appended a period, and the
> later one is stomping on the former one.

Events can have a period in their json definition, for
br_inst_retired.all_branches is here:
https://github.com/torvalds/linux/blob/master/tools/perf/pmu-events/arch/x8=
6/sapphirerapids/pipeline.json#L66
```
    {
        "BriefDescription": "All branch instructions retired.",
        "Counter": "0,1,2,3,4,5,6,7",
        "EventCode": "0xc4",
        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
        "PublicDescription": "Counts all branch instructions retired.
Available PDIST counters: 0",
        "SampleAfterValue": "400009"
    },
```

I'm not clear on the sys_perf_event_open output data which suggests
you are in period mode but the warnings mention frequency mode:
https://github.com/torvalds/linux/blob/master/tools/perf/util/record.c#L206

> My questions for perf maintainers / people who know this better:
>
> - should the EVSEL__CONFIG_TERM_{PERIOD,FREQ} terms check for both
> user_interval and user_freq, or am I missing a reason that this is
> intentional?

I think there was an attempt to keep the parsing simple and then override l=
ater.

> - should on-event modifiers be respected here? Would fixing that be as
> simple as prepending what we pick up from the JSON?

The json data should always be "weak" and overridden by the command
line arguments.

> - is the behavior I'm seeing (ignoring -F) a bug or is there some
> reason that the overall behavior is intended?

It could well be a bug :-) Thanks for digging into things!

Thanks,
Ian

> Thanks!
> Andrew
>
