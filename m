Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793131023;
	b=37+s1OArlLf3bIKiDk18R5C28GoqEFP0Qw3Aa2GRpp5JLboP/rr1XP0DVvdUguT5llhP
	 6gllVGs5jWKXoNinxtpWlDBBUwWQzxemXWbL9aKPARq4PRga6aeIcPqpPX78f0aEGqcjt
	 e0I9T15B0vGf0rGSFzK4r87MWaT4W1mjLUlsPh4nBGwWuBDZyypJnrC25ualxqvfXE+wA
	 ABWWd7/sCjYooZNfVZ20a2AJrONhFlV5iglLzdL6DklKt1Au7LgDYjskHq1Kep6L1Gkj3
	 ix9B6opnGzm9hubkKUNP357hYZhvdS4O+vTajuOWNQ+y5kfhhYEmE9b+2DgMBndnhHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131023;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=D+j8vussuX24sRS6D0PknwPrpWxpe1hpJSMo0M9lmug=;
	b=pLFajTtMSlfuAMdyHR2UyFi6pCbA7bsQR6SUe8gJG2MY2RqVevdbHAoLk+3/pPiVislY
	 qEVHqt6qHZLFzmJCCx+tbGikxA4/Sfd7ffVJfkNe9IcAElSyrwc0Jxo7vQx0Jk8ibac/H
	 /PRUWOFS+wYN1BnfOLN/nYDngP9ZTi+NihkO244U4MsqjxSbPvcVB3PCFOVw3sQjofaDI
	 kxj5bSLW+Mlm0NEEOmNZlHu3G7+cNyhEW3QNJYSxqkzratZs5osQ8MTuAgggLO7KZh3cp
	 HxxjRdESdU8sXBY+JV4ESXz6X/rIzHS7oKEsWRVCNm3YJp+PfrU+ATTWkl8Ss4Ed/EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b5ZgUb4X;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SVXE1DR+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816D4606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 19:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 816D4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b5ZgUb4X;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SVXE1DR+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793131021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+j8vussuX24sRS6D0PknwPrpWxpe1hpJSMo0M9lmug=;
	b=b5ZgUb4XrlB+gO7I7jDwVdOkJgD0gEPUKcd2B12cjCe4ILcor8RcWBW9WJOdp2ZXN8BSCY
	jl5AsbrwlXXdzgcFtvNJjWL148K6YiIJVh/4vKFeLJrUk0rtX6QgMVoOElgDfyAqPcf7h4
	hPCpL+llEcLRDHnxTNqfuvh/4xvzJW0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-DH-g7uEdNDCCVn7_yP3U4A-1; Tue, 27 Oct 2026 15:56:58 -0400
X-MC-Unique: DH-g7uEdNDCCVn7_yP3U4A-1
X-Mimecast-MFC-AGG-ID: DH-g7uEdNDCCVn7_yP3U4A_1793131018
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0af48c18so144299f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 12:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793131017; cv=none;
        d=google.com; s=arc-20260327;
        b=skfaNp3o4jv8wzZ10ixvLUHZQMuZF4jUn8gCUuj9WhA7Ayn6cuEeOZaLIASghUUiis
         GX0QtSrUZ3l6PC29YLaKRdr/otPWXj40+1jrj8mRpRnjJGDYpspkxKr9T4qJS6HD6SOj
         aKVXostaUPrgBUcAFIjssPlpraR3EbwV5UsbJSwhEIRrH885/7LYBse7SftlJv02Pc52
         P3epALx174p4dMkVywvqV2W7qpa3h0pu9QrQY08i2LSfrho1P9kyKnQtcOzSJ2CGadHb
         UPzpHyyNOw5mRD+i7uNtqeTdD1ePR8v1+YZZdpbkmp+VZf3eLHMFOY+eTi5sn3GAJUrQ
         s0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D+j8vussuX24sRS6D0PknwPrpWxpe1hpJSMo0M9lmug=;
        fh=UnkfR9JJWynSpRZv1Gq9Pfw6LQ4U9ANMpRn0WBWeGXQ=;
        b=EUWPRWx23uEXNCkzsEGmTcejid4Vd7w/ZMfz9l+Y3WwxqIv4a1fepDun/+cYN82/uR
         MY7aoXvHcJRv3vLgJAk3Gl9AZ5/NUXI9mEfKYZmMUsfbQqYXOk8uw5O+yT4ixikxBpJZ
         d45uNvNMwZKB8SbZLz6Lx9zxS0NfQRDc5j7S/HTuzokJMtvIyhjD5d4jTMs3G+d1VLEo
         EcnExf/9fPzW8sjiDwCHZeQ97WqF2qorH6B694msMlNa1UBLBLNKGVTyk+zBAasg6rQT
         XYn4jnnllZJNoBAeYbTQbHVwKObb9Zlw5xHvuAXt+4kDp3eRcxRwAzMcPcZluYPBde3r
         mhfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793131017; x=1793735817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D+j8vussuX24sRS6D0PknwPrpWxpe1hpJSMo0M9lmug=;
        b=SVXE1DR+m9o03wVvqdx5FFCzys5kUHb28iyLFscl0NOwn9Ab+MMfkocBkTS4pEHT8z
         pjdCj0vHNGExw4clRXPEN112mM3dUr76eQuoMgU5KmhRnAcLvBzMn5jsd29IpKxLi7jj
         SE7toaowuciM4JOVoOLqn+xqsa/bFQhTCwplkpJDayAUcL7g465Lp0GZeLyC6wAEe3mz
         0fbYaR8dvDCzYVAycw3JgXNw7xEAP6JCJCpDD+ptPUtgljoBGC+LL2WZTyIFRMHWwume
         5xAz8CMLt5BI22zlN+5GwRkGtqR/kxu99Orc+h7VxEiAFmosn6F6SH4nLogEMvduVQgC
         5W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793131017; x=1793735817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+j8vussuX24sRS6D0PknwPrpWxpe1hpJSMo0M9lmug=;
        b=mgx2g/MTSfdyO8dHrfhGYNg+sZnmM2cWKs5fPYj0OV3w29nZTUdptwNrjyKYzgn95u
         juCiAA7K6fJfcIhbc6aP/uScJ2CQ+GjXm4D7W7cL3NrqZbCaG+3QN90ucuUYruXixr7L
         +pUty5uxJp4vhsbGM0D0Vt+qfa5oxL5k1ExvOKRXpPFso0wNIjgDPKWaSomcuUdE9fsn
         Au+YNu2MVeppVMVSI1ySIWwdvVzQAPjlvkOzZKfcHWGDBT5Mf5yZSOKeSX68sDf7FDDJ
         UP+VoOdph0Xcvhy5w/5RWJPKawN8kJv8NH7+TPPnsllK3nuLQN0jED0h+s8J4BHqT3KR
         kHdA==
X-Forwarded-Encrypted: i=1; AKwUvByMj/CZhnCaS5I5r1HVYFvEecLI1RVIRCdgQ73Y22HeZdC3SeEZn/xXiAlXxKY28mpVtoC8PFb3h9QEuy1lIIL/@vger.kernel.org
X-Gm-Message-State: AFq9FYJbzDVaXMSszvOKyMkTb/ahEloOgi/QtOy8LAeDGAnXDxmcEQhE
	Oxn/d9YI17t0ahUkHIWXH6j0MRWmDypc/u6+2Ttf7Ba6uyqpMoH2XfuVDp+zdtPo5KUcWON1La7
	aj6F5OOVBUg3iC1H9HrJa396bfMhdny0W4AR/Ai1ETlpF7aU423GJlc/xwjL1WD7HZmMadCLYHh
	7dCiihJsMT5chUKrmGJF3dsvJVccgGtNBfDasA0Ia17Npeug==
X-Gm-Gg: AYBFou0Clw6gPB2B5UNj6We79wgwtNkzJJdK5DffbzdH4zmM45+Z2N1g6iEjFVWlcFU
	uX3SMT/VyLeCemV90TewqNdc24X5x9O/0o/FkxeHEDC4w5Wm/FMdgrLz2WH2fGRg6hIV/helFOG
	stBCp8LxWCkVvDTchwhSjb7ffkkZyA5yDkTC1ISt7VbdU1WmuMy+PkFoPoK2mOu/atc9S3wVrVO
	iYoSv5wAAwwcdU7Zw==
X-Received: by 2002:a5d:6f04:0:b0:48d:f7ef:cd1d with SMTP id ffacd0b85a97d-48e5d2e7526mr1186675f8f.9.1793131017571;
        Tue, 27 Oct 2026 12:56:57 -0700 (PDT)
X-Received: by 2002:a5d:6f04:0:b0:48d:f7ef:cd1d with SMTP id
 ffacd0b85a97d-48e5d2e7526mr1186634f8f.9.1793131017140; Tue, 27 Oct 2026
 12:56:57 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 27 Oct 2026 15:56:43 -0400
X-Gm-Features: AclHuK-lqklbDhOzhOwUlRaNa3EOHyRR5yyvs5msGAGwIR1j6q2MQbBTAlwUQTU
Message-ID: <CADRr4bcoMn2oq99psho5v3rqvtF0ZamTNGmozb2wMDUns0x4sQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] riscv: Introduce support for hardware break/watchpoints
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	alex@ghiti.fr, aou@eecs.berkeley.edu, palmer@dabbelt.com, pjw@kernel.org, 
	qingfang.deng@linux.dev, shuah@kernel.org, thecharlesjenkins@gmail.com, 
	cp0613@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:39=E2=80=AFAM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> This patchset adds support for hardware breakpoints and watchpoints in th=
e
> RISC-V architecture. The framework is built on top of the perf/ptrace sub=
system
> and the SBI debug trigger extension (Sdtrig).
>
> Single stepping is ready with software support and mc6. Once, icount is f=
ixed, the software
> supported single stepping will be put under a Kconfig option. Until then =
its default.
>
> Virtualization of debug triggers are pending. Patch set is ready but need=
s testing.
>
> Changes from v6:
>   - Rebased to v7.3-rc5
>   - Added HIT0/1 bit check/clear in breakpoint handler with EPC/Bp addres=
s check
>   - Removed dbtr_shmem null check as pointed by Qinfang Deng
>   - Fixed MEM_HI/MEM_LO macros to work both on rv64/32
>   - Changed unsigned long to __u64 from hwdebug state struct and dropped =
packing
>   - Gated HAVE_MIXED_BREAKPOINT_REGS with PERF_EVENTS
>   - Software base single stepping with mcontrol6 trigger type.
>   - icount is still under development.
>   - Moved and and reworked instruction decoding code to a common file.
>   - perf test suite now supported.
>         - Breakpoint overflow signal handler
>         - Breakpoint overflow sampling
>         - Breakpoint accounting (needs sudo)
>         - Watchpoint
>           - Read Only Watchpoint
>           - Write Only Watchpoint
>           - Read / Write Watchpoint
>           - Modify Watchpoint
>   - __test_function in "Breakpoint overflow signal handler" is name noinl=
ine
>   - Fixed warnings from checkpatch.pl --strict
>
> Changes from v5:
>   - Rebased to v7.2-rc6
>   - Simplified Macros in hw_breakpoint.h
>   - Took care of the review comments
>   - Added ptrace support for hardware break/watchpoints (new patch)
>     - PTRACE_GETREGSET/SETREGSET via NT_RISCV_HW_BREAK / NT_RISCV_HW_WATC=
H
>     - PTRACE_GETHBPREGS / SETHBPREGS for direct single-trigger access
>     - HAVE_MIXED_BREAKPOINTS_REGS selected (break/watch share trigger poo=
l)
>     - flush_ptrace_hw_breakpoint / ptrace_hw_copy_thread wired up
>   - Extended selftest to cover ptrace-based hw break/watchpoint paths (ne=
w patch)
>
> Changes from v4:
>   - Rebased to v7.2-rc4
>   - Fixed rv32 build error
>   - Added pr_fmt to print KBUILD_MODNAME
>   - Changed type of shmem_pa to phys_addr_t
>   - Use per_cpu_ptr_to_phys instead of __pa for per-cpu allocated memory
>   - Print successful registration/unregistration message when no error
>   - Added RISC-V DEBUGGING section in MAINTAINERS and added myself as mai=
ntainer
>   - Fixed warnings from checkpatch.pl --strict run
>
> Changes from v3:
>   - Rebased to v7.1-rc3
>   - For watchpoints, check tdata1.hit via SBI_EXT_DBTR_TRIG_READ and keep
>     STVAL-based matching as fallback
>   - Improved watchpoint matching when STVAL reports the lowest accessed a=
ddress
>     for wider memory accesses
>   - Program execute breakpoints with SIZE=3D0 (match any size) to avoid m=
isses
>     with 16-bit/compressed instruction addresses
>   - Updated selftest to avoid deadlock by replacing unbounded sem_wait() =
with
>     sem_timedwait() timeout handling
>   - Updated selftest breakpoint function so it cannot be inlined or optim=
ized away
>
> Changes from v2:
>   - Rebased to v7.0-rc1
>   - Fixed warnings from checkpatch.pl --strict run
>
> Changes from v1:
>   - The patch adding the SBI extension and function IDs is already merged=
; this
>     series builds on top of that
>   - Added breakpoint selftest in tools/testing/selftests/breakpoints/
>
> Specifications:
> ~~~~~~~~~~~~~~
> The SBI debug trigger extension is specified in Chapter 19 of the SBI
> specification:
>   https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0/r=
iscv-sbi.pdf
>
> The Sdtrig ISA is part of the RISC-V debug specification:
>   https://github.com/riscv/riscv-debug-spec
>
> How to use:
> ~~~~~~~~~~~
> OpenSBI:
>   https://github.com/riscv-software-src/opensbi.git
>
> QEMU:
>   https://github.com/qemu/qemu.git
>
> Linux Kernel:
>   Apply these patches on top of v7.3-rc5
>
> How to test:
> ~~~~~~~~~~~
> From the Linux kernel directory, first install the UAPI headers (required=
 on a
> fresh tree so the compiler can locate <asm/ptrace.h> and the new
> NT_RISCV_HW_BREAK/WATCH definitions via KHDR_INCLUDES):
>
>   make headers
>
> Then build the selftest:
>
>   make -C tools/testing/selftests/breakpoints/
>
> This produces breakpoint_test_riscv under the same directory. Load it on =
the
> target and run. Sample output:
>
>   # /apps/breakpoint_test_riscv
>   # [perf_event]: Breakpoint test passed!
>   # [perf_event]: Watchpoint test passed!
>   # [ptrace]: Breakpoint test passed!
>   # ptrace(PTRACE_GETREGSET): Number of watchpoints: 2
>   # ptrace(PTRACE_GETREGSet): addr: 0x82888 control: 0x8080
>   # [ptrace]: Watchpoint test passed!
>   # [hbpregs] breakpoint readback: addr=3D0x10472 type=3D4 len=3D4 ctrl=
=3D0
>   # [hbpregs]: Breakpoint test passed!
>   # [hbpregs] watchpoint readback: addr=3D0x82888 type=3D2 len=3D8 ctrl=
=3D0
>   # [hbpregs]: Watchpoint test passed!
>
> Perf Test Suite:
> ~~~~~~~~~~~~~~~
> ~ # /apps/perf test -v 16 17 18 19
>  16: Breakpoint overflow signal handler           : Ok
>  17: Breakpoint overflow sampling                 : Ok
>  18: Breakpoint accounting                        : Ok
>  19: Watchpoint                                   :
>  19.1: Read Only Watchpoint                       : Ok
>  19.2: Write Only Watchpoint                      : Ok
>  19.3: Read / Write Watchpoint                    : Ok
>  19.4: Modify Watchpoint                          : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 3
> Passed subtests   : 4
> Skipped tests     : 0
> Failed tests      : 0

Thanks for these fixes! Sorry for the late reply.
If I dont review the next set within week send me an email to remind me.
It might also be a good idea to add icount like I did here
https://github.com/Mr-Bossman/linux/commit/eb0dbb8f87fe7e5df49d6f562ccff409=
7c41f362

Thanks,
Jesse Taube

> Himanshu Chauhan (8):
>   riscv: Introduce support for hardware break/watchpoints
>   riscv: Add breakpoint and watchpoint test for riscv
>   riscv: ptrace support for hardware break/watchpoints
>   selftests/breakpoints: extend riscv test for ptrace hw
>     break/watchpoints
>   RISC-V: Add fetch and decode helpers to a common file
>   riscv: Add software supported single stepping with mc/mc6 triggers
>   perf tests: add noinline to __test_function
>   MAINTAINERS: Add entry for RISC-V Debugging
>
>  MAINTAINERS                                   |  11 +
>  arch/riscv/Kconfig                            |   3 +
>  arch/riscv/include/asm/hw_breakpoint.h        | 331 +++++++
>  arch/riscv/include/asm/insn.h                 |  15 +
>  arch/riscv/include/asm/kdebug.h               |   3 +-
>  arch/riscv/include/asm/processor.h            |  18 +
>  arch/riscv/include/uapi/asm/ptrace.h          |  50 +
>  arch/riscv/kernel/Makefile                    |   1 +
>  arch/riscv/kernel/hw_breakpoint.c             | 879 ++++++++++++++++++
>  arch/riscv/kernel/process.c                   |   5 +
>  arch/riscv/kernel/ptrace.c                    | 507 ++++++++++
>  arch/riscv/kernel/traps.c                     |   6 +
>  arch/riscv/kernel/traps_misaligned.c          |  52 +-
>  arch/riscv/lib/Makefile                       |   1 +
>  arch/riscv/lib/insn.c                         | 263 ++++++
>  include/uapi/linux/elf.h                      |   4 +
>  tools/include/uapi/linux/elf.h                |   2 +
>  tools/perf/tests/bp_signal.c                  |   2 +-
>  tools/testing/selftests/breakpoints/Makefile  |   5 +
>  .../breakpoints/breakpoint_test_riscv.c       | 769 +++++++++++++++
>  20 files changed, 2874 insertions(+), 53 deletions(-)
>  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
>  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
>  create mode 100644 arch/riscv/lib/insn.c
>  create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test_r=
iscv.c
>
> --
> 2.43.0
>

