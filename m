From: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH v2 5/7] perf script python: add Python3 support to
 intel-pt-events.py
Date: Tue, 5 Mar 2019 07:02:34 -0800
Message-ID: <dfa719d4-0d9e-ad08-536f-17b3da116b19@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-6-tonyj@suse.de>
 <6fe06c75-5f98-4829-e139-af2bfcda24f3@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6fe06c75-5f98-4829-e139-af2bfcda24f3@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 3/5/19 2:16 AM, Adrian Hunter wrote:
> On 2/03/19 3:19 AM, Tony Jones wrote:
>> Support both Python2 and Python3 in the intel-pt-events.py script
>>
>> There may be differences in the ordering of output lines due to
>> differences in dictionary ordering etc.  However the format within lines
>> should be unchanged.
>>
>> The use of 'from __future__' implies the minimum supported Python2 version
>> is now v2.6
>>
>> Signed-off-by: Tony Jones <tonyj@suse.de>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
> 
> One change missed, see below, otherwise:

I tested the patch on a Skylake system but it was not connected to our standard
network so I had to move files manually.  It seems I managed to somehow mess up
and not attach the correct patch :(
>>  def trace_unhandled(event_name, context, event_fields_dict):
>>  		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
> 
> Also above line

You are correct.  Apologies. I'll send a revised version.

tony
