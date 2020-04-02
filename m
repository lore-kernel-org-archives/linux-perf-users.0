From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v8 0/7]  powerpc/perf: Add json file metric support for
 the hv_24x7 socket/chip level events
Date: Thu, 2 Apr 2020 23:27:04 +0200
Message-ID: <20200402212704.GC2784502@krava>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200401203340.31402-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 02, 2020 at 02:03:33AM +0530, Kajol Jain wrote:
> Patchset adds json file metric support for the hv_24x7 socket/chip level
> events. "hv_24x7" pmu interface events needs system dependent parameter
> like socket/chip/core. For example, hv_24x7 chip level events needs
> specific chip-id to which the data is requested should be added as part
> of pmu events.
> 
> So to enable JSON file support to "hv_24x7" interface, patchset reads
> total number of sockets details in sysfs under 
> "/sys/devices/hv_24x7/interface/".
> 
> Second patch of the patchset adds expr_scanner_ctx object to hold user
> data for the expr scanner, which can be used to hold runtime parameter.
> 
> Patch 4 & 6 of the patchset handles perf tool plumbing needed to replace
> the "?" character in the metric expression to proper value and hv_24x7
> json metric file for different Socket/chip resources.
> 
> Patch set also enable Hz/hz prinitg for --metric-only option to print
> metric data for bus frequency.
> 
> Applied and tested all these patches cleanly on top of jiri's flex changes
> with the changes done by Kan Liang for "Support metric group constraint"
> patchset and made required changes.
> 
> Also apply this patch on top of the fix patch send earlier
> for printing metric name incase overlapping events.
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=37cd7f65bf71a48f25eeb6d9be5dacb20d008ea6
> 
> Changelog:
> v7 -> v8
> - Add test case for testing parsing of "?" in metric expression
> - Reaname variables name to runtime

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
