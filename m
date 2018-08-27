From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 2/2]: perf record: enable asynchronous trace writing
Date: Mon, 27 Aug 2018 12:20:50 +0300
Message-ID: <3a8286ff-124f-fb56-1d1c-5d5e1f3b8512@linux.intel.com>
References: <dcd3ee88-57d6-8704-f5e1-7a3c75a17d8d@linux.intel.com>
 <2db359cc-dc5d-c00e-a42a-12a2e9da80b7@linux.intel.com>
 <20180826214856.GA24518@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180826214856.GA24518@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi,

On 27.08.2018 0:48, Jiri Olsa wrote:
> On Tue, Aug 21, 2018 at 11:27:03AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> -static int record__pushfn(void *to, void *bf, size_t size)
>> +static int record__pushfn(void *to, void *bf, size_t size, off_t off)
>>  {
>>  	struct record *rec = to;
>> +	struct perf_mmap *map = bf;
>>  
>>  	rec->samples++;
>> -	return record__write(rec, bf, size);
>> +	return record__aio_write(rec->session->data->file.fd, &map->cblock,
>> +			map->data, size, off);
>>  }
>>  
>>  static volatile int done;
>> @@ -528,13 +530,85 @@ static struct perf_event_header finished_round_event = {
>>  	.type = PERF_RECORD_FINISHED_ROUND,
>>  };
>>  
>> +static int record__mmap_read_sync(int trace_fd, struct aiocb **cblocks,
>> +		int cblocks_size, struct record *rec)
>> +{
>> +	size_t rem;
>> +	ssize_t size;
>> +	off_t rem_off;
>> +	int i, aio_ret, aio_errno, do_suspend;
>> +	struct perf_mmap *md;
>> +	struct timespec timeout0 = { 0, 0 };
>> +	struct timespec timeoutS = { 0, 1000 * 500  * 1 };
>> +
>> +	if (!cblocks_size)
>> +		return 0;
>> +
>> +	do {
>> +		do_suspend = 0;
>> +		nanosleep(&timeoutS, NULL);
> 
> why the extra sleep in here and not sleeping through aio_suspend call?

Yep. Good question. That requires explicit explanation:

+               /* aio_suspend() implementation inside glibc (as of v2.27) is
+                * intrusive and not just blocks waiting io requests completion
+                * but polls requests queue inducing context switches in perf
+                * tool process. When profiling in system wide mode with tracing
+                * context switches the trace may be polluted by context switches
+                * from the perf process and the trace size becomes about 3-5
+                * times bigger than that of when writing the trace serially.
+                * To limit the volume of context switches from perf tool
+                * process nonsleep() call limits aio_suspend()
+                * polling till every half of the kernel timer tick which is
+                * usually 1ms (depends on CONFIG_HZ value).
+                */

> 
> jirka
> 
>> +		if (aio_suspend((const struct aiocb**)cblocks, cblocks_size, &timeout0)) {
>> +			if (errno == EAGAIN || errno == EINTR) {
>> +				do_suspend = 1;
>> +				continue;
>> +			} else {
>> +				pr_err("failed to sync perf data, error: %m\n");
> 
> SNIP
> 
