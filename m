From: AmirReza Ghods <ar.ghods@gmail.com>
Subject: Does perf record support event multiplexing?
Date: Tue, 21 Jan 2014 13:34:15 -0500
Message-ID: <CAOJauOAJbbjP6kR_op4bzncDajjOZvN0YWf9+scYjpHrJeLTOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:50980 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144AbaAUSeP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 21 Jan 2014 13:34:15 -0500
Received: by mail-ie0-f182.google.com with SMTP id lx4so3281684iec.13
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2014 10:34:15 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I noticed that "perf record" does not calculate the true value for the
number of event's counts in the case of having more events than
hardware counters.
But in pef stat it does and there is a time interpolation algorithm
for estimating and correcting the true value.
Also I saw a patch for Perf's source code that implimented time
interpolation for Perf in record mode but it did not include in the
next official realses of Perf. I just want to know that is there any
technical difficulty for implimenting this feature in "perf record" or
not?


Thanks in advanced,
Amir
