From: Mikhail Kulemin <mihkulemin@gmail.com>
Subject: Re: What should I do if I want to get Perf samples and Read
 Performance Counter at the same time?
Date: Fri, 30 Aug 2013 22:37:16 +0400
Message-ID: <CAKnzfP85hNi_56Sn2ZoC=B_zRJO1TDYFya7oKrnrRPCpV0=HFw@mail.gmail.com>
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
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64244 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab3H3ShR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 30 Aug 2013 14:37:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2189996pbb.5
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2013 11:37:16 -0700 (PDT)
In-Reply-To: <5220DDF7.5020704@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Peipei Wang <wangpeipei.90@gmail.com>, perf group <linux-perf-users@vger.kernel.org>

Indeed, It is preferable. I`m miss it.

2013/8/30 David Ahern <dsahern@gmail.com>:
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
