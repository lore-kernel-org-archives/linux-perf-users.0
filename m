Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F962EB5A1
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342894; cv=none; b=EfbmcrGooUr3efNGN1U4v67gzwY6kcSeFg6wlFQij6WxJkePc7gWpFROmvJeJ6ZHCRGDJhu53iS0iwRtd/d+bxRifW8+v4zg81Y3NgYrzvcvPNz9AzV+2pJh0weRgEmL6AltwEtfAzC7gxEKx9y2lran6ti2LZYowSsE2Tv3E1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342894; c=relaxed/simple;
	bh=hxbMiKWHABlxCO+9GLfBy9IZNmOoeNGOwOAu7TFR9YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iMFskud6bOliR3bhRoV88d72pcV2TT0zGgpnTw8SUArD34OoN6YDNJC1xvZuiZJJ6Mtwv0SRhXtOXENPS5YLH2yDw3hf8d8sCPUiC9XHerBgxOpmLBYPPQdNP2prlmwQj2vS4/sBK9HIq9YJtCT0SEf6bJOtURPyQNNzhiXE+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDKHGhD5; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDKHGhD5"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-37634d352dfso26013661fa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760342891; x=1760947691; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz2QGidhgo+X/Fpd+rZ1lAEe7FF+RTcu3YPeYbCkLMw=;
        b=IDKHGhD5RBk86ctzZbtJYCKi+6b01UkELHu8/Merm4de4z674kj8eNlpavEivOhbSr
         MOSDtJFYj7MlPOb3QAuuN9F5dbR1FhSsh2i2iMc/pmK36gvOZ4rjSHmP9DahtTRXE3Jb
         DMkQdRn0/13vPojVy0LZmULpGlW3BvmB6IYeO9GCGE9EiW3NAhOjtFP4M/NStG6nyCdQ
         lilnRDH0RoNSMtJYTQzGKlVwNVLjpm+tLPsxa8MxbdnubQE8n9s0y7MJsQhm2f/4uOcz
         f7VhICo5rGLDLTVMRaJ/gTvQQBlDT8LmG5QtvpuQ3nk2MHJz/neO3mwrGPxrLscIeNuC
         xNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342891; x=1760947691;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bz2QGidhgo+X/Fpd+rZ1lAEe7FF+RTcu3YPeYbCkLMw=;
        b=kIntZNY7fonJrupqJ1ZIJSfWuNxg2uXUeiw5JG/D8cKFvitNT1oVJU6B+vPTuxJdv2
         4Z1fL2dmhr+3fQOobpsUKcD0A9DPMmIc+wku+A+83QRs2ztUMUtsrcNEUK9vlmXdHMBv
         ohzdNmN8le3rznsAq8Zy7VEsl8RnkD3S5VZyeKZb7Frj1Jl4sE5ueVX+f7C9aDvj6OAr
         UQ1copvled/fvCt4noULdMN54FxDos19/zCkE3jen66H1nUjFtwMt9Vt6HI9+xHcv/M4
         u/D9jZqV850gHGZaOxH2VHOrMCSyj+3Y7WJ5QkgkytcJZsRf5xyvcccyeGo21KRC2RK0
         z7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYh4Lpq4vu4kNqg/w1JiWbuc9jC2Spo+bVc3438RwK42wq7y+j/Bnf5DmBYLehFIJ35GLZdaG1woOjaRnoGx7E@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+2G7vAtClncgBc8hYD3GClspB+h56UtYmk0hc/ayRaHfsUB9
	GD1kBiwfZpRRtqzWWKroJQWLe6++mKJ4p13BvybwVFRNPe2d6votb1rHaU+EGaOCSrYLbD/6GfY
	F9JilnYtqccbs1K+PD6lqZNutb37Qttg=
X-Gm-Gg: ASbGncu8B19EGNnQPXmOGhpLNVIH/ll0MbcqQuaSJlOKNdnUhl66vn3HDZa5F24uaLE
	Z+Sru60GP4y11oFAN7MvQmJ8Ehu2RXhdzClQXlvrN5VDRCbySHJS8iyqV0KzLFc2JyfKm6GGRdX
	ibuygXlCBYsI9LMEhCr/NCVASGSxYOUR3iI2iKKpJt5gjeOOESpUAFbfUF5ykp6NTamKBqg3PbL
	5NjvOFcd+2OKvr6tqM/F+ktPuwLI/iHINfVqw==
X-Google-Smtp-Source: AGHT+IEdRH2/twiTxUCsz2FNdqKhR4MJ7K55PctExmYC7IkUC3AAryzqJYOqRlICWr6mCwVYMBZBSQTtXPuwhbKdCl4=
X-Received: by 2002:a05:651c:2126:b0:372:921b:4b7e with SMTP id
 38308e7fff4ca-37609e46310mr51245101fa.27.1760342890304; Mon, 13 Oct 2025
 01:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com>
In-Reply-To: <20251013080609.2070555-1-hupu.gm@gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 13 Oct 2025 16:07:58 +0800
X-Gm-Features: AS18NWDWUG__4MWsbz9WXnhdDbqgwYSwIyPc7H86fNfD4Zzu1kXnX_kRb05Hvug
Message-ID: <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: namhyung@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Maintainer,

I encountered some issues while cross-compiling perf (ARCH=arm64),
particularly when enabling the BPF option. During the build, Clang
fails to compile BPF programs due to missing header files. The
relevant error messages are as follows:


---------------------------------------
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/crosstool-ng/output/aarch64-dumpstack-linux-gnu/bin/../aarch64-dumpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libzstd.a
when searching for -lzstd
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/crosstool-ng/output/aarch64-dumpstack-linux-gnu/bin/../aarch64-dumpstack-linux-gnu/sysroot/usr/lib/libc.a
when searching for -lc
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-dso_dlfcn.o):
in function `dlfcn_globallookup':
(.text+0x1f): warning: Using 'dlopen' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-bio_addr.o):
in function `BIO_lookup_ex':
(.text+0xdbc): warning: Using 'getaddrinfo' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-bio_sock.o):
in function `BIO_gethostbyname':
(.text+0x85): warning: Using 'gethostbyname' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_event.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:5
| #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_event.h:19:
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_event.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
1 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o]
Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_event.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
1 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o]
Error 1
1 error generated.
1 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o]
Error 1
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o]
Error 1
make[2]: *** [Makefile.perf:289: sub-make] Error 2
make[1]: *** [Makefile:76: all] Error 2
make: *** [Makefile:93: perf] Error 2
---------------------------------------


This happens because the eBPF part of perf is compiled with Clang,
which by default searches only the host /usr/include/ paths for
headers, not the cross-compilation sysroot. As a result, it cannot
find the ARM64-specific asm/ioctl.h.

To address this issue, I wrote a patch that introduces a new make
variable, EXTRA_CLANG_FLAGS. This allows passing custom Clang options
via the command line during the BPF skeleton build, for example
--sysroot or custom include paths, without modifying Makefile.perf
itself.

Example usage:
  EXTRA_CLANG_FLAGS="--sysroot=$SYSROOT"
  make perf ARCH=arm64 EXTRA_CLANG_FLAGS="$EXTRA_CLANG_FLAGS"

I have tested this approach and it works. However, I am not sure if
this is the optimal solution, so I would like to discuss this further
with you and get your feedback.

Thanks,
hupu
