From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: perf probe an addr without debuginfo
Date: Sat, 27 Jun 2015 12:06:24 -0700
Message-ID: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35615 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbbF0TGo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 27 Jun 2015 15:06:44 -0400
Received: by igblr2 with SMTP id lr2so31750742igb.0
        for <linux-perf-users@vger.kernel.org>; Sat, 27 Jun 2015 12:06:44 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day,

Is there a trick to getting perf to probe a user-level address without
debuginfo? Eg (on Linux 4.0):

# perf probe -x /root/tick '@+0x583'
Debuginfo-analysis is not supported.
  Error: Failed to add events.

I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
works. Thanks,

Brendan
