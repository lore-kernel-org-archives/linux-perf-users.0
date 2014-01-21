From: David Li <android.wm.edu@gmail.com>
Subject: perf not working for some commands?
Date: Mon, 20 Jan 2014 21:58:15 -0500
Message-ID: <CACTzACVZLm00yVZag5Hf-c_u0tdH+cQT0=8B_XS8BrN5cT2mDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:55503 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaAUC6Q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 20 Jan 2014 21:58:16 -0500
Received: by mail-qe0-f53.google.com with SMTP id s1so2389329qeb.26
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2014 18:58:16 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi everyone,
I'd like to use perf to profile the monkey command on Android, but I
got stuck with this.

Normally, when I run following:

      monkey -v -p com.google.android.youtube 500

      -it works (it generates 500 user events for youtube)

BUT, when I want to get the perf stat of it as follows:

      perf stat monkey -v -p com.google.android.youtube 500

I get:

     monkey: No such file or directory
     Terminated


monkey is a command, not a file nor a directory. Why am I getting
this? Any help will be greatly appreciated!

Thank you.
David
