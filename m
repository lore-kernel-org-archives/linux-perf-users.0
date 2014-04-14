From: Noah Luther <nluther@vt.edu>
Subject: perf branch
Date: Sun, 13 Apr 2014 23:55:53 -0400
Message-ID: <CAH+i1GK4QdEzoa05PUN-Zx8Gzr2-w0RY631a9MzvTvyMAs1fGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:60207 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaDNGuj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Apr 2014 02:50:39 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [198.82.164.236])
	by lennier.cc.vt.edu (8.13.8/8.13.8) with ESMTP id s3E3tx08009700
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Apr 2014 23:55:59 -0400
Received: from mail-ve0-f181.google.com (mail-ve0-f181.google.com [209.85.128.181])
	by mr4.cc.vt.edu (8.14.4/8.14.4) with ESMTP id s3E3trDv017385
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Apr 2014 23:55:59 -0400
Received: by mail-ve0-f181.google.com with SMTP id oy12so6781792veb.40
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Apr 2014 20:55:53 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I am trying to use perf to trace branches as described by the 'perf
branch' subcommand. Is there support through perf_event_open to access
the buffer storing branch traces? I saw Akihiro Nagai's presentation
on 'perf branch', but haven't yet figured out how to enable BTS and
access the buffer based on the documentation on this page:

http://web.eece.maine.edu/~vweaver/projects/perf_events/perf_event_open.html

If there are any resources that might be of use to me, I would
appreciate any assistance.

Thank you,
Noah
