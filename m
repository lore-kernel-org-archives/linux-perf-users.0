Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81218E760
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128159; cv=none; b=Ajz7uenSnxIRgNaqxyNO05SDw6ZLlefz8T8ufgu4MDEQhQ0WCtRP81bUTTjsEx74hDxXs3j70SDZ4DAHAzv3GqIlXSfBwX3Y5XdHH1GqeTtgEAYrA5YIfRJAqgEvV9P7pXH9BekKK3o2cPwAR8ikfPLYrflviB8nr8rPcWZsZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128159; c=relaxed/simple;
	bh=cdOop4SgA1vh/Gebn3G5jLC3/otAd7+I+7npQ97DObs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5PEVy/vCyAwIh7oqFOcty1bnGfuYB52X1LTQFt7eX1bs7F42qwiUQRWIp6VJgbuiAjiiQoRp5tP+PC4s/vtBFMagCHnxN67yJizReWOm7Zg7Srt+cwFk/+fCuU9dTOeuzqmLPCgYY8x13vF7OcQ+BkRidsA8LB7sIRxdGlmZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USn/aqvh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USn/aqvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723128156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPDrIl1dLmrmQF8meD3jdG+6q5OXmQDDoM2OSiyMIcc=;
	b=USn/aqvh1ZCvzzKNv/GlWgo98r05Vz/7y8GGwDU8Gkm/ZF+15GuXNnUHyFwWoyopb7ShOV
	xaCQujNEK5Xc0sDskALWboGbyfQfIxJD4oNUyod48jR34PG6SQq2jZ/8fybc9kXBy3aPWw
	a2YF9V0FDG+YeiiCM5MhGMyGQMuRdAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-GDsKUmZRM8ufmn6v0iRQvw-1; Thu, 08 Aug 2024 10:42:34 -0400
X-MC-Unique: GDsKUmZRM8ufmn6v0iRQvw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428207daff2so7467375e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Aug 2024 07:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128154; x=1723732954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPDrIl1dLmrmQF8meD3jdG+6q5OXmQDDoM2OSiyMIcc=;
        b=wkR3l+6ToLiXWEN2G55ABMKobOS2f3/Jc70bc/akA2BK/z54vS78tB8G61Tp4h1+v4
         ietgqyt2FQ/0+ctk7pgsZ9ChB3kAsbTsG75mE4eGrVUfr0P5zzHLvCQq5Rz67zYjMfjy
         LlpG5Hd0kyK5hyhybLV8NqYNyZJwhWVCzv9sHFTZ/Q+8ESNL1eEkUPS3BZAAbZ6+OiPS
         fONo/1cxpD1BKS/Jki+oMfY6/BrjFq4B1Md1/SmT1EdLXiTg7WM827g8nM6KKt0yzWty
         6p9D03mmYR8EmPnzD+UfML7Vs8M16jTmiIvzEw1a3kRX9/JPoMC7+WO84r9d75pkMNWL
         z6nw==
X-Gm-Message-State: AOJu0Yxvl4As7HR3EInKC5H41F0TnCjMf2QwtDK+KhSxzwedTHXxhAwl
	9ecNUO88H6Cu1SxSrHjU2l0VZKZaD8oho6YH7lG72V7pvKGWRbI68Je8qTjdElAu4IX4om8ZM0n
	thFk4VKpH67zqzXK6yBWOEvJeUuuZsDDrcVqiBPrNUB6HbIiuQ5FAt+eAGhqgHJ1BCG8=
X-Received: by 2002:a05:600c:190c:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-4290af13f11mr19696915e9.22.1723128153627;
        Thu, 08 Aug 2024 07:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkERMULaaaDYwri2Sb63V29S/bTCMXPVbHosQSwb5JPk2HRYGjj++z03YW2n6AEV3M87oaew==
X-Received: by 2002:a05:600c:190c:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-4290af13f11mr19696565e9.22.1723128152798;
        Thu, 08 Aug 2024 07:42:32 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057e8fe9sm49728275e9.1.2024.08.08.07.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:42:32 -0700 (PDT)
Message-ID: <40af7af7-598b-41aa-8a2f-119f5d3fb034@redhat.com>
Date: Thu, 8 Aug 2024 16:42:30 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test pmu: Set uninitialized PMU alias to null
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
 james.clark@arm.com, rstoyano@redhat.com
References: <20240808103749.9356-1-vmolnaro@redhat.com> <ZrTPqy3omGsTTati@x1>
 <ZrTSWvyox2ET1eNm@x1>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZrTSWvyox2ET1eNm@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/8/24 16:12, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 08, 2024 at 11:01:28AM -0300, Arnaldo Carvalho de Melo wrote:
>> On Thu, Aug 08, 2024 at 12:37:49PM +0200, vmolnaro@redhat.com wrote:
>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>>
>>> Commit 3e0bf9 ("perf pmu: Restore full PMU name wildcard support") adds
>>> a test case "PMU cmdline match" that covers PMU name wildcard support
>>> provided by function perf_pmu__match(). The test works with a wide
>>> range of supported combinations of PMU name matching but omits the case
>>> that if the perf_pmu__match() cannot match the PMU name to the wildcard,
>>> it tries to match its alias. However, this variable is not set up,
>>> causing the test case to fail when run with subprocesses or to segfault
>>> if run as a single process.
>>>
>>> ./perf test -vv 9
>>>   9: Sysfs PMU tests                                                 :
>>>   9.1: Parsing with PMU format directory                             : Ok
>>>   9.2: Parsing with PMU event                                        : Ok
>>>   9.3: PMU event names                                               : Ok
>>>   9.4: PMU name combining                                            : Ok
>>>   9.5: PMU name comparison                                           : Ok
>>>   9.6: PMU cmdline match                                             : FAILED!
>>>
>>> ./perf test -F 9
>>>   9.1: Parsing with PMU format directory                             : Ok
>>>   9.2: Parsing with PMU event                                        : Ok
>>>   9.3: PMU event names                                               : Ok
>>>   9.4: PMU name combining                                            : Ok
>>>   9.5: PMU name comparison                                           : Ok
>>> Segmentation fault (core dumped)
>>>
>>> Initialize the PMU alias to null for all tests of perf_pmu__match()
>>> as this functionality is not being tested and the alias matching works
>>> exactly the same as the matching of the PMU name.
>>>
>>> ./perf test -F 9
>>>   9.1: Parsing with PMU format directory                             : Ok
>>>   9.2: Parsing with PMU event                                        : Ok
>>>   9.3: PMU event names                                               : Ok
>>>   9.4: PMU name combining                                            : Ok
>>>   9.5: PMU name comparison                                           : Ok
>>>   9.6: PMU cmdline match                                             : Ok
>>>
>>> Fixes: 3e0bf9 ("perf pmu: Restore full PMU name wildcard support")
>>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>>> ---
>>>  tools/perf/tests/pmu.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
>>> index 0b2f04a55d7b..a4730b5dc0d9 100644
>>> --- a/tools/perf/tests/pmu.c
>>> +++ b/tools/perf/tests/pmu.c
>>> @@ -453,11 +453,13 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
>>>  /**
>>>   * Test perf_pmu__match() that's used to search for a PMU given a name passed
>>>   * on the command line. The name that's passed may also be a filename type glob
>>> - * match.
>>> + * match. If the name does not match, perf_pmu__match() attempts to match the
>>> + * alias of the PMU, if provided.
>>>   */
>>>  static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>>>  {
>>>  	struct perf_pmu test_pmu;
>>> +	test_pmu.alias_name = NULL;
>>
>> We can do a bit more future proofing by instead doing:
>>
>> 	struct perf_pmu test_pmu = {
>> 		.name = "pmuname",
>> 	};
>>
>> So that all the other fields are initialized to zero, ok? I'll do this
>> change and make a note in the commit, lemme know if you disagree.
> 
> Nah, tried with:
> 
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index a4730b5dc0d9259d..c9d4ed6d684551c1 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -457,11 +457,11 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
>   * alias of the PMU, if provided.
>   */
>  static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> -{
> -	struct perf_pmu test_pmu;
> -	test_pmu.alias_name = NULL;
>  
> -	test_pmu.name = "pmuname";
> +	struct perf_pmu test_pmu = {
> +		.name = "pmuname",
> +	};
> +
>  	TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),	     true);
>  	TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
>  	TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),	     false);
> 
Isn't the error caused by a missing curly bracket at the start of the function?
Tried it and works just fine for me.

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index a4730b5dc0d9..be18506f6a24 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -458,10 +458,10 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
  */
 static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-       struct perf_pmu test_pmu;
-       test_pmu.alias_name = NULL;
+       struct perf_pmu test_pmu = {
+               .name = "pmuname",
+       };
 
-       test_pmu.name = "pmuname";
        TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),      true);
        TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
        TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),        false);

./perf test -F 9
  9.1: Parsing with PMU format directory                             : Ok
  9.2: Parsing with PMU event                                        : Ok
  9.3: PMU event names                                               : Ok
  9.4: PMU name combining                                            : Ok
  9.5: PMU name comparison                                           : Ok
  9.6: PMU cmdline match                                             : Ok

> But those macros are not liking it:
> 
> tests/pmu.c: In function ‘test__pmu_match’:
> tests/pmu.c:461:16: error: parameter ‘test_pmu’ is initialized
>   461 |         struct perf_pmu test_pmu = {
>       |                ^~~~~~~~
> In file included from tests/pmu.c:7:
> tests/tests.h:22:1: error: expected declaration specifiers before ‘do’
>    22 | do {                                                                     \
>       | ^~
> tests/pmu.c:465:9: note: in expansion of macro ‘TEST_ASSERT_EQUAL’
>   465 |         TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),      true);
>       |         ^~~~~~~~~~~~~~~~~
> tests/tests.h:28:3: error: expected declaration specifiers before ‘while’
>    28 | } while (0)
>       |   ^~~~~
> 
> So I'll not spend more time here, I'm keeping your patch as-is.
> 
> Thanks and sorry for the noise :-)
> 
> - Arnaldo
> 

