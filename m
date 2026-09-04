Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCA3C10BF
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551407; cv=none; b=jB1KqxvtK85ZwhO0VKkSzT5biO2lPDKdHhnonJw0xjFum5Q9Li8Z8PTLZx8/P9Xy6sS+0dwaS15V07nv3anGAnNhIIWu2ZyGPBMPThIGF6B5NwzjXq3R7qrOMHT8foA/cE6UeZ5rRLFsAWPpYOaMw5bEVuxOdCEiDACryHgI5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551407; c=relaxed/simple;
	bh=5ZgMDCkwGquoA60xxL2RxGgZZW/RACRs9YLh6Dt2BX8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=QsXrZ0W4N+5cODA3yLiFfVU59foQd1LbfkoIEZvGYhBeIWyPQri7wXcuYe3N1muhtDOSOvVOtvwLYbY+xdYcwbB+OSPcB/rAbTWtCBkBZGDpa3m5wIvR56vE5Jef02O0Jdh3NrlKnhm3f0q48DBBZ5BMUPQ8bmVG9JE6f5M/piw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+sVzjsN; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+sVzjsN"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6fb956002so18556955ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Sep 2026 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788551399; x=1789156199; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HdsG6fcfBmaq2Sjx7PG0uI85rwv0h/nu4vJY5O/MUH0=;
        b=I+sVzjsNhAf/37UbtuZsbwO1G2bY0siJcqiFzUH52vmLh5n6KArB80+vFsqIxqYc61
         +Ch4IVXzsvsVC6sL9OcFu/IkM4MXlLy0wsDwdsswLy/6kV6S1XxqaJEYPVU8/DGwpkHz
         MzopI8Is19CjDxSHj/2NM/aN9W71EZLZZ/keTRlJohhHBAcGaCkmCurc6cK9LUickrmg
         fvD9vb8RB83u5b7gjj8ImRz3Ixk2FhlmGZdsChcVfpDRzB2eh0ZfSANGsvjMvMCO1PE6
         2Lvr9Xd2wxTYPzjmZKh0lcAAKwPMNvNaQVUFf+YAVHbf1+Yh9+bLw3FAbMs8rqPG9wSo
         4/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551399; x=1789156199;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HdsG6fcfBmaq2Sjx7PG0uI85rwv0h/nu4vJY5O/MUH0=;
        b=IWF+OPm2nXfpyLEJdLwhNGDdAWM8EybSSm9Nv4XN7qA+DgBtuaudvLmmFhmTcPOWFw
         SJYwhSVkOarwgIwYNAlGsdKO3T70MZi3sBASVp8cj8EaJ5VulYlF0UJnLHnKyxqJkLT0
         wSlAKhEazNheum+JJa1V11riyaM8mxE8wcp0rV4nYtoIfMHcJdUPfhN9RGHC6GeldFKW
         VIv0GmlDSmNhm5F2G48AHYb8699cUtUSRZqB3VVWoJErlwNCsuWlzH18G9vlbZ2m72q8
         X+KhvTpYO1tDoxrbkpIRsh63R6h1EgUTuedka5eZhMLURg+iKeBaNEm7/CaPHaNjISBF
         +9eg==
X-Forwarded-Encrypted: i=1; AKwUvByOPGYhQevabRNQp4SMGOa6Gr4OYBEPAIIcgsyowC83VF6DoGYVWZQH92EiWSSuX0kUspV1qKXCYrXT/ZvL3Gtj@vger.kernel.org
X-Gm-Message-State: AFuF++l+/TfyH2k5/kC9j2F3LrYyeY3su2CcIY8OVwbZwOjs8JMN4rpw
	WQmr8CmvsPL6+n0tY8SizM6T3tiwFzBs4KTnKiiwFTp6VfoARINRI5RcDzlBz+5N6I2qduiXniN
	Qm7X4/sMSQQ==
X-Received: from dyx20.prod.google.com ([2002:a05:693c:8214:b0:32c:bcf2:5193])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7284:b0:3cc:f280:ebc6
 with SMTP id adf61e73a8af0-3da39eacf9amr10926007637.5.1788551398676; Fri, 04
 Sep 2026 12:49:58 -0700 (PDT)
Date: Fri,  4 Sep 2026 12:49:54 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904194954.1192154-1-irogers@google.com>
Subject: [PATCH v1] perf test: Avoid call to missing cleanup function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Zide Chen <zide.chen@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Cleanup function was removed by writing to /dev/null rather than
temporary files. The exit path still had a call.

Fixes: 44f6b4402791 ("perf test: Fix hybrid testing of event fallback test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_event_open_fallback.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
index 9420a7557c13..27d440a5355d 100755
--- a/tools/perf/tests/shell/test_event_open_fallback.sh
+++ b/tools/perf/tests/shell/test_event_open_fallback.sh
@@ -57,8 +57,6 @@ ret=0
 test_decrease_precise_ip		|| ret=$? ; count_result $ret ; ret=0
 test_decrease_precise_ip_complicated	|| ret=$? ; count_result $ret ; ret=0
 
-cleanup
-
 if [ ${err_cnt} -gt 0 ] ; then
 	exit 1
 fi
-- 
2.55.0.979.g7e5102b832-goog

