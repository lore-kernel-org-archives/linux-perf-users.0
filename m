From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: perf tools build broken after v5.1-rc1
Date: Mon, 29 Apr 2019 17:14:54 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org> <20190425214800.GC21829@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On 4/25/19 2:48 PM, Arnaldo Carvalho de Melo wrote:=0A=
> Em Mon, Apr 22, 2019 at 12:20:27PM -0300, Arnaldo Carvalho de Melo escrev=
eu:=0A=
>> Em Fri, Apr 19, 2019 at 04:32:58PM -0700, Vineet Gupta escreveu:=0A=
>>> When building perf for ARC (v5.1-rc2) I get the following=0A=
>>  =0A=
>>> | In file included from bench/futex-hash.c:26:=0A=
>>> | bench/futex.h: In function 'futex_wait':=0A=
>>> | bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in this=
 function);=0A=
>>  =0A=
>>> git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools head=
ers uapi:=0A=
>>> Sync copy of asm-generic/unistd.h with the kernel sources")=0A=
>> Humm, I have to check why this:=0A=
>>=0A=
>> [perfbuilder@quaco ~]$ podman images | grep ARC=0A=
>> docker.io/acmel/linux-perf-tools-build-fedora                24-x-ARC-uC=
libc          4c259582a8e6   5 weeks ago      846 MB=0A=
>> [perfbuilder@quaco ~]$=0A=
>>=0A=
>> isn't catching this... :-\=0A=
>>=0A=
>> FROM docker.io/fedora:24=0A=
>> MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>=0A=
>> ENV TOOLCHAIN=3Darc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_inst=
all=0A=
>> ENV CROSS=3Darc-linux-=0A=
>> ENV SOURCEFILE=3D${TOOLCHAIN}.tar.gz=0A=
>> RUN dnf -y install make flex bison binutils gcc wget tar bzip2 bc findut=
ils xz=0A=
>> RUN wget https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.c=
om_foss-2Dfor-2Dsynopsys-2Ddwc-2Darc-2Dprocessors_toolchain_releases_downlo=
ad_arc-2D2017.09-2Drc2_-24-257BSOURCEFILE-257D&d=3DDwIDaQ&c=3DDPL6_X_6JkXFx=
7AXWqB0tg&r=3D7FgpX6o3vAhwMrMhLh-4ZJey5kjdNUwOL2CWsFwR4T8&m=3DHjtufCLozrW47=
pS5C2YH3safLHQE7eEtmHFZsSWrz1M&s=3D29g4oKvGuYcLgheCUvZh3wojhhljivpLd8aj7Ur4=
sKQ&e=3D=0A=
>> <SNIP>=0A=
>> COPY rx_and_build.sh /=0A=
>> ENV EXTRA_MAKE_ARGS=3DNO_LIBBPF=3D1=0A=
>> ENV ARCH=3Darc=0A=
>> ENV CROSS_COMPILE=3D/${TOOLCHAIN}/bin/${CROSS}=0A=
>> ENV EXTRA_CFLAGS=3D-matomic=0A=
> So, now I have a libnuma crossbuilt in this container that allows me to=
=0A=
> build a ARC perf binary linked with zlib and numactl-devel, but only=0A=
> after I applied the fix below.=0A=
>=0A=
> Can you please provide the feature detection header in the build? I.e.=0A=
> what I have with my ARC cross build container right now, after applying=
=0A=
> the patch below is:=0A=
>=0A=
> [perfbuilder@60d5802468f6 perf]$ make $EXTRA_MAKE_ARGS ARCH=3D$ARCH CROSS=
_COMPILE=3D$CROSS_COMPILE EXTRA_CFLAGS=3D"$EXTRA_CFLAGS" -C /git/perf/tools=
/perf O=3D/tmp/build/perf=0A=
> make: Entering directory '/git/perf/tools/perf'=0A=
>   BUILD:   Doing 'make -j8' parallel build=0A=
> sh: line 0: command: -c: invalid option=0A=
> command: usage: command [-pVv] command [arg ...]=0A=
>=0A=
> Auto-detecting system features:=0A=
> ...                         dwarf: [ OFF ]=0A=
> ...            dwarf_getlocations: [ OFF ]=0A=
> ...                         glibc: [ on  ]=0A=
=0A=
Not related to current issue, this run uses a uClibc toolchain and yet it i=
s=0A=
detecting glibc - doesn't seem right to me.=0A=
=0A=
> ...                          gtk2: [ OFF ]=0A=
> ...                      libaudit: [ OFF ]=0A=
> ...                        libbfd: [ OFF ]=0A=
> ...                        libelf: [ OFF ]=0A=
> ...                       libnuma: [ on  ]=0A=
=0A=
Wondering why that is - for me numa is off - even when using a glibc toolch=
ain.=0A=
=0A=
> ...        numa_num_possible_cpus: [ on  ]=0A=
> ...                       libperl: [ OFF ]=0A=
> ...                     libpython: [ OFF ]=0A=
> ...                      libslang: [ OFF ]=0A=
> ...                     libcrypto: [ OFF ]=0A=
> ...                     libunwind: [ OFF ]=0A=
> ...            libdw-dwarf-unwind: [ OFF ]=0A=
> ...                          zlib: [ OFF ]=0A=
> ...                          lzma: [ OFF ]=0A=
> ...                     get_cpuid: [ OFF ]=0A=
> ...                           bpf: [ on  ]=0A=
> ...                        libaio: [ OFF ]=0A=
> ...        disassembler-four-args: [ OFF ]=0A=
>=0A=
>=0A=
=0A=
For my glibc toolchain, here's the feature detection output=0A=
=0A=
Auto-detecting system features:=0A=
...                         dwarf: [ on  ]=0A=
...            dwarf_getlocations: [ OFF ]=0A=
...                         glibc: [ on  ]=0A=
...                          gtk2: [ OFF ]=0A=
...                      libaudit: [ OFF ]=0A=
...                        libbfd: [ OFF ]=0A=
...                        libelf: [ on  ]=0A=
...                       libnuma: [ OFF ]=0A=
...        numa_num_possible_cpus: [ OFF ]=0A=
...                       libperl: [ OFF ]=0A=
...                     libpython: [ OFF ]=0A=
...                      libslang: [ OFF ]=0A=
...                     libcrypto: [ OFF ]=0A=
...                     libunwind: [ OFF ]=0A=
...            libdw-dwarf-unwind: [ OFF ]=0A=
...                          zlib: [ OFF ]=0A=
...                          lzma: [ OFF ]=0A=
...                     get_cpuid: [ OFF ]=0A=
...                           bpf: [ on  ]=0A=
...                        libaio: [ on  ]=0A=
...        disassembler-four-args: [ OFF ]=0A=
=0A=
=0A=
