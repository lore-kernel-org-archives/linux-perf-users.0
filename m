Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79ABE46
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446171; cv=none; b=bPnnAgwXa1MQ+xAwse0IWN2s4rl2ZLG5IJzTTL1j8O3GaBzLDnqyWvdqvAqRegYVOVPcj04oxX39W+G+jhuPd41sU2Kcix0veN+rEQ9SWQ5RPJEMBzizZiioReykm84VuqdU+HkSht0jRbfXA3U3cVJ+47YlGjB2MawYJ+YI8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446171; c=relaxed/simple;
	bh=DCj/SPDhzZWR6LudWSEz9Wrn+7vnRXA2BSjveC2m/5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzDm8pLP/RL5BTR/pfmXZTvddaRfXPQmPzxSkU/WlMQsSjf9gmIZfUBsG7TwJJFyQP5LwLx5odBE+RgnKdC5AwI/inVv4YHJU/Xh/JqBsj9cXdoQHp6npdWEmrN1nnoGqx/3sz03q9udJh54TJkOC8aMxc/IXfkNwJCl3Rv3ebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2eed4fa2b3aso1232289a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 16:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733446169; x=1734050969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8ONmeTOrww7ECprK/FO1SLLh9/r1A5RYPnx3xRyO3M=;
        b=B/GTEk7jsYkRCbWkHV2eUphzMYzf/tL3Wt0W7ldqBiJwS/in2NsK0Dg+ycGM+XmlbM
         Q9AEojBGM+9pz0Hihb5MjQ8em9QpvwwZv5NoTfXfFjEVh9e4Jwi+M0uxHC36H5KPccpY
         jgDTl781X+oKT3E3gD/K6XP5m/Tr5IyvoiuT4MQE4vv5+DLCzcaPqnm5lw6DJQvgj5Sm
         Nh8U1kpyXpbznKeUCsqu8TIKUObk3AzFSM9hdwLN9Bc5ZcCLvNW/+F9p/psFGAbr/dJQ
         JZ4KIg4oEdcwL+1E3xJ/SvQyYp2Zwf395pqgZGfickhjSEQ0TJe3q+WYFfJiv53tuIbI
         MMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVapLfAGfq1ZFGgb9itD3dr2HlAgo/colsF/Jc+CGLdRbwReHkoeuPsGaCvlClx1n9OvWVHVaWWrp8xpM+lqXC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb65wAt74ELDcaT1uv8TyqSt8oXULW81Drbev/bEw3TDcr0a3Z
	5QVRaj+qb4+8ieS90bcm5gR3Ltxc+crBnuUGm0BpQJWckCGeOGRBQNXaxXtR9tzx49HSiU8ZrF4
	E2B/Cx2/Y8GFSS04Ngxxc7rbY7kM=
X-Gm-Gg: ASbGnct7AHeOPXS9ytna/26IUj8ls1Ik/73KCv+tktaYgCJxgoJVcN0WfKVFTiFdjiK
	4qxppFNNKNUOnHgM9JG1EZugz5rbMzqhX
X-Google-Smtp-Source: AGHT+IGgFMbRU/PNZAZFcHGscOHTdmxJ4Lt0r5pvQMyotwf5SOm5WZ28ewA38iqQ2gXUB9/0JkmNbEEq8IC+IgGo3WE=
X-Received: by 2002:a17:90b:1dcf:b0:2ee:d96a:5816 with SMTP id
 98e67ed59e1d1-2ef69e16decmr1627065a91.10.1733446168870; Thu, 05 Dec 2024
 16:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206001436.1947528-1-namhyung@kernel.org> <CA+JHD90D86YC=Kn3P_B1xLamxKS9+_zOxmKxXMWyTDQGwGnNsQ@mail.gmail.com>
In-Reply-To: <CA+JHD90D86YC=Kn3P_B1xLamxKS9+_zOxmKxXMWyTDQGwGnNsQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 5 Dec 2024 16:49:17 -0800
Message-ID: <CAM9d7ciJjat3fSFEy8PpAa2Q+1=FfkoOFW=5cneAWeS5-e_1Qw@mail.gmail.com>
Subject: Re: [BUG] perf trace: failed to load -E2BIG
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:19=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Thu, Dec 5, 2024, 9:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>>
>> Hello,
>>
>> I'm seeing the following error in the current perf-tools[-next].
>> Do you see you the same?
>
> Nope, what's your environment?  Kernel version, clang, etc.

It's a debian derivative and the kernel is v6.9.10 and clang 16.0.6.
But I cannot reproduce it anymore after the bisect. :(
Maybe it's a transient kernel bug.

>
> I think we should and that I'm addition to the verifier error log.

I think the below is the verifier log and I cut it out as it repeated.
It seems the verifier fell into a loop for some reason and thought
the program had too many instructions.

Thanks,
Namhyung

>
>  - Arnaldo
>
>>
>>   $ sudo ./perf trace -a sleep 1
>>   libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
>>   libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>   0: R1=3Dctx() R10=3Dfp0
>>   ; int sys_enter(struct syscall_enter_args *args) @ augmented_raw_sysca=
lls.bpf.c:527
>>   0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
>>   ; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:42=
3
>>   1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
>>   2: (63) *(u32 *)(r10 -4) =3D r0         ; R0_w=3Dscalar() R10=3Dfp0 fp=
-8=3Dmmmm????
>>   3: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
>>   ;  @ augmented_raw_syscalls.bpf.c:0
>>   4: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
>>   ; return bpf_map_lookup_elem(pids, &pid) !=3D NULL; @ augmented_raw_sy=
scalls.bpf.c:428
>>   ...
>>   140: (79) r7 =3D *(u64 *)(r10 -48)      ; R7_w=3Dctx() R10=3Dfp0 fp-48=
=3Dctx()
>>   141: (79) r0 =3D *(u64 *)(r10 -56)
>>   BPF program is too large. Processed 1000001 insn
>>   processed 1000001 insns (limit 1000000) max_states_per_insn 28 total_s=
tates 37670 peak_states 330 mark_read 16
>>   -- END PROG LOAD LOG --
>>   libbpf: prog 'sys_enter': failed to load: -E2BIG
>>   libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>>   libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2B=
IG
>>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (wa=
s it created?)
>>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (wa=
s it created?)
>>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (wa=
s it created?)
>>   libbpf: map '__augmented_syscalls__': can't use BPF map without FD (wa=
s it created?)
>>   Not enough memory to run!
>>
>> The git bisect found this but I couldn't find anything suspicious.
>>
>> 395d38419f1853decab84acc16176b3fa5c96690 is the first bad commit
>> commit 395d38419f1853decab84acc16176b3fa5c96690
>> Author: Howard Chu <howardchu95@gmail.com>
>> Date:   Thu Oct 10 19:14:02 2024 -0700
>>
>>     perf trace augmented_raw_syscalls: Add more checks to pass the verif=
ier
>>
>>     Add some more checks to pass the verifier in more kernels.
>>
>>     Signed-off-by: Howard Chu <howardchu95@gmail.com>
>>     Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>>     Cc: Alan Maguire <alan.maguire@oracle.com>
>>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>     Cc: Ian Rogers <irogers@google.com>
>>     Cc: Ingo Molnar <mingo@redhat.com>
>>     Cc: Jiri Olsa <jolsa@kernel.org>
>>     Cc: Kan Liang <kan.liang@linux.intel.com>
>>     Cc: Mark Rutland <mark.rutland@arm.com>
>>     Cc: Namhyung Kim <namhyung@kernel.org>
>>     Cc: Peter Zijlstra <peterz@infradead.org>
>>     Link: https://lore.kernel.org/r/20241011021403.4089793-3-howardchu95=
@gmail.com
>>     [ Reduced the patch removing things that can be done later ]
>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>>  .../perf/util/bpf_skel/augmented_raw_syscalls.bpf.c  | 20 +++++++++++++=
+++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>> bisect found first bad commit
>>
>> Thanks,
>> Namhyung
>>
