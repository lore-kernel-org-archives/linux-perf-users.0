From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: Bizarre results from perf event API
Date: Sun, 22 Feb 2015 20:12:26 +0000
Message-ID: <CAAk6P0V0QyCtBTi+zULhK_wwSQLN3xsLZq0uXWaBFkjar3BmWQ@mail.gmail.com>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
	<54E7D3B3.7020108@gmail.com>
	<CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com>
	<alpine.DEB.2.11.1502211758120.24085@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33517 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbBVUM1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 22 Feb 2015 15:12:27 -0500
Received: by iecar1 with SMTP id ar1so19082657iec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Feb 2015 12:12:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1502211758120.24085@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

On 2/21/15, Vince Weaver <vincent.weaver@maine.edu> wrote:
> On Sat, 21 Feb 2015, Benjamin Moody wrote:
>
>
>> there are grandchild processes involved.  (And I can't help thinking
>> the first version is a lot more elegant!)  Does the kernel somehow get
>> confused because enable_on_exec is set and the original process hasn't
>> actually exec'ed anything?
>
> Have you tried enabling the "inherit_stat" flag to see if that helps?

That does seem to help for the simple case I posted.  It doesn't work
in all cases, though.  I'll have to experiment a bit to find a simple
example.

My impression was that the inherit_stat bit shouldn't matter if we are
only interested in aggregate event counts, as opposed to counting
events per thread (found a ML thread about this a while ago but I
can't find it right now.)  Please correct me if I'm wrong.  In any
case, though, the perf tool doesn't use that bit.

Benjamin
