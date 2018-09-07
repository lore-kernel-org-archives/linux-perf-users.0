From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 77/77] perf tests: Fix record+probe_libc_inet_pton.sh
 without ping's debuginfo
Date: Fri, 7 Sep 2018 14:09:13 +0200
Message-ID: <62359230-cfb2-676d-6baf-93282ee99afc@linux.ibm.com>
References: <20180905220440.20256-1-acme@kernel.org>
 <20180905220440.20256-78-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-78-acme@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Kim Phillips <kim.phillips@arm.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0>
List-Id: linux-perf-users.vger.kernel.org

On 09/06/2018 12:04 AM, Arnaldo Carvalho de Melo wrote:
> rpm -e iputils-debuginfo

I have done the same on my s390 this morning:

[root@p23lp27 perf]# ./perf test ping
60: probe libc's inet_pton & backtrace it with ping       : Ok
[root@p23lp27 perf]# rpm -e iputils-debuginfo
[root@p23lp27 perf]# ./perf test ping
60: probe libc's inet_pton & backtrace it with ping       : Ok
[root@p23lp27 perf]#

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
