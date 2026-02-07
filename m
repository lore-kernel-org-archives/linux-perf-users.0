Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B320010C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505496; cv=none; b=MnpAV9ChlHLNEm9Iw8htJzy2IvG2QkzR/yFNwLx9ZUYOFSGUddi1mnugUYtcHf8aevWGqioi+04ZbqtQAHh6MbSPYZG2Pf8lZC/Nzk2Zie/Wbf5BUR//f4v0xLhZziJvgNdyFR5QGccTJdc05kdwLFcSoFlAo8TOy4s2rRKu8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505496; c=relaxed/simple;
	bh=mELfxSSY6zoOSFfkBSlf0zAGt5+XwtRsgDtuV5x0uRY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RLVw56w+zSas0EjIRF0OH2LVFnROPitlbF6oj8s+T66W+FSBHb4JfgHq9zcjYChzWcxbWitmNbC7T9Mdsn7GtO7y7d2euwVP5uq8qLniQdMrVj8yygk1AjUN9V5ABX95TBYitoguuzVpHYbHeu5G6QHNi+p5vJfFD2ugh1fQySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4IYu4Sl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4IYu4Sl"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-352e195f662so2679651a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 15:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770505496; x=1771110296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5vcqIEn2vlnoRzJuvmWBvZIAcRO2efq9q7KJIsflUtk=;
        b=a4IYu4SlfKoCYdRgLUMUqw/t/arK2oN3c35hNvJW2LxGJ+L/2zx9Bvy9QUlP/ESmAQ
         yj/CcbTsyh/laWRSe+h13sdb5uCnyUHaCl35S3674o0lKTrRyvLctDi9gy1qgT8DtihK
         qd4YasY9zedpQROV1bFFu8gHh441QzHzAvytevc6s22vxqni3hZwQlJczbrG1eAyt+fI
         y2Xzc4y+ZDVoaSxp9MLYtayz1JVE1pOUBiKHBJG3l7Mw8+LZ7DB2SzeCBscIVOxbomkg
         ji/ybHV4MiD/2hTWxcLEovoG+kgoBkphDP5PY+IFrYnNmB5BKuNYEdae2grDlXk4Yy9E
         s06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505496; x=1771110296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vcqIEn2vlnoRzJuvmWBvZIAcRO2efq9q7KJIsflUtk=;
        b=P+zxBpsVFQe+pn5HfGwYxWwrZU63r5c6P4FFHqnwtmT+WHB47offgdCMYFQqPxsIJY
         mcmnomJY7+aTYCw5KJ51EWD+qPHpTe7i1rWX4brdUMV+jMN1uDrwHYP2lubP5gYZIW54
         K4+Z3TkAFvH2hOyNE2TIFgTDWoYhC4GhSmal1v1VKB4hAyNt2q7tgh7dvoz6zQfSEwBX
         c65WMNDr/Sv+z0Vot40fTgwaNKmPq0HtnA4G0Qwp10u7RzSQ9yGhHo+DtFghuMC0MPHM
         gxaUBeqZ7ZrVnEBIeZ2lZPY7JrDIqGD7DP5mcdGIVZVVTV7e5n2HC20Fb+VW4AHXvqiq
         noKA==
X-Forwarded-Encrypted: i=1; AJvYcCWMm3405ljji2qgyxFsfWY9Ky5wX8qctthJBkw5zGFdfgP7wHircDxcyqteH/2mWF2gTOUYF96+UQvYX1q7QRut@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZBgfynbuVPwOC2B6EO7GWfQnvFxZLuNDC5KYh5eliub6liGu
	9EukgdGcX8cAdO2AxVaEmQ851cgZbVhAFNBn3T/tdjUc+S+NLdnN4oUJWDRQWnyP3ceuZOKq1Pc
	WM/X2l4AP7A==
X-Received: from pjob16.prod.google.com ([2002:a17:90a:8c90:b0:34b:e29d:f74c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d44:b0:355:35b0:8b83
 with SMTP id 98e67ed59e1d1-35535b08eefmr2578852a91.33.1770505496019; Sat, 07
 Feb 2026 15:04:56 -0800 (PST)
Date: Sat,  7 Feb 2026 15:04:52 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260207230452.1886143-1-irogers@google.com>
Subject: [PATCH v1] perf test record.sh: Fix shellcheck warning
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add quotes to avoid the following warning:
```
In tests/shell/record.sh line 264:
 [ $(uname -m) = "s390x" ] && {
   ^---------^ SC2046 (warning): Quote this to prevent word splitting.

For more information:
 https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
```

Fixes: c73a56ed3c97 ("perf test: Fix test case Leader sampling on s390")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 46b96d565680..7cb81cf3444a 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -261,7 +261,7 @@ test_uid() {
 test_leader_sampling() {
   echo "Basic leader sampling test"
   events="{cycles,cycles}:Su"
-  [ $(uname -m) = "s390x" ] && {
+  [ "$(uname -m)" = "s390x" ] && {
     [ ! -d /sys/devices/cpum_sf ] && {
       echo "No CPUMF [Skipped record]"
       return
-- 
2.53.0.239.g8d8fc8a987-goog

