From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: LLC-* events not working on sandybridge
Date: Wed, 02 May 2012 09:53:30 +0900
Message-ID: <87txzzmmid.fsf@sejong.aot.lge.com>
References: <sa7r4v7foi5.fsf@wragg.org> <87ehr5sj8p.fsf@sejong.aot.lge.com>
	<sa7k40xf6s0.fsf@wragg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:44768 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025Ab2EBAyk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 May 2012 20:54:40 -0400
In-Reply-To: <sa7k40xf6s0.fsf@wragg.org> (David Wragg's message of "Mon, 30
	Apr 2012 18:50:39 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Wragg <david@wragg.org>
Cc: linux-perf-users@vger.kernel.org

Hi,

On Mon, 30 Apr 2012 18:50:39 +0100, David Wragg wrote:
> Namhyung Kim <namhyung.kim@lge.com> writes:
>> On Sun, 29 Apr 2012 00:03:14 +0100, David Wragg wrote:
>>> I've run into a problem with perf on an Intel Sandybridge machine: The
>>> LLC-* events never seem to trigger.
>>> [...]
>>
>> I have a same problem on my i7-3930K machine. I guess it's because of
>> lacking of extra register (MSP_OFFCORE_RSP_X) settings. But I have no
>> idea of how I can set it properly :(.
>
> Ok, I've done some further digging around, and it doesn't look like the
> patch "perf events, x86: Implement Sandybridge last-level cache events"
> at <https://lkml.org/lkml/2011/5/9/80> ever got merged.  It's not clear
> why.
>

It seems that PeterZ and Ingo don't want an unverified patch get
merged. But you can still test with it and, hopefully, provide us a
verification :).

Thanks,
Namhyung
