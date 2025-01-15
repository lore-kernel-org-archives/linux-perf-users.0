Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57722F82F
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929322; cv=none; b=YchdKkI+q6xT5KVyVmKLInGC0o9G3dqUo/oUUrGDXutpBKjLsUWbYT+MzKwIGmBtsBYdK/QEAJLMvwz8VIo7LTya8mjP2XPNRGnnCUjN7oVieBGxBe89Z6ri7ZK2cWqReZ1ZjDLASIYxC4iUI/n/UYllp4Zd7o/SyVbIcL/lO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929322; c=relaxed/simple;
	bh=ZykKxIGqv+X148e2gcaIScS80oYgBRWYk5QnERaRz4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxyM8UzMUY7uwl5ulRAcjQ2/7j8kDEvPHKNrMoQQCu/DImHVBSB2peStuRbyqLxDcKYZyW8BHp2Q/d0kFzq+x/S/9qF3Mck83RHGZm+tg6aMsDQCt19pi9WkEFWSroUMLndsOwYlGqt/uqrc0XaUr0kRswTV1U1XG1hxO2B+MkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjKmx4YR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjKmx4YR"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5787c3fcf8so1529792276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 00:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736929319; x=1737534119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+eFB0JnkI9ZDWzqW+mOkg95ksSlIKxRMXk/0eft3Ag=;
        b=bjKmx4YRF6e29ASRFuXtfNLHwnGjPnrmQsWQA4d0GMiW0U0Z/NWssekavVtZolSfmv
         tOKK/Sqjhkgi/68lWJDEpka2PTIrnGNFHYeTIHRP8fziAabpxw4wN7Njcx3RGOn+TJXR
         B7BTwkol7EuvGXhsVfz9iB910lrpWrk9spO+cRZOPYLSGQ9DozqtbWMT45a1YDDPsXQD
         1dkKgs5vIcMPtTYbLTfVttrZYycIgf3kDdQdvvp3X3goGCH7apvm9FfjdmVYNkeb3F6J
         gA3Qw/sbFJXRIAdZK7ONOOP89UbpuOZ8pDT9AXhUanliqybzHkpg6bqqvqFdo2WAk8PY
         1aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736929319; x=1737534119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+eFB0JnkI9ZDWzqW+mOkg95ksSlIKxRMXk/0eft3Ag=;
        b=TXwx1z+5DMV1HqZWMnsG057g5Gnk02f5SvDqXbZ3bs83IuU+Lb2S844sFWYQPgNRBV
         qriC1U5FJhudUfPT1600Up0Zld6wOYkyUbIenlPZZF5WyfD4yJfJcb2R9YcZAOCfr1Ay
         6QkE6yXFG8yFqZowoYRHN0Dq+2NFG5Kl8b8CUqS9Cx/+8dba5lbpamm2r5jkZvKtKQ8g
         EVI06c18rtuyTods3QQqUwqVJbQG/80yjAtjdEbQKW4V+5lTUDmTCwlQaoWHX1cFH67q
         qt1GVgdQxJ/h3vvkLEHTZsSClU76sTXiFqqHrkoOqiucYUibd0JT8t37GMqqcAmOImFF
         yNCw==
X-Gm-Message-State: AOJu0YyMQGGsNiyGkSFC1ZBCz2kS8ox2KZSlo/CCqMIGeXyLI+gqh9tQ
	9VLQ22AKPU+sCCJx0r/d4//hakyfuBTZKd3hj+N5a/9wesr9Xs76WXubmFIkm2A62kgAb2nonoS
	gIKZEPZ94KQRP7N2WT3rBIukh8uY=
X-Gm-Gg: ASbGncszuR0DUaPDPlaaWrEEZAeDvhF57CMiTVosO51DsyAx7iJ/cb1ux047GoZ6gMb
	6jiwaQ5LcIuww2Chzou/HtIagMJuV0GlWsClx
X-Google-Smtp-Source: AGHT+IHKGgd/PC1MuOtmzBoRsXQYBafRtlCCgN4ClYpzK9RvFh4ROPHNrjLzEmSi8CptsHQ1ZaodA9Al9UtxMu5h670=
X-Received: by 2002:a05:690c:7105:b0:6f6:ca9a:30aa with SMTP id
 00721157ae682-6f6ca9a34d6mr11629997b3.25.1736929319507; Wed, 15 Jan 2025
 00:21:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAATMXfnhT-Uqp9rfBGZesjYSmbn8UAcyXzuhkhM8Uvg7wCX5Dg@mail.gmail.com>
 <CAH0uvoiJ=F3U9ib7_pmUPttMcSaSYkmD8Pi9qTLrtWHxEw9fKQ@mail.gmail.com> <CAATMXfnHzRG+i0DWBuMG17n-NgQOkQHd2JCU0bUjNrvnzuMaEg@mail.gmail.com>
In-Reply-To: <CAATMXfnHzRG+i0DWBuMG17n-NgQOkQHd2JCU0bUjNrvnzuMaEg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 15 Jan 2025 00:21:48 -0800
X-Gm-Features: AbW1kvazznqc1SZ-ynUCOtbb72dt1PRs67e7BQIKYFWcsVNSBv-tudtYN4H5ztU
Message-ID: <CAH0uvogpFVgs5ftBUrkAaf0Lz2+RJJPXWPAGew76D2+qbBFwUQ@mail.gmail.com>
Subject: Re: perf record "--off-cpu" options failed on 1 [v]cpu machine
To: Qiao Zhao <qzhao@redhat.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Michael Petlan <mpetlan@redhat.com>, 
	irogers@google.com, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Qiao,

<SNIP>

> > >
> > > But when test the Tracepoint event "sched:sched_switch", it works and
> > > can get the samples:
> > > ---
> > > # perf record --off-cpu -e sched:sched_switch sleep 1
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.009 MB perf.data (2 samples) ]
> >
> > There are two samples. Can you please check if there is an offcpu-time
> > sample in this perf.data file? Specifically:
> > ```
> > perf script | grep offcpu-time
>
> Command "perf script | grep offcpu-time' did not show any
> "offcpu-time" sample in perf.data.
> btw, in test case "record_offcpu.sh" use the 'perf evlist' to list
> samples 'offcpu-time'.
> # perf script | grep offcpu-time
> # perf evlist | grep offcpu-time
> offcpu-time

Gotcha, thanks.

>
> > ```
> >
> > If there isn't one, can you please run:
> > ```
> > perf record --off-cpu -a
> > ```
> >
> > and leave it running for a couple of seconds? Then, run:
> > ```
> > perf script | grep offcpu-time
> > ```
> > to see if any offcpu-time samples appear.
>
> Yes, when use '-a', 'perf script' can show the offcpu-time samples.

Interesting, then it might be a task filtering problem... Since
```
perf record --off-cpu sleep 1
```
records nothing except for the process of 'sleep 1', which did not
yield any samples in your case...

> # perf record --off-cpu -a   <--- C-C after 5 seconds
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.139 MB perf.data (91 samples) ]
> # perf script | grep offcpu-time
> tuned     913 [000] 18446744069.414584: 2000177867 offcpu-time:
> tuned     700 [000] 18446744069.414584: 2000204356 offcpu-time:
> perf    5865 [000] 18446744069.414584: 2780030394 offcpu-time:
> sshd    5385 [000] 18446744069.414584:     163718 offcpu-time:
> perf    5866 [000] 18446744069.414584: 1001042294 offcpu-time:
>
> >
> > I suspect that it might have something to do with BPF, although kernel
> > version 5.14 includes all the conditions necessary for perf record
> > --off-cpu to function properly. Can you please check if the BPF maps
> > are working as expected by using bpftool? That is to say while
> > running:
> > ```
> > perf record --off-cpu -a
> > ```
> > Check the bpf map:
> > ```
> > bpftool map | grep -E "stacks|off_cpu|tstamp"
>
> Yes, as you said, run the "perf record --off-cpu -a" in terminal, and
> run bpftool map:
> # bpftool map | grep -E "stacks|off_cpu|tstamp"
> 228: stack_trace  name stacks  flags 0x0
> 229: task_storage  name tstamp  flags 0x1
> 230: hash  name off_cpu  flags 0x0
> 234: array  name off_cpu_.bss  flags 0x400
> 235: array  name off_cpu_.rodata  flags 0x480
> 236: array  name off_cpu_.data  flags 0x400
>
> I can see the "stacks" and "off_cpu" flags by bpftool map.

Thanks, then those BPF components are all loaded.

I wonder why it fails to record this single task/process of 'sleep'.
My gut feeling is that the can_record() function in off_cpu.bpf.c
thinks it's not okay to record the task and filters it out. There
might also be something related to the usage of BPF_CORE, especially
considering that the kernel structs changed from 5.14 to 6.12. I'll
take a deeper look into this.

Thanks,
Howard
