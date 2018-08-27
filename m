From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
Date: Mon, 27 Aug 2018 12:33:07 +0300
Message-ID: <a34aa784-e36c-02fd-3e9d-7df4bc61ffe2@linux.intel.com>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
 <20180827083852.GF24695@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827083852.GF24695@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi,

On 27.08.2018 11:38, Jiri Olsa wrote:
> On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
>>  				    bool overwrite)
>>  {
>>  	u64 bytes_written = rec->bytes_written;
>> -	int i;
>> -	int rc = 0;
>> +	int i, rc = 0;
>>  	struct perf_mmap *maps;
>> +	int trace_fd = rec->session->data->file.fd;
>> +	struct aiocb **mmap_aio = rec->evlist->mmap_aio;
>> +	int mmap_aio_size = 0;
>> +	off_t off;
>>  
>>  	if (!evlist)
>>  		return 0;
>> @@ -546,14 +620,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>>  		return 0;
>>  
>> +	off = lseek(trace_fd, 0, SEEK_CUR);
>> +
> 
> with async write, do we need to query/set the offset like this
> all the time?

It looks like we need it this way. Internally glibc AIO implements writes 
using pwrite64 syscall in our case. The sycall requires offset as a parameter 
and doesn't update file position on the completion.

> 
> could we just keep/update the offset value in the 'struct perf_data_file'
> and skip both lseek calls?

Don't see how it is possible. offset is different for every enqeued write 
operation and write areas don't intersect for the whole writing loop. 
To know the final file position it is required to iterate thru 
the loop.

> 
> jirka
> 
> SNIP
> 
>>  
>> +	record__mmap_read_sync(trace_fd, mmap_aio, mmap_aio_size, rec);
>> +
>> +	lseek(trace_fd, off, SEEK_SET);
>> +
> 
