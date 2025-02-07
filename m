Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB291B87D3
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954386; cv=none; b=Y3ayx8v+ySqt6TwdN0o0h2XkfOf8/vxoOHrljTRyB1YKtmYT26lLSgAsIKQXVm28SeIki9zMNTyGZi2YxfmwkyQs8f7mAqWxmbIYN4pWswzYGPpnoG2yNWNps+zBzxOi6OYSDhDD/LJ4dJWVTJwxRBRCWQaedCOeSTdQs0FX1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954386; c=relaxed/simple;
	bh=BFPUfUPV9C28sQ+5++oI/Mt7czcCX79RjU67ZXHg4wc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QncxB6x18iZ44F+htbidKNW12tXgU2km4ZVM2tF+x/kbAhaVBfjEAkRvWxWsP/jaAdvOILJafehtFrrpStWoO6IMboIkMWtGDX3H6fDUh//NBbKegcMpBukOXpWx1S6q7gTxTvyLhvdkG3T20tyFx1B/FRgnuABmPOE1y6SEjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3vIPjuX+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vIPjuX+"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2c7746509so35862167b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 10:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738954379; x=1739559179; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1B/xiMtyqfDg8YY7mV/zwkOmMpFHIKV2LiJJcfRRg=;
        b=3vIPjuX+s6Inp0AMKpS2YPv/Qbg53/Tk0wGQFEA52aHWpkf5+pCRAvIXLkpyWZ7ouD
         gDzwz15i4EBFUaHyEmcnly1pzQYaoZpfXLpe+/ILxFgJcCe4Zwblfy5gTlyDRAV02BmE
         EMTL0cYcoCnNYo5D950ysCBRtNE1wN/pOGyBelAtTWgA0ki3k8Qp2ClWEeROKabNvrsS
         a/75nuWHuGX5C7h+LLAe8bWz5gLMKmiYRaCNtTyAcK4FDa3Fs3qTJu/GWEsnlP7Oalyz
         Y6VOcd+G5DyCRltsJWWoYmtFgqnMsUKxHaHpzuxRJjOLfyC7T1DPIL/uEvi33yHXxZtG
         1cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738954379; x=1739559179;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1B/xiMtyqfDg8YY7mV/zwkOmMpFHIKV2LiJJcfRRg=;
        b=JlTCuj5ybAM5JeiyvuZ/EnklGXcA58AoHYKmu39N1cVy6Dq3XqA6Ex5C7OwKJRcoG4
         1IZySuLp/pAAxCW/0l5x/QMFeD/RcwEN9225AvKFt/RNELxVZa7zW3zthAkdMrP5TuJZ
         3ApAlBmhuL2P092pFVPrW7frGfCLVfB132zlHEgEN158xEqJVROzpH575oPepGIGW2+n
         L/Dqs+FgKGs/rJWXtGpd6lNGbPB8ctNsWx7SZF9Mssp0aoc3getBbU4exs0X6Wpb7FoA
         q7zYfiKg8UwVJnI9dL5whhMnn9rhiMddYd+cgNeH5naOey46b12YgegR1o9P49yj3gEu
         UEFA==
X-Forwarded-Encrypted: i=1; AJvYcCVRGPFJNtoA9ptAhiZB700fyA/evhMSgRoxl/BftvPQ2/Q1xsSJqo0RazCfawNINO3nNNAdpueYQaY18nU7uQSo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0MT+8cBuADQDGL8TQ/hzfO8b5hENsinUCCb1QbqPw/ODUsCx
	UprBTnZu7dmcilQfzSh4uPXRmnVd/O/2EGH+cG7Cn1wVDs5CF8+q1nfjwz9yh2DB0j0eLAfvfff
	iMjG5xg==
X-Google-Smtp-Source: AGHT+IELqhbXBBd/48IvMoXbJtPfI6Vvv4cdbKhtGN1ZYscc5TqekcZtCIoE1dZxyhVthH6OC0VrdyzcJA15
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b8a:b0:6f9:b168:5e33 with SMTP
 id 00721157ae682-6f9b29c0e96mr311807b3.7.1738954378758; Fri, 07 Feb 2025
 10:52:58 -0800 (PST)
Date: Fri,  7 Feb 2025 10:51:53 -0800
In-Reply-To: <20250207185154.824433-1-irogers@google.com>
Message-Id: <20250207185154.824433-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207185154.824433-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v7 24/24] perf test stat_all_metrics: Ensure missing events
 fail test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Issue reported by Thomas Falcon and diagnosed by Kan Liang here:
https://lore.kernel.org/lkml/d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com/
Metrics with missing events can be erroneously skipped if they contain
FP, AMX or PMM events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 73e9347e88a9..ee817c66da06 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -20,7 +20,13 @@ for m in $(perf list --raw-dump metrics); do
   result_err=$?
   if [[ $result_err -gt 0 ]]
   then
-    if [[ "$result" =~ \
+    if [[ "$result" =~ "Cannot resolve IDs for" ]]
+    then
+      echo "Metric contains missing events"
+      echo $result
+      err=1 # Fail
+      continue
+    elif [[ "$result" =~ \
           "Access to performance monitoring and observability operations is limited" ]]
     then
       echo "Permission failure"
-- 
2.48.1.502.g6dc24dfdaf-goog

