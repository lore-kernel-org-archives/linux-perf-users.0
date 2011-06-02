From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] Add an unresolved symbol for deleted binaries
Date: Thu, 2 Jun 2011 16:24:27 -0300
Message-ID: <20110602192427.GC21739@ghostprotocols.net>
References: <20110511010305.GA4324@dev1756.snc6.facebook.com>
 <20110602192018.GA21739@ghostprotocols.net>
 <20110602192249.GB21739@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60057 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab1FBTYg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 2 Jun 2011 15:24:36 -0400
Received: by ywe9 with SMTP id 9so481471ywe.19
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2011 12:24:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110602192249.GB21739@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Jun 02, 2011 at 04:22:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jun 02, 2011 at 04:20:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> > The first patch is fine (dso->deleted) and I applied it, thanks.
> 
> oops, it has a problem as well, we can't set ->deleted when we just
> didn't found a symtab (stripped binary) fixing that.

oops, also we were setting it in map__load _after_ calling dso__load
that assumes it was already set, fixing that as well.

- Arnaldo
