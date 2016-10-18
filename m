From: Jonas Wagner <jonas.wagner@epfl.ch>
Subject: Re: Problems with -b, and confusing error messages
Date: Tue, 18 Oct 2016 18:04:35 +0200
Message-ID: <CAMRJFfJyydRegQTt=78cD+nRswr7up78JO=e8=sk4PiYdfhRxQ@mail.gmail.com>
References: <CAMRJFfLVEHrJ3zqExY=SMzuw8TS7V5A4sy5N2vW9moL=uYvYvg@mail.gmail.com>
 <20161005111131.GO7143@kernel.org> <CAMRJFfJeM8XGeNVzzhDom7zoB6fAsFgZrYY69UnW0H2C8Bu0tw@mail.gmail.com>
 <20161006161810.GA4809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54435 "EHLO smtp0.epfl.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964914AbcJRQFX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2016 12:05:23 -0400
Received: by mail-wm0-f47.google.com with SMTP id c78so2152482wme.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Oct 2016 09:05:16 -0700 (PDT)
In-Reply-To: <20161006161810.GA4809@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jonas Wagner <jonas.wagner@epfl.ch>, linux-perf-users@vger.kernel.org

Hi,

> This smells like a problem that could have been fixed, in the kernel, at
> a later version, would it be possible to grab a clone of Linus's tree:

I can confirm that the problem is gone when using a custom-compiled
4.8.0-25 kernel. Unfortunately I'm on a deadline right now and can't
do a lot of bisecting to find the reason for that.

But anyway, thanks a lot for the advice of compiling/installing a newer kernel!

Best,
Jonas
