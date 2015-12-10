From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Thu, 10 Dec 2015 13:49:49 +0900
Message-ID: <20151210044949.GD13790@sejong>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209134138.GB15864@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:57069 "EHLO
	lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbbLJEvT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 23:51:19 -0500
In-Reply-To: <20151209134138.GB15864@kernel.org>
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@plumgrid.com>

Hi Arnaldo and Masami,

On Wed, Dec 09, 2015 at 10:41:38AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 09, 2015 at 11:10:48AM +0900, Masami Hiramatsu escreveu:
> > In this series I've also tried to fix some object leaks in perf top
> > and perf stat.
> > After applying this series, this reduced (not vanished) to 1/5.
> >   ----
> >   # ./perf top --stdio
> >   q
> >   exiting.
> >   REFCNT: BUG: Unreclaimed objects found.
> >   REFCNT: Total 866 objects are not reclaimed.
> >     "dso" leaks 213 objects
> >     "map" leaks 624 objects
> >     "comm_str" leaks 12 objects
> >     "thread" leaks 9 objects
> >     "map_groups" leaks 8 objects
> >      To see all backtraces, rerun with -v option
> >   ----
> > 
> > Actually, I'm still not able to fix all of the bugs. It seems that
> > hists has a bug that hists__delete_entries doesn't delete all the
> > entries because some entries are on hists->entries but others on
> > hists->entries_in. And I'm not so sure about hists.c.
> > Arnaldo, would you have any idea for this bug?
> 
> I'll will audit the hists code, its all about collecting new entries
> into an rbtree to then move the last batch for merging with the
> previous, decayed ones while continuing to process a new batch in
> another thread.

Right.  After processing is done, hist entries are in both of
hists->entries and hists->entries_in (or hists->entries_collapsed).
So I guess perf report does not have leaks on hists.

But for perf top, it's possible to have half-processed entries which
are only in hists->entries_in.  Eventually they will go to the
hists->entries and get freed but they cannot be deleted by current
hists__delete_entries().  If we really care deleting all of those
half-processed entries, how about this?

Thanks,
Namhyung



diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fd179a068df7..08396a7fea23 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -270,6 +270,8 @@ static void hists__delete_entry(struct hists *hists, struct hist_entry *he)
 
 	if (sort__need_collapse)
 		rb_erase(&he->rb_node_in, &hists->entries_collapsed);
+	else
+		rb_erase(&he->rb_node_in, hists->entries_in);
 
 	--hists->nr_entries;
 	if (!he->filtered)
@@ -1589,11 +1591,33 @@ int __hists__init(struct hists *hists)
 	return 0;
 }
 
+static void hists__delete_remaining_entries(struct rb_root *root)
+{
+	struct rb_node *node;
+	struct hist_entry *he;
+
+	while (!RB_EMPTY_ROOT(root)) {
+		node = rb_first(root);
+		rb_erase(node, root);
+
+		he = rb_entry(node, struct hist_entry, rb_node_in);
+		hist_entry__delete(he);
+	}
+}
+
+static void hists__delete_all_entries(struct hists *hists)
+{
+	hists__delete_entries(hists);
+	hists__delete_remaining_entries(&hists->entries_in_array[0]);
+	hists__delete_remaining_entries(&hists->entries_in_array[1]);
+	hists__delete_remaining_entries(&hists->entries_collapsed);
+}
+
 static void hists_evsel__exit(struct perf_evsel *evsel)
 {
 	struct hists *hists = evsel__hists(evsel);
 
-	hists__delete_entries(hists);
+	hists__delete_all_entries(hists);
 }
 
 static int hists_evsel__init(struct perf_evsel *evsel)
