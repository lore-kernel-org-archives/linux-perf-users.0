Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA5317148
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882362; cv=none; b=I6O2rCsD9C7zgiIhkLtDiqj9Y2IP2As0zyr0ddBOzIYeHRkloe3hHqqEugfkQpQFzlvnr8XjSY3kqoxwl+M6R9Zm4rIKBZpuXF8CeUFy4EuF0IOtCTyEl954AAAI02AN/XfYDfjWiVtURDnptz2EgZaytgGrnAsmqp7XKkEMHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882362; c=relaxed/simple;
	bh=Gmuxp4WqFA97QBknE838BCE9Wm1G7NAZG6fKiarOItM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FodkpilzuW2mhClIVDes2MIntQO6+DEzJq9oBCm5IvPmG2LKpPbh6z0Lf94ddH9QqpMTz5FofkCTdaDwNQf1bXbFZ0UrJAZEhx41z+l8D9Esxm5IdJyn7yoNMtnvWvgdnxXZB2Rab2BZjYJFRkbEtQ3ZsRPrT58/GpoDKjHe7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwxfeqrE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwxfeqrE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dbf4f678eso20453748c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882360; x=1778487160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgADkEc29AeokmXkoizx0BWcSRq7zf6UjkidjmJFVco=;
        b=gwxfeqrECNQ6tNdPC3gXG9SeWpGETmO/n+QKbWeFzEqCipdBiMve9UPlJhIj6RrKmy
         FlPrQrWaTC6P9DO/7lE/hWqm260eDIihq41mw6vAiXABbE/U/7aHMNB66Z9Oiv38NMm6
         RmGIrIYC2a65a8kkBmlLQNst7HTJ6Df/iUp1gG0SpchF5x5rCVz9nBivaR8HijMWWZr2
         6oI4/ZL3za5I3XKtOPNqRligRE2u85k4U9gg4B9foKKv8x2VpWJ4XOKKCOp9B4DF4pNC
         v69wVTDMn4UxbMwXJlQMgGbi7Ydm5VD7FVt84U2Kn2VHd/WUYEunQq+QDbHpdv8zuURL
         IPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882360; x=1778487160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgADkEc29AeokmXkoizx0BWcSRq7zf6UjkidjmJFVco=;
        b=ZMGoOe1nGMTId5QR2Qt3WUMxIfykpRvvKQE2xK2lM7HDZFtQhNWChPGsOPmkCXxZ6o
         u9KWGwI8uHCeJhnG08zFQFfgAj/Pj+gJ3UywFHV2z4gnNQIavbHUYKeNJQBXtfm6kNL5
         lrOWAUdHJ7KverZrU3D0/L1sFNnlP/0WBhAkuXg3NJqz0XeVD9RQ/0BqEYcFMOyL0rG5
         ojo9RFaFSeL/8M/5+xCdKglglNdLCP4uzQiCarUExP7SBJnp97qWSGgxsIL4zWBLTKip
         rJoEy5xmC/zHS0QShzadC4b+uir24DmUmz/zY5xVeKdbGwooVYXe2cA7kq4BJ9PMau2E
         IKMA==
X-Forwarded-Encrypted: i=1; AFNElJ+fTPcEURp8Ogq9wwmy9PSyQPyv8o3eJliEhLcM7LKO9WvDK1rofGWvoaGJQqx4Bt34c18/Q9ecQoKxplTFhqVQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjNyNKl6YYk/wht+dO14vU6BD4iWpTkuTV9dBv1Z0SX4Coeys
	JdoJWOdnO3kzRaO3ZHtHCkg6B61SQz9Zn//OsbhUX1Y3WDX+XWmM/iTOR6oB1+jY/AxA/X+Lifb
	t1FT7AM38uw==
X-Received: from dlii2.prod.google.com ([2002:a05:7022:4182:b0:12d:b65b:1fb3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:427:b0:12d:de3e:86a7
 with SMTP id a92af1059eb24-12dfd8621a2mr4592641c88.37.1777882360268; Mon, 04
 May 2026 01:12:40 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:22 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-5-irogers@google.com>
Subject: [PATCH v5 4/9] perf libdw: Fix callchain parent update in
 ORDER_CALLER mode
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix the parent srcline lookup in `libdw_a2l_cb()` to target the
correct parent node depending on the callchain order
(ORDER_CALLER/ORDER_CALLEE).

This ensures inline callchains are not corrupted when nest depth > 2.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
 - Split from original Patch 3/6 into its own commit.
 - Fixed bisectability failure by removing unused `ilist` variable declaration.
---
 tools/perf/util/libdw.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 216977884103..301642084c69 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -4,6 +4,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "dwarf-aux.h"
+#include "callchain.h"
 #include <fcntl.h>
 #include <unistd.h>
 #include <elfutils/libdwfl.h>
@@ -80,7 +81,6 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, dwarf_diename(die));
 	const char *call_fname = die_get_call_file(die);
 	char *call_srcline = srcline__unknown;
-	struct inline_list *ilist;
 
 	if (!inline_sym)
 		return -ENOMEM;
@@ -89,14 +89,20 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 	if (call_fname)
 		call_srcline = srcline_from_fileline(call_fname, die_get_call_lineno(die));
 
-	list_for_each_entry(ilist, &args->node->val, list) {
-		if (args->leaf_srcline == ilist->srcline)
+	if (!list_empty(&args->node->val)) {
+		struct inline_list *parent;
+
+		if (callchain_param.order == ORDER_CALLEE)
+			parent = list_first_entry(&args->node->val, struct inline_list, list);
+		else
+			parent = list_last_entry(&args->node->val, struct inline_list, list);
+
+		if (args->leaf_srcline == parent->srcline)
 			args->leaf_srcline_used = false;
-		else if (ilist->srcline != srcline__unknown)
-			free(ilist->srcline);
-		ilist->srcline =  call_srcline;
+		else if (parent->srcline != srcline__unknown)
+			free(parent->srcline);
+		parent->srcline = call_srcline;
 		call_srcline = NULL;
-		break;
 	}
 	if (call_srcline && call_srcline != srcline__unknown)
 		free(call_srcline);
-- 
2.54.0.545.g6539524ca2-goog

