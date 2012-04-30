From: David Wragg <david@wragg.org>
Subject: Re: LLC-* events not working on sandybridge
Date: Mon, 30 Apr 2012 18:50:39 +0100
Message-ID: <sa7k40xf6s0.fsf@wragg.org>
References: <sa7r4v7foi5.fsf@wragg.org> <87ehr5sj8p.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33370 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2D3Ruo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 30 Apr 2012 13:50:44 -0400
Received: by wgbdr13 with SMTP id dr13so768407wgb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Apr 2012 10:50:43 -0700 (PDT)
In-Reply-To: <87ehr5sj8p.fsf@sejong.aot.lge.com> (Namhyung Kim's message of
	"Mon, 30 Apr 2012 17:43:02 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung.kim@lge.com>
Cc: linux-perf-users@vger.kernel.org

Namhyung Kim <namhyung.kim@lge.com> writes:
> On Sun, 29 Apr 2012 00:03:14 +0100, David Wragg wrote:
>> I've run into a problem with perf on an Intel Sandybridge machine: The
>> LLC-* events never seem to trigger.
>> [...]
>
> I have a same problem on my i7-3930K machine. I guess it's because of
> lacking of extra register (MSP_OFFCORE_RSP_X) settings. But I have no
> idea of how I can set it properly :(.

Ok, I've done some further digging around, and it doesn't look like the
patch "perf events, x86: Implement Sandybridge last-level cache events"
at <https://lkml.org/lkml/2011/5/9/80> ever got merged.  It's not clear
why.

David
