Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206D21D3E2
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327861; cv=none; b=oyCAmrcmGbksPo85tltCs4Z/LsTmRKf3YUNtaxf0bf6cXrtQ6RzvHIgbzNwij1etfMDEV/Y/q5pO0PQHm6AwT5Vnu7mvrtoHtMsTrf2u0fPpWONO4pg8A0cDdKY8dOh9JhPv+BKf6jNwrr+D1vqDXZWSIOZEkm+Fh9gxCMzKZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327861; c=relaxed/simple;
	bh=BolRQkYlh9mtTOrBSdsqKgqeFzE356E2fM5JWzOZdhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPU02aCXJSJtYFUL+rSMDpxRHcoQIjeeYsB1mK3UKJ6EdoJKg+L+jloIjkPtOZ1I3O2k5bSrZqfHNwqhAQ8r+eGdcXq6iR1Tt87JtKT3G69fS1GpzZYq8Q3sV3bm0oscP37kF2U6V4kb5G31301b9dtwcSx4n2EmjPoGzRc6rlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QWSZjCAh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWSZjCAh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso61007015e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776327859; x=1776932659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9gaYFQm7e+OPsK3uV9LKydMJoBgr2bMgA6yHNhYj+s=;
        b=QWSZjCAhCYRmQqIBlLqDgT2C7UBp3C3C2O7H1aa5SzHFpwwTEDCqTTmJdD5/ys+p6V
         fR1BCUhfZ/7yJqUcgSzTqYc1gEDuhSVOrviwrusJUenJkMksdovUoGxI6nEm/JuprzAq
         N0D/B+tMXuDqk2flNUjvSFossJsRdcIN7tgbh6YqXYg91Kvoog5jTAFauUiiUWfPDz8Y
         92/kIed5dH/SXKwCx3iPg5g8rdW3tRME2Lf9ZK3qIHnx1aY8P2tnRw4TRfZdarmLYG7f
         5aNGaIcbXXLhdrnDqiD+wnhGk6uYyG/ay/+JH9hxIliv+z0pfYHF17MhqsDnr9XRb2vj
         kApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327859; x=1776932659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9gaYFQm7e+OPsK3uV9LKydMJoBgr2bMgA6yHNhYj+s=;
        b=TjTvuQdg9UWPf3Ob8Ct1yl6GB0JBgCfESi1oFmxSpIQl9WCjPaWaby57efUGnDaatV
         mwcKA1xTwxCpXgIyWp+L+fczsJRCVcNKvxu1D0pcxgGJ53wf1Zeuf7lJGbclN1iG4PVZ
         LUk0l1Zv0PToKsv90t2v79oE5nfFTgH2muzqk1PuH1RDNrv0SdUFDXFa/Pm2QZsCguCN
         MTIxmNyPc+i0IAP3CmBW5dugRsfV38Os7x+FprlLVWHZpUWaNRfM7hME1L5rNjYv0Kwu
         LRfzqVlkF8OLUknJ1mUDGrgB++Xo+WzBQuUPxYEFReoYYN7E3stRbGHdfce+hKGKMNHS
         frzA==
X-Forwarded-Encrypted: i=1; AFNElJ8satoy/PtaMaCH7bP2ECg55Jetb3UkMKTZnl8nX3VakZ1R+iE/4f0VlAuGrAGQ3HCGoBfs4wbXLDQG8Epxu5Mb@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLpS8RZzHffZy+Q07WqYNq+SBLBxLLBIYd1sBWctm2v4F14f1
	aHFpsZglOEzjERIyBDVjNt1dc1Wt5CgNK9w8iwteNSQCsjGWUsCoOk9xUpnxi/z7MfU=
X-Gm-Gg: AeBDietDyzEwCGyRyzgqUZuOfWHybrv6oHCM4OKOjXnZEskuyfJg+O9WWFotJ/AbtI/
	WeoXSLAZnIOHiSrIDj0bT+g4lkyKvi8IjbO+5acVDknGIM+PlcSXtO5lfLT55r44Krm7UUyW92y
	1RjpN9RIgj7YGPLNPskgqjFpbeHDE0fCzdvnQN2FFALkY0DJXO01Bd12BLfQ/8ECQMiw4FruuNV
	jKJkD+S2yMImj7UX9dJeMAznnZEgUn6+T923bWpWbkw7fY2KyIHDHc5N6mExiuN9blC54BtPAj1
	XRUgfdUOtT8AElsi/DFd52f8fTt0BqEBb4lazbZ2cTZIMwI9b7nyasaox1Gnnp0LcKbjsb9CKkg
	GlC9SSL8H+KgoHmw6u9Mxgc7qLq1y0IZAGI28uDHDhj4x9iI5H5V4bvL/Z7zMc3xRCQWVd3bm7D
	2Y7PivseTk6ZSp6SsEuIK+HVoa4evWPbDSNd7v5NKM
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr291830395e9.21.1776327858543;
        Thu, 16 Apr 2026 01:24:18 -0700 (PDT)
Received: from [172.17.16.20] ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ad1e4fsm71691115e9.1.2026.04.16.01.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:24:18 -0700 (PDT)
Message-ID: <5bbc2d46-0876-43fe-b72d-e9693775578d@linaro.org>
Date: Thu, 16 Apr 2026 09:24:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES 0/4] More perf.data header validation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>
References: <20260414204847.293557-1-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260414204847.293557-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/04/2026 21:48, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	This is picking up from what was reported in the previous
> series, pre-existing lack of perf.data file validation, processing files
> and buffers in header.c in a similar fashion.
> 
> 	There is more to process in the trace data, but that is a
> different can of worms that needs to be dealt with in a similar,
> upcoming patch series,
> 
> 	This is probably 7.2 material, but if feeling this can still
> sneak into 7.1, feel free to do it :-)
> 
> 	Now lets see what Sashiko discovers while I still don't have it
> running locally right after Claude, before submitting it publicly, which
> will soon happen :-)

If only checkpatch.pl ran Sashiko automatically... It would be one less 
box to tick to get it right, of the many many boxes.

> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (4):
>    perf header: Add section bounds checking to the fd read path
>    perf header: Validate string length before allocating in do_read_string()
>    perf header: Sanity check HEADER_EVENT_DESC
>    perf header: Validate bitmap size before allocating in do_read_bitmap()
> 
>   tools/perf/util/header.c | 33 +++++++++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 6 deletions(-)
> 

