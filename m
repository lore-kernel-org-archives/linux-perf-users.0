Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A881C13D516
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511811; cv=none; b=O/dsQuu4XaVcwBYnhIBp+/Oc8p827zevn8dVHroGaxQndwoh4Q3OgOKQDtkVspm1ayL7E1DuF4xSvODIDB6EzHClFC0TFGLAwrK2EvgRko6nodIDNDguiJ7CoQ9ik9ycGdELAaJBhiUxIMkVCP45QGQYM8snYKppqf+lt5BugEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511811; c=relaxed/simple;
	bh=WYFRjaORBa24P6bJZfXehjaO3smdBPIQQHpRr65TSQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6OKMRHYo4vx3O3Y4+opPDzbR2BmGvu2PDKjvvyQvCG/cxEzXYZ6Z6F6uLNrcXywkQbf54WhggfTMGKyeK8omFFJwpT0bC6SM+ifyYbyRngduEtx1VwwQ0ANVFfS5uXJ23WdDHLCMOK824q1KRwKIRbyetPNs0nqSh8oqGv6FMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrgYmT7f; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrgYmT7f"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6efc58fae20so24036077b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Dec 2024 11:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733511808; x=1734116608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75CbnrG3XCtc4wopp1RFJYGFRN9piMOxcoXmJ0Z+xqI=;
        b=UrgYmT7fJ289LhBmVpS/pjKxhqxO3jbkD2+se3kYnw6JTQ1r4JlLT6qUHpyCm8SbPD
         g5/kytqsxkHSM3FbEBge5CytqbZy5ob4adMOJ2gW8XoxeCNcwTSRIr3cYI8cAfyA1mxa
         wTHj/QLMyEYPElVz39jASi/vsZa2eucJbl2JPKOH9AsIlusSgpaEKdb2vhbwBWE1Xvjz
         o6mkerAEqqqBmQSaTCTWG9NHkR3KTX6BsLjyYrRAO+xeiqAR6OrEbRrSqqRd7gZXVUn+
         9rYuXnwz4QWlpdIkzscVZ0oG64QBP6kxSmh8N8dKwX1Gf4KZMIrFGfG5BeI8kcfZmW70
         eJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511808; x=1734116608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75CbnrG3XCtc4wopp1RFJYGFRN9piMOxcoXmJ0Z+xqI=;
        b=dj5f8owy4PELVwFUPDjeez6eXtArryU5ry7zpPTxBDhsokcGnTlZ4b12bP1glJewZJ
         5AqDPJAFXqPKQfOuhZRoE5vRXDiimYpCL7jLT2sxmpepIU46e0kX2TOSE5FudvXEiiBV
         BRkR+l68SGHz3u9Bra4kFQes8nTSQDSVc8QQu4XHf+1ybnv250femxqZpLOHp6MYkqCW
         n2lwK5F5twhEGPVTvTj52lT0hc9eNgxTAMpLD/rirO8DysAr2/EsUG/OHpDNWL7KT8vU
         q3p3JBZ8Cvf6+CvbbtbIg9qPcelyuxAiV9FnSH5XYBkrovY94N8U5PqWKZIDFmnGUgfN
         K/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVmI5dRGnN5xvJXb/Pnpzn7pXydRRtA/OlE+CkTMSb+Q106+OU76trCa/s+o1L2S/pxyN2D6UGq/mVTZ3sK/t+C@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4Okd8U7Bp62ezAz64ea5PibJ34S6o4u7IdYX/OARJv6KHvlu
	AS2MNQmKlLdZZIrTfJ8BFGjon1LLNmzP0A3dCbBDJBFL8LLg/xpe8Y/0Ihoo4f2CxwS1YJZdFgk
	l+uzD/9pvLGiRKsl7AIcAXhSXMwc=
X-Gm-Gg: ASbGncu55HnuLrDbpj1A546rG+Hwr9/Y0RFPW9BoG0BhRRHJ0BYxzpde9wgOrh8rrXo
	XGXlTucAJG7evPDpWeemsmpmw7WMCh9FF
X-Google-Smtp-Source: AGHT+IERNNm/E4ChTPNmV78Y05bBucnBalQ0X9gJNw1nAi6D4JvleIqA5cH49y9EEJ96eVcU+TKm/fQDjmyt6ft4P1I=
X-Received: by 2002:a05:690c:9686:b0:6ef:7d51:eba6 with SMTP id
 00721157ae682-6efe3c6fad2mr55583767b3.28.1733511808557; Fri, 06 Dec 2024
 11:03:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206001436.1947528-1-namhyung@kernel.org> <CA+JHD90D86YC=Kn3P_B1xLamxKS9+_zOxmKxXMWyTDQGwGnNsQ@mail.gmail.com>
 <CAM9d7ciJjat3fSFEy8PpAa2Q+1=FfkoOFW=5cneAWeS5-e_1Qw@mail.gmail.com>
 <CAATMXfkk4VHyrzwdKfFiRaQbgPN=-EJ5-gf3n2G6Tq=qTNdTRQ@mail.gmail.com> <CAH0uvoiG4pXYip9NWGaLK9V5se3_TcVRvoY-Yj46KfO+GTMw4Q@mail.gmail.com>
In-Reply-To: <CAH0uvoiG4pXYip9NWGaLK9V5se3_TcVRvoY-Yj46KfO+GTMw4Q@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 6 Dec 2024 11:03:19 -0800
Message-ID: <CAH0uvojjyEm0Ezf6sXXvykzjtD9JxijTCNr=8WGGT_r6Fyu_FQ@mail.gmail.com>
Subject: Re: [BUG] perf trace: failed to load -E2BIG
To: Qiao Zhao <qzhao@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forgot to mention clang-13 gave unbounded memory access too:

ffffffff,var_off=3D(0x0; 0xffffffff))
R9=3Dscalar(id=3D14,smin=3Dumin=3Dumin32=3D2,smax=3Dumax=3D0xffffffff,var_o=
ff=3D(0x0;
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

Kernel:

perf $ uname -r
6.11.0-061100-generic

Thanks,
Howard

On Fri, Dec 6, 2024 at 10:36=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hi Qiao, Namhyung, and Arnaldo,
>
> Apologies. I observed the same issue and tested perf with trace BPF
> skel generated by clang-13 to clang-18, turns out BPF skelw generated
> by clang version <=3D clang-16 are not loadable, with clang-15 and -16
> showing the same error as yours. Additionally, the BPF verifier is
> running longer than usual to process the instructions.
>
> perf $ ./perf trace -e write --max-events=3D1
> libbpf: prog 'sys_enter': BPF program load failed: Argument list too long
> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int sys_enter(struct syscall_enter_args *args) @
> augmented_raw_syscalls.bpf.c:527
> 0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
> ; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:423
> ...
> 140: (79) r7 =3D *(u64 *)(r10 -48)      ; R7_w=3Dctx() R10=3Dfp0 fp-48=3D=
ctx()
> 141: (79) r0 =3D *(u64 *)(r10 -56)
> BPF program is too large. Processed 1000001 insn
> processed 1000001 insns (limit 1000000) max_states_per_insn 28
> total_states 37670 peak_states 330 mark_read 16
> -- END PROG LOAD LOG --
> libbpf: prog 'sys_enter': failed to load: -7
> libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -7
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> Not enough memory to run!
>
> For clang-14 however, I encountered an unbounded memory access:
>
> perf $ ./perf trace -e write --max-events=3D1
> libbpf: prog 'sys_enter': BPF program load failed: Permission denied
> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int sys_enter(struct syscall_enter_args *args) @
> augmented_raw_syscalls.bpf.c:527
> 0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
> ; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:423
> 1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
> 2: (63) *(u32 *)(r10 -4) =3D r0         ; R0_w=3Dscalar() R10=3Dfp0 fp-8=
=3Dmmmm????
> 88: (79) r1 =3D *(u64 *)(r10 -16)       ;
> R1_w=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D112) R10=
=3Dfp0
> fp-16=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,off=3D112)
> 89: (bf) r2 =3D r9                      ;
> R2_w=3Dscalar(id=3D14,smin=3Dumin=3Dumin32=3D2,smax=3Dumax=3D0xffffffff,v=
ar_off=3D(0x0;
> 0xffffffff)) R9=3Dscalar(id=3D14,smin=3Dumin=3Dumin32=3D2,smax=3Dumax=3D0=
xffffffff,var_off=3D(0x0;
> 0xffffffff))
> 90: (85) call bpf_probe_read_user#112
> R2 unbounded memory access, use 'var &=3D const' or 'if (var < const)'
> processed 490 insns (limit 1000000) max_states_per_insn 2 total_states
> 23 peak_states 23 mark_read 15
> -- END PROG LOAD LOG --
> libbpf: prog 'sys_enter': failed to load: -13
> libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> Not enough memory to run!
>
> I thought I had tested them, but apparently I didn=E2=80=99t. My apologie=
s
> again, and fixes are on the way.
>
> Thanks,
> Howard
