From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: Re: How can I get timestamps of samples in perf
Date: Sat, 10 Aug 2013 10:34:46 -0400
Message-ID: <CAEuYUeo9KnMpfU2s9cqvNJG5dY+4925rMpcEK-AhjoaNNcU_XA@mail.gmail.com>
References: <CAEuYUeqSbcMiszy-mZBROobsHv1Ohr4n2rVNXr_penhux3Dy4g@mail.gmail.com>
	<87li4anojx.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:35611 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933918Ab3HJOer (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 10 Aug 2013 10:34:47 -0400
Received: by mail-ve0-f182.google.com with SMTP id m1so4651131ves.27
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Aug 2013 07:34:46 -0700 (PDT)
In-Reply-To: <87li4anojx.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: perf group <linux-perf-users@vger.kernel.org>

I get it.  Is the timestamp for wall-clock or not???    What is the
counting unit of timestamp?  Seconds??

         swapper     0 [000] 1591103.081337: instructions:          c1022ae6 int
         swapper     0 [000] 1591103.081341: instructions:          c1022ae6 int
         swapper     0 [000] 1591103.081343: instructions:          c1022ae6 int
         swapper     0 [000] 1591103.081345: instructions:          c1022ae6 int
         swapper     0 [000] 1591103.081348: instructions:          c1036a26 __t
         swapper     0 [000] 1591103.081353: cycles:          c1035e68 native_wr
         swapper     0 [000] 1591103.081355: cycles:          c1035e68 native_wr
         swapper     0 [000] 1591103.081357: cycles:          c1035e68 native_wr
         swapper     0 [000] 1591103.081359: cycles:          c1035e68 native_wr
         swapper     0 [000] 1591103.081362: cycles:          c101909c mwait_id

Best wishes.
Yours,
Wang Peipei
Best wishes.
Yours,
Wang Peipei


On Sat, Aug 10, 2013 at 12:43 AM, Andi Kleen <andi@firstfloor.org> wrote:
> Peipei Wang <wangpeipei.90@gmail.com> writes:
>
>> I am trying to understand something about perf record. In its guide,
>> perf record could use option -T to generate sample timestamp, and then
>> use perf report -D to get them.
>>
>> However, what I get from perf report -D is something as follows. Does
>> anyone have an idea what content of perf.data  means?
>
> Use "perf script" to display the data instead.
>
> -Andi
>
> --
> ak@linux.intel.com -- Speaking for myself only
