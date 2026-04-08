Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25FF40DFB6
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607426; cv=none; b=JuE9INy/o/hJQ/Nj/pPu+raO4oGgmFR3hvqJIYzZY5AfwYUlbivfipRFrbzBzjran2NVAGJ8Msp7+nhAnriX2c+5iHs2wWNObKi3qIrYqx8HBITlm6UDGPl3xJybZH3iv/Eyb2rczgFbUGlQ0HoE+P1UMptCsZ0lJwSIRe9J0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607426; c=relaxed/simple;
	bh=Z0qfPEhcP1eMPLjQVXjuVt68AeV0ZxAQxr7U/NbzAV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SI5J+aVihIgaxpsM0/JkFxHMEfinBW/x50ndaB/viFVsaJT7jCCFvoBNnwsUah0e18dXOWAFk976ttYrYZ75+BguG9IvWCFbdw1cVZwFXM3FGYQ6HzqxTsoTjb4sahoJA1S9eSDEHiymPsjQFC8O6sqlI7DgXuKycRpE1IaHaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0qI54LX; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0qI54LX"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c72849f648so26017909eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 17:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775607424; x=1776212224; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oo6VH0RKKqWyfDtOptPYYvi5gEdLGmyx0uq6Rgsqz/8=;
        b=N0qI54LXPlyqsugPm4425xQeVgtA/MPI0P/0xDhyWrOTSHk62rLkOdJirLECvl6NJo
         1Y4aw/jirTGIMn0PAArkZfr41Q8CHaNOx0H6nUl1HFjfgV84ren16yF3tbJo/usi5hFw
         d+in8h2qIfHu3bb77LzycBXQYtlOgIu4R/E2Mb1ruecN7ze6U+r5q+Z3S004RCMGurQS
         JHZiMwxHvuJQR08cz65aCvhN1/StXQ82fZhSIyqrZ9HcgBR5t7MorGDxlnuWMpYL/k1p
         LN9uE8Lh6kIfDdi3dyBfb65jhexKxfZHYWtP9kz/sHQ7b0DLDM2RgKyOxiG0a0MQu/fI
         e4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607424; x=1776212224;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo6VH0RKKqWyfDtOptPYYvi5gEdLGmyx0uq6Rgsqz/8=;
        b=i3MYjTNVTESATpIPFKZ4RB3/xoe+Zb/Hvsc6JnHwL/jQhrTjcgac5Lqv2S/4ZOPlG3
         HAzKUaYX/Bsr/hZ/aDk78N4fuj68Zy4D3vTjGytG13SwNZlp6OQin1+Pq4rzhUXa047B
         elgDQG2zCJfUb7PXuivOSQR2okIdfOe3x/sLLrM7rFmkTkggeFizJq7kE3ejTwME7jRj
         XdsBUkTOiU8sTOfgVxYZEcyuGTBVGeCwPDtbNv9hBxTD+fMaXMoh7Xfoa8eSP5sYbhL0
         RuwwNSO1HX8fKsjcGNZkTAF3WoV3buVupI1q7NbnMJz7cKsMrC9G6RZilZtC+ZCzJaW5
         IYLw==
X-Forwarded-Encrypted: i=1; AJvYcCW+KEJr+RXj23CVTkVS1XbyhEnVSVGIPENynEyV7o+wl9PW6Qep7qLr1ajZxlTz4qlU5GwghmIRq2Gv7PlmPA+8@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6J5+2Q5+XtlaOV3ErdM9259DbNHjYIC0OCKd33RFHZffdNL8
	3lGzIw/DPFVaDijR0UbTUN8kzwsznSaNce9UL9SJShKCXHRExUBfnx5RrF3JqT7prUs3RVv2iNs
	LqUyErpOPVA==
X-Received: from dybfx18.prod.google.com ([2002:a05:7300:c392:b0:2c5:89d3:2645])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e78d:b0:2c0:da6f:55e0
 with SMTP id 5a478bee46e88-2cbfc362ac8mr9025591eec.27.1775607423743; Tue, 07
 Apr 2026 17:17:03 -0700 (PDT)
Date: Tue,  7 Apr 2026 17:15:21 -0700
In-Reply-To: <20260408001521.102140-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001521.102140-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408001521.102140-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf maps: Fix fixup_overlap_and_insert that can break
 sorted by name order
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When an entry in the address array is replaced, the corresponding name
entry is replaced. The entries names may sort differently and so it is
important that the sorted by name property be cleared on the maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 7dd6da9d1e4f..b44bc41f51f3 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -955,6 +955,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			if (maps_by_name) {
 				map__put(maps_by_name[ni]);
 				maps_by_name[ni] = map__get(new);
+				maps__set_maps_by_name_sorted(maps, false);
 			}
 
 			err = __maps__insert_sorted(maps, i + 1, after, NULL);
@@ -981,6 +982,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				if (maps_by_name) {
 					map__put(maps_by_name[ni]);
 					maps_by_name[ni] = map__get(new);
+					maps__set_maps_by_name_sorted(maps, false);
 				}
 
 				check_invariants(maps);
-- 
2.53.0.1213.gd9a14994de-goog

