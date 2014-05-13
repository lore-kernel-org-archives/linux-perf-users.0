From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Referencing perf?
Date: Tue, 13 May 2014 10:24:06 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1405131021440.24957@vincent-weaver-1.umelst.maine.edu>
References: <536E67D3.2030604@bsc.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:45432 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933243AbaEMOUW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 13 May 2014 10:20:22 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so464726qgd.32
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2014 07:20:21 -0700 (PDT)
In-Reply-To: <536E67D3.2030604@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org

On Sat, 10 May 2014, Harald Servat wrote:

>   which is the appropriate way to reference perf in a publication?

That's a good question.

The original authors are T. Gleixner and I. Molnar, but they've never 
published a real document about it.  You could try citing the
   tools/perf/design.txt document that comes with the Linux kernel,
or also the git commit 0793a61d4df8daeac6492dbf8d2f3e5713caae5e
from Thu Dec 4 2008 that introduced perf_event to the world.

I'm not sure if there is an official way to cite a git commit.

Vince
