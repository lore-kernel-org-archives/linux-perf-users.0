Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2822C07E99
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA879613CA
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGISAK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGISAK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28C1A613C9;
        Fri,  9 Jul 2021 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625853446;
        bh=C1m6Z9er+kZNyzP955FA2czrvjgxs0c+EFM0BbWsrF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTFtmBV8+FFOIZrRpKe4P8sa2BS1tkgqKR09afY18rlcW0DlBGNQp1WSZWtmTSjgt
         n4btsgBgp/1Vv7tIlaG67SC98AaUgACoNlxJvk8Y4/9K7Sd1+vW0mGQlCQrHkGoZZg
         2LNX4jFjDbhhCGTsUgCYjqatklBZPvoayJs7WcrnRxVxVdLSfy4qFCSe6MZ8HoNZa2
         K0VxUskNo/4PdMz4ukuNajchxahsJNVh8h8AzPxMt8YquQ/lxzajkI4tM+if6lCIKw
         CxgJOb/r5wZlk+BAnzOLbD7wU2qTfUdeu152iXX733pDh6epIbUAtQ42jr49tNyVC6
         Rz0tQTEkbs8nQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C9B540B1A; Fri,  9 Jul 2021 14:57:23 -0300 (-03)
Date:   Fri, 9 Jul 2021 14:57:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] libperf: Remove BUG_ON() from library code in
 get_group_fd(). was Re: [PATCH 6/7] libperF: Add group support to
 perf_evsel__open
Message-ID: <YOiOA5zOtVH9IBbE@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-7-jolsa@kernel.org>
 <YOXnq2yTVwklbrpO@kernel.org>
 <YOXvSpcxeAnrGBTi@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXvSpcxeAnrGBTi@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 07, 2021 at 08:15:38PM +0200, Jiri Olsa escreveu:
> On Wed, Jul 07, 2021 at 02:43:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 06, 2021 at 05:17:03PM +0200, Jiri Olsa escreveu:
> > > +static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread)
> > > +{
> > > +	struct perf_evsel *leader = evsel->leader;
> > > +	int fd;
> > > +
> > > +	if (evsel == leader)
> > > +		return -1;
> > > +
> > > +	/*
> > > +	 * Leader must be already processed/open,
> > > +	 * if not it's a bug.
> > > +	 */
> > > +	BUG_ON(!leader->fd);

> > Humm, having panics in library code looks ugly, why can't we just return
> > some errno and let the whatever is using the library to fail gracefully?
 
> true, I took it from perf code, did not realize this,
> I'll check what can we do in here

So, I've added this as a follow up patch:

commit 0ec138125eaea5f15157adcecc3e0def1ad2ed22
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Jul 9 14:52:16 2021 -0300

    libperf: Remove BUG_ON() from library code in get_group_fd()
    
    We shouldn't just panic, return a value that doesn't clash with what
    perf_evsel__open() was already returning in case of error, i.e. errno
    when sys_perf_event_open() fails.
    
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Michael Petlan <mpetlan@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 9ebf7122d4766c5e..d8886720e83d8dfe 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -77,23 +77,30 @@ sys_perf_event_open(struct perf_event_attr *attr,
 	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
 }
 
-static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread)
+static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *group_fd)
 {
 	struct perf_evsel *leader = evsel->leader;
 	int fd;
 
-	if (evsel == leader)
-		return -1;
+	if (evsel == leader) {
+		*group_fd = -1;
+		return 0;
+	}
 
 	/*
 	 * Leader must be already processed/open,
 	 * if not it's a bug.
 	 */
-	BUG_ON(!leader->fd);
+	if (!leader->fd)
+		return -ENOTCONN;
 
 	fd = FD(leader, cpu, thread);
-	BUG_ON(fd == -1);
-	return fd;
+	if (fd == -1)
+		return -EBADF;
+
+	*group_fd = fd;
+
+	return 0;
 }
 
 int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
@@ -133,7 +140,9 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 		for (thread = 0; thread < threads->nr; thread++) {
 			int fd, group_fd;
 
-			group_fd = get_group_fd(evsel, cpu, thread);
+			err = get_group_fd(evsel, cpu, thread, &group_fd);
+			if (err < 0)
+				return err;
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
