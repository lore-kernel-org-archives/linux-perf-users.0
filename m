Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390841;
	b=E+1cgqs7n6TPqXkltCNcu1bLVdwhhNcaLyTlEJrSs13UfgKt9G3y7FGKP7mh/5MC32kL
	 X1v0CEPyR73A9SOaS/5k+6iuGwFMaCLn1Cs5B0azXUX9TiB5TkvDy21EuYIf/8lsK1ugu
	 TELFG53wfmTuqgaxgfqYuJTTdSX7i1LXtZQjZCelU/CebOTshonAd9UtkW/+EXgc7TinG
	 FXMWtTDxRNlHa/DnIBMCsdZAJeBv3BP6U/p/RLaHNG7PC/+xLHeRlUTnCPu1P095wYeuf
	 nr/tJA7ECvDgYna8jDOy1cyX2ZoWghpA0/qXE2GMCwh+sj9HljxVlB98k3vYDMsM8iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iiynlEyig9LsinGQop9Fw8MYPPe7GVoPwBaprgGhDdM=;
	b=K3Xz6zR4MkGx4zMxEuVanpmmdhR/DdgZF2olA9tPf3kJS1a0jZpQLm/y+Kji/PrcEQnx
	 p8KogPz/WVyMloAac5X6e9zJpjvlwwPQiF0Tp+HcefIZJddeeHwOeajMRBADOzpkphJp0
	 lC3r6dTowmzn+pnXJSHT81w47hzRstGUQop+5517slZYCp4t9TrFXDuXITUK/mGuCKSmn
	 u1SnvIRsLAI1Mv04l/fqCv9OoCp+q9iuYyGurbRm9VHa9AjSXehfHNFCivKIsRakcWuvo
	 KWuVUM/DRX93xkfc2L0Ju2vGfhwYkpKr8dYLx27jUdhQ+hE31L0GmSST+YzYRx6dg7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KTmdlz2s;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B36606A327
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B36606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KTmdlz2s
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so36431905e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 01:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794390839; x=1794995639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iiynlEyig9LsinGQop9Fw8MYPPe7GVoPwBaprgGhDdM=;
        b=KTmdlz2si8eq6rRIBxKwHAL6SXnZylgbStbTdORWZgkdG7iRcET8/w2ikrDMefQPhX
         5SZDXG/avNQCvCY9x+4qmMNc2Ftjbq1QS9RzMV8DtEPnLwfMdHncnvpuejgQ5KlfMNQP
         3LZ0xfmy5rVbFt3ug7FXg1bztnDoBZlEEsYI2yj3mwl3R+t6zxzZOzGxGEVbEIz0dzze
         +VzJ8wwJdQ5KiMxucpR8CUuFnWGjoHFRDFsWoeEw3M1XaNpvyN2mOST/UEGy+QMJcrzN
         lsKNVjBdSZWKkfMtxgdsLwPiGhdYr0tquEHcFPUfDalBZsLfMSc0Rf9ETvLkoU3Hh12t
         7/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794390839; x=1794995639;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iiynlEyig9LsinGQop9Fw8MYPPe7GVoPwBaprgGhDdM=;
        b=BSdLPs4QkJB7yVjxkd3RB+PUf82vKf/ggvP8V57c7Sn85mmevg6FGhSn55eCNoi8lq
         bb00lckZCk5PXebbTY2ErC5nr0DpfOgTkxIo6Q0CPZyCuoygvs7vTcgdkEPjGQi3LbgM
         bZm2bx++SfbeeiF0kJcO6hFkF+5RzrdbxpE8tOdeovo2jQBnOHGoAVzpn+69tWFZP44u
         S19SRc1EHuV+hA1Maxin1jsWQex4KrM5ZUCfD86C9TKoxu8egBavJ/nY07An6zgK4rJg
         +kLAosZzPDwjkS97p0ARyCuYCfndV54qJionqHb+y8/NdNV/eAdLhZ7TkRpsiDNE9GLr
         75Xg==
X-Forwarded-Encrypted: i=1; AL+hErGblpy8u32LxSNOCLs7AD+k/kPEA0Dm9YU3E+JI4WUKkl2iP8uFhqEvt/h1cPWkBjvaqPvL72Hur90ARVDcW8bW@vger.kernel.org
X-Gm-Message-State: APuU4Z8iCU1s8T44dqKZNuqHNI/h/fe9PQ8tzYOkThKrV4uq6gHlvnit
	x7dI3D6VInDco51dR/AVvWOizI9/oY0DPJ62Azo/Ou7IN83oAA9Hk0tYV352Chrf+sw=
X-Gm-Gg: AYBFou2oLUtYMbjzfqj4eibYfXvlABicXldtdISqKfpWcV66SVPDEUCiJPliqn/x0cy
	aDNS6O4659/hXkawyN0pdagy493oAklcahu5mayXOTbQoQ/UJKRx6/U56R/VediyVzOrWzSIXoj
	yb9xoppPMZgjsqs4CbVClkRj+nkUGfToUfEHGKHnuTaENuPKyyHWa9fvMb48UJz9u+FJsi2tLYo
	cQB7s74bY2GBSMaWS6pP1rMoHeAdwjdWAgVBFg/zTWgmDT+BClGDQxVr3Bhrf67i6PX43jjJVzR
	qGAF0zwHZCSQmbSQeUCm7I1jellQ4dFh+DCEWBbRL+0QLmy88v8h0m07OFx0+iE+kNUQ/dewxIM
	f5p7dVyUAdtO25rjFySuI/mG1U88a42A4NLHEEHO6BpxWDZkgybN4PJDgjYKhvSzGNuXbhWgxOg
	c8xNYCvg+2SUBmpVVnkeM2aSLYlWv0n08Wic1MXag4XF5g83KZQczc5kL6gAcerGCZhfm2KYIsv
	jHnNAM6OQBr68UbzEhTOYQm3FghezFlaOEHm2a+NrDflU3Y9OzQOqxLG6GOb6AZl33WOnLpBTxk
	I/NnTMp24aywu+sxuUOcM0wnMAAwfFleyA==
X-Received: by 2002:a05:600c:1549:b0:4a2:cbe:bebc with SMTP id 5b1f17b1804b1-4ba0938ba0amr31926455e9.23.1794390838905;
        Wed, 11 Nov 2026 01:53:58 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba35csm116824795e9.1.2026.11.11.01.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 01:53:58 -0800 (PST)
Message-ID: <7bb2995a-e510-41e3-ac3f-cc4135b3774c@linaro.org>
Date: Wed, 11 Nov 2026 09:53:57 +0000
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
Subject: Re: [PATCH v3] arm64: perf: Drop the example the userspace counter
 section points at
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20261111023550.1971639-1-takano32@gmail.com>
 <20261111034432.2020955-1-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261111034432.2020955-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/2026 03:44, TAKANO Mitsuhiro wrote:
> Documentation/arch/arm64/perf.rst points at
> tools/perf/arch/arm64/tests/user-events.c, in the text and in the link
> target, but that file is not in the tree and no commit in the history
> leading to this base has added one.
> 
> The section already describes how to use the libperf helpers and points at
> tools/lib/perf/tests/test-evsel.c as the example, so the sentence that
> sends the reader elsewhere is redundant.  Remove it and the link target
> rather than pointing at another test, and move the instruction for running
> the example into the How-to section, next to the reference it belongs to.
> 
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
> v2: drop the reference instead of pointing it at another file, and move
>      the instruction for running the example into the How-to section.
> v3: the v1 history moves here, so the commit log is the change alone; the
>      sentence about the missing file is stated once.  Raised by Sashiko.
> 
>   Documentation/arch/arm64/perf.rst | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
> index 997fd716b82f..5b9cc2aeb642 100644
> --- a/Documentation/arch/arm64/perf.rst
> +++ b/Documentation/arch/arm64/perf.rst
> @@ -131,7 +131,12 @@ changed.
>   
>   The userspace access is supported in libperf using the perf_evsel__mmap()
>   and perf_evsel__read() functions. See `tools/lib/perf/tests/test-evsel.c`_ for
> -an example.
> +an example, which can be built and run from the source tree:
> +
> +.. code-block:: sh
> +
> +  make -C tools/lib/perf make-tests
> +  tools/lib/perf/tests-static
>   
>   About heterogeneous systems
>   ---------------------------
> @@ -140,14 +145,6 @@ only be enabled when the tasks are pinned to a homogeneous subset of cores and
>   the corresponding PMU instance is opened by specifying the 'type' attribute.
>   The use of generic event types is not supported in this case.
>   
> -Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
> -can be run using the perf tool to check that the access to the registers works
> -correctly from userspace:
> -
> -.. code-block:: sh
> -
> -  perf test -v user
> -
>   About chained events and counter sizes
>   --------------------------------------
>   The user can request either a 32-bit (config1:0 == 0) or 64-bit (config1:0 == 1)
> @@ -160,8 +157,6 @@ userspace must treat the upper 32-bits read from the counter as UNKNOWN. The
>   and should be used to mask the upper bits as needed.
>   
>   .. Links
> -.. _tools/perf/arch/arm64/tests/user-events.c:
> -   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
>   .. _tools/lib/perf/tests/test-evsel.c:
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
>   
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb

Reviewed-by: James Clark <james.clark@linaro.org>

