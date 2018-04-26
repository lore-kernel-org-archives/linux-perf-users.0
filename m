From: Martin Vuille <jpmv27@aim.com>
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
Date: Thu, 26 Apr 2018 09:57:08 -0400
Message-ID: <daaa4338-0e78-d11c-8699-5b432db6993e@aim.com>
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
 <20180412131012.GC9818@kernel.org>
 <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
 <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 04/26/18 04:09, Thomas-Mich Richter wrote:
>
> Martin,
>
> there is no need to revert the patch. I have adopted the test case for s390 and it
> now stops at main, which is identical to x86.
>
> The --symfs option was not used, however the debug file selected for dwarf examination
> was different. With you patch it changed from /usr/lib64/libc.so (old) to
> /usr/lib/debug/lib64/libc-2.26.so.debug (new)
> and I think that this file has not all the info (at least on s390).
>
Thomas,

Thanks for the additional information. My change was intended to only affect
the case where a --symfs option is used, so your finding is surprising.

I'll take a look to see why this is happening.

Regards,
MV
