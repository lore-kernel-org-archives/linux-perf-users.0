Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5F1D54F2
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510180; cv=none; b=DIieEZTbyKfH4Wb8faDLTjO6GTRTjlQTfs0MqtGYyyWek8G7ZhfySklHhn5c1XPHH3NJdoE9GEsFDBda+Aykllg0WQE7+8xcHa1lvnIqbYA8LF/MTt9ika4rTeCaS7vdTy9JznKDaIohe5FM4mdBHezlJMP2UCYsc7q6wn5SeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510180; c=relaxed/simple;
	bh=ywR7gksW+CmY0XZWNM5A0E01aV0sfKqukr+YjP7RssI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/c3Y9DMJEyzbBxE+XDD3Ufw+3kZe0gGGxagNn/6dcA69AyeygfCGmgS/uE1qBkiWW/gEtqtVNh4wdPUEde+WCzrvRGVrW506sv6nNnrYrMZA9JelerqKvbpXtW3IdoR2p0Txd3DevRCKngIZ2KTGKpU6Do+q8+SF1eTO1bJJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8WFzcTN; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8WFzcTN"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eeca160f14so17725487b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Dec 2024 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733510178; x=1734114978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQxq4sxx3TGnAxOtffM/2h1uUK8phHedU+42sQVWrFA=;
        b=G8WFzcTNONnG7S6Ir8Xs5PzrlaOfeDshAegs+AdCss/NMRjsVHF5BxZFGiHzUtzo5i
         9+FLqnddvsNLSb27QeaZsgXNd0rKGRbMa+vMqHm3xH8pOyX53gV2Z5dr1wTdGweppK8n
         FkRhXgOVw3oQ0YcJuHnVV/dt/Rn3SMC3x543Dy1I/lF/DqZbbjb8JJS9k21VP2Pzn52O
         ulttr3977CcN3PQgnH912rmZ3B/1uM/i3Rr/o8ivIEXgBRQylQZ0+bnWeN4f9I88BMuo
         VB82XVkG58OaR6beE6mkm+lePU/DIylifxRkGum5lvBuekhnSx/yGoflNEjADsxsfi7a
         X8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510178; x=1734114978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQxq4sxx3TGnAxOtffM/2h1uUK8phHedU+42sQVWrFA=;
        b=QPZ97J9E8pP0KhjmKbdezEvpvHkhRCf5RourizPrGful7Chdhg2t3k5bNxlliQti+g
         BUbYCXsl0ZHmXk6OW5hN6Xzx6sCfBtS775j3I7hkatC5qSIKjII3OEAbqAiL12l3k3Qo
         RQ3BZsXJzYe8XWEU6r2kuqMK2xiLGG0PYgQ/NZkKLl7Mupp+/tcWFMKIWAZeVwDvpcA9
         W6FfLIqcba3FOrlrDnf/s8hKeos+DQydunb9Jl0rCHAZwjnehXX6tGixjGGMQJDEBvrA
         +WM8jWYUbacnvL7B1JT/Vow4m4TIDgttAMRObsxPQQ6a7jQTLlXLl6ZrlQBZpBTaxZz9
         P0yA==
X-Forwarded-Encrypted: i=1; AJvYcCUndz4pillJkoIUecouJZnOUye9m55CbLOosY0MiC1UK5OWVlQebwcZNqSJlLHZ53Mnmbd6aCXstSM4Njg8fmWg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrp1D7z/yiOwjqYQzjR9I6M8QnPuT2VFyFLkk90Eew6CgudRyF
	/qaTd2BRofEZJ9rJ87ZNtRVk1yMEZUg5l4n5wwf2gRgU9Mg7anm6tM/Cd79itakXoQpreWHEmtm
	dPN7YwP2nXFt4xGFET3RRxQhheJPez/Grd1c=
X-Gm-Gg: ASbGnct3IkZ1V5YrBlWn3R7gvwZ+C31OdMfVvtRfh9xmA794uO73aysY6YLHNiCRmxP
	SvSLurm9fkpbO7+YS7f9/Lg+Re6yOo6xt
X-Google-Smtp-Source: AGHT+IGHZP/YEEuyx1EnTKnikM4Cn6WsFNdL458UJ5LgX2Za65iDJFIGUY0RIdyHzURwPmOUlE6PjJJPD8wAD25TFLc=
X-Received: by 2002:a05:690c:317:b0:6ef:96f8:b607 with SMTP id
 00721157ae682-6efe3cb5cc9mr44343037b3.30.1733510177824; Fri, 06 Dec 2024
 10:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206001436.1947528-1-namhyung@kernel.org> <CA+JHD90D86YC=Kn3P_B1xLamxKS9+_zOxmKxXMWyTDQGwGnNsQ@mail.gmail.com>
 <CAM9d7ciJjat3fSFEy8PpAa2Q+1=FfkoOFW=5cneAWeS5-e_1Qw@mail.gmail.com> <CAATMXfkk4VHyrzwdKfFiRaQbgPN=-EJ5-gf3n2G6Tq=qTNdTRQ@mail.gmail.com>
In-Reply-To: <CAATMXfkk4VHyrzwdKfFiRaQbgPN=-EJ5-gf3n2G6Tq=qTNdTRQ@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 6 Dec 2024 10:36:08 -0800
Message-ID: <CAH0uvoiG4pXYip9NWGaLK9V5se3_TcVRvoY-Yj46KfO+GTMw4Q@mail.gmail.com>
Subject: Re: [BUG] perf trace: failed to load -E2BIG
To: Qiao Zhao <qzhao@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qiao, Namhyung, and Arnaldo,

Apologies. I observed the same issue and tested perf with trace BPF
skel generated by clang-13 to clang-18, turns out BPF skelw generated
by clang version <=3D clang-16 are not loadable, with clang-15 and -16
showing the same error as yours. Additionally, the BPF verifier is
running longer than usual to process the instructions.

perf $ ./perf trace -e write --max-events=3D1
libbpf: prog 'sys_enter': BPF program load failed: Argument list too long
libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; int sys_enter(struct syscall_enter_args *args) @
augmented_raw_syscalls.bpf.c:527
0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:423
...
140: (79) r7 =3D *(u64 *)(r10 -48)      ; R7_w=3Dctx() R10=3Dfp0 fp-48=3Dct=
x()
141: (79) r0 =3D *(u64 *)(r10 -56)
BPF program is too large. Processed 1000001 insn
processed 1000001 insns (limit 1000000) max_states_per_insn 28
total_states 37670 peak_states 330 mark_read 16
-- END PROG LOAD LOG --
libbpf: prog 'sys_enter': failed to load: -7
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -7
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
Not enough memory to run!

For clang-14 however, I encountered an unbounded memory access:

perf $ ./perf trace -e write --max-events=3D1
libbpf: prog 'sys_enter': BPF program load failed: Permission denied
libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; int sys_enter(struct syscall_enter_args *args) @
augmented_raw_syscalls.bpf.c:527
0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:423
1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
2: (63) *(u32 *)(r10 -4) =3D r0         ; R0_w=3Dscalar() R10=3Dfp0 fp-8=3D=
mmmm????
88: (79) r1 =3D *(u64 *)(r10 -16)       ;
R1_w=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D112) R10=3Df=
p0
fp-16=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D112)
89: (bf) r2 =3D r9                      ;
R2_w=3Dscalar(id=3D14,smin=3Dumin=3Dumin32=3D2,smax=3Dumax=3D0xffffffff,var=
_off=3D(0x0;
0xffffffff)) R9=3Dscalar(id=3D14,smin=3Dumin=3Dumin32=3D2,smax=3Dumax=3D0xf=
fffffff,var_off=3D(0x0;
0xffffffff))
90: (85) call bpf_probe_read_user#112
R2 unbounded memory access, use 'var &=3D const' or 'if (var < const)'
processed 490 insns (limit 1000000) max_states_per_insn 2 total_states
23 peak_states 23 mark_read 15
-- END PROG LOAD LOG --
libbpf: prog 'sys_enter': failed to load: -13
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD
(was it created?)
Not enough memory to run!

I thought I had tested them, but apparently I didn=E2=80=99t. My apologies
again, and fixes are on the way.

Thanks,
Howard
