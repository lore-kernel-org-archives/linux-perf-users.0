Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638FECF
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHmIv2Dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F98C433C7;
	Wed, 10 Jan 2024 01:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704851114;
	bh=FFLNrRDDbxixUh+974Ze7u1dJ1WagklazRcz5+sty2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHmIv2DvOH25L8ccQ7ViHt4UbddyfmvwrWXA711JlhVdF95CPKJm6ulGW7I3SA/nx
	 ZV1VwndnNbT03ydajaW5+TbeQ9PFcpvoh9hJCPnCeTqwKrG1tu1lVH3UtWoelCSxXR
	 4XtpNbrUISPpqomFRJVllsilvsPXRWkzKQd8zfBdl4BrVWOuQtgAP9uTl3u6YdWZ2T
	 4aTflCqPwAcXVD24XIjkYvkEbsOW9ECCPua0Iesrc2bpllg+APuJotU5f7E0NgHXVe
	 7ZTsG9dyiBYC1Rm5/Wk1yPNKTYIyvv/9C6TbVZAOQtiVgnraglIaurdC5TBJtdVR+A
	 XiEoMVJcslkQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id D8B7B403EF; Tue,  9 Jan 2024 22:45:11 -0300 (-03)
Date: Tue, 9 Jan 2024 22:45:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Getting PMU stats on specific syscalls
Message-ID: <ZZ32p0LRSt5-vFPX@kernel.org>
References: <202401091452.B73E21B6C@keescook>
 <CA+JHD90kw0CX9=E18A7NBJrxdPDQuwrew355RV47oBhn_1s_QQ@mail.gmail.com>
 <01A077C8-95CA-4EBC-9504-CB971C284547@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01A077C8-95CA-4EBC-9504-CB971C284547@kernel.org>
X-Url: http://acmel.wordpress.com

Em Tue, Jan 09, 2024 at 05:04:54PM -0800, Kees Cook escreveu:
> On January 9, 2024 3:30:32 PM PST, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >On Tue, Jan 9, 2024, 7:55 PM Kees Cook <keescook@chromium.org> wrote:
> >> I'd like to get PMU stats only on specific syscalls. I haven't been able
> >> to figure this out. i.e. how do I run:

> >>         perf stat -e some_syscall_name_here make -j128

> >> Try with the technique described here:

> >https://www.spinics.net/lists/linux-perf-users/msg09253.html

> >Using the syscalls:sys_enter_syscall_name and
> >syscalls:sys_exit_syscall_name as on off switches.
 
> Yeah, I can get walk-clock time, but I'm trying to get much more
> detailed stats (cache hits, cycle counts, etc).
 
> It seems I can only get PMU counts from a whole process. I was hoping
> to avoid creating a synthetic workload that only exercises the one
> syscall and instead get a view of the PMU counters under a real load
> but only for the duration of the syscall...

This is the sequence I thought would do what you want:

First run collecting the metrics you want + the slice demarcators, in
this case while running 'find /':

[root@five ~]# perf record -e '{cycles,instructions,cache-misses}' -e syscalls:sys_enter_write,syscalls:sys_exit_write find / > /dev/null
[ perf record: Woken up 213 times to write data ]
[ perf record: Captured and wrote 55.935 MB perf.data (756776 samples) ]
[root@five ~]#

this will collect lots of samples:

[root@five ~]# perf script | wc -l
756776
[root@five ~]#

Now consider samples that take place after syscalls:sys_enter_write and
stop considering as soon as you find a syscalls:sys_exit_write.

[root@five ~]# perf script --switch-on=syscalls:sys_enter_write --switch-off=syscalls:sys_exit_write | wc -l
5854
[root@five ~]#

Now a report with all the samples:

[root@five ~]# perf report  | head
# Total Lost Samples: 0
#
# Samples: 293K of events 'anon group { cycles, instructions, cache-misses }'
# Event count (approx.): 127206014994
#
#                 Overhead  Command  Shared Object                                   Symbol
# ........................  .......  ..............................................  ........................
[root@five ~]# perf report  | head -20
# Total Lost Samples: 0
#
# Samples: 293K of events 'anon group { cycles, instructions, cache-misses }'
# Event count (approx.): 127206014994
#
#                 Overhead  Command  Shared Object                                   Symbol
# ........................  .......  ..............................................  .........................
#
     2.63%   2.04%   2.36%  find     [kernel.kallsyms]                               [k] btrfs_search_slot
     2.27%   1.74%   2.67%  find     [kernel.kallsyms]                               [k] __radix_tree_lookup
     2.11%   1.81%   1.80%  find     [kernel.kallsyms]                               [k] btrfs_bin_search
     1.99%   1.98%   2.41%  find     [kernel.kallsyms]                               [k] srso_alias_safe_ret
     1.87%   2.20%   1.00%  find     [kernel.kallsyms]                               [k] read_extent_buffer
     1.74%   2.26%   0.62%  find     [kernel.kallsyms]                               [k] btrfs_real_readdir
     1.71%   1.22%   1.66%  find     [kernel.kallsyms]                               [k] read_block_for_search
     1.60%   1.64%   1.10%  find     [kernel.kallsyms]                               [k] entry_SYSCALL_64
     1.60%   1.34%   1.20%  find     [kernel.kallsyms]                               [k] kmem_cache_alloc
[root@five ~]#

And now one with just what is inside sys_enter_write <-> sys_exit_write:

[root@five ~]# perf report --switch-on=syscalls:sys_enter_write --switch-off=syscalls:sys_exit_write | head -40
# Total Lost Samples: 0
#
# Samples: 5K of events 'anon group { cycles, instructions, cache-misses }'
# Event count (approx.): 2406980186
#
#                 Overhead  Command  Shared Object      Symbol
# ........................  .......  .................  ......................................
#
    10.72%  11.71%  13.61%  find     [kernel.kallsyms]  [k] perf_output_sample
     7.56%  10.25%   8.68%  find     [kernel.kallsyms]  [k] __output_copy
     7.06%  11.47%   7.89%  find     [kernel.kallsyms]  [k] memcpy
     6.60%   5.45%   6.54%  find     [kernel.kallsyms]  [k] vfs_write
     4.51%   4.27%   5.58%  find     [kernel.kallsyms]  [k] srso_alias_safe_ret
     4.37%   2.93%   5.25%  find     [kernel.kallsyms]  [k] perf_tp_event
     4.20%   3.94%   3.92%  find     [kernel.kallsyms]  [k] perf_event_output_forward
     4.12%   5.56%   2.63%  find     [kernel.kallsyms]  [k] perf_output_begin_forward
     4.00%   2.84%   1.88%  find     [kernel.kallsyms]  [k] perf_prepare_sample
     2.97%   2.40%   1.60%  find     [kernel.kallsyms]  [k] __perf_event_header__init_id
     2.93%   4.35%   3.03%  find     [kernel.kallsyms]  [k] srso_alias_return_thunk
     2.93%   1.88%   1.70%  find     [kernel.kallsyms]  [k] perf_syscall_exit
     2.60%   2.84%   2.37%  find     [kernel.kallsyms]  [k] security_file_permission
     2.50%   2.57%   1.86%  find     [kernel.kallsyms]  [k] selinux_file_permission
     2.42%   0.71%   2.49%  find     [kernel.kallsyms]  [k] perf_tp_event_match
     2.36%   1.06%   1.64%  find     [kernel.kallsyms]  [k] __task_pid_nr_ns
     2.20%   2.24%   2.37%  find     [kernel.kallsyms]  [k] ksys_write
     1.77%   2.01%   3.78%  find     [kernel.kallsyms]  [k] __fget_light
     1.62%   2.82%   1.01%  find     [kernel.kallsyms]  [k] native_sched_clock
     1.55%   1.56%   1.79%  find     [kernel.kallsyms]  [k] __rcu_read_unlock
     1.45%   0.84%   0.72%  find     [kernel.kallsyms]  [k] syscall_exit_to_user_mode_prepare
     1.41%   0.98%   1.25%  find     [kernel.kallsyms]  [k] __perf_event_overflow
     1.36%   0.81%   0.63%  find     [kernel.kallsyms]  [k] __fsnotify_parent
     1.23%   1.36%   1.03%  find     [kernel.kallsyms]  [k] do_syscall_64
     1.19%   0.26%   1.36%  find     [kernel.kallsyms]  [k] rw_verify_area
     1.07%   0.56%   0.87%  find     [kernel.kallsyms]  [k] write_null
     1.06%   1.36%   0.38%  find     [kernel.kallsyms]  [k] perf_instruction_pointer
     0.96%   0.58%   1.21%  find     [kernel.kallsyms]  [k] inode_security
     0.92%   0.33%   0.51%  find     [kernel.kallsyms]  [k] perf_trace_buf_update
[root@five ~]#

If you want to sum up the samples for each of the events you can do as
below, but yeah, the missing feature here is to aggregate those counters
as early as possible, without generating a perf.data for post
processing.

- Arnaldo

[root@five ~]# perf script -g python
generated Python script: perf-script.py
[root@five ~]# cat perf-script.py
# perf script event handlers, generated by perf script -g python
# Licensed under the terms of the GNU GPL License version 2

# The common_* event handler fields are the most useful fields common to
# all events.  They don't necessarily correspond to the 'common_*' fields
# in the format files.  Those fields not available as handler params can
# be retrieved using Python functions of the form common_*(context).
# See the perf-script-python Documentation for the list of available functions.

from __future__ import print_function

import os
import sys

sys.path.append(os.environ['PERF_EXEC_PATH'] + \
	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')

from perf_trace_context import *
from Core import *


def trace_begin():
	print("in trace_begin")

def trace_end():
	print("in trace_end")

def syscalls__sys_exit_write(event_name, context, common_cpu,
	common_secs, common_nsecs, common_pid, common_comm,
	common_callchain, __syscall_nr, ret, perf_sample_dict):
		print_header(event_name, common_cpu, common_secs, common_nsecs,
			common_pid, common_comm)

		print("__syscall_nr=%d, ret=%d" % \
		(__syscall_nr, ret))

		print('Sample: {'+get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')

		for node in common_callchain:
			if 'sym' in node:
				print("	[%x] %s%s%s%s" % (
					node['ip'], node['sym']['name'],
					"+0x{:x}".format(node['sym_off']) if 'sym_off' in node else "",
					" ({})".format(node['dso'])  if 'dso' in node else "",
					" " + node['sym_srcline'] if 'sym_srcline' in node else ""))
			else:
				print("	[%x]" % (node['ip']))

		print()

def syscalls__sys_enter_write(event_name, context, common_cpu,
	common_secs, common_nsecs, common_pid, common_comm,
	common_callchain, __syscall_nr, fd, buf, count,
		perf_sample_dict):
		print_header(event_name, common_cpu, common_secs, common_nsecs,
			common_pid, common_comm)

		print("__syscall_nr=%d, fd=%u, buf=%u, " \
		"count=%u" % \
		(__syscall_nr, fd, buf, count))

		print('Sample: {'+get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')

		for node in common_callchain:
			if 'sym' in node:
				print("	[%x] %s%s%s%s" % (
					node['ip'], node['sym']['name'],
					"+0x{:x}".format(node['sym_off']) if 'sym_off' in node else "",
					" ({})".format(node['dso'])  if 'dso' in node else "",
					" " + node['sym_srcline'] if 'sym_srcline' in node else ""))
			else:
				print("	[%x]" % (node['ip']))

		print()

def trace_unhandled(event_name, context, event_fields_dict, perf_sample_dict):
		print(get_dict_as_string(event_fields_dict))
		print('Sample: {'+get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')

def print_header(event_name, cpu, secs, nsecs, pid, comm):
	print("%-20s %5u %05u.%09u %8u %-20s " % \
	(event_name, cpu, secs, nsecs, pid, comm), end="")

def get_dict_as_string(a_dict, delimiter=' '):
	return delimiter.join(['%s=%s'%(k,str(v))for k,v in sorted(a_dict.items())])
[root@five ~]#
