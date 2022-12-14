Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41454C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Dec 2022 18:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiLNSki (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Dec 2022 13:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbiLNSka (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Dec 2022 13:40:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8427C2A733
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Dec 2022 10:40:24 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay40so12063202wmb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Dec 2022 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2xXj6E7TqJQIVDtAmPgd4vi/xIzD5cJJ8HWFRiZ4xRI=;
        b=in2I0qEOIgJnTYP972LD+zd3oHVTu2LylyTu6b8XVVAs85I85P0u7YgS5R3LWC6MH8
         9myZCKctu+Tu5Ka18GAHdljk9RXhsoLztjVlUt1P1Ka9l/zf42D/WDPRBUuPoLbGIPnG
         VM2GT1CBMPtKXxXGHyXesXPI9CAd8oWFIFZKXd002ueqWcgwiDVpOJ1bcVEQIpIF3q3U
         cwg87bFEkMjfLyh57hSS1BgZq75JvNxedGRlZg89K5ml7W4PuXpd6wttQGCWYtnuUQIY
         BtEvI7YsW7YVwg9N3Z/XhvHpf0RRwpVvcDayNRYG6ISVPcvnRzJwCLEh6KomzSXEMYkt
         iIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xXj6E7TqJQIVDtAmPgd4vi/xIzD5cJJ8HWFRiZ4xRI=;
        b=Ptade5AUlysoC6sz+A8o0UTdDmubZ7Abld5F7MyharzijZDAHSUafcetDGLd7nQRqZ
         c4JBoNduqezdWAbmpI1qc4R1xz7N4zUd8B5RQbu+mYoQcoiiOcy36BSatl5ZDkFyn/NM
         /ok9MpTF1lUME4Nb/ktp13ygIipFqYCXZxC7YGJQZ+oYEpySd73IHF/Ft4EBS51jP4Zr
         sP2PKSfdH+lwMwGPYWXLTZlqXrEcqtOvS2rTzXes5jNXCI6UnvMJpBAVykpHe+xf52jD
         nNIRoueeUyy0NtYb2Y/hBLGGw/DHzEEKD8qhdzhM521/HLc7I5MSaWLk03GE6Xd57GlZ
         h0Vg==
X-Gm-Message-State: ANoB5pmpugMnsE/4ZQW0D/GNUQoMecEtO3G7qTXrQo65vq91jEFcZZdb
        D3kxn8wGzR77fVegTy+/ffTJJ71IFzD+nrHVPYAnCw==
X-Google-Smtp-Source: AA0mqf4eBc5zW0DATSSfPquCQ1oPo3nICdqrX59QalQ07IhOwXeKFMlcXQRVYHyH4B2GEimospkT2fwN0FZHvseXAiw=
X-Received: by 2002:a1c:7203:0:b0:3c6:c109:2d9 with SMTP id
 n3-20020a1c7203000000b003c6c10902d9mr264937wmc.149.1671043222838; Wed, 14 Dec
 2022 10:40:22 -0800 (PST)
MIME-Version: 1.0
References: <58f34e62-81d7-fc71-dec2-03e88ee36392@ijclab.in2p3.fr>
In-Reply-To: <58f34e62-81d7-fc71-dec2-03e88ee36392@ijclab.in2p3.fr>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Dec 2022 10:40:10 -0800
Message-ID: <CAP-5=fU1TuqCzjF7k=5q2zfh_5Qz0iH1mmXKc9_MjqJGb04rNQ@mail.gmail.com>
Subject: Re: A few questions from writing a perf tutorial
To:     Hadrien Grasland <hadrien.grasland@ijclab.in2p3.fr>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 13, 2022 at 7:01 AM Hadrien Grasland
<hadrien.grasland@ijclab.in2p3.fr> wrote:
>
> Hi everyone,
>
> I recently ran a perf tutorial for my colleagues (which I hope to eventually
> translate to English so it's of more general use), and noted a number of
> surprising things in the process.

Sounds great! Perhaps you can land it or a link to it on the perf wiki:
https://perf.wiki.kernel.org/index.php/Main_Page
More languages than English is a plus!

> In the interest of fixing my understanding and reporting bugs where
> appropriate,
> I would appreciate it if some of you would care to help me triage the
> expected
> from the abnormal here.
>
> ===
>
> Many of my issues stem from the fact that I'm providing a shared server to
> ensure that everyone is using the same version of perf, the same kernel,
> and the
> same CPU. Which means that I need to set up the system to give participants
> fairly broad perf privileges, without wanting to giving them full root
> access.
> That leads to various permission issues.
>
> I have read
> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html#privileged-perf-users-groups
> and tried the suggested workflow of giving the perf executable various
> capabilities while making it only accessible to a "perf group". However, the
> capabilities don't seem to do anything. For example, even with
> cap_syslog set,
> I still need kptr_restrict = 0 to see kernel symbol names in perf top and
> system-wide perf record. Ditto for cap_perfmon : even if it's set, I
> still need
> to tune down perf_event_paranoid for system-wide profiling.
>
> I cross-checked with the procedure discussed in
> https://linux-audit.com/linux-capabilities-101/ that the capabilities
> are set
> correctly on running perf processes, so I'm not sure what's going on
> here. That
> would be the first mystery.

Likewise, I'm not sure what the issue is here.

> ===
>
> The second mystery is that perf trace run as a regular user does not
> correctly
> report thread names for all multi-threaded executables. It just reports
> the thread
> numerical ID, which makes the output hard to read unless supplemented with a
> little `ps aux -L`. This may not be feasible when the threads being
> monitored
> are short-lived.
>
> When perf trace is run as root, it has no such issue, which suggests
> that this
> is a permission problem. Would you happen to know what the missing
> permission
> is and whether/how I can give it to non-root users?

I find the behavior a little mysterious too. Arnaldo likely can speak
more that something to be aware of is that the system call
augmentation (getting things like file names for openat calls) needs a
BPF program to be loaded. The logic for this predates newer BPF things
like skeletons, where we could build the BPF program into the perf
executable, and so you must specify the BPF program as an event:

$ sudo perf trace -eopenat sleep 1
    0.000 ( 0.006 ms): sleep/1453070 openat(dfd: CWD, filename:
0x28e12165, flags: RDONLY|CLOEXEC) = 3
    0.018 ( 0.002 ms): sleep/1453070 openat(dfd: CWD, filename:
0x28de63e0, flags: RDONLY|CLOEXEC) = 3
    0.132 ( 0.004 ms): sleep/1453070 openat(dfd: CWD, filename:
0x28bbc160, flags: RDONLY|CLOEXEC) = 3

$ sudo perf trace
-e/usr/share/doc/linux-perf/examples/bpf/augmented_raw_syscalls.c,openat
sleep 1
    0.000 ( 0.005 ms): sleep/1452904 openat(dfd: CWD, filename:
"/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
    0.016 ( 0.003 ms): sleep/1452904 openat(dfd: CWD, filename:
"/lib/x86_64-linux-gnu/libc.so.6",flags: RDONLY|CLOEXEC) = 3
    0.131 ( 0.003 ms): sleep/1452904 openat(dfd: CWD, filename:
"/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) = 3

> ===
>
> I also noticed that trying to use `--call-graph=lbr` on non-PMU events
> (syscalls
> and tracepoints in general) fails with an "Operation not supported"
> error. I do
> not understand why this operation is not supported, however, given that
> from my
> limited understanding of the LBR, it should be active no matter what the
> CPU is
> doing, and perf should always be able to sample it including on tracepoint
> events. Can someone shed some light on this?

I see your point, likely this needs improvements in the kernel.

Thanks,
Ian

> ===
>
> Thanks in advance for your help!
> Hadrien Grasland
