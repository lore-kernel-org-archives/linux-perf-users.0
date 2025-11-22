Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D395226861
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799586; cv=none; b=C8BBv4EW+c6A67cML9Eb9A/dEbRL4UjwY0m9ylbEqqWjpyMRDfrNbctjQRKOW7PkaHnAK0ONMvwtMcJ4nKgzWffwan1Sujt4gWjdg8pFjmaG85yknyL+zYDlZWgMP7y/kJv3jelNhQO6GPVzUEBie8yNnnReMG3QLstVr4cjhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799586; c=relaxed/simple;
	bh=IF7kiGMXT3GWUUAyL/cSBuIOkjSMd8QXGdU4ipFZplA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H4E02xCBJCPFfzbhmZ4Eohj9Rff1S7O3Y52ySfNeg6xoRwnX2OUche37Qghs0DdhgLPua07AiztmktPlCjWfsWJIdSAa4k2iRGtVPXUDRUAJJK0jMMBnwUlPhoTLRSaCA6+7gLTZr19HUmG17QK4IHK54mb+Jgvbgou20DiEbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxQRQ1Cw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxQRQ1Cw"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b89ee2c1a4so6243334b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799583; x=1764404383; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvMe0/1/vRKq5bNJV10II46vCbhKGM1y7dlTeIbVfZk=;
        b=nxQRQ1CwsIEpxU3NS+uMMYeXEURIxJWVU52g08jqhB1eqC7cLcAzKAylQ19GIhljRC
         oU0jeAOzttD8UShWvrbYTfn+k2XjTP9lQdSGfuxS7fYSCqNW6QOwkLtcbRTdYB4AHKx+
         UlpsPTMLNhSQYuJkoZbsnFbR4Ct4SMSadH0dTKMxRk4b3WCbL3cZJ005Dh9s2L4NAj2h
         vAjrOjKn92qxVj1uWUcirmY00MtV+qXOXF4gJCrml/sl8mGeTkz7lEDsFaDtqxbUvRJq
         jSI0HuUIjEJDLtLi0wqz8naZbKXpOAz9AYMwR9OvLZkIwqNexqNn1FIijDy2GJkjmaE2
         KCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799583; x=1764404383;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvMe0/1/vRKq5bNJV10II46vCbhKGM1y7dlTeIbVfZk=;
        b=nDibngVtfkVA6t0BoElRrqCvw57mbK93czPmlz5a2AxFer1F3QhjZYztQmuwXKY+zi
         D+6bIuEyGq+10AggDc5F34LGg6OPxhBukI7q2huSmV2JevwKwj+I7592t71hg3wcF6Hz
         +MmfgMstpM6+6svFE1WPLfy1kv1n8L8dE5kNs49qGHVHu1A5H7QyabdSirYz6vzGvcvP
         WHGbmE3qI0f+yJrcjbAcb8EPI+FXg9SziUQ8ApgA6e9S50XDTBbb1LkIPrcDkzcn5bya
         BuhwljazBRLzRtfyTT1/iKiJm9bMVN4ehmpunOtqT/rkCOjuHGD82wPItmAEnY/KYIfS
         Wmcg==
X-Forwarded-Encrypted: i=1; AJvYcCUeye3gXn2KyX8P1a37fBL7V9HIXeAmimYor71bX80EJheElR6Y/WCFdRUfjhVtdJVi1X61xZClaxL8srf8oTrg@vger.kernel.org
X-Gm-Message-State: AOJu0YxnsVQna07SCqifF9ojqpmrcVw99NLuzsrvdfSYyFB9OFQnRBnz
	S+hjTngKc4Fob1XUeJEad1ToKfm7ZA9pZeqMVnw3Lg4Pxwg0PXf5OJok7519wzr4IET5zlCQgN+
	GxqBn0QBX7g==
X-Google-Smtp-Source: AGHT+IHIAAPP9U27w/gI9cni5l2P+pE2XAzE/K8cjLvVURUpB29gfEdcfXPra/Jl6XclLzvz/p2lYfJcv96N
X-Received: from dlbdm40.prod.google.com ([2002:a05:7022:6ba8:b0:119:78ff:fe1c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:251b:b0:119:e569:f278
 with SMTP id a92af1059eb24-11c9d865804mr2152423c88.33.1763799583198; Sat, 22
 Nov 2025 00:19:43 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:16 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-5-irogers@google.com>
Subject: [PATCH v1 04/17] perf symbol: Add missed dso__put
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing dso__put for the dso created in maps__split_kallsyms.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cc26b7bf302b..067754b5b667 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -985,6 +985,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				dso__put(ndso);
 				return -1;
 			}
+			dso__put(ndso);
 			++kernel_range;
 		} else if (delta) {
 			/* Kernel was relocated at boot time */
-- 
2.52.0.rc2.455.g230fcf2819-goog

