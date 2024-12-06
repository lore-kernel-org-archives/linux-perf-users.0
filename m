Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1812FB0A
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455545; cv=none; b=U6lOjG097hdBlCXkKD6b+WuEKUr5vnEgD0UXJwsAE2OgsepRBrcgnEHJ0YYtzgaaVMf+fl94ZtTCwChKBlGuoyDrl0I4v4egaW1ifgfQjdIQHJvw9GtLpI++NQpHvxSxohHe2EFfLD42KsCzwLTb/wSnIjx2Iw4BFkx0eicuxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455545; c=relaxed/simple;
	bh=UIwZ2F5iro57qftdeiVmKApmuIYElsbzdKtYtNYZUXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFodbyMMVjKWC0qr/Qe2qCqp9zcVd2WzsL4wovXOAz0oMsoE1lUaWkc1HIeIZ0eSHj2pVtucv15UwrWqqx16qSdGltguLbxmuSVbW9wLxMx4QSmfNB6ZKv21Yp+oQb0/X2vBGHpK3UU/UHJJ3OLeuPGISAbehD3Ux4E2lfxj8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Raxf2T/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Raxf2T/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733455541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ub3CBm+ARKvN52RKC1y+FOhT8x6wq6Pz/QR1gLGlmM=;
	b=Raxf2T/kfe5jv/ZYYoA/odd5x2UO2grngsH7iJfkD1jOXK0u/yFmSE6xWzWx4wwOF5pDCY
	1KqTyGAnEuIrKv/kmld0kl4mzLq5BgS/PELyCpNaftvWhNJMH0cBRhqVONsQML3eiJp4Qw
	qcavXFScpf143iJcFU5BQllqGN+nRHs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-SyZqk99QOvexdMZ-gplSyQ-1; Thu, 05 Dec 2024 22:25:39 -0500
X-MC-Unique: SyZqk99QOvexdMZ-gplSyQ-1
X-Mimecast-MFC-AGG-ID: SyZqk99QOvexdMZ-gplSyQ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21575ca0754so24051785ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 19:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733455538; x=1734060338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ub3CBm+ARKvN52RKC1y+FOhT8x6wq6Pz/QR1gLGlmM=;
        b=U5YM5xuE+zPmuLErwqiZUcmCgM0rCoUxI+Nuru5rUGRb0xLbvZQ3tYomqfXvXv5hyo
         PhYVmNx34Z7J2RBRC4tm9L3t5leoBoxQUre4l6QGJs65IhzDeC0XFi0vI9G9WDTV46uw
         H7N0H9ufRnp/qxhX/hQypIhKmK2oqoNnDJs3Oi09i36obrjX2IEvy178QJV+l4gDtj2n
         SsZwmtOGzeLgcenDjhzVO9P8chxoQhQVTD2tO0sTjofDeIP9exAArGRXWB1ejLwNtDjv
         iQkUd6wZ0d7qLGhJ3Rqew2OhLg6ySSH9TWjOXSQG22VtC2yEoUVe/5bsufwwHNsisu+n
         g8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVslkJTzWGVyoqH2DdFgVC+kGzg2lCPHNGqRLv2tbo95aHVYIrs/SsI5CGr9a63LbKbnmdOXu/DLYrjOfnsFMLI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wjEVNRXl3jQKdLH+IcFAVmrQEOwzq1dpkuOi6pIdbwbmzoqu
	MVU4uTULG/LxWlu/lKg7VPNcBJXIJTQaaCTzGVXxnCavQiQOhtCVRtAgRM1QjGKjLjR53levYj0
	gqm0PDwQ8dX+J7Rwb+LG8LslsCwQrdq2wS4W/SWAM+iBJRa5Tdgkc1Ige7AllPWGWgj1S6nIseA
	DCgjnj2ve9mWXWASoueykP5V8THSQYcd5WC39Np2Z4Ag==
X-Gm-Gg: ASbGncsex2K92VlN1Lul3o9fkUrCBp01fTOsw/2/VIXsOTfFxq2puNvaP1d5ppXXXzZ
	2dwNS0Q79ZYe434EZWWpkWl3Qy6jN2yrV
X-Received: by 2002:a17:902:e5c2:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21614df13bcmr18294845ad.40.1733455538300;
        Thu, 05 Dec 2024 19:25:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiYrBXQUNFqhbE55OV0KdX6ql8a4fPJgEuA8t4s5BWqmnsk6BiY0PiiOwfupv3hIZpQhEcsPkIwfeXtLu+Sos=
X-Received: by 2002:a17:902:e5c2:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-21614df13bcmr18294285ad.40.1733455537591; Thu, 05 Dec 2024
 19:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206001436.1947528-1-namhyung@kernel.org> <CA+JHD90D86YC=Kn3P_B1xLamxKS9+_zOxmKxXMWyTDQGwGnNsQ@mail.gmail.com>
 <CAM9d7ciJjat3fSFEy8PpAa2Q+1=FfkoOFW=5cneAWeS5-e_1Qw@mail.gmail.com>
In-Reply-To: <CAM9d7ciJjat3fSFEy8PpAa2Q+1=FfkoOFW=5cneAWeS5-e_1Qw@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Fri, 6 Dec 2024 11:25:25 +0800
Message-ID: <CAATMXfkk4VHyrzwdKfFiRaQbgPN=-EJ5-gf3n2G6Tq=qTNdTRQ@mail.gmail.com>
Subject: Re: [BUG] perf trace: failed to load -E2BIG
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We hit the similar issue on our internal version since v6.11.0 and start wi=
th
commit 395d38419f1853decab84acc16176b3fa5c96690
and can easy to reproduce by 'perf trace ls' and get such error log:

------------
# perf trace ls
libbpf: prog 'sys_enter': BPF program load failed: Argument list too long
libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; int sys_enter(struct syscall_enter_args *args) @
augmented_raw_syscalls.bpf.c:527
0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:423
1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
2: (63) *(u32 *)(r10 -4) =3D r0         ; R0_w=3Dscalar() R10=3Dfp0 fp-8=3D=
mmmm????
3: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
4: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
; return bpf_map_lookup_elem(pids, &pid) !=3D NULL; @
augmented_raw_syscalls.bpf.c:428
5: (18) r1 =3D 0xff45c8d9a56b1c00       ;
R1_w=3Dmap_ptr(map=3Dpids_filtered,ks=3D4,vs=3D1)
7: (85) call bpf_map_lookup_elem#1    ;
R0=3Dmap_value_or_null(id=3D1,map=3Dpids_filtered,ks=3D4,vs=3D1)
8: (bf) r1 =3D r0                       ;
R0=3Dmap_value_or_null(id=3D1,map=3Dpids_filtered,ks=3D4,vs=3D1)
R1_w=3Dmap_value_or_null(id=3D1,map=3Dpids_filtered,ks=3D4,vs=3D1)
9: (b7) r0 =3D 0                        ; R0_w=3D0
... ...
111: (2d) if r1 > r9 goto pc-22 90:
R0=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688) R1_w=3D-6 R2=3D1
R3=3Dscalar(umin=3D1) R6=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D24,o=
ff=3D20)
R7=3Dmap_value(map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D56) R8=3D6
R9=3Dscalar(smin=3D0xffffffff80000000,smax=3Dsmax32=3D0,umin=3D2,umax=3D0xf=
ffffffffffffff9)
R10=3Dfp0 fp-8=3Dmmmmmmmm
fp-16=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D88)
fp-24=3Dmap_value(map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D16)
fp-32=3Dmap_value(map=3Daugmented_args_,ks=3D4,vs=3D8272) fp-40=3D16 fp-48=
=3Dctx()
fp-56=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688) fp-64=3D1
fp-72=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D80)
fp-80=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D24)
90: (07) r7 +=3D 8
BPF program is too large. Processed 1000001 insn
processed 1000001 insns (limit 1000000) max_states_per_insn 28
total_states 40283 peak_states 269 mark_read 15
-- END PROG LOAD LOG --
libbpf: prog 'sys_enter': failed to load: -7
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -7
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
... ...
................
Like some bpf error is printed before the trace is printed.
Hope this can help you to debug.

- Qiao

On Fri, Dec 6, 2024 at 8:49=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Dec 5, 2024 at 4:19=E2=80=AFPM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> >
> >
> > On Thu, Dec 5, 2024, 9:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >>
> >> Hello,
> >>
> >> I'm seeing the following error in the current perf-tools[-next].
> >> Do you see you the same?
> >
> > Nope, what's your environment?  Kernel version, clang, etc.
>
> It's a debian derivative and the kernel is v6.9.10 and clang 16.0.6.
> But I cannot reproduce it anymore after the bisect. :(
> Maybe it's a transient kernel bug.
>
> >
> > I think we should and that I'm addition to the verifier error log.
>
> I think the below is the verifier log and I cut it out as it repeated.
> It seems the verifier fell into a loop for some reason and thought
> the program had too many instructions.
>
> Thanks,
> Namhyung
>
> >
> >  - Arnaldo
> >
> >>
> >>   $ sudo ./perf trace -a sleep 1
> >>   libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
> >>   libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> >>   0: R1=3Dctx() R10=3Dfp0
> >>   ; int sys_enter(struct syscall_enter_args *args) @ augmented_raw_sys=
calls.bpf.c:527
> >>   0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
> >>   ; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:=
423
> >>   1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
> >>   2: (63) *(u32 *)(r10 -4) =3D r0         ; R0_w=3Dscalar() R10=3Dfp0 =
fp-8=3Dmmmm????
> >>   3: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
> >>   ;  @ augmented_raw_syscalls.bpf.c:0
> >>   4: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
> >>   ; return bpf_map_lookup_elem(pids, &pid) !=3D NULL; @ augmented_raw_=
syscalls.bpf.c:428
> >>   ...
> >>   140: (79) r7 =3D *(u64 *)(r10 -48)      ; R7_w=3Dctx() R10=3Dfp0 fp-=
48=3Dctx()
> >>   141: (79) r0 =3D *(u64 *)(r10 -56)
> >>   BPF program is too large. Processed 1000001 insn
> >>   processed 1000001 insns (limit 1000000) max_states_per_insn 28 total=
_states 37670 peak_states 330 mark_read 16
> >>   -- END PROG LOAD LOG --
> >>   libbpf: prog 'sys_enter': failed to load: -E2BIG
> >>   libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> >>   libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E=
2BIG
> >>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (=
was it created?)
> >>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (=
was it created?)
> >>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (=
was it created?)
> >>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (=
was it created?)
> >>   Not enough memory to run!
> >>
> >> The git bisect found this but I couldn't find anything suspicious.
> >>
> >> 395d38419f1853decab84acc16176b3fa5c96690 is the first bad commit
> >> commit 395d38419f1853decab84acc16176b3fa5c96690
> >> Author: Howard Chu <howardchu95@gmail.com>
> >> Date:   Thu Oct 10 19:14:02 2024 -0700
> >>
> >>     perf trace augmented_raw_syscalls: Add more checks to pass the ver=
ifier
> >>
> >>     Add some more checks to pass the verifier in more kernels.
> >>
> >>     Signed-off-by: Howard Chu <howardchu95@gmail.com>
> >>     Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >>     Cc: Alan Maguire <alan.maguire@oracle.com>
> >>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >>     Cc: Ian Rogers <irogers@google.com>
> >>     Cc: Ingo Molnar <mingo@redhat.com>
> >>     Cc: Jiri Olsa <jolsa@kernel.org>
> >>     Cc: Kan Liang <kan.liang@linux.intel.com>
> >>     Cc: Mark Rutland <mark.rutland@arm.com>
> >>     Cc: Namhyung Kim <namhyung@kernel.org>
> >>     Cc: Peter Zijlstra <peterz@infradead.org>
> >>     Link: https://lore.kernel.org/r/20241011021403.4089793-3-howardchu=
95@gmail.com
> >>     [ Reduced the patch removing things that can be done later ]
> >>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>
> >>  .../perf/util/bpf_skel/augmented_raw_syscalls.bpf.c  | 20 +++++++++++=
+++++++--
> >>  1 file changed, 18 insertions(+), 2 deletions(-)
> >> bisect found first bad commit
> >>
> >> Thanks,
> >> Namhyung
> >>
>

