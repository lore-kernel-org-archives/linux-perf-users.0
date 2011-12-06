From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: [PATCH 3/7] perf: add ability to change event according to
 sample (v2)
Date: Tue, 6 Dec 2011 13:06:23 -0200
Message-ID: <20111206150623.GG10709@infradead.org>
References: <1322471015-107825-1-git-send-email-avagin@openvz.org>
 <1322471015-107825-4-git-send-email-avagin@openvz.org>
 <20111206141942.GE10709@infradead.org>
 <4EDE2D62.9050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51998 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933427Ab1LFPGh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 6 Dec 2011 10:06:37 -0500
Content-Disposition: inline
In-Reply-To: <4EDE2D62.9050802@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Andrew Vagin <avagin@openvz.org>, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu, asharma@fb.com, devel@openvz.org, linux-perf-users@vger.kernel.org

Em Tue, Dec 06, 2011 at 07:57:38AM -0700, David Ahern escreveu:
> Ditto on that comment.
> 
> I did not test it, but the logic is in the inverse of parse_sample so it
> should be correct.
> 
> Arnaldo: you could use remove the 2 comment lines on the commit since
> there are no logic impacts.
> 
> Reviewed-by: David Ahern <dsahern@gmail.com>

Thanks, will do that,

- Arnaldo
