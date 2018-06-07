From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 42/46] perf script powerpc: Python script for hypervisor
 call statistics
Date: Thu, 7 Jun 2018 11:04:17 +0530
Message-ID: <5856a13c-7a34-f4f4-d5f2-100f626a213f@linux.ibm.com>
References: <20180605175030.32549-1-acme@kernel.org>
 <20180605175030.32549-43-acme@kernel.org>
 <c58ba06a-2a1b-a981-b9a5-27708ea2479a@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c58ba06a-2a1b-a981-b9a5-27708ea2479a@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Paul,

On 06/06/2018 08:23 PM, Paul Clarke wrote:
> On 06/05/2018 12:50 PM, Arnaldo Carvalho de Melo wrote:
>> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>
>> Add python script to show hypervisor call statistics. Ex,
>>
>>   # perf record -a -e "{powerpc:hcall_entry,powerpc:hcall_exit}"
>>   # perf script -s scripts/python/powerpc-hcalls.py
>>     hcall                            count   min(ns)   max(ns)   avg(ns)
>>     --------------------------------------------------------------------
>>     H_RANDOM                            82       838      1164       904
>>     H_PUT_TCE                           47      1078      5928      2003
>>     H_EOI                              266      1336      3546      1654
>>     H_ENTER                             28      1646      4038      1952
>>     H_PUT_TCE_INDIRECT                 230      2166     18168      6109
>>     H_IPI                              238      1072      3232      1688
>>     H_SEND_LOGICAL_LAN                  42      5488     21366      7694
>>     H_STUFF_TCE                        294       986      6210      3591
>>     H_XIRR                             266      2286      6990      3783
>>     H_PROTECT                           10      2196      3556      2555
>>     H_VIO_SIGNAL                       294      1028      2784      1311
>>     H_ADD_LOGICAL_LAN_BUFFER            53      1978      3450      2600
>>     H_SEND_CRQ                          77      1762      7240      2447
> 
> This translation from HCALL code to mnemonic is more generally useful.  Is there a good way to make the "hcall_table_lookup" function more generally available, like "syscall_name" in scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py ?  It's even simpler than the syscall ID-to-name mapping, because the HCALL codes are constant, unlike syscall IDs which vary between arches.
> 

Right, but I don't see any other python script for hcalls. So, I thought
to add it in the script itself. Let me know if you are planning to add
any :) We will move it in a generic module.

Ravi
