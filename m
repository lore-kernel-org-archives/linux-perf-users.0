Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186B44369;
	Tue, 16 Jul 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124392; cv=none; b=Apwu5BHoxA7dvY7qs2Li6J9BGXvfkOh3LG7xgWdHRMMZ1ZD+KxqzLExKm3IF1AJqOBN93cfcuEDQ99hpUlCMz3ysoZF1criATd6MX43yZLi691EQ29wuHinXkGcEv6MlKXXQ27IlqxAZLI6xFXOX7t3NAObRSy/XaGvOKjXXkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124392; c=relaxed/simple;
	bh=15GE7Kublid/r/h32zPnzD+qmdotNJ/HsZeI1Dk8tSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BY/EJr+tL1S7fIURsnDEElzjHObajxKMf9gcuVzuwgV4qCuT/bY2n2yFaBuvIlOzNwetMP+n7e5kAeBwuKZ6Dw+5Aij+Bu1TMOToTFu4LOeNbJM1xEN/y3lTZdk8XBGvn3DRFBCK7g/v/dY0tCpv38Ke5dyFmXN2n0Kog1aWZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 971421063;
	Tue, 16 Jul 2024 03:06:54 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7195F3F762;
	Tue, 16 Jul 2024 03:06:27 -0700 (PDT)
Message-ID: <a17e6701-4195-4132-8518-fe4b10403f7e@arm.com>
Date: Tue, 16 Jul 2024 11:06:25 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715143342.52236-1-leo.yan@arm.com>
 <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com>
 <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
 <CAP-5=fWY4AeMxfNGh_jB4gss_qtGSgfX4pvv-D-fpCWuqamVfA@mail.gmail.com>
 <f316e3ce-e1e3-45f0-ac78-9af590b58706@arm.com>
 <CAP-5=fU=LguHNi861L4gmgZWXrrgZtG1w5cdw7hXDxnfWyJyMQ@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fU=LguHNi861L4gmgZWXrrgZtG1w5cdw7hXDxnfWyJyMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/15/24 22:21, Ian Rogers wrote:

[...]

> Hmm.. I can repro but I don't see where the string comes from and my
> build is definitely using clang:
> ```
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
> O=/tmp/perf NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_LIBPYTHON=1 CC=clang
> CXX=clang++ V=1
> ...
> clang --target=aarch64-linux-gnu -fintegrated-as  -Wbad-function-cast
> -Wdeclaration-after-statement -Wformat-security -Wformat-y2k
> -Winit-self -Wmissing-declarations -Wmissing-prototypes
> -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls
> -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef
> -Wwrite-strings -Wformat -Wno-type-limits -Wshadow -Wthread-safety
> -DHAVE_SYSCALL_TABLE_SUPPORT -I/tmp/perf/arch/arm64/include/generated
> -DHAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror -DNDEBUG=1 -O3
> -fno-omit-frame-pointer -Wall -Wextra -std=gnu11 -fstack-protector-all
> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -D_LARGEFILE64_SOURCE
> -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -I~/src/tools/perf/util/include
> -I~/src/tools/perf/arch/arm64/include -I~/src/tools/include/
> -I~/src/tools/arch/arm64/include/uapi -I~/src/tools/include/uapi
> -I~/src/tools/arch/arm64/include/ -I~/src/tools/arch/arm64/
> -I/tmp/perf//util -I/tmp/perf/ -I~/src/tools/perf/util
> -I~/src/tools/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
> -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT
> -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_GETTID -DHAVE_FILE_HANDLE
> -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
> -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DNO_LIBPERL
> -DHAVE_TIMERFD_SUPPORT -DNO_LIBPYTHON -DHAVE_BACKTRACE_SUPPORT
> -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT
> -I/tmp/perf/libapi/include -I/tmp/perf/libsubcmd/include
> -I/tmp/perf/libsymbol/include -I/tmp/perf/libperf/include -I/tmp/perf/
> -Wl,-z,noexecstack \
>          /tmp/perf/perf-in.o -Wl,--whole-archive
> /tmp/perf/libapi/libapi.a /tmp/perf/libperf/libperf.a
> /tmp/perf/libsubcmd/libsubcmd.a /tmp/perf/libsymbol/libsymbol.a
> /tmp/perf/libperf-bench.a /tmp/perf/libperf-test.a
> /tmp/perf/libperf-ui.a /tmp/perf/libperf-util.a
> /tmp/perf/libpmu-events.a  -Wl,--no-whole-archive -Wl,--start-group
> -lpthread -lrt -lm -ldl -Wl,--end-group -o /tmp/perf/perf
> $ strings /tmp/perf/perf|grep GCC
> GCC: (Debian 13.2.0-13) 13.2.0
> $ find /tmp/perf -name '*.[oa]' -exec sh -c "strings {} | grep GCC" \; -print
> GCC: (Debian 13.2.0-13) 13.2.0
> /tmp/perf/fixdep.o
> GCC: (Debian 13.2.0-13) 13.2.0
> /tmp/perf/fixdep-in.o
> ```
> fixdep is being compiled with HOSTCC which isn't clang. Some more digging:
> ```
> $ aarch64-linux-gnu-readelf -p .comment /tmp/perf/perf
> 
> String dump of section '.comment':
>   [     0]  GCC: (Debian 13.2.0-13) 13.2.0
>   [    1f]  Debian clang version 16.0.6 (20+build1)
> ```
> So I suspect that the GCC is coming from crt0.o and that the binary
> was built with clang.

Thanks for correcting. Now I even can build successfully with the Clang
from Android NDK with an additional flag 'NO_DEMANGLE=1'. Though we still
need to disable several modules for passing the building, but we are on the 
right way.

Would you like to continue a formal fixing or you want me to follow up?

Thanks,
Leo
