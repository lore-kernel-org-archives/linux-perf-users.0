Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF55214AD26;
	Thu,  9 May 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248895; cv=none; b=uR+HpMWwgTBhvwi2YAm2DmLkdWINb789Oo6roSYu+ctgjJS5lXpSwR+FHtCuKZuoJLwo6prIBe92dykenlRTWYNKb/rHdbnNtx+3o/yaNVju2PltfKaowT1BIFqfWL7sKFHSDHkJDjn1fzd6kunSustBNsCRpGN3rmmmOlDUTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248895; c=relaxed/simple;
	bh=DB7SKalhIH+6stQ/0tcsYTdtbo7WaE+lMLBwruwT/Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/aih5dNdiR5oJNCSiPafjFwOHEQjod00kfvM5G3Pcy4sNJEIygxiENOlYt+2jrfWzgX0H91NpyGBOPiw2122shP9ACICvTDZp0RwGenHNb5/buBjHsqcEoKH6IWcez8g7zHOeBbyQDOHlJRfrd/N7mwzYw6QiYqTbbPbRiZ3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B0D106F;
	Thu,  9 May 2024 03:01:57 -0700 (PDT)
Received: from [10.57.34.44] (unknown [10.57.34.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 655973F6A8;
	Thu,  9 May 2024 03:01:30 -0700 (PDT)
Message-ID: <45d28735-043f-43fd-bd2f-9dd8cb5259e8@arm.com>
Date: Thu, 9 May 2024 11:01:26 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf lock info: Display both map and thread by
 default
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240508134259.24413-1-nick.forrington@arm.com>
 <20240508134259.24413-2-nick.forrington@arm.com>
 <CAM9d7ciQ5idMLWO51JrpNEbFtdtrgz3o0qashX5dL2y1d1MRyw@mail.gmail.com>
Content-Language: en-US
From: Nick Forrington <nick.forrington@arm.com>
Organization: Arm
In-Reply-To: <CAM9d7ciQ5idMLWO51JrpNEbFtdtrgz3o0qashX5dL2y1d1MRyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 08/05/2024 22:18, Namhyung Kim wrote:
> Hello,
>
> On Wed, May 8, 2024 at 6:46 AM Nick Forrington <nick.forrington@arm.com> wrote:
>> Change "perf lock info" argument handling to:
>>
>> Display both map and thread info (rather than an error) when neither are
>> specified.
>>
>> Display both map and thread info (rather than just thread info) when
>> both are requested.
>>
>> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
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
>>
>>
>>   CONTENTION OPTIONS
>> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
>> index 230461280e45..d0b8645487ad 100644
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
> it seems you need pr_info("\n").  Where does lock_output come from?


It's a static FILE* that defaults to stderr.


It's used by dump_threads and dump_map (via fprintf), so I think it 
makes sense to use it for the output spacing between them?

>
>
>>                  dump_map();
>> -       else {
>> +       }
>> +
>> +       if (!info_threads && !info_map) {
>>                  rc = -1;
>> -               pr_err("Unknown type of information\n");
>> +               pr_err("No lock info specified\n");
>>          }
> I think we can remove this block now.


The original error looked like a function input sanity check (rather 
than for handling user input), so I kept it (even if it should no longer 
be possible for a user to trigger it).


Although I can remove it (or move it to the start of the function) if 
you prefer.


Thanks,
Nick

>
> Thanks,
> Namhyung
>
>
>>          return rc;
>> @@ -2578,9 +2583,9 @@ int cmd_lock(int argc, const char **argv)
>>
>>          const struct option info_options[] = {
>>          OPT_BOOLEAN('t', "threads", &info_threads,
>> -                   "dump thread list in perf.data"),
>> +                   "dump the thread list in perf.data"),
>>          OPT_BOOLEAN('m', "map", &info_map,
>> -                   "map of lock instances (address:name table)"),
>> +                   "dump the map of lock instances (address:name table)"),
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
