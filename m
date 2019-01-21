From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf script: fix crash when processing recorded stat data
Date: Mon, 21 Jan 2019 11:16:26 +0530
Message-ID: <aebdb574-66d2-9135-a6d0-3cd985abfc2f@linux.ibm.com>
References: <20190120191414.12925-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190120191414.12925-1-tonyj@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, jolsa@redhat.com, ak@linux.intel.com, linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 1/21/19 12:44 AM, Tony Jones wrote:
> While updating Perf to work with Python3 and Python2 I noticed that the 
> stat-cpi script was dumping core.

[...]
> Fixes: 1fcd03946b52 ("perf stat: Update per-thread shadow stats")
> Signed-off-by: Tony Jones <tonyj@suse.de>

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
