From: Taeung Song <treeze.taeung@gmail.com>
Subject: [Suggestion] perf ftrace: pager support
Date: Thu, 26 Jan 2017 21:44:58 +0900
Message-ID: <fd065615-08f9-7327-2efa-4026ed8233cd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36324 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752293AbdAZMpF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Jan 2017 07:45:05 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so16414687pfo.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2017 04:45:02 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Hi, :)

If we run perf ftrace, all output is printed.
But if size of output is big, it is hard to slowly examine output(traced 
functions).

So I thought if perf-ftrace has pager support,
it would be better.

What do you think about this ? :)

Thanks,
Taeung
