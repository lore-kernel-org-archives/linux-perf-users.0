From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] Add an unresolved symbol for deleted binaries
Date: Thu, 2 Jun 2011 16:22:50 -0300
Message-ID: <20110602192249.GB21739@ghostprotocols.net>
References: <20110511010305.GA4324@dev1756.snc6.facebook.com>
 <20110602192018.GA21739@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:47011 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab1FBTW5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 2 Jun 2011 15:22:57 -0400
Received: by yia27 with SMTP id 27so478160yia.19
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2011 12:22:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110602192018.GA21739@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Jun 02, 2011 at 04:20:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> The first patch is fine (dso->deleted) and I applied it, thanks.

oops, it has a problem as well, we can't set ->deleted when we just
didn't found a symtab (stripped binary) fixing that.

- Arnaldo
