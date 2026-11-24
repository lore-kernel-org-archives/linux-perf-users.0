Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541741;
	b=d2a6MyeV0Wkgb7oFa4mxOi/bxiiGw1Fn3l4VGBOsbNad7qx9nhAseCO9tcv9MZYa8lM+
	 3mB4Zg7bZYiESa+Y7aGGTKssK4s7xK6jnTlQc3sm9HDcXTk0hJu54bj7YZy5DEVGNmFaL
	 9mX95YmVmh97cASYpXNUG/yrNVHThH/Cj1kIE3sHBu8ZpHFk7Mxky123Rg2j2Rcb7ZG5g
	 b+oe55mOeKbgXflHvywk1GUNoQRJTaOnJfPUXW9AwCZckpdjQeOvP0ePKwLE/5zPrQvON
	 KDUt26Wey6yXeimLkRbFQizwDKW7UG0spQGDaqFMm5Z1GpT5GnqhZ4ansv7ztWY5xpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cerw/Z7KIbXX4bOl2Vw1MF/BZKr852ZbBEpPnDE+6mw=;
	b=fB/eJULVlTXyu9qTnq2V7cuJZK8lhatMudt2xh0qh6K7+l9/1tXQwr2fbr7OZuQEZJUM
	 2pCXuhgfZ//k8b4kXYf6N2wOV8a01gv7xN3szPRjfR4TS7gia1yOK5Br+RqOvBa5HewIB
	 2mGW5IcOBSEGLd3hZWOTAFrL4OkZU1NErb9PvYZ/yZdQx5exWmBmotGthF6S3XIlRwGt+
	 BvHlj1sar7Hi0ZlCpkSFkalAEUTCc+pGV0f7ITsWTYLJv4Xwlg/14Qyl1gnV3E8jiSzLw
	 JrlM1ltf9plFY7Imc8elcjF3wL5ZJOPrCNT77MGbE8PHdwTFlDd2v/TQO2KRMAJ23Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bD8uc4vF;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5181606A332
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 17:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5181606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bD8uc4vF
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-491971ac844so4399410f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795541739; x=1796146539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cerw/Z7KIbXX4bOl2Vw1MF/BZKr852ZbBEpPnDE+6mw=;
        b=bD8uc4vF8J9geK8iH88yaXJBF/maPWDjivN/U9G4xSaoBmWPAOsXoLld6tJg7fXty3
         haMkXbr/fKxihHDLmWFA9i136CGI8AQXavJ2jZmOGAQ5M4cq90284QmA1euiXzwxBhcy
         /yvLyPAHaa/6vqfizpyrfCiKT7kCY2Wz8ZQifPdWEpRIrXP4KReRnI4LFnIeEDvY7sJT
         t7MS4LyIbjYh8drWTGpjynNun+6KlHWr/lEq+GclIE4mo92jBQGnnlDZlNT51UGJ3qXx
         GYsYh102xj9SDAoJuSdRgdJPhbXLryRfHGO7ytr3PJNzUfrNka7SvGGIheWJL7uiXCSU
         q7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541739; x=1796146539;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cerw/Z7KIbXX4bOl2Vw1MF/BZKr852ZbBEpPnDE+6mw=;
        b=spstFpN5ef4Soc/32qZCayZXX7MR81SLhwVLL9cR6fImlCu16e5Cq1QHPYMEKlGCLd
         7VutxWFNSEu0tAhfwNSDBukTR7RbJX3ODbpx6TThgjb6iywN9fdXfG+b/RVun4nbufA0
         1OOeKfj/GKR6fvYNu+T19FG8b9i0vyXdrYMGOFYQmemRipFnG83bdgsCifyWqNxKr7PE
         XyrtR3/oFt0NM/uratkxwdHZE2FCMJN5K39FULB9Wyonh2ragJQ/Rx45tfTu+Z0fmCHx
         6WGBisxy4Q6yJqFy0R/WS4JkpK0OAe0S84kDVPXesXfISrnL2XThXGGxq/pyHtNRCKMC
         Ed6g==
X-Forwarded-Encrypted: i=1; AL+hErHfScDaBJSnWgg11GLgSEosQm5zZnayZmbjk8/sNXD8ufAMtYTT7TzJpF/RLXISWfbsgBUoXY9Nv8EYDj0PHMPg@vger.kernel.org
X-Gm-Message-State: APuU4Z8PD+lim2IxS07/X+Idt0JztRP2B7EFSmqjuwpOS/cV66j5iRh+
	yu3k5i2h+ZEABr1ZWHcYOZdEBfyD9XXvflbRDs+UbEEEvFuLGlACeTCrkNystx3diaM=
X-Gm-Gg: AZFdTZdypd+mFGWtjN4BYg6bJ4WDdux5/JbheF+0ypHYhmOh867boKMs3ejs/s+nLYt
	jdhzUHsb7o0bU9Ynw75j0uxoAp4ATnnd6Y5i5lUdJ6AxrquAjFgbZKL5SEnKLR5DLCeMNhvfhri
	sDpnoZPQAiRc1LoVYZTRhhHoHYgTYitu7IsAKcEOAWMULx1YDh8efyqo8hD29odzW+9j9F9OUIy
	AvRWp4bv158FLHWBHX94N17P/pvktsI8ZZ3oASocOFIFCG2JPKQxZbOk/J+yMs0l13iu9iVf6d8
	ID2erbjOXug4gZ20cU4UqKSJnMczYusOuixOIhVqRuaQvne4om4z4ciRZjqde/oC+dlvzieDBaX
	R1BumTEXMW+++Ioqk3LzRZ5sdFYViGfLFsoJTz8oWxsnHmbGV562xb+qA5cMNWE/BWl5yQF37Q4
	lyayIiMxXHVuBbz0LnMS3/gv5pgxBC3iRsswqsNYriBw0RaC8b6L7BWBNGKGXTqBcSQCK6I7QCD
	p95qv3YQcTg94Cd8W7ZILK88pAbdch97M7CRuRcFBK4qJFuTe/zZUpC+EtoahXrXi15A65wW6Jd
	WmTqXjqMDxSL7lHB+YZ4DgAkznuZuxjAYLcytkjj7YRHtXpTvnFzimU=
X-Received: by 2002:a05:6000:990:b0:493:ec0:861c with SMTP id ffacd0b85a97d-4abb0c5d53fmr28875984f8f.16.1795541739288;
        Tue, 24 Nov 2026 09:35:39 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dd55sm28453844f8f.30.2026.11.24.09.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:35:38 -0800 (PST)
Message-ID: <fa4e19d5-2e66-4468-9860-19cd9f3ea8db@linaro.org>
Date: Tue, 24 Nov 2026 17:35:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] perf cs-etm: Per-thread mode fixes and snapshot
 wrap support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 John Garry <john.garry@linux.dev>, Leo Yan <leo.yan@linux.dev>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/11/2026 11:44, James Clark wrote:
> This series depends on:
> https://lore.kernel.org/linux-perf-users/20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com/
> 
> Fix a few issues with per-thread mode:
>    - On nVHE, everything looks like guest trace instead of host
>    - Tracing multiple threads didn't really work
> 
> After adding a tests for those, it turns out there were some snapshot
> bugs not picked up by the other snapshot tests. That showed that the
> different snapshot searches for Intel BTS and Arm SPE were inconsistent
> and I think all tracers can benefit from using the same pointer fixup
> logic, so that gets refactored into the common auxtrace.c. Then SPE can
> just share the Intel BTS search as it was obviously copied from it
> originally. IntelPT keeps the more advanced duplicate data search, but
> in the future that could probably be made the common one and all tracers
> would benefit from using it (except maybe BTS if it always has a very
> small buffer, but I doubt the overhead of the duplicate search would be
> an issue). For now this is more of a refactor rather than behavioral
> change so don't do that yet.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v4:
> - Change test snapshot size to 128K for 64K machines
> - Put patchset depencency in cover letter text
> - Link to v3: https://patch.msgid.link/20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org
> 
> Changes in v3:
> - Keep the find_snapshot() callback instead of adding
>    snapshot_has_wrapped() and monotonic_snapshot_head boolean (Adrian)
> - Add auxtrace_record__default_find_snapshot() for the simple search for
>    BTS and SPE (Adrian)
> - Add auxtrace_record__snapshot_fixup() for any snapshot search
>    implementation to use to update the pointers (Adrian)

Hi Adrian,

Did you get a chance to check these changes? Sorry it took a while to 
send the V3 after your comments.

Thanks
James

> - Reword UINT64_MAX timestamp comment (Leo)
> - Fix disassembly test after rebasing onto exception sample fixes
> - Only take 'perf_guest' into account if there is no PIDFMT_CTXTID2
> - Improve decoding of old files by hard coding queue 0 for per-thread
> - Link to v2: https://patch.msgid.link/20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org
> 
> Changes in v2:
> - Remove stale "may be reset to -1 in per-thread mode" comment
> - Set CPU when queueing auxtrace fragments otherwise
>    auxtrace_queues__add_event() overwrites the queue's CPU
> - Link to v1: https://patch.msgid.link/20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org
> 
> ---
> James Clark (19):
>        perf cs-etm: Fix nVHE per-thread decoding
>        perf cs-etm: Warn for invalid timestamp option
>        perf cs-etm: Turn on context packet timestamps in per-thread mode
>        perf cs-etm: Use per-CPU queues for per-thread mode
>        perf test: cs-etm: Increase window size in disassembly test
>        perf cs-etm: Don't drop previous target for kernel samples
>        perf python: Expose sample instruction length
>        perf cs-etm: Use instruction length in disassembly script
>        perf cs-etm: Increase default timestamp generation period
>        perf auxtrace: Turn Intel BTS snapshot search into a generic one
>        perf arm-spe: Use generic snapshot search
>        perf auxtrace: intel-pt: Use common snapshot pointer fixup
>        perf cs-etm: Queue partial AUX records
>        perf cs-etm: Don't print missing buffers in snapshot mode
>        perf auxtrace: cs-etm: Capture wrapped snapshots
>        perf test: Allow infinite named_thread loops
>        perf test: cs-etm: Add test for per-thread mode
>        perf test: cs-etm: Test multiple per-thread threads
>        perf test: cs-etm: Increase snapshot size
> 
>   tools/perf/Documentation/perf-test.txt             |   2 +-
>   tools/perf/arch/arm/util/cs-etm.c                  |  34 ++++-
>   tools/perf/arch/arm64/util/arm-spe.c               | 147 +--------------------
>   tools/perf/arch/x86/util/intel-bts.c               | 115 +---------------
>   tools/perf/arch/x86/util/intel-pt.c                |  21 +--
>   tools/perf/python/arm-cs-trace-disasm.py           |  22 +--
>   tools/perf/python/perf.pyi                         |   1 +
>   .../perf/tests/shell/coresight/per-thread-multi.sh |  76 +++++++++++
>   tools/perf/tests/shell/coresight/per-thread.sh     |  48 +++++++
>   .../perf/tests/shell/coresight/raw_dump_stress.sh  |   5 -
>   .../shell/coresight/test_arm_coresight_disasm.sh   |   8 +-
>   tools/perf/tests/workloads/named_threads.c         |   7 +-
>   tools/perf/util/auxtrace.c                         | 145 +++++++++++++++++++-
>   tools/perf/util/auxtrace.h                         |  18 +++
>   tools/perf/util/cs-etm.c                           | 113 +++++++++++-----
>   tools/perf/util/python.c                           |   1 +
>   16 files changed, 420 insertions(+), 343 deletions(-)
> ---
> base-commit: 28ef93607ad52acc8f8be25199711153ba11a0c2
> change-id: 20260605-james-cs-unformatted-per-thread-fix-50e723aa7f0e
> prerequisite-message-id: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
> prerequisite-patch-id: 4ef889ad751e344ae47c1d75a2a2e6cb2eadf6e1
> prerequisite-patch-id: 636b39730334cbc5a76642c070e704ffe178e7be
> prerequisite-patch-id: fb58f6daebdf5a194f8aa56ccc4022f932a5a6e5
> prerequisite-patch-id: d240c10c6824f8ae6c3f10a1da01226a957f05fb
> prerequisite-patch-id: 17b291db261e32dcb0d6f1ab2ed0adb7e0411813
> prerequisite-patch-id: 45ae1d523c9e5c8c573309f1dab107a598f3d4f8
> prerequisite-patch-id: 39a3eb25b3a45f4481760c25fa270773bcfd94f5
> prerequisite-patch-id: 5723a15636c2a28ec40eb6b5c9836d162e971786
> prerequisite-patch-id: d18054b586fc38bc832ead185e8c1fbb0ce46f39
> prerequisite-patch-id: 6735b192189d7945613458abce3da871cb79b35d
> prerequisite-patch-id: 387cb2c6181bef8f45a8fb167e8ef86e4a54ff69
> prerequisite-patch-id: 50243a8d1739141aa24aa371a8452d4d2d078a99
> prerequisite-patch-id: 2ae6f1e7707ba0c71a0678331b02d738fb25cb3c
> prerequisite-patch-id: 1fa0a90cfbc904c4429c1427409125ac44b27aed
> 
> Best regards,
> --
> James Clark <james.clark@linaro.org>
> 

