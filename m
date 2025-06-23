Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0BD288511;
	Mon, 23 Jun 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706341; cv=none; b=Oap9rqKzbThZH5J0k0BZVrOnl3PKmmLABzpll4f6um8ZCfX4cjFahw25Zc0GzxGg9X3boVAjU9thp0hx8/GXNyE9ldhNJJV0eAbC9bxhVx33ASreiZiBaBiqGwxM8PFMkO/1/SifqIYB2G1jp7qh5JlDyKpbEMhJbk5diDdRGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706341; c=relaxed/simple;
	bh=Kbzxz2PSJrErSIphMGnNnRpgo/ytfR0oIkkJHEBXpTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7wDkirHmYvSJ6ddxH0DOX6R6uZPJRf1fR00smuZeDaiuJ81V+9SQUE01pybf12pa/teDGjld2OombqeSJ5L6YaDPqsOXxPwLqxr7vgE37vPmSOcdQ18n7Vr4uI0dQQKHOn3crECl5/ZETuZtfrzI+rzfVpg7dUXPbY2X/JSqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJRhowE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJRhowE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29CBC4CEEA;
	Mon, 23 Jun 2025 19:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750706341;
	bh=Kbzxz2PSJrErSIphMGnNnRpgo/ytfR0oIkkJHEBXpTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJRhowE2cpac0qUCMcjdUDtTr5jBXtonjTiJ8oqFGOOqzKUqcqu+CSBoUvUDcKuM3
	 n33DfJ8rZG2uK4b6gmQdDfuuDZe6Bu8xjLvbcHF8vhaoq6RFCXbCNSlRnvQrYYosTr
	 7Q/RHDaauyyyxy180Y6luY4vxOjOPsFv3UZefwm7CHhbddmVA9SPcbRg9densry8Mv
	 vIynVcaNeoJTBrFXYbveoLyMbv1/GDfuXiM5r9o2vmfmCcdLQktkcGllZJc2Ih/vNn
	 24dGDfEmjvCBrzU+RBR4DDjGs/7yhGwhl0CoP2iz3i+sxnsOBrtMDDwQFNOIISThWa
	 iGjI8pOd793FA==
Date: Mon, 23 Jun 2025 16:18:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf test workload noploop: Name the noploop
 process
Message-ID: <aFmooVYz-6p1DTSv@x1>
References: <20250619002034.97007-1-irogers@google.com>
 <aFW4VJtk96JD865U@google.com>
 <CAP-5=fUpnW1DE68pMW0q3vMT+n6d5SeNkwXd45XLaf01-eP47A@mail.gmail.com>
 <aFmSuSyZ1ZNT94Tq@x1>
 <CAP-5=fXms87LVH-Y5V3OpVbwUjY=hWAe0NTX4uKQf1q3Ax-WSA@mail.gmail.com>
 <aFmZl-SUT85Im8BJ@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFmZl-SUT85Im8BJ@google.com>

On Mon, Jun 23, 2025 at 11:14:47AM -0700, Namhyung Kim wrote:
> On Mon, Jun 23, 2025 at 11:05:41AM -0700, Ian Rogers wrote:
> > On Mon, Jun 23, 2025 at 10:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > On Mon, Jun 23, 2025 at 08:12:47AM -0700, Ian Rogers wrote:
> > > > On Fri, Jun 20, 2025 at 12:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > I'm afraid it'd introduce a build failure on musl.  Please see

> > > > > https://lore.kernel.org/linux-perf-users/20250611092542.F4ooE2FL@linutronix.de/

> > > > > I think <sys/prctl.h> would be enough.

> > > > we could do that but in the glibc man page it says:
> > > > https://man7.org/linux/man-pages/man2/prctl.2.html
> > > > ```
> > > > #include <linux/prctl.h>  /* Definition of PR_* constants */
> > > > #include <sys/prctl.h>
> > > > ```

> > > > It'd be nice to think musl was slowly getting fixed. I notice we're

> > > Sebastian reported on the musl libc, its maintainer replied:

> > > https://www.openwall.com/lists/musl/2025/06/12/11

> > Ugh. I'm not sure how we're expected to resolve this and have glibc
> > and musl be happy without basically not trusting libc.

> Maybe pthread_setname_np()?  It seems musl also implemented it.

⬢ [acme@toolbx perf-tools-next]$ git diff
diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
index 8b954d4660833a2f..656e472e618822a3 100644
--- a/tools/perf/tests/workloads/noploop.c
+++ b/tools/perf/tests/workloads/noploop.c
@@ -1,9 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <pthread.h>
 #include <stdlib.h>
 #include <signal.h>
 #include <unistd.h>
-#include <linux/prctl.h>
-#include <sys/prctl.h>
 #include <linux/compiler.h>
 #include "../tests.h"
 
@@ -18,7 +17,7 @@ static int noploop(int argc, const char **argv)
 {
        int sec = 1;
 
-       prctl(PR_SET_NAME, "perf-noploop");
+       pthread_setname_np(pthread_self(), "perf-noploop");
        if (argc > 0)
                sec = atoi(argv[0]);
 
⬢ [acme@toolbx perf-tools-next]$ 

⬢ [acme@toolbx perf-tools-next]$ perf test -w noploop &
[1] 1179763
⬢ [acme@toolbx perf-tools-next]$ ps
    PID TTY          TIME CMD
   3935 pts/1    00:00:00 bash
   4053 pts/1    00:00:00 toolbox
   4222 pts/1    00:00:28 podman
 971900 pts/1    00:00:00 bash
1100453 pts/1    00:00:00 tail
1160346 pts/1    00:00:00 bash
1179763 pts/1    00:00:00 perf-noploop
1179765 pts/1    00:00:00 ps
⬢ [acme@toolbx perf-tools-next]$

And then on one of the Alpine Linux containers:

make: Leaving directory '/tmp/perf-6.16.0-rc3/tools/perf'
/tmp/perf-6.16.0-rc3 $ cat /etc/os-release 
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.18.12
PRETTY_NAME="Alpine Linux v3.18"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
/tmp/perf-6.16.0-rc3 $ tools/perf/perf test -w noploop &
/tmp/perf-6.16.0-rc3 $ ps
PID   USER     TIME  COMMAND
    1 toolsbui  0:00 /bin/sh
 5693 toolsbui  0:00 {perf-noploop} tools/perf/perf test -w noploop
 5694 toolsbui  0:00 ps
/tmp/perf-6.16.0-rc3 $ 
[1]+  Done                       tools/perf/perf test -w noploop
/tmp/perf-6.16.0-rc3

There are more direct use of prctl() to set the name in tools/perf/,
using pthread_setname_np() seems cleaner :-)

- Arnaldo
