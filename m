From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: what is the default frequency and default event period set in "perf
 record -TP"
Date: Wed, 6 Nov 2013 18:52:30 -0500
Message-ID: <CAEuYUeqNq9jox_-j-P-XhSCxvK5o=F+UYutP-=3KPESuUDXgGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:60243 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3KFXwb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Nov 2013 18:52:31 -0500
Received: by mail-qa0-f41.google.com with SMTP id k4so2841920qaq.14
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2013 15:52:30 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>, David Ahern <dsahern@gmail.com>

Hi all/David,

I want to know the frequency in the following command:
        perf record -e cycles -e cache-misses -e cache-references -TP
-o abc.data command

I looked up in the perfwiki, and it says the default value is 1000.
However, when I specify this parameter in the above command,that is,
"perf record -e cycles -e cache-misses -e cache-references -TP -F 1000
-o abc.data command", I found a significant difference between the
file data size.

Using the first command, the size of "abc.data" is about 500MB, but
the second command could generate the raw data size up to over 10GB.


I could not figure out the reason. Is it might because sampling mode
of cycles is based on frequency while the other two events are based
on event period?


Best wishes.
Yours,
Wang Peipei
