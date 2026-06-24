Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB51325706
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278173; cv=none; b=tSJvXtUPQG9/g9goWCQFi3NOkPQ/QwUJuYAcXZAK+d+FnFfRk4dSDUxxsgJIrVkLJ9Hk8RNL07TjmPkuQfqNjQXzcwROISJXxLQ9F+73B+uG7s+IeFxtk/NmlT02WSV3Ix5fqPt9OVxww9u0xsv3flkkyiQKh0UJNVdWeXJCD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278173; c=relaxed/simple;
	bh=yBgJxLFlM8XfS2AmTQ1euX53AU1ZCMgDXuBQCLE6iuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=meYc8VBDHi610Cl5Ygcz50nZVo3RwMuGKbJA2nriXHsaB02xL0KlnE4Dc18rVOh9+nNmoUX3J0N5H6g3mTPc+zq8wURCcvVG6SJYB2bgzG7VOmdTIQxwNdiKo0c68J7EzO+G965s71hLAD5hG3NxgqtkIDBkK/4PFhCBwZCt+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5hbBZDs; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5hbBZDs"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139553dd8acso1219033c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278172; x=1782882972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gmw7pU9fNjTzs0L46fsauUoX5XHvR/H/XvPyxAUTAOY=;
        b=C5hbBZDsfVYh+nvxoHqzgvcSmfJBwBfUvOhB+xhUwuiEFPUa27ZT9Qrw55SbF7sXMk
         MpQWIJfuFaNRqkSZc4ZBzB+sxu+E9SeSNmoKxI2QamXku9v21F6xTTtSEekmn2zeARez
         6mjwlt/TRdLfi7NhK6MVRhxu8RLptDduhLsKUGgvt9QTW9+7L9zrsmgmdx+6kXrKu+51
         ldqQgObtcG8I6stbW6ALe1hIeMRN3n28ACG5VepbNI1PfGIdTcfqZl9DBZff9AEtiHBN
         2k4Vxa0J2XaFoeOL7Jsk714nu3XY22gqeazJMEoBmsapaWjlNNcEJyskue0SjbF6nmCm
         MpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278172; x=1782882972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmw7pU9fNjTzs0L46fsauUoX5XHvR/H/XvPyxAUTAOY=;
        b=r3v6OjsC2cAIn6UqXAFIEcK+1oIM54oU6PUVyRLdnGc4FbZo1Ft2S3WwlR4jln+qxc
         LaGAG65NDTwbjkHJs5xvRNEITAIjMSwrVGjmeAtHwEfLP8l4fW7qfzMQIR38+YCLojIM
         X62jWTgEfDlIbxlH8gC0ZhxTHdXEnVyKgv5IfTQd8pDhRsfyDUPtsQfxbTji5z2sNehv
         tZuynj5U9gJCw2jAGVWw5C2v8zGYNwNHzWfSM//JTL0BXpGA9Q04piYP0+FQ7HN6DhNk
         5lkVnjWx8rAxcaKSpwcXkXc3uZiLviZhd0KFayqXkwv+i6LysE5HW0QOfmJAtnuA+iOG
         gwlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Wk6xv9xfh6aWlg2zY1IrxCWm5HKIx2SvkkBKyWNS2cKhwOS06BeqadD8Z7H0vuz8O3X/yRRdT/YXwpQO9Is7h@vger.kernel.org
X-Gm-Message-State: AOJu0YxPI+xUFCME8JrtSd8Mx/mU/mpjdvn2uULPJCug5g651vJmcThs
	tx0HT/KYpIXxAEWW9SmtD2bNfHuzDI36zd7PEM5QkKvvYUbRv+XTpVMI/B0nGRiHOrwxNOfaD9Z
	QJ4Ruh3O/ZA==
X-Received: from dlbur9.prod.google.com ([2002:a05:7022:ea49:b0:139:c977:96ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:419d:b0:139:90ab:36bc
 with SMTP id a92af1059eb24-139d0cf69e4mr1575473c88.38.1782278171339; Tue, 23
 Jun 2026 22:16:11 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:31 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-15-irogers@google.com>
Subject: [PATCH v2 13/16] perf python: Fix MetricGroup return type in perf.pyi
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The metrics() function can return a dictionary where the value is either
a string or a list of strings, so the type signature in the stub file
should be Union[str, List[str]].

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index f266c9baffd0..58b0b3ed819d 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -1,5 +1,5 @@
 """Type stubs for the perf Python module."""
-from typing import Callable, Dict, List, Optional, Any, Iterator
+from typing import Callable, Dict, List, Optional, Any, Iterator, Union
 
 def config_get(name: str) -> Optional[str]:
     """Get a configuration value from perf config.
@@ -12,7 +12,7 @@ def config_get(name: str) -> Optional[str]:
     """
     ...
 
-def metrics() -> List[Dict[str, str]]:
+def metrics() -> List[Dict[str, Union[str, List[str]]]]:
     """Get a list of available metrics.
 
     Returns:
-- 
2.55.0.rc0.799.gd6f94ed593-goog

