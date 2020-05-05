From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 5/5] powerpc/hv-24x7: Update post_mobility_fixup() to handle migration
Date: Tue, 05 May 2020 17:05:52 +1000
Message-ID: <874ksueu9b.fsf@mpe.ellerman.id.au>
References: <20200327063642.26175-1-kjain@linux.ibm.com> <20200327063642.26175-6-kjain@linux.ibm.com> <877dxyfrpz.fsf@mpe.ellerman.id.au> <9586f8ef-1f3e-d45c-e0dc-665889a4f190@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9586f8ef-1f3e-d45c-e0dc-665889a4f190@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kajoljain <kjain@linux.ibm.com>, acme@kernel.org, linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

kajoljain <kjain@linux.ibm.com> writes:
> On 4/29/20 5:07 PM, Michael Ellerman wrote:
>> Kajol Jain <kjain@linux.ibm.com> writes:
>>> Function 'read_sys_info_pseries()' is added to get system parameter
>>> values like number of sockets and chips per socket.
>>> and it gets these details via rtas_call with token
>>> "PROCESSOR_MODULE_INFO".
>>>
>>> Incase lpar migrate from one system to another, system
>>> parameter details like chips per sockets or number of sockets might
>>> change. So, it needs to be re-initialized otherwise, these values
>>> corresponds to previous system values.
>>> This patch adds a call to 'read_sys_info_pseries()' from
>>> 'post-mobility_fixup()' to re-init the physsockets and physchips values.
>>>
>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/mobility.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>>> index b571285f6c14..226accd6218b 100644
>>> --- a/arch/powerpc/platforms/pseries/mobility.c
>>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>>> @@ -371,6 +371,18 @@ void post_mobility_fixup(void)
>>>  	/* Possibly switch to a new RFI flush type */
>>>  	pseries_setup_rfi_flush();
>>>  
>>> +	/*
>>> +	 * Incase lpar migrate from one system to another, system
>> 
>> In case an LPAR migrates
>> 
>>> +	 * parameter details like chips per sockets and number of sockets
>>> +	 * might change. So, it needs to be re-initialized otherwise these
>>                              ^                                       ^
>>                              they need                               the
>>> +	 * values corresponds to previous system.
>>                   ^
>>                   will correspond to the
>> 
>>> +	 * Here, adding a call to read_sys_info_pseries() declared in
>> 
>> Adding is the wrong tense in a comment. When someone reads the comment
>> the code has already been added. Past tense would be right, but really
>> the comment shouldn't say what you did, it should say why.
>> 
>>> +	 * platforms/pseries/pseries.h to re-init the physsockets and
>>> +	 * physchips value.
>> 
>> Call read_sys_info_pseries() to reinitialise the values.
>> 
>>> +	 */
>>> +	if (IS_ENABLED(CONFIG_HV_PERF_CTRS) && IS_ENABLED(CONFIG_PPC_RTAS))
>>> +		read_sys_info_pseries();
>> 
>> The RTAS check is not needed. pseries always selects RTAS.
>> 
>> You shouldn't need the IS_ENABLED() check here though, do it with an
>> empty version in the header when CONFIG_HV_PERF_CTRS is not enabled.
>> 
>
> Hi Michael,
> 	Thanks for reviewing the patch. Is something like this you are suggesting. Please
> let me know if my understanding is fine.
>
> +#ifndef CONFIG_HV_PERF_CTRS
> +#define read_sys_info_pseries() 
> +#endif

It should be an empty static inline. So more like:

#ifdef CONFIG_HV_PERF_CTRS
void read_sys_info_pseries(void);
#else
static inline void read_sys_info_pseries(void) { }
#endif

cheers
