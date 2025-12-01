Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89CA214A64
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579817; cv=none; b=elLSV+jprNv3GU9MlJOTyk4/ctjsRHTifkhUH6c3ESck7v2pnlUHl+HZBK6UavA1y1CB+RBLuDzDpanRUhjqSw1yylOUzrMocKJo5dQ6RDXKhJdSYVi48ZE5qcaD+C0h9EiRp0tABr/p9ZQwGz2yUt+x5qH4VRGk/z1v1WAUeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579817; c=relaxed/simple;
	bh=mgTGFwU21jChK71fnm+vsqp++tDIFTiz0dlboFWwSvQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIkTX/XBs03r9G6PxiVqV7aijvmsuPVzOQSBUIPzQdoh6fOl4qWNUOAVOivXHlzD0/RGKoiWA2i12gk/FwwHEtizY+/avboO7iS18Da27heguycdFu+Cki0F8uTbjpzNyrsC0hiRVujDdac1lO1qeuX89pN1IKAax3E7/LRB5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso2293131a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 01:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764579815; x=1765184615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLNuQKjPOA0n1znwyGymt124hlYaJVP20j2wWabaTIA=;
        b=vpT/Rhl8r3NXgyeubTc0yABrXIKUKxyVrHDBp1MrXlDkDZ1XBXDqK0s1zY18oUh+jk
         sK8Zf8/EptzjG1xP1NAzYbCCQHnjqOywZ0IArEp1SRGeqFd4qojx662ZHfs2XTaqndFL
         5Fkv1PzF93a02UhwztO2XM0nI8mhaHuRXXNhBPNum7JWiiSm3z/L6nnCYBeuInxQ4ivT
         CuOo9GsDaWscKq3/QqTlEjbdtbdhBs7djqGOv1DBDhM+Fe9nyr7d0ekNdsun4Y0KPoCq
         jkBcUs33fX3ozgzTvDHZeYNxk6wE6LP78vEdb4wzKOKaVvyyXs0j6z0R/kvC6WmVwwi1
         Bs6g==
X-Forwarded-Encrypted: i=1; AJvYcCURcPjA/Xl5j4q7hon8RUPbNxKK5oQCwNBZE2lww2rNncb1gSK7srewxryBOx6M37isw1Obh5tqND/oZoHRDgOC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sovif7DEl95tUR81PgQi1FWOVODngqtBInqNRsAl4QTCo4Ux
	e96W4CZO51WPkTV//hnklA1z1QZQmqMxNla/a75N20YnC1T19/EoBfUF
X-Gm-Gg: ASbGnctEPpl5/X6ky2r20lnfGOPfPUpCtA3D7ZqzQW6Cy3f9Ba/fwkWvwOzXWD7L8yt
	M3jnsCyHfDUCOA0A/EC0Zn9LChg2lKnndj2855IBz8d2l7MOsQqcLmBXMPr3Ox0SH+rQoQGGpPw
	+TBOBI8PzNGRBqTaX07IBPisAFnQTKZqmz4SzGkeax+m0UthjlcACmuUPu1NnkxP82hqFkIt3bE
	beuB9kCqtm+HXZhqd7H2mH0XHhgn9cGO2tF8qNRMwoFFJgh1Fs0nQyvSyinizUBmsyeN6RP6k+D
	CHEr4mL0b0NXQUg0hBjhcMAfG/J4DvCxKvbQ9HsD4TLqH0LRRb+WygoXeQB641HsrNcyKmtFmXg
	NYD2w/VUAryewTm17s5WRV3LrcxVc/ZadEDQwMT7CLyEJDfTjVgOEqAtNUMiojEVklU7spVMY
X-Google-Smtp-Source: AGHT+IFyl25CUESq4JqVuiQGgYwPzg0f/Ns83h0XJ+WFwiBBLUrZbV6J/ngeY1BqBYkgEpa6HLjinw==
X-Received: by 2002:a05:7022:7a5:b0:11b:7dcd:ca9a with SMTP id a92af1059eb24-11cbba523cbmr19746405c88.34.1764579814838;
        Mon, 01 Dec 2025 01:03:34 -0800 (PST)
Received: from localhost ([2601:647:4d84:e760::40ef])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm68752160c88.1.2025.12.01.01.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:03:34 -0800 (PST)
Date: Mon, 1 Dec 2025 01:04:02 -0800
From: Fangrui Song <maskray@sourceware.org>
To: linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <szxvulfrq5j5cbvqoli5pc63vhxj4o37f3qoextjxlap4cqcmg@4zv3kotuo2ke>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>


On 2025-10-29, Fangrui Song wrote:
>I've been following the SFrame discussion and wanted to share some concerns about its viability for userspace adoption, based on concrete measurements and comparison with existing compact unwind implementations in LLVM.
>
>**Size overhead concerns**
>
>Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is approximately 10% larger than the combined size of .eh_frame and .eh_frame_hdr (8.06 MiB total).
>This is problematic because .eh_frame cannot be eliminated - it contains essential information for restoring callee-saved registers, LSDA, and personality information needed for debugging (e.g. reading local variables in a coredump) and C++ exception handling.
>
>This means adopting SFrame would result in carrying both formats, with a large net size increase.
>
>**Learning from existing compact unwind implementations**
>
>It's worth noting that LLVM has had a battle-tested compact unwind format in production use since 2009 with OS X 10.6, which transitioned to using CFI directives in 2013 [1]. The efficiency gains are dramatic:
>
>  __text section: 0x4a55470 bytes
>  __unwind_info section: 0x79060 bytes (0.6% of __text)
>  __eh_frame section: 0x58 bytes
>
>  (On macOS you can check the section size with objdump --arch x86_64 -h clang and dump the unwind info with  objdump --arch x86_64 --unwind-info clang)
>
>OpenVMS's x86-64 port, which is ELF-based, also adopted this format as documented in their "VSI OpenVMS Calling Standard" and their 2018 post: https://discourse.llvm.org/t/rfc-asynchronous-unwind-tables-attribute/59282
>
>The compact unwind format achieves this efficiency through a two-level page table structure. It describes common frame layouts compactly and falls back to DWARF only when necessary, allowing most DWARF CFI entries to be eliminated while maintaining full functionality. For more details, see: https://faultlore.com/blah/compact-unwinding/ and the lld/MachO implemention https://github.com/llvm/llvm-project/blob/main/lld/MachO/UnwindInfoSection.cpp
>
>**The AArch64 case: size matters even more**
>
>The size consideration becomes even more critical for AArch64, which is heavily deployed on mobile phones.
>There's an active feature request for compact unwind support in the AArch64 ABI: https://github.com/ARM-software/abi-aa/issues/344
>This underscores the broader industry need for efficient unwind information that doesn't duplicate data or significantly increase binary size.
>
>There are at least two formats the ELF one can learn from: LLVM's compact unwind format (aarch64) and Windows ARM64 Frame Unwind Code.
>
>**Path forward**
>
>Unless SFrame can actually replace .eh_frame (rather than supplementing it as an accelerator for linux-perf) and demonstrate sizes smaller than .eh_frame - matching the efficiency of existing compact unwind approaches — I question its practical viability for userspace.
>The current design appears to add overhead rather than reduce it.
>This isn't to suggest we should simply adopt the existing compact unwind format wholesale.
>The x86-64 design dates back to 2009 or earlier, and there are likely improvements we can make. However, we should aim for similar or better efficiency gains.
>
>For additional context, I've documented my detailed analysis at:
>
>- https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering mandatory index building problems, section group compliance and garbage collection issues, and version compatibility challenges)
>- https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-trade-offs (size analysis)
>
>Best regards,
>Fangrui
>
>[1]: https://github.com/llvm/llvm-project/commit/58e2d3d856b7dc7b97a18cfa2aeeb927bc7e6bd5 ("Generate compact unwind encoding from CFI directives.")
>

tl;dr I believe a compact unwind scheme demonstrates significant promise over SFrame.
The MIPS compact exception tables as implemented in Binutils is also
worth considering (the structure can be shared among all architectures
while unwind code has to be arch-specific)

I've ported the Mach-O compact unwind format to ELF in a branch, establishing a baseline for improvements to the compact unwind format.

```
% ~/Dev/object-file-size-analyzer/section_size.rb /tmp/out/custom-{fp,sframe,compact,fp-gcc,sframe-gcc}/bin/{llvm-mc,opt}
Filename                               |       .text size |        EH size |   .sframe size |  VM size | VM increase
---------------------------------------+------------------+----------------+----------------+----------+------------
/tmp/out/custom-fp/bin/llvm-mc         |  2120895 (23.5%) |  301528 (3.3%) |       0 (0.0%) |  9043221 |           -
/tmp/out/custom-sframe/bin/llvm-mc     |  2109231 (22.3%) |  367424 (3.9%) |  348041 (3.7%) |  9474085 |       +4.8%
/tmp/out/custom-compact/bin/llvm-mc    |  2109519 (24.4%) |  106288 (1.2%) |       0 (0.0%) |  8639637 |       -4.5%

/tmp/out/custom-fp-gcc/bin/llvm-mc     |  2744214 (29.2%) |  301836 (3.2%) |       0 (0.0%) |  9389677 |       +3.8%
/tmp/out/custom-sframe-gcc/bin/llvm-mc |  2705860 (27.7%) |  354292 (3.6%) |  356073 (3.6%) |  9780985 |       +8.2%

/tmp/out/custom-fp/bin/opt             | 38769545 (69.9%) | 3547688 (6.4%) |       0 (0.0%) | 55425217 |           -
/tmp/out/custom-sframe/bin/opt         | 38891295 (62.4%) | 4559644 (7.3%) | 4448874 (7.1%) | 62292133 |      +12.4%
/tmp/out/custom-compact/bin/opt        | 38898415 (74.8%) | 1200764 (2.3%) |       0 (0.0%) | 52020449 |       -6.1%
/tmp/out/custom-fp-gcc/bin/opt         | 54654215 (78.1%) | 3631196 (5.2%) |       0 (0.0%) | 70001373 |      +26.3%
/tmp/out/custom-sframe-gcc/bin/opt     | 53644895 (70.4%) | 4857364 (6.4%) | 5263676 (6.9%) | 76206149 |      +37.5%
```

**Evaluation results**

With the current implementation, 4937 out of 77648 FDEs (6.36%) require a DWARF escape, while the remaining FDEs can be replaced with unwind descriptors, yielding a huge size saving.

.eh_frame_hdr will become significantly smaller if we implement a two-level page table structure similar to Mach-O __unwind_info to deduplicate entries.

**Build configurations**

```
#!/bin/zsh
conf() {
   configure-llvm $1 -DCMAKE_EXE_LINKER_FLAGS='-fuse-ld=bfd -pie -Wl,-z,pack-relative-relocs' \
     -DCMAKE_SHARED_LINKER_FLAGS=-fuse-ld=bfd -DLLVM_ENABLE_UNWIND_TABLES=on -DLLVM_ENABLE_LLD=off ${@:2}
}

clang=(-DCMAKE_CXX_COMPILER=/tmp/Rel/bin/clang++ -DCMAKE_C_COMPILER=/tmp/Rel/bin/clang)
gcc=("-DCMAKE_C_COMPILER=$HOME/opt/gcc-15/bin/gcc" "-DCMAKE_CXX_COMPILER=$HOME/opt/gcc-15/bin/g++")

compact="-fomit-frame-pointer -momit-leaf-frame-pointer -B$HOME/opt/binutils/bin -mllvm -elf-compact-unwind -mllvm -x86-epilog-cfi=0"
fp="-fno-omit-frame-pointer -momit-leaf-frame-pointer -B$HOME/opt/binutils/bin -Wa,--gsframe=no"
sframe="-fomit-frame-pointer -momit-leaf-frame-pointer -B$HOME/opt/binutils/bin -Wa,--gsframe"

conf custom-compact -DCMAKE_{C,CXX}_FLAGS="$compact" ${clang[@]} \
   -DCMAKE_EXE_LINKER_FLAGS='-fuse-ld=lld -pie -Wl,-z,pack-relative-relocs' \
   -DCMAKE_SHARED_LINKER_FLAGS=-fuse-ld=lld

conf custom-fp -DCMAKE_{C,CXX}_FLAGS="-fno-integrated-as $fp" ${clang[@]}
conf custom-sframe -DCMAKE_{C,CXX}_FLAGS="-fno-integrated-as $sframe" ${clang[@]}

conf custom-fp-gcc -DCMAKE_{C,CXX}_FLAGS="$fp" ${gcc[@]}
conf custom-sframe-gcc -DCMAKE_{C,CXX}_FLAGS="$sframe" ${gcc[@]}

for i in compact fp sframe  fp-gcc sframe-gcc; do ninja -C /tmp/out/custom-$i llvm-mc opt; done
```

The `/tmp/out/custom-compact` build uses my llvm-project branch
(<http://github.com/MaskRay/llvm-project/tree/demo-unwind>) that ports
Mach-O compact unwind to ELF, allowing the majority of `.eh_frame` FDEs
to replace CFI instructions with unwind descriptors.

-mllvm -x86-epilog-cfi=0: Disables epilogue CFI for x86 (primarily
implemented by D42848 in 2018, notably disabled for Darwin and Windows).
Without this option most frames will not utilize unwind descriptors
because the current Mach-O compact unwind implementation does not
support popq %rbp; .cfi_def_cfa %rsp, 8; ret. I believe this is still
fair as we expect to use a 8-byte descriptor, sufficient to describe
epilogue CFI.

If you still think custom-compact using -x86-epilog-cfi is not entirely
fair to other builds, this is the table using -fno-asynchronous-unwind-tables -funwind-tables -mllvm -x86-epilog-cfi=0
for all builds:

% ~/Dev/object-file-size-analyzer/section_size.rb /tmp/out/custom-{fp-sync,sframe-sync,compact-sync}/bin/{llvm-mc,opt}
Filename                                 |       .text size |        EH size |   .sframe size |  VM size | VM increase
-----------------------------------------+------------------+----------------+----------------+----------+------------
/tmp/out/custom-fp-sync/bin/llvm-mc      |  2120895 (24.1%) |  263396 (3.0%) |       0 (0.0%) |  8802093 |           -
/tmp/out/custom-sframe-sync/bin/llvm-mc  |  2109231 (23.2%) |  291084 (3.2%) |  248654 (2.7%) |  9090325 |       +3.3%
/tmp/out/custom-compact-sync/bin/llvm-mc |  2109519 (24.4%) |  106288 (1.2%) |       0 (0.0%) |  8639637 |       -1.8%
/tmp/out/custom-fp-sync/bin/opt          | 38769545 (72.2%) | 2997572 (5.6%) |       0 (0.0%) | 53706041 |           -
/tmp/out/custom-sframe-sync/bin/opt      | 38891295 (66.9%) | 3425116 (5.9%) | 2951292 (5.1%) | 58091421 |       +8.2%
/tmp/out/custom-compact-sync/bin/opt     | 38898415 (74.8%) | 1200764 (2.3%) |       0 (0.0%) | 52020449 |       -3.1%

---

After I had implemented this, I then investigated the MIPS compact
exception tables. I can now finalize the ‘in construction’ chapter of my
blog post,
https://maskray.me/blog/2020-11-08-stack-unwinding#mips-compact-exception-tables
Designed around 2015, it is actually a very good format.


Compiler output. The directive .cfi_sections .eh_frame_entry instructs
the assembler to emit index table entries to the .eh_frame_entry
section. .cfi_fde_data opcode1, ... betweens a pair of .cfi_startproc
and .cfi_endproc describes the frame unwind opcodes where each opcode
takes one byte. The frame unwind opcodes describes the semantics of
prologue instructions, similar to Windows ARM64 Frame Unwind Codes.

Assembler processing. The assembler generates a .eh_frame_entry.* section for each section with compact unwind information.
Each .eh_frame_entry is a pair of 4 bytes, where the first word is like the first word in a .eh_frame_hdr entry.
An .eh_frame_entry entry takes one of three forms:

Inline compact: (even pc, unwind_data). This form can be used when there are at most 3 opcodes (3 bytes) and no personality routine.
Out-of-line compact: (odd pc, even unwind_ptr) where unwind_ptr points to unwind data in the .gnu_extab section.
Legacy: (odd pc, odd legacy_unwind_ptr) where legacy_unwind_ptr points to the legacy .eh_frame section.
TODO: Describe .cfi_inline_lsda, which appears related to __gnu_compact_pr[1-3].

Linker processing. GNU ld concatenates .eh_frame_entry and .eh_frame_entry.* sections, sorting them by address.
The following internal linker script fragment adds a header before the entries:

.eh_frame_hdr   : { *(.eh_frame_hdr) *(.eh_frame_entry .eh_frame_entry.*) }
Although the section name remains the traditional .eh_frame_hdr, the version is set to 2.
The linker also defines the symbol __GNU_EH_FRAME_HDR to hold the .eh_frame_hdr address.

---

I've studied numerous stack unwinding/walking formats. DWARF CFI is
essential to achieve near 100% coverage. Other formats, such as compact
unwind formats and SFrame, have limitations. The ideal future solution,
as an alternative to frame pointer chains, will be a stack unwinding
format that supports C++ exceptions and can use DWARF CFI as a fallback.
