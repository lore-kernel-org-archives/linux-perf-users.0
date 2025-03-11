Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B4264A9C
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729015; cv=none; b=ZYeOzTqlZPNfwwRAoGrakmUdEtXuWYwO8yTn30puLfZHTDFjrpTgloSUNRKeQllBLsae7yXkjjwZSiBnvwX5V/BvPgwqjZEbGezj2q0TH4cRmWNhF1R+gi49b7MkCXhVYCGkIUbFQc8qn1fuHbBijieAFGPxAoseBhH6AS9hXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729015; c=relaxed/simple;
	bh=H5KlZ/3j12Z08b+bvKiJZqtJDPyp9/HVMV5Qiv4l5dE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Cxj4Ga44LSBOBbPL5QJAOCZ2GTFVRsElYT/MMbxqUx/jsD6CKoh3Vw/hz1BRKsze1dYEH+FzI0/RqlkKBYyKi6ezgFXACVn5ua4noOC+zdC0WyavMlvopB0nyI2v99bp/PEApxnOl6qfVB7bZZlik8cUjDzn0PCp4qs+MDsszcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZWUnlNa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZWUnlNa"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fda4eaca22so56935387b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729013; x=1742333813; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x49RrI+y8H8e2leJnO29XuD2sUnGFNr6Kwf4AQYViPU=;
        b=DZWUnlNaCNCquVIc5nwt+bsNrXuNop6icM+/RW3fXmpaqZc28h1t5tCp1RK9cDg5Ee
         JTLkd4bHpwK3aENDpN1/b/tnsV5GKqTHyGTlLsf5MfetXHzu4rF4pLAbdfFOcRV1lIXF
         ilJHVXCGMn4HEuwCgsdH4x3pWjh8/Uzp34OrbERfvwjMIDbqi5DNb4eoMF5QuIb9TYCY
         LOiQeuXggoecva5IloHvrODVEoRXWxQft/ogZ31QRLrFwWMvcO0BUmDJ/ny2tYHT6vCf
         c7MVcNATPbtrM2slCafZG2uzKQeU9+xMdWaGcK36Zw+dE0qGOfexhRkJXw/k+8GPknFd
         7Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729013; x=1742333813;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x49RrI+y8H8e2leJnO29XuD2sUnGFNr6Kwf4AQYViPU=;
        b=a/cGQyD/z2QrYFfzKd/6bo98ohH28fbb2upJ4gY0U2en1KiBZqGsddHu+WFJuCEdj1
         47W05Em/Tt2Pkcl8sFriaTHXuIy8hLXKrdso4tUdhSg4yhLYQsm+U4+pVIIXCCXSDaF/
         O7IwVxz/sbx1YOJz24AXd6509+Ieq4Hkj/ExMkwfsxZD1AX7BPLckryz7dDlNrNXImJE
         8lwFBrndOgwEqB+AGYvL7t+pzbf9zbVF5RbJ14B2l6e7IvfY00v/YoTfpBidUwXYromd
         3w44HJUrFdBhk1rpOAi0KVSnaFYQ00wCgQiv3d7sB1SCqhHuaEWwYZDwaF1ojTNTxRnE
         6AZw==
X-Forwarded-Encrypted: i=1; AJvYcCUQeTWBe/X4RLTwx9oo27kIMVmOn4oukvimI9TVDYV/y9HuQyA6Z9JIeI/feTL767+k7GIFhImxFsvPkZXqeZE5@vger.kernel.org
X-Gm-Message-State: AOJu0YwbktF8WzSWqEn39zo/GlA/so52vWqGvsGjaMvBkDD/0GOaGTi4
	JGkJgfWWIXjgi6kzElTBhHS0vD1kEsQhVvnITERW2quMPCBDsRzVKqXOck6UtoQyXOFmC8LUpOW
	snQJqqQ==
X-Google-Smtp-Source: AGHT+IF707m7mSPSEPJ18g9nVYQMveMRUqzHp/qCqbZlWYKZv4DrdCbj7BwpwXO+5c3lZla+2IjBtWNsAMmF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:48c5:b0:6fb:45b7:3b41 with SMTP
 id 00721157ae682-6febef7c8f6mr24077917b3.0.1741729012842; Tue, 11 Mar 2025
 14:36:52 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:27 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 5/6] perf test: Address attr.py mypy error
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ConfigParser existed in python2 but not in python3 causing mypy to
fail.
Whilst removing a python2 workaround remove reference to __future__.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/attr.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 3db9a7d78715..bfccc727d9b2 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-from __future__ import print_function
-
+import configparser
 import os
 import sys
 import glob
@@ -13,11 +12,6 @@ import re
 import shutil
 import subprocess
 
-try:
-    import configparser
-except ImportError:
-    import ConfigParser as configparser
-
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
     a_list = a.split('|')
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

