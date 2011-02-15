From: Arun Sharma <arun@sharma-home.net>
Subject: Re: [RFC] --dump-sym-trace
Date: Mon, 14 Feb 2011 16:00:12 -0800
Message-ID: <AANLkTimuEQVDdR7kZeDG0O3UUpyXd2+wA73b6HtrhTVU@mail.gmail.com>
References: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>
	<4D3F871B.3060906@cisco.com>
	<AANLkTinik0+Zp7N54bkh5fBzF1hb2XoubRbuMXwBeYGZ@mail.gmail.com>
	<4D433811.7020904@cisco.com>
	<20110129205050.GH6345@ghostprotocols.net>
	<AANLkTi=QdnJ2R-9bn4r+njwAnNewvWvBO2GRw6W4qwnj@mail.gmail.com>
	<4D4CB83A.2030400@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52081 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1BOAAN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Feb 2011 19:00:13 -0500
Received: by iyj8 with SMTP id 8so5377142iyj.19
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2011 16:00:12 -0800 (PST)
In-Reply-To: <4D4CB83A.2030400@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org

On Fri, Feb 4, 2011 at 6:38 PM, David Ahern <daahern@cisco.com> wrote:

> I take it your mileage varied from the above.

I can't reproduce the issue anymore and the code looks just fine. The
issue I had was:

perf record -a -T + perf report --timehist produced samples where:
perf record --timehist + perf report --timehist didn't.

 -Arun
