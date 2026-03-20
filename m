Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F036F414
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994152; cv=none; b=MQIp4jSho5nsaFqkF3LYr/I5QJF/LAs4ZWiudffguxjpxiFDEMxqnZ+ycunSMTvw2k3KiJ47CYfS+hbqVRKmUjo7jCAf5LafRL5qkG2eDFrNTpjwBwlyuzIlb23ueotZ+NPbvs3qLERaAlVlHsF908+dmL2JJO5GYHsqoaO+VfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994152; c=relaxed/simple;
	bh=VBRBWOOsTuUZUQAm9Xp4jFDUX44iF/hvvynPgGnEBf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lHbfsSQn9i9gCsxq0Akey1b1qmLZhpC3gE6XP1sr634yuA4RoiJmTubqej4rlbPY+hwi1++GRwIAVvQ0iV/DmlXHmfpJf4m6XyouxroDKGBR/hxa5bX7hhbC3/sgwD6mVG2JwRjThP5RCWVpXU56RJXYMyHF03WSzVB/7j0qJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KHLBhhZ8; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHLBhhZ8"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128ba70cc99so1145033c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994151; x=1774598951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex7esaiGl8GWNlFO/kP2nPhlftSsne7shuQzPr/LD2Y=;
        b=KHLBhhZ8d/HIdw4cPZEZI+U2RYItkn8hqNqaJU/X1A2/H7XMNs5m8TNu17FyZz/bqx
         NMKFFV+Pt0XpjmSqiQ45CMJcj/BbXC81n7I/YkAqot3In9jefjw/4GAAu8WiV65jCSev
         1U65+mNe6ejw/2NReROasWq2Q634NddIQPY/FEdCnWieJFc8qlKJRhrWDYEknPTfF5A4
         Xe5P+iYLT8ZAywSCbBC9s3EweblWjHpzlmH7+cY0XwO0PfXqwlK1cG6kxEZ1iP9xtUzR
         oTrHHut2LDPVfYHHKq4JcL/85qUjEKIEaV2Iv7ZZ+OsnP4A7MTMjpoRAZiOxJfyWtLBK
         71sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994151; x=1774598951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex7esaiGl8GWNlFO/kP2nPhlftSsne7shuQzPr/LD2Y=;
        b=JTF+FV4J/v5DWPAscSBtUx41PDxQQPZANxJnSeUgoNCH5Pnge5rwfFSTQ9NJcqGMVE
         y7MyvHH0IgxWmAiygbvO5WapJcQWd79gCxGGFxHLPYmRMvBMR9/3MX0Mr9XVK165Fm7X
         vRJ9OSkokrUg/aGRRBRBhDZfYZOFQdNqVx9zgoYWBeMIs7PQCfTp/gEZxbMT1b5ts3KD
         9ANlsjQlTS6L8tIhVLKsoLwq3gRnVBsa2rSTxAKAs4ZWy5IRWOPhRKEleo+vW7GDYqeq
         r2ZK5Jye43vv6m/aKRRwkca6JDqxqRe5K6hENqFfYo0sfOaRPT5vnMXh39fnHQiddcd+
         GfHg==
X-Forwarded-Encrypted: i=1; AJvYcCWvjLIBdz+z/V8WR1Q1NDJjKj9rALxm9TbRQhUE4alxeDJ66XnSuU8uMCtfdpKbPlB54I6MNKyuWZDiboO1P8sI@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwOZ6q/bbeEbq4sIgNbmtY7LjXKilZ92hS72iOSEl9vS7R7+4
	0cagw1FlVJagW9uyQyj7Sep110pQUhBfnnqFbikY46RvHYRtIYdt+qgBbdxyQJwilqDemKls7f8
	H9jQoe4o/Jw==
X-Received: from dlaj22.prod.google.com ([2002:a05:701b:2816:b0:128:dd08:f36b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ebc7:b0:128:d23d:81a2
 with SMTP id a92af1059eb24-12a726dad8bmr964238c88.29.1773994150383; Fri, 20
 Mar 2026 01:09:10 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:23 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-15-irogers@google.com>
Subject: [PATCH v3 14/25] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1051d7b75361..d53aa7a94192 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -793,9 +793,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.53.0.959.g497ff81fa9-goog

