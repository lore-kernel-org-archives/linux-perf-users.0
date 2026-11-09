Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226273;
	b=hgf6dQ+fE13OEmCRcJVB5DPtEbfZMsgiork9EPrugVOOrMhS6QJ1cNigtySru3hEJGot
	 6ZcY00Sf82DZ20Vfo1tehDE53QjCk3geUudiv8jdCAwcQIrfiqIiqZVRKj5wdQhOt+v6X
	 yAloSVX+e+w18NBLCdoq7+mFtqeHU2z5m51UQY+9rMBbZbTZDzsKCNZ205AB2nsvokVCH
	 ZnFQonMVwhvA2aNxJMaI9dquWhMXSo3XdCrwG2765eggDPU71IOCBVVF6TP+eHnXphCwj
	 6IqLu9zj67J5DIVPSOLsoqkZoqjWlNt7aJ1+b7KGMDGVB9FRjQkbUx7zt0g2lXYjs9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tgxmkN4SDhT3DVX1MkqJXs2K3p5W6sK2g9lAo+MIV18=;
	b=K3BN/Crd4zavKTej5BIoR+wATPK2ehv99jKUqJpoEFNqWO4FTCGyCTuKEOOXBy4ZqERH
	 RFMO5SIClI3+R9UKZYzUnJHlz/dNG/6JmNI2bu10DQI48zQt3sK4kBFXtGfKJsqeGsmjD
	 xjqynJSp5GZ5xk8/pqHay5+YllVqEBUizmk6G1IiN4FuT9wJznXhfLfZhWj9vyH/Zl3Ul
	 PtbujJYhGBGQHCFU8sEp6kDGpxgVN3f/RUbDe02bIovAY3JHz7melpAUPjqVZOUF0sZmA
	 dJLB6WI7pCNLQNpl5WkzBcYlN1Qqf9qCR8M1qYiZ6/fTywMFAXEGwou/+CGSaJ1HvxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MW0YKzdX;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC7606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 12:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BBC7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MW0YKzdX
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so5167195e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794226271; x=1794831071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tgxmkN4SDhT3DVX1MkqJXs2K3p5W6sK2g9lAo+MIV18=;
        b=MW0YKzdX88e0qiRGhc2GPKOo9KUhLdFdfcW9GCF7jSYRzx/wX2+BmX6r5f75wna+ey
         4AqDkEY3PnOF6EwLkUzwtFytC0yvy8OrPa0lh0+EoTIi3NQHr2Uhb1BVo0mxIAmt+Tkd
         6kEkZhpkw4FpdczlMOWnMNWTzlyrrc0RptPGw9E9umKVUTSN85qO17JVjnaOj6OqVIhV
         n/CBhaFSM8b6oAIC0Fvx1ee6PO7ek/uSkBV6E0KA92fAxN4BBanXPeWIdOF3fHpX29OO
         7gjG5CtNG7vyhc07jKxQhAwXSpWiUr8tk0sFh3rS4T3os0rBcf0h7rmoMH09L+PQrs70
         M6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794226271; x=1794831071;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tgxmkN4SDhT3DVX1MkqJXs2K3p5W6sK2g9lAo+MIV18=;
        b=p4j4hrkQFSeTZLpHwBUYkR9b6UxQJ7HsPJLobKtunoA9BTIuvcHaauR7ahoKD11vev
         g8GEJq+zODPxcNz2Yr001IQ4YYIbn2UcRtV10dyJ/3+Y2IDvQEf2eo7rkQA5VQhVQMbl
         /aEoE6V9i9pbzD7PsMNfCv854wg9eYE/f2mEhW5ErYs+n6b7T3vsBwG0G5cHCU5WJFv0
         JQjY515GnuU3T0Op86jDck8ENlId4Ix9rz7NqdIx6yTZPJbAsLAkJ0tqNNFoLEdUnU64
         uL2Wk1sinJztJjCKTxyC45JO1OHctEn45EnMkNgRUVpRisMM/AAg9TVB8WLUf6cWaqMz
         FojA==
X-Forwarded-Encrypted: i=1; AL+hErGxljvWP0atDh+rXjaIgWhl7DNYu80SsO2s6eACwovFGoeg6fH2xald/s/3yAvGTlD5Mz9pQzrql5gruHjiPjSt@vger.kernel.org
X-Gm-Message-State: APuU4Z/wKCsyBL+rFGUcWYfJt925yQdieboJeDcYelWWplQ0Q1lcRkjA
	+LEyPO9uAOACj/c4PIfKbpwWwA5tWPpWyr+aRK4KILJHZQ8obxt0l0JA2qFSny3fdx0=
X-Gm-Gg: AYBFou1NC5XBaUEvCzMSr1vk//+Mw6NXuN3KfI8XroopBuZJzHKZPFjEfi4+zinIljn
	3TUB0I50Jw+AitWUiDNFNX+wWSsav9RmitGmzKFW1dnaU6US6Do/f2wK5ob1T7vpkAE4MeeTU/r
	3DIErbcH7T7Mjp6d1+xxk9zbsTbYeb3WNY+aa1YCIVZXJnEwf519+b/RnLzshHsh5woW6k+k+e6
	ej2jzyQ9oH37KMOO50pcvLZNb/hpnJnvqyr2yqXkgK83+LFl5Q4RbfUDGFkurDQlIpm/p3sPVlq
	9luJ2EfhUjctUGGcUtEjDUp0C+udgl0/ew+NsaB9+ICZiAOzdrHCK0x5zdWKI+OxPtT8wIEaA5e
	f/RhHSz9CAoopjk410hcWgl4gQjJFRdkwJrJvU4nO7tD52ZLSQyGM3vLHuk+vxixDVCzynwQb6J
	+mZMec6YkK8lUR/ZpCki9UI7917ctjBIQSdK3zTKLTY/Yy9gg4ykvfpTUqG8ZMSJwNvtVykzYtw
	MY621FTGsm5P0/XeoMCFvKKtZaol+RPec8e/Ko9MJeqcmSJjPeGp+/yDQ+Sm39iu+Rqny7l/ooT
	LW+4Fros+ZvsW2r1DKs1nhrvC70uLg6p
X-Received: by 2002:a05:600c:6209:b0:4a3:5a98:c279 with SMTP id 5b1f17b1804b1-4b960da4963mr67152385e9.8.1794226271331;
        Mon, 09 Nov 2026 04:11:11 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee2b8c0sm149263015e9.9.2026.11.09.04.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 04:11:10 -0800 (PST)
Message-ID: <ecd60873-644e-4b8b-a786-ec84276a99c4@linaro.org>
Date: Mon, 9 Nov 2026 12:11:09 +0000
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
Subject: Re: [PATCH v3 3/4] perf test probe_vfs_getname: Fix missing debuginfo
 detection
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>,
 Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
 <20261109-james-perf-test-fixes-v3-3-e8d0a65e618a@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v3-3-e8d0a65e618a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/11/2026 10:17, James Clark wrote:
> skip_if_no_debuginfo() looks for the errors that 'perf probe' prints when
> there is no debuginfo in the output of add_probe_vfs_getname(). But since
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected"), add_probe_vfs_getname() returns early without adding a
> probe if 'perf probe -L' doesn't find the line, which is also what
> happens when there is no debuginfo. The error from 'perf probe -L' is
> discarded, so the debuginfo errors are never found.
> 
> This causes the debuginfo dependent subtests of the
> "perftool-testsuite_probe" test to fail instead of being skipped on
> kernels without debuginfo, because test_adding_kernel.sh calls
> skip_if_no_debuginfo() unconditionally. The other users only call it
> when add_probe_vfs_getname() returns 1, so they aren't affected.
> 
> Fix it by doing a dry run of a probe that needs debuginfo instead. This
> works without libdw too, where 'perf probe -L' isn't available, and also
> avoids adding a real probe just to check for debuginfo. This fixes the
> "perftool-testsuite_probe" test:
> 
>    $ sudo perf test -vvv "perftool-testsuite_probe"
>    ...
>    -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
>    ...
>    -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
>    ...
>    -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
>    ...
>    ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found
>    ...
>    189: perftool-testsuite_probe : FAILED!
> 
> Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable line detected")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   tools/perf/tests/shell/lib/probe_vfs_getname.sh | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 57a59ae7d4ae..98cfb02cf7c6 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -64,7 +64,11 @@ add_probe_vfs_getname() {
>   }
>   
>   skip_if_no_debuginfo() {
> -	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
> +	# Dry run a probe that needs debuginfo.
> +	perf probe -n -v 'getname_flags $params' 2>&1 | grep -q \
> +		-e "^Failed to find the path for the kernel" \
> +		-e "^Debuginfo-analysis is not supported" \
> +		-e "file has no debug information" && return 2
>   	return 1
>   }
>   
> 

Hi Namhyung,

This patch causes a shellcheck issue with certain versions. Not sure if 
you applied it already, but I'll send another version anyway:

   In tests/shell/./lib/probe_vfs_getname.sh line 30:
add_probe_vfs_getname() {
^-- SC2120 (warning): add_probe_vfs_getname references arguments, but 
none are ever passed.


