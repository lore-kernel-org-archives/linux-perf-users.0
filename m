From: Lin Ming <minggr@gmail.com>
Subject: Re: What perf_event_paranoid can do?
Date: Mon, 21 Mar 2011 16:35:11 +0800
Message-ID: <AANLkTimJ36H76Z77AmauMWtZ9hOM62X1Y2jJa5H6fxWa@mail.gmail.com>
References: <20110321061435.GA52815@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57806 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab1CUIfL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Mar 2011 04:35:11 -0400
Received: by iwn34 with SMTP id 34so6160558iwn.19
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2011 01:35:11 -0700 (PDT)
In-Reply-To: <20110321061435.GA52815@cs.nctu.edu.tw>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: =?UTF-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>

On Mon, Mar 21, 2011 at 2:14 PM, =B3=AF=AD=B3=A5=F4 <chenwj@iis.sinica.=
edu.tw> wrote:
> Hi, folks
>
>  I don't know what "perf_event_paranoid" is for. Sometimes
> `perf` told me tweaking perf_event_paranoid. For example,
>
> $ perf stat -e branches:pp ls
> No permission to collect stats.
> Consider tweaking /proc/sys/kernel/perf_event_paranoid.
>
>  I cannot find any document talks about what perf_event_paranoid
> is and what we can do on it.

It's used to control if some action is allowed or not for normal user.
See comments at kernel/perf_event.c:

/*
 * perf event paranoia level:
 *  -1 - not paranoid at all
 *   0 - disallow raw tracepoint access for unpriv
 *   1 - disallow cpu events for unpriv
 *   2 - disallow kernel profiling for unpriv
 */

Lin Ming

>
>  Any suggestion appreciated.
>
> Regards,
> chenwj
>
> --
> Wei-Ren Chen (=B3=AF=AD=B3=A5=F4)
> Parallel Processing Lab, Institute of Information Science,
> Academia Sinica, Taiwan (R.O.C.)
> Tel:886-2-2788-3799 #1667
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
