From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/15] perf script python: add Python3 support to
 intel-pt-events.py
Date: Mon, 25 Feb 2019 09:07:03 +0200
Message-ID: <1cc3561f-604f-6f01-147c-89deb07d3410@intel.com>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-7-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222230619.17887-7-tonyj@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 23/02/19 1:06 AM, Tony Jones wrote:
> Support both Python2 and Python3 in the intel-pt-events.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> Fix space/tab inconsistency as python3 enforces consistency.

It would be better for the white space changes to be a separate patch.

But I am not in favour of using spaces instead of tabs because it is the
opposite of what we tend to do with C.

Arnaldo, can you provide a guideline on this?

> 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/scripts/python/intel-pt-events.py | 138 ++++++++++---------
>  1 file changed, 70 insertions(+), 68 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> index b19172d673af..aef54566af61 100644
> --- a/tools/perf/scripts/python/intel-pt-events.py
> +++ b/tools/perf/scripts/python/intel-pt-events.py
> @@ -10,79 +10,81 @@
>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>  # more details.
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  import struct
>  
>  sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> +        '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
>  
>  # These perf imports are not used at present
>  #from perf_trace_context import *
>  #from Core import *
>  
>  def trace_begin():
> -	print "Intel PT Power Events and PTWRITE"
> +        print("Intel PT Power Events and PTWRITE")
>  
>  def trace_end():
> -	print "End"
> +        print("End")
>  
>  def trace_unhandled(event_name, context, event_fields_dict):
> -		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
> +        print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
>  
>  def print_ptwrite(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	flags = data[0]
> -	payload = data[1]
> -	exact_ip = flags & 1
> -	print "IP: %u payload: %#x" % (exact_ip, payload),
> +        data = struct.unpack_from("<IQ", raw_buf)
> +        flags = data[0]
> +        payload = data[1]
> +        exact_ip = flags & 1
> +        print("IP: %u payload: %#x" % (exact_ip, payload), end='')
>  
>  def print_cbr(raw_buf):
> -	data = struct.unpack_from("<BBBBII", raw_buf)
> -	cbr = data[0]
> -	f = (data[4] + 500) / 1000
> -	p = ((cbr * 1000 / data[2]) + 5) / 10
> -	print "%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p),
> +        data = struct.unpack_from("<BBBBII", raw_buf)
> +        cbr = data[0]
> +        f = (data[4] + 500) / 1000
> +        p = ((cbr * 1000 / data[2]) + 5) / 10
> +        print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p), end='')
>  
>  def print_mwait(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	hints = payload & 0xff
> -	extensions = (payload >> 32) & 0x3
> -	print "hints: %#x extensions: %#x" % (hints, extensions),
> +        data = struct.unpack_from("<IQ", raw_buf)
> +        payload = data[1]
> +        hints = payload & 0xff
> +        extensions = (payload >> 32) & 0x3
> +        print("hints: %#x extensions: %#x" % (hints, extensions), end='')
>  
>  def print_pwre(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	hw = (payload >> 7) & 1
> -	cstate = (payload >> 12) & 0xf
> -	subcstate = (payload >> 8) & 0xf
> -	print "hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
> +        data = struct.unpack_from("<IQ", raw_buf)
> +        payload = data[1]
> +        hw = (payload >> 7) & 1
> +        cstate = (payload >> 12) & 0xf
> +        subcstate = (payload >> 8) & 0xf
> +        print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate), end='')
>  
>  def print_exstop(raw_buf):
> -	data = struct.unpack_from("<I", raw_buf)
> -	flags = data[0]
> -	exact_ip = flags & 1
> -	print "IP: %u" % (exact_ip),
> +        data = struct.unpack_from("<I", raw_buf)
> +        flags = data[0]
> +        exact_ip = flags & 1
> +        print("IP: %u" % (exact_ip), end='')
>  
>  def print_pwrx(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	deepest_cstate = payload & 0xf
> -	last_cstate = (payload >> 4) & 0xf
> -	wake_reason = (payload >> 8) & 0xf
> -	print "deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason),
> +        data = struct.unpack_from("<IQ", raw_buf)
> +        payload = data[1]
> +        deepest_cstate = payload & 0xf
> +        last_cstate = (payload >> 4) & 0xf
> +        wake_reason = (payload >> 8) & 0xf
> +        print("deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason), end='')
>  
>  def print_common_start(comm, sample, name):
> -	ts = sample["time"]
> -	cpu = sample["cpu"]
> -	pid = sample["pid"]
> -	tid = sample["tid"]
> -	print "%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
> +        ts = sample["time"]
> +        cpu = sample["cpu"]
> +        pid = sample["pid"]
> +        tid = sample["tid"]
> +        print("%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name), end='')
>  
>  def print_common_ip(sample, symbol, dso):
> -	ip = sample["ip"]
> -	print "%16x %s (%s)" % (ip, symbol, dso)
> +        ip = sample["ip"]
> +        print("%16x %s (%s)" % (ip, symbol, dso))
>  
>  def process_event(param_dict):
>          event_attr = param_dict["attr"]
> @@ -92,37 +94,37 @@ def process_event(param_dict):
>          name       = param_dict["ev_name"]
>  
>          # Symbol and dso info are not always resolved
> -        if (param_dict.has_key("dso")):
> +        if "dso" in param_dict:
>                  dso = param_dict["dso"]
>          else:
>                  dso = "[unknown]"
>  
> -        if (param_dict.has_key("symbol")):
> +        if "symbol" in param_dict:
>                  symbol = param_dict["symbol"]
>          else:
>                  symbol = "[unknown]"
>  
> -	if name == "ptwrite":
> -		print_common_start(comm, sample, name)
> -		print_ptwrite(raw_buf)
> -		print_common_ip(sample, symbol, dso)
> -	elif name == "cbr":
> -		print_common_start(comm, sample, name)
> -		print_cbr(raw_buf)
> -		print_common_ip(sample, symbol, dso)
> -	elif name == "mwait":
> -		print_common_start(comm, sample, name)
> -		print_mwait(raw_buf)
> -		print_common_ip(sample, symbol, dso)
> -	elif name == "pwre":
> -		print_common_start(comm, sample, name)
> -		print_pwre(raw_buf)
> -		print_common_ip(sample, symbol, dso)
> -	elif name == "exstop":
> -		print_common_start(comm, sample, name)
> -		print_exstop(raw_buf)
> -		print_common_ip(sample, symbol, dso)
> -	elif name == "pwrx":
> -		print_common_start(comm, sample, name)
> -		print_pwrx(raw_buf)
> -		print_common_ip(sample, symbol, dso)
> +        if name == "ptwrite":
> +                print_common_start(comm, sample, name)
> +                print_ptwrite(raw_buf)
> +                print_common_ip(sample, symbol, dso)
> +        elif name == "cbr":
> +                print_common_start(comm, sample, name)
> +                print_cbr(raw_buf)
> +                print_common_ip(sample, symbol, dso)
> +        elif name == "mwait":
> +                print_common_start(comm, sample, name)
> +                print_mwait(raw_buf)
> +                print_common_ip(sample, symbol, dso)
> +        elif name == "pwre":
> +                print_common_start(comm, sample, name)
> +                print_pwre(raw_buf)
> +                print_common_ip(sample, symbol, dso)
> +        elif name == "exstop":
> +                print_common_start(comm, sample, name)
> +                print_exstop(raw_buf)
> +                print_common_ip(sample, symbol, dso)
> +        elif name == "pwrx":
> +                print_common_start(comm, sample, name)
> +                print_pwrx(raw_buf)
> +                print_common_ip(sample, symbol, dso)
> 
