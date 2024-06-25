Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A616FF59;
	Tue, 25 Jun 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335317; cv=none; b=VJk/Tml0Zo+UDTngQ+PzaQJrZ5G/XMWkgrtKbXqq78mSRW/LPZMuMMI0LhAXJP7RRX9SI+lA44tRRllX8Vk3TwkZuYq00hW2AEFYtgv9nFqn2wAB2tBWQGM7XIw4tDYnHRynUsnQ9lumsBqkNCInU4FCS0SF6iYsvSIIlJcml3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335317; c=relaxed/simple;
	bh=9b/Jh7qZF1wPuFccwNXsPDYutEtI+mhVJ27rAd7t4Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKqEZ8O/3EOnS1twfAYmoUwHE4TZBVcO/GWF0fJAjoS5u4jKvDS7NbQc/7Ea9OKSnOITjSlr5tvyMKYnZcXVgpuf2WsGbo+AGSSUJ+HYKq/R8b/NpFj7j0intsUrdWjBFVcNzTF68T8gseqKLdx8KgOspJYXQpaFK90ygfd8LaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44EBC339;
	Tue, 25 Jun 2024 10:08:59 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B257C3F73B;
	Tue, 25 Jun 2024 10:08:31 -0700 (PDT)
Message-ID: <55b8a9a7-f566-4462-94b5-729a808b0609@arm.com>
Date: Tue, 25 Jun 2024 18:08:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] perf: build: Setup PKG_CONFIG_LIBDIR for cross
 compilation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>,
 Changbin Du <changbin.du@huawei.com>, Fangrui Song <maskray@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Guilherme Amadio <amadio@gentoo.org>
References: <20240610095433.336295-1-leo.yan@arm.com>
 <20240610095433.336295-2-leo.yan@arm.com> <ZnYKUfr4f-0NFw6r@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZnYKUfr4f-0NFw6r@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Namhyung,

On 6/22/24 00:18, Namhyung Kim wrote:
> 
> Hello,
> 
> On Mon, Jun 10, 2024 at 10:54:28AM +0100, Leo Yan wrote:
>> On recent Linux distros like Ubuntu Noble and Debian Bookworm, the
>> 'pkg-config-aarch64-linux-gnu' package is missing. As a result, the
>> aarch64-linux-gnu-pkg-config command is not available, which causes
>> build failures.
>>
>> When a build passes the environment variables PKG_CONFIG_LIBDIR or
>> PKG_CONFIG_PATH, like a user uses make command or a build system
>> (like Yocto, Buildroot, etc) prepares the variables and passes to the
>> Perf's Makefile, the commit keeps these variables for package
>> configuration. Otherwise, this commit sets the PKG_CONFIG_LIBDIR
>> variable to use the Multiarch libs for the cross compilation.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/build/feature/Makefile | 26 +++++++++++++++++++++++++-
>>   tools/perf/Makefile.perf     | 26 +++++++++++++++++++++++++-
>>   2 files changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index ed54cef450f5..084f803093c3 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -82,7 +82,31 @@ FILES=                                          \
>>
>>   FILES := $(addprefix $(OUTPUT),$(FILES))
>>
>> -PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>> +# Some distros provide the command $(CROSS_COMPILE)pkg-config for
>> +# searching packges installed with Multiarch. Use it for cross
>> +# compilation if it is existed.
>> +ifneq (, $(shell which $(CROSS_COMPILE)pkg-config))
>> +  PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>> +else
>> +  PKG_CONFIG ?= pkg-config
>> +
>> +  # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR is required for the cross
>> +  # compilation. If both is not set, try to set the lib paths installed
>> +  # by multiarch.
>> +  ifdef CROSS_COMPILE
>> +    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH),)
> 
> Maybe you want to check PKG_CONFIG_SYSROOT_DIR too.

IIRC, the manual says PKG_CONFIG_SYSROOT_DIR is used alongside
PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH for prepending prefix for
the package paths.

I can add checking PKG_CONFIG_SYSROOT_DIR in the new patch set.

>> +      CROSS_ARCH = $(shell $(CC) -dumpmachine)
>> +      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
>> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
>> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
>> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
>> +      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
> 
> I'm not sure why this ordering.. don't you want to check
> CROSS_ARCH directories first and then /usr/local/share and
> /usr/share directory?

I mainly refered to the script [1] which is an obselete package
('aarch64-linux-gnu-pkg-config') on old Debian/Ubuntu distros.

Your suggestion makes sense to me. I will change order as:

   PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
   PKG_CONFIG_LIBDIR := 
$(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
   PKG_CONFIG_LIBDIR := 
$(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
   PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
   PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/

Thanks,
Leo

[1] https://gist.github.com/doug65536/ea9c52f9a65a655a2fd5cc4997e8443b
