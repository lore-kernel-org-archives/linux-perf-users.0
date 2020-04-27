From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v2 01/11] perf expr: unlimited escaped characters in a
 symbol
Date: Mon, 27 Apr 2020 15:01:23 +0530
Message-ID: <0930a64c-5c33-3527-949b-41ae42fefe52@linux.ibm.com>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-2-irogers@google.com> <20200423112905.GG1136647@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200423112905.GG1136647@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org



On 4/23/20 4:59 PM, Jiri Olsa wrote:
> On Wed, Apr 22, 2020 at 03:04:20PM -0700, Ian Rogers wrote:
>> Current expression allows 2 escaped '-,=' characters. However, some
>> metrics require more, for example Haswell DRAM_BW_Use.
>>
>> Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/util/expr.l | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
>> index 2582c2464938..95bcf3629edf 100644
>> --- a/tools/perf/util/expr.l
>> +++ b/tools/perf/util/expr.l
>> @@ -73,7 +73,7 @@ number		[0-9]+
>>  sch		[-,=]
>>  spec		\\{sch}
>>  sym		[0-9a-zA-Z_\.:@]+
>> -symbol		{spec}*{sym}*{spec}*{sym}*
>> +symbol		({spec}|{sym})+

Tested by: kjain@linux.ibm.com

Thanks,
Kajol Jain
> 
> yep, much better ;-)
> 
> thanks,
> jirka
> 
>>  
>>  %%
>>  	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
>> -- 
>> 2.26.2.303.gf8c07b1a785-goog
>>
> 
