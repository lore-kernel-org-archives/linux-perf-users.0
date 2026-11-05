Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891289;
	b=wez90QFjAZglNRApzhmTqM46a+sSLiXcZHnZXy12mZTLvMCJJSbQl7uMs1leQZIT1lJa
	 fr5nnti82tjFW2dXdMSju3/cf2FVILPTjhyoHWHtlqcRV/CYFebdHkHspkWZNzuRPd0MH
	 fH9r5b3pwNy4YinWs3OqxYznJ5AjkeeBJj5l+wLBZgEtef62PNw98IfUYeglUm/lxBwWa
	 IapKuqMdYo2bAWm8OHMS5dPFPhFyzel/bQ64lrzPOcjWSGKXUTvLITeCDgE8kvnnjU3Q/
	 uLWRIZbTCOT7yHJQja1udYdHrUSPp9rpL0ZOD+ZLTZPDaUj13B4W35PdmybYTqFqLZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qQbhB5AkHTYqmDaiCgXjFOfCS7zS0X9UC38rmNropIo=;
	b=sSoE03cm+qMkxNx7H2mX1y27nFzGs6zfkUjjFHLlddJRrxvWOlpjBdxHDuXPfTb6f/Pt
	 rclWXiuvQJ6Fvwr9Lq8sun/ihcSuN0lHzEMN6Do6r5y9IF8jxbCby5Blu2x3ABkh8pT90
	 rx4Sgm+MhNgLWhBLtpTFO37rEBTtIqz2SAyB89zHcxQyA/bZ9svE/L6+GvID3yJF7wM8S
	 8IlAtuNOBfTzrAHCqTzmZuf+6+Qlhhdnq/EZwmKsKz47ho85lhSl14eQpoSuDp6+yUefE
	 ianrcqkl+u9Y/aCjr5u0GdztUNQQ8AJ0e9uRgjkGEw0q32F8PCIjrWQxOdifomW2oww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="D/BBihNv";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4081606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 15:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4081606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D/BBihNv
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so18995795e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793891287; x=1794496087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQbhB5AkHTYqmDaiCgXjFOfCS7zS0X9UC38rmNropIo=;
        b=D/BBihNvJ3L7BN4wn4BSLRIp3WDX/f2WB5fDvxlxsSyPM3EnMdrtgFkwf18wuu3u9i
         dcdT6Sg8s3pUK1K3N+qFqMXtD4tpKPP8spfx8/WfzqHG3XDb/sRqzqJ8HEZuAKzU9qou
         ikxE8ISkQVVzf2h1g1l6QHfryDXrgu1XztoD+9iW6kj072f25pXJX4f7c6/C/3ioWUYm
         tJoMHgYVP2epA1Oe2cXtSZ13Y3oaENwPCPPb5/UKH23KVTreF2pdIQa+BL9zpSnw8AVb
         FzRbCqjiQROn8EbmvexRAdTjTAmgtFG1TB72jy7wL27ee50bETr8idH3WYaZ3xSUMPXV
         bUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891287; x=1794496087;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQbhB5AkHTYqmDaiCgXjFOfCS7zS0X9UC38rmNropIo=;
        b=tvzoS3V3x6fgCIVpUSs0hYb+g0pqEN1SxreSeNJI7Qa9nS3MasrwXmjEjR9EMTbRPb
         a/OhtU0w0eny2jUtwRGtiHErx1btyq1W2afhUcz75eZ3B0fMT4aKBQbgDoRBfgDRvf/9
         rLcg/hk35s9o0t6gPWqADhLh+AQasNu76z4qKCWajwkDrLIVkt71diH98jdhKiAyJsOm
         qncsL6VFw+dhntx75yRKKlf5GZCBnm5w9Cf+p4p9ZLeXrkdYCo2IXfONrzvNiy0bPSnx
         gNMbgpqoksQFTDlhb1oUFZ5cXjFxqCagpKyTA2pMkSVgRkn4u7Zobtx+adXpvPZo3NT6
         hgCA==
X-Forwarded-Encrypted: i=1; AKwUvBy1P89HoFgZnDaVIM7jKrlzrnHhiRuKGWB0bPKp12E0tpdp3NfdP07vVCr2Ro/yI6uqw+lYU0mVNqi6j0vq5F2t@vger.kernel.org
X-Gm-Message-State: APuU4Z8DPgVWjYofYRgTkuGw3RtLtD6PQEeT5Gz6Co0xChqvXiNR0A5k
	eJSqkqLMDDe4m17DX8C47ZPsSUGm0y/1e/QWTbiigotb2fHmsgktVxtSt0FkJkcTokc=
X-Gm-Gg: AYBFou1jcyn0VKpVqU5wGyQy7Uj0U7r31fv+fE37Svl37U3lcefi41M7bQVu2WixnmZ
	oyVkpLmBLPUoSTKMUeMxI0M7IRJislDY8/TptwFXFlBlQH+Wl43dcLsJUEEAD7Q1Nh832mBT0XH
	kJgxN3HhgxFZJcO70IREuKPSX+W8hTfTamzpnAyh2JcAQtT0K1rPkrkx6cyOBwHErWD9SPv3Bjg
	sLMuabkc0tirxl2y/lgpkKQqKTDbqsCHXgGMQFwAsflkMWhFRKh2cKPFMI84D9pbUcOKZENRJDb
	PhG72uRpV8FNgXaqeShdx3Cp97AW8htHDKcwHUiEiH+G0DEAB2emENW/Ti7RZDPRs/hSvbsH3H/
	sCcuzx4FqkCYmwvlEn3MD+sydqX7CNKL4n4i89RsmkisQQpMEGp9/IhKf90v4z3R01VXM4PY9fP
	63R2qbX2EzUqH6kZDimWJb3Fhqy9bXhD+qkX4gFsfXXXNlgjZYzRVcWmjrgNwScKcY+enh3VGp2
	1J5R76VJ9mntHxAJUwoOZW5KQANAA73DA5jyh8qqW8jdhxe0EfBHP4X0chazjqFj+6q2rRuaQZ/
	92ulnGlkXaLUxySCqWlu9KCdAjieLmTOpw==
X-Received: by 2002:a05:600c:a4c:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4ac17d16ba4mr423316545e9.9.1793891286836;
        Thu, 05 Nov 2026 07:08:06 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4527feb52sm102319695e9.2.2026.11.05.07.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:08:05 -0800 (PST)
Message-ID: <ea9091fc-c129-4840-80f7-ab5edc8d56a7@linaro.org>
Date: Thu, 5 Nov 2026 15:08:04 +0000
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
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Jakub Brnak <jbrnak@redhat.com>, Michael Petlan <mpetlan@redhat.com>
References: <20261105071711.31086-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261105071711.31086-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/11/2026 07:17, Namhyung Kim wrote:
> The perf probe test suite fails on my machine.  It seems it's because
> the kernel debug info is not available.  Actually NO_DEBUGINFO is to
> check the condition and skip affected tests.
> 
> But it didn't work well as the skip_if_no_debuginfo function misses a
> new error string for v7.0+ kernels.  Internally it uses the
> add_probe_vfs_getname() to check if perf probe handles debuginfo and
> check the error string.  But it didn't add the new error string.
> 
>    "Could not find probeable line"
> 
> With that added, it now passes like below:
> 
>    $ sudo perf test -vv 189
>    Not taking turns using the perf mlock budget: nothing can exhaust it
>    189: perftool-testsuite_probe:
>    ---- start ----
>    test child forked, pid 26135
>    Probing warn_thunk_thunk
>    -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: adding blacklisted function warn_thunk_thunk
>    -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing blacklisted probe (should NOT be listed)
>    ## [ PASS ] ## perf_probe :: test_adding_blacklisted SUMMARY
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission ::
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: -a
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: --add
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf list
>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due to missing debuginfo :: testcase skipped
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added probe
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed probe (should NOT be listed)
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding probe
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: first probe adding
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (without force)
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (with force)
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
>    Regexp not found: "probe:vfs_mknod"
>    Regexp not found: "probe:vfs_create"
>    Regexp not found: "probe:vfs_rmdir"
>    Regexp not found: "probe:vfs_link"
>    Regexp not found: "probe:vfs_write"
>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due to missing debuginfo :: testcase skipped
>    Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
>    Regexp not found: "in this function|at this address"
>    -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due to missing debuginfo :: testcase skipped
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: add
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: record
>    -- [ PASS ] -- perf_probe :: test_adding_kernel :: function argument probing :: script
>    ## [ PASS ] ## perf_probe :: test_adding_kernel SUMMARY
>    -- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase skipped
>    -- [ PASS ] -- perf_probe :: test_basic :: usage message
>    -- [ PASS ] -- perf_probe :: test_basic :: quiet switch
>    ## [ PASS ] ## perf_probe :: test_basic SUMMARY
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -a
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -d
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -L
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -V
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -F
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -l
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -d xxx
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -L foo
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -V foo
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -l
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -F
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -L foo
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -V foo
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -l
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -F
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -l
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -F
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -l
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -F
>    -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -l -F
>    ## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:10
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:0-10
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:2+10
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c:1
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1+1
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1-10
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:foo
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1-foo
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1+foo
>    -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func;lazy\*pattern
>    ## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
>    ---- end(0) ----
>    189: perftool-testsuite_probe                                                          : Ok
> 
> Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable line detected")
> Cc: Jakub Brnak <jbrnak@redhat.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 57a59ae7d4ae3d71..c091cd208beec056 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -64,7 +64,7 @@ add_probe_vfs_getname() {
>   }
>   
>   skip_if_no_debuginfo() {
> -	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
> +	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information|Could not find probeable line)" && return 2
>   	return 1
>   }
>   

I was just about to send a fix for the same thing, but I had something 
slightly different. I think adding "Could not find probeable line" 
allows for false skips in the future even when debug symbols are 
present, like when that function was re-worked other times. And that 
seems to be what Sashiko mentions as well.

If you just try to do a dry run probe of getname_flags() which has 
always existed, then its a pretty stable equivalent for whether debug 
info exists or not:

   perf probe -n -v 'getname_flags $params' 2>&1 | grep -E -q "^(Failed 
to find the path for the kernel|Debuginfo-analysis is not 
supported)|(file has no debug information)" && return 2

