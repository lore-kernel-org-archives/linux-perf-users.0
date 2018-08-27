From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
Date: Mon, 27 Aug 2018 12:45:38 +0300
Message-ID: <2c525930-fbfd-2ea7-0b80-b67eff9b44cf@linux.intel.com>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
 <20180827084333.GG24695@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827084333.GG24695@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi,

On 27.08.2018 11:43, Jiri Olsa wrote:
> On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
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
>> +	struct timespec timeoutS = { 0, 1000 * 1000  * 1 };
>> +
>> +	if (!cblocks_size)
>> +		return 0;
>> +
>> +	do {
>> +		do_suspend = 0;
>> +		nanosleep(&timeoutS, NULL);
>> +		if (aio_suspend((const struct aiocb**)cblocks, cblocks_size, &timeout0)) {
>> +			if (errno == EAGAIN || errno == EINTR) {
>> +				do_suspend = 1;
>> +				continue;
>> +			} else {
>> +				pr_err("failed to sync perf data, error: %m\n");
>> +				break;
>> +			}
>> +		}
>> +		for (i = 0; i < cblocks_size; i++) {
> 
> it looks like we could set up the async write to receive the signal
> with the user pointer (sigev_value.sival_ptr), which would allow us
> to get the finished descriptor right away and we wouldn't need
> to iterate all of them and checking on them

Yep. This mechanism is provided by AIO API, but we still need this kind of 
synchronizing barrier to avoid memory races on mmap->data buffer between 
calls of the loop in record__mmap_read_evlist().

> 
> jirka
>> +			if (cblocks[i] == NULL) {
>> +				continue;
>> +			}
>> +			aio_errno = aio_error(cblocks[i]);
>> +			if (aio_errno == EINPROGRESS) {
>> +				do_suspend = 1;
>> +				continue;
>> +			}
> 
> SNIP
> 
