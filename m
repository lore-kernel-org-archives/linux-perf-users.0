Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271654EB877
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117027; cv=pass; b=pdfsJrapscUQfYFb7Py9KV4ZoXMW65Ts2JpgGvJiX83rxta0hvp17M23xnQB/IB/xxDFqnqrLHJHxeCWEpGMfc1VWmh1AMb1YG8Zxbo/QqVST+5EHtwR7rCgCYyz44tfU0JSl9JgQkDA7CJpMeoAWntGWo/G99bVAbcg+5sgepg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117027; c=relaxed/simple;
	bh=hYVw2TEWO+2pTjb78w+bwpK2ernvq/Dh9VbJDwZYlL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkuE+L4KqCsT/f4wBEKEPFw9tuFpvuYGNHQ5sp5r++8yJy1czCCAnSXIZnRLSlhFIv9yAqtpTE+CCfD5VYkTFDM9sNKhdfW7eL8hc0A1XoEjoTyILFo3j9IvEdEnK7d4di+oMpEsz77X4jC1Zx5dieAJEKT4SpZJoo2lhrrrpmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIGcw/X/; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIGcw/X/"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-530e8c6fb80so39761cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 15:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790117021; cv=none;
        d=google.com; s=arc-20260327;
        b=Za8oBb1VnfLeFXcoH9bghSKcdTYDIymCEYjLMqMStTDyObDq7OcipuH8Ow+SRV0TP2
         2yqzU2tNAJzD2qjGdhzasqjO6P92ve522n4vFQHsTPdqE3zVuxTa1A2r/4cZkvms0IUp
         CZvBYONSP8ijpiLkKeiU7AqQ05vOkVYVceg7uKTirQ6U7/Xk13MASaz5O3lt5cTjL9Lr
         MXqpemIkWKWZ5M7WchhLmy97mhVZygTb0D6H8ID+hujFQQFM0TDfoR0LUPpPg6m8WDUB
         0T6nQVWiimn+55YhNvGcJyrleYWpmlsX5im6u/xgpjEJCVCbEx/pSB8UFaKzJL75rPuE
         gvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oCoHn/DU/SFjDpzawjmD+yAML8ReqYXauGoAOGbbi+s=;
        fh=uZ6Y2kcreFhmpozRs7MT8pn+g8b9XK8B4B52n9uMsCw=;
        b=UeOcizQzFYMWSs1QRCHJsZ7mlBDV2bVEqMt2T+8fSpFJfnzx08efmCc7G71zQ6PcpF
         tY+0Ezxqa5PmXe4MMf8wgTlRH5C0n9yKWWEoK1jrUxYoG2oNW+msOwz37k2YoYHrl4q4
         EwgFwB2gqj/6KvCEcqoC/0jtUbhDHLjMx4lnWAqCE1mAXr5nhNlfqLdhI7k4xECtxvi0
         C6XwvmSuxZDwtS3AfXEIvlWk/vrEyqxZtOl2UYxvpnwvIU7esfVITyFPMClewkiKEnnM
         kxif2XWlbmuPXKq+vnULfm2huMzfgZ53EvrxqSpAXZHc68d1hz/EaNaJ1l04Avil29vA
         n57A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790117021; x=1790721821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oCoHn/DU/SFjDpzawjmD+yAML8ReqYXauGoAOGbbi+s=;
        b=MIGcw/X/l4NZeczB4bRsUdWqi0NnJn6P7MNzWAQ9COdAddYOf4a8d76pEicxy1n5ES
         uVp6sUOGnFEPW0cdx+I1QGrv7JFyi4ton0a8FtoO9aoHZHaszrYLORVyeIxNghwgPmkV
         3ufXO5m82HT1QNUpa4ue94gzmYOVTHTThb7sKIjia3EAK74dm9vnZiUVLHcve4Pc12Cl
         h4NvLWVbgZ1D7+8hvQ+pIONS9UWyhfv76VYFUnD9ycPRESDwJFCNDV3xeRWy0PTzLVLd
         dK14E3/4cBf6HQJELEDh8gsPqJaMNkmK3av1p29kQIzADJ5SaDpCXcMKLmwS4UYmqwk7
         oVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790117021; x=1790721821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oCoHn/DU/SFjDpzawjmD+yAML8ReqYXauGoAOGbbi+s=;
        b=QH68QY7v6g4bW7VtRpOGH8V2g+OQSp6SuIQ7ccgJ0u/+XtNoEik4QmhczS4zLggS5D
         XfG8MjGhudmP0VPcpiXOEs0/+sHbPfEMwtjqYchLEpnW0XadqxWJVUS3xX6YVWIr3WS8
         26d2x1kHhnigoRStfNjMNzpLAipzq0lWSGy909lW9OuAMox0whteHFf+YBSHvBvbxDSP
         1GGKTPNMbcT2Q2MAnOLMsk8hFJf1KkwX/2PYssaJ3qsYr0ZZuBbtCuM58GUwB03y4Yhe
         lrVXXQx4yFRyLrkBrCgY/z7xOmioiMsLfT2Sc5jpmXhCtHLFLVfwqiLUvvpMyXpdhiBg
         aSog==
X-Forwarded-Encrypted: i=1; AKwUvBxsldrbCKlAzQg8vGGP/seYt27+Q76X/O44E73S+rTw90jFOqFi3bhJ2JEst772n2K8M2e6hn8JwDsofV1R5yI0@vger.kernel.org
X-Gm-Message-State: AFuF++lVmZ9tDJQSKv+DaYmuXiG/387vhzid543+jk44sWi8eMwl35pW
	zmvo/bgy3ykWT9b2AgwbOic3qY9+OaTL8FqZNJ6gOwqpmkQoDpe0yh5MW8x3ECQ8u4Kf7XsyqF9
	ZRAa3nZkZDmIGPn2uaof8ZNyf+kLCvvOPEC4Pt4XW
X-Gm-Gg: AYBFou17RxUR4Qe2PJUIHo4AfYJ0WSH8qvqRmXKBjxz62tOyCzJ3uRzT8KENqmwPg01
	EbAWBNlmvKe2PAoneYfiKagi9D2pX4l18e1QeV8hMhrnTp6LFibgR20QVrumu4jZZNUiOe6WGQy
	pvQCHQUUUVyCfa8NkyDuKK73xUpFYRBpIsAwkx0OaKqUXcfVCjlQl3xglo0ZAxFq0NDnqW3aFWY
	3EdwB3SPihdnWmjd9h2gMI8c9uOJBXx+kGstcQG6ojRHBRKr0bcKZDKIryGNWSMuY/LMiTRKU7S
	QeYGex2QnkyNasOxxjG2gQse+oiAqzM8QrPSO4sjN5GnbsVhi/3I/Z5oVgumHnADHm8zIV4r2cB
	NXAOYr51KsvWiiZTqb7MD
X-Received: by 2002:a05:622a:1b90:b0:531:6de:6028 with SMTP id
 d75a77b69052e-532ef055b5bmr1372891cf.13.1790117020968; Tue, 22 Sep 2026
 15:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
 <arJ-gpzqOHk-gF8T@x2>
In-Reply-To: <arJ-gpzqOHk-gF8T@x2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Sep 2026 15:43:29 -0700
X-Gm-Features: AcwNN1VvEDdJDuHGSY3qWAwyGdzqZxIiLNs2raAqk3wpkCvpU9wHJkJ7GVDiqjA
Message-ID: <CAP-5=fUSwjDLvB2oHHLOZNU0Hfd5dM6oopz2tpum0rJsy5V8vw@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] perf trace: Fix BPF filtering and make tracing
 tests non-exclusive
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, Howard Chu <howardchu95@gmail.com>, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 6:11=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Lots of changes, from a quick look all look sensible, I'll test it some
> more, as in one case it segfaulted:
>
> root@x2:~# strace -e perf_event_open perf trace -a sleep 1
> <SNIP>
>   262.297 ( 0.002 ms): ptyxis/30654 write(fd: 4<anon_inode:[eventfd]>, bu=
f: \1\0\0\0\0\0\0\0, count: 8)   =3D 8
>    262.304 ( 0.011 ms): ptyxis/30654 ppoll(ufds: 0x55dfa7a62f10, nfds: 11=
, tsp: 0x7ffc0701eed0, sigsetsize: 8) =3D 2
>    262.318 ( 0.002 ms): ptyxis/30654 read(fd: 4<anon_inode:[eventfd]>, bu=
f: 0x7ffc0701ee10, count: 8)      =3D 8
>    262.324 ( 0.002 ms): ptyxis/30654 write(fd: 4<anon_inode:[eventfd]>, b=
uf: \1\0\0\0\0\0\0\0, count: 8)   =3D 8
>    262.328 ( 0.002 ms): ptyxis/30654 read(fd: 31</dev/ptmx>, buf: 0x55dfa=
8a54f19, count: 5751)             =3D 8
>    262.332 ( 0.002 ms): ptyxis/30654 read(fd: 31</dev/ptmx>, buf: 0x55dfa=
8a54f20, count: 5744)             =3D -1 (unknown) (Resource temporarily un=
available)
> LOST 70 events!
> --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSEGV_MAPERR, si_addr=3D0x117f0=
00} ---
> perf: Segmentation fault
>     #0 0x73104f in dump_stack debug.c:366
>     #1 0x7310c5 in sighandler_dump_stack debug.c:378
>     #2 0x7f749ea66fb0 in __restore_rt libc.so.6[19fb0]
>     #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
>     #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
>     #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
>     #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
>     #7 0x4c7865 in trace__handle_event builtin-trace.c:4013
>     #8 0x4c9ab4 in __trace__deliver_event builtin-trace.c:4962
>     #9 0x4c9c06 in trace__deliver_event builtin-trace.c:4988
>     #10 0x4caed8 in trace__run builtin-trace.c:5397
>     #11 0x4cf530 in cmd_trace builtin-trace.c:6681
>     #12 0x4da43c in run_builtin perf.c:380
>     #13 0x4da68e in handle_internal_command perf.c:430
>     #14 0x4da7ea in run_argv perf.c:477
>     #15 0x4daabe in main perf.c:577
>     #16 0x7f749ea50681 in __libc_start_call_main libc.so.6[3681]
>     #17 0x7f749ea50798 in __libc_start_main@@GLIBC_2.34 libc.so.6[3798]
>     #18 0x409f25 in _start perf[409f25]
> --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSI_TKILL, si_pid=3D1097958, si=
_uid=3D0} ---
> +++ killed by SIGSEGV (core dumped) +++
> Segmentation fault         (core dumped) strace -e perf_event_open perf t=
race -a sleep 1
> root@x2:~#
>
> root@x2:~# uname -a
> Linux x2 7.2.5-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Sep 11 15:11:05=
 UTC 2026 x86_64 GNU/Linux
> root@x2:~#

Thanks Arnaldo for testing, and sorry for the crash. Working with
antigravity I got the analysis below for the crash and I'll fix it in
v5.

I can account for it, and it is a regression from patch 7 ("perf trace:
Filter events in BPF and avoid tracepoint vetoes") landing on a missing
bounds check that predates the series.

Before the series syscall_unaugmented() was:

SEC("tp/raw_syscalls/sys_enter")
int syscall_unaugmented(struct syscall_enter_args *args)
{
return 1;
}

so an unaugmented sys_enter emitted nothing at all. Patch 7 moved it to
tp/syscalls/sys_enter_unaugmented and made it output the 64 byte struct
syscall_enter_args to __augmented_syscalls__, so that perf trace could
stop listening on the raw tracepoint and stop vetoing it.

That 64 byte record does not come back as 64 bytes.
perf_sample_save_raw_data() does:

size =3D round_up(sum + sizeof(u32), sizeof(u64));
raw->size =3D size - sizeof(u32);
frag->pad =3D raw->size - sum;

so sum of 64 gives raw->size of 68, and the 4 bytes of padding are
written by:

__output_skip(handle, NULL, frag->pad);

which advances over them rather than zeroing them. They are whatever the
ring buffer last held there.

Userspace then does:

*augmented_args_size =3D sample->raw_size - args_size;

with args_size of 64, gets 4, decides that is an augmented payload, and
copies those 4 stale bytes into argbuf as the size and int_arg of a
struct augmented_arg. syscall_arg__scnprintf_buf() has no bound on the
length it reads there:

for (int j =3D 0; j < augmented_arg->size; ++j)

so a size taken from, say, the low half of a pointer walks straight off
the end of the 8K argbuf in bss. SCA_BUF is used by exactly one syscall,
write()'s buf argument, which is why a terminal emulator's writes were
what tripped it. The si_addr in your report is page aligned just past
that buffer, which fits.

btf_struct_scnprintf() already had the check that would have caught it,
which is why the BTF path survived this and SCA_BUF did not: a 4 byte
trailing run is smaller than a struct augmented_arg, so it returns early.

v5 fixes it in two patches, placed before the patch that introduces the
unaugmented output so that no commit in the series is broken:

  perf trace: Bounds check augmented arguments before reading them

    Lifts btf_struct_scnprintf()'s check into a shared
    syscall_arg__augmented_args_valid() in beauty.h and uses it at every
    site that reads an augmented argument. Besides the crash site this
    covers the timespec, sockaddr and perf_event_attr beautifiers, which
    read a fixed sized type out of a payload that may be shorter than
    it. Two unbounded reads that are not about the header are fixed with
    them: perf_event_attr__fprintf() always reads a whole struct
    perf_event_attr, so the payload is now copied into a zero padded
    local rather than read in place, and the AF_LOCAL path is printed
    with a length from the payload rather than as a string it need not
    be.

  perf trace: Do not read sample padding as an augmented argument

    A trailing run shorter than a struct augmented_arg cannot be one, so
    it is recognised as the padding it is rather than being offered to
    the beautifiers at all.

The first alone stops the SIGSEGV. The second stops the syscall being
printed with a bogus argument in the cases where the padding happens to
hold a length that passes validation.

Thanks,
Ian
