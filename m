From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 19/28] perf beauty: Wire up the mmap flags table
 generator to the Makefile
Date: Mon, 5 Nov 2018 15:46:12 -0300
Message-ID: <20181105184612.GD7077@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-20-acme@kernel.org>
 <20181105154433.GA11115@roeck-us.net>
 <20181105171140.GD11147@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105171140.GD11147@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Nov 05, 2018 at 02:11:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 05, 2018 at 07:44:33AM -0800, Guenter Roeck escreveu:
> > On Wed, Oct 31, 2018 at 01:44:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>

> > > Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:

> > >   $ cat /tmp/build/perf/trace/beauty/generated/mmap_flags_array.c
> > >   static const char *mmap_flags[] = {
> > > 	[ilog2(0x40) + 1] = "32BIT",
<SNIP>
> > > +include ../scripts/Makefile.arch

> > >  # The default target of this Makefile is...
> > >  all:
> > > @@ -385,6 +386,8 @@ export INSTALL SHELL_PATH
> > >  SHELL = $(SHELL_PATH)

> > >  linux_uapi_dir := $(srctree)/tools/include/uapi/linux
> > > +asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
> > > +arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/

> > This doesn't work for me. With v4.20-rc1:

> > $ make ARCH=x86_64 defconfig
> > *** Default configuration is based on 'x86_64_defconfig'
 
> I'll fix this, its the ARCH that needs to be normalized to x86 before
> building the path...

Can you try with the following patch?

Thanks,

- Arnaldo

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3ccb4f0bf088..d95655489f7e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -387,7 +387,7 @@ SHELL = $(SHELL_PATH)
 
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
-arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
+arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
