Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284103644C3
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614147; cv=none; b=iwlb1B3LaLwgYVUL29my2VbD9ATxssVwhlwksbJwQgRaHZd40uLx3cDAXfaWqpY1xy1THHW8Ftuj1H7omn/scUl9gwCCvOxwcPmy0NX1SiuA0/9gSxF37ooSNrAP+Gx+nZrHo1AbIaspZ2AJa/HjkOtnywUFv5ToWVdrxTaCt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614147; c=relaxed/simple;
	bh=ls6KccABJtS6wEi5zCOCmpl36LobIF43ExSR2l/KAsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1UKjQBfcAQngaG1GtBYirResVWJR0s0itji6Uo2ifuDi8HEdw0K+hZJfh0FUU5odjEyycBhWq1Bs8hlVJp9StF7f0T2eUH0Ji3BQyk9z6D9mj96s4ZCtEdW+H2GoNwdkp0nKbbWmFV2+3gyvDLPAzi+40ETaE5LgVHfjalyCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3TsEPTa; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3TsEPTa"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711ec96fbso22464607c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 19:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775614145; x=1776218945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuodUyFXg9dje1u/LSyhIGJhaibjnsbjKrE5jzp9X50=;
        b=l3TsEPTaT/+0Ns9HoVTiAeq7fGBXj4LZal1R59Oct24ecNG0CS/7wuhAzjqCIZad7l
         sBtsyhGmsZqu/yQt3wIAX1WEATWk3US5dzajqYNIOfUFCoj271nylk4iVba/OKgUuUj/
         g4EW5KqK65JDuqzFtNzYK964YK6DvnWsAcOCCQb7hQktqCG1ZP3y31C9+q7lo9+cN2if
         NMd+uoO+R1M2Ct0ncJee5UuxlDSbN003IW8YXl6bgIYS0xn/AsSv0BUy1sBy5x2qaBDe
         QownMVyblWtwORnE+Frbf4dXfF+B6teApKxgFNsExNxMCXlV9wtUuPs/braDJQ3/Q63x
         hm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614145; x=1776218945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuodUyFXg9dje1u/LSyhIGJhaibjnsbjKrE5jzp9X50=;
        b=dBSc1J1EhhyvtjTuq+czRFRvyx9fqU3FheHuejOAozH0DSj3eyxLDMsa59shCmTuV3
         fJAoUPDC/1IU6uFlb7SvltYJuvE79C0vLigH28Edy2DS3XkAJYJKHQ82L3zcxX+P09NK
         wfDShlpQUUkAlWSM+t6fXyaWTiJSkA6F94GgsZrM0b9Ta7Za3NwIGoZNWvTTG90Ywdqt
         bfbg9EZiSsaGcrcVII1wiDetm3W39DSFbEG+fCGCWR+7Sumkuws0L569T3vuX5c3iwcK
         J7Qq7NztzgB9VdCXLhqj7HyMVGY7TJp4vOjwGpyq+DoLAHmyVhVpGeYmfGQ3gX1W8uJB
         nAvw==
X-Forwarded-Encrypted: i=1; AJvYcCVFDInl7WZe48gtt8xmxpxdk2EZ+4aMRUTbJsPzlvDeB8R9Yds0tUFnIaHBFWgoMAfb05A/QR8P4mJwijUthN3s@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJnE0ai3Px5oNVKUJZS3IHrs9VnrjhxNVqjTBfBPFYLq66t65
	02HE1BgKHHArB1eSHAtp58fPyNRjgbfYgd2bWpHXrpXiECfCZi8n/HWsh7bLW0KK7hoA347dKMT
	nMPMQ7R/zhw==
X-Received: from dlbpu11.prod.google.com ([2002:a05:7022:e88b:b0:12c:20df:7530])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:52b:b0:128:d34a:320f
 with SMTP id a92af1059eb24-12bfb6fdc70mr11066133c88.12.1775614144679; Tue, 07
 Apr 2026 19:09:04 -0700 (PDT)
Date: Tue,  7 Apr 2026 19:08:37 -0700
In-Reply-To: <20260408020838.166906-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fVqaqNo1VyGPWhZ+DvEv+oRUU=sMtBtpFbm4D-sJb-JNA@mail.gmail.com>
 <20260408020838.166906-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408020838.166906-2-irogers@google.com>
Subject: [PATCH v3 2/3] perf maps: Fix fixup_overlap_and_insert that can break
 sorted by name order
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ctshao@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When an entry in the address array is replaced, the corresponding name
entry is replaced. The entries names may sort differently and so it is
important that the sorted by name property be cleared on the maps.

Fixes: 0d11fab32714 ("perf maps: Fixup maps_by_name when modifying maps_by_address")
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

