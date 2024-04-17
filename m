Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001FE79FE
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Apr 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378750; cv=none; b=hqSabuzxGYZXq2LOdwgEcFctmYYvjsOEuOPWYfugUlryT4zRxWIYsvlSt7S382Wd4y0KOVFhS2Vg66sY0rw/UhKIu+QKbD71j8btyzW+QFfb0lqMN7oKB0WSudfXtfMp2m3fN9OovcEWE/0omSBKNy6zvg5ANI08woTW/tBPsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378750; c=relaxed/simple;
	bh=36hXQuEvO/yn4vEmJGlAB6y3mAmxuqgfg5ZGP25OSKY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=dkaW395zUjcUbiCmUt7iZQ64hRmq3VxsQleKuqWQ+r2MbA7Wo0lvaQHyscI8EflNpDE8XubJ8OHWfovUOgq5W0VDdKjOIMaZ458dEPOSIlGqU53HS85yQj5Rkv2Y9rIrw/oAn6Vz9hfPqrxdugUhyuzes/8SuCWKnrhdHZfFVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PL5j5XyX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PL5j5XyX"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45daf49deso79883276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Apr 2024 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713378747; x=1713983547; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=axvyU+8QUv8kTyKybxhFapUIJ4L0+ijLXSh2frDTobY=;
        b=PL5j5XyXFKlPqmL+yZIXmnGBiZesm6YGkMItEwjpm2wTgNQgWnuNrsxhDko2QI6CXE
         9FESNgU9AxsvCvTPEP42UhL599BuI119svdMSS1i2asU3FtFC02Gi7wV/xUgw+nHJRk5
         dr/UwHA1RINtMgGVNtn6pxQh/Tt4OUhmHDteoBPhbC8gzQcWoavW5i9kSq8oxD4u0dW4
         1zjWurK2zOPsU4jtTFIIW6mAE3pT1HU4XMhmPPnPClJETseZxUdhOVjUp0tWlB+wlJem
         0xumU6YO8WgT6t7sIvGsvfOP7Imk+3SDTOHuft57sjjpuzskqBWI9nIB3qqyhdVAO6LF
         eBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713378747; x=1713983547;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axvyU+8QUv8kTyKybxhFapUIJ4L0+ijLXSh2frDTobY=;
        b=xM/ubtLgv79OFL5kZqdwyQJlBizVbgHVt/gPMG4AqEhpjhAczQ00V3IXxuYNzPpVQX
         4vrvEZLA2DwaRN050Y8PgP/KETadFRZSKmPLt1zHokrAFgvclyd5cx3jyYBhQfBVAqsd
         F/Y+img6jbraPUV3NVsog4AeruXCShcgu+B3Z8urEaapZvsI5YdSp2ti1WqP8PllAeHr
         GIysR0EocfFYB+Fcbmdi6trYO7WXE6P9jO3RASeU031LACugfN9XzlJUOM/NUHGrC45l
         FWtkJfM5VdwJActeKrqliP3qzYEEI7muBDza1S4RZ7oqaZz/SlM6servIJS6ho229ntv
         9pyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfCwFIMc0amdz4FKWBPXb4icBJHTsl0DDBYyW98/DY4EQSqf/jZRCPAhyclqCW5zbbZepFquH/dhYkmHfl1+5JhTaue5IzWK7fCXbv+UhlKw==
X-Gm-Message-State: AOJu0YybO3/Aeq2OcNE3CDYb9aDfxWMNzlaFblwG0hYC4QJEE3XKEnZO
	gOl04CuzuXInmYPziD8wSD1sJoq1UR9cba3FIsXFkMAZQwvW5PfJb6RsVVILxh9uITJ+yKXReiQ
	kXUOq0Q==
X-Google-Smtp-Source: AGHT+IFBWokfc9EOakTcRvWLn9uzuvhdYjyYgTXbyLc60iS9DX7y4vkAhB/A617M4Bu0xdVWZR0/ykNlQIWu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:21e2:a91b:3cf5:c57b])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b09:b0:de1:2220:862b with SMTP
 id fi9-20020a0569022b0900b00de12220862bmr38875ybb.12.1713378747053; Wed, 17
 Apr 2024 11:32:27 -0700 (PDT)
Date: Wed, 17 Apr 2024 11:32:19 -0700
Message-Id: <20240417183219.1208493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1] perf test: Avoid hard coded metrics in stat std output test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hard coded metric names fail on ARM testing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index cbf2894b2c84..845f83213855 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
 event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
+skip_metric=($(perf list --raw Default 2> /dev/null))
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.44.0.683.g7961c838ac-goog

