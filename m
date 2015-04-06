From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Translation to File name in sys_enter_open
Date: Mon, 6 Apr 2015 15:38:23 +0530
Message-ID: <CAGAANTWqLq4j-2rn=FPxOYw-dgG-2ed-JZfiQy76zB7WU4iA4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34859 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbbDFKIY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 6 Apr 2015 06:08:24 -0400
Received: by obbfy7 with SMTP id fy7so33898510obb.2
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Apr 2015 03:08:23 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi

I enabled sampling on tracepoint sys_enter_open but filename field
returned is address to filename as being passed to the system call,
how i can translate this to actual file name while reading ring
buffer.? How perf is doing it.?

Thanks
Regards
Sahil
