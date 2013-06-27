From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: How to get perf stat output and redirect to a file rather than screen
Date: Thu, 27 Jun 2013 13:47:11 -0400
Message-ID: <CAEuYUeqBE57QnF1rqk9G5tM58pXFVvpNP2GE4mQcvE0cLBgncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:35762 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab3F0RrM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 27 Jun 2013 13:47:12 -0400
Received: by mail-ea0-f179.google.com with SMTP id b15so569759eae.10
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2013 10:47:11 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>

Hi all.

I want to save the output of perf stat as a file, however, I 've tried
several ways, none of them works. Here is what I have tried.
My basic command is " timeout -s SIGINT 4s perf stat  -p 32098". That
is using perf stat to capture process 32098 for 4 seconds.

1) use --output

http://comments.gmane.org/gmane.linux.kernel.perf.user/911
Best wishes.
Yours,
Wang Peipei
