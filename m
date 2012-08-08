From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] perf: Add a new sort order: SORT_INCLUSIVE (v6)
Date: Wed, 8 Aug 2012 15:37:18 -0700
Message-ID: <5022EA1E.3010306@fb.com>
References: <1333172421-6775-2-git-send-email-asharma@fb.com> <4F769976.3070203@fb.com> <5022BB0E.8050706@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5022BB0E.8050706@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 8/8/12 12:16 PM, Arun Sharma wrote:

>     and therefore breaks the invariant period == period_self
>     in the default mode (no sort inclusive).


hist_entry__decay() also needs an update to maintain the invariant.

--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -138,6 +138,7 @@ static void hist_entry__add_cpumode_period(struct 
hist_entry *he,
  static void hist_entry__decay(struct hist_entry *he)
  {
         he->period = (he->period * 7) / 8;
+       he->period_self = (he->period_self * 7) / 8;
         he->nr_events = (he->nr_events * 7) / 8;
  }

  -Arun
