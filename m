From: David Ahern <daahern@cisco.com>
Subject: [PATCH 0/2 v2] perf script: add support for dumping events other than trace
Date: Sun,  6 Mar 2011 15:16:33 -0700
Message-ID: <1299449795-12933-1-git-send-email-daahern@cisco.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:43886 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1CFWQF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 6 Mar 2011 17:16:05 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de, David Ahern <daahern@cisco.com>

v1 -> v2:
- fixed process_event handler in trace-event-perl
- removed unneeded call to callchain_register_param
- corrected walking of callchains in perf_session__print_symbols
- complete rewrite for handling non-tracepoint events


David Ahern (2):
  perf script: change process_event prototype
  perf script: support custom field selection for output

 tools/perf/Documentation/perf-script.txt           |   24 ++
 tools/perf/builtin-script.c                        |  234 ++++++++++++++++++--
 tools/perf/util/output.h                           |   18 ++
 .../perf/util/scripting-engines/trace-event-perl.c |   12 +-
 .../util/scripting-engines/trace-event-python.c    |   12 +-
 tools/perf/util/session.c                          |   75 +++++++
 tools/perf/util/session.h                          |    5 +
 tools/perf/util/trace-event-parse.c                |   71 +++++--
 tools/perf/util/trace-event-scripting.c            |   10 +-
 tools/perf/util/trace-event.h                      |    8 +-
 10 files changed, 420 insertions(+), 49 deletions(-)
 create mode 100644 tools/perf/util/output.h

-- 
1.7.4
