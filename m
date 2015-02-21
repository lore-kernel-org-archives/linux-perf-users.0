From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Bizarre results from perf event API
Date: Sat, 21 Feb 2015 17:59:36 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1502211758120.24085@vincent-weaver-1.umelst.maine.edu>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com> <54E7D3B3.7020108@gmail.com> <CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:50219 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbbBUW4U (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 21 Feb 2015 17:56:20 -0500
Received: by mail-qg0-f41.google.com with SMTP id i50so19501147qgf.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Feb 2015 14:56:19 -0800 (PST)
In-Reply-To: <CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin Moody <benjamin.moody@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

On Sat, 21 Feb 2015, Benjamin Moody wrote:


> there are grandchild processes involved.  (And I can't help thinking
> the first version is a lot more elegant!)  Does the kernel somehow get
> confused because enable_on_exec is set and the original process hasn't
> actually exec'ed anything?

Have you tried enabling the "inherit_stat" flag to see if that helps?

Vince
