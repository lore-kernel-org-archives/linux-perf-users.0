From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: how to get a kernel callgraph starting from a syscall
Date: Thu, 21 Apr 2011 22:07:08 +0200
Message-ID: <BANLkTimZA6YA07d8hNKuxhoySvHpTmWjvw@mail.gmail.com>
References: <BANLkTikNDX4hYpLjgDnPx8SXFvsv8Syr9g@mail.gmail.com>
	<4DB04BF3.8080206@gmail.com>
	<BANLkTinvMLaL8vdDWiG5fDEEAXUNBsyrBQ@mail.gmail.com>
	<4DB08A5B.3060706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:61687 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab1DUUHJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Apr 2011 16:07:09 -0400
Received: by pxi2 with SMTP id 2so45191pxi.10
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Apr 2011 13:07:08 -0700 (PDT)
In-Reply-To: <4DB08A5B.3060706@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, Apr 21, 2011 at 9:49 PM, David Ahern <dsahern@gmail.com> wrote:
>
> You want the individual samples? if so, perf script dumps them and you
> can see the callchain for each sys_read.
>

hmm, I don't see what you mean by individual samples.

I don't think sampling can help in my case (tracing the callchain of
one syscall).

Could you give me an example of what you have in mind ?

Thanks
-- 
Francis
