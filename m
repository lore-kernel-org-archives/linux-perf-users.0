From: David Ahern <dsahern@gmail.com>
Subject: Re: How can I get timestamps of samples in perf
Date: Sat, 10 Aug 2013 11:01:30 -0400
Message-ID: <520655CA.1020504@gmail.com>
References: <CAEuYUeqSbcMiszy-mZBROobsHv1Ohr4n2rVNXr_penhux3Dy4g@mail.gmail.com> <87li4anojx.fsf@tassilo.jf.intel.com> <CAEuYUeo9KnMpfU2s9cqvNJG5dY+4925rMpcEK-AhjoaNNcU_XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36269 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934034Ab3HJPBj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 10 Aug 2013 11:01:39 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so5921126pab.7
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Aug 2013 08:01:38 -0700 (PDT)
In-Reply-To: <CAEuYUeo9KnMpfU2s9cqvNJG5dY+4925rMpcEK-AhjoaNNcU_XA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, perf group <linux-perf-users@vger.kernel.org>

On 8/10/13 10:34 AM, Peipei Wang wrote:
> I get it.  Is the timestamp for wall-clock or not???    What is the
> counting unit of timestamp?  Seconds??

It is a "perf_clock" timestamp in seconds.micro-seconds. On x86 the 
timestamp is related to the TSC -- usually.

I have been on a 2-1/2 year mission and counting to get time-of-day 
correlations into perf. e.g., see 
https://github.com/dsahern/linux/tree/perf-time-of-day-3.8.

That branch has a kernel side change to add an ioctl to pull the 
perf_clock timestamp into userspace. It does not include tracepoints to 
catch ntpd updates for example.

David

>
>           swapper     0 [000] 1591103.081337: instructions:          c1022ae6 int
>           swapper     0 [000] 1591103.081341: instructions:          c1022ae6 int
>           swapper     0 [000] 1591103.081343: instructions:          c1022ae6 int
>           swapper     0 [000] 1591103.081345: instructions:          c1022ae6 int
>           swapper     0 [000] 1591103.081348: instructions:          c1036a26 __t
>           swapper     0 [000] 1591103.081353: cycles:          c1035e68 native_wr
>           swapper     0 [000] 1591103.081355: cycles:          c1035e68 native_wr
>           swapper     0 [000] 1591103.081357: cycles:          c1035e68 native_wr
>           swapper     0 [000] 1591103.081359: cycles:          c1035e68 native_wr
>           swapper     0 [000] 1591103.081362: cycles:          c101909c mwait_id
>
