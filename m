Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057826461E
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739231313; cv=none; b=ULpH9q0X8y/xnm3ZfzGPZyw3i/pitTz6QGadyOPvbQAt2XKoGupUH41iEno/lotJAbhRV43ppEuBYJJL7BhUM+/WoK2Y+zixuqQ5YCNwsqv4QWcdceLhPddvGBHfGpZcoMXeNt5tKUDRf8BhkYCVR8K2EI4nCwByNFKaidypaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739231313; c=relaxed/simple;
	bh=/CKBPOgYU1itQ/4LQMGKnw3/T2du2/kYlFHhoCUThZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDXep2mLMAxYndJ+zJqejRJeuavEQNEuu5fecqtEA+IPGiBZQVVfyJ8uhwwP728PMKcl7jCqHQQC3wsMAqoYGu2rBbgcWNqVBcjnIUdeGXediMgt+mKYlkxoZTxFddwstPhk2ArE0OwQNlwwAwgJvwDuJz8BFXhf0jSTsFIyeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fgnI1UgF; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fgnI1UgF"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5b4d615362so2964417276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 15:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739231311; x=1739836111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hUbHvJc96V/cck7neSAdutap4ydIBlL7Lt+WobzOv4=;
        b=fgnI1UgF7T2WbOEECYAl7UHJ7HqE92pEYHrkBD2auRyaCSxl18KDby2ebiNRz8aj0z
         ilXAdNx25Gxi5FIgKJ3XNxioqlu4Z2VCa6mNHA62FzuYXW147Cn/8iE3sUrJXO0AxxWp
         jY38kChI2nD31CRvVTpZLi890pDMyhFUVf/2VaknpC7m42H1tDGgpAPkmkC1BkmzFFWI
         0XZLT23KVe0cw57VVrKkCAcjGU1N1V69lwwFU0DR1bQAD45poQyFFZDvhrP+klygcdfD
         JS2jsinkcPvcNR3ZOxoqy8CYIKYLsyc0irzIymq01POWmvW9fsz0dH+S3PVKeFbg2bI2
         nwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739231311; x=1739836111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hUbHvJc96V/cck7neSAdutap4ydIBlL7Lt+WobzOv4=;
        b=g7OLXe4vbU/3Z1uqi4dxSCuREkFYCY5lqILUDWGBQ/LE/0cqyV1OpWd2zWhK+QH5af
         QkMJUpv+1w+Yz6LnR591bfBvHQRkvIF7culXaTMQrh5marAEz1L3EyH70wbxU3VnQKAX
         cJ4J+Syoc0Wcr9fMpPr4doax++PyNW/y2DudVjYXL+TfyQ2ECDpTIm6HPzFJgEfbmc/z
         U5L5G51LK+RR7u/2R2lCJg3saNyB8nRZSBMSVOFot0flv/Xg8y1+BoC0HUqdWajGr2rS
         zDntS+3BW4xg+CCMGXluwRsjKd4wNZ1x8oV2Ji8sjD4yVXWOCQrQ3xdWYauc8PAiDLVf
         N+QA==
X-Forwarded-Encrypted: i=1; AJvYcCV0g+9BdLRxdJ0Fi7d+wxeEmN7YWpc6412sxUFcUPHgda1O22pdXPLb4Gq0UkgcHtpxr9QgU1ccLejrt27bZ4OJ@vger.kernel.org
X-Gm-Message-State: AOJu0YypL2a4mPmG8v7Aht3HR/VORFWkqWpFOQDqQNsj2Z+HuGDPCLFZ
	DWCP+3E4HoAEYaHRUreYeWnpRZMukXd/MRrKxat6O8nA7XEfJvLpR2fVq0Y4HDQ=
X-Gm-Gg: ASbGncv3Y9MvXiIAagj0dVcCLD4W44gMduBkFXepAnP8rCgPRC77bbs7PzKLh5CI/PC
	SX/4i9seSuab/J0b4PsvhhYHRopzsjXrtPcqz+oWwzTYhfNM5FmOEkzzXLS5sFlLrFJiVDpDX18
	krlEe3zjCgRgBzY34xcAseCjjHLJVVOCF3JPg9zqsUgE5iwgJnFcwWuXJBdmnT8IJvWcxRkVxyK
	jqAC5u3hyLeGce+0ZSCxgHmmCbsNTfZDPMeQbc0f1kON1XSQ8kongbYNNZed9tjJumOXy7fHG9z
	Arg=
X-Google-Smtp-Source: AGHT+IESD4xAhKpt/pl94F/2JTELVhfRZrr4MEz5jFM5hVpih0Ce3o8BYnuqyUwCOqcd7JcBXZF8hA==
X-Received: by 2002:a05:6902:1b03:b0:e5b:44f2:e2c2 with SMTP id 3f1490d57ef6-e5b461c59e5mr12913135276.25.1739231310645;
        Mon, 10 Feb 2025 15:48:30 -0800 (PST)
Received: from ghost ([50.146.0.9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5b3a45dd7esm2895010276.39.2025.02.10.15.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 15:48:29 -0800 (PST)
Date: Mon, 10 Feb 2025 15:48:28 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/7] perf syscalltble: Remove syscall_table.h
Message-ID: <Z6qQTL7k8VmAM_nD@ghost>
References: <20250210165108.95894-1-irogers@google.com>
 <20250210165108.95894-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210165108.95894-2-irogers@google.com>

On Mon, Feb 10, 2025 at 08:51:02AM -0800, Ian Rogers wrote:
> The definition of "static const char *const syscalltbl[] = {" is done
> in a generated syscalls_32.h or syscalls_64.h that is architecture
> dependent. In order to include the appropriate file a syscall_table.h
> is found via the perf include path and it includes the syscalls_32.h
> or syscalls_64.h as appropriate.
> 
> To support having multiple syscall tables, one for 32-bit and one for
> 64-bit, or for different architectures, an include path cannot be
> used. Remove syscall_table.h because of this and inline what it does
> into syscalltbl.c.
> 
> For architectures without a syscall_table.h this will cause a failure
> to include either syscalls_32.h or syscalls_64.h rather than a failure
> to include syscall_table.h. For architectures that only included one
> or other, the behavior matches BITS_PER_LONG as previously done on
> architectures supporting both syscalls_32.h and syscalls_64.h.

This is a great way of doing this, thank you.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/arch/alpha/include/syscall_table.h     | 2 --
>  tools/perf/arch/arc/include/syscall_table.h       | 2 --
>  tools/perf/arch/arm/include/syscall_table.h       | 2 --
>  tools/perf/arch/arm64/include/syscall_table.h     | 8 --------
>  tools/perf/arch/csky/include/syscall_table.h      | 2 --
>  tools/perf/arch/loongarch/include/syscall_table.h | 2 --
>  tools/perf/arch/mips/include/syscall_table.h      | 2 --
>  tools/perf/arch/parisc/include/syscall_table.h    | 8 --------
>  tools/perf/arch/powerpc/include/syscall_table.h   | 8 --------
>  tools/perf/arch/riscv/include/syscall_table.h     | 8 --------
>  tools/perf/arch/s390/include/syscall_table.h      | 2 --
>  tools/perf/arch/sh/include/syscall_table.h        | 2 --
>  tools/perf/arch/sparc/include/syscall_table.h     | 8 --------
>  tools/perf/arch/x86/include/syscall_table.h       | 8 --------
>  tools/perf/arch/xtensa/include/syscall_table.h    | 2 --
>  tools/perf/util/syscalltbl.c                      | 8 +++++++-
>  16 files changed, 7 insertions(+), 67 deletions(-)
>  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
> 
> diff --git a/tools/perf/arch/alpha/include/syscall_table.h b/tools/perf/arch/alpha/include/syscall_table.h
> deleted file mode 100644
> index b53e31c15805..000000000000
> --- a/tools/perf/arch/alpha/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_64.h>
> diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
> deleted file mode 100644
> index 4c942821662d..000000000000
> --- a/tools/perf/arch/arc/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> diff --git a/tools/perf/arch/arm/include/syscall_table.h b/tools/perf/arch/arm/include/syscall_table.h
> deleted file mode 100644
> index 4c942821662d..000000000000
> --- a/tools/perf/arch/arm/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> diff --git a/tools/perf/arch/arm64/include/syscall_table.h b/tools/perf/arch/arm64/include/syscall_table.h
> deleted file mode 100644
> index 7ff51b783000..000000000000
> --- a/tools/perf/arch/arm64/include/syscall_table.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
> deleted file mode 100644
> index 4c942821662d..000000000000
> --- a/tools/perf/arch/csky/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> diff --git a/tools/perf/arch/loongarch/include/syscall_table.h b/tools/perf/arch/loongarch/include/syscall_table.h
> deleted file mode 100644
> index 9d0646d3455c..000000000000
> --- a/tools/perf/arch/loongarch/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscall_table_64.h>
> diff --git a/tools/perf/arch/mips/include/syscall_table.h b/tools/perf/arch/mips/include/syscall_table.h
> deleted file mode 100644
> index b53e31c15805..000000000000
> --- a/tools/perf/arch/mips/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_64.h>
> diff --git a/tools/perf/arch/parisc/include/syscall_table.h b/tools/perf/arch/parisc/include/syscall_table.h
> deleted file mode 100644
> index 7ff51b783000..000000000000
> --- a/tools/perf/arch/parisc/include/syscall_table.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> diff --git a/tools/perf/arch/powerpc/include/syscall_table.h b/tools/perf/arch/powerpc/include/syscall_table.h
> deleted file mode 100644
> index 7ff51b783000..000000000000
> --- a/tools/perf/arch/powerpc/include/syscall_table.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> diff --git a/tools/perf/arch/riscv/include/syscall_table.h b/tools/perf/arch/riscv/include/syscall_table.h
> deleted file mode 100644
> index 7ff51b783000..000000000000
> --- a/tools/perf/arch/riscv/include/syscall_table.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> diff --git a/tools/perf/arch/s390/include/syscall_table.h b/tools/perf/arch/s390/include/syscall_table.h
> deleted file mode 100644
> index b53e31c15805..000000000000
> --- a/tools/perf/arch/s390/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_64.h>
> diff --git a/tools/perf/arch/sh/include/syscall_table.h b/tools/perf/arch/sh/include/syscall_table.h
> deleted file mode 100644
> index 4c942821662d..000000000000
> --- a/tools/perf/arch/sh/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> diff --git a/tools/perf/arch/sparc/include/syscall_table.h b/tools/perf/arch/sparc/include/syscall_table.h
> deleted file mode 100644
> index 7ff51b783000..000000000000
> --- a/tools/perf/arch/sparc/include/syscall_table.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> diff --git a/tools/perf/arch/x86/include/syscall_table.h b/tools/perf/arch/x86/include/syscall_table.h
> deleted file mode 100644
> index 7ff51b783000..000000000000
> --- a/tools/perf/arch/x86/include/syscall_table.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> diff --git a/tools/perf/arch/xtensa/include/syscall_table.h b/tools/perf/arch/xtensa/include/syscall_table.h
> deleted file mode 100644
> index 4c942821662d..000000000000
> --- a/tools/perf/arch/xtensa/include/syscall_table.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 928aca4cd6e9..2f76241494c8 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -7,13 +7,19 @@
>  
>  #include "syscalltbl.h"
>  #include <stdlib.h>
> +#include <asm/bitsperlong.h>
>  #include <linux/compiler.h>
>  #include <linux/zalloc.h>
>  
>  #include <string.h>
>  #include "string2.h"
>  
> -#include <syscall_table.h>
> +#if __BITS_PER_LONG == 64
> +  #include <asm/syscalls_64.h>
> +#else
> +  #include <asm/syscalls_32.h>
> +#endif
> +
>  const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
>  static const char *const *syscalltbl_native = syscalltbl;
>  
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 
