From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf tools build broken after v5.1-rc1
Date: Mon, 22 Apr 2019 12:20:27 -0300
Message-ID: <20190422152027.GB11750@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Arnd Bergmann <arnd@arndb.de>, lkml <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Apr 19, 2019 at 04:32:58PM -0700, Vineet Gupta escreveu:
> When building perf for ARC (v5.1-rc2) I get the following
 
> | In file included from bench/futex-hash.c:26:
> | bench/futex.h: In function 'futex_wait':
> | bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in this function);
 
> git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools headers uapi:
> Sync copy of asm-generic/unistd.h with the kernel sources")

Humm, I have to check why this:

[perfbuilder@quaco ~]$ podman images | grep ARC
docker.io/acmel/linux-perf-tools-build-fedora                24-x-ARC-uClibc          4c259582a8e6   5 weeks ago      846 MB
[perfbuilder@quaco ~]$

isn't catching this... :-\

FROM docker.io/fedora:24
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
ENV TOOLCHAIN=arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install
ENV CROSS=arc-linux-
ENV SOURCEFILE=${TOOLCHAIN}.tar.gz
RUN dnf -y install make flex bison binutils gcc wget tar bzip2 bc findutils xz
RUN wget https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/arc-2017.09-rc2/${SOURCEFILE}
<SNIP>
COPY rx_and_build.sh /
ENV EXTRA_MAKE_ARGS=NO_LIBBPF=1
ENV ARCH=arc
ENV CROSS_COMPILE=/${TOOLCHAIN}/bin/${CROSS}
ENV EXTRA_CFLAGS=-matomic

I have to update this to fedora 29 or 30 and get a newer toolchain...
 
> The issue is due to hunk below, rightly brought over from commit c8ce48f06503
> ("asm-generic: Make time32 syscall numbers optional")
 
> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>  #define __NR_futex 98
> -__SC_COMP(__NR_futex, sys_futex, compat_sys_futex)
> +__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
> +#endif
 
> While __ARCH_WANT_TIME32_SYSCALLS does exist in
> arch/arc/include/uapi/asm/unistd.h, but not inside tools, essentially we lack a
> copy such as below which were sync'ed by commit above as well.
 
>    tools/arch/arm64/include/uapi/asm/unistd.h
>    tools/arch/x86/include/uapi/asm/unistd.h

So yeah, we need to grab those copies that define something that is used
conditionally by something we have in tools, I'm trying to cook up a
patch grabbing the missing tools/arch/*/include/uapi/asm/unistd.h files,
will they fire a container test build that should cover lots of the
archs.

thanks for the report, will get back here with a report of the results
or else you'll get the patch flying to Ingo for tip/perf/urgent.
 
> A quick fix for ARC will be to create our own version but I presume all existing
> arches using generic syscall abi are affected. Thoughts ? In lack of ideas I'll
> send out a patch for ARC.
> 
> P.S. Why do we need the unistd.h duplication in tools directory, given it could
> have used the in-tree unistd headers directly ?

I have to write down the explanation and have it in a file, but we can't
use anything in the kernel from outside tools/ to avoid adding a burden
to kernel developers that would then have to make sure that the changes
that they make outside tools/ don't break things living there.

- Arnaldo
