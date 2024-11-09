Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31CD2556E;
	Sat,  9 Nov 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173508; cv=none; b=kr7/q0KbWA9Lp8QZ6Wf8+3zHGh2iZrK3d46bS55qVJUbkSQDeDe2sk7ONePJR1Q9zMYM+ddNQ9Tm6v/byhwct/gkJszJoULVln0/0YlWdzocg3tYoRRuvx4RMeoI1rZQDnEmPDEsHISC4a/f8OlUuLN4yxIz062FLfY4bJTkbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173508; c=relaxed/simple;
	bh=pKoq0PIk/eUWc+T+pDnlnNj6Q9RLiqn7dMQWPkG3+W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyPrQgWRIZyTcLOxOwWXhM7kwUcbescTwKh869hlJMLgZEAVSazZ7A6Ql3cNbxxlchYhskn3T19yJuxZV3bqzwShHT7PkAowujrrfRPSmoU1cnPnSML4kPqnTrSbaWdnNnUM3k7ISbwPBgGnVKHefKmb1te5/SXU6YTZPnWMd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvlH/ZT3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvlH/ZT3"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso3168650276.2;
        Sat, 09 Nov 2024 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731173505; x=1731778305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5awZMdR053eh2leXdPVvFEO44yv/RkMtmMrnIFFtKY=;
        b=UvlH/ZT3IWkWSTGitjAGQFus3S8x7WQKysaCo3o6S+Cjg03QYE3IF5cTzieiX6WJts
         Dl1ofzAg8G0U785fV5KoHXoMkv/apf2bRI7/OPMNJqzgeEs1rHuDW2M+90F7WEjufh72
         Ik/ePzEpWWmKSoKxQ201dj7e0pHPECpQIgHKXf6TW70Azn5A8aFuAqwSShb+5JK8NB0+
         H0p6e91zvVmvNZpYa1ffguysrBilmlwqWBQMSCXxQl7XOVMeW3P2JhBQMTsNqVYrN+TR
         uqBKkFwYgmOCFyOFzFrPaE7bOGcMjPSf13LUWzzD00alnFKPTynu0Q48s+Nm//Ks7vhs
         3alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731173505; x=1731778305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5awZMdR053eh2leXdPVvFEO44yv/RkMtmMrnIFFtKY=;
        b=d0pw4eXwOWStS68HKvj5zSMicOrcSsPyuHfueJudjaEQfSjvQd5/puORIYcZWbIqUh
         /unhsb5nckh4hZwEwlHbjOeq2xpa4nr9cht3ZmhX+NR1W3j1i1e970pVx09It9GcHSmc
         zBicfv15w9AYmLGhaFQofFJWs3pusDGqGsc4R8aEZvshQYmpviDsNQ9VOxjOTfA6jjJ5
         K8SnWwYAt6EEXbMniiTLHin6LURg7K4IZNxK31VRznU68dUIha7TpdLGygib/vIutSwn
         8UlRN49CnbiVRnZeLEPMFJW0X6ZO7MwTyLoYS0ZGS4uO3Myon2sDUrMUt6s4YIq4ucDP
         QeRw==
X-Forwarded-Encrypted: i=1; AJvYcCUO3Fp+RVcqmjC75d1JKXcZjfj84LSpgOAVwnNjnrrra29SaR+eMyssGLUE9pEPdFVcPaqQDYgQeJtFd1Y=@vger.kernel.org, AJvYcCXwtVHALlEiMcT3tGS6LImjI8mrCpMYpbsQyN4KNCHU83SadBeS0OVPMzQhBochF9EJdM9W2xgGUqYzHDAuEb1h6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ntFkJi+bynMBPja8n2U560/AIqnuZMbymdObo9mjTEywREEy
	+n1ru3sQIYJ3Kob2AVkqssJBhhwIRuKvJsAaryeG3/nR1z/zx4QWq/n+Af3haUovOcfIuauNp2X
	7Y82TzIAuu+pqosg9SUSIjwegWPY=
X-Google-Smtp-Source: AGHT+IGPG6Sr5/QPGi73zpYxqnQaBqQAsjudJUnWl4RD9qIg2SYqbUfETjNOdqRJZ1yH5t/ZRrXeJqRXZSat4qQwhmY=
X-Received: by 2002:a05:690c:6811:b0:6e7:e340:cd36 with SMTP id
 00721157ae682-6eaddfa4ad6mr55763677b3.40.1731173505385; Sat, 09 Nov 2024
 09:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030052431.2220130-1-howardchu95@gmail.com>
In-Reply-To: <20241030052431.2220130-1-howardchu95@gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 9 Nov 2024 09:31:35 -0800
Message-ID: <CAH0uvoj14TZ2f=ceWL+NFoDdseYg5JR=V6fd5co_XDhvf-2-ww@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Fix perf trace tracing itself, creating
 feedback loops
To: acme@kernel.org, peterz@infradead.org
Cc: namhyung@kernel.org, irogers@google.com, mingo@redhat.com, 
	mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Kindly ping. :)

You can test it simply by using  ./perf trace -e newfstatat
--max-events=3D30 & echo #!  and see if there are pids the same as
echoed, or if there are "perf" in trace messages

     9.321 (         ): perf/3159266 newfstatat(dfd: CWD, filename:
"/proc/3159273/ns/mnt", statbuf: 0x7ffefbfce7b0) ...

Thanks,
Howard

On Tue, Oct 29, 2024 at 10:24=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> There exists a pids_filtered map in augmented_raw_syscalls.bpf.c that
> ceases to provide functionality after the BPF skeleton migration:
> commit 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a skele=
ton")
>
> Before the migration, pid_filtered map works, courtesy of Arnaldo
> Carvalho de Melo <acme@kernel.org>:
>
> =E2=AC=A2 [acme@toolbox perf-tools]$ git log --oneline -5
> 6f769c3458b6cf2d (HEAD) perf tests trace+probe_vfs_getname.sh: Accept quo=
tes surrounding the filename
> 7777ac3dfe29f55d perf test trace+probe_vfs_getname.sh: Remove stray \ bef=
ore /
> 33d9c5062113a4bd perf script python: Add stub for PMU symbol to the pytho=
n binding
> e59fea47f83e8a9a perf symbols: Fix DSO kernel load and symbol process to =
correctly map DSO to its long_name, type and adjust_symbols
> 878460e8d0ff84a0 perf build: Remove -Wno-unused-but-set-variable from the=
 flex flags when building with clang < 13.0.0
>
> root@x1:/home/acme/git/perf-tools# perf trace -e /tmp/augmented_raw_sysca=
lls.o -e write* --max-events=3D30  &
> [1] 180632
> root@x1:/home/acme/git/perf-tools#      0.000 ( 0.051 ms): NetworkManager=
/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                          =
 =3D 8
>      0.115 ( 0.010 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508e=
f70, count: 8)                           =3D 8
>      0.916 ( 0.068 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 246)                         =3D 246
>      1.699 ( 0.047 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 121)                         =3D 121
>      2.167 ( 0.041 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 121)                         =3D 121
>      2.739 ( 0.042 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 121)                         =3D 121
>      3.138 ( 0.027 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 121)                         =3D 121
>      3.477 ( 0.027 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 121)                         =3D 121
>      3.738 ( 0.023 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 121)                         =3D 121
>      3.946 ( 0.024 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 121)                         =3D 121
>      4.195 ( 0.024 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 121)                         =3D 121
>      4.212 ( 0.026 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508e=
f70, count: 8)                           =3D 8
>      4.285 ( 0.006 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508e=
f70, count: 8)                           =3D 8
>      4.445 ( 0.018 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 260)                         =3D 260
>      4.508 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 124)                         =3D 124
>      4.592 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 116)                         =3D 116
>      4.666 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 130)                         =3D 130
>      4.715 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 95)                          =3D 95
>      4.765 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 102)                         =3D 102
>      4.815 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 79)                          =3D 79
>      4.890 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 57)                          =3D 57
>      4.937 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 89)                          =3D 89
>      5.009 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 112)                         =3D 112
>      5.059 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 112)                         =3D 112
>      5.116 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 79)                          =3D 79
>      5.152 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 33)                          =3D 33
>      5.215 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 37)                          =3D 37
>      5.293 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 128)                         =3D 128
>      5.339 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 89)                          =3D 89
>      5.384 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, cou=
nt: 100)                         =3D 100
>
> [1]+  Done                    perf trace -e /tmp/augmented_raw_syscalls.o=
 -e write* --max-events=3D30
> root@x1:/home/acme/git/perf-tools#
>
> No events for the 'perf trace' (pid 180632), i.e. no feedback loop.
>
> If we leave it running:
>
> root@x1:/home/acme/git/perf-tools# perf trace -e /tmp/augmented_raw_sysca=
lls.o -e landlock_add_rule &
> [1] 181068
> root@x1:/home/acme/git/perf-tools#
>
> And then look at what maps it sets up:
>
> root@x1:/home/acme/git/perf-tools# bpftool map | grep pids_filtered -A3
> 1190: hash  name pids_filtered  flags 0x0
>         key 4B  value 1B  max_entries 64  memlock 7264B
>         btf_id 1613
>         pids perf(181068)
> root@x1:/home/acme/git/perf-tools#
>
> And ask for dumping its contents:
>
> We see that we are _also_ setting it to filter those:
>
> root@x1:/home/acme/git/perf-tools# bpftool map dump id 1190
> [{
>         "key": 181068,
>         "value": 1
>     },{
>         "key": 156801,
>         "value": 1
>     }
> ]
>
> Now testing the migration commit:
>
> perf $ git log
> commit 5e6da6be3082f77be06894a1a94d52a90b4007dc (HEAD)
> Author: Ian Rogers <irogers@google.com>
> Date:   Thu Aug 10 11:48:51 2023 -0700
>
>     perf trace: Migrate BPF augmentation to use a skeleton
>
> perf $ ./perf trace -e write --max-events=3D10 & echo #!
> [1] 1808653
>
> perf $      0.000 ( 0.010 ms): :1808671/1808671 write(fd: 1, buf: 0x6003f=
5b26fc0, count: 11)                          =3D 11
>      0.162 (         ): perf/1808653 write(fd: 2, buf: 0x7fffc2174e50, co=
unt: 11)                       ...
>      0.174 (         ): perf/1808653 write(fd: 2, buf: 0x74ce21804563, co=
unt: 1)                        ...
>      0.184 (         ): perf/1808653 write(fd: 2, buf: 0x57b936589052, co=
unt: 5)
>
> The feedback loop is there.
>
> Keep it running, look into the bpf map:
>
> perf $ bpftool map | grep pids_filtered
> 10675: hash  name pids_filtered  flags 0x0
>
> sberf $ bpftool map dump id 10675
> []
>
> The map is empty.
>
> Now, this commit:
> commit 64917f4df048 ("perf trace: Use heuristic when deciding if a syscal=
l tracepoint "const char *" field is really a string")
>
> Temporarily fixed the feedback loop for perf trace -e write, that's
> because before using the heuristic, write is hooked to sys_enter_openat:
>
> perf $ git log
> commit 83a0943b1870944612a8aa0049f910826ebfd4f7 (HEAD)
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Aug 17 12:11:51 2023 -0300
>
>     perf trace: Use the augmented_raw_syscall BPF skel only for tracing s=
yscalls
>
> perf $ ./perf trace -e write --max-events=3D10 -v 2>&1 | grep Reusing
> Reusing "openat" BPF sys_enter augmenter for "write"
>
> And after the heuristic fix, it's unaugmented:
>
> perf $ git log
> commit 64917f4df048a0649ea7901c2321f020e71e6f24 (HEAD)
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Aug 17 15:14:21 2023 -0300
>
>     perf trace: Use heuristic when deciding if a syscall tracepoint "cons=
t char *" field is really a string
>
> perf $ ./perf trace -e write --max-events=3D10 -v 2>&1 | grep Reusing
> perf $
>
> After using the heuristic, write is hooked to syscall_unaugmented, which
> returns 1.
>
> SEC("tp/raw_syscalls/sys_enter")
> int syscall_unaugmented(struct syscall_enter_args *args)
> {
>         return 1;
> }
>
> If the BPF program returns 1, the tracepoint filter will filter it
> (since the tracepoint filter for perf is correctly set), but before the
> heuristic, when it was hooked to a sys_enter_openat(), which is a BPF
> program that calls bpf_perf_event_output() and writes to the buffer, it
> didn't get filtered, thus creating feedback loop. So switching write to
> unaugmented accidentally fixed the problem.
>
> But some syscalls are not so lucky, for example newfstatat:
> perf $ ./perf trace -e newfstatat --max-events=3D100 & echo #!
> [1] 2166948
>
>    457.718 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/pro=
c/self/ns/mnt", statbuf: 0x7fff0132a9f0) ...
>    457.749 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/pro=
c/2166950/ns/mnt", statbuf: 0x7fff0132aa80) ...
>    457.962 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/pro=
c/self/ns/mnt", statbuf: 0x7fff0132a9f0) ...
>
> Currently, write is augmented by the new BTF general augmenter (which
> calls bpf_perf_event_output()). The problem, which luckily got fixed,
> resurfaced, and that=E2=80=99s how it was discovered.
>
> v1:
>
> Currently when tracing system-wide, perf trace will trace itself,
> creating feedback loops. This patch fixes this problem by setting the
> correct BPF map for filtering pids.
>
> Before:
>
> here perf/2807067 is the tracing process itself):
>
> perf $ ./perf trace -e write --max-events=3D10
>      0.000 ( 0.007 ms): tmux: server/2299109 write(fd: 4, buf: \17, count=
: 1)                                      =3D 1 (systemd)
>      0.060 (         ): perf/2807067 write(fd: 2, buf:      0.000 , count=
: 11)                          ...
>      0.072 (         ): perf/2807067 write(fd: 2, buf: (, count: 1)      =
                               ...
>      0.085 (         ): perf/2807067 write(fd: 2, buf:  0.007 ms, count: =
9)                             ...
>      0.089 (         ): perf/2807067 write(fd: 2, buf: ): , count: 3)    =
                               ...
>      0.094 (         ): perf/2807067 write(fd: 2, buf: tmux: server/, cou=
nt: 13)                        ...
>      0.099 (         ): perf/2807067 write(fd: 2, buf: 2299109 , count: 8=
)                              ...
>      0.103 (         ): perf/2807067 write(fd: 2, buf: write(fd: 4, buf: =
\17, count: 1, count: 31)      ...
>      0.108 (         ): perf/2807067 write(fd: 2, buf: )                 =
              , count: 41)     ...
>      0.113 (         ): perf/2807067 write(fd: 2, buf: 1, count: 1)      =
                               ...
>
> After:
>
> perf $ ./perf trace -e write --max-events=3D10
>      0.000 ( 0.030 ms): sshd/2725386 write(fd: 4, buf: r\148\133\163\17\1=
67\194\172bF\231\192\227\194\215\251kBLE\167(\10WY\22\138^\233\28\248\249, =
count: 36) =3D 36 (idle_inject/3)
>      0.622 ( 0.019 ms): sshd/2725386 write(fd: 4, buf: \177"\251\159\244)=
F5\224\250\135Y\1865/\30\191\171\140Q\213\182\133\145\224\148\190L\210{\143=
D, count: 228) =3D
>      9.510 ( 0.014 ms): dirname/2805386 write(fd: 1, buf: /root/.tmux/plu=
gins/tmux-continu, count: 43)        =3D 43 (kauditd)
>      9.788 ( 0.007 ms): bash/2805385 write(fd: 1, buf: /root/.tmux/plugin=
s/tmux-continu, count: 43)        =3D 43 (kauditd)
>     13.865 ( 0.020 ms): :2805390/2805390 write(fd: 1, buf: 1.9\10, count:=
 4)                                   =3D 4 (kworker/R-rcu_g)
>     15.183 ( 0.015 ms): tr/2805391 write(fd: 1, buf: 19, count: 2)       =
                                =3D 2 (kthreadd)
>     15.715 ( 0.009 ms): bash/2805388 write(fd: 1, buf: 19\10, count: 3)  =
                                  =3D 3 (pool_workqueue_)
>     18.755 ( 0.014 ms): tmux/2805393 write(fd: 1, buf: tmux 3.4\10, count=
: 9)                              =3D 9 (kworker/0:0H-ev)
>     19.737 ( 0.044 ms): sshd/2725386 write(fd: 4, buf: \188\197;\82d.1k\1=
97\30\165[L@\153\139\192\173\247k\179kT.m\150\223\216\31\251\255, count: 31=
6) =3D
>     20.173 ( 0.008 ms): bash/2805396 write(fd: 1, buf: tmux 3.4\10, count=
: 9)                              =3D 9 (kworker/0:0H-ev)
>
> Fixes: 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a skele=
ton")
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 748b061f8678..5d83da62275c 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4326,6 +4326,8 @@ static int trace__run(struct trace *trace, int argc=
, const char **argv)
>                                         sizeof(__u32), BPF_ANY);
>                 }
>         }
> +
> +       trace->filter_pids.map =3D trace->skel->maps.pids_filtered;
>  #endif
>         err =3D trace__set_filter_pids(trace);
>         if (err < 0)
> --
> 2.43.0
>
