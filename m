From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf tools: Add rootfs option for off-box analysis using
 specified tree
Date: Sun, 21 Nov 2010 16:12:34 -0200
Message-ID: <20101121181234.GA4056@ghostprotocols.net>
References: <1290356275-9969-1-git-send-email-y>
 <20101121163455.GA4024@ghostprotocols.net>
 <4CE950A0.2060705@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42368 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab0KUSMl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Nov 2010 13:12:41 -0500
Received: by yxf34 with SMTP id 34so3647355yxf.19
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Nov 2010 10:12:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE950A0.2060705@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "David S. Ahern" <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org

Em Sun, Nov 21, 2010 at 10:02:24AM -0700, David S. Ahern escreveu:
> 
> 
> On 11/21/10 09:34, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Nov 21, 2010 at 09:17:55AM -0700, y@cisco.com escreveu:
> >> From: David Ahern <daahern@cisco.com>
> >>
> >> The rootfs argument allows analysis of perf.data file using a locally
> >> accessible filesystem tree with debug symbols - e.g.,  loop mounted
> >> KVM disk images, NFS, USB keys, initrds, etc. Anything with an OS tree
> >> can be analyzed from anywhere without the need to populate a local
> >> data store with build-ids.
> > 
> > Patch looks sane after quick look, just in doubt if "rootfs" is a good
> > name for this, will look if this can be somehow combined with the kvm
> > parameters.
> 
> I do want to have the ability to analyze a KVM hosted VM using an
> external tree as well. e.g., --guestmount points to an sshfs mount and
> --rootfs points to a tree with symbols for the stripped image running in
> the VM.

So perhaps --symfs would be better? "root" seems vague here.
 
- Arnaldo
