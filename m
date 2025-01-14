Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F99168DA
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736827804; cv=none; b=Kgj6mU9rM5b7iBsW854AWlYV6zLUabKyRHT1LqBcp9/dsdkqBuy4T4aY1YKQ0sAl9Cln83OyzGHn2khIjZYWPFjM2M4K+gyLHHZkEPETO+zA6T3e247C/8eoH7HTG58DCTCTmDdJX4oAT6Bk0MALCKt832fHotCUkCcq4qwqC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736827804; c=relaxed/simple;
	bh=qVkvgMENHI8flH4JDjkYtPlC4BZf0FntYuDOVZdFbt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JApG3JOpPNkA/HlEoRTavDJed5QoOq8sVe8wDeHqMHwQJNB/kO887sCf4v20w3vonMKGsy0cXGD8gUv4kPqdvMvVj0VJiWqmy3gMPSeo8u3j/PwIGltrRvHdieFvW7oz0BbY55kLT2h841oZkFLAjDqMCyd7Ey6gkAdy9THh4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/H4nN+i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/H4nN+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736827801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y50vhiuQ0vt1wwiKIfMh8A/carLd1iG8aN39/Ha5s94=;
	b=U/H4nN+i8jUHhX8sjDAgWs1X2uAvYMUcjP5w1tuGB5/H2iNHP+oVkbbIqFs35ofJV2XkLn
	jezodL2U0yfnOPxDO68vlMSKiB+R9xAIU/MdzxsHGzlWMCDDJ+hg1M+zgcL90jkrKyjWQP
	8CbkON+ppuu4aKEfXTGnCpOaY0oy8m8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-IIBofCr_OiWpzr416FlDlA-1; Mon, 13 Jan 2025 23:10:00 -0500
X-MC-Unique: IIBofCr_OiWpzr416FlDlA-1
X-Mimecast-MFC-AGG-ID: IIBofCr_OiWpzr416FlDlA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f129f7717fso9239209a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 20:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736827799; x=1737432599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y50vhiuQ0vt1wwiKIfMh8A/carLd1iG8aN39/Ha5s94=;
        b=QMb2zvo3G1UYc68lKAMFo+YdbwpjafLOJWRjpwPSxENp54nU8Sk0nypDAiGnqJjgzo
         /frvKNUILZis8pYsFM+sWg4OJrlrBrUru77G7cb2972HZD9dqkldj89EPvrnky4uuM4h
         s+x2UpZ/fYilsU2DVang9jYxvyLzV7iDjHQL9uOpS3QzKl7G328ggrWo9o5C23L5LsPF
         VTSDniJEsCqb54o73nTdTntwfeCSkspA8+fmatesr/7U1bJIuw6+895aZ9xOmKO1gCLA
         JtNHAIvsqc3AE1vBy0IE+hUGfb4nHyFk3Wyn0W14sxQD0wH1RsXDbkAkyVMaSI30OICO
         EGoA==
X-Gm-Message-State: AOJu0Yzdg3rzEyjpbvNgFnOcDHOAxIBzWBXMhasPRoEsNPxiJY8p/tyO
	5biDdYbeJRpSG/ln/KihzPPUtuYXe6V7PDA6bTTwFqL4dW3LuSQCCpZa1RusIfeWs1nt6tiwW9+
	uPs0lxR3KqTn9p6Npxd0V7O3vVkmj7PclSTLB09U67zshxLShjDtLKZfhQukGG1hcX85Ss4Ze25
	ur1FzRt58zXssw4o/nlmtKdKSbTt4/gj2JfH6acTPeWsVykCOKU+U/CZQ6Mw==
X-Gm-Gg: ASbGncsPOncwISVAreFjgdKk73Jif/6ZHtwuBK+2KXCKH5ibNGM5y8Un9yg/dtbRYw5
	fK1q+XiWTmr8MZhLSmU8dZkKqcTtzK+BeYZP/WMg=
X-Received: by 2002:a17:90b:3a0e:b0:2ee:45fe:63b5 with SMTP id 98e67ed59e1d1-2f548e98716mr31776886a91.3.1736827798875;
        Mon, 13 Jan 2025 20:09:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSPMCUHswVKpHcKrdtGDEaAjZA2fPmoSZJmmzJy8rSA1HXFZeDACIerzeftoOHXCnVqKt+bDbktG2Ie1bbSiM=
X-Received: by 2002:a17:90b:3a0e:b0:2ee:45fe:63b5 with SMTP id
 98e67ed59e1d1-2f548e98716mr31776861a91.3.1736827798530; Mon, 13 Jan 2025
 20:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAATMXfnhT-Uqp9rfBGZesjYSmbn8UAcyXzuhkhM8Uvg7wCX5Dg@mail.gmail.com>
 <CAH0uvoiJ=F3U9ib7_pmUPttMcSaSYkmD8Pi9qTLrtWHxEw9fKQ@mail.gmail.com>
In-Reply-To: <CAH0uvoiJ=F3U9ib7_pmUPttMcSaSYkmD8Pi9qTLrtWHxEw9fKQ@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Tue, 14 Jan 2025 12:09:47 +0800
X-Gm-Features: AbW1kvYq7-xORwKlZ8HLiJVgSAQG5L8YHl818ufZo8pwT9TIKCd5l3g0aW7xIv4
Message-ID: <CAATMXfnHzRG+i0DWBuMG17n-NgQOkQHd2JCU0bUjNrvnzuMaEg@mail.gmail.com>
Subject: Re: perf record "--off-cpu" options failed on 1 [v]cpu machine
To: Howard Chu <howardchu95@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Michael Petlan <mpetlan@redhat.com>, 
	irogers@google.com, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Howard,

Thanks for your response and explantion!

On Mon, Jan 13, 2025 at 11:44=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> Hello Qiao,
>
> On Sun, Jan 12, 2025 at 6:35=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrot=
e:
> >
> > Hi all,
> >
> > I meet this problem when running the perf test "record_offcpu.sh" on 1
> > [v]cpu machine:
> > ---
> > # ./record_offcpu.sh
> > Checking off-cpu privilege
> > Basic off-cpu test
> > Error:
> > The /tmp/__perf_test.perf.data.mjj
> > FB data has no samples!
> > Basic off-cpu test [Failed missing output]
> > ---
> >
> > The command executed is "perf record --off-cpu -e dummy -o ${perfdata}
> > sleep 1" that can not
> > record any samples:
> > ---
> > # perf record --off-cpu -e dummy sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.008 MB perf.data ]
> >
> > # perf report --stdio
> > Error:
> > The perf.data data has no samples!
> > # To display the perf.data header info, please use
> > --header/--header-only options.
> > #
> > ---
> >
> > I also tested Hardware event 'cycles', and got the same results.
>
> Are you saying that you ran
> ```
> perf record --off-cpu -e cycles sleep 1
> ```
> And got no samples? The 'off-cpu' option collects samples in a BPF map
> which is separated from the usual perf ring buffer, the latter is used
> to collecting the cycles event. If perf record --off-cpu -e cycles
> sleep 1 doesn't collect samples then perf record -e cycles sleep 1
> shouldn't collect any samples either.

Understand! Thank you!

>
> >
> > But when test the Tracepoint event "sched:sched_switch", it works and
> > can get the samples:
> > ---
> > # perf record --off-cpu -e sched:sched_switch sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.009 MB perf.data (2 samples) ]
>
> There are two samples. Can you please check if there is an offcpu-time
> sample in this perf.data file? Specifically:
> ```
> perf script | grep offcpu-time

Command "perf script | grep offcpu-time' did not show any
"offcpu-time" sample in perf.data.
btw, in test case "record_offcpu.sh" use the 'perf evlist' to list
samples 'offcpu-time'.
# perf script | grep offcpu-time
# perf evlist | grep offcpu-time
offcpu-time

> ```
>
> If there isn't one, can you please run:
> ```
> perf record --off-cpu -a
> ```
>
> and leave it running for a couple of seconds? Then, run:
> ```
> perf script | grep offcpu-time
> ```
> to see if any offcpu-time samples appear.

Yes, when use '-a', 'perf script' can show the offcpu-time samples.
# perf record --off-cpu -a   <--- C-C after 5 seconds
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.139 MB perf.data (91 samples) ]
# perf script | grep offcpu-time
tuned     913 [000] 18446744069.414584: 2000177867 offcpu-time:
tuned     700 [000] 18446744069.414584: 2000204356 offcpu-time:
perf    5865 [000] 18446744069.414584: 2780030394 offcpu-time:
sshd    5385 [000] 18446744069.414584:     163718 offcpu-time:
perf    5866 [000] 18446744069.414584: 1001042294 offcpu-time:

>
> I suspect that it might have something to do with BPF, although kernel
> version 5.14 includes all the conditions necessary for perf record
> --off-cpu to function properly. Can you please check if the BPF maps
> are working as expected by using bpftool? That is to say while
> running:
> ```
> perf record --off-cpu -a
> ```
> Check the bpf map:
> ```
> bpftool map | grep -E "stacks|off_cpu|tstamp"

Yes, as you said, run the "perf record --off-cpu -a" in terminal, and
run bpftool map:
# bpftool map | grep -E "stacks|off_cpu|tstamp"
228: stack_trace  name stacks  flags 0x0
229: task_storage  name tstamp  flags 0x1
230: hash  name off_cpu  flags 0x0
234: array  name off_cpu_.bss  flags 0x400
235: array  name off_cpu_.rodata  flags 0x480
236: array  name off_cpu_.data  flags 0x400

I can see the "stacks" and "off_cpu" flags by bpftool map.

- Qiao


> ```
>
> It's supposed to say:
> perf $ sudo bpftool map | grep -E "stacks|off_cpu|tstamp"
> 2046: stack_trace  name stacks  flags 0x0
> 2047: task_storage  name tstamp  flags 0x1
> 2048: hash  name off_cpu  flags 0x0
> 2052: array  name off_cpu_.bss  flags 0x400
> 2053: array  name off_cpu_.rodata  flags 0x480
> 2054: array  name off_cpu_.data  flags 0x400
>
> You can also check the BPF maps for data.
> $ bpftool map dump name stacks
> ...
> key:
> 8a ff 01 00
> value:
> cd b4 f1 63 02 72 00 00  6e a6 2f 65 02 72 00 00
> 53 aa 29 65 02 72 00 00  8d 18 4d 65 02 72 00 00
> 71 07 3f b1 ec 60 00 00  ca a1 e2 63 02 72 00 00
> 8b a2 e2 63 02 72 00 00  05 09 3f b1 ec 60 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> Found 533 elements
>
> $ bpftool map dump name off_cpu
> key:
> 3e d0 0a 00 24 d0 0a 00  bd 77 00 00 01 00 00 00
> 00 00 00 00 00 00 00 00
> value:
> 89 61 03 10 00 00 00 00
> ...
> Found 648 elements
>
> Thanks,
> Howard
>
>
> > ---
> >
> > Can someone give me some ideas why this problem occurs?  I try to read
> > the code of the
> > option '--off-cpu', but it looks related to bpf, I have no more ideas f=
or that.
> >
> > Btw, I tested on 5.14.x and 6.12.x kernels, this issue only happened
> > on 5.14.x kernel.
> >
> > Thanks,
> > Qiao Zhao
> >
> >
>

