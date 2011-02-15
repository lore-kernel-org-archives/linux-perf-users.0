From: David Ahern <daahern@cisco.com>
Subject: Re: [RFC] --dump-sym-trace
Date: Mon, 14 Feb 2011 17:03:47 -0700
Message-ID: <4D59C2E3.1030306@cisco.com>
References: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>	<4D3F871B.3060906@cisco.com>	<AANLkTinik0+Zp7N54bkh5fBzF1hb2XoubRbuMXwBeYGZ@mail.gmail.com>	<4D433811.7020904@cisco.com>	<20110129205050.GH6345@ghostprotocols.net>	<AANLkTi=QdnJ2R-9bn4r+njwAnNewvWvBO2GRw6W4qwnj@mail.gmail.com>	<4D4CB83A.2030400@cisco.com> <AANLkTimuEQVDdR7kZeDG0O3UUpyXd2+wA73b6HtrhTVU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70]:55785 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab1BOADt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Feb 2011 19:03:49 -0500
In-Reply-To: <AANLkTimuEQVDdR7kZeDG0O3UUpyXd2+wA73b6HtrhTVU@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org



On 02/14/11 17:00, Arun Sharma wrote:
> On Fri, Feb 4, 2011 at 6:38 PM, David Ahern <daahern@cisco.com> wrote:
> 
>> I take it your mileage varied from the above.
> 
> I can't reproduce the issue anymore and the code looks just fine. The
> issue I had was:
> 
> perf record -a -T + perf report --timehist produced samples where:
> perf record --timehist + perf report --timehist didn't.

You need the --timehist on both to work properly. If you add it to
report but not record then you are asking for information that was not
recorded. Something to be addressed for proper inclusion.

I've been wanting to use this time history option to record/analyze
syscall events lately. I'll see if I can spend some time on it this week.

David


> 
>  -Arun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
