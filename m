Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6714B092;
	Sun,  6 Apr 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743961013; cv=none; b=VZil3y+wSffGy9uyjNJdXD+6LYy+S7q51dkjQB+Meqg5JfQ+xxpyQUi7u7bZec218chFcCGuHdTPbngX5+94RKKPV3z9PxpJVzEzB0qnSU7KRUvX2IyVHgXuknukbZZS3I+m+PpoeSevlPwpGnEgMQou/IGHQ3VXjF2shh7Lu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743961013; c=relaxed/simple;
	bh=1dSNAFo5GSL7d+r5bdIEpzCsGYMFrfwM6VtdmM+UiuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkBRnHSjXP9sn5wMMA9mh85z2Hq4kpBFHkZl995diQY5dVN6pPLjLMmcLvmrAGQfA9Dex3VN+dMqlOg/BLdHO2EjK3tBX1ogaNp6clFz2wODOarZk9cNPjYQ+fF50r7rSXcWe/rwKYYZLhZ9ivzvMI3NpgH0dnZyxmKDxwmjyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQr3BdA8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQr3BdA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BC7C4CEE3;
	Sun,  6 Apr 2025 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743961012;
	bh=1dSNAFo5GSL7d+r5bdIEpzCsGYMFrfwM6VtdmM+UiuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQr3BdA8W46wzs/EphpeSe904lsF0AGIaIwm/GL1VyQW2xcAqmzBvp94RW+gjx9CU
	 B7Iew9i5SK15x3fy4kOFAPY2qnkcFJcrw3A2AJGi8Lb3nbwxXgTE994cOvTVc+FCH0
	 dRaqOToaiJfLEEZBCpQKhOe9hb8y+ljevhwT1zmFgek9BSSvrknRSxNUjMzi6e6VDJ
	 qN3eZsrWEmrBJFjt2ebjEgnnDo2AI/aFwSlk3/O2Im4unQx6PWjMH3hT8Fs97qpFj9
	 gKGToQcqGCMkA3mla5zyRsO1+dL3nuEZHQ86OxDZC5Skw6sxv6aQ+p2KhTQto0Pd/i
	 OLX0RIf2IfdCA==
Date: Sun, 6 Apr 2025 19:36:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Don't set libunwind as available if
 test-all.c build succeeds
Message-ID: <Z_K7ruz8hhvCTbL8@gmail.com>
References: <Z_ArFrHU7hMNUOv3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ArFrHU7hMNUOv3@x1>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> The tools/build/feature/test-all.c file tries to detect the expected,
> most common set of libraries/features we expect to have available to
> build perf with.
> 
> At some point libunwind was deemed not to be part of that set of
> libraries, but the patches making it to be opt-in ended up forgetting
> some details, fix one more.
> 
> Testing it:
> 
>   $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
>   $ rpm -q libunwind-devel
>   libunwind-devel-1.8.0-3.fc40.x86_64
>   $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
>   ...                               libunwind: [ on  ]
>     CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
>     CC      /tmp/build/perf-tools-next/arch/x86/util/unwind-libunwind.o
>     CC      /tmp/build/perf-tools-next/util/arm64-frame-pointer-unwind-support.o
>     CC      /tmp/build/perf-tools-next/tests/dwarf-unwind.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
> 	  libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f615a549000)
> 	  libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f615a52f000)
>   $ sudo rpm -e libunwind-devel
>   $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
>   $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
>   Makefile.config:653: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
>   ...                               libunwind: [ OFF ]
>     CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
>     CC      /tmp/build/perf-tools-next/arch/x86/util/unwind-libdw.o
>     CC      /tmp/build/perf-tools-next/util/arm64-frame-pointer-unwind-support.o
>     CC      /tmp/build/perf-tools-next/tests/dwarf-unwind.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libdw.o
>   $

So I'm not sure whether this is related to my libunwind-OFF build 
message bugreport, but in case it is, with this patch applied I still 
get this message both before and after applying the patch:

...                               libunwind: [ OFF ]

Note: I did not add any LIBUNWIND parameters to the build, it's a 
standard 'make clean install' perf build:

  $ make clean install
  ...
  BUILD:   Doing 'make -j128' parallel build
  ...
  ...                               libunwind: [ OFF ]
  ...

All other feature messages indicate '[ on ]'.

It's on a fairly standard x86-64 Ubuntu 24.10 installation, with 
various development libraries installed. Let me know if you need
any debug output or other information!

Thanks,

	Ingo
