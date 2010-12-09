From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH-v2] perf tools: Add symfs option for off-box analysis
 using specified tree
Date: Thu, 9 Dec 2010 15:14:36 -0200
Message-ID: <20101209171436.GA13027@ghostprotocols.net>
References: <1291862020-24540-1-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44972 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab0LIROl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 9 Dec 2010 12:14:41 -0500
Content-Disposition: inline
In-Reply-To: <1291862020-24540-1-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Wed, Dec 08, 2010 at 07:33:40PM -0700, David Ahern escreveu:
> The symfs argument allows analysis of perf.data file using a locally
> accessible filesystem tree with debug symbols - e.g., tree created
> during image builds, sshfs mount, loop mounted KVM disk images,
> USB keys, initrds, etc. Anything with an OS tree can be analyzed from
> anywhere without the need to populate a local data store with
> build-ids.
> 
> Signed-off-by: David Ahern <daahern@cisco.com>
> 
> v1 --> v2: removed symfs changes from builtin-annotate.c
>            fixed tab/space inconsistencies
>            changed new strlen() to symbol_conf.symfs[0]
>            added symfs option to Documentation files

So I tried it now with:

perf report --symfs /

Which should be equivalent to the common case:

perf report

Bu kernel symbols didn't got resolved, can you please check this?

- Arnaldo
