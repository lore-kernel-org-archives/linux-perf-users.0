Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A9192590;
	Tue, 25 Feb 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503434; cv=none; b=TxB/EEl9EQscY8nfDYDu9AotrD/lf7CGVqp/cpIcBPg0I5Q1aBagw5cUyEV4GcIQzvJnmZVpgC7M8fQsXMe0gPjrPQS60gR11OHoGTSokdPRicNf1ShrfpYBpbYCi/NpJns8KCoiiVHQJBnj0r4vDbeAKStgqXuFE3HG6C5e+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503434; c=relaxed/simple;
	bh=tXxaorPHn4pHiMqvjZfTU/Y22wBYgpx0AiOrDyr5FMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6wOMbpTWiApPrR2Fo7xXMjHYqne8XAwjL4+g5SU5Z4KJjOLJMiu6Z3VUX3fmZswcZO7zz0GlLcxUpMMxkN6J/MiRLViSnc+N2a/hohvjir/oui63NbEOjDlEyrZxJuOrmjl9JAnIC44nDTPnq57Jq3d/zNTzckwXUr/VXxSgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=N4yrIpzu; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N4yrIpzu"
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PHA2tZ1360058
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 09:10:02 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PHA2tZ1360058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740503403;
	bh=li5piKz6gNejYYWNkGKJI9BlmhWBdeMwWCFBAi8IYKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N4yrIpzu+oDV1Wqo1K8nqaTXD/Ad6YlGS8lBPiQwaqo1q4QdGRhTk837oULDAcWJW
	 oUUhO/5UCAs+9n2hUEpGX+Wy+g0pGqnA9ZbwJxJmMy8W6ERPWaKHiYX+6/V/QTdfNc
	 14bfgGmBujtpCVYRcChJQqEQUNtSDs7uNMXjDEy43R7+/k2wbvpVm0NuV/VrV35JsJ
	 6Nu/yzmj4p8yTr04CJFNrllQvYIcYIKQd3FKughSYQVyHg1HlIv76eFWPqUWSa2/ZZ
	 NJa0P2uzCXWffnQb/ymj7isbL9BS5S3FFc+aiKABD0FUCdpH0XzjGHy2Pkc4agtd6K
	 9ZIhjyVUheghQ==
Message-ID: <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com>
Date: Tue, 25 Feb 2025 09:10:01 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org, peterz@infradead.org,
        yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com,
        nik.borisov@suse.com
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/2025 2:27 AM, Borislav Petkov wrote:
> On Sun, Jan 05, 2025 at 11:07:22PM -0800, Xin Li (Intel) wrote:
>>   arch/x86/Kconfig                              |   4 +-
>>   arch/x86/Kconfig.cpu                          |  12 +-
>>   arch/x86/Kconfig.cpufeatures                  | 197 ++++++++++++++++++
>>   arch/x86/Makefile                             |  17 +-
>>   arch/x86/boot/cpucheck.c                      |   3 +-
>>   arch/x86/boot/cpuflags.c                      |   1 -
>>   arch/x86/boot/mkcpustr.c                      |   3 +-
>>   arch/x86/include/asm/Kbuild                   |   1 +
>>   arch/x86/include/asm/asm-prototypes.h         |   2 +-
>>   arch/x86/include/asm/atomic64_32.h            |   2 +-
>>   arch/x86/include/asm/bitops.h                 |   4 +-
>>   arch/x86/include/asm/cmpxchg_32.h             |   2 +-
>>   arch/x86/include/asm/cpufeature.h             |  71 +------
>>   arch/x86/include/asm/cpufeatures.h            |  13 +-
>>   arch/x86/include/asm/disabled-features.h      | 161 --------------
>>   arch/x86/include/asm/required-features.h      | 105 ----------
>>   arch/x86/kernel/cpu/common.c                  |   1 +
>>   arch/x86/kernel/verify_cpu.S                  |   4 +
>>   arch/x86/lib/Makefile                         |   2 +-
>>   arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
>>   arch/x86/tools/featuremasks.awk               |  88 ++++++++
>>   lib/atomic64_test.c                           |   2 +-
>>   tools/arch/x86/include/asm/cpufeatures.h      |   8 -
>>   .../arch/x86/include/asm/disabled-features.h  | 161 --------------
>>   .../arch/x86/include/asm/required-features.h  | 105 ----------
>>   tools/perf/check-headers.sh                   |   2 -
>>   26 files changed, 327 insertions(+), 646 deletions(-)
>>   create mode 100644 arch/x86/Kconfig.cpufeatures
>>   delete mode 100644 arch/x86/include/asm/disabled-features.h
>>   delete mode 100644 arch/x86/include/asm/required-features.h
>>   create mode 100755 arch/x86/tools/featuremasks.awk
>>   delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
>>   delete mode 100644 tools/arch/x86/include/asm/required-features.h
> 
> make --no-print-directory -C /home/kernel/linux \
> -f /home/kernel/linux/Makefile
> # GEN     arch/x86/include/generated/asm/orc_hash.h
>    mkdir -p arch/x86/include/generated/asm/; sh ./scripts/orc_hash.sh < arch/x86/include/asm/orc_types.h > arch/x86/include/generated/asm/orc_hash.h
> make -f ./scripts/Makefile.build obj=scripts/basic
> set -e; mkdir -p include/config/; trap "rm -f include/config/.tmp_kernel.release" EXIT; { ./scripts/setlocalversion .; } > include/config/.tmp_kernel.release; if [ ! -r include/config/kernel.release ] || ! cmp -s include/config/kernel.release include/config/.tmp_kernel.release; then : '  UPD     include/config/kernel.release'; mv -f include/config/.tmp_kernel.release include/config/kernel.release; fi
> # GEN     arch/x86/include/generated/asm/featuremasks.h
>    awk -f ./arch/x86/tools/featuremasks.awk ./arch/x86/include/asm/cpufeatures.h .config > arch/x86/include/generated/asm/featuremasks.h
> make -f ./scripts/Makefile.asm-headers obj=arch/x86/include/generated/uapi/asm \
> generic=include/uapi/asm-generic
> awk: ./arch/x86/tools/featuremasks.awk: line 16: syntax error at or near {
> awk: ./arch/x86/tools/featuremasks.awk: line 20: syntax error at or near :
> awk: ./arch/x86/tools/featuremasks.awk: line 24: syntax error at or near }
> make[1]: *** [arch/x86/Makefile:285: arch/x86/include/generated/asm/featuremasks.h] Error 2
> make[1]: *** Deleting file 'arch/x86/include/generated/asm/featuremasks.h'
> make[1]: *** Waiting for unfinished jobs....
> # WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>    echo "#include <asm-generic/bpf_perf_event.h>" > arch/x86/include/generated/uapi/asm/bpf_perf_event.h
> # WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
>    echo "#include <asm-generic/fcntl.h>" > arch/x86/include/generated/uapi/asm/fcntl.h
> # WRAP    arch/x86/include/generated/uapi/asm/errno.h
>    echo "#include <asm-generic/errno.h>" > arch/x86/include/generated/uapi/asm/errno.h
> # WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
>    echo "#include <asm-generic/ioctl.h>" > arch/x86/include/generated/uapi/asm/ioctl.h
> # WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
>    echo "#include <asm-generic/ioctls.h>" > arch/x86/include/generated/uapi/asm/ioctls.h
> # WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
>    echo "#include <asm-generic/ipcbuf.h>" > arch/x86/include/generated/uapi/asm/ipcbuf.h
> # WRAP    arch/x86/include/generated/uapi/asm/param.h
>    echo "#include <asm-generic/param.h>" > arch/x86/include/generated/uapi/asm/param.h
> # WRAP    arch/x86/include/generated/uapi/asm/poll.h
>    echo "#include <asm-generic/poll.h>" > arch/x86/include/generated/uapi/asm/poll.h
> # WRAP    arch/x86/include/generated/uapi/asm/resource.h
>    echo "#include <asm-generic/resource.h>" > arch/x86/include/generated/uapi/asm/resource.h
> # WRAP    arch/x86/include/generated/uapi/asm/socket.h
>    echo "#include <asm-generic/socket.h>" > arch/x86/include/generated/uapi/asm/socket.h
> # WRAP    arch/x86/include/generated/uapi/asm/sockios.h
>    echo "#include <asm-generic/sockios.h>" > arch/x86/include/generated/uapi/asm/sockios.h
> # WRAP    arch/x86/include/generated/uapi/asm/termbits.h
>    echo "#include <asm-generic/termbits.h>" > arch/x86/include/generated/uapi/asm/termbits.h
> # WRAP    arch/x86/include/generated/uapi/asm/termios.h
>    echo "#include <asm-generic/termios.h>" > arch/x86/include/generated/uapi/asm/termios.h
> # WRAP    arch/x86/include/generated/uapi/asm/types.h
>    echo "#include <asm-generic/types.h>" > arch/x86/include/generated/uapi/asm/types.h
> make: *** [Makefile:251: __sub-make] Error 2
> 
> Probably due to:
> 
> $ awk --version
> mawk 1.3.4 20250131
> Copyright 2008-2024,2025, Thomas E. Dickey
> Copyright 1991-1996,2014, Michael D. Brennan
> 
> random-funcs:       srandom/random
> regex-funcs:        internal
> 
> compiled limits:
> sprintf buffer      8192
> maximum-integer     9223372036854775808
> 
> while the other box has GNU awk where it obviously works.

After looking into the build issue, we think it's better to change to 
perl; GNU awk has quite a few extended features that standard awk 
doesn't support, e.g., BEGINFILE/FPAT/...

Thanks!
     Xin

> 
> HTH.
> 

