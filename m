From: Bram Stolk <b.stolk@gmail.com>
Subject: Adding a recording delay interferes with symbols/call-stack
Date: Mon, 30 Oct 2017 13:25:08 -0700
Message-ID: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:51428 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdJ3UZJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Oct 2017 16:25:09 -0400
Received: by mail-vk0-f52.google.com with SMTP id v3so4208649vkb.8
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2017 13:25:09 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

If I record with callstacks like this:

$ perf record --freq 2000 --call-graph dwarf ./bench

then it works just fine: I see callstacks, and symbols in the report.

If I delay the recording by 1 second with the --delay flag, like this:

$ perf record --delay=1000 --freq 2000 --call-graph dwarf ./bench

Then I lose all callstack information, and even all symbol information
on my program in the report.

Is this a known issue, that --delay interferes with symbol resolution?

Thanks!

  Bram

PS: I am on 64b Ubuntu, and perf version 4.4.87

-- 
Owner/Director of Game Studio Abraham Stolk Inc.
Vancouver BC, Canada
b.stolk@gmail.com
