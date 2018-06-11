From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test: Test 6 dumps core on s390
Date: Mon, 11 Jun 2018 09:00:53 +0200
Message-ID: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
References: <20180608131728.75084-1-tmricht@linux.ibm.com>
 <20180608095318.2ba14669fdc5da2004285bcf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608095318.2ba14669fdc5da2004285bcf@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@arm.com>, Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 06/08/2018 04:53 PM, Kim Phillips wrote:
> On Fri, 8 Jun 2018 15:17:28 +0200
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
>> Perf test case 6 "Parse event definition strings"
>> dumps core when executed on s390.
> 
> I reported it actually fails on any $ARCH system without
> Intel Processor Trace (PT) h/w:
> 
> https://www.spinics.net/lists/linux-perf-users/msg06020.html
> 
> There was a follow-up patch sent here:
> 
> https://www.spinics.net/lists/linux-perf-users/msg06029.html
> 
> which worked for me, but I don't know what has/has-not transpired
> since, other than it is still broken, as you found.
> 
> Kim


Looks like this is still broken. I also can not find this patch on
git clone -b perf/core git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux

We actually need 2 patches
- one to fix the core dump
- one to test for x86 platform


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
