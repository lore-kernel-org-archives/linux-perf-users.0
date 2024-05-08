Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858CE7442E;
	Wed,  8 May 2024 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159732; cv=none; b=aPrVYfbOynnD1CXMo04BkcirwIB3n40+oaofBe620pUHu9OmUDsm4Lvt+2saeGJcxDN5YnvKSyYqGyoIZeIHvLRYUb6tXpNvPh9pUnlgGpBOrWEU0k5Ycp2s1A7n5Lyc/NEqGXgSONTaZJR5w/5Fi/1S62tKwc5Fsz7Etm9Hx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159732; c=relaxed/simple;
	bh=2U+lQYBT9fkEJIVjOh9dsby6cdeI9wj4uLu2lvfSCAU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i0OlHxrbP8ixXX0qoWvfrYD4pP0ODtkx5veB7trwkq6+GX0HAnUjAcJQR73O7zO/iM6FmeC2uN7g9232Pnp6nyJSbbLCPwz/YwMN4WkiH2oSca6O5PbCOhqUkv1NlMb0dc4hQrpiKq2cwQI0nqAlEN5ib0NCYYqBpvPJgUlkHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A568A1063;
	Wed,  8 May 2024 02:15:54 -0700 (PDT)
Received: from [10.57.34.44] (unknown [10.57.34.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 648CC3F6A8;
	Wed,  8 May 2024 02:15:27 -0700 (PDT)
Message-ID: <eb7872ad-4c38-40c3-875b-5150b066f895@arm.com>
Date: Wed, 8 May 2024 10:15:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nick Forrington <nick.forrington@arm.com>
Subject: Re: [PATCH v2 1/1] perf lock info: Display both map and thread by
 default
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240502091446.3037-1-nick.forrington@arm.com>
 <20240502091446.3037-2-nick.forrington@arm.com>
 <CAM9d7cjWDwg1nQPL4qDKHi59pmhrZq8+c8GhsgAT72cLUv_i2Q@mail.gmail.com>
Content-Language: en-US
Organization: Arm
In-Reply-To: <CAM9d7cjWDwg1nQPL4qDKHi59pmhrZq8+c8GhsgAT72cLUv_i2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/05/2024 19:32, Namhyung Kim wrote:
> Hello,
>
> On Thu, May 2, 2024 at 2:15 AM Nick Forrington<nick.forrington@arm.com>  wrote:
>> Change "perf lock info" argument handling to:
>>
>> Display both map and thread info (rather than an error) when neither are
>> specified.
>>
>> Display both map and thread info (rather than just thread info) when
>> both are requested.
>>
>> Signed-off-by: Nick Forrington<nick.forrington@arm.com>
>> ---
>>   tools/perf/Documentation/perf-lock.txt |  4 ++--
>>   tools/perf/builtin-lock.c              | 22 +++++++++++++++++-----
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
>> index f5938d616d75..57a940399de0 100644
>> --- a/tools/perf/Documentation/perf-lock.txt
>> +++ b/tools/perf/Documentation/perf-lock.txt
>> @@ -111,11 +111,11 @@ INFO OPTIONS
>>
>>   -t::
>>   --threads::
>> -       dump thread list in perf.data
>> +       dump only the thread list in perf.data
>>
>>   -m::
>>   --map::
>> -       dump map of lock instances (address:name table)
>> +       dump only the map of lock instances (address:name table)
> But your change allows both thread and map info to be printed, right?


Yes

>>   CONTENTION OPTIONS
>> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
>> index 230461280e45..86c68c39aac0 100644
>> --- a/tools/perf/builtin-lock.c
>> +++ b/tools/perf/builtin-lock.c
>> @@ -1483,11 +1483,16 @@ static int dump_info(void)
>>
>>          if (info_threads)
>>                  dump_threads();
>> -       else if (info_map)
>> +
>> +       if (info_map) {
>> +               if (info_threads)
>> +                       fputc('\n', lock_output);
>>                  dump_map();
>> -       else {
>> +       }
>> +
>> +       if (!info_threads && !info_map) {
>>                  rc = -1;
>> -               pr_err("Unknown type of information\n");
>> +               pr_err("No lock info specified\n");
>>          }
> I guess you made this condition impossible.


Yes. (I kept/updated the error handling for potential future errors)

>>          return rc;
>> @@ -2578,9 +2583,9 @@ int cmd_lock(int argc, const char **argv)
>>
>>          const struct option info_options[] = {
>>          OPT_BOOLEAN('t', "threads", &info_threads,
>> -                   "dump thread list in perf.data"),
>> +                   "dump only the thread list in perf.data"),
>>          OPT_BOOLEAN('m', "map", &info_map,
>> -                   "map of lock instances (address:name table)"),
>> +                   "dump only the map of lock instances (address:name table)"),
> Ditto, I think we can drop the 'only' part.


Ok, I'll submit a new version with this removed

> Thanks,
> Namhyung
>
>
>>          OPT_PARENT(lock_options)
>>          };
>>
>> @@ -2694,6 +2699,13 @@ int cmd_lock(int argc, const char **argv)
>>                          if (argc)
>>                                  usage_with_options(info_usage, info_options);
>>                  }
>> +
>> +               /* If neither threads nor map requested, display both */
>> +               if (!info_threads && !info_map) {
>> +                       info_threads = true;
>> +                       info_map = true;
>> +               }
>> +
>>                  /* recycling report_lock_ops */
>>                  trace_handler = &report_lock_ops;
>>                  rc = __cmd_report(true);
>> --
>> 2.44.0
>>
>>
