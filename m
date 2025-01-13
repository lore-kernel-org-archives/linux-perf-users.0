Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC824023A
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783037; cv=none; b=UTieuB7BljEojjM/ndGOcEuCcM8n9fm9zHmRUVXPuLrb/VP9cQjvMA5Dy7t5g3svZzxIy8LJR2I70lO/DauhEr0NDUibSBiUiEqrFgFrx4y9BqZE8xd08YlbYfvToqOzPR/bDkF0Hs4HtdmeK0m3m/S3qSRPm/AOX/ok9LKLuWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783037; c=relaxed/simple;
	bh=Oh/eiVdpDemFsEWWDRQdE0a//TR8mVx0ARtz3xlPSdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDLZMJM9pZaKOTiqXhN1A48he6NmH0sL3WwjViFWGPfcjFgFJECOwjmS/wGA58iKDc5/JMrfvTYiNdhfcDplAjb4S7j2fFMyo9DFNIRlaS7STCvsMn7peujHDCQuofvTx4l0+kdOhi1vGf4HVq3ZLR/Q8BIaqZWirsaMNxKvRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPKjHdcD; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPKjHdcD"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so7385570276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736783035; x=1737387835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyWG966mvDcxs5T4Oj63RiDftVM/4HqLJ8+J445vIZw=;
        b=gPKjHdcDxVjH+9N73kfX1aBldJUzFq5mbBxq85wGSjZnfXp8qNf2xDRwPzzjF0lO0c
         +NcWBuyHLF7XXivgu/KtynCMqumD4x4L5KgpukeJ1CkQUHj0m5rJc0g62lzptKAcEfdX
         h3q1L5xmMkMRLb6GxY7CoLX0VuwSTo+txleWcVO1JonepCYupyk2RUEMqCLLa/nQrCMU
         +1PIvBaKKijhkoNvU8LV8F/VQURfVNM0tKHx3nKxaJP24Koxzu8ehlGjC5G4rRpJm9FD
         eGnq14Vyo1MhSuJdxS8KIrmLapDr1/zvKc/d27hfCAtLNYIJBfMGImNbU+eZrTh3VD4k
         Usnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783035; x=1737387835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyWG966mvDcxs5T4Oj63RiDftVM/4HqLJ8+J445vIZw=;
        b=oNhEL7LkpEYp8IBrIh4sJRXUPGtBvOtxJ8AjwWvz6TMzOYps0y0Cay8iIKBY/OFA8P
         2DAWuBNdzjrKXtMcYa9nBJuAQ26KB6H8N5iUzmnidrzPQEAHciYLjjVx7dITjFdVEZrT
         X6QbBV0bjbCkVvThR6tCxf5LXnLOgLK/AaCBwnuqkvOPpsVz5xQdtSt23qI7H41qKxaP
         31NbNHO+o/3q4GmDleUm+MveWQ+lwbx/ouuyURY6NoMVykZs0g5kHJUCF6dMhB8hziuM
         qd8mkwF+k1HZZ5gv154ZTFe/sFEXLYYq9qSpjaAXVEuOv9g8UpYTgI/d5s6RjiT3qad0
         bhnw==
X-Gm-Message-State: AOJu0Yz9ZY5p0ZCObE3+4jYHnkCciRHmgJRibjon8lj/JdiPj3c8FYzW
	1Q/bPjfQz0C3LZEJlLZZBHHBabKqBUPWj9U2LtCvFVpAScZ4e+huBuBKP5volPQzROBsSBSS5hf
	7xvnKM2y5FYCu+AXThZw7GzS33nk=
X-Gm-Gg: ASbGnctd7UWmsUkMSbeuhyb1n0jYxpvF6QyrqC+JOO17AsRSszzwQHS6GKS91EmDa9V
	QOPeoLyUnig/5FBe7sQyCZqHMOx8syWBzNMFXlpqW1vCjum0841yI/3gLBySkmFowWjEpDA==
X-Google-Smtp-Source: AGHT+IHHl5gSlZv6qjGUQzSG7auVjYouPRmqUrULRZ8M1gmm3geJkyBPavkk5ouekQ4t+6m4TrdWBzwrcEgVwHv/DWI=
X-Received: by 2002:a25:6a46:0:b0:e54:e662:94f5 with SMTP id
 3f1490d57ef6-e54ee1dde52mr12055311276.32.1736783033360; Mon, 13 Jan 2025
 07:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAATMXfnhT-Uqp9rfBGZesjYSmbn8UAcyXzuhkhM8Uvg7wCX5Dg@mail.gmail.com>
In-Reply-To: <CAATMXfnhT-Uqp9rfBGZesjYSmbn8UAcyXzuhkhM8Uvg7wCX5Dg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 13 Jan 2025 07:43:42 -0800
X-Gm-Features: AbW1kvb6ti9PQcTzwQ6iKMBvIMlBdvH7hH04Aj4w2M5NJL4h23Y1thSMYPLwg3w
Message-ID: <CAH0uvoiJ=F3U9ib7_pmUPttMcSaSYkmD8Pi9qTLrtWHxEw9fKQ@mail.gmail.com>
Subject: Re: perf record "--off-cpu" options failed on 1 [v]cpu machine
To: Qiao Zhao <qzhao@redhat.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Michael Petlan <mpetlan@redhat.com>, 
	irogers@google.com, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qiao,

On Sun, Jan 12, 2025 at 6:35=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrote:
>
> Hi all,
>
> I meet this problem when running the perf test "record_offcpu.sh" on 1
> [v]cpu machine:
> ---
> # ./record_offcpu.sh
> Checking off-cpu privilege
> Basic off-cpu test
> Error:
> The /tmp/__perf_test.perf.data.mjj
> FB data has no samples!
> Basic off-cpu test [Failed missing output]
> ---
>
> The command executed is "perf record --off-cpu -e dummy -o ${perfdata}
> sleep 1" that can not
> record any samples:
> ---
> # perf record --off-cpu -e dummy sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.008 MB perf.data ]
>
> # perf report --stdio
> Error:
> The perf.data data has no samples!
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> ---
>
> I also tested Hardware event 'cycles', and got the same results.

Are you saying that you ran
```
perf record --off-cpu -e cycles sleep 1
```
And got no samples? The 'off-cpu' option collects samples in a BPF map
which is separated from the usual perf ring buffer, the latter is used
to collecting the cycles event. If perf record --off-cpu -e cycles
sleep 1 doesn't collect samples then perf record -e cycles sleep 1
shouldn't collect any samples either.

>
> But when test the Tracepoint event "sched:sched_switch", it works and
> can get the samples:
> ---
> # perf record --off-cpu -e sched:sched_switch sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.009 MB perf.data (2 samples) ]

There are two samples. Can you please check if there is an offcpu-time
sample in this perf.data file? Specifically:
```
perf script | grep offcpu-time
```

If there isn't one, can you please run:
```
perf record --off-cpu -a
```

and leave it running for a couple of seconds? Then, run:
```
perf script | grep offcpu-time
```
to see if any offcpu-time samples appear.

I suspect that it might have something to do with BPF, although kernel
version 5.14 includes all the conditions necessary for perf record
--off-cpu to function properly. Can you please check if the BPF maps
are working as expected by using bpftool? That is to say while
running:
```
perf record --off-cpu -a
```
Check the bpf map:
```
bpftool map | grep -E "stacks|off_cpu|tstamp"
```

It's supposed to say:
perf $ sudo bpftool map | grep -E "stacks|off_cpu|tstamp"
2046: stack_trace  name stacks  flags 0x0
2047: task_storage  name tstamp  flags 0x1
2048: hash  name off_cpu  flags 0x0
2052: array  name off_cpu_.bss  flags 0x400
2053: array  name off_cpu_.rodata  flags 0x480
2054: array  name off_cpu_.data  flags 0x400

You can also check the BPF maps for data.
$ bpftool map dump name stacks
...
key:
8a ff 01 00
value:
cd b4 f1 63 02 72 00 00  6e a6 2f 65 02 72 00 00
53 aa 29 65 02 72 00 00  8d 18 4d 65 02 72 00 00
71 07 3f b1 ec 60 00 00  ca a1 e2 63 02 72 00 00
8b a2 e2 63 02 72 00 00  05 09 3f b1 ec 60 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
Found 533 elements

$ bpftool map dump name off_cpu
key:
3e d0 0a 00 24 d0 0a 00  bd 77 00 00 01 00 00 00
00 00 00 00 00 00 00 00
value:
89 61 03 10 00 00 00 00
...
Found 648 elements

Thanks,
Howard


> ---
>
> Can someone give me some ideas why this problem occurs?  I try to read
> the code of the
> option '--off-cpu', but it looks related to bpf, I have no more ideas for=
 that.
>
> Btw, I tested on 5.14.x and 6.12.x kernels, this issue only happened
> on 5.14.x kernel.
>
> Thanks,
> Qiao Zhao
>
>
