Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF281DDA35
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025094; cv=none; b=GMzEoi6bJKBm2suFIxYpiEqz4LYbtfY4mEsvmhcxiwUgTrUZsbbT3fZ5+hSXiH0x+ATvDZjTGOMk3cHvok2wCgknG9CHv3IsqhNLTpST/u05CAA9bViItWfs4OKb4C0wEFrsp9rsyjH4bZn8umMNMkomunQCZoSBQ6mQMVmtBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025094; c=relaxed/simple;
	bh=mEl9FPdNIGL+7of09FaB+aLQ+LE02jM69s1x/OSq8Qk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=B98RPVXhvXPvUlkZMqLTRwA967AqKAt96imB87ut/jBammMfRPFECo9x6EyLcY8QDhDvQlVuayaBl3hYRlsY2p37MbIz+utyKPVR61e6inGfgP1e4FDELCUHrottK+3XLvC4sPgaUcxbVgBh4lMlzdfSIwB0j3Vw5fOSMqxZAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g9Lvikjg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9Lvikjg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38a34e8410bso392402f8f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737025091; x=1737629891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tsLhHgCE8t1uHtJmL2kynlLt5kpefdWOcvDAu5xoAA=;
        b=g9Lvikjg2ILm66FRcMiGuCU5GXjvnDyPbywW4kL57qqvbqX7C1u7F/alhJOM3MBJT1
         pk8W8a5vkQFlG65oN9krnpDNt/Vzxv9JLTTlKWFZD2it/Qyp/7fUb0Dfw+6nVpOZSxJH
         KQWE5As1T2qdQf0Rr8smlqyd09Jh2yYvLwvREOxEJamYO/7A+DeYrhFcr6w+FoCX2p4w
         nHOeW7I3VreQK4Lp6lJtY3cubyKt4w28xRuZ1BwSVK5ajNRpJpeldmIHRIwUSA6GWai4
         DG0oFzPm0AfyHslBgiXPzdXgkdSQiPlmzSa9g4Lb+ZKVy98q1yFtQarRR4K/e9WGHGOX
         Qcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737025091; x=1737629891;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tsLhHgCE8t1uHtJmL2kynlLt5kpefdWOcvDAu5xoAA=;
        b=wSTuehzKJGfxtkt4EoI3om7k6IWrTB6A1Q7yvdA/Qdm2uY9/AxQWEtOEnCPzLMhZJ+
         K0R5Dp0IOEjgiTv7i4aPfkdsKm1r1ZuyiWxJEf72MLoEKGq6h4h0QMjrPpF4Ven0CHh0
         6z3d9yCtRAmi46c/8gy3rOTgGC1nYFfwZVLEjdVOOw868tJEr+UrzZXQc1eGWXxvGbLq
         tzBzzcTyrKMtPgxN18v+tdx/4Z9tl7boNzd15S2pIowPFIDl7AUDZFvNVS6hBvJ5MBGF
         oPAGwK1Q8CJDBFvG1LlXdiU2mBBAtLSOBp+MGdU9/B0mRXSyXQ27c3Kyp7DZ/6aski2Y
         F+hw==
X-Forwarded-Encrypted: i=1; AJvYcCWHZFs8CvTbTjhXqlQviAI5GW5o5D423IuzMUjC4Hf+7BRaWQqUQLE4lHHcq5Wbm67nxnAbWwhSfW+dSahCOZHG@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuGs0H82TQ8GH3M/bdFhJtNoByvVet/WpCHdgLOR8oyqyQmZo
	a2LEWOp8Lg9HgP1soePqur1V3iRuglnJpbliNLXp40751S4LT+ekYjrEdNOx5dg=
X-Gm-Gg: ASbGncuymKlsyrNZao+nnYqxllIotjGqLuEg4tMCzpFetDV6y17kVcIipKAzkaUbf7J
	efmL0EwlDGUlVrNODUzM8VPl8mfBjRdzTMyOCb0nrRVn5lm81MfQdLUVzKUl63trbwK2+5zbG8G
	6rsKtaV2SfpozuNvgwtDZgt8ZCy72qQqYcZq0VLSzDKzUwuxov9RSROFuR0uN/kRWWybCtQ+gp2
	nW0Y3awUKWNsDT5W/ODBUhOuEMC5cSAhiOk+aDbyWCNyXJHRMBJQ+eNZjB5rgvP7g==
X-Google-Smtp-Source: AGHT+IFdR4AJ/eWyTtSvWP609ybcS++0zb/CT+oNdVHiy1WuvgSrUhFhMr0Z1qGvJhn9tx8HaTJ3CA==
X-Received: by 2002:a5d:64cc:0:b0:386:366d:5d0b with SMTP id ffacd0b85a97d-38a8732098dmr27681383f8f.55.1737025090876;
        Thu, 16 Jan 2025 02:58:10 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c006sm19968676f8f.46.2025.01.16.02.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 02:58:10 -0800 (PST)
Message-ID: <64a3dadc-7c37-4e05-8d42-445142691777@linaro.org>
Date: Thu, 16 Jan 2025 10:58:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Mypy and pylint build support
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>
References: <20241025172303.77538-1-irogers@google.com>
 <45f0bebf-6d4a-448c-8088-db2facbbfa46@linaro.org>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
 Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <45f0bebf-6d4a-448c-8088-db2facbbfa46@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/01/2025 10:56 am, James Clark wrote:
> 
> 
> On 25/10/2024 6:22 pm, Ian Rogers wrote:
>> Support building perf checking the python code with mypy and/or
>> pylint. Currently there are too many errors to make this a default.
>>
>> Shellcheck generates no output on success, so linking shellcheck files
>> doesn't cause `ld` to fail. Mypy and pylint generate output that will
>> break `ld` so change the Makefile.build to ignore test log files.
>>
>> Address some initial mypy errors.
>>
>> Ian Rogers (6):
>>    tools/build: Don't pass test log files to linker
>>    perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
>>    perf build: Add mypy build tests
>>    perf build: Add pylint build tests
>>    perf test: Address attr.py mypy error
>>    perf python: Fix setup.py mypy errors
>>
>>   tools/build/Makefile.build         |  6 +++++-
>>   tools/perf/Build                   | 32 +++++++++++++++++++++++++++---
>>   tools/perf/Makefile.perf           | 14 +++++++++++--
>>   tools/perf/arch/x86/Build          |  6 +++---
>>   tools/perf/arch/x86/tests/Build    |  6 +++---
>>   tools/perf/pmu-events/Build        | 25 ++++++++++++++++++++++-
>>   tools/perf/scripts/Build           | 26 ++++++++++++++++++++++++
>>   tools/perf/tests/Build             | 32 +++++++++++++++++++++++++++---
>>   tools/perf/tests/shell/lib/attr.py |  8 +-------
>>   tools/perf/trace/beauty/Build      |  6 +++---
>>   tools/perf/util/Build              | 31 ++++++++++++++++++++++++++---
>>   tools/perf/util/setup.py           | 10 ++++++++--
>>   12 files changed, 171 insertions(+), 31 deletions(-)
>>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 
>    $ make PYLINT=1 MYPY=1
> 
>    TEST    python/twatch.py.pylint_log
>    ...
>    Your code has been rated at -5.00/10
>    ...

I forgot to add this:

  :(

I didn't know it could go negative.

