From: David Ahern <dsahern@gmail.com>
Subject: [PATCH 0/2] perf script: split sym format option into ip, sym, dso
Date: Fri, 27 May 2011 14:28:42 -0600
Message-ID: <1306528124-25861-1-git-send-email-dsahern@gmail.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:51303 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1E0U2t (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 May 2011 16:28:49 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de, David Ahern <dsahern@gmail.com>

The option to dump events with a custom field selection assumes "sym" means
instruction pointer/callchain and the conversions to symbol and dso. This
series adds "ip" to mean dump the instruction pointer/callchain and shifts
the meaning of "sym" to symbol conversion of addresses. The "dso" option
further splits the old "sym" format into symbols and the dso it comes
from.

David Ahern (2):
  perf script: "sym" field really means show IP data
  perf script: make printing of dso a separate field option

 tools/perf/Documentation/perf-script.txt |   10 +++---
 tools/perf/builtin-script.c              |   38 ++++++++++++++-----
 tools/perf/util/session.c                |   57 +++++++++++++++++++-----------
 tools/perf/util/session.h                |    5 ++-
 4 files changed, 72 insertions(+), 38 deletions(-)

-- 
1.7.5.1
