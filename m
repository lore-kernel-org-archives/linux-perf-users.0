Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CE46521
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Feb 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790273; cv=none; b=J7d0G8bHVtgDrth/gxafwa+Bw2OhH6KE+d9XLE1BDY+8tE4Jb55VPHwvNrdLRMzA9WAZgf1pk7jPn0ElnRqq85eW9mIgMfUbG8gMxM3ID95QcdD9J5xXSIp2eDHn/JlQPalLlK6S66Vh/Ga+4OpNubVN2r6L+pl1tA3O/5Xo6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790273; c=relaxed/simple;
	bh=kA4HJGmAWfHeTwrNoxNfR559WSZK9P7+wVQFqawbHVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gxs0k2vGdrNahn95eDfAncyKKLpEmwOhEzwvZeATU0X2pGhsROC68sYuyfzoDOGB8j0G1bXjXoysoer8+lX85mUWAGrMBJPXVmGM3cAgU7iVY+k5MscoRExyiOi1RQt+GYgVpEhHrDfwTLkg+43jMCPO1OOf7r5yn+/U6sQTLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUwj56NG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUwj56NG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc744f54d0so116435ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Feb 2024 07:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708790272; x=1709395072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxK3RQlJqjSaaTSRynT6mb3vJkeecwcqelm+GMD9Vn0=;
        b=QUwj56NGJSTsNIq8rgnCEmP6sz6xhulrn4IViwEmkzhpb/su3oFnK+ow+0LK1GkqNg
         86/ouYyAWNZF59PPGRt7e6DHWQklebFuNpDB/cnEJEDqz5uBH1KMWiX5CE9dIeJXvRaq
         h/jvv1JC837lmoX4F4MTKENF5LNQOWf3gy5yBe8mvbqdDgcUuS/Ba+wj16mRrF6yDbfs
         p32HqgA0a7EfCWi7sn5IKcG2ecPg57ib5h6HkU3M8vvllTGAlFRO/uOVyR6Fp9Ev32PQ
         6Ul1k8KDg2awjndL+RPxJGNgeXXPQjwBf/KuqAik1+CrtCDzg4HUlUCsNG0modAz2Vwd
         i8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708790272; x=1709395072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxK3RQlJqjSaaTSRynT6mb3vJkeecwcqelm+GMD9Vn0=;
        b=frIrQR0zwexoPCGwlG7BBOKfenJDhBc7lkd1ZJeHAqpveTi0srsbv/KGNkfliUJrcu
         CiKhe9G8S5EYoHtl1IsyCecnfs32fBwJaLGMztFAwT4rR6C8/rZQTUdXMbrkACgqYTg4
         uKrxALnUQr1ZiqrN6KPUBcM1ZOjUgsFqCw0VxLKfSKNrWaQCB9eHo+t9J7Z/NeK9QP0w
         HlWQGz5Z2fZAWsi0QizGHKeicpX0QKSA898/b+YkEwnXxslNjAD3T0V6kS49cKxx3zCh
         slttOIrVjRu13g5ywD6r0HN8YItrssVIQ3WcNkxmRITAyaRGfO5OyEe8OUtQlEpLz0zf
         mX4w==
X-Forwarded-Encrypted: i=1; AJvYcCXTcaYRBJa6vCwmvkW6GLKcWScFsIZCdicna8UFeBQcdcdKw9bPnmDd87wzZl7yht2yOODDS4XBSgTpvNfzDiucsT6YA+/khQu4NalGoH0Bcg==
X-Gm-Message-State: AOJu0YzjZwtonSXTDJQOBc/o9O47lQxxzqQhWMJvO3zeEDMnrYhg0v7R
	Gf1FyKxFFgzsDhO6tg/zdoquRLBcm76PX3eUvLWMk841ahIZFMtAeR5+cdRoQEPIFu4T05vCewg
	+B35bs6rEqynTvDKpgXB8JTzULC5bjTXwlUqAos/MjPdFVQ/MXCsJ
X-Google-Smtp-Source: AGHT+IF9/YUc3Jxcdgnr2jCA4eooBcSWBj2wt/igREyEUGMIY3W0N9s+XPH7fNan0mM+QzSzwYMZmK3FgKxvYfe5cAM=
X-Received: by 2002:a17:903:3092:b0:1dc:418f:4ebc with SMTP id
 u18-20020a170903309200b001dc418f4ebcmr171604plc.21.1708790271225; Sat, 24 Feb
 2024 07:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdoPrWg-qYFpBJbz@x1>
In-Reply-To: <ZdoPrWg-qYFpBJbz@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 24 Feb 2024 07:57:37 -0800
Message-ID: <CAP-5=fVhQLSXb7GSn3H=CLCq+n7hr2FXgQLrOyJZAeBOJUOveA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf: Check that the minimal vmlinux.h installed
 is the latest one
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 7:48=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> When building BPF skels perf will, by default, install a minimalistic
> vmlinux.h file with the types needed by the BPF skels in
> tools/perf/util/bpf_skel/ in its build directory.
>
> When 29d16de26df17e94 ("perf augmented_raw_syscalls.bpf: Move 'struct
> timespec64' to vmlinux.h") was added, a type used in the augmented_raw_sy=
scalls
> BPF skel, 'struct timespec64' was not found when building from a pre-exis=
ting
> build directory, because the vmlinux.h there didn't contain that type,
> ending up with this error, spotted in linux-next:
>
>     CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_s=
yscalls.bpf.o
>   util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid appli=
cation of 'sizeof' to an incomplete type 'struct timespec64'
>     329 |         __u32 size =3D sizeof(struct timespec64);
>         |                      ^     ~~~~~~~~~~~~~~~~~~~
>   util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declar=
ation of 'struct timespec64'
>     329 |         __u32 size =3D sizeof(struct timespec64);
>         |                                    ^
>   util/bpf_skel/augmented_raw_syscalls.bpf.c:350:15: error: invalid appli=
cation of 'sizeof' to an incomplete type 'struct timespec64'
>     350 |         __u32 size =3D sizeof(struct timespec64);
>         |                      ^     ~~~~~~~~~~~~~~~~~~~
>   util/bpf_skel/augmented_raw_syscalls.bpf.c:350:29: note: forward declar=
ation of 'struct timespec64'
>     350 |         __u32 size =3D sizeof(struct timespec64);
>         |                                    ^
>   2 errors generated.
>   make[2]: *** [Makefile.perf:1158: /tmp/build/perf-tools-next/util/bpf_s=
kel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
>   make[2]: *** Waiting for unfinished jobs....
>   make[1]: *** [Makefile.perf:261: sub-make] Error 2
>   make: *** [Makefile:113: install-bin] Error 2
>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>
> So add a Makefile dependency (Namhyung's suggestion) to make sure that
> the new tools/perf/util/bpf_skel/vmlinux/vmlinux.h minimal vmlinux is
> updated in the build directory, providing the moved 'struct timespec64'
> type.
>
> Fixes: 29d16de26df17e94 ("perf augmented_raw_syscalls.bpf: Move 'struct t=
imespec64' to vmlinux.h")
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/lkml/CAM9d7ciaj80QZL0AS_T2HNBdMOyS-j1wBHQSY=
s=3DU3kHQimY1mQ@mail.gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 3cecd51b239707ba..33621114135ee2c8 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1147,7 +1147,7 @@ ifeq ($(VMLINUX_H),)
>    endif
>  endif
>
> -$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> +$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) $(VMLINUX_H)
>  ifeq ($(VMLINUX_H),)
>         $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
>  else
> --
> 2.43.0
>
