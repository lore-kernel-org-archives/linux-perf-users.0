From: Mohammed Riyaz <riyaz.list@gmail.com>
Subject: Measuring worst case interrupt processing time
Date: Sun, 8 Dec 2013 05:18:06 -0800
Message-ID: <CAL7o8itUf0wOj-f7LEF=EfydzimOkpi1VrTZXVE0VvECNP0VPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:61533 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3LHNSH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 8 Dec 2013 08:18:07 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so1871014qap.4
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Dec 2013 05:18:06 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am working on trying to measure the worst case processing time for
hard IRQ and soft IRQ. Well, I understand that we could use time
stamps at entry and exit to measure this. Just wanted to know if there
were other standard ways of measuring this. Any suggestions?

Thanks

Riyaz
