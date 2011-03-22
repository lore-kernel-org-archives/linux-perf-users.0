From: Lin Ming <minggr@gmail.com>
Subject: Re: What perf_event_paranoid can do?
Date: Tue, 22 Mar 2011 11:09:52 +0800
Message-ID: <AANLkTim2-fcRG+JtDh5jL_eAYJdRM45W0NHpEVG0jUN0@mail.gmail.com>
References: <20110321061435.GA52815@cs.nctu.edu.tw>
	<AANLkTimJ36H76Z77AmauMWtZ9hOM62X1Y2jJa5H6fxWa@mail.gmail.com>
	<20110321095643.GA57074@cs.nctu.edu.tw>
	<AANLkTik3FT02nBPoKRh66hGA+bT7dPe2Vc0DK9HNmu7C@mail.gmail.com>
	<AANLkTi=Z0Y6nsr-QOBCtLOJMJ_eQHyQ28CjTd4pUyujk@mail.gmail.com>
	<20110322011041.GA73124@cs.nctu.edu.tw>
	<20110322015513.GA74089@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52567 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1CVDJx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Mar 2011 23:09:53 -0400
Received: by iyb26 with SMTP id 26so7009714iyb.19
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2011 20:09:52 -0700 (PDT)
In-Reply-To: <20110322015513.GA74089@cs.nctu.edu.tw>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Lin Ming <minggr@gmail.com>, linux-perf-users@vger.kernel.org, =?UTF-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>

On Tue, Mar 22, 2011 at 9:55 AM, =B3=AF=AD=B3=A5=F4 <chenwj@iis.sinica.=
edu.tw> wrote:
> Hi, Lin
>
>  As the discussion on the mailing list (see below) said,
> He suspected the older perf may over-interpret the error
> code, thus gave me poor error message.
>
> http://www.mail-archive.com/perfmon2-devel@lists.sourceforge.net/msg0=
2927.html
>
>  Is it possible to build a newer perf by a "normal" user
> himself? Or the newer perf needs a kernel update to work
> correctly?

Yes, you can build perf tool by a non-root normal user.

$ cd linux-2.6/tools/perf
$ make
$ ./perf stat -e branches:pp ls

The code changes frequently, you'd better also build a new kernel, for
example 2.6.38.
So I can analyze where from problem is with the same kernel version.

Lin Ming

>
> Regards,
> chenwj
>
> --
> Wei-Ren Chen (=B3=AF=AD=B3=A5=F4)
> Parallel Processing Lab, Institute of Information Science,
> Academia Sinica, Taiwan (R.O.C.)
> Tel:886-2-2788-3799 #1667
>
