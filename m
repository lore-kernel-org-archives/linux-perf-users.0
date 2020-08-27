From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC v2] perf/core: Fixes hung issue on perf stat command during
 cpu hotplug
Date: Thu, 27 Aug 2020 11:17:42 +0530
Message-ID: <20200827054742.GA5431@linux.vnet.ibm.com>
References: <20200826145411.489169-1-kjain@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200826145411.489169-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, daniel@iogearbox.net, brho@google.com
List-Id: linux-perf-users.vger.kernel.org

* Kajol Jain <kjain@linux.ibm.com> [2020-08-26 20:24:11]:

> Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
> added assignment of ret value as -EAGAIN in case function
> call to 'smp_call_function_single' fails.
> For non-zero ret value, it did
> 'ret = !ret ? data.ret : -EAGAIN;', which always
> assign -EAGAIN to ret and make second if condition useless.
> 
> In scenarios like when executing a perf stat with --per-thread option, and
> if any of the monitoring cpu goes offline, the 'smp_call_function_single'
> function could return -ENXIO, and with the above check,
> task_function_call hung and increases CPU
> usage (because of repeated 'smp_call_function_single()')
> 
> Recration scenario:
> 	# perf stat -a --per-thread && (offline a CPU )
> 
> Patch here removes the tertiary condition added as part of that
> commit and added a check for NULL and -EAGAIN.
> 
> Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>


-- 
Thanks and Regards
Srikar Dronamraju
