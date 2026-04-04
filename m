Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105633C502
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274252; cv=none; b=PNBZGXNVfVNi3tDsa7XMeWXlpZqzaU+1Nfc+6aLvp/kEKKQSi7ij4EUw1x/TC1TxAKbVc73YTcJOHkufGY9N9QA3gOrYAuwqGmlebc91eTLhEknWe0E66q+JEOyewbaAIymZl7e8mHPYKGhKd6iPgbcF49dTFHyzhFpE9OAsvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274252; c=relaxed/simple;
	bh=cLWE7bs+0Cxg9cEMpw2DCvBK22szFSANqxVQJFFr1kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j/Nd3A8Boimyduhh9NnZQrjPbt2hWERUIxjkTnciLSKPFObBlTKy8rAm946iN/kckIJnsLu2oRRxqzGMc3nFIknBsS8VKMwh3wIbfMaRubQ8d2A57CFSjTmwozte3VWyaKtudE0I/4PsXa4dXIQ7mgMypY/T2Eb73rmY4QJhy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUmMNxM5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUmMNxM5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cf362659eso1649761b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274249; x=1775879049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=EUmMNxM5ghE4MAIVMP7SQ3jLlqW+OKwiaGv75QACFDws3miJ5nOfz9Ks1mzAo22oQC
         GvypqPCEuWNVxx/+o+79GzIKLiOrelVzVs/Z3c1Y/CI2jjXgFEbzHAcKH8qZXvCJPrH4
         p+krKrZKAC/KS6PgO/B/FyTgIrx0JWXSMmhXSoBoxaBTJT8ubpLlGJJ+9kaldvqGVJk0
         2yNZmbyVEwFQAmCmwBCRwbwTclv5dUwO/UybnsWcf35LbRj5We3D14lUegiu48hGoH5i
         1qVzBo6V19jTdOmAdW1MgdYg45wXW1j6Ub5EQPHx14UXbO1XG3hfHhQMy9Hi/WAipRuF
         7ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274249; x=1775879049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=a4qYQgbR8K3Nm18dIkxiDFIFEiHkg0wPrit4jpA/pMo3S4ES91lPvQ09Mnz28XdIBr
         xrQOWvWjndkABUhKg+OiluQlUmkVTYR4ZUpGKCIE9b7z/qgs3DwPjKzTwTa8ClP+71Bn
         mFJOJ6RuHbeZ1TH3wpELBbjHe7VNWxHJKRVPEppYDnIIV4GNmIESyuKlsrjZ2COg1DMz
         U9Wl69aYnPlm8z0ZIv/izUcBmwpRTAd1izt2f5Xxmp/fxYnWXMm8W7vPF3pUbXG1EyEr
         9WnYHCUMtDJ2Xu0FCa9juzsukUy/qlGZuycW+nJ7a6YC8hFrZsurSbR5j708oLr+lQo7
         BUlA==
X-Forwarded-Encrypted: i=1; AJvYcCWVagen2K7vJjYRgTK+8qqsYAZGu/zyx9luSYVCmaqJe2Bfb5/7SyyWIWrkHNEwddFC7C/RXPunuT7BEByROMGz@vger.kernel.org
X-Gm-Message-State: AOJu0YwePzlSs2M25x8d+aSciwalpSVZeTG9mGb5pddNVGt/nmvqDIWA
	ocHNhrWcGQ/VD9m4sgp0HtyMaPDAsITs2E2vAWj5f4fhB4+PU2qv4Fa5XPP1zH7Py6mcz4oJZCQ
	VGAUFeD7Ilw==
X-Received: from pfbeq1.prod.google.com ([2002:a05:6a00:37c1:b0:82c:6ae6:e5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3902:b0:82c:9fe1:aa4d
 with SMTP id d2e1a72fcca58-82d0da6d649mr5084248b3a.13.1775274248877; Fri, 03
 Apr 2026 20:44:08 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:14 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-15-irogers@google.com>
Subject: [PATCH v6 14/25] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ff7117c5470f..3deb21f4d781 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -788,9 +788,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
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
2.53.0.1213.gd9a14994de-goog

