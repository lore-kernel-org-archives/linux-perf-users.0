Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C0C466B09
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586953; cv=none; b=guqNI8l+6X30ciFkei07Prk6x5iuet+Q4Z6QNYBkkXpDt6OJ6KQGUp6HIeBRDZipTb7llxO2Cp3a0dOgu9QzzSwTsIgLptYGc+ayrA70kTrLf+sjKCO2YH/uMAI65NQNOhsUCBBWx1UDlhClHCiIze90RP07Pssmw8GxPet2gKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586953; c=relaxed/simple;
	bh=JHjweW4tKjJzdlaIpmKAFsqozfRQUWPcEqdfjwpoddk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rODWp2TFAOWa1Tys05Zm2wROUnmXEv0eP4+AxDw3E1enYjXhRUxzZIOZcBR6Os1xM6OellyCZ9SV8nuCwYKxtdNcwxs458o9irhnlRxdILS6O/znoF7vX/y1JaOWCzrfqP5URSc5fSeJlnSouCMzjVDlHsQjVqsiiXbSUXcwONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QmWLroh8; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmWLroh8"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af9270c53so234267466b.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790586950; x=1791191750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rEuFHJDtEaYDRIoBn4eFmTqqB11z/QrLz8Ps7ePt5c=;
        b=QmWLroh8z5u4qAU/NBLXVMZUSwH6fM52h9L5UUqM6VcfrO28VlU6MHE2bh3ucis/OX
         zjEplXeiko3PjrZL4lPphY2Ra32NV+RMoDp+f5RaqqB7N2B5esuKsowsef9vOH82bwES
         hVotGwYYVt73p8TjHSBVB8E9dN4QgU3fSZgAxaoyGizuiLwFG1N1N/zHuPUPh7HG8snQ
         SazAqgYjWOww80RAYGRDBOA4utPE1RlBFdHj9Ve1nvQWNNm5alvazVu71jL53BYM3qA0
         tJiiZWpR7Dk0JGGOPjFBtetH514hDi9nEPGqpnAN6qZ4soww36abdh+UHP0Mlj6k7Y/c
         hs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790586950; x=1791191750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rEuFHJDtEaYDRIoBn4eFmTqqB11z/QrLz8Ps7ePt5c=;
        b=qiHUeiWdtgUVRx4RAKBgHRJKNaY2hSfB2usiEjslnoK62B/SSwTvExyZjISokOX+q/
         f1hwR73AAqsmOfeMF4MsJ+NOPCyYJt2gLNXFlFQusQ7QUI/osAIAbO6mcsBXv+6ARdoN
         sLR5lV5g+FIAHAh8GIDvqcVhsTMRmX1+/zHwCO1q3LsuA8uzNqk0dOQJ5KAORpuuV3Xm
         qwNWxkzBsPgWEBKx5hUS7QVNvieS6OcsgXigQMx0wcdp04ATyRGvQ4uV5MyfojunmaaV
         EPgKsSLolieXt3hys3lijffksKeQYU9OmIeVsTzAxCvCIVDwR0EHqIhZWs0N2S3G4UDu
         BoxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuytrdMTE6HAkWM1yUjLmaOP5qodULqKn1cbMveMRVazRNItg2zAxy8vn427C8RGr40adCJSaNucKAUzlVXBSr@vger.kernel.org
X-Gm-Message-State: AFuF++mEgniWeDJWGJsdNRM4LC5Pyno7myVWrvzLehQHks8u+N4dFxLg
	qpLj5XncabyYyAd5bA+OPAZ1XkDUmxXK8iS6WsDmolHHwy9gs1yToDndR5vT8ElHcmQ=
X-Gm-Gg: AYBFou3gzc9ZiSQQvrDUrJrj1Nw/RojgSWQRkoxAInI+dyTXT0wa79PZzDXrCNrc5A0
	c4IwtcTvk/TKH7VlQ8aKSMwo8PwU5WRXQBbNyUDAjryBuwbpmKL92JysGk/bmg/nXtHMb4L9Wvb
	4JVrwazsv+01vhbg8tCp2ONfOzx9teqM+bG+LPasP4YftM2XvVvTG/+QTNvKM8cNOJY6E/RDQpY
	OnoiUZo4rN6ekCAcduDEp1R8iphfgHK0JO/uZaDYnPurwaCE8FIAPadEV1S9y9eto1v/7YhN4Zy
	/R89umXXHHX1eXfZMrWWJjP98pVK+uL7+ofPJQQ/EJNrW9J2TzUeAifSiGXuuvTjrxE/x51eJ82
	GmzCe+iIxCP/1YOIbZYShsvQtG4/XzCSICDvtEw+QH8a2k37dnN8OVwwYwHWyI4Fey1OPb8o1kA
	NB2aP5eH72amA2+zbMa2USiACQO3PJVGE5g1ulJZozxPPBo0XPW/j0Ifo8V7CeJMGTymaHFD9P7
	AQ=
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47af with SMTP id a640c23a62f3a-c2ac53cb0afmr1026470866b.37.1790586950002;
        Mon, 28 Sep 2026 02:15:50 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2de21a6349sm77293766b.21.2026.09.28.02.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 02:15:48 -0700 (PDT)
Message-ID: <8bc8b276-bc4e-4a6d-b770-5b02c79946d4@linaro.org>
Date: Mon, 28 Sep 2026 10:15:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Improve fix for "argument list too long"
 error
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Markus Mayer <mmayer@broadcom.com>
References: <20260928-perf-orphan-args-v1-1-8cacf784621e@bootlin.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260928-perf-orphan-args-v1-1-8cacf784621e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/09/2026 09:55, Benoît Monin wrote:
> The orphaned pmu-events JSON files are passed to the shell via
> `echo "$^"`, which puts the whole list into a single argument. With
> a long enough output directory path and enough files, exec'ing
> /bin/sh fails with:
> 
>    make[5]: /bin/sh: Argument list too long
>    make[5]: *** [pmu-events/Build:228: prune_orphans] Error 127
> 
> This only happens with out-of-tree builds, when setting O= to a
> relatively long path.
> 
> To reproduce, build once with JEVENTS_ARCH=all, then rebuild with
> a smaller JEVENTS_ARCH without cleaning first, so the leftover files
> become orphans. Using nds32 (which leaves ~1100 orphans), an output
> path of only ~70 characters is already enough to trigger it:
> 
>    OUT=/any/long/path (at least 70 characters)
>    make -C tools/perf JEVENTS_ARCH=all   O=$OUT -j$(nproc)
>    make -C tools/perf JEVENTS_ARCH=nds32 O=$OUT -j$(nproc)
> 
> Express the orphan file list as paths relative to $(OUT_DIR) by
> stripping the common prefix and restoring it with printf, the same
> approach used in scripts/Makefile.clean, so the shell arguments stay
> short.
> 
> Fixes: b6712d91f8f5 ("perf build: Prevent "argument list too long" error")
> Suggested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> Tested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Reviewed-by: James Clark <james.clark@linaro.org>

