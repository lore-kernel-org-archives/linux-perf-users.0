From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 5/7] perf script python: add Python3 support to
 intel-pt-events.py
Date: Tue, 5 Mar 2019 12:16:48 +0200
Message-ID: <6fe06c75-5f98-4829-e139-af2bfcda24f3@intel.com>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-6-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302011903.2416-6-tonyj@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 2/03/19 3:19 AM, Tony Jones wrote:
> Support both Python2 and Python3 in the intel-pt-events.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>

One change missed, see below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/scripts/python/intel-pt-events.py | 30 +++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> index 2177722f509e..5c42c4c359dc 100644
> --- a/tools/perf/scripts/python/intel-pt-events.py
> +++ b/tools/perf/scripts/python/intel-pt-events.py
> @@ -10,6 +10,8 @@
>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>  # more details.
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  import struct
> @@ -22,10 +24,10 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
>  #from Core import *
>  
>  def trace_begin():
> -	print "Intel PT Power Events and PTWRITE"
> +	print("Intel PT Power Events and PTWRITE")
>  
>  def trace_end():
> -	print "End"
> +	print("End")
>  
>  def trace_unhandled(event_name, context, event_fields_dict):
>  		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])

Also above line

> @@ -35,21 +37,21 @@ def print_ptwrite(raw_buf):
>  	flags = data[0]
>  	payload = data[1]
>  	exact_ip = flags & 1
> -	print "IP: %u payload: %#x" % (exact_ip, payload),
> +	print("IP: %u payload: %#x" % (exact_ip, payload), end=' ')
>  
>  def print_cbr(raw_buf):
>  	data = struct.unpack_from("<BBBBII", raw_buf)
>  	cbr = data[0]
>  	f = (data[4] + 500) / 1000
>  	p = ((cbr * 1000 / data[2]) + 5) / 10
> -	print "%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p),
> +	print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p), end=' ')
>  
>  def print_mwait(raw_buf):
>  	data = struct.unpack_from("<IQ", raw_buf)
>  	payload = data[1]
>  	hints = payload & 0xff
>  	extensions = (payload >> 32) & 0x3
> -	print "hints: %#x extensions: %#x" % (hints, extensions),
> +	print("hints: %#x extensions: %#x" % (hints, extensions), end=' ')
>  
>  def print_pwre(raw_buf):
>  	data = struct.unpack_from("<IQ", raw_buf)
> @@ -57,13 +59,14 @@ def print_pwre(raw_buf):
>  	hw = (payload >> 7) & 1
>  	cstate = (payload >> 12) & 0xf
>  	subcstate = (payload >> 8) & 0xf
> -	print "hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
> +	print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
> +		end=' ')
>  
>  def print_exstop(raw_buf):
>  	data = struct.unpack_from("<I", raw_buf)
>  	flags = data[0]
>  	exact_ip = flags & 1
> -	print "IP: %u" % (exact_ip),
> +	print("IP: %u" % (exact_ip), end=' ')
>  
>  def print_pwrx(raw_buf):
>  	data = struct.unpack_from("<IQ", raw_buf)
> @@ -71,18 +74,21 @@ def print_pwrx(raw_buf):
>  	deepest_cstate = payload & 0xf
>  	last_cstate = (payload >> 4) & 0xf
>  	wake_reason = (payload >> 8) & 0xf
> -	print "deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason),
> +	print("deepest cstate: %u last cstate: %u wake reason: %#x" %
> +		(deepest_cstate, last_cstate, wake_reason), end=' ')
>  
>  def print_common_start(comm, sample, name):
>  	ts = sample["time"]
>  	cpu = sample["cpu"]
>  	pid = sample["pid"]
>  	tid = sample["tid"]
> -	print "%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
> +	print("%16s %5u/%-5u [%03u] %9u.%09u %7s:" %
> +		(comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
> +		end=' ')
>  
>  def print_common_ip(sample, symbol, dso):
>  	ip = sample["ip"]
> -	print "%16x %s (%s)" % (ip, symbol, dso)
> +	print("%16x %s (%s)" % (ip, symbol, dso))
>  
>  def process_event(param_dict):
>  	event_attr = param_dict["attr"]
> @@ -92,12 +98,12 @@ def process_event(param_dict):
>  	name	   = param_dict["ev_name"]
>  
>  	# Symbol and dso info are not always resolved
> -	if (param_dict.has_key("dso")):
> +	if "dso" in param_dict:
>  		dso = param_dict["dso"]
>  	else:
>  		dso = "[unknown]"
>  
> -	if (param_dict.has_key("symbol")):
> +	if "symbol" in param_dict:
>  		symbol = param_dict["symbol"]
>  	else:
>  		symbol = "[unknown]"
> 
