Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F491714B4
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315155; cv=none; b=uFtGC6si9SwTU0BliYncYcav7xa74bjWF1hFFVy+a9aPQbliK6IBbQoySPci+KFUiDQJ5wqD/YluLOFO5wAngCkLkxoeMljx50ALOPxYKFMxF2GP42BMS4D5PofFz0Qyud+DD/Zyal8DPBdqbq+0XsMfFLKWtFnx7yY6zEN9E0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315155; c=relaxed/simple;
	bh=NWyOZGvVp70tlGmdZEWQ8sDHjKT8tk+xY/WeZhdeWww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kFagtPgvIz36eNVteipafPoZhN8Qs5RCaOhC+AR2pt/hpLzoyToSWECzC2islaP7wp1Xq+dqwxCW+3uVUIILgQt1CXSfA2KT/wLVW+C6UfECW6SJiH/otdAlyImupMQttulLlUCfqYSb5fX3KCOaY+a9JIkAXm9YVk1+78TJKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFDY55Ng; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFDY55Ng"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso2555239a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 18:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741315153; x=1741919953; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YwLtUBA2a3eR+2CmuTfmd2aWCIaAduMpkYNneVBrdI=;
        b=yFDY55NgMDe32bLT7ObWKOtwsj5/86Nukgsy+NUtrDx/UKSXDh+e07wFdeGuJ9bEk9
         2bKXYl8rf8NcP+1SyYaQ54QgoDfR7T8RYqYoXZ9hjV7mB0YRFdA+hduNyfcvlZvD8VO2
         +vz9v8O/HkGCvDgixozWx13y9iLIeJAAWIbTsgRUZ3SqSIVYQsMur+Ympqa69pj18gae
         4WB1l3nUNKb7Fl0wIQ6H65012144gCzZg/0gs2i+TwvecVr5PTboAXzDWcwIOoVYy2to
         9tZa937c/XaWuxh87Iqv0fvaidRakPNbT4rZszJBCuV+LmRVbIxPzz757i/tZQt93pwQ
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315153; x=1741919953;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YwLtUBA2a3eR+2CmuTfmd2aWCIaAduMpkYNneVBrdI=;
        b=dZYTJOEoe6BxLXZZqEi3wYC+TOhhCQ67hpiUJRR12WecTvSRVzy50DVKCrI+IoLfyb
         oTVzNB6zHYnbzed7/z/JD8N8hULuVn6ObyBbv1sN8s364S0/fgIt6rJuVQOA31zwLKU9
         k2/iQERmmBeY2Psu7H6/xDwa3ReZlToz2+0xi/iEPeYg87kJ7uvFjTtvkYLKNnzrV9z1
         IH/Mr1qLH6dtRiMaoEoF7gLjaPDIbs93nKYRq2KNdwrjPLapm9UCY1jHpZ8d2Ulfqajh
         8h4RMX/0ApS9edmWVZqC9BGbF1cuN8sU7btkhlCQ9sXsl22WyF/Fo2CEhLMdO4ExWRRV
         F/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPM/buqI7uIOv7mJTloCYbluCUDcZPZnqqjxOu1dtQAgWCKUpKz0r/MXvFszq0LPMHVhl+3a2ygH6Dl15vcc0h@vger.kernel.org
X-Gm-Message-State: AOJu0YwJB9N4Xt0nO0kBu2mvnUImd8rFtzA40UCEPc9E8/oDUPiwi7Ob
	N0+W0mjQHJdpoeJJWxzIu7ExJ6euXKx7tbl2T2rj72QhsJUAViHnvuGffwtnhmdGjZOjs/WMoOt
	8iLt/2w==
X-Google-Smtp-Source: AGHT+IEolkiQSfDAoU+Ce7TybWwf7ay09+pwJfxEWHQ2tK3T/2E4vteMlcQkSfh9pSvQr98fCC9jXru0BD5F
X-Received: from pjbqj3.prod.google.com ([2002:a17:90b:28c3:b0:2fc:2959:b397])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180b:b0:2ff:5357:1c7f
 with SMTP id 98e67ed59e1d1-2ff7cf3d0bfmr2290224a91.30.1741315153549; Thu, 06
 Mar 2025 18:39:13 -0800 (PST)
Date: Thu,  6 Mar 2025 18:39:03 -0800
In-Reply-To: <20250307023906.1135613-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307023906.1135613-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307023906.1135613-2-irogers@google.com>
Subject: [PATCH v2 2/5] perf x86/topdown: Fix topdown leader sampling test
 error on hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

When running topdown leader smapling test on Intel hybrid platforms,
such as LNL/ARL, we see the below error.

Topdown leader sampling test
Topdown leader sampling [Failed topdown events not reordered correctly]

It indciates the below command fails.

perf record -o "${perfdata}" -e "{instructions,slots,topdown-retiring}:S" true

The root cause is that perf tool creats a perf event for each PMU type
if it can create.

As for this command, there would be 5 perf events created,
cpu_atom/instructions/,cpu_atom/topdown_retiring/,
cpu_core/slots/,cpu_core/instructions/,cpu_core/topdown-retiring/

For these 5 events, the 2 cpu_atom events are in a group and the other 3
cpu_core events are in another group.

When arch_topdown_sample_read() traverses all these 5 events, events
cpu_atom/instructions/ and cpu_core/slots/ don't have a same group
leade, and then return false directly and lead to cpu_core/slots/ event
is used to sample and this is not allowed by PMU driver.

It's a overkill to return false directly if "evsel->core.leader !=
 leader->core.leader" since there could be multiple groups in the event
list.

Just "continue" instead of "return false" to fix this issue.

Fixes: 1e53e9d1787b ("perf x86/topdown: Correct leader selection with sample_read enabled")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Tested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/topdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index f63747d0abdf..d1c654839049 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -81,7 +81,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
 	 */
 	evlist__for_each_entry(leader->evlist, evsel) {
 		if (evsel->core.leader != leader->core.leader)
-			return false;
+			continue;
 		if (evsel != leader && arch_is_topdown_metrics(evsel))
 			return true;
 	}
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

