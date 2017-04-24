From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v6] Allow user probes on versioned symbols
Date: Mon, 24 Apr 2017 13:34:23 -0300
Message-ID: <20170424163423.GD2742@kernel.org>
References: <27b85625-3134-9d2e-8501-36f4c2e4dbf5@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S974732AbdDXQei (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Apr 2017 12:34:38 -0400
Content-Disposition: inline
In-Reply-To: <27b85625-3134-9d2e-8501-36f4c2e4dbf5@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Paul Clarke <pc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

Em Thu, Apr 13, 2017 at 12:03:13PM -0500, Paul Clarke escreveu:
> v4:
> - rebased to acme/perf/core

Are you sure?

[acme@jouet linux]$ patch -p1 < /wb/1.patch 
patching file tools/perf/arch/powerpc/util/sym-handling.c
Hunk #1 FAILED at 52.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/arch/powerpc/util/sym-handling.c.rej
patching file tools/perf/util/map.c
Hunk #1 FAILED at 325.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/map.c.rej
patching file tools/perf/util/map.h
Hunk #1 FAILED at 130.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/map.h.rej
patching file tools/perf/util/symbol.c
Hunk #1 FAILED at 87.
Hunk #2 FAILED at 396.
Hunk #3 FAILED at 411.
Hunk #4 FAILED at 424.
Hunk #5 FAILED at 500.
5 out of 5 hunks FAILED -- saving rejects to file tools/perf/util/symbol.c.rej
patching file tools/perf/util/symbol.h
Hunk #1 FAILED at 348.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/symbol.h.rej
[acme@jouet linux]$ 
