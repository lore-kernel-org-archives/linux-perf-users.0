From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: perf Hacktograms
Date: Thu, 10 Jul 2014 13:09:28 -0700
Message-ID: <CAE40pddW1J2UGSgKU18HyHPS2Pwjius3Bt3CJW8Sjfbv4cAH5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:61498 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaGJUJ3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Jul 2014 16:09:29 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so82011qac.21
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2014 13:09:28 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day perf users,

You might find this interesting -- using perf_events to do in-kernel histograms:

http://www.brendangregg.com/blog/2014-07-10/perf-hacktogram.html

It's a hack, and probably short-term too. If extended BPF lands, I'd
probably do this using BPF tables...

Brendan
-- 
http://www.brendangregg.com
