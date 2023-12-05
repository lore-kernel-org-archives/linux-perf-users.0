Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scXw0st0"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B8181
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 11:07:16 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50beed2a46eso444e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2023 11:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701803234; x=1702408034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej3kQBx3EFuPWQzAG+dXMq1q7o7L2rJhMK8Ry3wRpZA=;
        b=scXw0st09jwZ2T7+fncZ6sGore8YnmQY+WYcgghtWT3frvotV6UwiIaJf0yti/KJxH
         InjMX9UKHYjaiyGYRscYW4AoXxfYr2cA9UKTt4DLqfAmwrHEanA+jzO2ixR1uCByBzaA
         wUyoZqm40y4ZfdUsxHqVr3Q9wq/gM6vQGPRnMed5oR0ZIgfxiL50hYBHXWyutg23c6Ox
         uyfNsaq4K5dEN3IToZrmZfrA9xC/mmXuSWLJJCN032T6vRKroUxr/l0tuvzcZUVUC0WR
         pLB2JtAnb07cEfS6s1QE2b25aqH8wUX928HZwzMcepVB/IYTWk+E7EruRcA0S9sVBEDh
         xMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803234; x=1702408034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ej3kQBx3EFuPWQzAG+dXMq1q7o7L2rJhMK8Ry3wRpZA=;
        b=HZV/nnVD+Ly1I9+qsv6wITxpVH37exbGmCr7DKrq6WM63L4gVMITF/ENdwnj+zZENG
         lUr/8pczW3IobjmmnfrzOU4yerNWxAvv6epEhN0anaDCSYvmCKnkY/0jHXw5Y3YK/+Fn
         jjFRGRYtv8RKav/9h5wXzLjEUId1w0E7vAuBfneBBMrjz1z+ulAygLjhHuj+lplUAnYl
         lXzhgnF+JHCd5SRkWISqkXCPRGI70NnXqy5V0CFTXDI4KLkP25MP4quJw05Qv1DXYQty
         1FgyprlK8pE3Q+cczhX72WRL1W8viq9XRRtnY+KL2zblinQmZ7+bSjONpmLWD9YptlLH
         DQMA==
X-Gm-Message-State: AOJu0Yx5i1U7YKcygpnX1DWz095RybjqftTyC79MDSy5kPXfLVagjT2l
	H8o+4NDrT7gikaxr/u8NYiG70DQWAIDaQoixS8zLIrxPRkE3Af9V2QRwgESV
X-Google-Smtp-Source: AGHT+IH50AP4nKcixs6NdUxZaj4WXJIkkIhTylwjFhT080e92ZvW1/jl8FFHyq9FpKrgYFIU7JgqUmosoeODSfx+9Oc=
X-Received: by 2002:a05:6512:ba1:b0:50b:fa8d:f28b with SMTP id
 b33-20020a0565120ba100b0050bfa8df28bmr3399lfv.1.1701803234217; Tue, 05 Dec
 2023 11:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ac77391.1d70f.18c3ab61090.Coremail.chang-liu22@mails.tsinghua.edu.cn>
In-Reply-To: <3ac77391.1d70f.18c3ab61090.Coremail.chang-liu22@mails.tsinghua.edu.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Dec 2023 11:07:02 -0800
Message-ID: <CAP-5=fXRFOpbqe-z_aQC4xhuS3-Mp6cKNJ8o53fr8UBVboctQQ@mail.gmail.com>
Subject: Re: Can I create and read perf counters in the kernel?
To: chang-liu22@mails.tsinghua.edu.cn
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:01=E2=80=AFAM <chang-liu22@mails.tsinghua.edu.cn> =
wrote:
>
> Hi all,
>
> I'm doing a research project in which I implement a new functionality in =
the kernel. Now I want to benchmark the code that I write, e.g., I want to =
measure the number of cache misses of my code with different workloads. I w=
onder if I could create perf counters and read them in kernel just like usi=
ng perf_event_open() + read() in user space to implement the following logi=
c:
> -------------------------------
> crate_perf_counter()
>
> reset_and_start_counter()
> run some kernel code
> read_counter()
> -------------------------------
> If I can, what kernel API should I use? Is there any document that I can =
refer?

Not directly answering your question, but perf events can filter
between user and kernel, e.g. cycles:u and cycles:k. You can use
filters like:

$ perf record -e cycles:k --filter "ip >=3D 0xffffffff99e036b0, ip <
0xffffffff99e036c0" -a sleep 1

To limit what samples are recorded (the magic numbers are addresses
for a function in the kernel that you can find in things like
/proc/kallsyms).

In general perf events are managed by user land, the NMI watchdog is
an example of a perf event opened in the kernel. You can use BPF to
inject in behaviors with perf events and this is what the perf command
is doing above. The perf event filtering is a feature built into the
kernel, but you are recording sample globally and just discarding the
ones you don't care about. To match the behavior you describe you may
want to use bpftrace or write a BPF program, but I don't believe there
is a BPF helper currently to enable/disable perf events. You may want
to explore BPF kfuncs. In general enabling/disabling events has some
cost as the kernel's perf subsystem will do things like considering
other events to schedule when a counter is used/freed. PMUs like Intel
PT and ARM CoreSight have filtering built in, you may want to explore
these.

Thanks,
Ian

>
> I'd be very grateful if anyone can help :)
>
> Kind regards,
>
> Chang Liu
