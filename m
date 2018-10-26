From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH 11/11] perf tools: Stop fallbacking to kallsyms for vdso symbols lookup
Date: Fri, 26 Oct 2018 16:19:52 -0700
Message-ID: <87a7n070tj.fsf@intel.com>
References: <20181017225501.32150-1-acme@kernel.org> <20181017225501.32150-12-acme@kernel.org> <4c682937-3cee-6974-0970-68610e13ad37@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c682937-3cee-6974-0970-68610e13ad37@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Hi,

Adrian Hunter <adrian.hunter@intel.com> writes:

> On 18/10/18 1:55 AM, Arnaldo Carvalho de Melo wrote:
>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> 
>> David reports that:
>> 
>> <quote>
>> Perf has this hack where it uses the kernel symbol map as a backup when
>> a symbol can't be found in the user's symbol table(s).
>
> I don't think this is a complete fix because it exposes new problems.

This commit broke function name resolution for 'perf record -g' for me.

What I mean is, with this commit applied:

$ ./tools/perf/perf record -g -- sleep 1

$ ./tools/perf/perf report

'perf report' doesn't seem to be able to show the function names of the
trace.

If I revert this commit, function names are resolved fine.


> This code caters for branches from kernel space to user space and vice
> versa. That is, since there is only one cpumode so it is certain to be
> wrong for either 'ip' or 'addr' when they are not both in the kernel
> or both in userspace.
>
>> 
>> 
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: David Ahern <dsahern@gmail.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Wang Nan <wangnan0@huawei.com>
>> Link: https://lkml.kernel.org/n/tip-cs7skq9pp0kjypiju6o7trse@git.kernel.org
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> ---
>>  tools/perf/util/event.c | 21 ++-------------------
>>  1 file changed, 2 insertions(+), 19 deletions(-)
>> 
>> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>> index 0988eb3b844b..bc646185f8d9 100644
>> --- a/tools/perf/util/event.c
>> +++ b/tools/perf/util/event.c
>> @@ -1561,26 +1561,9 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>>  
>>  		return NULL;
>>  	}
>> -try_again:
>> +
>>  	al->map = map_groups__find(mg, al->addr);
>> -	if (al->map == NULL) {
>> -		/*
>> -		 * If this is outside of all known maps, and is a negative
>> -		 * address, try to look it up in the kernel dso, as it might be
>> -		 * a vsyscall or vdso (which executes in user-mode).
>> -		 *
>> -		 * XXX This is nasty, we should have a symbol list in the
>> -		 * "[vdso]" dso, but for now lets use the old trick of looking
>> -		 * in the whole kernel symbol list.
>> -		 */
>> -		if (cpumode == PERF_RECORD_MISC_USER && machine &&
>> -		    mg != &machine->kmaps &&
>> -		    machine__kernel_ip(machine, al->addr)) {
>> -			mg = &machine->kmaps;
>> -			load_map = true;
>> -			goto try_again;
>> -		}
>> -	} else {
>> +	if (al->map != NULL) {
>>  		/*
>>  		 * Kernel maps might be changed when loading symbols so loading
>>  		 * must be done prior to using kernel maps.
>> 


--
Vinicius
