Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B11DE2BF
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025017; cv=none; b=dd47Ky4puzIhDu8G9Fs0ptYqEW2ghNlMnFR/quAF49SFEo6h7d0WI8gDui/C65Lz6UIAZSDb7DHUWv1eUiOqHjctSrtxRuUH1TOQihK9f2zAI+9n0uSgg9fA/F66no6eFT3Qu4hdmQlUzd55sIIqj7Cz5/24cpW9O5fwn3JVcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025017; c=relaxed/simple;
	bh=G6099FHO6nWJJHNre2ycddLPVGziWYRVcBYD5XNOTSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LaOFlaID9Gk57OW6QJ0BSGrpsw1hXcjOK8+tzrPRvBbQV//iloLO4gXtt2w4ox3YMqrE6AcH8lj1Ywbq40jie9suAL8OPZ8gxIh+sJtQ9rdJbbjf9rzweQ1nOmaxDyw/5H3HUqyUwjzjAFAmQbhJzErTBdk5IBU7cNbD+IGaNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GQn0PSej; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQn0PSej"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso4399355e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 02:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737025014; x=1737629814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mnFejfmTPjeYudZjpoT12TW6mGK7qWBB/S51xWl9wMM=;
        b=GQn0PSejyuJfsWBID8g2br1OuEyaFxGerTZtVhugGnwuEc+XJaUAJI5COhdSd2BC/g
         K4sKCPONVHC4zIayASGDrkaEylVKfUw+hI3tK5cLmbMS86u0yODWkZetMkpJWZmV00Ql
         P/Eiq/WGl90AnjZcCiU5QzoKucS5L/8QGSVgI6gm6AThMtomucZrbwPYUJ0e6BmyAqSt
         G/bD5n2Tz4gPfW3W1b92f6Ej4L9YTvN1xeQOCb69ycXT6MjZ4wtqus+vL6nHSeskgifQ
         mt5qlc+XDdcI696PbVwAUsIn8QCy7cHHVWGbUmCe4e7Ek9roxxTS4u1OL0gMTiO8CZnA
         0xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737025014; x=1737629814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnFejfmTPjeYudZjpoT12TW6mGK7qWBB/S51xWl9wMM=;
        b=qTIPneo4czTEbykSJfA8AHKT+QJyCNypNcnb3Cq2oUFxACab0na3B+blgw9Ccjm5nd
         zbgnkO99oBHf9iweZkVMB/02inqvmcC+PTot/fpHj25DIDkErWwRdf4Qz2wsIcOOnJVi
         IkSXc/Hw4npCGgLGHbg9AoeAyoFPn30BwPdrD00xgp1xqRaE4OgDuwTvY+yAS+3jLSVe
         j322USzt90Y1WI5Po8twoso3VxcMxq88r6DCr5cF0wQyaLvhSV72Uld6YK9Up3dqyqEb
         rUmCjvIzSFhY6ywpzUw9TQc6idfcxxgdnLNvzWY4JIX4prsh+ogLv3T2oKbrFD5YMx4E
         jNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVToqrxpP/BZaEa07NYAEiB/LlgsXLn871JbJ772fbV4zuhOm+jxCA9kLQuLMpY6jjLeElrlLuzznSi8NjR3U8z@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWn7xmRpk+k+xUoRVmV3PNJKLi6QZzcgZlM/pxKjbC5Rja93Q
	QRYcFAYm/oX8ktAtNstXIoFPfbnfCWH3x98Jo1RxVPlB6KZ0q3yQl7q3cluauUo=
X-Gm-Gg: ASbGncvn4TfQsEq0q2WnL1BmNsubtcUQi2YmORiw8SRlvWUVSsFvXG6Y/XhD4BY6nDk
	WvustA1Vl64rLERV10yaLMNeqPi/kAEEkagsAgrzaaOq5UPDl41BQSeoAsopfO+XuohTbwq96aW
	eoTsLDrXpHzMRv8SjtiSZatGiX0swR9xBDvB/QqSsfdSATx9a67x4/jI/oHRFMtXDjRCdjVPPL8
	QWvIkMUsVdRSxijYYcxrVcSnSsF/RQ24OSe/MfmQXpINiYPT0dm/7Ux1/intoF5QA==
X-Google-Smtp-Source: AGHT+IEaM+HUjw9DUX+MbLPNx3KI+ADTauH4ORBCsTCMfr5r1tpw6yofjrJn0lgwY5VXgcFUbkGkBA==
X-Received: by 2002:a05:600c:1987:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-436e267850cmr306974415e9.7.1737025013678;
        Thu, 16 Jan 2025 02:56:53 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383df8sm20492748f8f.38.2025.01.16.02.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 02:56:53 -0800 (PST)
Message-ID: <45f0bebf-6d4a-448c-8088-db2facbbfa46@linaro.org>
Date: Thu, 16 Jan 2025 10:56:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Mypy and pylint build support
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
 Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20241025172303.77538-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/10/2024 6:22 pm, Ian Rogers wrote:
> Support building perf checking the python code with mypy and/or
> pylint. Currently there are too many errors to make this a default.
> 
> Shellcheck generates no output on success, so linking shellcheck files
> doesn't cause `ld` to fail. Mypy and pylint generate output that will
> break `ld` so change the Makefile.build to ignore test log files.
> 
> Address some initial mypy errors.
> 
> Ian Rogers (6):
>    tools/build: Don't pass test log files to linker
>    perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
>    perf build: Add mypy build tests
>    perf build: Add pylint build tests
>    perf test: Address attr.py mypy error
>    perf python: Fix setup.py mypy errors
> 
>   tools/build/Makefile.build         |  6 +++++-
>   tools/perf/Build                   | 32 +++++++++++++++++++++++++++---
>   tools/perf/Makefile.perf           | 14 +++++++++++--
>   tools/perf/arch/x86/Build          |  6 +++---
>   tools/perf/arch/x86/tests/Build    |  6 +++---
>   tools/perf/pmu-events/Build        | 25 ++++++++++++++++++++++-
>   tools/perf/scripts/Build           | 26 ++++++++++++++++++++++++
>   tools/perf/tests/Build             | 32 +++++++++++++++++++++++++++---
>   tools/perf/tests/shell/lib/attr.py |  8 +-------
>   tools/perf/trace/beauty/Build      |  6 +++---
>   tools/perf/util/Build              | 31 ++++++++++++++++++++++++++---
>   tools/perf/util/setup.py           | 10 ++++++++--
>   12 files changed, 171 insertions(+), 31 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

   $ make PYLINT=1 MYPY=1

   TEST    python/twatch.py.pylint_log
   ...
   Your code has been rated at -5.00/10
   ...
