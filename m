From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
Date: Thu, 26 Apr 2018 10:09:00 +0200
Message-ID: <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
 <20180412131012.GC9818@kernel.org>
 <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Vuille <jpmv27@aim.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 04/25/2018 04:19 PM, Martin Vuille wrote:
> Apologies for any problems my patch may be causing.
> 
> I'm unclear on what is the proposed fix, other than reverting the commit.
> 
> In the problem scenario, is a --symfs option used? Is the debug info being obtained from the symfs directory?
> 
> Unfortunately, I've had to change my focus for the time being, so won't be able to investigate further for a while.
> 
> Arnaldo, I'm fine with you reverting this change for now.
> 
> Regards,
> 
> MV
> 
> 

Martin,

there is no need to revert the patch. I have adopted the test case for s390 and it
now stops at main, which is identical to x86.

The --symfs option was not used, however the debug file selected for dwarf examination
was different. With you patch it changed from /usr/lib64/libc.so (old) to
/usr/lib/debug/lib64/libc-2.26.so.debug (new)
and I think that this file has not all the info (at least on s390).

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
