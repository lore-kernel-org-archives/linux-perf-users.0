From: Luke Gorrie <luke@snabb.co>
Subject: Re: First time user, problem with toplev.py levels (-l)
Date: Wed, 25 Sep 2013 19:18:55 +0200
Message-ID: <CAA2XHbdK5UR8G-rUkvaPP=B=YJaR3n+381o4tzRkLZh16POEoQ@mail.gmail.com>
References: <CAA2XHbcy6qSvm_s=XPdp3GuXHgTAQqtiDZ1cgvM5rZMF9f00RQ@mail.gmail.com>
	<87ob7gsz42.fsf@tassilo.jf.intel.com>
	<CAA2XHbfK5qkf6UERFu_zLK5NEA+ZSs3=2QCeZ3MvkSceY9bxqg@mail.gmail.com>
	<20130925155416.GJ18242@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:65024 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab3IYRS5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Sep 2013 13:18:57 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so2433405bkb.3
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2013 10:18:56 -0700 (PDT)
In-Reply-To: <20130925155416.GJ18242@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 25 September 2013 17:54, Andi Kleen <andi@firstfloor.org> wrote:
> toplev doesn't have a detailed model for SandyBridge-E currently,
> that is why only level 1 is enabled.

Ah, I see.

> You could force snb in the code for jkt (the table at line 175+), but some
> of the estimated latencies would be a bit off and it would not
> support NUMA.

Thanks for the tip. I tried FORCECPU=snb and now it appears I at least
have something to play with :-).

Cheers,
-Luke
