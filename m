From: Martin Vuille <jpmv27@aim.com>
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
Date: Thu, 26 Apr 2018 11:26:15 -0400
Message-ID: <57ea75b8-cebd-0ca2-0e4e-acf2beb6e981@aim.com>
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
> was different. With you patch it changed from /usr/lib64/libc.so (old) to
> /usr/lib/debug/lib64/libc-2.26.so.debug (new)
>
Thomas,

Can you tell me what 'file' reports for the old and new files?

Regards,
MV
