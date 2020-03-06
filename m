From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v3 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Fri, 6 Mar 2020 10:22:27 +0530
Message-ID: <d15a8aa6-e2d5-3edf-699a-8eda0862fd9b@linux.ibm.com>
References: <20200229094159.25573-1-kjain@linux.ibm.com>
 <20200229094159.25573-7-kjain@linux.ibm.com> <20200302150819.GA259142@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200302150819.GA259142@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org



On 3/2/20 8:38 PM, Jiri Olsa wrote:
> On Sat, Feb 29, 2020 at 03:11:57PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>>  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
>>  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
>>  
>> +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/"
>> +
>>  int
>>  get_cpuid(char *buffer, size_t sz)
>>  {
>> @@ -44,3 +51,43 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>>  
>>  	return bufp;
>>  }
>> +
>> +int arch_get_runtimeparam(void)
>> +{
>> +	int count = 0;
>> +	DIR *dir;
>> +	char path[PATH_MAX];
>> +	const char *sysfs = sysfs__mountpoint();
>> +	char filename[] = "sockets";
>> +	FILE *file;
>> +	char buf[16], *num;
>> +	int data;
>> +
>> +	if (!sysfs)
>> +		goto out;
>> +
>> +	snprintf(path, PATH_MAX,
>> +		 "%s" SOCKETS_INFO_FILE_PATH, sysfs);
>> +	dir = opendir(path);
>> +
>> +	if (!dir)
>> +		goto out;
>> +
>> +	strcat(path, filename);
>> +	file = fopen(path, "r");
>> +
>> +	if (!file)
>> +		goto out;
>> +
>> +	data = fread(buf, 1, sizeof(buf), file);
>> +
>> +	if (data == 0)
>> +		goto out;
>> +
>> +	count = strtol(buf, &num, 10);
>> +out:
>> +	if (!count)
>> +		count = 1;
>> +
>> +	return count;
> 
> we have sysfs__read_ull for this
> 

Hi Jiri,
    Thanks for suggesting it. Will update.

Kajol

> jirka
> 
