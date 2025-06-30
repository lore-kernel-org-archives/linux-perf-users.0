Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC6EEC0
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274847; cv=none; b=vDfpSqLzSg4OxpeoBhsZGu7h+T3kmWiwseisHIDtku/ktzUhgP2qHhLr5UpDyNUyxXqa88yCuSszGFANVwuh+SzmmLemHiCJCWikwDTt5wQr6Bci3wkD8BKXQ8rbooKpj/+KeoC9gNQLnUDQxrMisRymElyt+QDyANKgKELFIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274847; c=relaxed/simple;
	bh=pG69dsn1qT1G2CK2vAd+AMlEBsBzpdXBa3/6S8PX44c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gwa1r4kzGGprIpMJx1UUvkKXVC5ELXBsxhah0DAXrFhdYRQ1xxg3IClLevO2qQpnsmG1dpvkd3M5VeoSgGUVyXN883Dyylmcz6Dbp0nah7jP97+e2uGd+JZDhvLv+d35dKzcxo0BDJvlpOiZwMjeTrwlP29kiC5MDYtzKhBrZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oEhRNyBM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEhRNyBM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so10362375e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751274844; x=1751879644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k725XEyUWw1sdx9utxFrAUAXo1FfhnAIN7734FL4f6E=;
        b=oEhRNyBMdHJi1h2azFeIJNeoSwT88PP/nR0Q3d3iWSZcqw43j+riUZAsoCts8TVxJS
         WsCeI7FhZkQ6Uosd2LYq3P0C3U/8aL326+4cT8uoXwbLcakfQTsWCmV63U0mJQDWvlsw
         7C9CcTUaQ4ZBzcT4UIOZawbUHj4rtQ5AAuQPk4yI5gBVVvuyhGb6JkK6kf/WyWigz0Zo
         WA8ImFsGds7O2XUvzPZe71jWgwC8ALwD1vZ9Ut6mdYHf7TW7RgBWVCLS9Py2w4AAWHVl
         yrNFtdhYDHkGD3b1nvdfkoqTpg0MU6HS9J+FxDfvRz4b6aCGo09n46i9Ce3mKcxhjbmE
         RQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274844; x=1751879644;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k725XEyUWw1sdx9utxFrAUAXo1FfhnAIN7734FL4f6E=;
        b=qVbDHA8n0JURRqNAztZ3c0NA1KGVgNUnhvMJd54DJV0yhfe3PpaBHcpDtKa11jBYgy
         59vjUUXXWdBeKt1zc7cuOxOMbFpBwK2OJU8zWIvhFpCynWoK0nKF/gR0whHFD+OaysW3
         c7kClJA0fmKcUZmvR8pVeV8nAWR5yTQeBiCP0sXKJSsAtlHLUD8lyZe/PhqyKM06Xn/h
         5tVTX5DUgf3F+W+jhwJdmgBEENZpDQnCCULQDr+BV1QEMdY4ud4P3QGYv91loR+WHz9E
         EMGjGrS5BPUjpKWPmSwRx17qEBwsO3u8YQdvvRusQndwuAvrIMyglab9xalZI0C7fQN8
         76zQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6E5lMCrMlKDe1G/Yp/FzlNqDFSG0sPoU0oPmH3z72BToYpBB0J2gIvVhEn6CXBgoDrhfyWLh9WeA1j/Ld7Sik@vger.kernel.org
X-Gm-Message-State: AOJu0YwnaZxYAlQa7qHWl4M0EXZWFw1ar/ZzuOoVbvJHtDwtV+1qdYH/
	LHvHbO9tSl2Lkm3tO0VBV4o+N9tUXGBo9NOiqawSKXSD5Yi2adTJmf0Aounejlwhd3g=
X-Gm-Gg: ASbGncsGWxrEkoZaXNvwNW8e56f8jH2KBxcmuAk5Dw4eLXuShbioCV9EdopOZ7T3mjT
	+4OjceOpgChpN9tM7s+Dl+ArUk5kfma1OLw9V9jjhLd0/53U/jXtGW+XC/eyxBsLlC0rvPwCEoD
	kNRvsv2+t2k533GPDRpswJCAY2/m1jw8s/0ipFT9IW2EP9VM2BBvIml3OQuNpGzSKUrFlgoPGoF
	HgpPWyJ74wL0L2wXrWm74mlD+x0nG20ytOTKlymlKiVjdIUT6UsuZLabq4evuYHeL6UFMxWjKM7
	JHuXfiz48Np/jF71PNfflQrMilQrvvtLLpEb+n0o0uM7wNv4fuUtp4220qROBa9/ko0=
X-Google-Smtp-Source: AGHT+IFYoFBPKKngs821UJ8n0tFqXZPviDTIJ6NnZlA9GTMUmKwKlnhVaLOZ3Yl40O1NkZSxJ8b8eg==
X-Received: by 2002:a05:600c:6295:b0:442:d9fb:d9f1 with SMTP id 5b1f17b1804b1-453a1708a45mr23146695e9.4.1751274844110;
        Mon, 30 Jun 2025 02:14:04 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a35sm9986321f8f.57.2025.06.30.02.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 02:14:03 -0700 (PDT)
Message-ID: <f3524574-03a4-491b-98d1-8a384132ec5b@linaro.org>
Date: Mon, 30 Jun 2025 10:14:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test: Add basic callgraph test to record testing
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>
References: <20250628015553.1270748-1-irogers@google.com>
 <898927c3-e85f-4a9a-9374-6fdb49236410@linux.ibm.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <898927c3-e85f-4a9a-9374-6fdb49236410@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/06/2025 9:01 am, Thomas Richter wrote:
> On 6/28/25 03:55, Ian Rogers wrote:
>> Give some basic perf record callgraph coverage.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>> v2: Pick up s390's needed "--call-graph dwarf" as spotted by James
>>      Clark <james.clark@linaro.org>.
>> ---
>>   tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 2022a4f739be..b1ad24fb3b33 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -12,8 +12,10 @@ shelldir=$(dirname "$0")
>>   . "${shelldir}"/lib/perf_has_symbol.sh
>>   
>>   testsym="test_loop"
>> +testsym2="brstack"
>>   
>>   skip_test_missing_symbol ${testsym}
>> +skip_test_missing_symbol ${testsym2}
>>   
>>   err=0
>>   perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>> @@ -359,6 +361,33 @@ test_precise_max() {
>>     fi
>>   }
>>   
>> +test_callgraph() {
>> +  echo "Callgraph test"
>> +
>> +  case $(uname -m)
>> +  in s390x)
>> +       cmd_flags="--call-graph dwarf -e cpu-clock";;
>> +     *)
>> +       cmd_flags="-g";;
>> +  esac
>> +
>> +  if ! perf record -o "${perfdata}" $cmd_flags perf test -w brstack
>> +  then
>> +    echo "Callgraph test [Failed missing output]"
>> +    err=1
>> +    return
>> +  fi
>> +
>> +  if ! perf report -i "${perfdata}" 2>&1 | grep "${testsym2}"
>> +  then
>> +    echo "Callgraph test [Failed missing symbol]"
>> +    err=1
>> +    return
>> +  fi
>> +
>> +  echo "Callgraph test [Success]"
>> +}
>> +
>>   # raise the limit of file descriptors to minimum
>>   if [[ $default_fd_limit -lt $min_fd_limit ]]; then
>>          ulimit -Sn $min_fd_limit
>> @@ -374,6 +403,7 @@ test_uid
>>   test_leader_sampling
>>   test_topdown_leader_sampling
>>   test_precise_max
>> +test_callgraph
>>   
>>   # restore the default value
>>   ulimit -Sn $default_fd_limit
> 
> Works ok for s390
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

