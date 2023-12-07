Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfnAQZ6M"
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13792D7F
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 20:42:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50beed2a46eso2502e87.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 20:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701924147; x=1702528947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWHFsJ/G14HmyXGZdwPpGPR5F0PivmBz3jwLXtJ0OGw=;
        b=dfnAQZ6MtfiWLrVSjqr1O2qBa7iU/NcfPVj49QrERrY/szJKkZUyxtyvuGH7XDXbAh
         4JVRuL9NBvsqy1DvLVXos/Ajulf5aA3BM1FTHC+oIG4A6OvRBdwb/MyZ0/AMclrNY0r8
         LoQt81drBlqhcQbzvLazgOufYmTbUmI30SThkgBDB3o2IJ7j1KYJd5yNr8O3o4RLH7oC
         yUgvhFVZUvWLYC+2q+hSnSJ4etvu95Dqn91x6iQP/Itcmblhof+3CvJTpHOySiOADV16
         4gJ8aNrpsHI7yETS7NUDiYpLEyJ9gk3e3a/ISuLGecGkHNWmiiIjHOO6tVbaSSR9miOH
         jSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701924147; x=1702528947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWHFsJ/G14HmyXGZdwPpGPR5F0PivmBz3jwLXtJ0OGw=;
        b=Z7f8Lffjq3LYmNRj83xOY8d3BYN6C1kumvGoGKxpc7XLR0iX6k55Z0tLKAm/DRkHDH
         D84d3B5D308BiyfZA26MzW3RdL9eK1SVN07Eo7VSnJfnF1rXSvZvJnwP2vnws9FksmAA
         XW4g+8xGm55y9+LJAY45P39D3j/TEhdCNhCmqyh7wd8Nt21XGP5Ou+ZGM6Y6V1SqRjUw
         V0YVJbnB0eeDT+PW0qKTrqFAXFfEx/4G7caozseg1qHk8OjQzqwWutP8xRXPohXmIoTv
         n22pryXNK4TbtFKLk6cxMi/2v8Cxnb21CjUNwvdwe7+i/lBEDM2bNyzOHcLuEqfnPehW
         E6KA==
X-Gm-Message-State: AOJu0YxSf0Hp6eMA4Bzeky3UsCick3b34nO32igLXfjDW3AoVgcC6Ve0
	cFjttv7OTOQsCDk/f4qGJsfBdUDJS/aIEQKyjslZrtcp3aAE+BvGwdhtIb2z
X-Google-Smtp-Source: AGHT+IG17eBDZmAhTOt0BUQDCjCqG7ziBasPPsSLysgc1M4JTyO+d2yKw1OPQy1ju5YuxZe0qzGIoIz07LRRf01sTuI=
X-Received: by 2002:a05:6512:3452:b0:50b:f51a:2999 with SMTP id
 j18-20020a056512345200b0050bf51a2999mr116427lfr.4.1701924147108; Wed, 06 Dec
 2023 20:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ac77391.1d70f.18c3ab61090.Coremail.chang-liu22@mails.tsinghua.edu.cn>
 <CAP-5=fXRFOpbqe-z_aQC4xhuS3-Mp6cKNJ8o53fr8UBVboctQQ@mail.gmail.com> <817a188.1bb2b.18c3e3fa344.Coremail.chang-liu22@mails.tsinghua.edu.cn>
In-Reply-To: <817a188.1bb2b.18c3e3fa344.Coremail.chang-liu22@mails.tsinghua.edu.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Dec 2023 20:42:15 -0800
Message-ID: <CAP-5=fW4SCtxtONKmDN14iDhit98D6Sy6og-m2R=BdAQmCmKdA@mail.gmail.com>
Subject: Re: Reply: Re: Can I create and read perf counters in the kernel?
To: chang-liu22@mails.tsinghua.edu.cn
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 12:30=E2=80=AFAM <chang-liu22@mails.tsinghua.edu.cn>=
 wrote:
>
> > -----Original Messages-----
> > From: "Ian Rogers" <irogers@google.com>
> > Send time:Wednesday, 12/06/2023 03:07:02
> > To: chang-liu22@mails.tsinghua.edu.cn
> > Cc: linux-perf-users@vger.kernel.org
> > Subject: Re: Can I create and read perf counters in the kernel?
> >
> > On Tue, Dec 5, 2023 at 8:01=E2=80=AFAM <chang-liu22@mails.tsinghua.edu.=
cn> wrote:
> > >
> > > Hi all,
> > >
> > > I'm doing a research project in which I implement a new functionality=
 in the kernel. Now I want to benchmark the code that I write, e.g., I want=
 to measure the number of cache misses of my code with different workloads.=
 I wonder if I could create perf counters and read them in kernel just like=
 using perf_event_open() + read() in user space to implement the following =
logic:
> > > -------------------------------
> > > crate_perf_counter()
> > >
> > > reset_and_start_counter()
> > > run some kernel code
> > > read_counter()
> > > -------------------------------
> > > If I can, what kernel API should I use? Is there any document that I =
can refer?
> >
> > Not directly answering your question, but perf events can filter
> > between user and kernel, e.g. cycles:u and cycles:k. You can use
> > filters like:
> >
> > $ perf record -e cycles:k --filter "ip >=3D 0xffffffff99e036b0, ip <
> > 0xffffffff99e036c0" -a sleep 1
> >
> > To limit what samples are recorded (the magic numbers are addresses
> > for a function in the kernel that you can find in things like
> > /proc/kallsyms).
> >
> > In general perf events are managed by user land, the NMI watchdog is
> > an example of a perf event opened in the kernel. You can use BPF to
> > inject in behaviors with perf events and this is what the perf command
> > is doing above. The perf event filtering is a feature built into the
> > kernel, but you are recording sample globally and just discarding the
> > ones you don't care about. To match the behavior you describe you may
> > want to use bpftrace or write a BPF program, but I don't believe there
> > is a BPF helper currently to enable/disable perf events. You may want
> > to explore BPF kfuncs. In general enabling/disabling events has some
> > cost as the kernel's perf subsystem will do things like considering
> > other events to schedule when a counter is used/freed. PMUs like Intel
> > PT and ARM CoreSight have filtering built in, you may want to explore
> > these.
> >
> > Thanks,
> > Ian
>
> Hi Ian,
>
> Thank you for your help. Following your advice, I read some documents on =
BPF,
> and I think I can use the following way to implement what I need:
>
>
>                                                         user space progra=
m
> user space                                                     |
> ---------------------------------------------------------------|-----
> kernel                                                         |
>    -------------------------   bpf_perf_event_read()           | insert p=
erf events
>    |   entry BPF program   | ------------------                | using bp=
f()
>    -------------------------                  |                |
>    |                       |   ----------------------------------------
>    |      benchmarked      |   |          perf event BPF map          |
>    |      kernel code      |   | (BPF_MAP_TYPE_PERF_EVENT_ARRAY type) |
>    |                       |   ----------------------------------------
>    -------------------------                  |
>    |   exit BPF program    |-------------------
>    -------------------------   bpf_perf_event_read()
>
> 1. Write a user space program which
>    1.1 creates and loads a BPF_MAP_TYPE_PERF_EVENT_ARRAY map
>    1.2 creates the perf event that I want to read in kernel
>    1.3 inserts the perf event into the BPF map
>    1.4 creates and attaches two BPF programs at the entry point
>    and the exit point of the kernel code to be benchmarked
>
> 2. Before the target kernel code is executed, the entry BPF
> program is triggered and invokes the bpf_perf_event_read() to
> get the value of the perf event.
>
> 3. After the target kernel code is executed, the exit BPF
> program is triggered and invokes the bpf_perf_event_read() to
> get the value of the perf event.
>
> 4. Calculate the delta of the two counter values retrived in
> step 2 and 3 as the final result.
>
> Do you have any comments on the aforementioned method? If you
> think it works, I'll try to implement it.
>
> Your answer really helps, thanks a lot!

Hi Chang,

what you describe should work, some more thoughts :-) Perf events use
file descriptors the perf tool can run into file descriptor limits, it
can also be costly to switch perf events on context switches, for this
reason the perf stat command has a --bpf-counters command. The
--bpf-counters option opens a system wide event and simulates counters
using BPF maps, bpf_perf_event_read and running a BPF program on
context switches. Perhaps there is a way to integrate what you want to
do with what perf record is doing with filters, but for the perf stat
command.With BPF counters normally a value is written when a context
switch happens, but with the filter we'd need a way to have a BPF
program start when a condition becomes true (the program would read
the initial value) and then write the actual BPF counter value (the
delta between the current and the initial value) when the condition
becomes false. I note there is filter syntax for "start" and "stop"
but I'm not very familiar with the mechanism. I'm thinking out loud as
it is always nice to get additional features into the perf tool :-)

For your use, you may want to look at leader sample in the perf list
manpage (man perf-list). With leader sampling when the first event
samples (perhaps it can be a tracepoint or kprobe), the other counter
values in the group are read. If you only want to know cycles, you may
also want to look at timed LBR (https://lwn.net/Articles/680996/).

Thanks,
Ian

> Chang
>
> >
> > >
> > > I'd be very grateful if anyone can help :)
> > >
> > > Kind regards,
> > >
> > > Chang Liu
