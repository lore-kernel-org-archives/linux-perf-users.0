From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: Re: What should I do if I want to get Perf samples and Read
 Performance Counter at the same time?
Date: Fri, 30 Aug 2013 18:42:48 -0400
Message-ID: <CAEuYUequvyDxVbRUk4JAT9GEea8nVh_-6=pECEsh1_ybPG9jDQ@mail.gmail.com>
References: <CAEuYUerYx9w=LdJsGG0PV0BKteMcoTL4ro=3+nfm8hBdXtuZ2w@mail.gmail.com>
	<521E57D4.7090105@gmail.com>
	<CAKnzfP9VxYry9v+tSyTrs_9m6GFoCGzAuKXY0_yv99LqumeZEg@mail.gmail.com>
	<CAEuYUeoj9YmHmD9SPv1OMdqaNV+C3e1UoMxTKW4kvQbmJxq2=A@mail.gmail.com>
	<CAKnzfP85J+AD9A4E2OD9ZzHfCoE_0srPdFRJp2SXmwFc6Dh_Jg@mail.gmail.com>
	<CAEuYUep-n=Pts8sFSusgOvKG8xTY8=aQqjb8mqtEpfUzz6ihCw@mail.gmail.com>
	<CAEuYUepG4p2+ET81MdrrajgUvfgG4=WnNwSDKpPS8YSQ8EO+6w@mail.gmail.com>
	<CAKnzfP99WV-p=WP0zgs-68+dy7pTxkfMPcDEmL_P6KL4jh2Umw@mail.gmail.com>
	<CAEuYUepPNNpUQ8ysgyR6DK85_kUqiZyz=hdfnfwzFQtCG=mhuQ@mail.gmail.com>
	<CAKnzfP995a6UrpKDJ4akOMDBX-j9vkwhtp-i0S=WM3v3pWzQvg@mail.gmail.com>
	<52209F11.5030201@gmail.com>
	<CAEuYUeoNJg4wjcpJNQeJH=-E4TQ1cQJVvB5P4z87KNGTXdP6_A@mail.gmail.com>
	<CAKnzfP_QR1X1M8g0awamFNqgaMS1O2s5c6MgW2W5x7D3YnCMdQ@mail.gmail.com>
	<5220DDF7.5020704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:37764 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab3H3Wmt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 30 Aug 2013 18:42:49 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz11so1757456veb.8
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2013 15:42:48 -0700 (PDT)
In-Reply-To: <5220DDF7.5020704@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Mikhail Kulemin <mihkulemin@gmail.com>, perf group <linux-perf-users@vger.kernel.org>

Thanks David.

That was I did at first. You know I compiled perf from git repository
and it is actually not an official version. So I copy all stuffs in
the directory of perf to
/usr/src/linux-header3-3.10.9-031009/tools/perf  and make a soft link
to /usr/bin/perf.

I read the perf-script.py, actually, and set the environment variable
PERF_EXEC_PATH in /etc/profile :
                        export PERF_EXEC_PATH=
/usr/src/linux-header3-3.10.9-031009/tools/perf

But it doesn't work. But after I use the absolute directory, it seems
to work now.  But setting absolute directory still doesn't work on
Redhat 6.0, even if I replaced the total directory of perf.

Here it is. I get a Segmentation fault here.

[pwang7@bn20-171 ~]$ perf script -s perf-script.py
# ========
# captured on: Fri Aug 30 14:00:01 2013
# hostname : bn20-171.dcs.mcnc.org
# os release : 2.6.32-71.el6.x86_64
# perf version : 2.6.32-358.11.1.el6.x86_64.debug
# arch : x86_64
# nrcpus online : 24
# nrcpus avail : 24
# cpudesc : Intel(R) Xeon(R) CPU E5645 @ 2.40GHz
# cpuid : GenuineIntel,6,44,2
# total memory : 99061748 kB
# cmdline : /usr/bin/perf record -e cache-misses ls
# event : name = cache-misses, type = 0, config = 0x3, config1 = 0x0,
config2 = 0x0, excl_usr = 0, excl_kern = 0, excl_host = 0, excl_guest
= 0, precise_ip = 0, id = { 1797, 1798, 1799, 1800, 1801, 1802, 1803,
1804, 1805, 1806, 1807, 1808, 1809, 1810, 1811, 1812, 1813, 1814,
1815, 1816, 1817, 1818, 1819, 1820 }
# HEADER_CPU_TOPOLOGY info available, use -I to display
# HEADER_NUMA_TOPOLOGY info available, use -I to display
# ========
#
in trace_begin
Segmentation fault (core dumped)
Best wishes.
Yours,
Wang Peipei


On Fri, Aug 30, 2013 at 2:01 PM, David Ahern <dsahern@gmail.com> wrote:
> On 8/30/13 11:15 AM, Mikhail Kulemin wrote:
>>
>> You should fix perf-script.py
>>
>> replace   sys.path.append(os.environ['PERF_EXEC_PATH'] +
>> '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
>> with
>
>
> better to set/export PERF_EXEC_PATH before running the command.
>
> David
>
>
>
>>
>> sys.path.append(os.getcwd()+"/tools/perf/scripts/python/
>> Perf-Trace-Util/lib/Perf/Trace")
>>
>> this string instruct python interpreter where to find modules to load.
>>
>>
>> Please check that "perf script" command works correctly (output all
>> sample records from perf.data file)
>
>
