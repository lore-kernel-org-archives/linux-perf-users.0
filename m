From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v3] perf test: S390 does not support watchpoints in test
 22
Date: Fri, 28 Sep 2018 16:43:06 +0530
Message-ID: <f1ee3dc0-6b96-c7e5-f449-caabd3bf7f8a@linux.ibm.com>
References: <20180928105335.67179-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928105335.67179-1-tmricht@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 09/28/2018 04:23 PM, Thomas Richter wrote:
> S390 does not support the perf_event_open system call for
> attribute type PERF_TYPE_BREAKPOINT. This results in test
> failure for test 22:
> 
> [root@s8360046 perf]# ./perf test 22
> 22: Watchpoint                                :
> 22.1: Read Only Watchpoint                    : FAILED!
> 22.2: Write Only Watchpoint                   : FAILED!
> 22.3: Read / Write Watchpoint                 : FAILED!
> 22.4: Modify Watchpoint                       : FAILED!
> [root@s8360046 perf]#
> 
> Add s390 support to avoid these tests being executed on
> s390 platform:
> 
> [root@s8360046 perf]# ./perf test 22
> [root@s8360046 perf]# ./perf test -v 22
> 22: Watchpoint                                : Disabled
> [root@s8360046 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks,
Ravi
