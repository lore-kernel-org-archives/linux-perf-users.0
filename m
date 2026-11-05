Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894167;
	b=m70HqdY1WUXt9yqxhPOpiPe60z+63AbFnuWHwRExYbVLuYGsM9QGVV3uYmiFVOFL6Vvz
	 Qt9mo4pB0uMz+DrT0d+Fp5p6kV2UQqMu2zcHqoPk0dp1Htug9OGojBW/iOMUSGhPiXlzD
	 O1RycjxIWRmZyVnBj0L2BaIzsj5/ptFiysx+S1UEDCyqRgcXYv1po1zv/qbGPK7ThWmXD
	 ChGBqv9wuIHfr/Iz7ZPPG+l1zCxYfeo7WLzfJ3k7CFssCqGSR00+ztqVm6u8PHN5o99L2
	 XkVx7bC5fDv5GCOGv1MVsEMX8+mW9y/mAVe26z5PHjiIIG8nNPjGPHYUOwUadIK6k2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lBmH8CcGArjCqi+nJLDXWaRiUN/VD7YdP9zGGrihg/s=;
	b=4t9MtysbH9iwLnoPEsZXVzyEd0WU72gWvg8wCHigX+5bds8DyOArP7wNhCjF38eGqTY1
	 5I2HJln/vYMbtDwWT/VwuoJOajOwuBQBAnEAC+fLAK81mnSWvgwodEWtIBLgQs5GdKsV8
	 H1XJKnWFVhP1sDJNdxw+SQk8G1rpLpMoZ3kd8d+v1ZYBBF2Swg6kDu7dsEktsNFSRvuCk
	 +h6bqSR7ASS6Z4SRLqhA60FhNxMO5biGuYaJDKKB9hB4raa/aJdcAOu3B6NGyYSUuV7BW
	 PF9tqX4HDXyK6D2l09kc9WLl5uJejAjxJxKwUN8FDCbUCVQDtCZR2jYr3AdTPpX27+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LsqSa5P7;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099C606E562
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 15:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F099C606E562
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LsqSa5P7
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso1661433f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793894165; x=1794498965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBmH8CcGArjCqi+nJLDXWaRiUN/VD7YdP9zGGrihg/s=;
        b=LsqSa5P79oauPX2TdT+IJtqPkilAQD5Yb2FriU8d5fzDZ1C6weZGYIWUT0gOJAZ+7E
         C+p49GCaxVEZAq0acCTdCLSFyeci5EG4pKXP4Lsz17RAyu+BACGY624rkzbQ8PbvSYFi
         a3EIKntM07NqUYuy111TzT10vedLzZd2rmFNgMrYm49Op1CwNoXnibt0B1NHZoZzlYdn
         YjxGWqvyzdAgfp1FqHV0p+6Q1BGaS9rLehAFkZd9CtzAEaI3dPuWzFi0XqIOog5EtAEy
         FEgVYt/djsKMsHVYI5ohrj60dGltAC6FC6yLG3A+qkKUV0/65jiVxUBU/eBcI2RiYDBQ
         IqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793894165; x=1794498965;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBmH8CcGArjCqi+nJLDXWaRiUN/VD7YdP9zGGrihg/s=;
        b=yLgRV5UlTM2HzJB8Yjz5p4RK1xpuLErjx+TRVkXXcogkLpcrULHP3U9cAoaQO7eNLl
         gayEH2evWQWCnbU0+PMfzdsjZc0nRk/2TDRddBfn6yjXFxXsUobW7+QocHdqNSk4CWC8
         GgCeZGHtuebCruT2xILi/a29g2iA+YzXHAVb63tyAVqKR45GWZrNg7bpzv1q4vpoefz9
         2WwSG+q46dTvv5POOSzdj2gb+PIUgDdStFVNITXfAYfgGSbNhKoSH8CEz5Wt4qQC0lIy
         DnU5F75f1h2/9n0pbTShTXjr2yqkGmePLfJw+ro4yUZ/h9l8vjxPAt74GgRC2tgN9kZf
         cVeg==
X-Forwarded-Encrypted: i=1; AKwUvBzntT6nMt54lZgljdNeTs4Nl3XNrUb/8t4hqPEPV5qiRoLj0eWCAubpIywcn6XKbCfABe2NkU4COSYGSRNuSZBd@vger.kernel.org
X-Gm-Message-State: APuU4Z97zZLBbA7HcqqV2V/zzuhblrEs6WQ+vYkrnhJWrnJH9Nr1Yiz5
	VT+0lcnP5y8GrILDf2Tasbz6VeN8w4aXSQ6HRAecUxH5KV0RhwhfT+TEuCP5SpyIw+o=
X-Gm-Gg: AYBFou3p3ZDdWu1hN4J8FIIPiWwPp/hZJSJdG9LrhC902NSZdUrFHmylK3zjVvC7WIH
	OcB3IzwIcM/wOd5Hs40aQtAlCCs08HvVSseIhrsKysv8sDg17nD9PprUY3tNeVKvZkEnpN0Epqn
	HRnMhmg20haDLnKRaJpleDEV1nzTcZGOAO+5iA2XXc6vBM2hPH/XCRij8tGVSx15brXBpzKd9hX
	zoAPHEqXnmYFh9kczL9l/PYDarMvgWRE0w1rk96IlNU7+NPLDD/gEgUb7Ed9xyrDuulp588jqFQ
	3kJBUYDytb4D4NjQjJmyOwPN1IiENeQkRpvdtu2MfjCV1KMWdg/qKFePQq3oTJULdrzQm2HdFBN
	zyKKWGWdsAwathHvmPcdt4Mbwbsg8gwfGBWAgTd9d3lA6V42pyMJBwNiW9lOhXSqESTpNEZYYuV
	2AX4strutvHqDwGT4FMGgdQqoTbRa6iiDdQrxnwDM2i7hI9RyyhsU4ECRz34pWW85D0b0W/xspB
	bXKUlw+DTEr5jAC8+fQVaa8mPMrmoFQayuqY69ZwWCFRc1TmZDvN+rs6QRPDnBXjJKIZVore7fg
	7uHKflE6L40HZ0cOI3b7Wzk+Kvgi/aL7yQ==
X-Received: by 2002:a05:6000:4b17:b0:48e:4561:8a17 with SMTP id ffacd0b85a97d-49275fe4f50mr52740f8f.16.1793894165277;
        Thu, 05 Nov 2026 07:56:05 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm10525910f8f.14.2026.11.05.07.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:56:04 -0800 (PST)
Message-ID: <7fb3e764-e71d-4cd1-b481-963ea518dfd3@linaro.org>
Date: Thu, 5 Nov 2026 15:56:03 +0000
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
Subject: Re: [PATCH] perf test: Fix perf probe testsuite
From: James Clark <james.clark@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Jakub Brnak <jbrnak@redhat.com>, Michael Petlan <mpetlan@redhat.com>
References: <20261105071711.31086-1-namhyung@kernel.org>
 <ea9091fc-c129-4840-80f7-ab5edc8d56a7@linaro.org>
Content-Language: en-US
In-Reply-To: <ea9091fc-c129-4840-80f7-ab5edc8d56a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/11/2026 15:08, James Clark wrote:
> 
> 
> On 05/11/2026 07:17, Namhyung Kim wrote:
>> The perf probe test suite fails on my machine.  It seems it's because
>> the kernel debug info is not available.  Actually NO_DEBUGINFO is to
>> check the condition and skip affected tests.
>>
>> But it didn't work well as the skip_if_no_debuginfo function misses a
>> new error string for v7.0+ kernels.  Internally it uses the
>> add_probe_vfs_getname() to check if perf probe handles debuginfo and
>> check the error string.  But it didn't add the new error string.
>>
>>    "Could not find probeable line"
>>
>> With that added, it now passes like below:
>>
>>    $ sudo perf test -vv 189
>>    Not taking turns using the perf mlock budget: nothing can exhaust it
>>    189: perftool-testsuite_probe:
>>    ---- start ----
>>    test child forked, pid 26135
>>    Probing warn_thunk_thunk
>>    -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: adding 
>> blacklisted function warn_thunk_thunk
>>    -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing 
>> blacklisted probe (should NOT be listed)
>>    ## [ PASS ] ## perf_probe :: test_adding_blacklisted SUMMARY
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe 
>> inode_permission ::
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe 
>> inode_permission :: -a
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe 
>> inode_permission :: --add
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added 
>> probe :: perf list
>>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due 
>> to missing debuginfo :: testcase skipped
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added 
>> probe
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed 
>> probe (should NOT be listed)
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: 
>> adding probe
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding 
>> probes :: first probe adding
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding 
>> probes :: second probe adding (without force)
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding 
>> probes :: second probe adding (with force)
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing 
>> multiple probes
>>    Regexp not found: "probe:vfs_mknod"
>>    Regexp not found: "probe:vfs_create"
>>    Regexp not found: "probe:vfs_rmdir"
>>    Regexp not found: "probe:vfs_link"
>>    Regexp not found: "probe:vfs_write"
>>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due 
>> to missing debuginfo :: testcase skipped
>>    Regexp not found: 
>> "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
>>    Regexp not found: "in this function|at this address"
>>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due 
>> to missing debuginfo :: testcase skipped
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with 
>> retval :: add
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with 
>> retval :: record
>>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function 
>> argument probing :: script
>>    ## [ PASS ] ## perf_probe :: test_adding_kernel SUMMARY
>>    -- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase 
>> skipped
>>    -- [ PASS ] -- perf_probe :: test_basic :: usage message
>>    -- [ PASS ] -- perf_probe :: test_basic :: quiet switch
>>    ## [ PASS ] ## perf_probe :: test_basic SUMMARY
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing 
>> argument for -a
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing 
>> argument for -d
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing 
>> argument for -L
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing 
>> argument for -V
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary 
>> argument for -F
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary 
>> argument for -l
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -a xxx -d xxx
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -a xxx -L foo
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -a xxx -V foo
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -a xxx -l
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -a xxx -F
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -d xxx -L foo
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -d xxx -V foo
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -d xxx -l
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -d xxx -F
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -L foo -V bar
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -L foo -l
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -L foo -F
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -V foo -l
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -V foo -F
>>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually 
>> exclusive options :: -l -F
>>    ## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: func
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: func:10
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: func:0-10
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: func:2+10
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: func@source.c
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: func@source.c:1
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: source.c:1
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: source.c:1+1
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable 
>> descriptions :: source.c:1-10
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable 
>> descriptions :: func:foo
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable 
>> descriptions :: func:1-foo
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable 
>> descriptions :: func:1+foo
>>    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable 
>> descriptions :: func;lazy\*pattern
>>    ## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
>>    ---- end(0) ----
>>    189: perftool- 
>> testsuite_probe                                                          : Ok
>>
>> Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable 
>> line detected")
>> Cc: Jakub Brnak <jbrnak@redhat.com>
>> Cc: Michael Petlan <mpetlan@redhat.com>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/ 
>> perf/tests/shell/lib/probe_vfs_getname.sh
>> index 57a59ae7d4ae3d71..c091cd208beec056 100644
>> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>> @@ -64,7 +64,7 @@ add_probe_vfs_getname() {
>>   }
>>   skip_if_no_debuginfo() {
>> -    add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the 
>> path for the kernel|Debuginfo-analysis is not supported)|(file has no 
>> debug information)" && return 2
>> +    add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the 
>> path for the kernel|Debuginfo-analysis is not supported)|(file has no 
>> debug information|Could not find probeable line)" && return 2
>>       return 1
>>   }
> 
> I was just about to send a fix for the same thing, but I had something 
> slightly different. I think adding "Could not find probeable line" 
> allows for false skips in the future even when debug symbols are 
> present, like when that function was re-worked other times. And that 
> seems to be what Sashiko mentions as well.
> 
> If you just try to do a dry run probe of getname_flags() which has 
> always existed, then its a pretty stable equivalent for whether debug 
> info exists or not:
> 
>    perf probe -n -v 'getname_flags $params' 2>&1 | grep -E -q "^(Failed 
> to find the path for the kernel|Debuginfo-analysis is not supported)| 
> (file has no debug information)" && return 2
> 

I included it here: 
https://lore.kernel.org/linux-perf-users/20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org/T/#t


