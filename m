From: Geoffrey Blake <geoffrey.w.blake@gmail.com>
Subject: Profiling Java code running on Sun HotSpot JVM with linux perf
Date: Tue, 30 Aug 2011 15:03:34 -0500
Message-ID: <CACiFetRWM4nmfAhB1J6dSSJdiQnCqov8XQYHqrSuxSiMrWoLFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52162 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411Ab1H3UDf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Aug 2011 16:03:35 -0400
Received: by bke11 with SMTP id 11so1875bke.19
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Aug 2011 13:03:34 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am trying to profile some java server applications using %>perf
record -a, and as expected the majority of the execution time of these
applications is spent within jit'ed java code.=A0 According to these
lists, the jit should be outputting a /tmp/perf-$pid.map file for each
thread being jit'ed.=A0 The Sun JIT does not seem to have this output
enabled by default.=A0 Does anyone here know what options I need to set
on the command line to get the JVM to output the symbol map files from
the JIT?

Thanks,
Geoff Blake
