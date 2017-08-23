From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Filter option should follow a tracer option
Date: Wed, 23 Aug 2017 13:33:40 +0300
Message-ID: <de75121e-cafc-0389-039b-fb038e0ff7c6@intel.com>
References: <2141818167.39420.1503049431846@office.mailbox.org>
 <20170822190011.GA31893@kernel.org>
 <a214874a-a271-729e-d253-731e648a10e6@intel.com>
 <98754540.17249.1503478275998@office.mailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21589 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753691AbdHWKkK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2017 06:40:10 -0400
In-Reply-To: <98754540.17249.1503478275998@office.mailbox.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jack Henschel <jackdev@mailbox.org>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

On 23/08/17 11:51, Jack Henschel wrote:
>> Adrian Hunter <adrian.hunter@intel.com> hat am 23. August 2017 um 08:06 geschrieben:
>>
>>
>> On 22/08/17 22:00, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Aug 18, 2017 at 11:43:51AM +0200, Jack Henschel escreveu:
>>>> Hi everyone,
>>>>
>>>> I'm experimenting with Intel PT and perf, but I am currently stuck at getting filters to work with `perf record`.
>>>>
>>>> I have the following command:
>>>>> perf record -e intel_pt// --filter 'filter main @ /bin/sleep' /bin/sleep 1
>>>> But it throws this error message:
>>>>> --filter option should follow a -e tracepoint or HW tracer option
>>>>
>>>> Maybe this is a trivial mistake, but I don't understand the error, because as far as I'm concerned the --filter options *is* following a -e HW tracer option.
>>>>
>>>> I'm using perf version 4.9.30 with kernel 4.9.30-2+deb9u3 on Debian 9 Stretch.
>>
>> It looks like either your CPU does not support Intel PT at all, or it does not support address filtering.
> 
> My CPU (Xeon CPU E5-2680 v4) supports Intel PT (intel_pt flag is present in /proc/cpuinfo), but this is not an issue with Intel PT. Here are some more examples (with various syntaxes):

I think that is Broadwell which doesn't have address filtering.

> 
>> $ perf list | grep -E 'intel_pt|branch-loads|cache-misses'
>>  cache-misses                                       [Hardware event]
>>  branch-loads                                       [Hardware cache event]
>>  cache-misses OR cpu/cache-misses/                  [Kernel PMU event]
>>  intel_pt//                                         [Kernel PMU event]
>> $ perf record --event intel_pt// --exclude-perf -a
>> --exclude-perf option should follow a -e tracepoint option
>> $ perf record --event=branch-loads --filter 'filter main @ /bin/sleep' -- /bin/sleep 1
>> --filter option should follow a -e tracepoint or HW tracer option
>> $ perf record -e cache-misses --filter 'filter main @ /bin/sleep' -- /bin/sleep 1
>> --filter option should follow a -e tracepoint or HW tracer option
> 
>> Have you checked the value of /sys/bus/event_source/devices/intel_pt/nr_addr_filters ?
> I don't have that file:

Which definitely means address filtering is not supported.  That is
mentioned in the man page for 'perf record'.
