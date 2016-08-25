From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Impact of perf_event_paranoid default to 2 on measurement accuracy
Date: Thu, 25 Aug 2016 15:02:46 -0700
Message-ID: <87lgzk1p89.fsf@tassilo.jf.intel.com>
References: <63c068ab-bfb5-1138-17cc-5a153ea183a7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25592 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbcHYWDz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Aug 2016 18:03:55 -0400
In-Reply-To: <63c068ab-bfb5-1138-17cc-5a153ea183a7@redhat.com> (William
        Cohen's message of "Thu, 25 Aug 2016 11:42:27 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: linux-perf-users@vger.kernel.org

William Cohen <wcohen@redhat.com> writes:

> Hi All,
>
> Recent kernels have changed the default setting of /proc/sys/kernel/perf_event_paranoid from 1 to 2 which excludes kernel space measurements.  Has there been some review of the metrics and computation of derived metrics to make sure they are correct and reasonable?  Below are two runs on the same machine back-to-back with the only change being the perf_event_paranoid setting.  The stalled-cycles-fronend looks to be still be counting kernel events for the perf_event_paranoid=2.  The GHz calculation looks questionable (probably because task-clock is measuring total time rather than just user-space time).

Yes that's a good point. Probably the only option would be to stop using
task-clock for any calculations if perf_event_period==2 and not having
the right capabilities.

Unfortunately this wouldn't handle non standard security models with
more restrictions.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
