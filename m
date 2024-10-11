Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68EB207205;
	Fri, 11 Oct 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613034; cv=none; b=hTvVM6LzMrMQXFyEb0gNyK5PBwN2GBi9yRCe0aaFt6Rp8w06BDnmA5ExWsyG9l2WX1h9P7wDBiIn6heRXjnhPHeYteab3KrjCzsXjr3dlhumkmsHo7VrFTFm8tKaM7fJ+JoJx2JTU3EGxLpdSCegs9X24IXx8Z3peGHGYHtwU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613034; c=relaxed/simple;
	bh=rPzVXgvBdH+mcDaZO6Hvn2JiSWoII0FVviKqgFjuXwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMBv18CZ0RRpYnWRUtPbhtUa7UGo6KehefV5aQCOgCpIAN8j3xF+0IZRixqlDx47yXaNaGYKa4dThS3fNNIBLm1h+fK0jPM37oETGy/VF92+Zg7i8t+i0GrQpiY4LeUDoNcRe7I90IYtyJR5N1azFC6uwYSUe3U1HcA9pVVAmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv3+Hf8S; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv3+Hf8S"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2923d5b87aso52181276.3;
        Thu, 10 Oct 2024 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613030; x=1729217830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h4iQnW2lP9nDNF1rcytF0D3RYaRTvu4j7tZVujiwPA=;
        b=Dv3+Hf8SEjVCZurcDfcfvzhnm8okC4b2eemAIniSsjv+nfS6YDjGOxe/2hT/O/ukOy
         A6jmNOeWztQKJLr+/bSFUrzwx9bb7UNR/coaGGuJnkR/sEUlqJGjersc1L2H1dRm0WyL
         4saZ2pD2fF1EFNcdbbvcZ4e8WEd7Nqca8Rh/lQVR8LL7nOjrZO5U0xjkTvzRixHSdE8G
         2yaMU2Nuy9HzSe3on8DDlAvAFMx5+rGwr+0FLfq168MMwS1S1kcfGI7CKgVJTcWAbkzG
         kf5WXgt3gUe5tmb9CxV4Fqo7BBW8S1MMJKbwtbObBEnyLLgHlZrkgNCTcndx/wj052Qc
         7xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613031; x=1729217831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h4iQnW2lP9nDNF1rcytF0D3RYaRTvu4j7tZVujiwPA=;
        b=b6pfEqejbjW5rthpvpWwUJAiXc5h+YyFGSPmKzZXa+7kn/vbfmpehplcS1CoKGR8l+
         yVKGYCYHaK5id5dTXSpZLhHhUUFJfpDA/iCsnICbLWcweHKxCia8hthkihknk/vcK66z
         CRojZGdzZJowH4hCHhG4LcviKJ1fRe5nwcaCMMyrZJVaiUE+lw553yYDdO6LwGJMHp4s
         MofK54JaNQVfqPw8qz5RQWgaB2vVzsMkJK8FWlSPfTmEcCforL9ZTsq/wzcbz0WyWyKl
         vZF3D4Hl0tn6dkTDtwu0JQstzosz1v0ExrAnj38ToSILNY+Iz5Z4bIFq+HMTt79L5y1F
         gZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWFSJ56/liIotysDKOY9VTDRlH7QWvMPBl4pIxmixYyaKW7QS/KUhcakYM4disJzLyeFNNMkwRbN1zVIWI=@vger.kernel.org, AJvYcCWy/h9d3rELml71Gf9CpXWCjKtZDM1ioxdgKr3foVBmlQi2OEcD46rcApLBYSUynbpsrHevSlfq2RTj3sfdVQq+Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCGFuACQezxBu7y1+h/45whs2Fherbl6how8Vk+lZGifKIYqw
	lcb4WwrfiBOcnwYqR3vvmu3S82IyOBu6/2Bq3QLCFyVuBWGcoo+pseh4bUcxKdxI1F/GXRbUz5N
	bC10o4vtDwPE6GX5ia8viKk2Og/U=
X-Google-Smtp-Source: AGHT+IHGcFbcWg9Y4Hi6w+Ul+E+vYC5Aq18lrbYv+LcBum3CJ9+/IDV2DuyImp26QbUvlxkqUJFOFBVyENM49diqHPA=
X-Received: by 2002:a05:6902:2411:b0:e29:11fe:102a with SMTP id
 3f1490d57ef6-e2919def5f4mr862732276.36.1728613030308; Thu, 10 Oct 2024
 19:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007051414.2995674-1-howardchu95@gmail.com>
 <52125138-9ba5-4f71-9e7d-aff5f85d0dae@linaro.org> <ZwhvYsN7UPAOPvFj@google.com>
In-Reply-To: <ZwhvYsN7UPAOPvFj@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 10 Oct 2024 19:16:59 -0700
Message-ID: <CAH0uvohZUBw7VBe99itjTYzQETHNds79_TczO=1VhnF08w0U9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf trace: Fix support for the new BPF feature in
 clang 12
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

Fixed it in v2 (Link:
https://lore.kernel.org/linux-perf-users/20241011021403.4089793-1-howardchu=
95@gmail.com/)
, and tested it on clang-14 ~ clang-18 (did make clean every time just
incase)

Thanks,
Howard


On Thu, Oct 10, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 10, 2024 at 10:06:05AM +0100, James Clark wrote:
> >
> >
> > On 07/10/2024 6:14 am, Howard Chu wrote:
> > > The new augmentation feature in perf trace, along with the protocol
> > > change (from payload to payload->value), breaks the clang 12 build.
> > >
> > > perf trace actually builds for any clang version newer than clang 16.
> > > However, as pointed out by Namhyung Kim <namhyung@kernel.org> and Ian
> > > Rogers <irogers@google.com>, clang 16, which was released in 2023, is
> > > still too new for most users. Additionally, as James Clark
> > > <james.clark@linaro.org> noted, some commonly used distributions do n=
ot
> > > yet support clang 16. Therefore, breaking BPF features between clang =
12
> > > and clang 15 is not a good approach.
> > >
> > > This patch series rewrites the BPF program in a way that allows it to
> > > pass the BPF verifier, even when the BPF bytecode is generated by old=
er
> > > versions of clang.
> > >
> > > However, I have only tested it till clang 14, as older versions are n=
ot
> > > supported by my distribution.
> > >
> > > Howard Chu (2):
> > >    perf build: Change the clang check back to 12.0.1
> > >    perf trace: Rewrite BPF code to pass the verifier
> > >
> > >   tools/perf/Makefile.config                    |   4 +-
> > >   .../bpf_skel/augmented_raw_syscalls.bpf.c     | 117 ++++++++++-----=
---
> > >   2 files changed, 65 insertions(+), 56 deletions(-)
> > >
> >
> > Tested with clang 15:
> >
> >  $ sudo perf trace -e write --max-events=3D100 -- echo hello
> >     0.000 ( 0.014 ms): echo/834165 write(fd: 1, buf: hello\10, count: 6=
)
> >                                             =3D
> >
> > Tested-by: James Clark <james.clark@linaro.org>
>
> I got this on my system (clang 16).  The kernel refused to load it.
>
>   $ sudo ./perf trace -e write --max-events=3D10 -- echo hello
>   libbpf: prog 'sys_enter': BPF program load failed: Permission denied
>   libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>   0: R1=3Dctx() R10=3Dfp0
>   ; int sys_enter(struct syscall_enter_args *args) @ augmented_raw_syscal=
ls.bpf.c:518
>   0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
>   ; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:427
>   1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
>   2: (63) *(u32 *)(r10 -4) =3D r0         ; R0_w=3Dscalar() R10=3Dfp0 fp-=
8=3Dmmmm????
>   3: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   4: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
>   ; return bpf_map_lookup_elem(pids, &pid) !=3D NULL; @ augmented_raw_sys=
calls.bpf.c:432
>   5: (18) r1 =3D 0xffff9dcccdfe7000       ; R1_w=3Dmap_ptr(map=3Dpids_fil=
tered,ks=3D4,vs=3D1)
>   7: (85) call bpf_map_lookup_elem#1    ; R0=3Dmap_value_or_null(id=3D1,m=
ap=3Dpids_filtered,ks=3D4,vs=3D1)
>   8: (bf) r1 =3D r0                       ; R0=3Dmap_value_or_null(id=3D1=
,map=3Dpids_filtered,ks=3D4,vs=3D1) R1_w=3Dmap_value_or_null(id=3D1,map=3Dp=
ids_filtered,ks=3D4,vs=3D1)
>   9: (b7) r0 =3D 0                        ; R0_w=3D0
>   ; if (pid_filter__has(&pids_filtered, getpid())) @ augmented_raw_syscal=
ls.bpf.c:531
>   10: (55) if r1 !=3D 0x0 goto pc+161     ; R1_w=3D0
>   11: (b7) r6 =3D 0                       ; R6_w=3D0
>   ; int key =3D 0; @ augmented_raw_syscalls.bpf.c:150
>   12: (63) *(u32 *)(r10 -4) =3D r6        ; R6_w=3D0 R10=3Dfp0 fp-8=3D000=
0????
>   13: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   14: (07) r2 +=3D -4                     ; R2_w=3Dfp-4
>   ; return bpf_map_lookup_elem(&augmented_args_tmp, &key); @ augmented_ra=
w_syscalls.bpf.c:151
>   15: (18) r1 =3D 0xffff9dcc73f8f200      ; R1_w=3Dmap_ptr(map=3Daugmente=
d_args_,ks=3D4,vs=3D8272)
>   17: (85) call bpf_map_lookup_elem#1   ; R0=3Dmap_value_or_null(id=3D2,m=
ap=3Daugmented_args_,ks=3D4,vs=3D8272)
>   18: (bf) r8 =3D r0                      ; R0=3Dmap_value_or_null(id=3D2=
,map=3Daugmented_args_,ks=3D4,vs=3D8272) R8_w=3Dmap_value_or_null(id=3D2,ma=
p=3Daugmented_args_,ks=3D4,vs=3D8272)
>   19: (b7) r0 =3D 1                       ; R0_w=3D1
>   ; if (augmented_args =3D=3D NULL) @ augmented_raw_syscalls.bpf.c:535
>   20: (15) if r8 =3D=3D 0x0 goto pc+151     ; R8_w=3Dmap_value(map=3Daugm=
ented_args_,ks=3D4,vs=3D8272)
>   ; bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->a=
rgs), args); @ augmented_raw_syscalls.bpf.c:538
>   21: (bf) r1 =3D r8                      ; R1_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272) R8_w=3Dmap_value(map=3Daugmented_args_,ks=3D4,v=
s=3D8272)
>   22: (b7) r2 =3D 64                      ; R2_w=3D64
>   23: (bf) r3 =3D r7                      ; R3_w=3Dctx() R7=3Dctx()
>   24: (85) call bpf_probe_read_kernel#113       ; R0_w=3Dscalar()
>   ; int zero =3D 0, value_size =3D sizeof(struct augmented_arg) - sizeof(=
u64); @ augmented_raw_syscalls.bpf.c:438
>   25: (63) *(u32 *)(r10 -4) =3D r6        ; R6=3D0 R10=3Dfp0 fp-8=3D0000?=
???
>   ; nr             =3D (__u32)args->syscall_nr; @ augmented_raw_syscalls.=
bpf.c:448
>   26: (79) r1 =3D *(u64 *)(r8 +8)         ; R1_w=3Dscalar() R8_w=3Dmap_va=
lue(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   27: (63) *(u32 *)(r10 -8) =3D r1        ; R1_w=3Dscalar() R10=3Dfp0 fp-=
8=3D0000scalar()
>   28: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
>   ; bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->a=
rgs), args); @ augmented_raw_syscalls.bpf.c:538
>   29: (07) r2 +=3D -8                     ; R2_w=3Dfp-8
>   ; beauty_map     =3D bpf_map_lookup_elem(&beauty_map_enter, &nr); @ aug=
mented_raw_syscalls.bpf.c:449
>   30: (18) r1 =3D 0xffff9dcccdfe5800      ; R1_w=3Dmap_ptr(map=3Dbeauty_m=
ap_ente,ks=3D4,vs=3D24)
>   32: (85) call bpf_map_lookup_elem#1   ; R0=3Dmap_value_or_null(id=3D3,m=
ap=3Dbeauty_map_ente,ks=3D4,vs=3D24)
>   ; if (beauty_map =3D=3D NULL) @ augmented_raw_syscalls.bpf.c:450
>   33: (15) if r0 =3D=3D 0x0 goto pc+132     ; R0=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24)
>   34: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   35: (07) r2 +=3D -4                     ; R2_w=3Dfp-4
>   ; payload        =3D bpf_map_lookup_elem(&beauty_payload_enter_map, &ze=
ro); @ augmented_raw_syscalls.bpf.c:454
>   36: (18) r1 =3D 0xffff9dcc73f8e800      ; R1_w=3Dmap_ptr(map=3Dbeauty_p=
ayload_,ks=3D4,vs=3D24688)
>   38: (7b) *(u64 *)(r10 -16) =3D r0       ; R0=3Dmap_value(map=3Dbeauty_m=
ap_ente,ks=3D4,vs=3D24) R10=3Dfp0 fp-16_w=3Dmap_value(map=3Dbeauty_map_ente=
,ks=3D4,vs=3D24)
>   39: (85) call bpf_map_lookup_elem#1   ; R0_w=3Dmap_value_or_null(id=3D4=
,map=3Dbeauty_payload_,ks=3D4,vs=3D24688)
>   40: (79) r4 =3D *(u64 *)(r10 -16)       ; R4_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R10=3Dfp0 fp-16_w=3Dmap_value(map=3Dbeauty_map_en=
te,ks=3D4,vs=3D24)
>   ; if (payload =3D=3D NULL) @ augmented_raw_syscalls.bpf.c:456
>   41: (15) if r0 =3D=3D 0x0 goto pc+124     ; R0_w=3Dmap_value(map=3Dbeau=
ty_payload_,ks=3D4,vs=3D24688)
>   42: (7b) *(u64 *)(r10 -48) =3D r7       ; R7=3Dctx() R10=3Dfp0 fp-48_w=
=3Dctx()
>   ; __builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_ar=
gs)); @ augmented_raw_syscalls.bpf.c:460
>   43: (79) r1 =3D *(u64 *)(r8 +56)        ; R1_w=3Dscalar() R8=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   44: (7b) *(u64 *)(r0 +56) =3D r1        ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R1_w=3Dscalar()
>   45: (79) r1 =3D *(u64 *)(r8 +48)        ; R1_w=3Dscalar() R8=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   46: (7b) *(u64 *)(r0 +48) =3D r1        ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R1_w=3Dscalar()
>   47: (79) r1 =3D *(u64 *)(r8 +40)        ; R1_w=3Dscalar() R8=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   48: (7b) *(u64 *)(r0 +40) =3D r1        ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R1_w=3Dscalar()
>   49: (79) r1 =3D *(u64 *)(r8 +32)        ; R1_w=3Dscalar() R8=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   50: (7b) *(u64 *)(r0 +32) =3D r1        ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R1_w=3Dscalar()
>   51: (79) r1 =3D *(u64 *)(r8 +24)        ; R1_w=3Dscalar() R8=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   52: (7b) *(u64 *)(r0 +24) =3D r1        ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R1_w=3Dscalar()
>   53: (79) r1 =3D *(u64 *)(r8 +16)        ; R1_w=3Dscalar() R8=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   54: (7b) *(u64 *)(r0 +16) =3D r1        ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R1_w=3Dscalar()
>   55: (79) r1 =3D *(u64 *)(r8 +8)         ; R1_w=3Dscalar() R8=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   56: (7b) *(u64 *)(r0 +8) =3D r1         ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R1_w=3Dscalar()
>   57: (79) r1 =3D *(u64 *)(r8 +0)         ; R1_w=3Dscalar() R8=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272)
>   58: (7b) *(u64 *)(r0 +0) =3D r1         ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R1_w=3Dscalar()
>   59: (b7) r1 =3D 64                      ; R1_w=3D64
>   60: (7b) *(u64 *)(r10 -24) =3D r1       ; R1_w=3D64 R10=3Dfp0 fp-24_w=
=3D64
>   61: (7b) *(u64 *)(r10 -40) =3D r8       ; R8=3Dmap_value(map=3Daugmente=
d_args_,ks=3D4,vs=3D8272) R10=3Dfp0 fp-40_w=3Dmap_value(map=3Daugmented_arg=
s_,ks=3D4,vs=3D8272)
>   62: (bf) r7 =3D r8                      ; R7_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272) R8=3Dmap_value(map=3Daugmented_args_,ks=3D4,vs=
=3D8272)
>   63: (07) r7 +=3D 16                     ; R7_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272,off=3D16)
>   64: (7b) *(u64 *)(r10 -56) =3D r0       ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R10=3Dfp0 fp-56_w=3Dmap_value(map=3Dbeauty_pay=
load_,ks=3D4,vs=3D24688)
>   ; payload_offset =3D (void *)&payload->aug_args; @ augmented_raw_syscal=
ls.bpf.c:455
>   65: (bf) r9 =3D r0                      ; R0_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R9_w=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,=
vs=3D24688)
>   66: (07) r9 +=3D 64                     ; R9_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D64)
>   67: (b7) r1 =3D 0                       ; R1_w=3D0
>   ; for (int i =3D 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:471
>   68: (7b) *(u64 *)(r10 -32) =3D r1       ; R1_w=3D0 R10=3Dfp0 fp-32_w=3D=
0
>   69: (05) goto pc+11
>   ; int augment_size =3D beauty_map[i], augment_size_with_header; @ augme=
nted_raw_syscalls.bpf.c:472
>   81: (bf) r1 =3D r4                      ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R4=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D=
24)
>   82: (0f) r1 +=3D r6                     ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R6=3D0
>   83: (61) r8 =3D *(u32 *)(r1 +0)         ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R8_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,v=
ar_off=3D(0x0; 0xffffffff))
>   84: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x7fffff=
ff00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xffffffff00000000))
>   85: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3D0x7fffffff)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   86: (15) if r8 =3D=3D 0x0 goto pc-9       ; R8_w=3Dscalar(smin=3D0xffff=
ffff80000000,smax=3D0x7fffffff,umin=3D1)
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   87: (79) r3 =3D *(u64 *)(r7 +0)         ; R3_w=3Dscalar() R7=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D16)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   88: (15) if r3 =3D=3D 0x0 goto pc-11      ; R3_w=3Dscalar(umin=3D1)
>   ; value_offset =3D ((struct augmented_arg *)payload_offset)->value; @ a=
ugmented_raw_syscalls.bpf.c:479
>   89: (bf) r1 =3D r9                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D64) R9=3Dmap_value(map=3Dbeauty_payload_,=
ks=3D4,vs=3D24688,off=3D64)
>   90: (07) r1 +=3D 8                      ; R1=3Dmap_value(map=3Dbeauty_p=
ayload_,ks=3D4,vs=3D24688,off=3D72)
>   ; if (augment_size =3D=3D 1) { /* string */ @ augmented_raw_syscalls.bp=
f.c:481
>   91: (55) if r8 !=3D 0x1 goto pc-22      ; R8=3D1
>   ; augment_size =3D bpf_probe_read_user_str(value_offset, value_size, ad=
dr); @ augmented_raw_syscalls.bpf.c:482
>   92: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   93: (85) call bpf_probe_read_user_str#114     ; R0_w=3Dscalar(smin=3Dsm=
in32=3D-4095,smax=3Dsmax32=3D4096)
>   94: (79) r4 =3D *(u64 *)(r10 -16)       ; R4_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R10=3Dfp0 fp-16=3Dmap_value(map=3Dbeauty_map_ente=
,ks=3D4,vs=3D24)
>   95: (bf) r8 =3D r0                      ; R0_w=3Dscalar(id=3D5,smin=3Ds=
min32=3D-4095,smax=3Dsmax32=3D4096) R8_w=3Dscalar(id=3D5,smin=3Dsmin32=3D-4=
095,smax=3Dsmax32=3D4096)
>   96: (b7) r1 =3D 1                       ; R1_w=3D1
>   ; if (augment_size > value_size) @ augmented_raw_syscalls.bpf.c:496
>   97: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x100000=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   98: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3Dsmax32=3D4096)
>   99: (b7) r2 =3D 4096                    ; R2=3D4096
>   100: (6d) if r2 s> r8 goto pc+1       ; R2=3D4096 R8=3D4096
>   101: (b7) r8 =3D 4096                   ; R8_w=3D4096
>   ; if (is_augmented && augment_size_with_header <=3D sizeof(struct augme=
nted_arg)) { @ augmented_raw_syscalls.bpf.c:503
>   102: (57) r1 &=3D 1                     ; R1_w=3D1
>   103: (15) if r1 =3D=3D 0x0 goto pc-26     ; R1_w=3D1
>   104: (bf) r1 =3D r8                     ; R1_w=3D4096 R8_w=3D4096
>   105: (07) r1 +=3D 8                     ; R1_w=3D4104
>   106: (bf) r2 =3D r1                     ; R1_w=3D4104 R2_w=3D4104
>   107: (67) r2 <<=3D 32                   ; R2_w=3D0x100800000000
>   108: (77) r2 >>=3D 32                   ; R2=3D4104
>   109: (25) if r2 > 0x1008 goto pc-32   ; R2=3D4104
>   ; ((struct augmented_arg *)payload_offset)->size =3D augment_size; @ au=
gmented_raw_syscalls.bpf.c:504
>   110: (63) *(u32 *)(r9 +0) =3D r8        ; R8=3D4096 R9=3Dmap_value(map=
=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D64)
>   ; len            +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:506
>   111: (79) r3 =3D *(u64 *)(r10 -24)      ; R3_w=3D64 R10=3Dfp0 fp-24=3D6=
4
>   112: (0f) r1 +=3D r3                    ; R1_w=3D4168 R3_w=3D64
>   ; payload_offset +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:507
>   113: (0f) r9 +=3D r2                    ; R2=3D4104 R9_w=3Dmap_value(ma=
p=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D4168)
>   114: (b7) r2 =3D 1                      ; R2_w=3D1
>   115: (7b) *(u64 *)(r10 -32) =3D r2      ; R2_w=3D1 R10=3Dfp0 fp-32_w=3D=
1
>   116: (7b) *(u64 *)(r10 -24) =3D r1      ; R1_w=3D4168 R10=3Dfp0 fp-24_w=
=3D4168
>   117: (05) goto pc-40
>   ; for (int i =3D 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:471
>   78: (07) r7 +=3D 8                      ; R7_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272,off=3D24)
>   79: (07) r6 +=3D 4                      ; R6_w=3D4
>   80: (15) if r6 =3D=3D 0x18 goto pc+56     ; R6_w=3D4
>   ; int augment_size =3D beauty_map[i], augment_size_with_header; @ augme=
nted_raw_syscalls.bpf.c:472
>   81: (bf) r1 =3D r4                      ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R4=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D=
24)
>   82: (0f) r1 +=3D r6                     ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D4) R6_w=3D4
>   83: (61) r8 =3D *(u32 *)(r1 +0)         ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D4) R8_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xff=
ffffff,var_off=3D(0x0; 0xffffffff))
>   84: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x7fffff=
ff00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xffffffff00000000))
>   85: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3D0x7fffffff)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   86: (15) if r8 =3D=3D 0x0 goto pc-9       ; R8_w=3Dscalar(smin=3D0xffff=
ffff80000000,smax=3D0x7fffffff,umin=3D1)
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   87: (79) r3 =3D *(u64 *)(r7 +0)         ; R3=3Dscalar() R7=3Dmap_value(=
map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D24)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   88: (15) if r3 =3D=3D 0x0 goto pc-11      ; R3=3Dscalar(umin=3D1)
>   ; value_offset =3D ((struct augmented_arg *)payload_offset)->value; @ a=
ugmented_raw_syscalls.bpf.c:479
>   89: (bf) r1 =3D r9                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D4168) R9=3Dmap_value(map=3Dbeauty_payload=
_,ks=3D4,vs=3D24688,off=3D4168)
>   90: (07) r1 +=3D 8                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D4176)
>   ; if (augment_size =3D=3D 1) { /* string */ @ augmented_raw_syscalls.bp=
f.c:481
>   91: (55) if r8 !=3D 0x1 goto pc-22      ; R8=3D1
>   ; augment_size =3D bpf_probe_read_user_str(value_offset, value_size, ad=
dr); @ augmented_raw_syscalls.bpf.c:482
>   92: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   93: (85) call bpf_probe_read_user_str#114     ; R0_w=3Dscalar(smin=3Dsm=
in32=3D-4095,smax=3Dsmax32=3D4096)
>   94: (79) r4 =3D *(u64 *)(r10 -16)       ; R4_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R10=3Dfp0 fp-16=3Dmap_value(map=3Dbeauty_map_ente=
,ks=3D4,vs=3D24)
>   95: (bf) r8 =3D r0                      ; R0_w=3Dscalar(id=3D6,smin=3Ds=
min32=3D-4095,smax=3Dsmax32=3D4096) R8_w=3Dscalar(id=3D6,smin=3Dsmin32=3D-4=
095,smax=3Dsmax32=3D4096)
>   96: (b7) r1 =3D 1                       ; R1=3D1
>   ; if (augment_size > value_size) @ augmented_raw_syscalls.bpf.c:496
>   97: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x100000=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   98: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3Dsmax32=3D4096)
>   99: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   100: (6d) if r2 s> r8 goto pc+1       ; R2_w=3D4096 R8_w=3D4096
>   101: (b7) r8 =3D 4096                   ; R8_w=3D4096
>   ; if (is_augmented && augment_size_with_header <=3D sizeof(struct augme=
nted_arg)) { @ augmented_raw_syscalls.bpf.c:503
>   102: (57) r1 &=3D 1                     ; R1_w=3D1
>   103: (15) if r1 =3D=3D 0x0 goto pc-26     ; R1_w=3D1
>   104: (bf) r1 =3D r8                     ; R1_w=3D4096 R8_w=3D4096
>   105: (07) r1 +=3D 8                     ; R1_w=3D4104
>   106: (bf) r2 =3D r1                     ; R1_w=3D4104 R2_w=3D4104
>   107: (67) r2 <<=3D 32                   ; R2_w=3D0x100800000000
>   108: (77) r2 >>=3D 32                   ; R2_w=3D4104
>   109: (25) if r2 > 0x1008 goto pc-32   ; R2_w=3D4104
>   ; ((struct augmented_arg *)payload_offset)->size =3D augment_size; @ au=
gmented_raw_syscalls.bpf.c:504
>   110: (63) *(u32 *)(r9 +0) =3D r8        ; R8_w=3D4096 R9=3Dmap_value(ma=
p=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D4168)
>   ; len            +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:506
>   111: (79) r3 =3D *(u64 *)(r10 -24)      ; R3_w=3D4168 R10=3Dfp0 fp-24=
=3D4168
>   112: (0f) r1 +=3D r3                    ; R1_w=3D8272 R3_w=3D4168
>   ; payload_offset +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:507
>   113: (0f) r9 +=3D r2                    ; R2_w=3D4104 R9_w=3Dmap_value(=
map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D8272)
>   114: (b7) r2 =3D 1                      ; R2_w=3D1
>   115: (7b) *(u64 *)(r10 -32) =3D r2      ; R2_w=3D1 R10=3Dfp0 fp-32_w=3D=
1
>   116: (7b) *(u64 *)(r10 -24) =3D r1      ; R1_w=3D8272 R10=3Dfp0 fp-24_w=
=3D8272
>   117: (05) goto pc-40
>   ; for (int i =3D 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:471
>   78: (07) r7 +=3D 8                      ; R7_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272,off=3D32)
>   79: (07) r6 +=3D 4                      ; R6=3D8
>   80: (15) if r6 =3D=3D 0x18 goto pc+56     ; R6=3D8
>   ; int augment_size =3D beauty_map[i], augment_size_with_header; @ augme=
nted_raw_syscalls.bpf.c:472
>   81: (bf) r1 =3D r4                      ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R4=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D=
24)
>   82: (0f) r1 +=3D r6                     ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D8) R6=3D8
>   83: (61) r8 =3D *(u32 *)(r1 +0)         ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D8) R8_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xff=
ffffff,var_off=3D(0x0; 0xffffffff))
>   84: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x7fffff=
ff00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xffffffff00000000))
>   85: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3D0x7fffffff)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   86: (15) if r8 =3D=3D 0x0 goto pc-9       ; R8_w=3Dscalar(smin=3D0xffff=
ffff80000000,smax=3D0x7fffffff,umin=3D1)
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   87: (79) r3 =3D *(u64 *)(r7 +0)         ; R3_w=3Dscalar() R7=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D32)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   88: (15) if r3 =3D=3D 0x0 goto pc-11      ; R3_w=3Dscalar(umin=3D1)
>   ; value_offset =3D ((struct augmented_arg *)payload_offset)->value; @ a=
ugmented_raw_syscalls.bpf.c:479
>   89: (bf) r1 =3D r9                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D8272) R9=3Dmap_value(map=3Dbeauty_payload=
_,ks=3D4,vs=3D24688,off=3D8272)
>   90: (07) r1 +=3D 8                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D8280)
>   ; if (augment_size =3D=3D 1) { /* string */ @ augmented_raw_syscalls.bp=
f.c:481
>   91: (55) if r8 !=3D 0x1 goto pc-22      ; R8_w=3D1
>   ; augment_size =3D bpf_probe_read_user_str(value_offset, value_size, ad=
dr); @ augmented_raw_syscalls.bpf.c:482
>   92: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   93: (85) call bpf_probe_read_user_str#114     ; R0=3Dscalar(smin=3Dsmin=
32=3D-4095,smax=3Dsmax32=3D4096)
>   94: (79) r4 =3D *(u64 *)(r10 -16)       ; R4_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R10=3Dfp0 fp-16=3Dmap_value(map=3Dbeauty_map_ente=
,ks=3D4,vs=3D24)
>   95: (bf) r8 =3D r0                      ; R0=3Dscalar(id=3D7,smin=3Dsmi=
n32=3D-4095,smax=3Dsmax32=3D4096) R8_w=3Dscalar(id=3D7,smin=3Dsmin32=3D-409=
5,smax=3Dsmax32=3D4096)
>   96: (b7) r1 =3D 1                       ; R1_w=3D1
>   ; if (augment_size > value_size) @ augmented_raw_syscalls.bpf.c:496
>   97: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x100000=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   98: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3Dsmax32=3D4096)
>   99: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   100: (6d) if r2 s> r8 goto pc+1       ; R2_w=3D4096 R8_w=3D4096
>   101: (b7) r8 =3D 4096                   ; R8_w=3D4096
>   ; if (is_augmented && augment_size_with_header <=3D sizeof(struct augme=
nted_arg)) { @ augmented_raw_syscalls.bpf.c:503
>   102: (57) r1 &=3D 1                     ; R1_w=3D1
>   103: (15) if r1 =3D=3D 0x0 goto pc-26     ; R1_w=3D1
>   104: (bf) r1 =3D r8                     ; R1_w=3D4096 R8_w=3D4096
>   105: (07) r1 +=3D 8                     ; R1_w=3D4104
>   106: (bf) r2 =3D r1                     ; R1_w=3D4104 R2_w=3D4104
>   107: (67) r2 <<=3D 32                   ; R2_w=3D0x100800000000
>   108: (77) r2 >>=3D 32                   ; R2_w=3D4104
>   109: (25) if r2 > 0x1008 goto pc-32   ; R2_w=3D4104
>   ; ((struct augmented_arg *)payload_offset)->size =3D augment_size; @ au=
gmented_raw_syscalls.bpf.c:504
>   110: (63) *(u32 *)(r9 +0) =3D r8        ; R8_w=3D4096 R9=3Dmap_value(ma=
p=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D8272)
>   ; len            +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:506
>   111: (79) r3 =3D *(u64 *)(r10 -24)      ; R3_w=3D8272 R10=3Dfp0 fp-24=
=3D8272
>   112: (0f) r1 +=3D r3                    ; R1_w=3D12376 R3_w=3D8272
>   ; payload_offset +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:507
>   113: (0f) r9 +=3D r2                    ; R2_w=3D4104 R9_w=3Dmap_value(=
map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D12376)
>   114: (b7) r2 =3D 1                      ; R2_w=3D1
>   115: (7b) *(u64 *)(r10 -32) =3D r2      ; R2_w=3D1 R10=3Dfp0 fp-32_w=3D=
1
>   116: (7b) *(u64 *)(r10 -24) =3D r1      ; R1_w=3D12376 R10=3Dfp0 fp-24_=
w=3D12376
>   117: (05) goto pc-40
>   ; for (int i =3D 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:471
>   78: (07) r7 +=3D 8                      ; R7_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272,off=3D40)
>   79: (07) r6 +=3D 4                      ; R6_w=3D12
>   80: (15) if r6 =3D=3D 0x18 goto pc+56     ; R6_w=3D12
>   ; int augment_size =3D beauty_map[i], augment_size_with_header; @ augme=
nted_raw_syscalls.bpf.c:472
>   81: (bf) r1 =3D r4                      ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R4_w=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=
=3D24)
>   82: (0f) r1 +=3D r6                     ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D12) R6_w=3D12
>   83: (61) r8 =3D *(u32 *)(r1 +0)         ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D12) R8_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xf=
fffffff,var_off=3D(0x0; 0xffffffff))
>   84: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x7fffff=
ff00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xffffffff00000000))
>   85: (c7) r8 s>>=3D 32                   ; R8=3Dscalar(smin=3D0xffffffff=
80000000,smax=3D0x7fffffff)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   86: (15) if r8 =3D=3D 0x0 goto pc-9       ; R8=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3D0x7fffffff,umin=3D1)
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   87: (79) r3 =3D *(u64 *)(r7 +0)         ; R3_w=3Dscalar() R7=3Dmap_valu=
e(map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D40)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   88: (15) if r3 =3D=3D 0x0 goto pc-11      ; R3_w=3Dscalar(umin=3D1)
>   ; value_offset =3D ((struct augmented_arg *)payload_offset)->value; @ a=
ugmented_raw_syscalls.bpf.c:479
>   89: (bf) r1 =3D r9                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D12376) R9=3Dmap_value(map=3Dbeauty_payloa=
d_,ks=3D4,vs=3D24688,off=3D12376)
>   90: (07) r1 +=3D 8                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D12384)
>   ; if (augment_size =3D=3D 1) { /* string */ @ augmented_raw_syscalls.bp=
f.c:481
>   91: (55) if r8 !=3D 0x1 goto pc-22      ; R8=3D1
>   ; augment_size =3D bpf_probe_read_user_str(value_offset, value_size, ad=
dr); @ augmented_raw_syscalls.bpf.c:482
>   92: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   93: (85) call bpf_probe_read_user_str#114     ; R0_w=3Dscalar(smin=3Dsm=
in32=3D-4095,smax=3Dsmax32=3D4096)
>   94: (79) r4 =3D *(u64 *)(r10 -16)       ; R4_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R10=3Dfp0 fp-16=3Dmap_value(map=3Dbeauty_map_ente=
,ks=3D4,vs=3D24)
>   95: (bf) r8 =3D r0                      ; R0_w=3Dscalar(id=3D8,smin=3Ds=
min32=3D-4095,smax=3Dsmax32=3D4096) R8_w=3Dscalar(id=3D8,smin=3Dsmin32=3D-4=
095,smax=3Dsmax32=3D4096)
>   96: (b7) r1 =3D 1                       ; R1_w=3D1
>   ; if (augment_size > value_size) @ augmented_raw_syscalls.bpf.c:496
>   97: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x100000=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   98: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3Dsmax32=3D4096)
>   99: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   100: (6d) if r2 s> r8 goto pc+1       ; R2_w=3D4096 R8_w=3D4096
>   101: (b7) r8 =3D 4096                   ; R8=3D4096
>   ; if (is_augmented && augment_size_with_header <=3D sizeof(struct augme=
nted_arg)) { @ augmented_raw_syscalls.bpf.c:503
>   102: (57) r1 &=3D 1                     ; R1_w=3D1
>   103: (15) if r1 =3D=3D 0x0 goto pc-26     ; R1_w=3D1
>   104: (bf) r1 =3D r8                     ; R1_w=3D4096 R8=3D4096
>   105: (07) r1 +=3D 8                     ; R1_w=3D4104
>   106: (bf) r2 =3D r1                     ; R1_w=3D4104 R2_w=3D4104
>   107: (67) r2 <<=3D 32                   ; R2_w=3D0x100800000000
>   108: (77) r2 >>=3D 32                   ; R2_w=3D4104
>   109: (25) if r2 > 0x1008 goto pc-32   ; R2_w=3D4104
>   ; ((struct augmented_arg *)payload_offset)->size =3D augment_size; @ au=
gmented_raw_syscalls.bpf.c:504
>   110: (63) *(u32 *)(r9 +0) =3D r8        ; R8=3D4096 R9=3Dmap_value(map=
=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D12376)
>   ; len            +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:506
>   111: (79) r3 =3D *(u64 *)(r10 -24)      ; R3_w=3D12376 R10=3Dfp0 fp-24=
=3D12376
>   112: (0f) r1 +=3D r3                    ; R1_w=3D16480 R3_w=3D12376
>   ; payload_offset +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:507
>   113: (0f) r9 +=3D r2                    ; R2_w=3D4104 R9_w=3Dmap_value(=
map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D16480)
>   114: (b7) r2 =3D 1                      ; R2_w=3D1
>   115: (7b) *(u64 *)(r10 -32) =3D r2      ; R2_w=3D1 R10=3Dfp0 fp-32_w=3D=
1
>   116: (7b) *(u64 *)(r10 -24) =3D r1      ; R1_w=3D16480 R10=3Dfp0 fp-24_=
w=3D16480
>   117: (05) goto pc-40
>   ; for (int i =3D 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:471
>   78: (07) r7 +=3D 8                      ; R7_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272,off=3D48)
>   79: (07) r6 +=3D 4                      ; R6_w=3D16
>   80: (15) if r6 =3D=3D 0x18 goto pc+56     ; R6_w=3D16
>   ; int augment_size =3D beauty_map[i], augment_size_with_header; @ augme=
nted_raw_syscalls.bpf.c:472
>   81: (bf) r1 =3D r4                      ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R4=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D=
24)
>   82: (0f) r1 +=3D r6                     ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D16) R6_w=3D16
>   83: (61) r8 =3D *(u32 *)(r1 +0)         ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D16) R8_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xf=
fffffff,var_off=3D(0x0; 0xffffffff))
>   84: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x7fffff=
ff00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xffffffff00000000))
>   85: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3D0x7fffffff)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   86: (15) if r8 =3D=3D 0x0 goto pc-9       ; R8_w=3Dscalar(smin=3D0xffff=
ffff80000000,smax=3D0x7fffffff,umin=3D1)
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   87: (79) r3 =3D *(u64 *)(r7 +0)         ; R3_w=3Dscalar() R7_w=3Dmap_va=
lue(map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D48)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   88: (15) if r3 =3D=3D 0x0 goto pc-11      ; R3_w=3Dscalar(umin=3D1)
>   ; value_offset =3D ((struct augmented_arg *)payload_offset)->value; @ a=
ugmented_raw_syscalls.bpf.c:479
>   89: (bf) r1 =3D r9                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D16480) R9_w=3Dmap_value(map=3Dbeauty_payl=
oad_,ks=3D4,vs=3D24688,off=3D16480)
>   90: (07) r1 +=3D 8                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D16488)
>   ; if (augment_size =3D=3D 1) { /* string */ @ augmented_raw_syscalls.bp=
f.c:481
>   91: (55) if r8 !=3D 0x1 goto pc-22      ; R8_w=3D1
>   ; augment_size =3D bpf_probe_read_user_str(value_offset, value_size, ad=
dr); @ augmented_raw_syscalls.bpf.c:482
>   92: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   93: (85) call bpf_probe_read_user_str#114     ; R0_w=3Dscalar(smin=3Dsm=
in32=3D-4095,smax=3Dsmax32=3D4096)
>   94: (79) r4 =3D *(u64 *)(r10 -16)       ; R4_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R10=3Dfp0 fp-16=3Dmap_value(map=3Dbeauty_map_ente=
,ks=3D4,vs=3D24)
>   95: (bf) r8 =3D r0                      ; R0_w=3Dscalar(id=3D9,smin=3Ds=
min32=3D-4095,smax=3Dsmax32=3D4096) R8_w=3Dscalar(id=3D9,smin=3Dsmin32=3D-4=
095,smax=3Dsmax32=3D4096)
>   96: (b7) r1 =3D 1                       ; R1_w=3D1
>   ; if (augment_size > value_size) @ augmented_raw_syscalls.bpf.c:496
>   97: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x100000=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   98: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3Dsmax32=3D4096)
>   99: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   100: (6d) if r2 s> r8 goto pc+1       ; R2_w=3D4096 R8_w=3D4096
>   101: (b7) r8 =3D 4096                   ; R8_w=3D4096
>   ; if (is_augmented && augment_size_with_header <=3D sizeof(struct augme=
nted_arg)) { @ augmented_raw_syscalls.bpf.c:503
>   102: (57) r1 &=3D 1                     ; R1=3D1
>   103: (15) if r1 =3D=3D 0x0 goto pc-26     ; R1=3D1
>   104: (bf) r1 =3D r8                     ; R1_w=3D4096 R8=3D4096
>   105: (07) r1 +=3D 8                     ; R1_w=3D4104
>   106: (bf) r2 =3D r1                     ; R1_w=3D4104 R2_w=3D4104
>   107: (67) r2 <<=3D 32                   ; R2_w=3D0x100800000000
>   108: (77) r2 >>=3D 32                   ; R2_w=3D4104
>   109: (25) if r2 > 0x1008 goto pc-32   ; R2_w=3D4104
>   ; ((struct augmented_arg *)payload_offset)->size =3D augment_size; @ au=
gmented_raw_syscalls.bpf.c:504
>   110: (63) *(u32 *)(r9 +0) =3D r8        ; R8=3D4096 R9=3Dmap_value(map=
=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D16480)
>   ; len            +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:506
>   111: (79) r3 =3D *(u64 *)(r10 -24)      ; R3_w=3D16480 R10=3Dfp0 fp-24=
=3D16480
>   112: (0f) r1 +=3D r3                    ; R1_w=3D20584 R3_w=3D16480
>   ; payload_offset +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:507
>   113: (0f) r9 +=3D r2                    ; R2_w=3D4104 R9_w=3Dmap_value(=
map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D20584)
>   114: (b7) r2 =3D 1                      ; R2_w=3D1
>   115: (7b) *(u64 *)(r10 -32) =3D r2      ; R2_w=3D1 R10=3Dfp0 fp-32_w=3D=
1
>   116: (7b) *(u64 *)(r10 -24) =3D r1      ; R1_w=3D20584 R10=3Dfp0 fp-24_=
w=3D20584
>   117: (05) goto pc-40
>   ; for (int i =3D 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:471
>   78: (07) r7 +=3D 8                      ; R7_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272,off=3D56)
>   79: (07) r6 +=3D 4                      ; R6_w=3D20
>   80: (15) if r6 =3D=3D 0x18 goto pc+56     ; R6_w=3D20
>   ; int augment_size =3D beauty_map[i], augment_size_with_header; @ augme=
nted_raw_syscalls.bpf.c:472
>   81: (bf) r1 =3D r4                      ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R4=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D=
24)
>   82: (0f) r1 +=3D r6                     ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D20) R6_w=3D20
>   83: (61) r8 =3D *(u32 *)(r1 +0)         ; R1_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24,off=3D20) R8_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xf=
fffffff,var_off=3D(0x0; 0xffffffff))
>   84: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x7fffff=
ff00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xffffffff00000000))
>   85: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3D0x7fffffff)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   86: (15) if r8 =3D=3D 0x0 goto pc-9       ; R8_w=3Dscalar(smin=3D0xffff=
ffff80000000,smax=3D0x7fffffff,umin=3D1)
>   ;  @ augmented_raw_syscalls.bpf.c:0
>   87: (79) r3 =3D *(u64 *)(r7 +0)         ; R3_w=3Dscalar() R7_w=3Dmap_va=
lue(map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D56)
>   ; if (augment_size =3D=3D 0 || addr =3D=3D NULL) @ augmented_raw_syscal=
ls.bpf.c:476
>   88: (15) if r3 =3D=3D 0x0 goto pc-11      ; R3_w=3Dscalar(umin=3D1)
>   ; value_offset =3D ((struct augmented_arg *)payload_offset)->value; @ a=
ugmented_raw_syscalls.bpf.c:479
>   89: (bf) r1 =3D r9                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D20584) R9_w=3Dmap_value(map=3Dbeauty_payl=
oad_,ks=3D4,vs=3D24688,off=3D20584)
>   90: (07) r1 +=3D 8                      ; R1_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688,off=3D20592)
>   ; if (augment_size =3D=3D 1) { /* string */ @ augmented_raw_syscalls.bp=
f.c:481
>   91: (55) if r8 !=3D 0x1 goto pc-22      ; R8_w=3D1
>   ; augment_size =3D bpf_probe_read_user_str(value_offset, value_size, ad=
dr); @ augmented_raw_syscalls.bpf.c:482
>   92: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   93: (85) call bpf_probe_read_user_str#114     ; R0_w=3Dscalar(smin=3Dsm=
in32=3D-4095,smax=3Dsmax32=3D4096)
>   94: (79) r4 =3D *(u64 *)(r10 -16)       ; R4_w=3Dmap_value(map=3Dbeauty=
_map_ente,ks=3D4,vs=3D24) R10=3Dfp0 fp-16=3Dmap_value(map=3Dbeauty_map_ente=
,ks=3D4,vs=3D24)
>   95: (bf) r8 =3D r0                      ; R0_w=3Dscalar(id=3D10,smin=3D=
smin32=3D-4095,smax=3Dsmax32=3D4096) R8_w=3Dscalar(id=3D10,smin=3Dsmin32=3D=
-4095,smax=3Dsmax32=3D4096)
>   96: (b7) r1 =3D 1                       ; R1_w=3D1
>   ; if (augment_size > value_size) @ augmented_raw_syscalls.bpf.c:496
>   97: (67) r8 <<=3D 32                    ; R8_w=3Dscalar(smax=3D0x100000=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   98: (c7) r8 s>>=3D 32                   ; R8_w=3Dscalar(smin=3D0xffffff=
ff80000000,smax=3Dsmax32=3D4096)
>   99: (b7) r2 =3D 4096                    ; R2_w=3D4096
>   100: (6d) if r2 s> r8 goto pc+1 102: R0_w=3Dscalar(id=3D10,smin=3Dsmin3=
2=3D-4095,smax=3Dsmax32=3D4096) R1_w=3D1 R2_w=3D4096 R4_w=3Dmap_value(map=
=3Dbeauty_map_ente,ks=3D4,vs=3D24) R6_w=3D20 R7_w=3Dmap_value(map=3Daugment=
ed_args_,ks=3D4,vs=3D8272,off=3D56) R8_w=3Dscalar(smin=3D0xffffffff80000000=
,smax=3Dsmax32=3D4095) R9_w=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D2=
4688,off=3D20584) R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmap_value(map=3Dbeauty_=
map_ente,ks=3D4,vs=3D24) fp-24_w=3D20584 fp-32_w=3D1 fp-40=3Dmap_value(map=
=3Daugmented_args_,ks=3D4,vs=3D8272) fp-48=3Dctx() fp-56=3Dmap_value(map=3D=
beauty_payload_,ks=3D4,vs=3D24688)
>   ; if (is_augmented && augment_size_with_header <=3D sizeof(struct augme=
nted_arg)) { @ augmented_raw_syscalls.bpf.c:503
>   102: (57) r1 &=3D 1                     ; R1_w=3D1
>   103: (15) if r1 =3D=3D 0x0 goto pc-26     ; R1_w=3D1
>   104: (bf) r1 =3D r8                     ; R1_w=3Dscalar(id=3D12,smin=3D=
0xffffffff80000000,smax=3Dsmax32=3D4095) R8_w=3Dscalar(id=3D12,smin=3D0xfff=
fffff80000000,smax=3Dsmax32=3D4095)
>   105: (07) r1 +=3D 8                     ; R1_w=3Dscalar(smin=3D0xffffff=
ff80000008,smax=3Dsmax32=3D4103,smin32=3D0x80000008)
>   106: (bf) r2 =3D r1                     ; R1_w=3Dscalar(id=3D13,smin=3D=
0xffffffff80000008,smax=3Dsmax32=3D4103,smin32=3D0x80000008) R2_w=3Dscalar(=
id=3D13,smin=3D0xffffffff80000008,smax=3Dsmax32=3D4103,smin32=3D0x80000008)
>   107: (67) r2 <<=3D 32                   ; R2_w=3Dscalar(smax=3D0x100700=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   108: (77) r2 >>=3D 32                   ; R2_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>   109: (25) if r2 > 0x1008 goto pc-32   ; R2_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D4104,var_off=3D(0x0; 0x1fff))
>   ; ((struct augmented_arg *)payload_offset)->size =3D augment_size; @ au=
gmented_raw_syscalls.bpf.c:504
>   110: (63) *(u32 *)(r9 +0) =3D r8        ; R8_w=3Dscalar(id=3D12,smin=3D=
0xffffffff80000000,smax=3Dsmax32=3D4095) R9_w=3Dmap_value(map=3Dbeauty_payl=
oad_,ks=3D4,vs=3D24688,off=3D20584)
>   ; len            +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:506
>   111: (79) r3 =3D *(u64 *)(r10 -24)      ; R3_w=3D20584 R10=3Dfp0 fp-24_=
w=3D20584
>   112: (0f) r1 +=3D r3                    ; R1_w=3Dscalar(smin=3D0xffffff=
ff80005070,smax=3Dsmax32=3D24687,smin32=3D0x80005070) R3_w=3D20584
>   ; payload_offset +=3D augment_size_with_header; @ augmented_raw_syscall=
s.bpf.c:507
>   113: (0f) r9 +=3D r2                    ; R2_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4104,var_off=3D(0x0; 0x1fff)) R9_w=3Dm=
ap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D20584,smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4104,var_off=3D(0x0; 0x1fff))
>   114: (b7) r2 =3D 1                      ; R2_w=3D1
>   115: (7b) *(u64 *)(r10 -32) =3D r2      ; R2_w=3D1 R10=3Dfp0 fp-32_w=3D=
1
>   116: (7b) *(u64 *)(r10 -24) =3D r1      ; R1_w=3Dscalar(id=3D14,smin=3D=
0xffffffff80005070,smax=3Dsmax32=3D24687,smin32=3D0x80005070) R10=3Dfp0 fp-=
24_w=3Dscalar(id=3D14,smin=3D0xffffffff80005070,smax=3Dsmax32=3D24687,smin3=
2=3D0x80005070)
>   117: (05) goto pc-40
>   ; for (int i =3D 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:471
>   78: (07) r7 +=3D 8                      ; R7_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272,off=3D64)
>   79: (07) r6 +=3D 4                      ; R6_w=3D24
>   80: (15) if r6 =3D=3D 0x18 goto pc+56     ; R6_w=3D24
>   ; if (!bpf_probe_read_user(value_offset, augment_size, addr)) @ augment=
ed_raw_syscalls.bpf.c:491
>   137: (79) r5 =3D *(u64 *)(r10 -24)      ; R5_w=3Dscalar(id=3D14,smin=3D=
0xffffffff80005070,smax=3Dsmax32=3D24687,smin32=3D0x80005070) R10=3Dfp0 fp-=
24=3Dscalar(id=3D14,smin=3D0xffffffff80005070,smax=3Dsmax32=3D24687,smin32=
=3D0x80005070)
>   138: (bf) r2 =3D r5                     ; R2_w=3Dscalar(id=3D14,smin=3D=
0xffffffff80005070,smax=3Dsmax32=3D24687,smin32=3D0x80005070) R5_w=3Dscalar=
(id=3D14,smin=3D0xffffffff80005070,smax=3Dsmax32=3D24687,smin32=3D0x8000507=
0)
>   139: (67) r2 <<=3D 32                   ; R2_w=3Dscalar(smax=3D0x606f00=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   140: (77) r2 >>=3D 32                   ; R2_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>   141: (b7) r1 =3D 1                      ; R1_w=3D1
>   142: (b7) r3 =3D 24689                  ; R3_w=3D24689
>   143: (2d) if r3 > r2 goto pc+1 145: R0=3Dscalar(id=3D10,smin=3Dsmin32=
=3D-4095,smax=3Dsmax32=3D4096) R1=3D1 R2=3Dscalar(smin=3Dsmin32=3D0,smax=3D=
umax=3Dsmax32=3Dumax32=3D24688,var_off=3D(0x0; 0x7fff)) R3=3D24689 R4=3Dmap=
_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D24) R5=3Dscalar(id=3D14,smin=3D0xf=
fffffff80005070,smax=3Dsmax32=3D24687,smin32=3D0x80005070) R6=3D24 R7=3Dmap=
_value(map=3Daugmented_args_,ks=3D4,vs=3D8272,off=3D64) R8=3Dscalar(id=3D12=
,smin=3D0xffffffff80000000,smax=3Dsmax32=3D4095) R9=3Dmap_value(map=3Dbeaut=
y_payload_,ks=3D4,vs=3D24688,off=3D20584,smin=3Dsmin32=3D0,smax=3Dumax=3Dsm=
ax32=3Dumax32=3D4104,var_off=3D(0x0; 0x1fff)) R10=3Dfp0 fp-8=3Dmmmmmmmm fp-=
16=3Dmap_value(map=3Dbeauty_map_ente,ks=3D4,vs=3D24) fp-24=3Dscalar(id=3D14=
,smin=3D0xffffffff80005070,smax=3Dsmax32=3D24687,smin32=3D0x80005070) fp-32=
=3D1 fp-40=3Dmap_value(map=3Daugmented_args_,ks=3D4,vs=3D8272) fp-48=3Dctx(=
) fp-56=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688)
>   ; if (!bpf_probe_read_user(value_offset, augment_size, addr)) @ augment=
ed_raw_syscalls.bpf.c:491
>   145: (79) r2 =3D *(u64 *)(r10 -32)      ; R2_w=3D1 R10=3Dfp0 fp-32=3D1
>   ; if (!do_augment || len > sizeof(struct beauty_payload_enter)) @ augme=
nted_raw_syscalls.bpf.c:511
>   146: (5f) r2 &=3D r1                    ; R1=3D1 R2_w=3D1
>   147: (57) r2 &=3D 1                     ; R2_w=3D1
>   148: (79) r7 =3D *(u64 *)(r10 -48)      ; R7_w=3Dctx() R10=3Dfp0 fp-48=
=3Dctx()
>   149: (79) r8 =3D *(u64 *)(r10 -40)      ; R8_w=3Dmap_value(map=3Daugmen=
ted_args_,ks=3D4,vs=3D8272) R10=3Dfp0 fp-40=3Dmap_value(map=3Daugmented_arg=
s_,ks=3D4,vs=3D8272)
>   150: (79) r4 =3D *(u64 *)(r10 -56)      ; R4_w=3Dmap_value(map=3Dbeauty=
_payload_,ks=3D4,vs=3D24688) R10=3Dfp0 fp-56=3Dmap_value(map=3Dbeauty_paylo=
ad_,ks=3D4,vs=3D24688)
>   151: (55) if r2 !=3D 0x0 goto pc+1      ; R2_w=3D1
>   ; return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURR=
ENT_CPU, data, len); @ augmented_raw_syscalls.bpf.c:162
>   153: (67) r5 <<=3D 32                   ; R5_w=3Dscalar(smax=3D0x606f00=
000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(=
0x0; 0xffffffff00000000))
>   154: (77) r5 >>=3D 32                   ; R5_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>   155: (bf) r1 =3D r7                     ; R1_w=3Dctx() R7_w=3Dctx()
>   156: (18) r2 =3D 0xffffaed2058d9000     ; R2_w=3Dmap_ptr(map=3D__augmen=
ted_sys,ks=3D4,vs=3D4)
>   158: (18) r3 =3D 0xffffffff             ; R3_w=3D0xffffffff
>   160: (85) call bpf_perf_event_output#25
>   R5 unbounded memory access, use 'var &=3D const' or 'if (var < const)'
>   processed 387 insns (limit 1000000) max_states_per_insn 1 total_states =
20 peak_states 20 mark_read 13
>   -- END PROG LOAD LOG --
>   libbpf: prog 'sys_enter': failed to load: -13
>   libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>   libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was=
 it created?)
>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was=
 it created?)
>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was=
 it created?)
>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was=
 it created?)
>   hello
>        0.000 ( 0.008 ms): write(fd: 1, buf: , count: 6)                  =
                       =3D
>
> Also like James said, the buf doesn't show anything and the return
> value is missing.
>
> Thanks,
> Namhyung
>
