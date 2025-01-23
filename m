Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C8139CEF;
	Thu, 23 Jan 2025 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673924; cv=none; b=I2Wr0l7F8RfuQDKDSnDrwdH96f7vMQLhsNNbzURRWOrh965SMdjGTkzMIG7EQl1nQGlxS7IUVxFK2/CDB7M/AfVeJRwMEASMy4k2UjAGNMdpGqraMWqN5ANL/YT2XvfwvJ/Y/22rNu5krCLbwY1oPnaMGFVyDdby/nIlvjwtWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673924; c=relaxed/simple;
	bh=eoCNcVECKz+NF82IMCY1Qbz4onIwEluRPxxjPeAhW5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEgXEiS1qA+lSa4eupDeTfbetzonEZgKeGnKJEHYSPtpcFh8K3lB5tVC3hbaekc+CQWnDJhqke/Ok05RJBvY63A7cNRZB12KOIIH2g3s01+9OULQOYYqAf9v+Q4HJaJiyofhtX2g/D7fCx0y1o3gHgpyH6cY1bM+0ml8ZN0M0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcxLOjml; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcxLOjml"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e479e529ebcso2100101276.3;
        Thu, 23 Jan 2025 15:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737673922; x=1738278722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKoJw9FlYwc0UNYR34AMCBueSo8/FSSlax+RXSs3Ig0=;
        b=LcxLOjmlYdEMnTkSXkcnWG6SH2YM3eHh5E0SXquv/z3Sf7/+h8VPB9cWywc5uZFNec
         h20JE0o6pHWJk+5mWyMTfv3V9kCieT0hIBDF/g/UehrA3vBemQu59mCckNZCeuEl3fsz
         TA41HWKVWz5j2e4SNvjbtdQUpXhY6J4yZBmZVnZKgaYaUSMUKhVem92Q8fRS/ktkEf5j
         afRuBVMSqta3rAz7c9AeJTD1BTJSCcw/teZEgR+qHKkAQCx3cOUnbHgXiaG58obPncwn
         AoI5hRncq4B9l113al9DUPqen73W84u+byK71vk3bUI2baje3z9LUMo8S0rI9krZYSjC
         YIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737673922; x=1738278722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKoJw9FlYwc0UNYR34AMCBueSo8/FSSlax+RXSs3Ig0=;
        b=Def7Enb/eWyE2wgEfInG9Dp3tbo80OLudwgERfUc2anhoGG+klVMB3139dGM5GGX90
         zSMzi1VohgAvLQ1VlzH9ZRkl4dQz1J34hbJUT+GoWW/bj03rJKxTHfP8qzubB8nudxmE
         HQpNGNwrNwyAaWGg8GY89ORLfVkIIlFKjdjImIKec8GR8oeOsKAmy2wqIA4XY5G28/h6
         nz+ydatjkRaRAVj3C3nA7DbpceyXxbo5Xnn7mSZOjAkOck8htUXZohuRac8wrgrjihpa
         As/dth6xyqhig1vbfDNYW+PzGIOf50bARyYqK9CkqHb6Uj+3elLwZ++3GR/FvBVI0bly
         YouA==
X-Forwarded-Encrypted: i=1; AJvYcCV57cCUWpvkXt1Y87EEL7i4FipR9RYgqKNQRIUq3I6+/xJIMUaWZU9W12DZbA/iGg96Dlrxdgt6cgckcoeKb0kUlA==@vger.kernel.org, AJvYcCXFsiPCR9vG/xw25fQZLb7i/FPKdV58A97h0MwVvyuBji45LFvGD44HYyvlMhteTiZgCaRvAyLLogLW/ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXtFYroqzVioSL+E6h+SlHU5xfmmieQSsLzYX1959JoODk2/p
	BwHekDWU20Wl8BLAoGVV/tzmxbr3MGp/i6C0HaOwi0Xi4uMfaavFSQ0h6F2DsMSun/xJ/AzNjnM
	SbSTPTth+9H/xNqGm8GM2i4L89mh34g73tN4=
X-Gm-Gg: ASbGncv0nZfjcIeCzqBkd9tA66POh13dp++nluKD9sktkINkLDCQOPUb0OrerEkqRGe
	BhMu+0RIhmVfC3EHK6r4Wc2TGyiA+QMxINqEbTwEGMyfJycjgCC4Hsb8aTj+w
X-Google-Smtp-Source: AGHT+IFXIZ7tKSccbJGm64UlBQf5gr5g9BhTo44+GgVqTxkqoAZApo4jC06e1hN0wDq3VPCEnRWXFzs1KAM0i82OYtI=
X-Received: by 2002:a05:690c:690d:b0:6f4:beb3:1f1c with SMTP id
 00721157ae682-6f6eb922174mr228403407b3.26.1737673921953; Thu, 23 Jan 2025
 15:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122025519.361873-1-howardchu95@gmail.com> <Z5FC47bfDAPu75-e@google.com>
In-Reply-To: <Z5FC47bfDAPu75-e@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 23 Jan 2025 15:11:54 -0800
X-Gm-Features: AWEUYZlZvQWgNqjC82V319H8gYglH3awXIo9qxdhBlejB-m4CO8ticR3-kt8u6k
Message-ID: <CAH0uvoiYSG_gJo3tnVHvi71x6kmL5-hXDJGMJJeRMkJtiofYXg@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Fix runtime error of index out of bounds
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Wed, Jan 22, 2025 at 11:11=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Jan 21, 2025 at 06:55:19PM -0800, Howard Chu wrote:
> > libtraceevent parses and returns an array of argument fields, sometimes
> > larger than RAW_SYSCALL_ARGS_NUM (6) because it includes "__syscall_nr"=
,
> > idx will traverse to index 6 (7th element) whereas sc->fmt->arg holds 6
> > elements max, creating an out-of-bounds access. This runtime error is
> > found by UBsan. The error message:
>
> I'm curious how I miss this.  Is this only for some specific syscalls or
> always happening?  Do you which commit introduced this?

On my x86-64 machine, I found that this error can occur for syscalls
with 6 arguments, which results in nr_fields being 7. These syscalls
are:
copy_file_range
epoll_pwait
epoll_pwait2
futex
futex_wait
io_pgetevents
io_uring_enter
mbind
mmap
move_pages
preadv2
process_vm_readv
process_vm_writev
pselect6
pwritev2
recvfrom
sendto
splice

But the runtime error occurs only with the futex syscall, when
accessing sc->fmt->arg[idx]. This is an array of length 6.

>
> Thanks,
> Namhyung
>
> >
> > perf $ sudo UBSAN_OPTIONS=3Dprint_stacktrace=3D1 ./perf trace -a --max-=
events=3D1
> > builtin-trace.c:1966:35: runtime error: index 6 out of bounds for type =
'syscall_arg_fmt [6]'
> >     #0 0x5c04956be5fe in syscall__alloc_arg_fmts /home/howard/hw/linux-=
perf/tools/perf/builtin-trace.c:1966
> >     #1 0x5c04956c0510 in trace__read_syscall_info /home/howard/hw/linux=
-perf/tools/perf/builtin-trace.c:2110
> >     #2 0x5c04956c372b in trace__syscall_info /home/howard/hw/linux-perf=
/tools/perf/builtin-trace.c:2436
> >     #3 0x5c04956d2f39 in trace__init_syscalls_bpf_prog_array_maps /home=
/howard/hw/linux-perf/tools/perf/builtin-trace.c:3897
> >     #4 0x5c04956d6d25 in trace__run /home/howard/hw/linux-perf/tools/pe=
rf/builtin-trace.c:4335
> >     #5 0x5c04956e112e in cmd_trace /home/howard/hw/linux-perf/tools/per=
f/builtin-trace.c:5502
> >     #6 0x5c04956eda7d in run_builtin /home/howard/hw/linux-perf/tools/p=
erf/perf.c:351
> >     #7 0x5c04956ee0a8 in handle_internal_command /home/howard/hw/linux-=
perf/tools/perf/perf.c:404
> >     #8 0x5c04956ee37f in run_argv /home/howard/hw/linux-perf/tools/perf=
/perf.c:448
> >     #9 0x5c04956ee8e9 in main /home/howard/hw/linux-perf/tools/perf/per=
f.c:556
> >     #10 0x79eb3622a3b7 in __libc_start_call_main ../sysdeps/nptl/libc_s=
tart_call_main.h:58
> >     #11 0x79eb3622a47a in __libc_start_main_impl ../csu/libc-start.c:36=
0
> >     #12 0x5c04955422d4 in _start (/home/howard/hw/linux-perf/tools/perf=
/perf+0x4e02d4) (BuildId: 5b6cab2d59e96a4341741765ad6914a4d784dbc6)
> >
> >      0.000 ( 0.014 ms): Chrome_ChildIO/117244 write(fd: 238, buf: !, co=
unt: 1)                                      =3D 1
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index d7c7d29291fb..8d3260bad10a 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2108,7 +2108,7 @@ static int trace__read_syscall_info(struct trace =
*trace, int id)
> >       }
> >
> >       if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
> > -                                     RAW_SYSCALL_ARGS_NUM : sc->tp_for=
mat->format.nr_fields))
> > +                                     RAW_SYSCALL_ARGS_NUM : sc->tp_for=
mat->format.nr_fields - 1))

Looking back, unfortunately, this is incorrect, because, as Arnaldo
mentioned, the '__syscall_nr' in tracefs does not exist in older
kernels. You mentioned missing the runtime error; maybe check the
tracefs on your machine to see if there is a '__syscall_nr'.

$ cat /sys/kernel/tracing/events/syscalls/sys_enter_futex/format |
grep __syscall_nr
        field:int __syscall_nr; offset:8;   size:4;  signed:1;

And I'll send v2 that will have the correct logic.

Thanks,
Howard

> >               return -ENOMEM;
> >
> >       sc->args =3D sc->tp_format->format.fields;
> > --
> > 2.45.2
> >
