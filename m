From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH v2] perf test: S390 does not support watchpoints in test
 22
Date: Fri, 28 Sep 2018 12:02:29 +0200
Message-ID: <491ce3c5-f1ce-1513-3a9f-b86795e0332a@linux.ibm.com>
References: <20180928074317.42893-1-tmricht@linux.ibm.com>
 <b743ec89-9e54-e54d-86cc-f3312e06e23c@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b743ec89-9e54-e54d-86cc-f3312e06e23c@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 09/28/2018 10:37 AM, Ravi Bangoria wrote:
> Hi Thomas,
> 
> On 09/28/2018 01:13 PM, Thomas Richter wrote:
>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
>> index 54ca7d87236f..e83c15a95c43 100644
>> --- a/tools/perf/tests/builtin-test.c
>> +++ b/tools/perf/tests/builtin-test.c
>> @@ -124,7 +124,7 @@ static struct test generic_tests[] = {
>>  		.desc = "Watchpoint",
>>  		.func = test__wp,
>>  		.subtest = {
>> -			.skip_if_fail	= false,
>> +			.skip_if_fail	= true,
> 
> Can you instead use ".is_supported"?
> 
> Thanks,
> Ravi
> 

Hi Ravi,

I can rework the patch to use the is_supported() member function. The
down side is that the test does not show up in the list of executed tests anymore,
unless some debug output is enabled:

[root@s8360046 perf]# ./perf test -F 22
[root@s8360046 perf]# ./perf test -Fv 22
22: Watchpoint                                            : Disabled
[root@s8360046 perf]#

I leave it to Arnaldo to decide...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
