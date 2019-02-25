From: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH 06/15] perf script python: add Python3 support to
 intel-pt-events.py
Date: Mon, 25 Feb 2019 09:18:20 -0800
Message-ID: <13778fda-031c-6aa7-d186-279271bb4f29@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-7-tonyj@suse.de>
 <1cc3561f-604f-6f01-147c-89deb07d3410@intel.com>
 <20190225140312.GD31136@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225140312.GD31136@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 2/25/19 6:03 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 25, 2019 at 09:07:03AM +0200, Adrian Hunter escreveu:
>> On 23/02/19 1:06 AM, Tony Jones wrote:
>>> Support both Python2 and Python3 in the intel-pt-events.py script
>>>
>>> There may be differences in the ordering of output lines due to
>>> differences in dictionary ordering etc.  However the format within lines
>>> should be unchanged.
>>>
>>> Fix space/tab inconsistency as python3 enforces consistency.
>>
>> It would be better for the white space changes to be a separate patch.
>>
>> But I am not in favour of using spaces instead of tabs because it is the
>> opposite of what we tend to do with C.
>>
>> Arnaldo, can you provide a guideline on this?
> 
> Yeah, please separate things, this would help me now to pick the
> uncontroversial part while we discuss the other.
> 
> And I'm in favour of being consistent with what we do for C code, i.e.
> use TABs.
> 
> I'm now processing the other patches.

I'll split and resubmit.

Also, FYI, PEP8 states "Spaces are the preferred indentation method".
