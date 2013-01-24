From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Chronogram with pref ?
Date: Thu, 24 Jan 2013 16:39:12 +0900
Message-ID: <87ham7jahr.fsf@sejong.aot.lge.com>
References: <1358934288.36342.YahooMailNeo@web171503.mail.ir2.yahoo.com>
	<1358934556.33108.YahooMailNeo@web171501.mail.ir2.yahoo.com>
	<1898984.QcIki0Uqq8@minime>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:63659 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab3AXHjS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 Jan 2013 02:39:18 -0500
In-Reply-To: <1898984.QcIki0Uqq8@minime> (Milian Wolff's message of "Wed, 23
	Jan 2013 14:17:03 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 23 Jan 2013 14:17:03 +0100, Milian Wolff wrote:
> On Wednesday 23 January 2013 09:49:16 dark_footix wrote:
>> If I am interested to start a development of an graphic interface to visual
>> the result, do you have some result of log which one I could parse ? which
>> could be the formalism of the result ?
>> 
>> What is the best way to develop this kind of feature ?
>> Does it already exist ?
>
> I think what we need is a proper public perf library to parse its generated 
> data. That would then allow one to integrate Perf into KCacheGrind or similar 
> which would give one a really nice GUI. Though a timeline GUI similar to what 
> VTune offers would be very interesting as well. Afaik it does not exist yet.

There's a gtk+ GUI support in the mainline perf tools.  You can improve
it as you wish. ;-)

Thanks,
Namhyung
