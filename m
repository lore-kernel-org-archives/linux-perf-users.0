From: David Wragg <david@wragg.org>
Subject: Re: LLC-* events not working on sandybridge
Date: Sun, 06 May 2012 00:48:26 +0100
Message-ID: <sa7vckatcj9.fsf@wragg.org>
References: <sa7r4v7foi5.fsf@wragg.org> <87ehr5sj8p.fsf@sejong.aot.lge.com>
	<sa7k40xf6s0.fsf@wragg.org> <87txzzmmid.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34600 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab2EEXsb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 5 May 2012 19:48:31 -0400
Received: by werb10 with SMTP id b10so595244wer.19
        for <linux-perf-users@vger.kernel.org>; Sat, 05 May 2012 16:48:30 -0700 (PDT)
In-Reply-To: <87txzzmmid.fsf@sejong.aot.lge.com> (Namhyung Kim's message of
	"Wed, 02 May 2012 09:53:30 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung.kim@lge.com>
Cc: linux-perf-users@vger.kernel.org

Namhyung Kim <namhyung.kim@lge.com> writes:
> On Mon, 30 Apr 2012 18:50:39 +0100, David Wragg wrote:
>> Ok, I've done some further digging around, and it doesn't look like the
>> patch "perf events, x86: Implement Sandybridge last-level cache events"
>> at <https://lkml.org/lkml/2011/5/9/80> ever got merged.  It's not clear
>> why.
>>
>
> It seems that PeterZ and Ingo don't want an unverified patch get
> merged. But you can still test with it and, hopefully, provide us a
> verification :).

I fixed the patch up for 3.3, and it works for me.  I'll ask Lin Ming
what happened to it.

David
