From: David Ahern <dsahern@gmail.com>
Subject: [PATCH] perf stat: tell user about unsupported events in the list
Date: Fri, 29 Apr 2011 16:04:15 -0600
Message-ID: <1304114655-10600-1-git-send-email-dsahern@gmail.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41619 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844Ab1D2WEV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 29 Apr 2011 18:04:21 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: acme@ghostprotocols.net, mingo@elte.hu, David Ahern <dsahern@gmail.com>

Similar to perf-record, tell user about unsupported events
that will not be counted if invoked in verbose mode.

e.g.,
perf stat -e dTLB-prefetch-misses -v -- sleep 1
dTLB-prefetch-misses event is not supported by the kernel.
dTLB-prefetch-misses: 0 0 0

 Performance counter stats for 'sleep 1':

     <not counted> dTLB-prefetch-misses

        1.001884783  seconds time elapsed

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 tools/perf/builtin-stat.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c8b535b..602c3c9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -377,8 +377,12 @@ static int run_perf_stat(int argc __used, const char **argv)
 
 	list_for_each_entry(counter, &evsel_list->entries, node) {
 		if (create_perf_stat_counter(counter) < 0) {
-			if (errno == EINVAL || errno == ENOSYS || errno == ENOENT)
+			if (errno == EINVAL || errno == ENOSYS || errno == ENOENT) {
+				if (verbose)
+					ui__warning("%s event is not supported by the kernel.\n",
+						    event_name(counter));
 				continue;
+			}
 
 			if (errno == EPERM || errno == EACCES) {
 				error("You may not have permission to collect %sstats.\n"
-- 
1.7.4.4
