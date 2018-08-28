From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/2]: perf util: map data buffer for preserving
 collected data
Date: Tue, 28 Aug 2018 12:19:06 +0300
Message-ID: <48431c29-5642-c282-a760-c2dd99db8049@linux.intel.com>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <e5591d27-5386-1d41-b09b-421316f75d07@linux.intel.com>
 <20180827083303.GD24695@krava>
 <2284a8e8-d90e-bd99-89c1-0b125ba2e205@linux.intel.com>
 <20180828084522.GD23727@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828084522.GD23727@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi,

On 28.08.2018 11:45, Jiri Olsa wrote:
> On Mon, Aug 27, 2018 at 12:02:35PM +0300, Alexey Budankov wrote:
>> Hi,
>>
>> On 27.08.2018 11:33, Jiri Olsa wrote:
>>> On Thu, Aug 23, 2018 at 07:42:09PM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>>>> index fc832676a798..e71d46cb01cc 100644
>>>> --- a/tools/perf/util/mmap.c
>>>> +++ b/tools/perf/util/mmap.c
>>>> @@ -155,6 +155,10 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>>>>  
>>>>  void perf_mmap__munmap(struct perf_mmap *map)
>>>>  {
>>>> +	if (map->data != NULL) {
>>>> +		munmap(map->data, perf_mmap__mmap_len(map));
>>>> +		map->data = NULL;
>>>> +	}
>>>>  	if (map->base != NULL) {
>>>>  		munmap(map->base, perf_mmap__mmap_len(map));
>>>>  		map->base = NULL;
>>>> @@ -190,6 +194,14 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>>>>  		map->base = NULL;
>>>>  		return -1;
>>>>  	}
>>>> +	map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ | PROT_WRITE,
>>>> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>
>>> hum, why does map->data need to be mmap-ed?
>>
>> The same way as for kernel buffers. If you see better alternatives it could be applied.
> 
> I meant why not just allocate them with mmaloc?

Yep. Using malloc()/free() makes the implementation shorter. Included into [PATCH v4 1/2].

> 
> jirka
> 
