Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306A53ED1D;
	Wed,  9 Sep 2026 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954773; cv=none; b=D0m1hw4N4eyMcwwKEd0b6pzKGJaZnO0m0POw7VfpQMz2NOJA1a2oxt1M9kqEAr0FIHW6JbQfJEnTV0Z/yN4rGq4KLQq0zAr4iuSPB9+7BvsrNLzthLXQxfxuLUxUBYTdQ9YQwDiN8NMpMLMjKSwwcj170Ei1nJccvUaHqU78Xzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954773; c=relaxed/simple;
	bh=PMlcPN1pGdd0les1zHqHbTaXrb5Fa97JWbU40R+JlUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9AMKUnkveGNEDDvV1M3OdCS4SV4+1m+49NYIhnfqjHLzVTrbRcT/t6IU/gC0asxbgBkNNsLv8hRogw7Wz4uqa208WC2keYOHXDmH9SV/s2s7EUsjIX+5CqOjbBT+vF7QHt63q8NFo2xIlz/Eyd7ARceUx8dDDtkERYqSvLVYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmbRqPrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmbRqPrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7B41F00A3A;
	Wed,  9 Sep 2026 11:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954771;
	bh=HX/9u9ZOyn+A65il1ydMpPrAYGvAfJ881m9P59zMh/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RmbRqPrYgdNlWaUzBNmteLc0oXjw9N1SOHkFnHRXB29L8jvAU7loD2kN+qR/fOA22
	 CrDq7ggGAFi/iU3KkFyqdwpZg3BLX0GiR+ETOZeNRLstrd+xsPLcGSS7l1m4nzPcOu
	 9OkoYLGJfIU5QPj7eO5nRW4hnadhxjv0yGdQJTlO68Nc0ivG4Zm4wUJpTmgnCzwSVm
	 qsNNnYCAZcTtZtshl8O6UH+pX4HkiGokxQwtJxeaq7DEIoWu7kj9kGDhZLPvwZuhXj
	 gFxQyAfraGgEBec75hogWWocPeiDplxGjThD/n/C8wZLTb7HQAuGY8YLZevZrVHmx2
	 hg6+ZkSQUbyfQ==
Date: Wed, 9 Sep 2026 08:52:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 0/3] perf tools: port UI from GTK2 to GTK4
Message-ID: <aqFIkFzVvCQqnzpy@x2>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <aqE_QOp-x1aOQsCX@x2>
 <aqFCMfb94Cdumemm@x2>
 <aqFDLQ5Yu7yg6Y2Z@x2>
 <aqFEdSZ40HkvipUr@x2>
 <aqFGVejYb-kZ8o_I@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqFGVejYb-kZ8o_I@x2>

On Wed, Sep 09, 2026 at 08:43:20AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 09, 2026 at 08:35:20AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Sep 09, 2026 at 08:29:52AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Sep 09, 2026 at 08:25:41AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > patching file tools/perf/ui/setup.c
> > > > ⬢ [acme@toolbx perf-tools-next]$
> > > > 
> > > > I fixed it up quickly, now lets see the rest...
> > > 
> > > Trying to build with it with just the first patch in this series in it
> > > correctly discovers that the gtk4 devel files are not available but then
> > > proceed to try to include gtk code and thus fail, where it should just
> > > do what the feature detection states: disable gtk support but build
> > > successfully without it, I'm checking if this is a quick surgery.
> > 
> > This is a pre-existing condition, if I try without your series and
> > without gtk2 devel files, I get the same problem, so I'll now try to
> > build it with the required gtk4 devel files, we can fix this
> > pre-existing problem afterwards, its not a regression introduced by your
> > series.
> 
> Now, with GTK4=1 and trying to build the first patch after installing
> gtk4-devel on fedora 43 it fails to detect gtk4 support:
> 
> ⬢ [acme@toolbx perf-tools-next]$ m
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> 
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                    gtk4: [ OFF ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]

I see, you do it with tools/perf being your cwd, I tried that and it
works now:

⬢ [acme@toolbx perf-tools-next]$ cd tools/perf/
⬢ [acme@toolbx perf]$ make GTK4=1
  BUILD:   Doing 'make -j32' parallel build

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                    gtk4: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                               libpython: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]
...                              libopenssl: [ on  ]
...                                    rust: [ on  ]

  INSTALL libsubcmd_headers
  INSTALL libapi_headers
  PERF_VERSION = 7.3.rc2.g581f81a14c5c
  INSTALL libsymbol_headers
  GEN     perf-archive
  INSTALL libperf_headers
  GEN     perf-iostat
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/core.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/cpumap.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/threadmap.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/evsel.o
  INSTALL libbpf_headers
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/evlist.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/mmap.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/zalloc.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/xyarray.o
  CC      /home/acme/git/perf-tools-next/tools/perf/libperf/lib.o
  LD      /home/acme/git/perf-tools-next/tools/perf/libperf/libperf-in.o
  AR      /home/acme/git/perf-tools-next/tools/perf/libperf/libperf.a
  CC      ui/gtk/browser.o
  CC      jvmti/libjvmti.o
  CC      ui/gtk/hists.o
  CC      arch/common.o
  CC      ui/gtk/setup.o
  CC      trace/beauty/syscalltbl.o
  CC      ui/gtk/util.o
  CC      jvmti/jvmti_agent.o
  CC      ui/gtk/helpline.o
  CC      trace/beauty/arch_errno_names.o
  CC      jvmti/libstring.o
  CC      ui/gtk/progress.o
  CC      jvmti/libctype.o
  CC      ui/gtk/annotate.o
<SNIP>
  LD      perf-bench-in.o
  AR      libperf-bench.a
  LINK    perf
  LINK    libperf-gtk.so
⬢ [acme@toolbx perf]$

I don't think this was present before, lemme try...

My bad, I made a mistake and was trying to build with gtk4 while using
GTK2=1 on the make command line, that I had switched to test building
with gtk2 for that pre-existing problem and forgot to switch back to
GTK4=1 when returning to test your patches...

Now, with it it works as expected, using 'make GTK4=1 -C tools/perf',
building the first patch:

⬢ [acme@toolbx perf-tools-next]$ rm -rf /tmp/build/`basename $PWD` ; mkdir -p /tmp/build/`basename $PWD`
⬢ [acme@toolbx perf-tools-next]$ alias m='rm -rf ~/libexec/perf-core/ ; make -k GTK4=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test import && cat /tmp/build/$(basename $PWD)/feature/test-all.make.output' ; export PYTHONPATH=/tmp/build/$(basename $PWD)/python
⬢ [acme@toolbx perf-tools-next]$ m
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                    gtk4: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                               libpython: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]
...                              libopenssl: [ on  ]
...                                    rust: [ on  ]

  CC      /tmp/build/perf-tools-next/dlfilters/dlfilter-test-api-v0.o
  CC      /tmp/build/perf-tools-next/dlfilters/dlfilter-test-api-v2.o
  CC      /tmp/build/perf-tools-next/dlfilters/dlfilter-show-cycles.o
  GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
<SNIP>
  LINK    /tmp/build/perf-tools-next/perf
  LINK    /tmp/build/perf-tools-next/libperf-gtk.so
  GEN     /tmp/build/perf-tools-next/python/perf.cpython-314-x86_64-linux-gnu.so
  INSTALL GTK UI
  INSTALL binaries
  INSTALL tests
  INSTALL libperf-jvmti.so
  INSTALL libexec
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL python-scripts
install: omitting directory 'scripts/python/Perf-Trace-Util/lib/Perf/Trace/__pycache__'
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
104: 'import perf' in python                                                                                   : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
⬢ [acme@toolbx perf-tools-next]$ 

And, which makes me recall why we made t his a plugin :-)

⬢ [acme@toolbx perf-tools-next]$ ldd /tmp/build/perf-tools-next/libperf-gtk.so
	linux-vdso.so.1 (0x00007f8588fb8000)
	libgtk-4.so.1 => /lib64/libgtk-4.so.1 (0x00007f858854c000)
	libpangocairo-1.0.so.0 => /lib64/libpangocairo-1.0.so.0 (0x00007f8588539000)
	libpango-1.0.so.0 => /lib64/libpango-1.0.so.0 (0x00007f85884cd000)
	libharfbuzz.so.0 => /lib64/libharfbuzz.so.0 (0x00007f8588399000)
	libgdk_pixbuf-2.0.so.0 => /lib64/libgdk_pixbuf-2.0.so.0 (0x00007f858836b000)
	libcairo-gobject.so.2 => /lib64/libcairo-gobject.so.2 (0x00007f8588362000)
	libcairo.so.2 => /lib64/libcairo.so.2 (0x00007f8588222000)
	libvulkan.so.1 => /lib64/libvulkan.so.1 (0x00007f858819a000)
	libgraphene-1.0.so.0 => /lib64/libgraphene-1.0.so.0 (0x00007f858817d000)
	libgio-2.0.so.0 => /lib64/libgio-2.0.so.0 (0x00007f8587faa000)
	libgobject-2.0.so.0 => /lib64/libgobject-2.0.so.0 (0x00007f8587f4b000)
	libglib-2.0.so.0 => /lib64/libglib-2.0.so.0 (0x00007f8587df4000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f8587c00000)
	libgmodule-2.0.so.0 => /lib64/libgmodule-2.0.so.0 (0x00007f8587bfa000)
	libharfbuzz-subset.so.0 => /lib64/libharfbuzz-subset.so.0 (0x00007f8587ac5000)
	libfribidi.so.0 => /lib64/libfribidi.so.0 (0x00007f8587aa5000)
	libfontconfig.so.1 => /lib64/libfontconfig.so.1 (0x00007f8587a55000)
	libepoxy.so.0 => /lib64/libepoxy.so.0 (0x00007f8587949000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f8587852000)
	libgstplay-1.0.so.0 => /lib64/libgstplay-1.0.so.0 (0x00007f858782e000)
	libgstvideo-1.0.so.0 => /lib64/libgstvideo-1.0.so.0 (0x00007f8587759000)
	libgstreamer-1.0.so.0 => /lib64/libgstreamer-1.0.so.0 (0x00007f8587600000)
	libgstgl-1.0.so.0 => /lib64/libgstgl-1.0.so.0 (0x00007f858756d000)
	libgstallocators-1.0.so.0 => /lib64/libgstallocators-1.0.so.0 (0x00007f8587564000)
	librsvg-2.so.2 => /lib64/librsvg-2.so.2 (0x00007f85870a0000)
	libXi.so.6 => /lib64/libXi.so.6 (0x00007f858708d000)
	libX11.so.6 => /lib64/libX11.so.6 (0x00007f8586f48000)
	libpangoft2-1.0.so.0 => /lib64/libpangoft2-1.0.so.0 (0x00007f8586f2c000)
	libtinysparql-3.0.so.0 => /lib64/libtinysparql-3.0.so.0 (0x00007f8586e58000)
	libpng16.so.16 => /lib64/libpng16.so.16 (0x00007f8586e1c000)
	libtiff.so.6 => /lib64/libtiff.so.6 (0x00007f8586d83000)
	libjpeg.so.62 => /lib64/libjpeg.so.62 (0x00007f8586ce1000)
	libxkbcommon.so.0 => /lib64/libxkbcommon.so.0 (0x00007f8586c88000)
	libwayland-client.so.0 => /lib64/libwayland-client.so.0 (0x00007f8586c78000)
	libwayland-egl.so.1 => /lib64/libwayland-egl.so.1 (0x00007f8586c74000)
	libXext.so.6 => /lib64/libXext.so.6 (0x00007f8586c60000)
	libXcursor.so.1 => /lib64/libXcursor.so.1 (0x00007f8586c51000)
	libXdamage.so.1 => /lib64/libXdamage.so.1 (0x00007f8586c4d000)
	libXfixes.so.3 => /lib64/libXfixes.so.3 (0x00007f8586c46000)
	libXrandr.so.2 => /lib64/libXrandr.so.2 (0x00007f8586c39000)
	libXinerama.so.1 => /lib64/libXinerama.so.1 (0x00007f8586c35000)
	libcairo-script-interpreter.so.2 => /lib64/libcairo-script-interpreter.so.2 (0x00007f8586c12000)
	libcups.so.2 => /lib64/libcups.so.2 (0x00007f8586b7c000)
	libcolord.so.2 => /lib64/libcolord.so.2 (0x00007f8586b21000)
	libthai.so.0 => /lib64/libthai.so.0 (0x00007f8586b16000)
	libfreetype.so.6 => /lib64/libfreetype.so.6 (0x00007f8586a4c000)
	libgraphite2.so.3 => /lib64/libgraphite2.so.3 (0x00007f8586a2d000)
	libglycin-2.so.0 => /lib64/libglycin-2.so.0 (0x00007f858660b000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f85865e3000)
	libXrender.so.1 => /lib64/libXrender.so.1 (0x00007f85865d7000)
	libxcb.so.1 => /lib64/libxcb.so.1 (0x00007f85865ad000)
	libxcb-render.so.0 => /lib64/libxcb-render.so.0 (0x00007f858659e000)
	libxcb-shm.so.0 => /lib64/libxcb-shm.so.0 (0x00007f858659a000)
	libpixman-1.so.0 => /lib64/libpixman-1.so.0 (0x00007f85864e9000)
	libmount.so.1 => /lib64/libmount.so.1 (0x00007f8586493000)
	libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f8586462000)
	libffi.so.8 => /lib64/libffi.so.8 (0x00007f8586452000)
	libpcre2-8.so.0 => /lib64/libpcre2-8.so.0 (0x00007f85863a5000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f8588fba000)
	libxml2.so.2 => /lib64/libxml2.so.2 (0x00007f8586245000)
	libgsttag-1.0.so.0 => /lib64/libgsttag-1.0.so.0 (0x00007f8586206000)
	libgstpbutils-1.0.so.0 => /lib64/libgstpbutils-1.0.so.0 (0x00007f85861c1000)
	libgstbase-1.0.so.0 => /lib64/libgstbase-1.0.so.0 (0x00007f858613d000)
	liborc-0.4.so.0 => /lib64/liborc-0.4.so.0 (0x00007f8586099000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f858607c000)
	libdw.so.1 => /lib64/libdw.so.1 (0x00007f8585fdf000)
	libEGL.so.1 => /lib64/libEGL.so.1 (0x00007f8585fce000)
	libGLX.so.0 => /lib64/libGLX.so.0 (0x00007f8585f9d000)
	libwayland-cursor.so.0 => /lib64/libwayland-cursor.so.0 (0x00007f8585f93000)
	libX11-xcb.so.1 => /lib64/libX11-xcb.so.1 (0x00007f8585f8f000)
	libgudev-1.0.so.0 => /lib64/libgudev-1.0.so.0 (0x00007f8585f80000)
	libdrm.so.2 => /lib64/libdrm.so.2 (0x00007f8585f69000)
	libgbm.so.1 => /lib64/libgbm.so.1 (0x00007f8585f63000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f8585f37000)
	libdav1d.so.7 => /lib64/libdav1d.so.7 (0x00007f8585d53000)
	libjson-glib-1.0.so.0 => /lib64/libjson-glib-1.0.so.0 (0x00007f8585d26000)
	libsqlite3.so.0 => /lib64/libsqlite3.so.0 (0x00007f8585bac000)
	libwebp.so.7 => /lib64/libwebp.so.7 (0x00007f8585b26000)
	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f8585a63000)
	libLerc.so.4 => /lib64/libLerc.so.4 (0x00007f85859ce000)
	libjbig.so.2.1 => /lib64/libjbig.so.2.1 (0x00007f85859c0000)
	liblzo2.so.2 => /lib64/liblzo2.so.2 (0x00007f8585998000)
	libgssapi_krb5.so.2 => /lib64/libgssapi_krb5.so.2 (0x00007f8585941000)
	libavahi-common.so.3 => /lib64/libavahi-common.so.3 (0x00007f8585932000)
	libavahi-client.so.3 => /lib64/libavahi-client.so.3 (0x00007f858591e000)
	libgnutls.so.30 => /lib64/libgnutls.so.30 (0x00007f8585679000)
	liblcms2.so.2 => /lib64/liblcms2.so.2 (0x00007f858560f000)
	libudev.so.1 => /lib64/libudev.so.1 (0x00007f85855c5000)
	libdatrie.so.1 => /lib64/libdatrie.so.1 (0x00007f85855bd000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f85855a9000)
	libbrotlidec.so.1 => /lib64/libbrotlidec.so.1 (0x00007f858559b000)
	libseccomp.so.2 => /lib64/libseccomp.so.2 (0x00007f858556f000)
	libXau.so.6 => /lib64/libXau.so.6 (0x00007f858556a000)
	libblkid.so.1 => /lib64/libblkid.so.1 (0x00007f8585530000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f85854fb000)
	libgstaudio-1.0.so.0 => /lib64/libgstaudio-1.0.so.0 (0x00007f8585476000)
	libelf.so.1 => /lib64/libelf.so.1 (0x00007f8585457000)
	libGLdispatch.so.0 => /lib64/libGLdispatch.so.0 (0x00007f85853df000)
	libexpat.so.1 => /lib64/libexpat.so.1 (0x00007f85853b4000)
	libsharpyuv.so.0 => /lib64/libsharpyuv.so.0 (0x00007f85853ac000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007f8585134000)
	libkrb5.so.3 => /lib64/libkrb5.so.3 (0x00007f8585067000)
	libk5crypto.so.3 => /lib64/libk5crypto.so.3 (0x00007f858504f000)
	libcom_err.so.2 => /lib64/libcom_err.so.2 (0x00007f8585049000)
	libkrb5support.so.0 => /lib64/libkrb5support.so.0 (0x00007f8585039000)
	libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x00007f8585033000)
	libcrypto.so.3 => /lib64/libcrypto.so.3 (0x00007f8584af1000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f8584adc000)
	libdbus-1.so.3 => /lib64/libdbus-1.so.3 (0x00007f8584a88000)
	libp11-kit.so.0 => /lib64/libp11-kit.so.0 (0x00007f85848fb000)
	libidn2.so.0 => /lib64/libidn2.so.0 (0x00007f85848ab000)
	libunistring.so.5 => /lib64/libunistring.so.5 (0x00007f85846fe000)
	libtasn1.so.6 => /lib64/libtasn1.so.6 (0x00007f85846e6000)
	libhogweed.so.6 => /lib64/libhogweed.so.6 (0x00007f85846a3000)
	libnettle.so.8 => /lib64/libnettle.so.8 (0x00007f858464d000)
	libgmp.so.10 => /lib64/libgmp.so.10 (0x00007f85845a6000)
	libcap.so.2 => /lib64/libcap.so.2 (0x00007f858459a000)
	libbrotlicommon.so.1 => /lib64/libbrotlicommon.so.1 (0x00007f8584577000)
	libsystemd.so.0 => /lib64/libsystemd.so.0 (0x00007f858444d000)
⬢ [acme@toolbx perf-tools-next]$


