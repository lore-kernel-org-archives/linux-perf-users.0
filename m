From: Freehill Christopher-RAT063 <RAT063@freescale.com>
Subject: perf event attrributes
Date: Wed, 27 Mar 2013 15:40:38 +0000
Message-ID: <0C53B16FB1F182409A7BA6DC928E7AFE1FDA4F@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:4301
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751671Ab3C0Pko convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Mar 2013 11:40:44 -0400
Received: from mail174-co1 (localhost [127.0.0.1])	by
 mail174-co1-R.bigfish.com (Postfix) with ESMTP id EE2E21000F5	for
 <linux-perf-users@vger.kernel.org>; Wed, 27 Mar 2013 15:40:43 +0000 (UTC)
Received: from CO1EHSMHS005.bigfish.com (unknown [10.243.78.230])	by
 mail174-co1.bigfish.com (Postfix) with ESMTP id 9077A5C00E6	for
 <linux-perf-users@vger.kernel.org>; Wed, 27 Mar 2013 15:40:41 +0000 (UTC)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi,

I am working on adding support in perf for many events for a particular=
 architecture.=A0 As it is, there are thousands of events to add, with =
potentially many more.=20

Instead of treating each event as a separate raw event number (e.g., "p=
erf stat -e rXXXXX ."), I wondering if there is any existing support in=
 the perf infrastructure to support event attributes? For example, if I=
 have an event that represents "DDR hits", meaning all accesses to DDR,=
 and I want to add support for DDR hits from a particular source, do I =
need to add a perf event for every possible source (e.g., "DDR access f=
rom source A", "DDR access from source B", .), or is=A0 there a way to =
specify attributes for the event, in order to keep the number of events=
 to a reasonable level, and also make it easier for the user? Something=
 like "perf stat -e rXXXXX -source A"

The "Source" =A0is one example of an attribute. There are several other=
s. If you wanted to add support for all of those variations without usi=
ng some kind of attribute, the number of events would be difficult to i=
mplement in a "flat" way, due to the huge number of events required. Al=
so, it seems not very useable.=20

On the perf wiki, I see mention of "sub-events" and "unit masks", which=
 could be applicable, but I cannot find any other info or examples on t=
hem, or see the related kernel code. I would like to use a kernel modul=
e to extend this, if possible.

Also, potentially related are modifiers (but it looks like those may no=
t be something I could extend). I'm not sure.

Any info or suggestions are appreciated.

Thanks,
Chris
