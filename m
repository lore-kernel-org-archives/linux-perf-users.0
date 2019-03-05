From: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH v2 5/7] perf script python: add Python3 support to
 intel-pt-events.py
Date: Tue, 5 Mar 2019 08:10:09 -0800
Message-ID: <18913237-75f2-731b-940d-1fccc43d1b4a@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-6-tonyj@suse.de>
 <6fe06c75-5f98-4829-e139-af2bfcda24f3@intel.com>
 <dfa719d4-0d9e-ad08-536f-17b3da116b19@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dfa719d4-0d9e-ad08-536f-17b3da116b19@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 3/5/19 7:02 AM, Tony Jones wrote:

> I tested the patch on a Skylake system but it was not connected to our standard
> network so I had to move files manually.  It seems I managed to somehow mess up
> and not attach the correct patch :(

Sure enough, I managed to attach the wrong patch. Sorry. I'll attach revised (v3) 
to this thread as the change is trivial.

I am seeing a lot of "instruction trace errors" on this Skylake system.  I see them
using Python2 without any of the changes.  I've not looked at this.

Output of v3.

# head /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 94
model name	: Intel(R) Xeon(R) CPU E3-1240 v5 @ 3.50GHz
stepping	: 3
microcode	: 0xc6
cpu MHz		: 1600.887
cache size	: 8192 KB
physical id	: 0

# ldd /tmp/perf/bin/perf | grep python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007fd8fdaae000)

# /tmp/perf/bin/perf script report intel-pt-events -i /tmp/perf.data | tail -20
         swapper     0/0     [006]     17424.535324338     cbr:  27  freq: 2703 MHz  ( 77%)                0 [unknown] ([unknown])
            perf 20899/20899 [003]     17424.535324363     cbr:  27  freq: 2703 MHz  ( 77%)                0 [unknown] ([unknown])
         swapper     0/0     [004]     17424.535324387     cbr:  27  freq: 2703 MHz  ( 77%)                0 [unknown] ([unknown])
         swapper     0/0     [000]     17424.535324867     cbr:  27  freq: 2703 MHz  ( 77%)                0 [unknown] ([unknown])
         swapper     0/0     [006]     17424.543315376     cbr:  24  freq: 2403 MHz  ( 69%)                0 [unknown] ([unknown])
            perf 20899/20899 [003]     17424.699315686     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [006]     17424.714915068     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [005]     17424.779321732     cbr:   9  freq:  901 MHz  ( 26%)                0 [unknown] ([unknown])
         swapper     0/0     [001]     17424.779322738     cbr:   9  freq:  901 MHz  ( 26%)                0 [unknown] ([unknown])
         swapper     0/0     [003]     17424.903321958     cbr:   9  freq:  901 MHz  ( 26%)                0 [unknown] ([unknown])
         swapper     0/0     [000]     17425.099316258     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [003]     17425.107316167     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [004]     17425.519574381     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [001]     17425.519796998     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [002]     17425.519828095     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [005]     17425.519897417     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
         swapper     0/0     [007]     17425.519936473     cbr:  16  freq: 1602 MHz  ( 46%)                0 [unknown] ([unknown])
Warning:
260 instruction trace errors
End
