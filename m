From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/2]: perf util: map data buffer for preserving
 collected data
Date: Mon, 27 Aug 2018 11:58:56 +0300
Message-ID: <e4a206a2-882b-c37f-e68d-80e7ed39596a@linux.intel.com>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <e5591d27-5386-1d41-b09b-421316f75d07@linux.intel.com>
 <20180827082819.GC24695@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827082819.GC24695@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Jiri,

On 27.08.2018 11:28, Jiri Olsa wrote:
> On Thu, Aug 23, 2018 at 07:42:09PM +0300, Alexey Budankov wrote:
>>
>> The data buffer and accompanying AIO control block are allocated at 
>> perf_mmap object and the mapped data buffer size is equal to 
>> the kernel one.
>>
>> The buffer is then used to preserve profiling data ready for dumping 
>> and queue it for asynchronous writing into perf trace thru implemented 
>> record__aio_write() function.
>>
>> mmap_aio control structure of the size equal to the number of per-cpu 
>> kernel buffers is used to keep pointers to enqueued AIO control 
>> blocks for monitoring of completed AIO operations.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> Changes in v2:
>> - converted zalloc() to calloc() for allocation of mmap_aio array,
>> - cleared typo and adjusted fallback branch code;
>> ---
>> tools/perf/builtin-record.c | 18 ++++++++++++++++++
>>  tools/perf/util/evlist.c    |  7 +++++++
>>  tools/perf/util/evlist.h    |  2 ++
>>  tools/perf/util/mmap.c      | 12 ++++++++++++
>>  tools/perf/util/mmap.h      |  3 +++
>>  5 files changed, 42 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 22ebeb92ac51..a35675e9f3aa 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -53,6 +53,7 @@
>>  #include <sys/mman.h>
>>  #include <sys/wait.h>
>>  #include <linux/time64.h>
>> +#include <aio.h>
>>  
>>  struct switch_output {
>>  	bool		 enabled;
>> @@ -121,6 +122,23 @@ static int record__write(struct record *rec, void *bf, size_t size)
>>  	return 0;
>>  }
>>  
>> +static int record__aio_write(int trace_fd, struct aiocb *cblock,
>> +		void *buf, size_t size, off_t off)
>> +{
> 
> this breaks bisection:
> 
> builtin-record.c:125:12: error: ‘record__aio_write’ defined but not used [-Werror=unused-function]
>  static int record__aio_write(int trace_fd, struct aiocb *cblock,

Moving it to [PATCH v3 2/2]. Thanks!

> 
> jirka
> 
