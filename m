From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: Can perf be used to record cycles or instructions on Virtual Machine
Date: Wed, 26 Jun 2013 15:13:42 -0400
Message-ID: <CAEuYUeoCAOJAP4xvKWsFf4e-VJ0BuooO=i8_1qadva-1YFii5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:33578 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3FZTNn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Jun 2013 15:13:43 -0400
Received: by mail-vb0-f44.google.com with SMTP id e15so11156619vbg.17
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2013 12:13:42 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>

Hi, all.
I got a new problem.

When I use perf to get CPI( cycles per instruction) on a Virtual
Machine, I receive the message that
cycles and instructions are not supported.

However, other events like page-faults or context-switches can be
supported well.
I don't know why. So I guess I can't user perf to record a certain
sort of performance events on Virtual Machine.

Is my guess correct??  What kind of performance events in hell  aren't
supported?
Thanks for all your help.



Yours,
Wang Peipei
