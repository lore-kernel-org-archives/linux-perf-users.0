From: Jan Kratochvil <jan.kratochvil@redhat.com>
Subject: Re: [PATCH 2/2] perf report: report module before querying
 isactivation in dwfl unwind
Date: Thu, 15 Jun 2017 21:20:53 +0200
Message-ID: <20170615192053.GA4615@host1.jankratochvil.net>
References: <20170602143753.16907-1-milian.wolff@kdab.com>
 <20170602143753.16907-2-milian.wolff@kdab.com>
 <20170602152508.GC7901@redhat.com>
 <20170605104720.GC28871@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbdFOTVA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2017 15:21:00 -0400
Content-Disposition: inline
In-Reply-To: <20170605104720.GC28871@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, acme@kernel.org

On Mon, 05 Jun 2017 12:47:20 +0200, Jiri Olsa wrote:
> On Fri, Jun 02, 2017 at 12:25:08PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jun 02, 2017 at 04:37:53PM +0200, Milian Wolff escreveu:
> > > The PC returned by dwfl_frame_pc may map into a not-yet-reported
> > > module. We have to report it before we continue unwinding. But when
> > > we query for the isactivation flag in dwfl_frame_pc, libdw will
> > > actually do one more unwinding step internally which can then break
> > > and lead to missed frames or broken stacks.
> > > 
> > > With libunwind we get e.g.:
> 
> sounds like a libdw design issue.. Jan is there a specific way
> to handle the case that Milian described?

I agree with the patch.

Just be aware for performance then the __report_module() call in entry() is no
longer useful as the '--pc' adjustment should never cross a module boundary.

Although for perf unwinding performance there is still a wide gap there
(such as caching the loaded modules for multiple backtraces.)


Thanks,
Jan
