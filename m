From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf tools: Add rootfs option for off-box analysis using
 specified tree
Date: Sun, 21 Nov 2010 14:34:55 -0200
Message-ID: <20101121163455.GA4024@ghostprotocols.net>
References: <1290356275-9969-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55033 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab0KUQfA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Nov 2010 11:35:00 -0500
Received: by gwb20 with SMTP id 20so889030gwb.19
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Nov 2010 08:35:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290356275-9969-1-git-send-email-y>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
Cc: linux-perf-users@vger.kernel.org, David Ahern <daahern@cisco.com>

Em Sun, Nov 21, 2010 at 09:17:55AM -0700, y@cisco.com escreveu:
> From: David Ahern <daahern@cisco.com>
> 
> The rootfs argument allows analysis of perf.data file using a locally
> accessible filesystem tree with debug symbols - e.g.,  loop mounted
> KVM disk images, NFS, USB keys, initrds, etc. Anything with an OS tree
> can be analyzed from anywhere without the need to populate a local
> data store with build-ids.

Patch looks sane after quick look, just in doubt if "rootfs" is a good
name for this, will look if this can be somehow combined with the kvm
parameters.

Anybody else with cycles to think about this?

- Arnaldo
