From: Al Grant <al.grant@foss.arm.com>
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Date: Tue, 1 Sep 2020 16:05:50 +0100
Message-ID: <67062e1a-98b1-1f0d-d405-2c0dc2ce655a@foss.arm.com>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
 <20200901150225.GA1424523@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200901150225.GA1424523@kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org



On 01/09/2020 16:02, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 26, 2020 at 03:33:35PM +0100, Al Grant escreveu:
>> On 26/08/2020 15:26, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
>>>> On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
>>>>> perf_event.h has macros that define the field offsets in the
>>>>> data_src bitmask in perf records. The SNOOPX and REMOTE offsets
>>>>> were both 37. These are distinct fields, and the bitfield layout
>>>>> in perf_mem_data_src confirms that SNOOPX should be at offset 38.
>>>>
>>>> Looks good.
>>>>
>>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>>>
>>>> Probably should have a Fixes: header
>>>
>>> Please do so, find the patch that introduced the error, add the Fixes
>>> tag, will help me not having to do it myself :-)
>>
>> Fixes: 52839e653b562 ("perf tools: Add support for printing new mem_info
>> encodings")
> 
> Ok, I'll add that, thanks.
>  > But you forgot to add your Signed-off-by:, can you please provide it?

Signed-off-by: Al Grant <al.grant@arm.com>

> There was also a minor problem in the patch, there was no separation of
> --- from the patch comment section to the patch itself, I'll fix that as
> well.

Thanks, will remember for next time.

Al
