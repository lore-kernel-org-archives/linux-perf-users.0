From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 2/2] perf config: Show default report configuration in example and docs
Date: Tue, 30 Aug 2016 15:41:06 +0200
Message-ID: <20160830134106.21240-2-milian.wolff@kdab.com>
References: <20160830134106.21240-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:52114 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbcH3NlQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Aug 2016 09:41:16 -0400
In-Reply-To: <20160830134106.21240-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/Documentation/perf-config.txt    | 8 ++++++++
 tools/perf/Documentation/perfconfig.example | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c7031bc..1559000 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -110,6 +110,14 @@ Given a $HOME/.perfconfig like this:
 		order = caller
 		sort-key = function
 
+	[report]
+		# Defaults
+		sort-order = comm,dso,symbol
+		percent-limit = 0
+		queue-size = 0
+		children = true
+		group = true
+
 Variables
 ~~~~~~~~~
 
diff --git a/tools/perf/Documentation/perfconfig.example b/tools/perf/Documentation/perfconfig.example
index 1d8d5bc..2b477c1 100644
--- a/tools/perf/Documentation/perfconfig.example
+++ b/tools/perf/Documentation/perfconfig.example
@@ -27,3 +27,12 @@
 	use_offset = true
 	jump_arrows = true
 	show_nr_jumps = false
+
+[report]
+
+	# Defaults
+	sort-order = comm,dso,symbol
+	percent-limit = 0
+	queue-size = 0
+	children = true
+	group = true
-- 
2.9.3
