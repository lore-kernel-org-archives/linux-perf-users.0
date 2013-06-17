From: Yuanfang Chen <tabloid.adroit@gmail.com>
Subject: perf record: per-event sampling period
Date: Mon, 17 Jun 2013 14:18:52 -0400
Message-ID: <CAN1HeCdeoNs4rPcLVcJGbcrJhmzjhd9AkJfx2WSPAwJJ_XugMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:53743 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3FQSSx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Jun 2013 14:18:53 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so3067783pdj.28
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jun 2013 11:18:52 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

Is the per-event sampling period supported now? I'm searching around,
found [1] using "-c 100,1000" method, [2] using
"cpu/----/period=1000". However, neither of these work in my box
(fedora 18, 3.8.11-200.fc18.x86_64, with perf package from fedora 18
repo ).

thanks,
yuanfang

[1]https://lkml.org/lkml/2010/11/23/122
[2]http://cscads.rice.edu/workshops/summer-2012/slides/performance-tools/CSCADS_2012_perf_events_status_update.pdf
