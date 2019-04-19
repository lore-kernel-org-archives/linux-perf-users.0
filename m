From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: perf tools build broken after v5.1-rc1
Date: Fri, 19 Apr 2019 16:32:58 -0700
Message-ID: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi,

When building perf for ARC (v5.1-rc2) I get the following

| In file included from bench/futex-hash.c:26:
| bench/futex.h: In function 'futex_wait':
| bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in this function);

git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools headers uapi:
Sync copy of asm-generic/unistd.h with the kernel sources")

The issue is due to hunk below, rightly brought over from commit c8ce48f06503
("asm-generic: Make time32 syscall numbers optional")

+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
-__SC_COMP(__NR_futex, sys_futex, compat_sys_futex)
+__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+#endif

While __ARCH_WANT_TIME32_SYSCALLS does exist in
arch/arc/include/uapi/asm/unistd.h, but not inside tools, essentially we lack a
copy such as below which were sync'ed by commit above as well.

   tools/arch/arm64/include/uapi/asm/unistd.h
   tools/arch/x86/include/uapi/asm/unistd.h

A quick fix for ARC will be to create our own version but I presume all existing
arches using generic syscall abi are affected. Thoughts ? In lack of ideas I'll
send out a patch for ARC.

P.S. Why do we need the unistd.h duplication in tools directory, given it could
have used the in-tree unistd headers directly ?

Thx,
-Vineet
