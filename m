From: Johan Tibell <johan.tibell@gmail.com>
Subject: Re: Symbols not decoded in 0.0.2.PERF
Date: Wed, 20 Apr 2011 10:55:10 +0200
Message-ID: <BANLkTin0pLU3aGzj8m+4xUeBy5jCNFCLcQ@mail.gmail.com>
References: <BANLkTike-f9qjdtjce+uiAPrjXgucn=5xQ@mail.gmail.com> <BANLkTimUitmGOJKMk+YOgXOFNHiLCJCSGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59029 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab1DTIza (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 Apr 2011 04:55:30 -0400
Received: by pzk9 with SMTP id 9so282830pzk.19
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Apr 2011 01:55:30 -0700 (PDT)
In-Reply-To: <BANLkTimUitmGOJKMk+YOgXOFNHiLCJCSGQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On Tue, Apr 19, 2011 at 5:58 PM, Johan Tibell <johan.tibell@gmail.com> wrote:
> On Tue, Apr 19, 2011 at 1:22 PM, Johan Tibell <johan.tibell@gmail.com> wrote:
>> * It could be the case that GHC is generating symbols that perf cannot
>> interpret somehow. If we can confirm this is the case we can try to
>> fix that.
>
> I spent the day making sure this is not the case. All the Haskell
> functions now have the correct (fingers crossed) .type and .size ELF
> directives:

Problem solved. There were indeed some functions that didn't have any
.size directives, making perf (or is that objdump?) fail to recognize
the symbols.

Sorry for the noise.

Johan
