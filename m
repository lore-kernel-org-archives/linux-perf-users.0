Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFE1C4608;
	Wed, 30 Oct 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273506; cv=none; b=Am0p/ZFCZ184rA5z5NmqQKZVLX45OGR60vQqgk4gfo5X7i+Ey712Pye5k/vS82JztMxVpeFos9WLIeBK6maIZ9r8ADeu9XcbV+f2GGQHdIFKoh4vz7UwV44/kzDpysZ1qhY6CpEs3pCn6zrVV6SMP3CuaZ2m2Ns/aD4qgYXGLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273506; c=relaxed/simple;
	bh=Ligc7gG9uxazZzG+VKRAhVU1GN6Yz6i7eOPHZT3S7k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL7EmaRGvpGpkYOeU2Qifmch8UVgeOYSAxoCk67xmXkAOmEZyvFPJ9nHPZfllxzSFJoVrvg8TvOGwCvQjTC+Ap6Ko5dHaCaxlr99/JSPCAp2nVlqHKlxUOzi/16HZP5ji7yRY8Y1dlm/cZbNJ3/9cFCIHAJ79mI2U7JV/0YGsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56AF5C0004;
	Wed, 30 Oct 2024 07:31:36 +0000 (UTC)
Message-ID: <faa08151-3090-4c36-b4af-32f5378ac5a6@ghiti.fr>
Date: Wed, 30 Oct 2024 08:31:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf, riscv: Wire up perf trace support for RISC-V
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>
References: <20241024190353.46737-1-bjorn@kernel.org>
 <ZyF_whZ4Ez-jwd-W@google.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZyF_whZ4Ez-jwd-W@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Bjorn, Namhyung,

On 30/10/2024 01:37, Namhyung Kim wrote:
> Hello,
>
> On Thu, Oct 24, 2024 at 12:03:51PM -0700, Björn Töpel wrote:
>> From: Björn Töpel <bjorn@rivosinc.com>
>>
>> RISC-V does not currently support perf trace, since the system call
>> table is not generated.
>>
>> Perform the copy/paste exercise, wiring up RISC-V system call table
>> generation.
> Can anybody with RISC-V please test this?


So before this patch, I get:

Error::5File /sys/kernel/tracing//events/raw_syscalls/sys_(enter|exit) 
not found.
Hint:    Perhaps this kernel misses some CONFIG_ setting to enable this 
feature?.

After applying this patch, I get a proper trace:
....

      7.435 ( 0.332 ms): ls/1307 openat(dfd: CWD, filename: 0xb36ef668, 
flags: RDONLY|CLOEXEC)         = 3
      8.023 ( 0.454 ms): ls/1307 mmap(len: 23171, prot: READ, flags: 
PRIVATE, fd: 3)                   = 0x7fffb36cd000
      8.558 ( 0.065 ms): ls/1307 close(fd: 
3)                                                          = 0
      8.850 ( 0.294 ms): ls/1307 openat(dfd: CWD, filename: 0xb36f9f80, 
flags: RDONLY|CLOEXEC)         = 3
      9.223 ( 0.152 ms): ls/1307 read(fd: 3, buf: 0x7fffe27b3c20, count: 
832)

...

So you can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


>
> Thanks,
> Namhyung
>
>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>> ---
>>   tools/perf/Makefile.config                    |  6 ++-
>>   tools/perf/arch/riscv/Makefile                | 22 +++++++++
>>   .../arch/riscv/entry/syscalls/mksyscalltbl    | 47 +++++++++++++++++++
>>   tools/perf/util/syscalltbl.c                  |  4 ++
>>   4 files changed, 78 insertions(+), 1 deletion(-)
>>   create mode 100755 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
>>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 4ddb27a48eed..1d388e71e0cc 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
>>   ifneq ($(NO_SYSCALL_TABLE),1)
>>     NO_SYSCALL_TABLE := 1
>>   
>> -  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm64 s390 mips loongarch))
>> +  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm64 s390 mips loongarch riscv))
>>       NO_SYSCALL_TABLE := 0
>>     endif
>>   
>> @@ -83,6 +83,10 @@ ifeq ($(ARCH),mips)
>>     LIBUNWIND_LIBS = -lunwind -lunwind-mips
>>   endif
>>   
>> +ifeq ($(ARCH),riscv)
>> +  CFLAGS += -I$(OUTPUT)arch/riscv/include/generated
>> +endif
>> +
>>   # So far there's only x86 and arm libdw unwind support merged in perf.
>>   # Disable it on all other architectures in case libdw unwind
>>   # support is detected in system. Add supported architectures
>> diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
>> index 90c3c476a242..481da4518695 100644
>> --- a/tools/perf/arch/riscv/Makefile
>> +++ b/tools/perf/arch/riscv/Makefile
>> @@ -4,3 +4,25 @@ endif
>>   PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
>>   PERF_HAVE_JITDUMP := 1
>>   HAVE_KVM_STAT_SUPPORT := 1
>> +
>> +#
>> +# Syscall table generation for perf
>> +#
>> +
>> +out    := $(OUTPUT)arch/riscv/include/generated/asm
>> +header := $(out)/syscalls.c
>> +incpath := $(srctree)/tools
>> +sysdef := $(srctree)/tools/arch/riscv/include/uapi/asm/unistd.h
>> +sysprf := $(srctree)/tools/perf/arch/riscv/entry/syscalls/
>> +systbl := $(sysprf)/mksyscalltbl
>> +
>> +# Create output directory if not already present
>> +$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>> +
>> +$(header): $(sysdef) $(systbl)
>> +	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
>> +
>> +clean::
>> +	$(call QUIET_CLEAN, riscv) $(RM) $(header)
>> +
>> +archheaders: $(header)
>> diff --git a/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl b/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
>> new file mode 100755
>> index 000000000000..c59f5e852b97
>> --- /dev/null
>> +++ b/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
>> @@ -0,0 +1,47 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Generate system call table for perf. Derived from
>> +# powerpc script.
>> +#
>> +# Copyright IBM Corp. 2017
>> +# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>> +# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> +# Changed by: Kim Phillips <kim.phillips@arm.com>
>> +# Changed by: Björn Töpel <bjorn@rivosinc.com>
>> +
>> +gcc=$1
>> +hostcc=$2
>> +incpath=$3
>> +input=$4
>> +
>> +if ! test -r $input; then
>> +	echo "Could not read input file" >&2
>> +	exit 1
>> +fi
>> +
>> +create_sc_table()
>> +{
>> +	local sc nr max_nr
>> +
>> +	while read sc nr; do
>> +		printf "%s\n" "	[$nr] = \"$sc\","
>> +		max_nr=$nr
>> +	done
>> +
>> +	echo "#define SYSCALLTBL_RISCV_MAX_ID $max_nr"
>> +}
>> +
>> +create_table()
>> +{
>> +	echo "#include \"$input\""
>> +	echo "static const char *const syscalltbl_riscv[] = {"
>> +	create_sc_table
>> +	echo "};"
>> +}
>> +
>> +$gcc -E -dM -x c -I $incpath/include/uapi $input \
>> +	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
>> +		sub("^#define __NR(3264)?_", "");
>> +		print | "sort -k2 -n"}' \
>> +	|create_table
>> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
>> index 7c15dec6900d..349986f6e5f5 100644
>> --- a/tools/perf/util/syscalltbl.c
>> +++ b/tools/perf/util/syscalltbl.c
>> @@ -46,6 +46,10 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
>>   #include <asm/syscalls.c>
>>   const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
>>   static const char *const *syscalltbl_native = syscalltbl_loongarch;
>> +#elif defined(__riscv)
>> +#include <asm/syscalls.c>
>> +const int syscalltbl_native_max_id = SYSCALLTBL_RISCV_MAX_ID;
>> +static const char *const *syscalltbl_native = syscalltbl_riscv;
>>   #endif
>>   
>>   struct syscall {
>>
>> base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
>> -- 
>> 2.45.2
>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
