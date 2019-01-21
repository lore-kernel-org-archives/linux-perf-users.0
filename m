From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf script: fix crash when processing recorded stat data
Date: Mon, 21 Jan 2019 11:15:29 -0300
Message-ID: <20190121141529.GB15707@kernel.org>
References: <20190120191414.12925-1-tonyj@suse.de>
 <aebdb574-66d2-9135-a6d0-3cd985abfc2f@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aebdb574-66d2-9135-a6d0-3cd985abfc2f@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Tony Jones <tonyj@suse.de>, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, jolsa@redhat.com, ak@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Jan 21, 2019 at 11:16:26AM +0530, Ravi Bangoria escreveu:
> 
> 
> On 1/21/19 12:44 AM, Tony Jones wrote:
> > While updating Perf to work with Python3 and Python2 I noticed that the 
> > stat-cpi script was dumping core.
> 
> [...]
> > Fixes: 1fcd03946b52 ("perf stat: Update per-thread shadow stats")
> > Signed-off-by: Tony Jones <tonyj@suse.de>
> 
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks, applied. Added your tby and Jiri's rby.

- Arnaldo
