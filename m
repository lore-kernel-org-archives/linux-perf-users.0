From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: Bizarre results from perf event API
Date: Mon, 23 Feb 2015 23:13:24 +0000
Message-ID: <CAAk6P0W6MAV2Vi1HuFXJBKnpvo7W8UzFGtHgKsyTEYFbCeD05Q@mail.gmail.com>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
	<87sidwuzmf.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36960 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbbBWXNZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 Feb 2015 18:13:25 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so22388610iga.5
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Feb 2015 15:13:24 -0800 (PST)
In-Reply-To: <87sidwuzmf.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 2/23/15, Andi Kleen <andi@firstfloor.org> wrote:
> Benjamin Moody <benjamin.moody@gmail.com> writes:
>>
>>   pe.pinned = 1;                /* always track */
>
> You definitely don't want pinned

I'm fairly confident that I do, actually, but why do you say that?

In any case, these problems occur regardless of pinned-ness.

Benjamin
