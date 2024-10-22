Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051CD1A0AF2;
	Tue, 22 Oct 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610321; cv=none; b=HmBPqyiJ5oh5bcTqm0CDHQ0fXsX/f/iODjJANCemtgmx9+milRPWPBScxl5a+oLxNsg6FVTUaBTvgcQoHttMfYnP0q+4JX0FN4ZInjn22AdrmifzBRMEbZKh7UCxStId+XPf+xi9B7vYuqpuxR5V8UK0Y1YFFPmKzlLWZl4LS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610321; c=relaxed/simple;
	bh=CSfYJ73PoiHlK1B0hKxExTw/zBdaJ8h97t83JEP4vOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqsmIwyrVnxVdqcX6rtPcKnYZHiyL8rq7C5JRr4H0RF3vDvgor3IKeSb8M3DLWjDZ33AF0+Ocb8z2KVaiOAfQA8RNZRpqapTq5kRW/xEfgbJNlHH+Blq5WKIhHapIpz2+T9MPn8ylKOSg7g0zExyxLUIOZEtioZRtkA4VkuaGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia0qI+D1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia0qI+D1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8E7C4CEC3;
	Tue, 22 Oct 2024 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729610320;
	bh=CSfYJ73PoiHlK1B0hKxExTw/zBdaJ8h97t83JEP4vOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ia0qI+D1EDfyaNJVL+fRWbBSkEXT/Hf4e/YmdoysJc0jMwlVAOiZgbnsZSlZ7vaYP
	 pePNKvK1friTwMrZwjbixyog/B8cku6tVImzqRz7NJsP5LqZsDeDBxTfWjkkcdOAj9
	 5+YOovUpAoj8qU4mghPGrs1bOUjZ2PPjwXA3ur2oh/iqLtmcwYH1RG+nM7VDXMsOSk
	 mSaByG0Sill0fXVbYEkyjBbMmWvE/jwpKsEIQE5bH4LOWAYpa2PDTKanrNrhoFxB1Y
	 TecH9QD+2l+3oe6pJNSYgKErAIKTffRavwQqSdusSy6uRlhT6sHk+b5iemBzGvkDHk
	 x8PtTFGYwvtSw==
Date: Tue, 22 Oct 2024 12:18:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
Message-ID: <ZxfCTG76hvFaSxzi@x1>
References: <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
 <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
 <ZwgAzde-jVyo4cSu@google.com>
 <ZwgBenahw7EImQLk@google.com>
 <ZwhA1SL706f60ynd@x1>
 <2a91f9d0-8950-4936-9776-7ba59ab1d42a@kernel.org>
 <ZxLeS7CQFIR8lTmo@x1>
 <ZxLglVIivPk05c97@x1>
 <744634f0-5010-4465-85cd-0df79506f5d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <744634f0-5010-4465-85cd-0df79506f5d9@kernel.org>

On Mon, Oct 21, 2024 at 07:43:50AM +0200, Jiri Slaby wrote:
> On 19. 10. 24, 0:26, Arnaldo Carvalho de Melo wrote:
> > root@aquarius:~# ls -la /sys/kernel/debug/tracing/events/syscalls
> > ls: cannot access '/sys/kernel/debug/tracing/events/syscalls': No such file or directory
> 
> Doesn't 5.10 have /sys/kernel/tracing/events/syscalls yet?

The config for rpi doesn't have, I had to install bookworm, 6.6 based
kernel, then rebuild it after enabling DWARF, BTF,
CONFIG_FTRACE_SYSCALLS and then it works, I was able to do some initial
testing of my patch:

root@raspberrypi:~# ~acme/bin/perf trace -e write,read cat /etc/passwd |& tail
saned:x:109:120::/var/lib/saned:/usr/sbin/nologin
vnc:x:992:992:vnc:/nonexistent:/usr/sbin/nologin
colord:x:110:121:colord colour management daemon,,,:/var/lib/colord:/usr/sbin/nologin
hplip:x:111:7:HPLIP system user,,,:/run/hplip:/bin/false
acme:x:1000:1000:,,,:/home/acme:/bin/bash
     0.000 ( 0.035 ms): read(fd: 3, buf: 0x7efde570, count: 512)                              = 512
     0.256 ( 0.011 ms): read(fd: 3, buf: 0x7efde108, count: 512)                              = 512
     1.153 ( 0.019 ms): read(fd: 3, buf: 0x76939000, count: 131072)                           = 1851
     1.179 ( 0.043 ms): write(fd: 1, buf: , count: 1851)                                      = 1851
     1.227 ( 0.006 ms): read(fd: 3, buf: 0x76939000, count: 131072)                           = 0
root@raspberrypi:~#

root@raspberrypi:~# ~acme/bin/perf --version
perf version 6.12.rc3.g0f709a2d7be1

root@raspberrypi:~# ls -la /sys/kernel/tracing/events/syscalls/
Display all 760 possibilities? (y or n)^C
root@raspberrypi:~# uname -a
Linux raspberrypi 6.6.57-v7+ #1 SMP Mon Oct 21 20:55:20 -03 2024 armv7l GNU/Linux
root@raspberrypi:~# head /etc/debian_version 
12.7
root@raspberrypi:~#

Now I'm back dabbling with the BPF verifier in various kernels,
including this 6.6 arm7 32-bit one:

root@raspberrypi:~# clang --version
Raspbian clang version 14.0.6
Target: arm-unknown-linux-gnueabihf
Thread model: posix
InstalledDir: /usr/bin
root@raspberrypi:~# 

root@raspberrypi:~# ~acme/bin/perf trace -e clock_nanosleep,nanosleep sleep 1.23456 |& tail -20
83: (bf) r1 = r9                      ; R1_w=scalar(id=13,umax=4294967295,var_off=(0x0; 0xffffffff)) R9_w=scalar(id=13,umax=4294967295,var_off=(0x0; 0xffffffff))
84: (07) r1 += -1                     ; R1_w=scalar(smin=-1,smax=4294967294)
85: (67) r1 <<= 32                    ; R1_w=scalar(smax=9223372032559808512,umax=18446744069414584320,var_off=(0x0; 0xffffffff00000000),s32_min=0,s32_max=0,u32_max=0)
86: (77) r1 >>= 32                    ; R1=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
87: (25) if r1 > 0xfff goto pc+23     ; R1=scalar(umax=4095,var_off=(0x0; 0xfff))
; if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
88: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=map_value(off=112,ks=4,vs=24688,imm=0) R10=fp0 fp-16=map_value
89: (bf) r2 = r9                      ; R2_w=scalar(id=13,umax=4294967295,var_off=(0x0; 0xffffffff)) R9=scalar(id=13,umax=4294967295,var_off=(0x0; 0xffffffff))
90: (85) call bpf_probe_read_user#112
R2 unbounded memory access, use 'var &= const' or 'if (var < const)'
processed 490 insns (limit 1000000) max_states_per_insn 2 total_states 23 peak_states 23 mark_read 15
-- END PROG LOAD LOG --
libbpf: prog 'sys_enter': failed to load: -13
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
     0.000 (1234.739 ms): clock_nanosleep(rqtp: 0x7ea35adc, rmtp: 0x7ea35ad4)                   = 0
root@raspberrypi:~#

So the original problem, that you reported, i.e. not being able to build
on 32-bit arm seems to be mostly gone, I need to do some more tests with
globbing, i.e.:

root@raspberrypi:~# ~acme/bin/perf trace -e *anosleep sleep 1.23456 |& tail
processed 490 insns (limit 1000000) max_states_per_insn 2 total_states 23 peak_states 23 mark_read 15
-- END PROG LOAD LOG --
libbpf: prog 'sys_enter': failed to load: -13
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
     0.000 (1234.730 ms): clock_nanosleep(rqtp: 0x7ef0cadc, rmtp: 0x7ef0cad4)                   = 0
root@raspberrypi:~#

Ah, it is working, lets try something else:

root@raspberrypi:~# ~acme/bin/perf trace -e open*
<BIG SNIP>
  6245.506 ( 0.018 ms): (udev-worker)/14286 openat(dfd: 13, filename: 0xd6bac0, flags: RDONLY|CLOEXEC|LARGEFILE|PATH|0x20000) = 6
  6245.570 ( 0.018 ms): (udev-worker)/14286 openat(dfd: 6, filename: 0xd6bac0, flags: RDONLY|CLOEXEC|LARGEFILE|PATH|0x20000) = 13
  6245.713 ( 0.017 ms): (udev-worker)/14286 openat(dfd: CWD, filename: 0x5097c0, flags: RDONLY|CLOEXEC|DIRECTORY|PATH|0x20000) = 6
  6245.755 ( 0.016 ms): (udev-worker)/14286 openat(dfd: 6, filename: 0xceb5d8, flags: RDONLY|CLOEXEC|LARGEFILE|PATH|0x20000) = 13
  6245.815 ( 0.018 ms): (udev-worker)/14286 openat(dfd: 13, filename: 0xceb5d8, flags: RDONLY|CLOEXEC|LARGEFILE|PATH|0x20000) = 6
  6246.269 ( 0.049 ms): (udev-worker)/14286 openat(dfd: CWD, filename: 0x7eb10620, flags: RDONLY|CLOEXEC|NOCTTY|0x20000) = 6
  6246.466 ( 0.032 ms): (udev-worker)/14286 openat(dfd: CWD, filename: 0x7eb10630, flags: RDONLY|CLOEXEC|0x20000) = 6
^Croot@raspberrypi:~# 

Yeah, works.

So to summarize: the patch I sent and you filled in the missing bits,
that is in perf-tools/tmp.perf-tools was tested on arm v7, 32-bit, on a
Raspberry PI 3 and it builds and then when tested, works:

acme@raspberrypi:~/git/linux $ git log --oneline torvalds/master..
0f709a2d7be1 (HEAD -> perf-tools, perf-tools/perf-tools) perf trace arm32: Fix iteration of syscall ids in syscalltbl->entries
2c881b312117 perf trace augmented_raw_syscalls: Add more checks to pass the verifier
6a6c689b7540 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
44c1d54d4d26 perf build: Change the clang check back to 12.0.1
39c6a356201e perf trace: The return from 'write' isn't a pid
ab8aaab874c4 tools headers UAPI: Sync linux/const.h with the kernel headers
acme@raspberrypi:~/git/linux $

Now I need to go back to the augmented_raw_syscall.bpf.o problems here
and there, probably will just push what I have (listed above) and leave
it soak in linux-next so that I can send to Linus, as it improves the
current situation.

- Arnaldo
 
> Alternatively, isn't debugfs mounted elsewhere on debian? (Or mounted at
> all?)
> 
> > Unsure where to find the config used to build this kernel:
> > 
> > root@aquarius:~# uname -a
> > Linux aquarius 5.10.103-v7+ #1529 SMP Tue Mar 8 12:21:37 GMT 2022 armv7l GNU/Linux
> > root@aquarius:~#
> > 
> > normally is in /boot/ but I'm no debian user, ideas?
> 
> Won't something dpkg -L linux-image tell you (I haven't used deb for years)?
> 
> Looking into:
> https://ftp.debian.org/debian/pool/main/l/linux/linux-image-5.10.0-0.deb10.16-armmp_5.10.127-2~bpo10+1_armhf.deb
> 
> the config should really live in /boot.
> 
> -- 
> js
> suse labs
