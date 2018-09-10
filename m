From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 77/77] perf tests: Fix record+probe_libc_inet_pton.sh
 without ping's debuginfo
Date: Mon, 10 Sep 2018 12:19:58 -0300
Message-ID: <20180910151958.GN5147@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
 <20180905220440.20256-78-acme@kernel.org>
 <62359230-cfb2-676d-6baf-93282ee99afc@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <62359230-cfb2-676d-6baf-93282ee99afc@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Kim Phillips <kim.phillips@arm.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.v>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Sep 07, 2018 at 02:09:13PM +0200, Thomas-Mich Richter escreveu:
> On 09/06/2018 12:04 AM, Arnaldo Carvalho de Melo wrote:
> > rpm -e iputils-debuginfo
> 
> I have done the same on my s390 this morning:
> 
> [root@p23lp27 perf]# ./perf test ping
> 60: probe libc's inet_pton & backtrace it with ping       : Ok
> [root@p23lp27 perf]# rpm -e iputils-debuginfo
> [root@p23lp27 perf]# ./perf test ping
> 60: probe libc's inet_pton & backtrace it with ping       : Ok
> [root@p23lp27 perf]#
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks for testing!

- Arnaldo
