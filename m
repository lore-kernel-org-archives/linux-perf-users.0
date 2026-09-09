Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792863D170C;
	Wed,  9 Sep 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954201; cv=none; b=ZF6QXMtAAQ38p5kajbni4XDcrIBwdZ9866CKHiEwoszmgPZH8Q+szKZkE6+k1WJ0Iro99P+P/U7TkdsBYHq+zdzhr+SVggOjDDj3aJxW0J8nAw8rBCYULKYeaCvOOLicRela92m0YkMG9+pIVP557p99nhpLMpE15DvXZ0wmjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954201; c=relaxed/simple;
	bh=rtUQvmc7sOfK/aLokMLWqH+yfzVrRGi/fnhxtvCH6Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGCHPj0zttjzq3AyhRTDRQD8JLtFltcp4Bqv9pFay8Ri8oXMPaq9K6ySflQPwJe+T72hsFgT9LAGLhuIN3WKKl3A1iOA3oDV5CH6licCmdiOdrH3uZn/Dmu0A0nToLcqnWYBqTfUGqurbAUu71vszkGOtVxkAcASK1sM8gZ1foY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHPtqqwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHPtqqwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8EE1F00A3D;
	Wed,  9 Sep 2026 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954200;
	bh=+zNCqgsES4lsEjZbgikUYk7qmS9/TBEqFNk5Bjzu1Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XHPtqqwJKmWsKCbEB8uLDrxP2lqjj2VGR1rYPZ26WuVXpRCaK5LZiQOnFMJFJ6KIK
	 Z4v5rMg9s8rpqQW7KcaqjME1K4xvaj317NC0xxSxWbYaKtO2jFzG51ZxJchEDiFnBa
	 A7wK6XMtjtCttxTzUCHWV5IaUv9wE3JmTEaRXlM3qkHLXpO1iqxo9vPmDo1o9NyGPb
	 j1/wzgoM7/5/qrpgBCK4QmQplvDl8c+5oX5NH29OxIDufRw9r5zbZPZuoCKugZ4sv1
	 zM1P5o5Tm9TdPT3N5UVYBD4k1cfrZ3dyKmRWIabuW3YN4XUlWXk3s/LLrBXxP8tV7r
	 TpzFozuAnnLJg==
Date: Wed, 9 Sep 2026 08:43:17 -0300
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
Message-ID: <aqFGVejYb-kZ8o_I@x2>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <aqE_QOp-x1aOQsCX@x2>
 <aqFCMfb94Cdumemm@x2>
 <aqFDLQ5Yu7yg6Y2Z@x2>
 <aqFEdSZ40HkvipUr@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqFEdSZ40HkvipUr@x2>

On Wed, Sep 09, 2026 at 08:35:20AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 09, 2026 at 08:29:52AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Sep 09, 2026 at 08:25:41AM -0300, Arnaldo Carvalho de Melo wrote:
> > > patching file tools/perf/ui/setup.c
> > > ⬢ [acme@toolbx perf-tools-next]$
> > > 
> > > I fixed it up quickly, now lets see the rest...
> > 
> > Trying to build with it with just the first patch in this series in it
> > correctly discovers that the gtk4 devel files are not available but then
> > proceed to try to include gtk code and thus fail, where it should just
> > do what the feature detection states: disable gtk support but build
> > successfully without it, I'm checking if this is a quick surgery.
> 
> This is a pre-existing condition, if I try without your series and
> without gtk2 devel files, I get the same problem, so I'll now try to
> build it with the required gtk4 devel files, we can fix this
> pre-existing problem afterwards, its not a regression introduced by your
> series.

Now, with GTK4=1 and trying to build the first patch after installing
gtk4-devel on fedora 43 it fails to detect gtk4 support:

⬢ [acme@toolbx perf-tools-next]$ m
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                    gtk4: [ OFF ]
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


And:

⬢ [acme@toolbx perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-gtk4.make.output
cat: /tmp/build/perf-tools-next/feature/test-gtk4.make.output: No such file or directory
⬢ [acme@toolbx perf-tools-next]$ ls -la /tmp/build/perf-tools-next/feature/test-gtk4*
ls: cannot access '/tmp/build/perf-tools-next/feature/test-gtk4*': No such file or directory
⬢ [acme@toolbx perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output 
⬢ [acme@toolbx perf-tools-next]$ ldd /tmp/build/perf-tools-next/feature/test-all.
test-all.bin          test-all.d            test-all.make.output  
⬢ [acme@toolbx perf-tools-next]$ ldd /tmp/build/perf-tools-next/feature/test-all.bin 
	linux-vdso.so.1 (0x00007f271bb90000)
	libdw.so.1 => /lib64/libdw.so.1 (0x00007f271bae1000)
	libpython3.14.so.1.0 => /lib64/libpython3.14.so.1.0 (0x00007f271b4a7000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f271b3b2000)
	libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007f271b391000)
	libelf.so.1 => /lib64/libelf.so.1 (0x00007f271b374000)
	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007f271b366000)
	libslang.so.2 => /lib64/libslang.so.2 (0x00007f271b072000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f271b04a000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f271b015000)
	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f271af52000)
	libssl.so.3 => /lib64/libssl.so.3 (0x00007f271ae67000)
	libcrypto.so.3 => /lib64/libcrypto.so.3 (0x00007f271a925000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f271a731000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f271a71d000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f271bb92000)
⬢ [acme@toolbx perf-tools-next]$

Meaning its feature detection isn't being called at all, remains at
undetected:

⬢ [acme@toolbx perf-tools-next]$ grep gtk4 /tmp/build/perf-tools-next/FEATURE-DUMP
⬢ [acme@toolbx perf-tools-next]$

Probably this is pre-existing, but I wonder how you managed to test
then?

- Arnaldo
