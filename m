From: =?ISO-8859-1?Q?Jos=E9_Sim=E3o?= <jose.m.simao@gmail.com>
Subject: ratio of progress of the counters
Date: Thu, 31 Oct 2013 16:39:20 +0000
Message-ID: <CAJ38vxtu6nsNU8m_kWecJKVKs8ArBmaR2DF3iXmcE=pUQoxEEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:56581 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3JaQjV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 31 Oct 2013 12:39:21 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so757162lab.25
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2013 09:39:20 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear all,

I'm trying to collect ASCII-based progress information regarding a set
of performance counters. "Progress" means, for example, the ratios of
values/second (e.g. page faults/seconds).

I can get information in this form using 'perf stat' but 'stat' only
gives me the final value. I would like to collect, or calculate,
theses values from the running command and determine how these metrics
evolved over time (i.e. faster or slower).

Is this possible (or eventually trivial) with the perf tool?

Thank you,
Jos=E9
