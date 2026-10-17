Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC43E4C88
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263299; cv=none; b=uuUQbXmC7QyNrXOP3Xq/rz8S0xm7S5nVgrU8xITGl69uJMknlBLF8tPVAwTjgEQH+Ij8MSENa4s4c/N7J7AY9S41nfyRUvR0aLk8fBwGm2wKuwjo0Einrfb3i7Dx2ZIjG9lYHosbXNuxJreMmymv4sJaoOhvUW/QApgL24AblqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263299; c=relaxed/simple;
	bh=pwZ9OQ6qL5pRbPWaY17g4pkRZiL7Z4DnY4iQm+Rw4L0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJ+Lm+S0bWpheUM5xoWlWBDH+K2PpiLM8SHUg5f02zfXGkc30oL60KQidBszgAm8AT76Tbv6bZ1WPrgGBoxwKCxU8u4yAosJplH+86LakDrXPf41tz8DVm1zQXxWCJrmH9gT/cIXbLbnukOXUyqwZi5/GxG9Lpcl22+Ha0h+6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZMKsRpo; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZMKsRpo"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso1967492c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792263297; x=1792868097; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e1adkZP34xVTQKYBzCVnMpi452Dqg9ZuiLZtb9Rgypc=;
        b=UZMKsRpo4V5HfpUusrhtlkYFFfRX9sox8sVW3fTz8D8CmuCu7CIhhcD2S9DRUCx9Nw
         PrWEJ8ZxVtWTUlFX0wAY+2cq9v+mD7o1MDdKD/LwkmfTcifBaXfGVHQAvshiQqKo1YKB
         u47gfbw/eEcXQZkuN/TNqGSCUFRbQJ2HgFiN7R2LLkYW7Rx7bJK5oGgUUiqjvfLRKr+M
         TUrv2m0MhvqOfNzkE97+WDHWCGdi99V/kY3t5572qWmasHnN7OZARxeWSww7fPrDzmcE
         X9roQDWRZuAE6vHAah61mmTVzNQU1+Ej4xuXQym8+09c+IVVAE7bFRwtYwOV/BhyoyfI
         4qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792263297; x=1792868097;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e1adkZP34xVTQKYBzCVnMpi452Dqg9ZuiLZtb9Rgypc=;
        b=IVmYYQerrggJ1x/xqjK2glyDIBezh99rFxkAnK6NjtVPqQOGOXsdgBG89dlA/chT1Y
         qsbAef63Xtk3mvfZexm/3SzKfRWERMFjtQOFkwMjCXt7LkosMd0Gq91JG/kpQ6H2yCEb
         h6YwAb9RY4wuE0ohOFHMYR6usHn6HA0KeTajPFb/S53gB+IL9GxdH2P7YcNuM8EJz1Dx
         vIC13xyqCTb5mvCsVkgZ9Jvj95sseNLZ5YPhHpLJ4AyiDoiRFXqExKwDcVvxAcguyCih
         3QQ9BAzyOmwQJrt6JEvau5629mUod89JtVZ6Iz8v8vQCRabaJDjMMuT9pTyLyT9OPWox
         GPvA==
X-Forwarded-Encrypted: i=1; AKwUvBw2PcHsmo7Z/LHKYAy0CF58Qb97IqMOWte1Fpo5m0IdN2NrAqoPK8YYyxmPh1/D+/D5/MiRCDqf0iZ+Tc+RXDuL@vger.kernel.org
X-Gm-Message-State: AFq9FYJOouZJGGg9e+fe0QAnO1wY/uN1qZdRU0yn9nCpTW8eSXHxKcgc
	BxcSvwPuKpCnLuNpUCgIqBKTaIM1PzNkH2IvC4QJaXBV3Yt6VFhhzdQEj4zNrMvw3KDE5Gbst1W
	1iXuf/dHwcg==
X-Received: from dlbbz7.prod.google.com ([2002:a05:7022:2387:b0:160:72ff:6139])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:907:b0:187:a2b1:7b3a
 with SMTP id a92af1059eb24-187a2b17beemr1334961c88.41.1792263296764; Sat, 17
 Oct 2026 11:54:56 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:54:36 -0700
In-Reply-To: <20261017185442.2137623-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com> <20261017185442.2137623-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017185442.2137623-4-irogers@google.com>
Subject: [RFC PATCH v2 3/9] perf pmus: Expose duplicate uncore PMU scanning helpers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, eranian@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Export perf_pmus__scan_skip_duplicates() and add
perf_pmu__num_duplicates() to count numbered uncore PMU instances
sharing a common prefix.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 23 ++++++++++++++++++++++-
 tools/perf/util/pmus.h |  2 ++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index ea727d577c89..8657b36767ff 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -455,7 +455,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
 	return NULL;
 }
 
-static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
+struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 	int last_pmu_name_len = 0;
@@ -492,6 +492,27 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 	return NULL;
 }
 
+size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu)
+{
+	const struct perf_pmu *pos = pmu;
+	size_t base_len;
+	size_t count = 1;
+
+	if (!pmu || pmu->is_core)
+		return 1;
+
+	base_len = pmu_name_len_no_suffix(pmu->name ?: "");
+	list_for_each_entry_continue(pos, &other_pmus, list) {
+		size_t pos_len = pmu_name_len_no_suffix(pos->name ?: "");
+
+		if (pos_len != base_len ||
+		    strncmp(pmu->name ?: "", pos->name ?: "", base_len))
+			break;
+		count++;
+	}
+	return count;
+}
+
 struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat)
 {
 	if (!pmu) {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index d1646f91036e..58ecab3e3da3 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -23,6 +23,8 @@ struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
+struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu);
+size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
 struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
 struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat);
-- 
2.56.0.212.g129ede20d9-goog

