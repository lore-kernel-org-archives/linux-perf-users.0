Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8ED31987D
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882364; cv=none; b=qkYXnBV9p9RNmc8gznOxoMaepaJsJzO2YUKHX5+m0xK/1Jkfej63etKkGDvYfNRPSCF+G5rGhvzcEvhKa4mmVwO5zC3c8hD0WOjdxOtjOXzA6Z3K0n0Om4qZ8Af4gt9xJZyE/Jv5Kq3UDQZ7BPLAGCwV96517+K0hsICIs0UVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882364; c=relaxed/simple;
	bh=hM/dU06r3H2iof1UEM9SSbD+8fZxFpUGbqpf7lbtA9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VSVzBUQKYqIrEzUryuKUvW1fsRD5IlCsKrV/kzhW8E+T5dbjcthuH/6OEtzhlU2k8RSv/Nw6JhRO9M2VuoqDhodmmQuc8UXi70PG2vb4r9KQegyIbLjUHJ2z8BPX/1wiGwnOvl6v0rvCKxglw6bVQ4ieWoJjf1qzYEah+iGbdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amsNcr5Y; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amsNcr5Y"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5905597eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882363; x=1778487163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXZ9tzHv3saf8ZzOj6+EMxtC6tufF+eRQYpgvcGXfn4=;
        b=amsNcr5YM9ZfYLPWg0arpDNBD8UPN21CMwElbusdKoqkDNph4cHR8TGdlIZQd8bDCh
         Pd4V4Invv49Bc7V6efSOy0PUSRnbtAjPHDO/ns0U8uCyenSJi04UK01rBB4XZDTqYIoO
         +CDIZAoclVfUJrK5q+yh48e1w17scoTcGYNnHs5vaa7YW4Fm09ktyp3EZ1xEQR8v3TJE
         EyNxZQRcSW7BVvfhX6dVWYoLaeaY3k6AvChzJERCovjzg2pX1JM+W7sSwXquEoakxWfK
         D6zDP3jKZVxW2gzUh0hJgJsTqa4Jvyt75ZLwnMoujB7YTAXUVtiXLrgOFQek/WMvBIF5
         I28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882363; x=1778487163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXZ9tzHv3saf8ZzOj6+EMxtC6tufF+eRQYpgvcGXfn4=;
        b=dTIKFcNB0rcxiRih9VC7aO+AWSPlubFvHOTT+Q3ATq7YxrD5bEwQ8MAZBqD728L3qC
         dhhqCSDehjwT3IqxZRtNf3w+LX2Z9Onhd3nmvzIINInjOFyc6aBbvv7XPzXy4t/RzXp9
         aBKCnEJ2QidvR+VPMe4vosyShuovt/1WJ3sBVuOhT8Y/qtO4Io/yebO+L58tUdFuhYXw
         8xHSxBDpvTxCN2zA1cU6RsmKeTUMf8B+JeWoeGDbDdWsV2t4Nled5VRX+hKy73//OkSX
         7dOBKpdLyor0AbXy8JaEiWYWN+QCAcxv9TzSlWFy+3SLNL5LFY6hfPT1jbaGOuDtmGYR
         mtiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jOEjEKa6z6sAcmNuL51vuX4wRCaeTuehzA3el65n10HL6g1mYAcBZc1OlHJur92WfpIwAP43vNosvo+3Bg90y@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2dy4YgkeSzADoQ2cUuUU6uZ/EB+xhb1bg6NlSmFmzThg+adt
	25jBHHgGtF+Bg+3kt33PutH19CO5cZRlY4qCGSitN/mGZ07D4zStuKSYEZEvjv+0d0TLCDvJrkx
	Sd/aauPChLA==
X-Received: from dycou19.prod.google.com ([2002:a05:7300:dc93:b0:2ee:996c:6f28])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cd8e:b0:2d2:96e8:1bf5
 with SMTP id 5a478bee46e88-2efb7bdc5bamr3624015eec.3.1777882362411; Mon, 04
 May 2026 01:12:42 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:23 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-6-irogers@google.com>
Subject: [PATCH v5 5/9] perf libdw: Support DWARF line 0 in inline list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow DWARF line 0 in `libdw_a2l_cb()`, as it is a valid
reference for compiler-generated code.

Filter `die_get_call_lineno` error codes (negative values), but
fallback to line 0 if `call_fname` is present to preserve the
caller's filename instead of discarding it entirely.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
 - Split from original Patch 3/6 into its own commit.
 - Fixed fallback logic for missing call lines to preserve filename by defaulting to line 0.
---
 tools/perf/util/libdw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 301642084c69..196b9cdf51b2 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -80,6 +80,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 	struct libdw_a2l_cb_args *args  = _args;
 	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, dwarf_diename(die));
 	const char *call_fname = die_get_call_file(die);
+	int call_lineno = die_get_call_lineno(die);
 	char *call_srcline = srcline__unknown;
 
 	if (!inline_sym)
@@ -87,7 +88,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 
 	/* Assign caller information to the parent. */
 	if (call_fname)
-		call_srcline = srcline_from_fileline(call_fname, die_get_call_lineno(die));
+		call_srcline = srcline_from_fileline(call_fname, call_lineno >= 0 ? call_lineno : 0);
 
 	if (!list_empty(&args->node->val)) {
 		struct inline_list *parent;
-- 
2.54.0.545.g6539524ca2-goog

