From: Bram Stolk <b.stolk@gmail.com>
Subject: Wildly different output sizes between subsequent perf record runs.
Date: Fri, 3 Nov 2017 18:57:01 -0700
Message-ID: <CABYXEkvrMhd9+P01k94AE97YHooDcs8Nxn4UfuvKfzzq88foVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:44553 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdKDB5D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Nov 2017 21:57:03 -0400
Received: by mail-ua0-f176.google.com with SMTP id f46so3137001uae.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Nov 2017 18:57:02 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

If I do subsequent runs of 'perf record', both of which are identical,
I sometimes get wildly different output sizes.


https://gist.github.com/stolk/3666b2b4d4319764fdff4a2d4c619782

The binary did the same amount of work, and took the same amount of
time to execute.
This is with using perf from Ubuntu LTS.
