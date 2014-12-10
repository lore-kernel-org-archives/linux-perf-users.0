From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated olanguages
Date: Wed, 10 Dec 2014 10:39:53 -0700
Message-ID: <54888569.30409@gmail.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com> <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com> <20141209203419.GI4189@kernel.org> <87ppbs4h5k.fsf@tassilo.jf.intel.com> <20141209222203.GD8788@kernel.org> <20141210173228.GA6759@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43491 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261AbaLJRjz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 10 Dec 2014 12:39:55 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so1206615pdi.7
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2014 09:39:55 -0800 (PST)
In-Reply-To: <20141210173228.GA6759@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, Carl Love <cel@us.ibm.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 12/10/14 10:32 AM, Andi Kleen wrote:
>>  From what I understood, how would it insert that event into the
>> perf.data event stream? Only if it necessarily involved a new mmap, via
>> the kernel, etc.
>
> That's the new interface to be defined.
>
> Just write a perf.data?

Pawel Moll's new ioctl -- assumming it gets committed.

David
