From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: How can I write a script and use perf script to process the record
 data periodically
Date: Wed, 14 Aug 2013 17:19:22 -0400
Message-ID: <CAEuYUep7Ph+QnOonkvEAropiUqCFV9e-DT9ygcP7LDNEyV6SMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:54516 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933191Ab3HNVTX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 14 Aug 2013 17:19:23 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so8260686veb.9
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2013 14:19:22 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>, David Ahern <dsahern@gmail.com>

Hi all,

I want to use perf script to process the data sampled by "perf record"
since it is huge overhead to just write down all the samples.
Processing the samples every minute is what I am desperate to do.

However, I don't know how to write such scripts, "perf script -l "
gives me no hints on this matter. Besides, I see a --Latency option,
is that the way I configure to run the script ??

Thanks for your time.


Yours,
Wang Peipei
