Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB4158A2B
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018517; cv=none; b=gU4touQ+iRQ+Bd55TkxifNL7s3sArZ7Cyp+T1IFR00VpVR1Op2/QsK7wW9z9VuuGAF7e0DhN+RK4JW+twGi/4m7n1bnkHdiTWHFF6qONI6UCrhQu1geoeRiRci5d91XyMcvP+nLsfg9PZJlSr69LKQZ659vmkYHYDgVVxlDSbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018517; c=relaxed/simple;
	bh=1yzFprNhaKFl6mEsHce9Oo3cfn1awTKRipJQsB6Z/KA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XuzshBu1sRH8rz/4ESr0d+ZbwwtS/4u8g3s+rIoqItclvd3V0f7iR0fsrolm1OQYIjUHwxjEtOrgFA70DtoOlhP3n5RHkQuQOc0RSlVn7azX9u9XUYiRfa2IeOHW09pNKdJU5IxcfL+IlWi3WMs0s1BNjOeQdO/FQIt8bnzeZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F72Uk8HH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F72Uk8HH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be8f7ed6eso28366767b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715018515; x=1715623315; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gs61+vEHfK1A5CqaImlmWdzNwJtN0dQgBykm78W0t8E=;
        b=F72Uk8HHQgCMJtg8dIFxvq9u2vdUcSlPTd5FPdbEHx7YQwH2SpsxNnoGRYVftbdjpo
         FzWSexwt7k4bgRFJcBn26xgkeJ4Mqjtreo9IqQtfqtfS3KlsKvXCpBUEPfeaz2exBhn4
         KcAW5QPAfc+FKprGZd6o6dUglVI0TESd6+bEm+1DQnrZY7zNh65Vuo9ObgnSb8L/nCl9
         UgiRX/j7XvV9bwk9fpc+vmXp6beGcUYHrEl6iq+MS+pJl+p69GEg0P4qe8QP+Ah2osIV
         uFDfng49qz3uNrcLx6BXQl6j+mCZaK5MxS1V5uc7/whI05jPG/NSFveLZsl70Ob85FPg
         wvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018515; x=1715623315;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs61+vEHfK1A5CqaImlmWdzNwJtN0dQgBykm78W0t8E=;
        b=Yn1omsIWlEueCNnsoMK6yHY9cEOW01wdm3b/pKAYPVBMZYuwEdHHpUDgJdsOR7IAGR
         447I/+80HfqjRkfel/ZkKPXcRAfHhSQnATTQnLHXs4WQO09ZMWSMzscoEcUUbSNZ71th
         ANif4lt/EI3U1OrvdHiRJTz5E7RUWzHWVCLLMMXHlV09Z4ciLbsy5eVN8S9uDQ4M30Sr
         I9MPbtkf9ED307bYMGVMzhS5KBg826p+wNN8dP/Yh68Sq4Y0mD+SL8VMioQt8nRplRxb
         N5ISNHXoxZHbOVkvAFwbMGjtwaMW3yxbSMVzlupI3EqOi+u4jdQKeCDIg9PKxcbBTJof
         BSTw==
X-Forwarded-Encrypted: i=1; AJvYcCVbUCo8HwKDNYOhKr3DhqWRYMb0eDzNCXgqfHcv/XtHQSOLhbkWE+GrtWxPzBEwlfsj9U8mx+1BDxZ7PPdTVBT0sHmkceyBowCqD/qcruwprQ==
X-Gm-Message-State: AOJu0YzLIT8tX8IbdDvC/Ua+DqHbbef2u1akC6l8DL3CjIvEVpg6E3xf
	snA/XS6OsW0mQr9NHY2ft/qluggwEC5Vbg3vndESeOiYxXgt4UqpHCN+zZ6aOa5L1tzJgbS+KUw
	6WfxXzQ==
X-Google-Smtp-Source: AGHT+IHmpR/kZ77gWROkDuGj7RyagbQ7fJ7wQtcFf7RNBG+mtFYr8arNJ6kJc90frUmzyys/IOnpbg7lqixv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91df:9b7f:c8d8:409a])
 (user=irogers job=sendgmr) by 2002:a81:910d:0:b0:611:5a9d:bb0e with SMTP id
 i13-20020a81910d000000b006115a9dbb0emr82660ywg.4.1715018515209; Mon, 06 May
 2024 11:01:55 -0700 (PDT)
Date: Mon,  6 May 2024 11:01:02 -0700
In-Reply-To: <20240506180104.485674-1-irogers@google.com>
Message-Id: <20240506180104.485674-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506180104.485674-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v7 2/4] perf symbol-elf: Ensure dso__put in machine__process_ksymbol_register
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Changbin Du <changbin.du@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dso__put after the map creation causes a use after put in the
dso__set_loaded. To ensure there is a +1 reference count on both sides
of the if-else, do a dso__get on the found map's dso.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0b8fb14f5ff6..a3ff2ab154bd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -683,7 +683,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 					     struct perf_sample *sample __maybe_unused)
 {
 	struct symbol *sym;
-	struct dso *dso;
+	struct dso *dso = NULL;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
 	int err = 0;
 
@@ -696,7 +696,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 		dso__set_kernel(dso, DSO_SPACE__KERNEL);
 		map = map__new2(0, dso);
-		dso__put(dso);
 		if (!map) {
 			err = -ENOMEM;
 			goto out;
@@ -722,7 +721,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_long_name(dso, "", false);
 		}
 	} else {
-		dso = map__dso(map);
+		dso = dso__get(map__dso(map));
 	}
 
 	sym = symbol__new(map__map_ip(map, map__start(map)),
@@ -735,6 +734,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	dso__insert_symbol(dso, sym);
 out:
 	map__put(map);
+	dso__put(dso);
 	return err;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

