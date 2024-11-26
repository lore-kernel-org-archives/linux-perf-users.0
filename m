Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DE1DEFC2
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657010; cv=none; b=DfopStd2t4ooe3hhp04lFQys4f7tBPHxgEs/Egrb3WhHRqLUD0hce8+jZE7PkNm0adcBlE5KJrSAmSXw0X+k6hyNd0pVNawg1VsfYHRKV05SSKlFIZgGx2V/YWwhqiaZ9yg9kn8Q/zx3Js2aDWJJd4a6PvnVYhynbeMB9mvahWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657010; c=relaxed/simple;
	bh=v/GairsYwJ78tOGQPrHiE3P7/qShDg8uD4VwxNeY0XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q84CMc92oymkDvKrlf2rxcHmKH9nqNAsG//tREhybRiQZYhL7VI7+5P4la03jorK9Lcofz0TW8YxI26VsDrC41oEaKFL56Joi2lgqBHMaiTtjGiaqRN7QlrQglDqYtY12nVReB0LJiBjO45fteYB/wJaFCe35gryTQGTGcqNSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3euBkT/9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3euBkT/9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21288ce11d7so48183595ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 13:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732657007; x=1733261807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHRhjsfKN6Al5TNnmTyBOiKcGX/jb5roHjFGenSaZE0=;
        b=3euBkT/9yDCBQ4M6YgNbBkE/21YhGBRGwUwhyRU3mneFx4Df7yKDBv9M/Tv9WZUm8D
         9Bq0qaMfjyiwpgDjgLJMUMXQrc92r0y7lLlc34DpPY2BG88EaOcDMIxukR0VPuBvhtdW
         NbCsRDtXXTz8f7w7KBeG7L8a/kYIWoIBcB3mLl0bvybTO7GKXY0XudcxEH6oe2sTM2KK
         rCkMvcBAzsUdUonZ8EH/vXsu6Uqup8lO+7Fwqlw0Bf+iClzcusdThv5mMXac6PsJuoAu
         8m5GKCRyt68q45u4Rxl3VkhTO8U+Lg+JIPW6JMfzaBYLfsP94m/7ymOs8u85dafm/KLr
         1lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657007; x=1733261807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHRhjsfKN6Al5TNnmTyBOiKcGX/jb5roHjFGenSaZE0=;
        b=gXGYYHvT5NARTngS4BFhGjjDIOOaJJSaATnkCutPPzRPvCWWwA+/WkSNKiO/v2rxZJ
         /omOXfuA9m7FOw+WXO3oEc3I83fMx2HLIKUEq70ZpAv4Zw78REMl6ihhNklCa4syZaCa
         OimubK1P6fuSrhggPJet6zfDK82JdD6M+RD4OVUornkwWEb6STorz8VMOYNrwXPeCZ7R
         vynt74NPi67C5Ans3h3iXWusAjiuPXB6xJ3fzk2C6aJRcUmB3Ud4+k+/COSCrnhZTnn7
         8bFlmJwHaJeM3WStF1u5giz4PKsvZx9kp4IRz5GbbKxqcytT01h6smPAJLDNme4n6oxT
         tm8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQWj8oxaqBI9mUq/TGdbORQ3zWneUBLknhpARd9TASPfsnINBYOR69iq7bVZY3YMaHdgfBArqd6Aowr/0qMAUb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdb0n2GB4peIT8D/pJ3JBEeqMsHVmv7ORJ48a7aHGHhRfc1ZLp
	vdISzvaGbPJ670ROaMw50DePuqDhHu+BZcd9/ZmR4S28OUi/ZJDwR10ufa/KjWA=
X-Gm-Gg: ASbGncu+dOVjVsDOmjSAdtUPOOxvsJ6PtpAjhFAbUwVEPWBKV97mVrmZwUdESJenoG8
	wPX909bqcqYnoKxiy01s+1NZk+dWZeIFta49Q7pY1ACNuEcY8H+z9zkphuSfkt0nXO+dS131Dxr
	p/Buor23f+YmyAwvidE5nnvCnToP/8Obg1YavO78T8hsIgMaaOp0qo7MxWlM6ucuSMvGN93zOEm
	Yeksxo7lwW9XmJ+Nh0C22AoYbmlaWbDkJRqv6XJvOGj
X-Google-Smtp-Source: AGHT+IE6PiHzCBpFxf6nqtggtGSAKLH3Svgn7LxrahHubJPvHJeZhuEaDwLks+UyVbr6RS0/jAAVqw==
X-Received: by 2002:a17:903:2441:b0:212:67a5:ab24 with SMTP id d9443c01a7336-21501e5c1ffmr6937425ad.41.1732657007184;
        Tue, 26 Nov 2024 13:36:47 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:15f:6df4:c303:cfc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc207bbsm89082475ad.228.2024.11.26.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:36:46 -0800 (PST)
Date: Tue, 26 Nov 2024 13:36:44 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools] tools riscv: Include fence.h from the
 same directory barrier.h lives
Message-ID: <Z0Y_bC42dufBNE4L@ghost>
References: <Z0Y8XQMBXT5JdOAG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Y8XQMBXT5JdOAG@x1>

On Tue, Nov 26, 2024 at 06:23:41PM -0300, Arnaldo Carvalho de Melo wrote:
> When cross building perf to riscv I noticed that it isn't finding the
> asm/fence.h file included from tools/arch/riscv/include/asm/barrier.h,
> since both live in the same directory, load it from there instead of
> from asm/fence.h, fixing the libbpf build in such environment:
> 
>   perfbuilder@number:~$ time dm ubuntu:22.04-x-riscv64
>      1     4.32 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
>                        from mmap.c:7:
>       /git/perf-6.12.0-rc6/tools/include/asm/../../arch/riscv/include/asm/barrier.h:13:10: fatal error: asm/fence.h: No such file or directory
>          13 | #include <asm/fence.h>
>             |          ^~~~~~~~~~~~~
>       compilation terminated.
>   <SNIP other similar errors>
> 
> This probably should work in other systems where the right asm/fence.h
> is available, but in the above scenario, it fails. Probably we should
> fix the perf build system to find it in tools/arch/riscv/include/asm/,
> but this one-liner should be a stop gap solution till we get there.
> 
> Testing it:
> 
>   perfbuilder@number:~$ time dm ubuntu:22.04-x-riscv64
>      1    21.65 ubuntu:22.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0  flex 2.6.4
>   BUILD_TARBALL_HEAD=800d169e2d39e4e81ade326d73ae7c4343c12b45
>   $ git log --oneline -1 800d169e2d39e4e81ade326d73ae7c4343c12b45
>   800d169e2d39e4e8 tools riscv: Include fence.h from the same directory barrier.h lives
>   toolsbuilder@number:~/perf-6.12.0-rc6$ ls -la /tmp/build/perf/perf
>   -rwxr-xr-x. 1 toolsbuilder toolsbuilder 3278728 Nov 26 21:12 /tmp/build/perf/perf
>   toolsbuilder@number:~/perf-6.12.0-rc6$ file /tmp/build/perf/perf
>   /tmp/build/perf/perf: ELF 64-bit LSB pie executable, UCB RISC-V, RVC, double-float ABI, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, BuildID[sha1]=9b77bbf51da74cee24c6d5fc5814343cc7e9a652, for GNU/Linux 4.15.0, with debug_info, not stripped
>   toolsbuilder@number:~/perf-6.12.0-rc6$
>   toolsbuilder@number:~/perf-6.12.0-rc6$ readelf -d /tmp/build/perf/perf | head
>   Dynamic section at offset 0x242db0 contains 33 entries:
>     Tag        Type                         Name/Value
>    0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
>    0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
>    0x0000000000000001 (NEEDED)             Shared library: [libelf.so.1]
>    0x0000000000000001 (NEEDED)             Shared library: [libdw.so.1]
>    0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
>    0x0000000000000001 (NEEDED)             Shared library: [ld-linux-riscv64-lp64d.so.1]
>    0x0000000000000020 (PREINIT_ARRAY)      0x238740
>   toolsbuilder@number:~/perf-6.12.0-rc6$
> 
> Fixes: 6d74d178fe6eaf61 ("tools: Add riscv barrier implementation")
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/arch/riscv/include/asm/barrier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/arch/riscv/include/asm/barrier.h b/tools/arch/riscv/include/asm/barrier.h
> index 6997f197086ddf61..e78241632e2f1301 100644
> --- a/tools/arch/riscv/include/asm/barrier.h
> +++ b/tools/arch/riscv/include/asm/barrier.h
> @@ -10,7 +10,7 @@
>  #ifndef _TOOLS_LINUX_ASM_RISCV_BARRIER_H
>  #define _TOOLS_LINUX_ASM_RISCV_BARRIER_H
>  
> -#include <asm/fence.h>
> +#include "fence.h"
>  #include <linux/compiler.h>
>  
>  /* These barriers need to enforce ordering on both devices and memory. */
> -- 
> 2.47.0
> 

We have been trying to get this resolved with a different patch [1], but
getting it picked up was painfully slow and it wasn't picked up into
6.12 for some reason... It is on master now, but it hasn't been
backported yet, I don't know why not. There was another fix here [2]
that is similar to what you have, but [1] was selected instead of it.

[1] https://lore.kernel.org/linux-riscv/172835823300.66789.3704854116445399222.git-patchwork-notify@kernel.org/
[2] https://lore.kernel.org/linux-riscv/mvm5xq44bqh.fsf@suse.de/

- Charlie

