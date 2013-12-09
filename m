From: Mohammed Riyaz <riyaz.list@gmail.com>
Subject: Re: Measuring worst case interrupt processing time
Date: Mon, 9 Dec 2013 04:17:33 -0800
Message-ID: <CAL7o8iu+cM1x+NnNWvtjVjJLRdB2q5f==-0nmzfhX02BjUxcjA@mail.gmail.com>
References: <CAL7o8itUf0wOj-f7LEF=EfydzimOkpi1VrTZXVE0VvECNP0VPQ@mail.gmail.com>
	<52A5A8D6.6020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47]:60406 "EHLO
	mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932532Ab3LIMRe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Dec 2013 07:17:34 -0500
Received: by mail-qe0-f47.google.com with SMTP id t7so2623102qeb.6
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2013 04:17:33 -0800 (PST)
In-Reply-To: <52A5A8D6.6020401@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: JJ Hiblot <jjhiblot@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, Dec 9, 2013 at 3:26 AM, JJ Hiblot <jjhiblot@gmail.com> wrote:
> I used to do this kind of measurement with a GPIO and an oscilloscope set up
> in persistence mode. In this case ,the precision of  the measure doesn't
> depend of the timer's resolution.

Though not suitable for my setup, never thought of using h/w for such
measurements. Interesting.

Thanks
Riyaz
