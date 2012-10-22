From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf top -z not working?
Date: Sun, 21 Oct 2012 18:46:18 -0700
Message-ID: <20121022014618.GA7924@ghostprotocols.net>
References: <507EA40D.60206@cs.utoronto.ca>
 <507EB776.9030304@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:34043 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688Ab2JVBqX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Oct 2012 21:46:23 -0400
Received: by mail-gh0-f174.google.com with SMTP id g15so391024ghb.19
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Oct 2012 18:46:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <507EB776.9030304@core.kaist.ac.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chulmin Kim <cmkim@core.kaist.ac.kr>
Cc: linux-perf-users@vger.kernel.org, Ryan Johnson <ryan.johnson@cs.utoronto.ca>

Em Wed, Oct 17, 2012 at 10:49:42PM +0900, Chulmin Kim escreveu:
> 2012-10-17 =EC=98=A4=ED=9B=84 9:26, Ryan Johnson =EC=93=B4 =EA=B8=80:
> >(Please CC me in replies, not a list member)
> >
> >It seems that `perf top -z' does not behave as advertized, at
> >least not on the 3.2.0-25 kernel (Ubuntu) that I'm running. The
> >man page states that it should "zero history across display
> >updates" but the counts still seem to accumulate (the total
> >samples reported rises monotonically) and processes still show up
> >in the display long after they have exited. Pressing `z' or `Z'
> >seems to have no effect, either.

Are you using the --tui or --stdio interface? Try with both and check i=
f
it works in one of them, I bet the problem is with --tui.

- Arnaldo
