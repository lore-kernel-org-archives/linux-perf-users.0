From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v7 2/5] powerpc/hv-24x7: Add rtas call in hv-24x7 driver
 to get processor details
Date: Wed, 6 May 2020 15:23:32 +0530
Message-ID: <0b9c9d6c-736e-4981-aa62-6d12e327eeda@linux.ibm.com>
References: <20200327063642.26175-1-kjain@linux.ibm.com>
 <20200327063642.26175-3-kjain@linux.ibm.com>
 <87ftcmfryt.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ftcmfryt.fsf@mpe.ellerman.id.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>, acme@kernel.org, linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org



On 4/29/20 5:01 PM, Michael Ellerman wrote:
> Hi Kajol,
> 
> Some comments inline ...
> 
> Kajol Jain <kjain@linux.ibm.com> writes:
>> For hv_24x7 socket/chip level events, specific chip-id to which
>> the data requested should be added as part of pmu events.
>> But number of chips/socket in the system details are not exposed.
>>
>> Patch implements read_sys_info_pseries() to get system
>> parameter values like number of sockets and chips per socket.
>> Rtas_call with token "PROCESSOR_MODULE_INFO"
>> is used to get these values.
>>
>> Sub-sequent patch exports these values via sysfs.
>>
>> Patch also make these parameters default to 1.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  arch/powerpc/perf/hv-24x7.c              | 72 ++++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/pseries.h |  3 +
>>  2 files changed, 75 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
>> index 48e8f4b17b91..9ae00f29bd21 100644
>> --- a/arch/powerpc/perf/hv-24x7.c
>> +++ b/arch/powerpc/perf/hv-24x7.c
>> @@ -20,6 +20,11 @@
>>  #include <asm/io.h>
>>  #include <linux/byteorder/generic.h>
>>  
>> +#ifdef CONFIG_PPC_RTAS
> 
> This driver can only be build on pseries, and pseries always selects
> RTAS. So the ifdef is unncessary.

Hi Michael,
	Thanks for review, I will remove this check.

> 
>> +#include <asm/rtas.h>
>> +#include <../../platforms/pseries/pseries.h>
>> +#endif
> 
> That's not really what the platform header is intended for.
> 
> You should put the extern in arch/powerpc/include/asm somewhere.
> 
> Maybe rtas.h
> 
>> @@ -57,6 +62,69 @@ static bool is_physical_domain(unsigned domain)
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_PPC_RTAS
> 
> Not needed.
> 
>> +#define PROCESSOR_MODULE_INFO   43
> 
> Please document where these come from, presumably LoPAPR somewhere?
> 

Sure, will add the details.

>> +#define PROCESSOR_MAX_LENGTH	(8 * 1024)
>> +
>> +static int strbe16toh(const char *buf, int offset)
>> +{
>> +	return (buf[offset] << 8) + buf[offset + 1];
>> +}
> 
> I'm confused by this. "str" implies string, a string is an array of
> bytes and has no endian. But then be16 implies it's an array of __be16,
> in which case buf should be a __be16 *.
> 

Yes right, actually I was following implementation in util-linux. But what you
suggested make more sense, will update accordingly.

>> +
>> +static u32		physsockets;	/* Physical sockets */
>> +static u32		physchips;	/* Physical chips */
> 
> No tabs there please.

Sure will update.

> 
>> +
>> +/*
>> + * Function read_sys_info_pseries() make a rtas_call which require
>> + * data buffer of size 8K. As standard 'rtas_data_buf' is of size
>> + * 4K, we are adding new local buffer 'rtas_local_data_buf'.
>> + */
>> +char rtas_local_data_buf[PROCESSOR_MAX_LENGTH] __cacheline_aligned;
> 
> static?
> 
>> +/*
>> + * read_sys_info_pseries()
>> + * Retrieve the number of sockets and chips per socket details
>> + * through the get-system-parameter rtas call.
>> + */
>> +void read_sys_info_pseries(void)
>> +{
>> +	int call_status, len, ntypes;
>> +
>> +	/*
>> +	 * Making system parameter: chips and sockets default to 1.
>> +	 */
>> +	physsockets = 1;
>> +	physchips = 1;
>> +	memset(rtas_local_data_buf, 0, PROCESSOR_MAX_LENGTH);
>> +	spin_lock(&rtas_data_buf_lock);
> 
> You're not using the rtas_data_buf, so why are you taking the
> rtas_data_buf_lock?

Sure, I will add new lock specific for rtas_local_data_buf

> 
>> +	call_status = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
>> +				NULL,
>> +				PROCESSOR_MODULE_INFO,
>> +				__pa(rtas_local_data_buf),
>> +				PROCESSOR_MAX_LENGTH);
>> +
>> +	spin_unlock(&rtas_data_buf_lock);
>> +
>> +	if (call_status != 0) {
>> +		pr_info("%s %s Error calling get-system-parameter (0x%x)\n",
>> +			__FILE__, __func__, call_status);
> 
> pr_err(), don't use __FILE__, this file already uses pr_fmt(). Not sure
> __func__ is really necessary either
> 
> 		return;
> 
> Then you can deindent the next block.
> 
>> +	} else {
>> +		rtas_local_data_buf[PROCESSOR_MAX_LENGTH - 1] = '\0';
>> +		len = strbe16toh(rtas_local_data_buf, 0);
> 
> Why isn't the buffer a __be16 array, and then you just use be16_to_cpu() ?
> 
>> +		if (len < 6)
>> +			return;
>> +
>> +		ntypes = strbe16toh(rtas_local_data_buf, 2);
>> +
>> +		if (!ntypes)
>> +			return;
> 
> What is ntype
ntype specify processor module type

> 
>> +		physsockets = strbe16toh(rtas_local_data_buf, 4);
>> +		physchips = strbe16toh(rtas_local_data_buf, 6);
>> +	}
>> +}
>> +#endif /* CONFIG_PPC_RTAS */
>> +
>>  /* Domains for which more than one result element are returned for each event. */
>>  static bool domain_needs_aggregation(unsigned int domain)
>>  {
>> @@ -1605,6 +1673,10 @@ static int hv_24x7_init(void)
>>  	if (r)
>>  		return r;
>>  
>> +#ifdef CONFIG_PPC_RTAS
>> +	read_sys_info_pseries();
>> +#endif
>

Will remove this config checks.

Thanks,
Kajol Jain

 
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
>> index 13fa370a87e4..1727559ce304 100644
>> --- a/arch/powerpc/platforms/pseries/pseries.h
>> +++ b/arch/powerpc/platforms/pseries/pseries.h
>> @@ -19,6 +19,9 @@ extern void request_event_sources_irqs(struct device_node *np,
>>  struct pt_regs;
>>  
>>  extern int pSeries_system_reset_exception(struct pt_regs *regs);
>> +#ifdef CONFIG_PPC_RTAS
>> +extern void read_sys_info_pseries(void);
>> +#endif
>>  extern int pSeries_machine_check_exception(struct pt_regs *regs);
>>  extern long pseries_machine_check_realmode(struct pt_regs *regs);
> > 
> cheers
> 
