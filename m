From: =?ISO-8859-1?Q?Jos=E9_Sim=E3o?= <jose.m.simao@gmail.com>
Subject: Re: ratio of progress of the counters
Date: Mon, 4 Nov 2013 15:12:32 +0000
Message-ID: <CAJ38vxvPBP=TFJXf55wfk5Y=Q=QX2xZ6L3p3Gb1Ob0b3cC-efg@mail.gmail.com>
References: <CAJ38vxtu6nsNU8m_kWecJKVKs8ArBmaR2DF3iXmcE=pUQoxEEA@mail.gmail.com>
	<871u2zykx9.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51364 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab3KDPMg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Nov 2013 10:12:36 -0500
Received: by mail-lb0-f174.google.com with SMTP id q8so5450131lbi.5
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2013 07:12:34 -0800 (PST)
In-Reply-To: <871u2zykx9.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On Fri, Nov 1, 2013 at 7:35 PM, Andi Kleen <andi@firstfloor.org> wrote:
> Jos=E9 Sim=E3o <jose.m.simao@gmail.com> writes:
>
>> Dear all,
>>
>> I'm trying to collect ASCII-based progress information regarding a s=
et
>> of performance counters. "Progress" means, for example, the ratios o=
f
>> values/second (e.g. page faults/seconds).
>>
>> I can get information in this form using 'perf stat' but 'stat' only
>> gives me the final value. I would like to collect, or calculate,
>> theses values from the running command and determine how these metri=
cs
>> evolved over time (i.e. faster or slower).
>
> Newer perf stat has a -I (interval) option for this.

Thank you for your answer.

How can I get more information regarding the update of my system to
use this new version of perf?

Regards,
Jos=E9

>
> -Andi
>
> --
> ak@linux.intel.com -- Speaking for myself only
