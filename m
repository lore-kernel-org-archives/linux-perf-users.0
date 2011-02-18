From: David Ahern <daahern@cisco.com>
Subject: [PATCH 0/3] perf events: Add realtime clock event and timehist option
Date: Thu, 17 Feb 2011 22:53:50 -0700
Message-ID: <1298008433-22911-1-git-send-email-daahern@cisco.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:29254 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab1BRFx4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 00:53:56 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@elte.hu, acme@ghostprotocols.net, paulus@samba.org, David Ahern <daahern@cisco.com>

David Ahern (3):
  perf events: fix WARN_ON_ONCE for 64-bit raw data, SW events
  perf events: Introduce realtime clock event
  perf events: add timehist option to record and report

 include/linux/perf_event.h               |    1 +
 kernel/perf_event.c                      |   74 +++++++++++-
 tools/perf/Documentation/perf-record.txt |    4 +
 tools/perf/Documentation/perf-report.txt |    6 +
 tools/perf/builtin-record.c              |   78 +++++++++++-
 tools/perf/builtin-report.c              |  208 +++++++++++++++++++++++++++++-
 tools/perf/util/event.c                  |    1 +
 tools/perf/util/event.h                  |    8 +
 tools/perf/util/parse-events.c           |    2 +
 tools/perf/util/session.c                |    4 +
 tools/perf/util/session.h                |    3 +-
 11 files changed, 384 insertions(+), 5 deletions(-)

-- 
1.7.3.4
