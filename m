From: Hyojong Kim <hkim606@gmail.com>
Subject: perf events (node-loads, node-load-misses, ...)
Date: Mon, 1 May 2017 13:03:41 -0400
Message-ID: <CAC8SZUvZKWkniGBZE_afeNPJT2_9OnKBOudHWHJ_aHNmCbs1Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35355 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbdEARE2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 May 2017 13:04:28 -0400
Received: by mail-pg0-f46.google.com with SMTP id o3so42159471pgn.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 May 2017 10:04:28 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

My processor has several hardware cache events, of which I am
interested in node-loads, node-load-misses, node-stores,
node-store-misses. I think it is kind of obvious that node-loads and
node-stores represent references to local memory (memory physically
attached to a processor package). However, I have no clue as to what
the rest represents. I have some theory that "node-load-misses"
represent the number of misses in local memory, or the number of
accesses to disk. Based on the profiled results I have
(page-faults:16M << node-load-misses+node-store-misses:748M), however,
this cannot be the raw number of disk accesses. Maybe some kind of
piggybacking mechanism (by some MSHR kind of structure in memory?)
could be the reason behind this discrepancy, but no clue. If anyone
has some idea on this, please share it with me.

I appreciate your help in advance!

Sincerely,
- Hyojong
