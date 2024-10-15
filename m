Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614561B6D13;
	Tue, 15 Oct 2024 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022340; cv=none; b=tkzHN+G8uGd7ia54P6mhg4YmqsjG1r0CWKSTXYML9De9wQrF5xlbXrVPkwN1aETu3KLhsBAUxtAq+lhuqhAXUL0g159cJV1htgLy04IB7Q8o5IpuZ5J4FjEIPQYFZcsRelhf6If8bASrolYrYM/ROS4Sd2eb9Ls0nAI7IO5S58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022340; c=relaxed/simple;
	bh=42f2cDVCTVN2U0GsGFbasWWywSZmux7a9WruFjV5vU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7p/SFl6eTLXwNZCWP0T73ysSlEWOfCEoQm1oXBACRCq++awjDCU8UeP+KcgD6FSJ4Fm51oFfjX2AHSsDBVrkNLEOQ9HX223m6stOdxjEDLrD4TjwI6P1xifE2cIE3jzVTiMy4UWqRJ9+NxK5In8JJrK5hUkaYe2aqi0jONiDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL8Br/xO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL8Br/xO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E696FC4CEC6;
	Tue, 15 Oct 2024 19:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729022340;
	bh=42f2cDVCTVN2U0GsGFbasWWywSZmux7a9WruFjV5vU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PL8Br/xOOJAZgFi4hWMLFLAuFSaCSLoPUk6WmA4u2rGsKSQDm5pyFKAHixRv3p2OB
	 11qrWC1v+ytKdE6fpRNyw94qXFjYGn5Bv6GCZ4K5u5mOyDBF/lrixEQy4ggTCp0xB4
	 dIcI9YWqSyA9rZUbzUjJfiRstk3RYzjwLYCtTYx/yClH41LyHzFdPvmLE3giBMYVyW
	 eCZ645AYjMXAVfUiUl4efcs8Y2GRBFltTORt1I5vmWKBfGnRrL2AjFfvDLE5lDwL26
	 J0CLqM7hfmsZHNg7WQ4DI8XILiNqQwNqDrR+/BaRTypBr5DZ0enNkaizDCw8eu7mrA
	 TnC6+Ssi+jnDQ==
Date: Tue, 15 Oct 2024 16:58:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Howard Chu <howardchu95@gmail.com>,
	ndrea Righi <andrea.righi@linux.dev>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, james.clark@linaro.org,
	alan.maguire@oracle.com
Subject: Re: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature
 in clang 12
Message-ID: <Zw7JgJc0LOwSpuvx@x1>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com>
 <Zw7D9HXBanPLUO4G@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw7D9HXBanPLUO4G@x1>

On Tue, Oct 15, 2024 at 04:35:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 15, 2024 at 11:32:45AM -0700, Namhyung Kim wrote:
> > On Thu, Oct 10, 2024 at 07:14:00PM -0700, Howard Chu wrote:
> > > Howard Chu (2):
> > >   perf build: Change the clang check back to 12.0.1
> > >   perf trace: Rewrite BPF code to pass the verifier
>  
> > Tested with clang 16.  And I think it's better to change the order of
> > the commits so it can fix the problem first and then check the version.
 
> So, I tested it on a RHEL8 system and it gets built with clang 17 but
> then fails to load, the verifier complains about lack of bounds checking
> for the index of the syscall array, with or without this last patch from
> Howard.
 
> I also simplified it to a more minimal version withour renaming
> variables, so that we see what exactly fixed the problem, its available
> at the perf-tools/tmp.perf-tools branch, I've talked about it with
> Howard over chat.

Just to give more details, without the following patch:

[acme@dell-per740-01 perf-tools]$ git diff
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 3b30aa74a3ae..873fa738530b 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -485,7 +485,8 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
                        if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
                                augmented = true;
                } else if (size < 0 && size >= -6) { /* buffer */
-                       index = -(size + 1);
+                       //index = -(size + 1);
+                       index = 0;
                        aug_size = args->args[index];
 
                        if (aug_size > TRACE_AUG_MAX_BUF)
[acme@dell-per740-01 perf-tools]$

We end up with:

; } else if (size < 0 && size >= -6) { /* buffer */
111: (b7) r1 = -6
112: (2d) if r1 > r9 goto pc-22
 R0=map_value(id=0,off=0,ks=4,vs=24688,imm=0) R1_w=inv-6 R2=invP40 R3=inv(id=0) R4=map_value(id=0,off=112,ks=4,vs=24688,imm=0) R6=map_value(id=0,off=20,ks=4,vs=24,imm=0) R7=map_value(id=0,off=56,ks=4,vs=8272,imm=0) R8=invP6 R9=inv(id=0,umin_value=18446744073709551610,var_off=(0xffffffff00000000; 0xffffffff)) R10=fp0 fp-8=mmmmmmmm fp-16=map_value fp-24=map_value fp-32=map_value fp-40=invP40 fp-48=ctx fp-56=map_value fp-64=inv1 fp-72=map_value fp-80=map_value
; index = -(size + 1);
113: (a7) r9 ^= -1
114: (67) r9 <<= 32
115: (77) r9 >>= 32
; aug_size = args->args[index];
116: (67) r9 <<= 3
117: (79) r1 = *(u64 *)(r10 -32)
118: (0f) r1 += r9
last_idx 118 first_idx 111
regs=200 stack=0 before 117: (79) r1 = *(u64 *)(r10 -32)
regs=200 stack=0 before 116: (67) r9 <<= 3
regs=200 stack=0 before 115: (77) r9 >>= 32
regs=200 stack=0 before 114: (67) r9 <<= 32
regs=200 stack=0 before 113: (a7) r9 ^= -1
regs=200 stack=0 before 112: (2d) if r1 > r9 goto pc-22
regs=202 stack=0 before 111: (b7) r1 = -6
 R0=map_value(id=0,off=0,ks=4,vs=24688,imm=0) R1=inv1 R2=invP40 R3=inv(id=0) R4=map_value(id=0,off=112,ks=4,vs=24688,imm=0) R6=map_value(id=0,off=20,ks=4,vs=24,imm=0) R7=map_value(id=0,off=56,ks=4,vs=8272,imm=0) R8=invP6 R9_r=invP(id=0,smin_value=-2147483648,smax_value=0) R10=fp0 fp-8=mmmmmmmm fp-16=map_value fp-24=map_value fp-32_r=map_value fp-40=invP40 fp-48=ctx fp-56=map_value fp-64=inv1 fp-72=map_value fp-80=map_value
parent didn't have regs=200 stack=0 marks
last_idx 85 first_idx 85
regs=200 stack=0 before 85: (6d) if r1 s> r9 goto pc+25
 R0_w=map_value(id=0,off=0,ks=4,vs=24688,imm=0) R1_rw=invP1 R2_w=invP40 R3_rw=inv(id=0) R4_w=map_value(id=0,off=112,ks=4,vs=24688,imm=0) R6_rw=map_value(id=0,off=20,ks=4,vs=24,imm=0) R7_rw=map_value(id=0,off=56,ks=4,vs=8272,imm=0) R8_rw=invP6 R9_rw=invP(id=0,smin_value=-2147483648,smax_value=4096) R10=fp0 fp-8=mmmmmmmm fp-16_rw=map_value fp-24_rw=map_value fp-32_r=map_value fp-40_rw=invP40 fp-48_r=ctx fp-56_r=map_value fp-64_rw=invP1 fp-72_r=map_value fp-80_r=map_value
parent already had regs=202 stack=0 marks
119: (79) r9 = *(u64 *)(r1 +16)
 R0=map_value(id=0,off=0,ks=4,vs=24688,imm=0) R1_w=map_value(id=0,off=0,ks=4,vs=8272,umax_value=34359738360,var_off=(0x0; 0x7fffffff8),s32_max_value=2147483640,u32_max_value=-8) R2=invP40 R3=inv(id=0) R4=map_value(id=0,off=112,ks=4,vs=24688,imm=0) R6=map_value(id=0,off=20,ks=4,vs=24,imm=0) R7=map_value(id=0,off=56,ks=4,vs=8272,imm=0) R8=invP6 R9_w=invP(id=0,umax_value=34359738360,var_off=(0x0; 0x7fffffff8),s32_max_value=2147483640,u32_max_value=-8) R10=fp0 fp-8=mmmmmmmm fp-16=map_value fp-24=map_value fp-32=map_value fp-40=invP40 fp-48=ctx fp-56=map_value fp-64=inv1 fp-72=map_value fp-80=map_value
R1 unbounded memory access, make sure to bounds check any such access
processed 549 insns (limit 1000000) max_states_per_insn 3 total_states 27 peak_states 27 mark_read 16

With it (which is not a fix, I'm just using it to narrow down what
calculation the compiler is generating code the verifier in that kernel
dislikes):

[root@dell-per740-01 ~]# ~acme/bin/perf trace -e *sleep* sleep 1.234567890
     0.000 (1234.696 ms): sleep/3852601 nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 234567890 })                  = 0
[root@dell-per740-01 ~]# 

So I'm trying adding extra bounds checking, marking the index as
volatile, adding compiler barriers, etc, all the fun with the verifier,
but got distracted with other stuff, coming back to this now.

Ok, the following seems to do the trick:

[acme@dell-per740-01 perf-tools]$ git diff
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 3b30aa74a3ae..ef87a04ff8d0 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -486,6 +486,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
                                augmented = true;
                } else if (size < 0 && size >= -6) { /* buffer */
                        index = -(size + 1);
+                       index &= 7; // To satisfy the bounds checking with the verifier in some kernels
                        aug_size = args->args[index];
 
                        if (aug_size > TRACE_AUG_MAX_BUF)

I'll now test it without Howard's patch to see if it fixes the RHEL8 +
clang 17 case.

- Arnaldo
 
> Song Liu reproduced the problem (unsure with what clang and kernel
> versions) and couldn't find a way to fix it using the usual tricks to
> coax clang to keep the bounds checking for the verifier to get
> satisfied.
> 
> More generally I'll use virtme-ng[1] to test with a wider range of
> kernels, not just clang versions.
> 
> - Arnaldo
> 
> [1] https://kernel-recipes.org/en/2024/virtme-ng/
