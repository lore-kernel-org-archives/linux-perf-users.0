Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A571B043F
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952474; cv=none; b=eYnb1JPu4r5phlQgkggqwoYk+dZ+KXR9eHI7EVEyr1Qzm1ZHp3dDpT2wh/BSCz0ySW+TPCbOLM6nra1VVDv3SVsmH1nGBra3nS04zctD4UvVCACiOZer/GOELsxDnPfaMnBPswOiSJtm4/CjKGy2x+SYXXO+MDWNc+cMrXnmhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952474; c=relaxed/simple;
	bh=BFPUfUPV9C28sQ+5++oI/Mt7czcCX79RjU67ZXHg4wc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MP03VF6qWplOhFuWYt/vTO6Dr3m+ZquVS9bkcH+A+oz8RvzoF+0E6k83wIGIBff8bLenQiZpO2MtsEfbmlnEx1wdqpi44T8zSPo/Scxxy7j4DwVjF2i1rSw97paVVD2NQzQU7YrgrQVZQsT24JCgJCb3zJO1Vlrd3dS66rWQ8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lHGLNkT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lHGLNkT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f774360029so43224177b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738952462; x=1739557262; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1B/xiMtyqfDg8YY7mV/zwkOmMpFHIKV2LiJJcfRRg=;
        b=1lHGLNkTlFfs0RKU0oMmU1f1mYihB82iE5UsB9F88z7oJMExu6zc9zehwtX2MDT1L5
         JSMzybt3KmviOvLztALE6tSogZbKkX+xj4/4MYRG1iYUfr3N5m0fThcozYVHDVdRyYqP
         zjyYt9w2gQAuRpHgNnZmWAcoW05OsrJxP4Kt+11T5w7IL+0l/pjU7Oel5olyx+TDKU8g
         UjllTZ6gWEtHfvOXg+1bp/oa80U/jTPJgLQR9fw9JAxZYROHpFquDOjAenCP9cgbeTyE
         ed/P210RB8X00SEVTnG5w+9QAa/vhhlrHnDq0K78wo8ePZzqbTmRINfY2sGi4yZPMsZg
         tbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738952462; x=1739557262;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1B/xiMtyqfDg8YY7mV/zwkOmMpFHIKV2LiJJcfRRg=;
        b=GYo96u8Mn2HsqLG0cnCoe7BSjVXcjEzQjKYKyGxqLYZ28dz+qW/3zZkzHM81I/yJ51
         CzSgyclKe+Za4g35zsKGU3XgXitfIf9NwRzAddwnxoViXhKpVcIz+Efc5272tmYJDP0D
         4OgBNAsu1GhikUI5c2BUZ88maxtPgajWnZyvSRrgj3K+SGy8n3/QlLGBRaHiVieSgsJR
         4H5f6vMC7GT3XZQnQ+Tsg7cxru/Gl11wD5fnXGDBSqwCWjpq0TT+AZYpUcgA2zTCfoFk
         ARNtgUJO2S85WveSY3dtH+JcYen945SvQv4QR9ZaN29bUvShv1meYtH3/aXhVGGyiBFL
         lKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV97T7GresCfjws107WTGahTyoX0gdracEf5M6EFcodmC7ib0ixjigZ/BfZ9eac0Q6nbp5n75szVrhEON+CMkd4@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsTN3vkW8iY4TV0iQIV8HffmMgYhaztvcxrbZ9GOgQIXi5asK
	D43cEHBExXyIxmdrj8jUKlmG7CDTOaw6RvkbKKpQYvHmpbTPokHQyRbafXdH5zNgK8dw00p/LWb
	jJFT+kw==
X-Google-Smtp-Source: AGHT+IE9nQpJYQAPqABDSpxfPZLeiGhu7pUsYj71K+2YZn/FOwykQoduIPN2YQ2O5PvMZXOpJnpFdfgF8pTZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a25:d890:0:b0:e5b:33d1:cbf7 with SMTP id
 3f1490d57ef6-e5b354f6044mr89852276.4.1738952461878; Fri, 07 Feb 2025 10:21:01
 -0800 (PST)
Date: Fri,  7 Feb 2025 10:19:58 -0800
In-Reply-To: <20250207181959.799610-1-irogers@google.com>
Message-Id: <20250207181959.799610-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207181959.799610-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v6 24/24] perf test stat_all_metrics: Ensure missing events
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

