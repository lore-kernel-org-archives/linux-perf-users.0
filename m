From: Mikhail Kulemin <mihkulemin@gmail.com>
Subject: Re: What should I do if I want to get Perf samples and Read
 Performance Counter at the same time?
Date: Fri, 30 Aug 2013 21:15:27 +0400
Message-ID: <CAKnzfP_QR1X1M8g0awamFNqgaMS1O2s5c6MgW2W5x7D3YnCMdQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:35874 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3H3RP2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 30 Aug 2013 13:15:28 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so2110703pbb.6
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2013 10:15:27 -0700 (PDT)
In-Reply-To: <CAEuYUeoNJg4wjcpJNQeJH=-E4TQ1cQJVvB5P4z87KNGTXdP6_A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, perf group <linux-perf-users@vger.kernel.org>

You should fix perf-script.py

replace   sys.path.append(os.environ['PERF_EXEC_PATH'] +
'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
with

sys.path.append(os.getcwd()+"/tools/perf/scripts/python/
Perf-Trace-Util/lib/Perf/Trace")

this string instruct python interpreter where to find modules to load.


Please check that "perf script" command works correctly (output all
sample records from perf.data file)

Mikhail.

2013/8/30 Peipei Wang <wangpeipei.90@gmail.com>:
> Hi Mikhail,
>
> Yes, you are right. I could use perf now. But I get errors again running
> "perf script -s perf-script.py". Here it is:
> perf script -s perf-script.py
> Traceback (most recent call last):
>   File "perf-script.py", line 18, in <module>
>     from Core import *
> ImportError: No module named Core
>
> I do have the module Core.py in the directory of
> tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace
>
> Is there anything else I should pay attention to when using this?
>
> Best wishes.
> Yours,
> Wang Peipei
>
>
> On Fri, Aug 30, 2013 at 9:33 AM, David Ahern <dsahern@gmail.com> wrote:
>>
>> On 8/29/13 10:28 PM, Mikhail Kulemin wrote:
>>>
>>> You can ignote message about Android. As far as I understand form
>>> output you should see compiled executable of perf in tools/perf
>>> directory. Please check it.
>>
>>
>> Yes, you can ignore that message during the CHK - it's just probing for
>> build options.
>>
>> David
>
>
