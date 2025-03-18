Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA01CAA66
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271300; cv=none; b=YTiGS2c05WqohvAnq/PICuxGdVZpU4vpxqbA960RZa08PSwPVAv9gHm0X5ssuDmZwHRuy64InjXyMGIQoFBFKbymtouufx/knPPqSYEFNdphTMbaNQqn4WOabG+9WSId1ffVogln0hFi1vvoXcKtMgQ+7VgcUk9MZPlzWa9Xclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271300; c=relaxed/simple;
	bh=nM7VLv/vcPJb8IP1hkBb7xTP6rJT9gjNNb4KuBio9Y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=C7Z1aSO2D2zN5cSBsu+i7Ynxt1KjMyfedDgDoONw9rxR/jhg84KXp6bARzzXifsw5ikHIRYALWV0SQw1wpYl7mDDIs5fGuuGkbBlkrrVvBb1fknBq/UcUWB1+MnKlqzPV1iDtwKCLOBmumQcJlZbtzwV+kU6o/Jz+sidWA9MZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV5dO8Sv; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eV5dO8Sv"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5fea6c35b34so1127514eaf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742271298; x=1742876098; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcTDVc7sWc+BX5SOaqTWz06HZw+0rggI949f/hqkkSw=;
        b=eV5dO8Svo2y5cx6scAbegntfkkIeovgL7zY+a8uboV0Ftt5ma7eC0YFUS8R/6EsS9N
         LdTj8VRvqIkz0VLFNwe4F8+7eCFeovD3enCkGwLkYHT4ZI6q4gDxcZmJY/Otz+91WqMh
         O/wtBSoXAhqFbnhCEathU/RfRNk6OWFIBIYMAZ9rSnVC0DGX8XPndu/oCZdSYWfbRdmf
         DoO442o5m0IaL0I81MM+QbqV3m25HBrXq4o3+JD+57ZMQyddj3h3OoeGuoV8GBYAOPEO
         hjJ7q0DxobxGPWSgU4kIwYwQzUFR2ZyhtOnMMTkaBnoxTyt4/ZC8B7/asIQNH2gS1Xuu
         Vqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271298; x=1742876098;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcTDVc7sWc+BX5SOaqTWz06HZw+0rggI949f/hqkkSw=;
        b=MwLj6B53NkWU7Chk0MT/nQZ2wO9WMOGxcX0/k5UInRRg7l0wIQu7lB/xn7tjIdlECR
         72x9azcSqeJK07R+OBhR/qB2jvY9rdvWzta1U5TlJ/taP0t1pw53MH548lAhqd74T+ht
         vV8TDljScbo9ZCnsDukrxr5WLLI6IBpNxcTu0YgvmgMcjfUA7UlF1Usl7fwX2Jcua9TF
         NdWGvgmZiz4bFlEXsaGUP4GWk8wroYwpm+SxwtpbFhLYCMixzaW5nPxBoz3/08asat1W
         woX9ZwbWHE76FkusaARo/zGtbpQ5daQv+MrDiBH7L722bPJ6UaIgFouK29bVQMGcKKU5
         lDQw==
X-Forwarded-Encrypted: i=1; AJvYcCVXSSTlCWt6Q8YClxPVGPBEAhScVuMes+Ufj+paz8jj5mXtlEo+iSACJVGuHotVQia6PS/p6VjVFCA9TzmkVkJi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8HCHHxePhJkxfPYEx9xp4+LX3dCqrePFr/er6wi9Ef7pJTJG
	8bKzWjhZo216Umufusj3G6rsbjhNyuf4BMV09WT7tOgrFpmcQ4HemEQMJhO9+H6Bg9qWiVx7ieo
	TU9bTmg==
X-Google-Smtp-Source: AGHT+IHbiPc7HGDa8UDDNXiyyyNYm3dPD9ip4rcffjkWbCIt+vvE/ogOPNPgJ48eQYU33l1n9NXH5ew2ke34
X-Received: from oabhq15.prod.google.com ([2002:a05:6870:9b0f:b0:2c2:67a4:62b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:d614:b0:2c2:d2b8:e1ab
 with SMTP id 586e51a60fabf-2c690feb31dmr7568764fac.18.1742271298202; Mon, 17
 Mar 2025 21:14:58 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:14:42 -0700
In-Reply-To: <20250318041442.321230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318041442.321230-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318041442.321230-6-irogers@google.com>
Subject: [PATCH v1 5/5] perf parse-events: Add debug dump of evlist if reordered
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add debug verbose output to show how evsels were reordered by
parse_events__sort_events_and_fix_groups. For example:
```
$ perf record -v -e '{instructions,cycles}' true
Using CPUID GenuineIntel-6-B7-1
WARNING: events were regrouped to match PMUs
evlist after sorting/fixing: '{cpu_atom/instructions/,cpu_atom/cycles/},{cpu_core/instructions/,cpu_core/cycles/}'
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..cb76796bc5c7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,6 +28,7 @@
 #include "util/evsel_config.h"
 #include "util/event.h"
 #include "util/bpf-filter.h"
+#include "util/stat.h"
 #include "util/util.h"
 #include "tracepoint.h"
 
@@ -2196,14 +2197,23 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	if (ret2 < 0)
 		return ret;
 
-	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus)
-		pr_warning("WARNING: events were regrouped to match PMUs\n");
-
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
 	 */
 	evlist__splice_list_tail(evlist, &parse_state.list);
 
+	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
+		pr_warning("WARNING: events were regrouped to match PMUs\n");
+
+		if (verbose > 0) {
+			struct strbuf sb = STRBUF_INIT;
+
+			evlist__uniquify_name(evlist);
+			evlist__format_evsels(evlist, &sb);
+			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
+			strbuf_release(&sb);
+		}
+	}
 	if (!ret) {
 		struct evsel *last;
 
-- 
2.49.0.rc1.451.g8f38331e32-goog

