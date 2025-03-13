Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E92EADA;
	Thu, 13 Mar 2025 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895759; cv=none; b=m4ndWVTS7mCNnUbN+7WK7BWks7Chg4wyRwi6nai04Jr+G1bAHCzmVFi0CREtXwFQm7cX6JX8bqJLfCKlB4wZVGPOfi6OmnUanf9b4hWr7bYn2XWKlKVzU0GEJ9j9PU4wWudyej8GndRMn7CcO+Mr3L6kCROfqn/S39oy2UqrCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895759; c=relaxed/simple;
	bh=fYqkeQRnWF5f+DKytRvz15lVWn76of85/QsqfnCc3FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUKnpIQOpM6OZa0YK4bvPtvo/ckuSQ0e0rvUhwboADzhFEvpkGPSV/5lHXtgKAN2FrE5FGGsAn5SMOhf78sCqWZgkkVHCTZNpYq+7Wd+jnM74CgwJP8w/4lhTOetq/gNjDX5RxqcZ4p+drQhTi9erzPD2yjzTYQDcs54Pk4rRJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tayN66tO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tayN66tO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5735BC4CEDD;
	Thu, 13 Mar 2025 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741895759;
	bh=fYqkeQRnWF5f+DKytRvz15lVWn76of85/QsqfnCc3FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tayN66tOOF6jMNqkZ5ePRkN7Ee8y31+K7eOP673REb6XV5zLOulLsRfo22a7MqFoR
	 r05dup9BfCoNTPi13Zt83sIUdU+jQp+O6qGxWwhxvO9rqtQzqhlgsYmC6J6o96heGe
	 tEZKHpS32417/8hRF8VY9nI86YAlkqCylsTC58mV+N6MaC89xKmr+Fw0aYT1thVWVD
	 kLLQq6AjOM3w5/E47TIz0UotatLlZ8zec9LhnkXbtISpJG7a5wnaa24YnUNxeOXM36
	 xdRBDo37cTFAdPfkCSrUG1AI/Z2PyR8BcDXtw87iq3W7zxnUfCSnwF40tvVk3JMEPq
	 vPcac02Z+5zwA==
Date: Thu, 13 Mar 2025 12:55:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	guoren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 09/11] perf syscalltbl: Use lookup table containing
 multiple architectures
Message-ID: <Z9M4TIY9HstTLzNs@google.com>
References: <20250308003209.234114-1-irogers@google.com>
 <20250308003209.234114-10-irogers@google.com>
 <Z9MwQJ5bRu6-N43w@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9MwQJ5bRu6-N43w@x1>

On Thu, Mar 13, 2025 at 04:21:36PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 07, 2025 at 04:32:07PM -0800, Ian Rogers wrote:
> > Switch to use the lookup table containing all architectures rather
> > than tables matching the perf binary.
> > 
> > This fixes perf trace when executed on a 32-bit i386 binary on an
> > x86-64 machine. Note in the following the system call names of the
> > 32-bit i386 binary as seen by an x86-64 perf.
> > 
> 
> Reproduced the results here:
> 
> root@number:/home/acme/c# file faccessat2
> faccessat2: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, BuildID[sha1]=8dafcc1549658d57248dce883e8ec7eea3d6e8a5, for GNU/Linux 3.2.0, not stripped
> root@number:/home/acme/c#
> 
> root@number:/home/acme/c# strace ./faccessat2 |& head 
> execve("./faccessat2", ["./faccessat2"], 0x7ffce63265e0 /* 39 vars */) = 0
> [ Process PID=2552445 runs in 32 bit mode. ]
> brk(NULL)                               = 0x849a000
> mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fb3000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
> statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_ALL|STATX_MNT_ID|STATX_SUBVOL, stx_attributes=0, stx_mode=S_IFREG|0644, stx_size=85091, ...}) = 0
> mmap2(NULL, 85091, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7f9e000
> close(3)                                = 0
> openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
> root@number:/home/acme/c#
> 
> Before:
> 
> root@number:/home/acme/c# perf trace ./faccessat2 |& head
> faccessat2(123, (null), X_OK, AT_EACCESS | AT_SYMLINK_NOFOLLOW) = -1
>          ? (         ): faccessat2/2552543  ... [continued]: munmap())                                           = 0
>      0.024 ( 0.002 ms): faccessat2/2552543 recvfrom(ubuf: 0x2, size: 4159848428, flags: DONTROUTE|CTRUNC|TRUNC|DONTWAIT|EOR|WAITALL|FIN|SYN|CONFIRM|RST|ERRQUEUE|SOCK_DEVMEM|ZEROCOPY|FASTOPEN|CMSG_CLOEXEC|0x91f20000, addr: 0xe30, addr_len: 0xffcda98c) = 138993664
>      0.047 ( 0.006 ms): faccessat2/2552543 lgetxattr(name: "", value: 0x3, size: 34)                             = 4159602688
>      0.063 ( 0.003 ms): faccessat2/2552543 dup2(oldfd: -135160188, newfd: 4)                                     = -1 ENOENT (No such file or directory)
>      0.071 ( 0.023 ms): faccessat2/2552543 preadv(fd: 4294967196, vec: 0xf7f16420, vlen: 557056, pos_h: 4159848428) = 3
>      0.098 ( 0.004 ms): faccessat2/2552543 lgetxattr(name: "", value: 0x1, size: 2)                              = 4159516672
>      0.104 ( 0.001 ms): faccessat2/2552543 lstat(filename: "", statbuf: 0x14c63)                                 = 0
>      0.114 ( 0.004 ms): faccessat2/2552543 preadv(fd: 4294967196, vec: 0xf7ee8380, vlen: 557056, pos_h: 4159848428) = 3
>      0.118 ( 0.002 ms): faccessat2/2552543 close(fd: 3)                                                          = 512
> root@number:/home/acme/c# 
> 
> After:
> 
> root@number:/home/acme/c# perf trace ./faccessat2 |& head
> faccessat2(123, (null), X_OK, AT_EACCESS | AT_SYMLINK_NOFOLLOW) = -1
> sh: line 1: perf-read-vdso32: command not found
>          ? (         ): faccessat2/2556897  ... [continued]: execve())                                           = 0
>      0.028 ( 0.002 ms): faccessat2/2556897 brk()                                                                 = 0x8fe4000
>      0.068 ( 0.003 ms): faccessat2/2556897 access(filename: 0xf7ff2e84, mode: R)                                 = -1 ENOENT (No such file or directory)
>      0.080 ( 0.005 ms): faccessat2/2556897 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC|LARGEFILE) = 3
>      0.094 ( 0.001 ms): faccessat2/2556897 close(fd: 3)                                                          = 0
>      0.103 ( 0.003 ms): faccessat2/2556897 openat(dfd: CWD, filename: "/lib/libc.so.6", flags: RDONLY|CLOEXEC|LARGEFILE) = 3
>      0.108 ( 0.002 ms): faccessat2/2556897 read(fd: 3, buf: 0xffdd84b0, count: 512)                              = 512
>      0.216 ( 0.001 ms): faccessat2/2556897 close(fd: 3)                                                          = 0
> root@number:/home/acme/c#
> 
> And interestingly the openat syscall got its contents obtained via the
> BPF augmenter... better to test this more thoroughly, but I think it
> should come after this series lands.

Right, I don't see the filename in openat() in my tests.

openat() is 295 on i386 and that's preadv() on x86_64 so BPF won't try
to augment the argument.  I wonder how it can get the filename.  But
anyway we can take a look later.

Thanks,
Namhyung

