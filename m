From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: event group without multiplexing
Date: Thu, 12 Nov 2015 18:40:01 +0100
Message-ID: <1447350001.15375.95.camel@Rudolf-RHEL-7>
References: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com>
	 <CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com>
	 <CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53065 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326AbbKLRkD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 12:40:03 -0500
In-Reply-To: <CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <cyfmxc@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 2015-11-12 at 10:02 -0500, Yuanfang Chen wrote:
> And the case can be reduced to
> 
> perf stat -e \{r1000248,r148\} -- sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>               7008      r1000248
>    <not supported>      r148
> 
>        1.001885804 seconds time elapsed
> 

perf stat -e \{r1000248,r148\} -- sleep 1

 Performance counter stats for 'sleep 1':

             9,605      r1000248
           553,201      r148


Intel Ivy Bridge EP machine (family = 6, model = 62),
kernel/perf version 4.3.0

The Intel 64 and IA-32 Architectures Software Developer's
Manual, vol-3B, part-2 agrees with the download.01.org's
json file on the fact that r0148 is limited to the counter
2 only on both IVB and HSW.

But I can't find any reference about the r1000248 event
in the Intel Manual. Vince, am I missing something?

Anyway, shouldn't it behave the same on IVB and HSW?

Michael
