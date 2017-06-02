From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf: fix perf test case 14 result reporting
Date: Fri, 2 Jun 2017 11:58:46 +0200
Message-ID: <c06b8134-4636-c14f-c580-8b45e5256093@linux.vnet.ibm.com>
References: <20170601123441.24581-1-tmricht@linux.vnet.ibm.com>
 <20170601132038.GG2899@kernel.org> <20170601210451.GA5713@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53295 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750910AbdFBJ6w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jun 2017 05:58:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v529s9Tx162298
        for <linux-perf-users@vger.kernel.org>; Fri, 2 Jun 2017 05:58:51 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2au50baagw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jun 2017 05:58:50 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 2 Jun 2017 10:58:49 +0100
In-Reply-To: <20170601210451.GA5713@krava>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux390-list@tuxmaker.boeblingen.de.ibm.com

On 06/01/2017 11:04 PM, Jiri Olsa wrote:
> On Thu, Jun 01, 2017 at 10:20:38AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Jun 01, 2017 at 02:34:41PM +0200, Thomas Richter escreveu:
>>> Command perf test -v 14 (Setup struct perf_event_attr test)
>>> always reports success even if the test case fails.
>>> It works correctly if you also specify -F (for don't fork).
>>
>> Thanks for working on this, adding Jiri Olsa, that wrote this test
>> harness, so that he can check and provide his Acked-by or Reviewed-by,
>> Jiri?
>>
>> - Arnaldo
>>  
>>>    root@s35lp76 perf]# ./perf test -v 14
>>>    14: Setup struct perf_event_attr               :
>>>    --- start ---
>>>    running './tests/attr/test-record-no-delay'
>>>    [ perf record: Woken up 1 times to write data ]
>>>    [ perf record: Captured and wrote 0.002 MB /tmp/tmp4E1h7R/perf.data
>>>      (1 samples) ]
>>>    expected task=0, got 1
>>>    expected precise_ip=0, got 3
>>>    expected wakeup_events=1, got 0
>>>    FAILED './tests/attr/test-record-no-delay' - match failure
>>>    test child finished with 0
>>>    ---- end ----
>>>    Setup struct perf_event_attr: Ok
>>>
>>> The reason for the wrong error reporting is the return value of the
>>> system() library call. It is called in run_dir() file tests/attr.c
>>> and returns the exit status, in above case 0xff00.
>>> This value is given as parameter to the exit() function which
>>> can only handle values 0-0xff.
>>> The child process terminates with exit value of 0 and the parent
>>> does not detect any error.
>>>
>>> This patch corrects the error reporting and prints the
>>> correct test result.
>>>
>>> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
>>> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>>> ---
>>>  tools/perf/tests/attr.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
>>> index 88dc51f..131b510 100644
>>> --- a/tools/perf/tests/attr.c
>>> +++ b/tools/perf/tests/attr.c
>>> @@ -150,7 +150,7 @@ static int run_dir(const char *d, const char *perf)
>>>  	snprintf(cmd, 3*PATH_MAX, PYTHON " %s/attr.py -d %s/attr/ -p %s %.*s",
>>>  		 d, d, perf, vcnt, v);
>>>  
>>> -	return system(cmd);
>>> +	return system(cmd) ? TEST_FAIL : TEST_OK;
>>>  }
>>>  
>>>  int test__attr(int subtest __maybe_unused)
>>> -- 
>>> 2.9.3
> 
> seems ok, however "perf test attr" is broken ATM, since it wasn't updated
> for some time as it showed false 'Ok'
> 
> I started fixing it some time ago, but got distracted, if you are
> interested, you're welcome to pick up from my branch ;-)
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/attr_test
> 
> thanks,
> jirka
> 

I have started work on perf tool very recently to get s390 support
working and up to date.

I downloaded your branch and discovered you have already fixed
another issue I run into this week. For example 
commit 070b9644981e ("perf tests attr: Do not store failed events")

I can certainly help you to get this test case operational again.
Maybe you need to pull some of your patches out of your backlog
and submit them the kernel to get to a common base to work on.

I suggest we should move the discussion to the linux-perf-users
mailing list.

Your thoughts?

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
