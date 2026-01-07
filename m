Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501872D592F
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Jan 2026 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767827625; cv=none; b=DPJqr4LODb7umDa5jb3bMvggXiDuJArCFtWQX6d5wA6mQulwsdBVXhKFa5YVPZuRurIpS+IHLDV0yDw77b4NpZdsmLdW9e8Z04pvuErdbYsFLZ0bxYojEdKW3g+Z7iS/B4n51F4lJmhyNV69tKAcQP045ZRkrPjflMbnlWI7kdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767827625; c=relaxed/simple;
	bh=S94C9Q8EMUekImW970bzq/8zHxlUkt+OYW+kYy2Wffw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW1hm/Ge9zyORv6xa97TVAZNe1Y8qMpS+ToSSGvE3iWkkTGrAtAF5XL5z57d7WhYX3pOq87d9kBgOvcQBUgG9aA6A1r14bl67cpjeGwRMQm++pAXq9s1WUT9GpzC60nSCiQK3AkikCRKoDh0VqYgG7i7FJlAdd16YexVJ12qsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=hOA7kkJA; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="hOA7kkJA"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11df4458a85so3227114c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jan 2026 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1767827620; x=1768432420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnK4Ewc8hN+ARSrftsR1VA6lcIUmoKo6afmRZuoPxlI=;
        b=hOA7kkJAVmSA71hF41Q6qHn6yodrPXWXU5TxttWbO86myd2WmWEOmpTMqeIfsfYKVs
         sBCObfIxRuelE1Xjxok1lx7tJHB3V9bS2+xkajaAf5HWpkCvuohH2/zDD6FK1eirAeCs
         /d/GroDveMLZjXyrlf7vjtie6pzUJIoQS4+xntIp1H1Y/G4vAT5KHP/XghVGrtpt+gNk
         JBO2NRRx373zmtW6ONPa9E8W+lmwMkq/yxgy/9qEQfK4P9SGdSgA42vvILuVdHEW9Zvj
         W2QF1SIOmCFWl9UU91nc9nnfYXXX2aNv1QSk4noYTxu3DXU4H63e7Hl3Of/TYfCU/kyc
         wRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767827620; x=1768432420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VnK4Ewc8hN+ARSrftsR1VA6lcIUmoKo6afmRZuoPxlI=;
        b=SowO52SSoGZlOaq4W8QZSEGsAJ1UeWbCgq2KOEZmrTql7SNFbGiFqdG9/BlvCf434Z
         2lDbxyI5vcbPoh1OG+P7DgcSKLRF4nD4Naw0HE5YwCTd7bINrtyB8jLU5sHQSW5vZIzM
         msxMFtbJFtWf8vxZuehpwqWaU8uGiE8YeyW0EzCx+nEovnhzaHpbsVtfg9xIBOEf1dxl
         DY572ryp5+JP8mJOv3Ia0RHnv4apjRcZ0+SLQ8Q/CTbqx0+Z/9w6CVsGV2CFyddJaS/c
         /hYgigowy/Q+m0IK34fDztWiqi3qTZMhsWRn1o148zXSVJbecXf7DyaCNDkt9KO+Z+Yw
         pL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoMoHB+/Cfg8HVZqkB5lmureHYY76WPIuZ8cvrGptrGm4yW4ttoJO3NChMB6Yu0cGK3KADBOC9I9HNqp9CRUy9@vger.kernel.org
X-Gm-Message-State: AOJu0YygV22aHR06cxfQJGzaCA9KIZsXGfVRyn1Y/3n0+eLP6XPF79PN
	nqZf/2ePDZ10TFUCKkk6DvXcOHh83YtsPTA+ZiUiyhvILfsp/UjfBAvAv+U0OuI+PQSoaFUj00g
	NERisuUETw7wd1IXU29R+uKg/RSG/2QX+HouvmjBwIg==
X-Gm-Gg: AY/fxX4RcfUFTs2z0fcUOrgJL6mBKvsEGd7UQBkbQq2UkKC55qyC8zjJBDd/R6ncnPt
	ypP7j0owjGsjpAKkjDrEtKHMDuWHuXtYVRwQvaXD25niJy8naxG5pXfz/5ItdFd0FcP2d2SHNpr
	9AxSL4u5/5QaXvviNTLhaZN03/7j/SOzrUCwCP780Tfsod6WuWcE/DHmlEFm1MBLJQXPIqrUU5g
	nvRn2l3gHNC3SOkgN9zM1YbDDmHEv0RGpfZlyVzhmaxmhodEmkGXN+E733N0crJYegdYQ==
X-Google-Smtp-Source: AGHT+IEysz/5tWAMJaFn+KNXDO0p0klUrP71rBqwVW2QNmTwqmgmGGmUOOcgjCbYzpgemldTFn3NmJJTN3/ClvM7lwA=
X-Received: by 2002:a05:7022:608f:b0:11b:9386:a3cf with SMTP id
 a92af1059eb24-121f8b6fa2emr3103840c88.48.1767827620030; Wed, 07 Jan 2026
 15:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-cross-arch-unwind-v2-1-9a8b0b14ce7b@skydio.com> <aV4SRdNWzBpDVbfz@google.com>
In-Reply-To: <aV4SRdNWzBpDVbfz@google.com>
From: Shimin Guo <shimin.guo@skydio.com>
Date: Wed, 7 Jan 2026 15:13:28 -0800
X-Gm-Features: AQt7F2pIT-u6cvUiv8c9O6ineKBrseF9Ym_6j-HoPsO-jPl7mayag5mVrIC69DA
Message-ID: <CAK3u-5i3mR7325ebhvvB3JupnH_BT95LAewoTwDQM9QBTjxdNg@mail.gmail.com>
Subject: Re: [PATCH v2] perf unwind-libdw: fix a cross-arch unwinding bug
To: Namhyung Kim <namhyung@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, Jan 05, 2026 at 01:13:38PM -0800, Shimin Guo via B4 Relay wrote:
> > From: Shimin Guo <shimin.guo@skydio.com>
> >
> > The set_initial_registers field of Dwfl_Thread_Callbacks needs to be se=
t
> > according to the arch of the stack samples being analyzed, not the arch
> > that perf itself is built for. Currently perf fails to unwind stack sam=
ples
> > collected from archs different from that of the host perf is running on=
.
>
> Thanks for the contribution!
>
> > This patch moves the arch-specific implementations of set_initial_regis=
ters
> > from tools/perf/arch to tools/perf/utli/unwind-libdw-arch, similar to t=
he
> > way the perf-regs-arch folder contains arch-specific functions related =
to
> > registers, and chooses the implementation based on the arch of the data
> > being processed.
>
> I feel like some day we will just include all top-level arch directories
> for multi-arch builds..
>
> Btw, can you please show me an example how you tested this?

Sure. I initially tested with an embedded target. I also did the
following with qemu:
- run an arm64 ubuntu guest under qemu, where the folder /host is
shared with host
- install sysbench, sysbench-dbgsym, and libc6-dbgsym on the guest
- collect data on the guest:
  sysbench cpu --threads=3D4 --time=3D60 run & \
    perf record -a --call-graph dwarf -o /host/perf.data -- sleep 60
- save /proc/kallsyms: cp /proc/kallsyms /host/kallsyms
- Terminate guest. Mount the guest disk image on the host at /mnt/guestroot
- On the host, install libdw1 and libdw-dev.
- On the host, under tools/perf, build perf: make NO_LIBUNWIND=3D1
NO_LIBTRACEEVENT=3D1
- On the host, run
  ./perf script -i $SHARED_FOLDER/perf.data --symfs /mnt/guestroot
--kallsyms $SHARED_FOLDER/kallsyms
- Without this patch, I get records like
sysbench    4166 [001]  2309.569275:          5   cycles:
                   e27e0 [unknown] ([unknown])
- With the patch, I get proper backtraces like
sysbench    4166 [001]  2309.569275:          5   cycles:
            aaaab906a338 cpu_execute_event+0x98 (/usr/bin/sysbench)
            aaaab9067a57 worker_thread+0x197 (/usr/bin/sysbench)
            ffffa8940397 start_thread+0x2d7
(/usr/lib/aarch64-linux-gnu/libc.so.6)
            ffffa89a9e9b thread_start+0xb (/usr/lib/aarch64-linux-gnu/libc.=
so.6)


>
> >
> > Signed-off-by: Shimin Guo <shimin.guo@skydio.com>
> > ---
> > Changes in v2:
> > - Fixed the include path for perf_regs.h in unwind-libdw-x86.c
> > - Removed one level of "../" from the include paths in the moved files
> > now that they are two directory levels under tools/perf instead of thre=
e.
> > - Link to v1: https://lore.kernel.org/r/20251223-cross-arch-unwind-v1-1=
-4d71ee7db512@skydio.com
> > ---
> >  tools/perf/arch/arm/util/Build                     |  1 -
> >  tools/perf/arch/arm64/util/Build                   |  1 -
> >  tools/perf/arch/csky/util/Build                    |  2 -
> >  tools/perf/arch/powerpc/util/Build                 |  1 -
> >  tools/perf/arch/riscv/util/Build                   |  1 -
> >  tools/perf/arch/s390/util/Build                    |  2 -
> >  tools/perf/arch/x86/util/Build                     |  1 -
> >  tools/perf/util/Build                              |  1 +
> >  tools/perf/util/unwind-libdw-arch/Build            |  8 ++++
> >  .../unwind-libdw-arch/unwind-libdw-arm.c}          | 10 ++---
> >  .../unwind-libdw-arch/unwind-libdw-arm64.c}        | 10 ++---
> >  .../unwind-libdw-arch/unwind-libdw-csky.c}         |  6 +--
> >  .../unwind-libdw-arch/unwind-libdw-loongarch.c}    |  4 +-
> >  .../unwind-libdw-arch/unwind-libdw-powerpc.c}      | 10 ++---
> >  .../unwind-libdw-arch/unwind-libdw-riscv.c}        |  4 +-
> >  .../unwind-libdw-arch/unwind-libdw-s390.c}         |  6 +--
> >  .../unwind-libdw-arch/unwind-libdw-x86.c}          |  8 ++--
> >  tools/perf/util/unwind-libdw.c                     | 51 ++++++++++++++=
+++++---
> >  tools/perf/util/unwind-libdw.h                     | 10 ++++-
> >  19 files changed, 92 insertions(+), 45 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/=
Build
> > index fd695e1fdaee2ccc300a206131b8b38a763b00ce..3291f893b943df0722dff58=
3523fff4ae79919bc 100644
> > --- a/tools/perf/arch/arm/util/Build
> > +++ b/tools/perf/arch/arm/util/Build
> > @@ -1,6 +1,5 @@
> >  perf-util-y +=3D perf_regs.o
> >
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >
> >  perf-util-y +=3D pmu.o auxtrace.o cs-etm.o
> > diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/u=
til/Build
> > index d63881081d2eb1e9a83eabf82104d75308f7fc79..0177af19cc00038d6a60055=
92ddc530bf7eb1557 100644
> > --- a/tools/perf/arch/arm64/util/Build
> > +++ b/tools/perf/arch/arm64/util/Build
> > @@ -1,4 +1,3 @@
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> >  perf-util-y +=3D ../../arm/util/auxtrace.o
> > diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/uti=
l/Build
> > index 5e6ea82c42021d3d5651ca4c4a3a6e5138574e4e..6b2d0e021b11464e46d6b53=
974260d32ea969732 100644
> > --- a/tools/perf/arch/csky/util/Build
> > +++ b/tools/perf/arch/csky/util/Build
> > @@ -1,3 +1 @@
> >  perf-util-y +=3D perf_regs.o
> > -
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/power=
pc/util/Build
> > index 3d0d5427aef7f26a8c05c883cc7ad763f08cbb30..5fd28ec713a4db74ecd1d26=
866a65ddb20e94bd3 100644
> > --- a/tools/perf/arch/powerpc/util/Build
> > +++ b/tools/perf/arch/powerpc/util/Build
> > @@ -9,5 +9,4 @@ perf-util-y +=3D evsel.o
> >  perf-util-$(CONFIG_LIBDW) +=3D skip-callchain-idx.o
> >
> >  perf-util-$(CONFIG_LIBUNWIND) +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >  perf-util-y +=3D auxtrace.o
> > diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/u=
til/Build
> > index 58a672246024dd0f72e767d11e9958bd9913ec3c..628b9ebd418bde8cdf1ab13=
32bf79f7c9d50760e 100644
> > --- a/tools/perf/arch/riscv/util/Build
> > +++ b/tools/perf/arch/riscv/util/Build
> > @@ -2,4 +2,3 @@ perf-util-y +=3D perf_regs.o
> >  perf-util-y +=3D header.o
> >
> >  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/uti=
l/Build
> > index c64eb18dbdae93adafabf8542e4c9a763ecfe057..5391d26fedd46b7d30a1bef=
0bff2ec2d58ec30ed 100644
> > --- a/tools/perf/arch/s390/util/Build
> > +++ b/tools/perf/arch/s390/util/Build
> > @@ -2,8 +2,6 @@ perf-util-y +=3D header.o
> >  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> >  perf-util-y +=3D perf_regs.o
> >
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > -
> >  perf-util-y +=3D machine.o
> >  perf-util-y +=3D pmu.o
> >
> > diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/=
Build
> > index c0dc5965f3624a6f02525a04d287dff755356d20..fad256252bb95a8f8350b6b=
b1a54e8074eaebbec 100644
> > --- a/tools/perf/arch/x86/util/Build
> > +++ b/tools/perf/arch/x86/util/Build
> > @@ -12,7 +12,6 @@ perf-util-y +=3D evsel.o
> >  perf-util-y +=3D iostat.o
> >
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >
> >  perf-util-y +=3D auxtrace.o
> >  perf-util-y +=3D archinsn.o
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 1c2a43e1dc68e7f751ec6082352b10de9ffeea62..15f8a4f4b24a46b6300e824=
f672dd9c0d5b7865f 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -226,6 +226,7 @@ perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >  perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> >
> >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-arch/
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-local.o
> >  perf-util-$(CONFIG_LIBUNWIND)          +=3D unwind-libunwind.o
> >  perf-util-$(CONFIG_LIBUNWIND_X86)      +=3D libunwind/x86_32.o
> > diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/=
unwind-libdw-arch/Build
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e016d54ae2a40ecba47156c=
8f09cb72156105727
> > --- /dev/null
> > +++ b/tools/perf/util/unwind-libdw-arch/Build
> > @@ -0,0 +1,8 @@
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-x86.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-arm.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-arm64.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-csky.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-loongarch.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-powerpc.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-riscv.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-s390.o
> > \ No newline at end of file
>
> Please fix.  And I think they can be simply perf-util-y at this point
> since you added the directory with CONFIG_LIBDW_DWARF_UNWIND in the
> Build file in the parent directory.

Will fix in the next version.

>
>
> > diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/util/=
unwind-libdw-arch/unwind-libdw-arm.c
> > similarity index 78%
> > rename from tools/perf/arch/arm/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> > index fbb643f224ec4b27ce9d67051fe0bc4ad555b05e..3c7f91a1af7416f57b0e4fa=
0dcd15a530cb44f8a 100644
> > --- a/tools/perf/arch/arm/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> > @@ -1,11 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../../util/unwind-libdw.h"
> > -#include "../../../util/perf_regs.h"
> > -#include "../../../util/sample.h"
> > +#include "../../../arch/arm/include/uapi/asm/perf_regs.h"
> > +#include "../../util/unwind-libdw.h"
> > +#include "../../util/perf_regs.h"
> > +#include "../../util/sample.h"
>
> I think it'd be simpler if we assume the include path always starts from
> tools/perf directory (which is set with -I already).  Then we don't need
> to change the relative paths when we move files around.

Will fix in the next version.

>
> Thanks,
> Namhyung
>
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/uti=
l/unwind-libdw-arch/unwind-libdw-arm64.c
> > similarity index 86%
> > rename from tools/perf/arch/arm64/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> > index b89b0a7e5ad919fed23643d219fbdc3d84deff1e..a237af99d1f87a72b99d5ed=
2ff965d4ef2f75434 100644
> > --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> > @@ -1,11 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../../util/unwind-libdw.h"
> > -#include "../../../util/perf_regs.h"
> > -#include "../../../util/sample.h"
> > +#include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
> > +#include "../../util/unwind-libdw.h"
> > +#include "../../util/perf_regs.h"
> > +#include "../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/util=
/unwind-libdw-arch/unwind-libdw-csky.c
> > similarity index 92%
> > rename from tools/perf/arch/csky/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> > index b20b1569783d7e982e91b1b40120d29ccf2f01d1..889d3b788931f3af55b03ef=
8b91d5def364972e5 100644
> > --- a/tools/perf/arch/csky/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> > @@ -2,12 +2,12 @@
> >  // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> >
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/csky/include/uapi/asm/perf_regs.h"
> >  #include "../../util/unwind-libdw.h"
> >  #include "../../util/perf_regs.h"
> > -#include "../../util/event.h"
> > +#include "../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf=
/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > similarity index 91%
> > rename from tools/perf/arch/loongarch/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > index 60b1144bedd5f325e1512eeab05c29a1e8de2b03..1c5753ace6f63be771aa923=
65d3174ad8ed3a6fd 100644
> > --- a/tools/perf/arch/loongarch/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > @@ -2,12 +2,12 @@
> >  /* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
> >
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
> >  #include "../../util/unwind-libdw.h"
> >  #include "../../util/perf_regs.h"
> >  #include "../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *=
arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/u=
til/unwind-libdw-arch/unwind-libdw-powerpc.c
> > similarity index 88%
> > rename from tools/perf/arch/powerpc/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> > index 82d0c28ae3459ecdb0039cac1f534420d142739b..d5012f20a87e30809b8b44e=
e20572fab8668b7dd 100644
> > --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> > @@ -1,10 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> >  #include <linux/kernel.h>
> > -#include "perf_regs.h"
> > -#include "../../../util/unwind-libdw.h"
> > -#include "../../../util/perf_regs.h"
> > -#include "../../../util/sample.h"
> > +#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
> > +#include "../../util/unwind-libdw.h"
> > +#include "../../util/perf_regs.h"
> > +#include "../../util/sample.h"
> >
> >  /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
> >  static const int special_regs[3][2] =3D {
> > @@ -13,7 +13,7 @@ static const int special_regs[3][2] =3D {
> >       { 109, PERF_REG_POWERPC_CTR },
> >  };
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *ar=
g)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/uti=
l/unwind-libdw-arch/unwind-libdw-riscv.c
> > similarity index 92%
> > rename from tools/perf/arch/riscv/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> > index dc1476e16321736de897ad53a00fbc813bd706db..2a5442b3b5bdc27252378de=
0073deb8a620f8779 100644
> > --- a/tools/perf/arch/riscv/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> > @@ -2,12 +2,12 @@
> >  /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
> >
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
> >  #include "../../util/unwind-libdw.h"
> >  #include "../../util/perf_regs.h"
> >  #include "../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/util=
/unwind-libdw-arch/unwind-libdw-s390.c
> > similarity index 89%
> > rename from tools/perf/arch/s390/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> > index c27c7a0d1076c890c35ba19543932c4ed5ac9c2a..18d44074a55bc1c7fa2d715=
0afc1f1a93d4eadf8 100644
> > --- a/tools/perf/arch/s390/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> > @@ -4,11 +4,11 @@
> >  #include "../../util/perf_regs.h"
> >  #include "../../util/event.h"
> >  #include "../../util/sample.h"
> > -#include "dwarf-regs-table.h"
> > -#include "perf_regs.h"
> > +#include "../../arch/s390/include/dwarf-regs-table.h"
> > +#include "../../../arch/s390/include/uapi/asm/perf_regs.h"
> >
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/util/=
unwind-libdw-arch/unwind-libdw-x86.c
> > similarity index 86%
> > rename from tools/perf/arch/x86/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> > index 798493e887d7308cb293e29e4ba11054d0fda722..6619c60728ef6ad1e725cd8=
6c7bcbf06b8aad28d 100644
> > --- a/tools/perf/arch/x86/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> > @@ -1,11 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../../util/unwind-libdw.h"
> > -#include "../../../util/perf_regs.h"
> > +#include "../../../arch/x86/include/uapi/asm/perf_regs.h"
> > +#include "../../util/unwind-libdw.h"
> > +#include "../../util/perf_regs.h"
> >  #include "util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-li=
bdw.c
> > index ae70fb56a05729b9f06a411d162eabebbf29ac52..f32694ff4ea52d4bf80a384=
05341864e7ff5e6c8 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -225,11 +225,45 @@ static bool memory_read(Dwfl *dwfl __maybe_unused=
, Dwarf_Addr addr, Dwarf_Word *
> >       return true;
> >  }
> >
> > -static const Dwfl_Thread_Callbacks callbacks =3D {
> > -     .next_thread            =3D next_thread,
> > -     .memory_read            =3D memory_read,
> > -     .set_initial_registers  =3D libdw__arch_set_initial_registers,
> > -};
> > +#define DEFINE_DWFL_THREAD_CALLBACKS(arch)                           \
> > +static const Dwfl_Thread_Callbacks callbacks_##arch =3D {             =
 \
> > +     .next_thread           =3D next_thread,                        \
> > +     .memory_read           =3D memory_read,                        \
> > +     .set_initial_registers =3D libdw_set_initial_registers_##arch, \
> > +}
> > +
> > +DEFINE_DWFL_THREAD_CALLBACKS(x86);
> > +DEFINE_DWFL_THREAD_CALLBACKS(arm);
> > +DEFINE_DWFL_THREAD_CALLBACKS(arm64);
> > +DEFINE_DWFL_THREAD_CALLBACKS(csky);
> > +DEFINE_DWFL_THREAD_CALLBACKS(loongarch);
> > +DEFINE_DWFL_THREAD_CALLBACKS(powerpc);
> > +DEFINE_DWFL_THREAD_CALLBACKS(riscv);
> > +DEFINE_DWFL_THREAD_CALLBACKS(s390);
> > +
> > +static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *a=
rch)
> > +{
> > +     if (!strcmp(arch, "arm"))
> > +             return &callbacks_arm;
> > +     else if (!strcmp(arch, "arm64"))
> > +             return &callbacks_arm64;
> > +     else if (!strcmp(arch, "csky"))
> > +             return &callbacks_csky;
> > +     else if (!strcmp(arch, "loongarch"))
> > +             return &callbacks_loongarch;
> > +     else if (!strcmp(arch, "powerpc"))
> > +             return &callbacks_powerpc;
> > +     else if (!strcmp(arch, "riscv"))
> > +             return &callbacks_riscv;
> > +     else if (!strcmp(arch, "s390"))
> > +             return &callbacks_s390;
> > +     else if (!strcmp(arch, "x86"))
> > +             return &callbacks_x86;
> > +
> > +     pr_err("Fail to get thread callbacks for arch %s, returns NULL\n"=
,
> > +            arch);
> > +     return NULL;
> > +}
> >
> >  static int
> >  frame_callback(Dwfl_Frame *state, void *arg)
> > @@ -278,6 +312,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void =
*arg,
> >       const char *arch =3D perf_env__arch(ui_buf.machine->env);
> >       Dwarf_Word ip;
> >       int err =3D -EINVAL, i;
> > +     const Dwfl_Thread_Callbacks *callbacks;
> >
> >       if (!data->user_regs || !data->user_regs->regs)
> >               return -EINVAL;
> > @@ -300,7 +335,11 @@ int unwind__get_entries(unwind_entry_cb_t cb, void=
 *arg,
> >       if (err)
> >               goto out;
> >
> > -     err =3D !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread)=
, &callbacks, ui);
> > +     callbacks =3D get_thread_callbacks(arch);
> > +     if (!callbacks)
> > +             goto out;
> > +
> > +     err =3D !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread)=
, callbacks, ui);
> >       if (err)
> >               goto out;
> >
> > diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-li=
bdw.h
> > index 8c88bc4f2304b59561ffd482469ca63ce0f531f0..574b29848cce31e6bfd9302=
1f752b518cebf73b7 100644
> > --- a/tools/perf/util/unwind-libdw.h
> > +++ b/tools/perf/util/unwind-libdw.h
> > @@ -9,7 +9,15 @@ struct machine;
> >  struct perf_sample;
> >  struct thread;
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)=
;
> > +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg);
> > +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg);
> > +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg)=
;
> > +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg);
> > +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *=
arg);
> > +bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
> > +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *ar=
g);
> > +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)=
;
> > +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg);
> >
> >  struct unwind_info {
> >       Dwfl                    *dwfl;
> >
> > ---
> > base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> > change-id: 20260105-cross-arch-unwind-7238af40fb14
> >
> > Best regards,
> > --
> > Shimin Guo <shimin.guo@skydio.com>
> >
> >
