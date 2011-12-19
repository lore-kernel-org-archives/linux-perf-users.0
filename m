From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH 3/6] perf: add ability to record event period
Date: Mon, 19 Dec 2011 14:25:45 -0700
Message-ID: <4EEFABD9.9050203@gmail.com>
References: <1323266161-394927-1-git-send-email-avagin@openvz.org> <1323266161-394927-4-git-send-email-avagin@openvz.org> <4EEAEF83.3080100@gmail.com> <20111219205829.GB28058@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44041 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab1LSVZv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Dec 2011 16:25:51 -0500
In-Reply-To: <20111219205829.GB28058@infradead.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Andrew Vagin <avagin@gmail.com>, Andrew Vagin <avagin@openvz.org>, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu, asharma@fb.com, devel@openvz.org, linux-perf-users@vger.kernel.org

On 12/19/2011 01:58 PM, Arnaldo Carvalho de Melo wrote:
> I get that Arun is in agreement, everything seems OK, but we need to do
> a better job on describing why we add code, the context we have now from
> all these discussions will be mostly lost, say, 5 years from now when we
> try to figure out why something was done in some way,

It seems like an option is needed for all the sample attributes.
Timestamp is now covered (-T). Sample address is covered (-d). Callchain
(-g). This targets period (-P). I think that just leaves CPU, and we are
out of c/C options. ;-)

David
