Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1647405FB
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658497; cv=none; b=IeqqwWSbWmc8P6k3gmsf1sIHNMd5MJBWPHBD89r3MvI8Y53hlLRqDYGoIL4KAKV8540n+G+hiGbobRe9N/L0jbPsfLSgEF6KehNtTLGwLCUhE0BLBmdFdC+BwDks0uo8gX6Zuiyf6fneMB36WLmmG/uUCNQdF0Yl+bqwDo/SE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658497; c=relaxed/simple;
	bh=ayOP6kmT0Uhxqgho5scUs/ofCyaD3oPtnl1pskkLz5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcxjBoLSN2tnxeHlCAQPgVPVQiADsKkihGXyrmW/Jy71xchCnZvTcXv5CXWb13HmrdUXfKvdW1G1h2MJGJyUs6mYC4eunglIh37gs/e3ZZJhRKUDmyZsvXe1xzQ+8OEkb7nZo1aXjdk/WhK5JDrQiO1VfJ2vMpiSxHfTeWnSGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ed9tz3b2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ed9tz3b2"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5398e4ae9efso2865409e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728658494; x=1729263294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqJdH6KvlGOaJs6LPdOjTJk5FO4Bru3b1GwmXSj7OG0=;
        b=ed9tz3b2N1MfcdCGQcfVoznA64jeL8e3DVCWAatIi7fbH7XuC6x+90RWiyHdX7fwkR
         IpgQ2a5rDA9AQesDEiaWo3iaCLPbYxU2YSmyE0qVlzm0zLP+RFsxovosiNCTRsqSsIEk
         DL5N6blfm5CbkL1dlZF38+VNXGWxL9CFuKPiG1G8cBTo5b8U2LO2TLa6JkChyU7+pzb2
         zNSEDTWKX7idKL7ew/jbXuJMTltOLX8YAJ/I8fF5EzNHYxY3FpLcUMIQtAf2OjHN/7oo
         JEQ5p7s66QvJ8Sh1OC9iIRjBuDs7zJ7T9ZIodf2C+8oTCwFVnsJe0JM2OsJdRwsZHkXc
         h0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658494; x=1729263294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqJdH6KvlGOaJs6LPdOjTJk5FO4Bru3b1GwmXSj7OG0=;
        b=ECsME+n2TtWvQnptStOLBO8hLe2copvwiKgdJ0TI29+d934NexeUYcApn6LbZR0mGY
         2eOAyz0X8SLdeo9chtMvZEowOa9TC3wsJ4cAdFO/mrJqC5NFQccESrYb7+xWMb0CQgUH
         2/8H0FEEclKhx1a3xeWJmKpUMetn26xzab5c2Q55wJs80u6n50V72l86LyE3ULvIX+1l
         wbYMS+fWaKBk0eaGAMbxU2bg2Og1fCK+CQ0lof1LbwMMOUdrxR8w9G2nlQ+47Witb23D
         BO3W5XdvQxu5zK4MXk+GBxK4Dohvqd+6qlBuvExdD5x5ZnDuY7SEiXIj/SzJIRHa+AMd
         ZrVw==
X-Forwarded-Encrypted: i=1; AJvYcCWU8HFT8ulL8NQ3+OzasHmSr0prRvCBcQq1NyqKMb07q2Hjhatea+iS2kyfNeVkZABj8W7qlFwsUL/DX9OgiZLt@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9g156vQ8CXwNiB4w3jhowT67W+nrhV7GXWVEAL4gVsP2KPLf
	eG5YyG10riRXflPrknTZpU8eEl8dGVNU1ixvrUnwdyx25WEFw4Em6vyhmYp1xUQ=
X-Google-Smtp-Source: AGHT+IGEqpHxLhsvoJ3aD2Hs3uY1bxru/hFDC2inGgVcpwnr5oCn1DIcDbUUVYp2qv7/GuTpsG+sdg==
X-Received: by 2002:a05:6512:3a8d:b0:52e:7542:f469 with SMTP id 2adb3069b0e04-539da22cdf6mr1789366e87.0.1728658493944;
        Fri, 11 Oct 2024 07:54:53 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm44130005e9.12.2024.10.11.07.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:54:53 -0700 (PDT)
Message-ID: <9513f8d7-7f42-4c1e-bdc9-d2078d46ba1f@linaro.org>
Date: Fri, 11 Oct 2024 15:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf test: Introduce '-w --list' to list the
 available workloads
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20241011143906.1285675-1-acme@kernel.org>
 <20241011143906.1285675-3-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241011143906.1285675-3-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 3:39 pm, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Using it:
> 
>    $ perf test -w noplop
>    No workload found: noplop
>    $
>    $ perf test -w
>     Error: switch `w' requires a value
>     Usage: perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]
> 
>        -w, --workload <work>
>                              workload to run for testing, use '-w --list' to list the available ones.
>    $
>    $ perf test -w --list
>    noploop
>    thloop
>    leafloop
>    sqrtloop
>    brstack
>    datasym
>    landlock
>    $
> 
> Would be good at some point to have a description in 'struct test_workload'.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/perf/tests/builtin-test.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 2201f7ed432ce9f2..f0d10d2dd0d40019 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -505,10 +505,26 @@ static int perf_test__list(int argc, const char **argv)
>   	return 0;
>   }
>   
> +static int workloads__fprintf_list(FILE *fp)
> +{
> +	struct test_workload *twl;
> +	int printed = 0;
> +
> +	workloads__for_each(twl)
> +		printed += fprintf(fp, "%s\n", twl->name);
> +
> +	return printed;
> +}
> +
>   static int run_workload(const char *work, int argc, const char **argv)
>   {
>   	struct test_workload *twl;
>   
> +	if (!strcmp(work, "--list")) {
> +		workloads__fprintf_list(stdout);
> +		return 0;
> +	}
> +

Very minor nit, but I think searching the workload name for an argument 
instead of having a 'proper' toplevel argument seems a bit weird, but I 
can see why you did it that way.

But maybe something like this might be a bit more readable especially 
when searching in the usual places for an argument. And in the future 
might survive auto doc attempts of known arguments:

   $ perf test --list-workloads

And add it with OPT_BOOLEAN() etc.

>   	workloads__for_each(twl) {
>   		if (!strcmp(twl->name, work))
>   			return twl->func(argc, argv);
> @@ -544,7 +560,7 @@ int cmd_test(int argc, const char **argv)
>   	OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
>   	OPT_BOOLEAN('S', "sequential", &sequential,
>   		    "Run the tests one after another rather than in parallel"),
> -	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
> +	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '-w --list' to list the available ones."),
>   	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
>   	OPT_STRING(0, "objdump", &test_objdump_path, "path",
>   		   "objdump binary to use for disassembly and annotations"),

