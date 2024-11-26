Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCD1BBBC9;
	Tue, 26 Nov 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656225; cv=none; b=Fr+JMeK9Q8nFrhvp9CwWHzhHaFSdNWALKbjQ3fMoqyJaSMw3WTogSpxHPhdR1o/Kth2GAOkLpeIObA74HLcou56br5/JfrkLiVUtJ2DWGtSvsRvRMocbm+i+romPD2hIgn1wv7r672kVUbFRw9+Y3hSwVbxQzqpl08T4s8xBcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656225; c=relaxed/simple;
	bh=+4cak4AD+EKtDVgADHKyTvjrNEL4RZ5ds2BhcayRHUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SHoQO4I/31i/HPUX99kGsLA30/+W8Aos8f88VZhTCNKXKf0FOuJqNDQ1bjpYL1snavYAh/e67KlQwH0wZjz3uoTh6c22Ne4STvLhzeg/P6Yf1ia3mZE7ziuMqChlbhsuqeda1TmkhHoptLBO2G39OiU2ah7oDFUqrx/mWYO4u6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3O6Q6zH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3O6Q6zH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA3C4CECF;
	Tue, 26 Nov 2024 21:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732656225;
	bh=+4cak4AD+EKtDVgADHKyTvjrNEL4RZ5ds2BhcayRHUY=;
	h=Date:From:To:Cc:Subject:From;
	b=s3O6Q6zHaFeNNhd5cooYjdl8yCNs7VhpmTZkfinbg8OzcIKfGVdqoZLbVNVjKEapn
	 bu7JgY6yBvbAJzcpLj+FEy/T9lydZheJ6Z4YB5B4N02p16BrW2yEGzH6x7pQdZI/O8
	 8Uh8nRaID+2URpjlsSUpHo0ph7DUVi8UXqg7yTbmjRFEMfWiQLxsZf61w8tL+seSP0
	 5RLK3fxKEfwSxg5XeSlOwod6uGNDB4i9nHtZxl3PNgsQM9M5qpthB0nVjuWWdMUQbu
	 2vAcETMoEUmR2Nrzre8rV+Do8zmPeemMh2Vwkw5aod+MOnss2Ywr2EgP0/v++CweuU
	 LGVOio94/WZ/Q==
Date: Tue, 26 Nov 2024 18:23:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 perf-tools] tools riscv: Include fence.h from the same
 directory barrier.h lives
Message-ID: <Z0Y8XQMBXT5JdOAG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When cross building perf to riscv I noticed that it isn't finding the
asm/fence.h file included from tools/arch/riscv/include/asm/barrier.h,
since both live in the same directory, load it from there instead of
from asm/fence.h, fixing the libbpf build in such environment:

  perfbuilder@number:~$ time dm ubuntu:22.04-x-riscv64
     1     4.32 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
                       from mmap.c:7:
      /git/perf-6.12.0-rc6/tools/include/asm/../../arch/riscv/include/asm/barrier.h:13:10: fatal error: asm/fence.h: No such file or directory
         13 | #include <asm/fence.h>
            |          ^~~~~~~~~~~~~
      compilation terminated.
  <SNIP other similar errors>

This probably should work in other systems where the right asm/fence.h
is available, but in the above scenario, it fails. Probably we should
fix the perf build system to find it in tools/arch/riscv/include/asm/,
but this one-liner should be a stop gap solution till we get there.

Testing it:

  perfbuilder@number:~$ time dm ubuntu:22.04-x-riscv64
     1    21.65 ubuntu:22.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0  flex 2.6.4
  BUILD_TARBALL_HEAD=800d169e2d39e4e81ade326d73ae7c4343c12b45
  $ git log --oneline -1 800d169e2d39e4e81ade326d73ae7c4343c12b45
  800d169e2d39e4e8 tools riscv: Include fence.h from the same directory barrier.h lives
  toolsbuilder@number:~/perf-6.12.0-rc6$ ls -la /tmp/build/perf/perf
  -rwxr-xr-x. 1 toolsbuilder toolsbuilder 3278728 Nov 26 21:12 /tmp/build/perf/perf
  toolsbuilder@number:~/perf-6.12.0-rc6$ file /tmp/build/perf/perf
  /tmp/build/perf/perf: ELF 64-bit LSB pie executable, UCB RISC-V, RVC, double-float ABI, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, BuildID[sha1]=9b77bbf51da74cee24c6d5fc5814343cc7e9a652, for GNU/Linux 4.15.0, with debug_info, not stripped
  toolsbuilder@number:~/perf-6.12.0-rc6$
  toolsbuilder@number:~/perf-6.12.0-rc6$ readelf -d /tmp/build/perf/perf | head
  Dynamic section at offset 0x242db0 contains 33 entries:
    Tag        Type                         Name/Value
   0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
   0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
   0x0000000000000001 (NEEDED)             Shared library: [libelf.so.1]
   0x0000000000000001 (NEEDED)             Shared library: [libdw.so.1]
   0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
   0x0000000000000001 (NEEDED)             Shared library: [ld-linux-riscv64-lp64d.so.1]
   0x0000000000000020 (PREINIT_ARRAY)      0x238740
  toolsbuilder@number:~/perf-6.12.0-rc6$

Fixes: 6d74d178fe6eaf61 ("tools: Add riscv barrier implementation")
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/riscv/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/riscv/include/asm/barrier.h b/tools/arch/riscv/include/asm/barrier.h
index 6997f197086ddf61..e78241632e2f1301 100644
--- a/tools/arch/riscv/include/asm/barrier.h
+++ b/tools/arch/riscv/include/asm/barrier.h
@@ -10,7 +10,7 @@
 #ifndef _TOOLS_LINUX_ASM_RISCV_BARRIER_H
 #define _TOOLS_LINUX_ASM_RISCV_BARRIER_H
 
-#include <asm/fence.h>
+#include "fence.h"
 #include <linux/compiler.h>
 
 /* These barriers need to enforce ordering on both devices and memory. */
-- 
2.47.0

