Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047A18D620;
	Fri, 18 Oct 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729289809; cv=none; b=qauMANJ05sd3/t3RTRblbAOJLcz0eX0iD18+8v+ezysbdjKpY75GCeo8+c5dksNShzjBD2v95jOxjAKNy00yE7Z0Mdk7pKXuVNHKzJUlOszxzHtp+zTEcjyk0XkX3OrEDwgV1rHYACHRh3pIZqyVhSn2O9NNgMrAOxFWJRsXIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729289809; c=relaxed/simple;
	bh=5dHJfEm//35pWwhcN2KEO86KY/+VX4OyM6ATgjJuFow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC2yzLMg64wBp3JpUpXAFybn226rl/z4GKwH81iycQXt3p3QJ2+CK04XIw/4P3fLAWrt+Nj7zQ10H8Jv/Vx6NJo+cbdXQjvluB5z5sPDUIHNLHemq+t0feueOLr1C5NDbJC75W7KGWalbFOzDglhgIqydBJpyIkHl6JCOivwZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmSIL0OO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmSIL0OO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126A7C4CEC6;
	Fri, 18 Oct 2024 22:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729289808;
	bh=5dHJfEm//35pWwhcN2KEO86KY/+VX4OyM6ATgjJuFow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmSIL0OOaHObtvUoi1O1SZEQYGAT80cUtx+ys1Qt124zMTIxotskyKvZx0U7Ty+E2
	 VNy50yirarmymG1aWuK17ZJaHUC2VUZQXVfXGpysL20keMuxedkHalbBsfudxA8AVE
	 ozsKZnBkm+pHsRtvKlrMmcHmTaw2BPL7MSUYx5mMnmsnz2sqLThXT82ksdLLo4D4qS
	 ID+fDk+YluZJmohUwt6Cg0j0JIOVdzR588qBX+QuYoFrmtjbvBgkOM04PrmKRDm8xJ
	 UltiyoccabinhZl5Of4JYPm0QyrTQ58F7D1+HLWGNU5PNjofPM8Rux2wWdjvZWoYYZ
	 sjwb2ZVG4XUfg==
Date: Fri, 18 Oct 2024 19:16:43 -0300
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
Message-ID: <ZxLeS7CQFIR8lTmo@x1>
References: <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
 <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
 <ZwgAzde-jVyo4cSu@google.com>
 <ZwgBenahw7EImQLk@google.com>
 <ZwhA1SL706f60ynd@x1>
 <2a91f9d0-8950-4936-9776-7ba59ab1d42a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a91f9d0-8950-4936-9776-7ba59ab1d42a@kernel.org>

On Mon, Oct 14, 2024 at 02:19:58PM +0200, Jiri Slaby wrote:
> On 10. 10. 24, 23:02, Arnaldo Carvalho de Melo wrote:
> > On Thu, Oct 10, 2024 at 09:31:54AM -0700, Namhyung Kim wrote:
> > > On Thu, Oct 10, 2024 at 09:29:01AM -0700, Namhyung Kim wrote:
> > > > On Thu, Oct 10, 2024 at 10:22:12AM +0200, Jiri Slaby wrote:
> > > > > Subject: [PATCH] perf: fix non-listed archs

> > > > > Suggested-by: Howard Chu <howardchu95@gmail.com>
> > > > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>

> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > Also with,
> > > Fixes: 7a2fb5619cc1fb53 ("perf trace: Fix iteration of syscall ids in syscalltbl->entries")
> > > > Arnaldo, can you please pick this up for v6.12?

> > Sure, probably the safest bet now, but just in case, Jiri, can you test
> > the following?

> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Subject: [PATCH 1/1] perf tools arm: Generate syscalltbl.c from arm's syscall.tbl
> 
> With this:
> +++ b/tools/perf/Makefile.config
> @@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
>  ifneq ($(NO_SYSCALL_TABLE),1)

So after merging your changes (thanks) and finding an arm 32-bit system
(ressurecting a raspberry pi 3), I can build it, with bpf skels, etc but
then...

; } else if (size > 0 && size <= value_size) { /* struct */
83: (bf) r1 = r9
84: (07) r1 += -1
85: (67) r1 <<= 32
86: (77) r1 >>= 32
87: (25) if r1 > 0xfff goto pc+23
 R0_w=map_value(id=0,off=0,ks=4,vs=24688,imm=0) R1_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R2_w=map_value(id=0,off=16,ks=4,vs=8272,imm=0) R3_w=inv(id=0) R6_w=map_value(id=0,off=20,ks=4,vs=24,imm=0) R7_w=map_value(id=0,off=56,ks=4,vs=8272,imm=0) R8_w=invP6 R9_w=inv(id=27,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=mmmmmmmm fp-16_w=map_value fp-24=map_value fp-32_w=invP40 fp-40=ctx fp-48=map_value fp-56_w=inv1 fp-64_w=map_value fp-72=map_value fp-80=map_value
; if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
88: (79) r1 = *(u64 *)(r10 -16)
89: (bf) r2 = r9
90: (85) call bpf_probe_read_user#112
 R0_w=map_value(id=0,off=0,ks=4,vs=24688,imm=0) R1_w=map_value(id=0,off=112,ks=4,vs=24688,imm=0) R2_w=inv(id=27,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R3_w=inv(id=0) R6_w=map_value(id=0,off=20,ks=4,vs=24,imm=0) R7_w=map_value(id=0,off=56,ks=4,vs=8272,imm=0) R8_w=invP6 R9_w=inv(id=27,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=mmmmmmmm fp-16_w=map_value fp-24=map_value fp-32_w=invP40 fp-40=ctx fp-48=map_value fp-56_w=inv1 fp-64_w=map_value fp-72=map_value fp-80=map_value
R2 unbounded memory access, use 'var &= const' or 'if (var < const)'
processed 497 insns (limit 1000000) max_states_per_insn 2 total_states 23 peak_states 23 mark_read 15
-- END PROG LOAD LOG --
libbpf: prog 'sys_enter': failed to load: -13
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13

Back at playing games with the BPF verifier:

root@aquarius:~# uname -a
Linux aquarius 5.10.103-v7+ #1529 SMP Tue Mar 8 12:21:37 GMT 2022 armv7l GNU/Linux
root@aquarius:~# clang-13 --version
Raspbian clang version 13.0.1-6~deb10u4+rpi1 (172.17.3.10:/build/git/l/llvm-toolchain-13 5bdfde6d6808bed4396414f7000db3d958040453)
Target: arm-unknown-linux-gnueabihf
Thread model: posix
InstalledDir: /usr/bin
root@aquarius:~#

Will continue chasing windmills tomorrow...

- Arnaldo
