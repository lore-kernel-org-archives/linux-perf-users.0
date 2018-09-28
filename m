From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH v2] perf test: S390 does not support watchpoints in test
 22
Date: Fri, 28 Sep 2018 12:52:43 +0200
Message-ID: <c7b16721-0792-1f13-85fc-49d689b1ea2c@linux.ibm.com>
References: <20180928074317.42893-1-tmricht@linux.ibm.com>
 <b743ec89-9e54-e54d-86cc-f3312e06e23c@linux.ibm.com>
 <491ce3c5-f1ce-1513-3a9f-b86795e0332a@linux.ibm.com>
 <7a99b293-fd3d-db4a-fc4b-d552e2458fb9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a99b293-fd3d-db4a-fc4b-d552e2458fb9@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 09/28/2018 12:17 PM, Ravi Bangoria wrote:
> Hi Thomas,
> 
> On 09/28/2018 03:32 PM, Thomas-Mich Richter wrote:
>> I can rework the patch to use the is_supported() member function. The
>> down side is that the test does not show up in the list of executed tests anymore,
>> unless some debug output is enabled:
> 
> Which should be fine because s390 is doing that in all breakpoint related tests.
> But more important thing to suggest .is_supported field is, this patch has a
> regression on x86:
> 
> Before:
>   $ sudo ./perf test 22
>   22: Watchpoint                                            :
>   22.1: Read Only Watchpoint                                : Skip
>   22.2: Write Only Watchpoint                               : Ok
>   22.3: Read / Write Watchpoint                             : Ok
>   22.4: Modify Watchpoint                                   : Ok
> 
> After:
>   $ git apply 1.patch
>   $ make
>   $ sudo ./perf test 22
>   22: Watchpoint                                            :
>   22.1: Read Only Watchpoint                                : Skip
>   22.2: Write Only Watchpoint                               : Skip
>   22.3: Read / Write Watchpoint                             : Skip
>   22.4: Modify Watchpoint                                   : Skip
> 
> Intel hw does not support read only watchpoitns. If you use skip_if_fail=true,
> all subsequent testcases are skipped as well.
> 
> Thanks,
> Ravi
> 

Ahhh  ....  thanks a lot for the hint, will post version 3.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
