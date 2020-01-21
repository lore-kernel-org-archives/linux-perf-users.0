From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC 5/6] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Tue, 21 Jan 2020 15:47:53 +0530
Message-ID: <b6e3ae17-ce41-2709-1a87-dcd9bd1f365a@linux.ibm.com>
References: <20200117124620.26094-1-kjain@linux.ibm.com>
 <20200117124620.26094-6-kjain@linux.ibm.com>
 <20200117162807.GL302770@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200117162807.GL302770@tassilo.jf.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org
List-Id: linux-perf-users.vger.kernel.org


On 1/17/20 9:58 PM, Andi Kleen wrote:
> On Fri, Jan 17, 2020 at 06:16:19PM +0530, Kajol Jain wrote:
>> Patch enhances current metric infrastructure to handle "?" in the metric
>> expression. The "?" can be use for parameters whose value not known while
>> creating metric events and which can be replace later at runtime to
>> the proper value. It also add flexibility to create multiple events out
>> of single metric event added in json file.
> Please add a proper specification how this ? thing is supposed to work,
> what the exact semantics are, how it is different from the existing
> # mechanism etc.
>
> The standard way to do similar things before was to define an explicit
> # name and let the expr code take care of it.

Hi Andi,

     Thanks for reviewing my patchset.

I did review the existing '#' mechanism. It is quiet useful for runtime
dependency (like ex. event selection based on a return value). But I want
to handle couple of more things. Meaning, filling in parameter of event code
based on runtime value and replicating events at runtime.

So the '?' can handle, 1) replacement of a value in the event code based 
on runtime

and 2) replicate the event (metric expr) at runtime (handled in new 
metricgroup__add_metric()).

This patchset add an arch specific function called 
'arch_get_runtimeparam'. Ideally,
arch_get_runtimeparm() returns the number of metric exps one want to 
create (it defaults to 1).
The loop added in 'metricgroup__add_metric' will handle the event addition.

Example ppc64 hv_24x7 pmu metric event using '?':

(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + 
hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@)

Here, '?' will be replaced with a runtime value and metric expression 
will be replicated.

Thanks,

Kajol

> -Andi
