From: Arun Sharma <arun@sharma-home.net>
Subject: Re: 2.6.37 kernel warning in perf_events code
Date: Thu, 10 Feb 2011 12:02:20 -0800
Message-ID: <AANLkTi=WRrBnyiDqOeR7PnqVhh8wLFx5W0tgjNaPvkLg@mail.gmail.com>
References: <AANLkTi=4_p73eHhQbj5DDDEzTWaLou+u2igiY+yNiPQ9@mail.gmail.com>
	<20110210190843.GE20676@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55390 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab1BJUCV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Feb 2011 15:02:21 -0500
In-Reply-To: <20110210190843.GE20676@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

On Thu, Feb 10, 2011 at 11:08 AM, Arnaldo Carvalho de Melo
<acme@redhat.com> wrote:
> Em Wed, Feb 09, 2011 at 06:50:09PM -0800, Arun Sharma escreveu:
>> [ Not sure if this is known and fixed in newer kernels. My machine
>> becomes unusable after this warning triggers ]
>>
>> perf record -g -p <pid> cs -o csw.data -- sleep 3
>
> What kernel are you using? Peter, rings any bells?

Stock 2.6.37.

 -Arun
