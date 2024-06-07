Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D919048A;
	Fri,  7 Jun 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767188; cv=none; b=p4yrCdIH18WLRSnPZbMMkU8n/X5kEJ6u+NK2K9Y2KUqu+55kKni8tVnD6XbyreyFtz/sGvXOew+so/SN2vW5kNSlPLfRl1pPgJogE8Nu86C+PISf1N5EaQpQ9oaI3CPYoTiV/i9vFUPX/nrGb6nA3mypTWm/uajH5u+Ql+93CzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767188; c=relaxed/simple;
	bh=2Ktr9J43Oe4hlTFBzJRV2+RE98k1HCB3MTdBSiY4z+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWNiqKFs/WMHh6tQKopaotqZ/yyq712T96mUTv4J8inbQ7qewAyzQGVRCOxaMiSCtQu+R2gTT8xY9Y1KeCRds6ZdpX2iZImt4kEyVtKscWJWnfa4PR13LjxAwjArX4Fz7aSqgB8LNgzBelXgzZDDgFrIWF6MbtUEQ1f7vRwjs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6318E153B;
	Fri,  7 Jun 2024 06:33:29 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B2903F792;
	Fri,  7 Jun 2024 06:33:03 -0700 (PDT)
Message-ID: <4a174cd7-7b52-40f8-b190-dc8fe90a7e39@arm.com>
Date: Fri, 7 Jun 2024 14:33:01 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] perf: build: Only link libebl.a for old libdw
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>,
 Ian Rogers <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Terrell <terrelln@fb.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Changbin Du <changbin.du@huawei.com>, Fangrui Song <maskray@google.com>,
 Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240604093223.1934236-1-leo.yan@arm.com>
 <20240604093223.1934236-5-leo.yan@arm.com> <ZmH0nCxLm5_Xl3Yo@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZmH0nCxLm5_Xl3Yo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 18:40, Namhyung Kim wrote:

[...]

>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index 6f52f892f9a3..2f4cfb7b8c14 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -159,7 +159,17 @@ $(OUTPUT)test-libopencsd.bin:
>>
>>   DWARFLIBS := -ldw
>>   ifeq ($(findstring -static,${LDFLAGS}),-static)
>> -DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
>> +  DWARFLIBS += -lelf -lz -llzma -lbz2
>> +
>> +  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
>> +  LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
>> +  LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
>> +
>> +  # Elfutils merged libebl.a into libdw.a starting from version 0.177,
>> +  # Link libebl.a only if libdw is older than this version.
>> +  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
>> +    DWARFLIBS += -lebl
>> +  endif
>>   endif
> 
> Is there a better way to collect required libraries using pkg-config?
> I guess that's what we want to with the pkg-config in the first place.
> Maybe `pkg-config --print-requires-private libdw` ?

Unfortunately, `pkg-config --print-requires-private libdw` does not work 
for the libebl.a after checked on Debian:buster.

   # pkg-config --modversion libdw
   0.176

   # pkg-config --print-requires-private libdw
   zlib
   liblzma

   # pkg-config --libs-only-l libdw
   -ldw -lelf

   # ldd /usr/lib/x86_64-linux-gnu/libdw.so
	linux-vdso.so.1 (0x00007fff733e3000)
	libelf.so.1 => /usr/lib/x86_64-linux-gnu/libelf.so.1 (0x0000702e24ec6000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x0000702e24ec1000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x0000702e24ea3000)
	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x0000702e24e7b000)
	libbz2.so.1.0 => /lib/x86_64-linux-gnu/libbz2.so.1.0 (0x0000702e24e68000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x0000702e24ca8000)
	/lib64/ld-linux-x86-64.so.2 (0x0000702e24f3e000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 
(0x0000702e24c85000)


I think libdw.pc cannot reflect the required dependencies, we still need 
to use a way liked in this patch (it is a bit ugly :) to link '-lebl'.

Thanks,
Leo
