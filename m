From: Al Grant <al.grant@foss.arm.com>
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Date: Wed, 26 Aug 2020 15:33:35 +0100
Message-ID: <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200826142631.GA5351@redhat.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 26/08/2020 15:26, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
>> On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
>>> perf_event.h has macros that define the field offsets in the
>>> data_src bitmask in perf records. The SNOOPX and REMOTE offsets
>>> were both 37. These are distinct fields, and the bitfield layout
>>> in perf_mem_data_src confirms that SNOOPX should be at offset 38.
>>
>> Looks good.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>
>> Probably should have a Fixes: header
> 
> Please do so, find the patch that introduced the error, add the Fixes
> tag, will help me not having to do it myself :-)

Fixes: 52839e653b562 ("perf tools: Add support for printing new mem_info 
encodings")
