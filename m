Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144731A4F21;
	Mon, 11 Nov 2024 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345275; cv=none; b=K85YaGG6yzwPVOkECr/jfGqBwENz/ToZt0KkGWJGfiWXzmBr4x+8r4CUl6SAx1Sk9KqQtagNZInXfDRyEVqqP5Df7bwLQDn6tH/0kQRhjHNX1uuGoKlK72wxf9kHGswtnhd+ExBsjjuzttetYEipeaOVK5zkGZlkq9r86GbdgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345275; c=relaxed/simple;
	bh=jIKJW6Fo/uFQh3Y3EwDAHT/7Hlv9NMc8opbLm2I42MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne4FOtv0aVXO8QDOlbET/kWe6X6QiDyYeNJL0h7N9DEiyVsGbxswfQEHZGi5dqeI4FyQl+hliD/jTg3Rf88eDlMZ3C2wdngAN55ZG4xWTwlDH0Xqu/+61dHkSRcu3sUL22ul1aHnv3xgX17/TGD0JWysFnQB9D8GlR+2vZDV9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmTy8VvL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmTy8VvL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731345274; x=1762881274;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jIKJW6Fo/uFQh3Y3EwDAHT/7Hlv9NMc8opbLm2I42MM=;
  b=VmTy8VvLO3O8tU8dJ+v0rud82TWm7Iariupucn95aldvZRUlFGzfvIPA
   ULVUIRxUbJwkxPwwOrymZu/PNv0+ko4HOwmbRkYGiZu/DpgTbgTYhBizG
   pBzMZ3fbG4JDh6lm5HuE4IXBS7GCi2927jlLBZTuBkHcxwW5TKcKg3lDZ
   DtmnrOYFz3yZIJ8aNK5w+sNjth+BLvnGmHlCQ48qZ7wvqbh8C7oiBp1kD
   igjLEh/RHgrl6SP2d4plJ1mfZiIlpGe2ioABXsdyN1RYRnN3ERGIGeI+Q
   oIB0gKzIowXAmRzQ8IgnABUyDHF/c0kEG4ahHdO+BgS1hAcG5dXKxRNTN
   Q==;
X-CSE-ConnectionGUID: d9kZEm29SVqCCCWdMB731Q==
X-CSE-MsgGUID: exkSRvNgQPWd8SlcmMrB3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31251006"
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="31251006"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 09:14:33 -0800
X-CSE-ConnectionGUID: 7omy0XIoRKmYMxbrrBkBjg==
X-CSE-MsgGUID: ALvbiysiTYOVWray0MlKxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="124567175"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 09:14:33 -0800
Received: from [10.212.84.100] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 74A2D20B5703;
	Mon, 11 Nov 2024 09:14:31 -0800 (PST)
Message-ID: <4d5d2514-8378-4b0f-b58f-45dcd239ea51@linux.intel.com>
Date: Mon, 11 Nov 2024 12:14:30 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Add a runs-per-test flag
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241109160219.49976-1-irogers@google.com>
 <bfba7266-1903-41ca-9961-aa449f982912@linux.intel.com>
 <CAP-5=fWxMzCDQ7v1W_gMN-Yaz4yiam=5vOc8+bter0vF4cbV+Q@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWxMzCDQ7v1W_gMN-Yaz4yiam=5vOc8+bter0vF4cbV+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-11 11:10 a.m., Ian Rogers wrote:
> On Mon, Nov 11, 2024 at 7:52 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-11-09 11:02 a.m., Ian Rogers wrote:
>>> To detect flakes it is useful to run tests more than once. Add a
>>> runs-per-test flag that will run each test multiple times.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++++-------------
>>>  1 file changed, 23 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
>>> index d2cabaa8ad92..574fbd5caff0 100644
>>> --- a/tools/perf/tests/builtin-test.c
>>> +++ b/tools/perf/tests/builtin-test.c
>>> @@ -42,6 +42,8 @@
>>>  static bool dont_fork;
>>>  /* Fork the tests in parallel and wait for their completion. */
>>>  static bool sequential;
>>> +/* Numer of times each test is run. */
>>> +static unsigned int runs_per_test = 1;
>>>  const char *dso_to_test;
>>>  const char *test_objdump_path = "objdump";
>>>
>>> @@ -490,10 +492,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>>>                               len = strlen(test_description(*t, subi));
>>>                               if (width < len)
>>>                                       width = len;
>>> -                             num_tests++;
>>> +                             num_tests += runs_per_test;
>>>                       }
>>>               } else {
>>> -                     num_tests++;
>>> +                     num_tests += runs_per_test;
>>>               }
>>>       }
>>
>> Seems we just need to calculate the num_tests once at the end for each
>> loop. Something as below may works. (not tested)
>>
>> @@ -482,20 +490,19 @@ static int __cmd_test(struct test_suite **suites,
>> int argc, const char *argv[],
>>
>>         for (struct test_suite **t = suites; *t; t++) {
>>                 int len = strlen(test_description(*t, -1));
>> +               int subi = 0, subn = 1;
>>
>>                 if (width < len)
>>                         width = len;
>>
>>                 if (has_subtests(*t)) {
>> -                       for (int subi = 0, subn = num_subtests(*t); subi
>> < subn; subi++) {
>> +                       for (subn = num_subtests(*t); subi < subn; subi++) {
>>                                 len = strlen(test_description(*t, subi));
>>                                 if (width < len)
>>                                         width = len;
>> -                               num_tests++;
>>                         }
>> -               } else {
>> -                       num_tests++;
>>                 }
>> +               num_tests += subn * runs_per_test;
>>         }
>>         child_tests = calloc(num_tests, sizeof(*child_tests));
>>         if (!child_tests)
> 
> It's basically the same thing, instead of doing increments and then
> multiplying by runs_per_test you just add on runs_per_test and avoid
> the multiply.

The "else" should be unnecessary either. But the above is just a nit.

> 
>>>       child_tests = calloc(num_tests, sizeof(*child_tests));
>>> @@ -556,21 +558,25 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>>>                       }
>>>
>>>                       if (!has_subtests(*t)) {
>>> -                             err = start_test(*t, curr, -1, &child_tests[child_test_num++],
>>> -                                              width, pass);
>>> -                             if (err)
>>> -                                     goto err_out;
>>> +                             for (unsigned int run = 0; run < runs_per_test; run++) {
>>> +                                     err = start_test(*t, curr, -1, &child_tests[child_test_num++],
>>> +                                                     width, pass);
>>> +                                     if (err)
>>> +                                             goto err_out;
>>> +                             }
>>>                               continue;
>>>                       }
>>> -                     for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
>>> -                             if (!perf_test__matches(test_description(*t, subi),
>>> -                                                     curr, argc, argv))
>>> -                                     continue;
>>> -
>>> -                             err = start_test(*t, curr, subi, &child_tests[child_test_num++],
>>> -                                              width, pass);
>>> -                             if (err)
>>> -                                     goto err_out;
>>> +                     for (unsigned int run = 0; run < runs_per_test; run++) {
>>> +                             for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
>>> +                                     if (!perf_test__matches(test_description(*t, subi),
>>> +                                                                     curr, argc, argv))
>>> +                                             continue;
>>> +
>>> +                                     err = start_test(*t, curr, subi, &child_tests[child_test_num++],
>>> +                                                     width, pass);
>>> +                                     if (err)
>>> +                                             goto err_out;
>>> +                             }
>>
>> Can we add a wrapper for the start_test()? Something similar to below?
>> It avoids adding the loop for every places using the start_test.
>>
>> +static int start_test(struct test_suite *test, int i, int subi, struct
>> child_test **child,
>> +               int width, int pass)
>> +{
>> +       for (unsigned int run = 0; run < runs_per_test; run++) {
>> +               __start_test();
>> +       }
>> +}
> 
> I think the issue is the code has become overly indented. 

And duplication.

> Having a
> start_test function that starts some number of tests feels less than
> intention revealing. Perhaps (in the future I'd like to tackle other
> things for now, such as new TMAs :-) ) we can create all the child
> tests in one pass, then just have start_test and finish_test work with
> the child tests. 

It may be easier to understand if we have both start_mul/all_tests() and
start_single_test().

> (Off topic) Something else I'd like is to move the
> slower running tests to the end of the list of tests so you can see
> the earlier results while waiting.

I'm not sure how useful it is. But for me, I always wait for all the
tests complete, no matter how fast the results of the first several
cases shows.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
> 
>>>                       }
>>>               }
>>>               if (!sequential) {
>>> @@ -714,6 +720,8 @@ int cmd_test(int argc, const char **argv)
>>>                   "Do not fork for testcase"),
>>>       OPT_BOOLEAN('S', "sequential", &sequential,
>>>                   "Run the tests one after another rather than in parallel"),
>>> +     OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
>>> +                  "Run each test the given number of times, default 1"),
>>>       OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
>>>       OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
>>>       OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
>>
> 

