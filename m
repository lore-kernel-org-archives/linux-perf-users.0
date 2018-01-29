From: weiping zhang <zwp10758@gmail.com>
Subject: Re: [RFC PATCH] perf cgroup: simplify arguments if track multiple
 events for a cgroup
Date: Mon, 29 Jan 2018 23:19:01 +0800
Message-ID: <CAA70yB7XD5N2UGBvHb1O5rT7jL6mVaGu_1AvTzWs9PWAd-VV1A@mail.gmail.com>
References: <20180128053143.GA13597@localhost.didichuxing.com> <20180129103926.GA20848@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180129103926.GA20848@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, namhyung@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

2018-01-29 18:39 GMT+08:00 Jiri Olsa <jolsa@redhat.com>:
> On Sun, Jan 28, 2018 at 01:31:48PM +0800, weiping zhang wrote:
>> if use -G with one cgroup and -e with multiple events, only the first
>> event has correct cgroup setting, all events from the second will track
>> system-wide events.
>>
>> if user want track multiple events for a specific cgroup, user must give
>> parameters like follow:
>> $ perf stat -e e1 -e e2 -e e3 -G test,test,test
>> this patch simplify this case, just type one cgroup, like following:
>> $ perf stat -e e1 -e e2 -e e3 -G test
>>
>> reproduce:
>> $ mkdir -p /sys/fs/cgroup/perf_event/test
>> $ perf stat -e cycles -e cache-misses  -a -I 1000 -G test
>>
>> before:
>>      1.001007226      <not counted>      cycles                    test
>>      1.001007226              7,506      cache-misses
>>
>> after:
>>      1.000834097      <not counted>      cycles                    test
>>      1.000834097      <not counted>      cache-misses              test
>>
>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>> ---
>>  tools/perf/util/cgroup.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> please update the -G option documentation
>
OK, I'll add that at V2.
>>
>> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
>> index d9ffc1e..38aaeb2 100644
>> --- a/tools/perf/util/cgroup.c
>> +++ b/tools/perf/util/cgroup.c
>> @@ -154,9 +154,11 @@ int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
>>                 int unset __maybe_unused)
>>  {
>>       struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
>> +     struct perf_evsel *counter;
>> +     struct cgroup_sel *cgrp = NULL;
>>       const char *p, *e, *eos = str + strlen(str);
>>       char *s;
>> -     int ret;
>> +     int ret, i;
>>
>>       if (list_empty(&evlist->entries)) {
>>               fprintf(stderr, "must define events before cgroups\n");
>> @@ -185,5 +187,18 @@ int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
>>                       break;
>>               str = p+1;
>>       }
>> +     /* for the case one cgroup combine to multiple events */
>> +     i = 0;
>> +     if (nr_cgroups == 1) {
>> +             evlist__for_each_entry(evlist, counter) {
>> +                     if (i == 0)
>> +                             cgrp = counter->cgrp;
>
> what if the only group is not defined for the first event? like  -G ,,krava
>
if there is a comma, the nr_cgrous will > 1, so it will keep original
behavior track system-wide events.
> thanks,
> jirka
