From: Kiran T <kiran.lkml@gmail.com>
Subject: How to use PERF_RECORD_MMAP
Date: Mon, 27 Nov 2017 12:27:54 -0800
Message-ID: <CABUc5FFGkqn1kS9p=_ZmfuMEn-jhkJc60yvtC3eEjuw7HcHbeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:41179 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbdK0U14 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Nov 2017 15:27:56 -0500
Received: by mail-wm0-f45.google.com with SMTP id b189so36636284wmd.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2017 12:27:55 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,
Man pages/documentation is not clear on how to use PERF_RECORD_MMAP .
Dummy event did not record this -- probably need a qualifier to add
sample_id_all?  ( Of course I could create a custom program with
perf_event_open.  But wanted to use perf if possible.)

Thanks,
Kiran
