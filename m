Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3002EB10
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992994; cv=none; b=IfWnT9AtR5tlMd/CwglTFomGsjM5X+CzlNzpgcyycfPZ1WyRlBrXrTGTYlrezbn8zzTdreO2caIjYxqB6dC47yLHlmOjArOqhUYIyxzRO6ztNSal7X6XqQS8D5b232vRg7MqDVhYacCJOPMa+/gub8rp1dZ/9PZZovxlcr3B9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992994; c=relaxed/simple;
	bh=6H6SznWVkd4zqH08Mc3kC1LFnhuC8TP1Wdev/ouSW9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAnM8Z4ISbdY8Gs6mU0rmHSw4WB/oTD1C0CxEkhldSQkiialfjlxjSaSNCrQG/ALbzm5V+ndMaLBbmTaw21h4u5GMNamYL0C/zffFSHMM/YMY35pIrScu/OGFgydvinMoD4A7EUqmIhOTsmMFREoxC34JNjNmHhoyORECGQRogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOnok5gR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOnok5gR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736992991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkcOryu255p1tsSxTm2B4F+up29HLyULWgE6NpeGRSM=;
	b=IOnok5gRZfdNvJDTln254xZRVKHpQ85X9RjcV4nzlyNTtMKy8MhHOWKY2WCBD5Y/9VF0gx
	GE3SQd/6UQv9qSL5Ut526aJDAS270WipwaeigiqmfMTYC2nSrFj8DwWdrtiXq5LJp+//iI
	xjOW2yTDLoT8I7bpGioziz8MrKGVFAw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-1GYzCgp5Ps28GcHvg9yV3A-1; Wed, 15 Jan 2025 21:03:10 -0500
X-MC-Unique: 1GYzCgp5Ps28GcHvg9yV3A-1
X-Mimecast-MFC-AGG-ID: 1GYzCgp5Ps28GcHvg9yV3A
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso945108a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 18:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736992989; x=1737597789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkcOryu255p1tsSxTm2B4F+up29HLyULWgE6NpeGRSM=;
        b=jYu56FXmIzh/eOstleauCKsxmGfvY1DzwiqfXj+URXkXSDVKm3mQd0qExSvK/y212X
         R+Y3rq3+T+u4m7Ap4wUhXwmwXXOJzVi1iKLrO5MxIE1GettEsDPV8TaVnqs3yEKDxA71
         jsPlq6lV7HCFoIGLKqfgkuwJ6JdI+DhB5L57YrKyACfx8Oy6wMjRbOcvA1tu8HpLdKn/
         yKno008Osrkr707i3uOkTbBIo8rf/nBJszyIUzGwG33rr77u2peZL9uziJOcwRlWFKLY
         VEschQ13JNPNDU/9soBCPHY4Xa/jyZ8h4tsIAownTBchFMjF34NqW+fhqoiXoHVIDwy7
         EL1g==
X-Gm-Message-State: AOJu0YwFeuueZiqvwN2IJSqi9DAYS8+PV40u8UQULJrB+eI6ELHJIxIb
	p1sqvLgHjbSdq8HqCFt16VIQoJ7ZgEKBSzdR0h9c3FkL1EbXl7WUALR38WufKaexC6wJwIsFyPi
	uys2vhma/73WuYa4pZ7FbEfqCzRCbwUFN/2f6vcfVxK03EkHTyXD+T6C/4o0JEDeRIFJKXdhF3u
	J2Et2ct1Thfb3nb/1ab1oZO907ax1B803vctFSMgOXIw==
X-Gm-Gg: ASbGncsbojNk744mLYPwuZBRIxD1JZKCz0xz3yrMLmPL7feqDeFn+l5oTMs5+IBuNL0
	3eTIGqMe8M2fx2K01pjLSNTJJWUWTX7/62nHKyJg=
X-Received: by 2002:a17:90b:1f8b:b0:2f5:63a:449c with SMTP id 98e67ed59e1d1-2f548f1a28emr43361653a91.28.1736992989080;
        Wed, 15 Jan 2025 18:03:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeS6WaTi8XU5yfIclfR6iqo6b8vHFccf+aCSVntW/p9E1Qnzxf3IwWMKplaPqouNjqJC/e9J3vHrC18C4FaIg=
X-Received: by 2002:a17:90b:1f8b:b0:2f5:63a:449c with SMTP id
 98e67ed59e1d1-2f548f1a28emr43361638a91.28.1736992988814; Wed, 15 Jan 2025
 18:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAATMXfnhT-Uqp9rfBGZesjYSmbn8UAcyXzuhkhM8Uvg7wCX5Dg@mail.gmail.com>
 <CAH0uvoiJ=F3U9ib7_pmUPttMcSaSYkmD8Pi9qTLrtWHxEw9fKQ@mail.gmail.com>
 <CAATMXfnHzRG+i0DWBuMG17n-NgQOkQHd2JCU0bUjNrvnzuMaEg@mail.gmail.com> <CAH0uvogpFVgs5ftBUrkAaf0Lz2+RJJPXWPAGew76D2+qbBFwUQ@mail.gmail.com>
In-Reply-To: <CAH0uvogpFVgs5ftBUrkAaf0Lz2+RJJPXWPAGew76D2+qbBFwUQ@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Thu, 16 Jan 2025 10:02:57 +0800
X-Gm-Features: AbW1kvbXSuyCxTCjc-EMoUNl9kwHR9EQLDRcla9m_DdsnVgIQJtxFbMKizKR4Dg
Message-ID: <CAATMXfnKPrXpwpoeCLpN2FmAdV2VZwSbMSR=Gau5=6iJfcLKNQ@mail.gmail.com>
Subject: Re: perf record "--off-cpu" options failed on 1 [v]cpu machine
To: Howard Chu <howardchu95@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Michael Petlan <mpetlan@redhat.com>, 
	irogers@google.com, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 4:22=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hi Qiao,
>
> <SNIP>
>
> > > >
> > > > But when test the Tracepoint event "sched:sched_switch", it works a=
nd
> > > > can get the samples:
> > > > ---
> > > > # perf record --off-cpu -e sched:sched_switch sleep 1
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.009 MB perf.data (2 samples) ]
> > >
> > > There are two samples. Can you please check if there is an offcpu-tim=
e
> > > sample in this perf.data file? Specifically:
> > > ```
> > > perf script | grep offcpu-time
> >
> > Command "perf script | grep offcpu-time' did not show any
> > "offcpu-time" sample in perf.data.
> > btw, in test case "record_offcpu.sh" use the 'perf evlist' to list
> > samples 'offcpu-time'.
> > # perf script | grep offcpu-time
> > # perf evlist | grep offcpu-time
> > offcpu-time
>
> Gotcha, thanks.
>
> >
> > > ```
> > >
> > > If there isn't one, can you please run:
> > > ```
> > > perf record --off-cpu -a
> > > ```
> > >
> > > and leave it running for a couple of seconds? Then, run:
> > > ```
> > > perf script | grep offcpu-time
> > > ```
> > > to see if any offcpu-time samples appear.
> >
> > Yes, when use '-a', 'perf script' can show the offcpu-time samples.
>
> Interesting, then it might be a task filtering problem... Since
> ```
> perf record --off-cpu sleep 1
> ```
> records nothing except for the process of 'sleep 1', which did not
> yield any samples in your case...
>
> > # perf record --off-cpu -a   <--- C-C after 5 seconds
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.139 MB perf.data (91 samples) ]
> > # perf script | grep offcpu-time
> > tuned     913 [000] 18446744069.414584: 2000177867 offcpu-time:
> > tuned     700 [000] 18446744069.414584: 2000204356 offcpu-time:
> > perf    5865 [000] 18446744069.414584: 2780030394 offcpu-time:
> > sshd    5385 [000] 18446744069.414584:     163718 offcpu-time:
> > perf    5866 [000] 18446744069.414584: 1001042294 offcpu-time:
> >
> > >
> > > I suspect that it might have something to do with BPF, although kerne=
l
> > > version 5.14 includes all the conditions necessary for perf record
> > > --off-cpu to function properly. Can you please check if the BPF maps
> > > are working as expected by using bpftool? That is to say while
> > > running:
> > > ```
> > > perf record --off-cpu -a
> > > ```
> > > Check the bpf map:
> > > ```
> > > bpftool map | grep -E "stacks|off_cpu|tstamp"
> >
> > Yes, as you said, run the "perf record --off-cpu -a" in terminal, and
> > run bpftool map:
> > # bpftool map | grep -E "stacks|off_cpu|tstamp"
> > 228: stack_trace  name stacks  flags 0x0
> > 229: task_storage  name tstamp  flags 0x1
> > 230: hash  name off_cpu  flags 0x0
> > 234: array  name off_cpu_.bss  flags 0x400
> > 235: array  name off_cpu_.rodata  flags 0x480
> > 236: array  name off_cpu_.data  flags 0x400
> >
> > I can see the "stacks" and "off_cpu" flags by bpftool map.
>
> Thanks, then those BPF components are all loaded.
>
> I wonder why it fails to record this single task/process of 'sleep'.
> My gut feeling is that the can_record() function in off_cpu.bpf.c
> thinks it's not okay to record the task and filters it out. There
> might also be something related to the usage of BPF_CORE, especially
> considering that the kernel structs changed from 5.14 to 6.12. I'll
> take a deeper look into this.

Thank you, Howard! Appreciate your help!!

>
> Thanks,
> Howard
>

