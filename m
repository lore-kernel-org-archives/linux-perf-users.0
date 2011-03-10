From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: perf record regression?
Date: Thu, 10 Mar 2011 12:28:07 -0300
Message-ID: <20110310152807.GA23555@ghostprotocols.net>
References: <AANLkTikcz=_HX7Ws2Ojmky+JgQhk1cj2YW=uxSkYkXBQ@mail.gmail.com>
 <20110310144927.GF14438@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:58410 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1CJP2g (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Mar 2011 10:28:36 -0500
Content-Disposition: inline
In-Reply-To: <20110310144927.GF14438@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Mar 10, 2011 at 11:49:28AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 09, 2011 at 09:59:39PM -0800, Arun Sharma escreveu:
> > I pulled the perf/core branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux-2.6.git today
> > and found that:
> > 
> > perf record -ag -- sleep 1
> > perf report -D | grep dso:
> > 
> > was returning:
> > 
> >  ...... dso: <not found>
> >  ...... dso: <not found>
> >  ...... dso: /boot/vmlinux-2.6.38-rc5+
> > 
> > i.e perf report was not able to map IP addresses to the correct dso
> > for anything in user space.
> > perf built after these commits is able to symbolize properly for
> > perf.data collected using an older version of perf. So I believe, the
> > perf report side of things are ok. But perf record is not.
> 
> Thanks for bisecting, I noticed some problems yesterday and was trying
> to bisect it, but run into another bug, will investigate now.

Can you try with this one? Has the fix plus some simplifications.

The fix is to call perf_session__update_sample_type after we have the
perf_evsel created or read from the perf.data file. We need to do that
to cope with having or not sample_id_all, etc, that affects how we parse
the events.

This area still needs some work to support events with different
sample_types, the recent changes that introduced evsels and evlists are
a step in that direction.

- Arnaldo

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 81dbe27..40c6b10 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -39,7 +39,6 @@ enum write_mode_t {
 
 static u64			user_interval			= ULLONG_MAX;
 static u64			default_interval		=      0;
-static u64			sample_type;
 
 static unsigned int		page_size;
 static unsigned int		mmap_pages			=    128;
@@ -342,7 +341,7 @@ try_again:
 		}
 	}
 
-	sample_type = pos->attr.sample_type;
+	perf_session__update_sample_type(session);
 }
 
 static int process_buildids(void)
@@ -563,8 +562,6 @@ static int __cmd_record(int argc, const char **argv)
 
 	open_counters(evsel_list);
 
-	perf_session__set_sample_type(session, sample_type);
-
 	/*
 	 * perf_session__delete(session) will be called at atexit_header()
 	 */
@@ -583,8 +580,6 @@ static int __cmd_record(int argc, const char **argv)
 
 	post_processing_offset = lseek(output, 0, SEEK_CUR);
 
-	perf_session__set_sample_id_all(session, sample_id_all_avail);
-
 	if (pipe_output) {
 		err = perf_session__synthesize_attrs(session,
 						     process_synthesized_event);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 417f757..847a9e0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -883,7 +883,6 @@ try_again:
 static int __cmd_top(void)
 {
 	pthread_t thread;
-	struct perf_evsel *first;
 	int ret __used;
 	/*
 	 * FIXME: perf_session__new should allow passing a O_MMAP, so that all this
@@ -900,8 +899,7 @@ static int __cmd_top(void)
 		perf_event__synthesize_threads(perf_event__process, session);
 
 	start_counters(top.evlist);
-	first = list_entry(top.evlist->entries.next, struct perf_evsel, node);
-	perf_session__set_sample_type(session, first->attr.sample_type);
+	perf_session__update_sample_type(session);
 
 	/* Wait for a minimal set of events before starting the snapshot */
 	poll(top.evlist->pollfd, top.evlist->nr_fds, 100);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f642615..f26639f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -94,17 +94,6 @@ out:
        session->id_hdr_size = size;
 }
 
-void perf_session__set_sample_id_all(struct perf_session *session, bool value)
-{
-	session->sample_id_all = value;
-	perf_session__id_header_size(session);
-}
-
-void perf_session__set_sample_type(struct perf_session *session, u64 type)
-{
-	session->sample_type = type;
-}
-
 void perf_session__update_sample_type(struct perf_session *self)
 {
 	self->sample_type = perf_evlist__sample_type(self->evlist);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 05dd7bc..b5b148b 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -112,8 +112,6 @@ void mem_bswap_64(void *src, int byte_size);
 int perf_session__create_kernel_maps(struct perf_session *self);
 
 void perf_session__update_sample_type(struct perf_session *self);
-void perf_session__set_sample_id_all(struct perf_session *session, bool value);
-void perf_session__set_sample_type(struct perf_session *session, u64 type);
 void perf_session__remove_thread(struct perf_session *self, struct thread *th);
 
 static inline
