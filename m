Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFAD3F23B3
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823029; cv=none; b=J42qhrRVCmf1ljkeVKVbKs9EUHO02f4/KGSeRAILKGVhySj3yN5qoxAlVHt9EoldYJ1Pn4sYhNI5QmL63SheSwqvmLDbnYXBzZci+TFueUsEOUiKMbR0Rfp9wMRrj9OVcqScx8pYMrHnYYC+1l3zawAUSlGPVt5mDDERCWKDH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823029; c=relaxed/simple;
	bh=xn8nRn3PBEai+XwhzmEVhdf0J3gdqLpxs/5746Rxges=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=nqnoBYHKZ/JGQw6l9a4WHe3huIM4RNMCVpvuP1QzG58JA9ZvvrKCpM2ibJp9/vzm8ThYHXEwO4TCaZlULWYT52a7Hv739LncwmPAoHExCIR4S6nffL5AtFs/Ub2/lYb8hVHXRdUvBWbT+IADjIc3PcbD5qpuhGryWLiZCLbWbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhyFh6kj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhyFh6kj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2be21c6e2f5so62537808eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 10:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772823026; x=1773427826; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52hfCZ16RpnGMPOUeS9KQdXOkClBKdKam0G4pLZQt5s=;
        b=BhyFh6kj6ZG85c8gFf9W94cLVAmZsmm2QnhJIs7NF0LTu78YbLaoa6OsCkulIxbTi5
         0o03ozHMQALhNA37S29Pf1fZvapRXN9ZqPaEi5ZlRSbmc0piPNHjMbYgGaPPU+M4QeKZ
         0cHiRKSl6o+SvdPRfUq2oDpZsTJFizoKJDsPUA3thEvII8r/+OrtyDvt+771GVHqufL0
         /abEoYzq/Lpf2tdqEvaIykf5dFp4xGiBZJbAE+SQ6czLZKYoc1ZV4ieMkdvazwmQmgEs
         9l4PXdcpxJPUqnIQIJ+tDr22+Pz7mIm90K0cUhNuF9ax9JjFoya+qRo2TWyN/CaPCjVl
         qNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772823026; x=1773427826;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52hfCZ16RpnGMPOUeS9KQdXOkClBKdKam0G4pLZQt5s=;
        b=NqM5Xz2faZA0+62XbBB4oQS7vBIwZwM/f0gMX8pceHCdp9Wl9UNZcbv845UXisYPl7
         /HX3+/7ji2gB/1yekr/mFu9aIuU9BCjxFO/AdEAJz9RfMiav5f/WPnRHyy1jyp9LRTpX
         fAdbUXG87Zujf9Rb8tcxKUUOrn4lsPEuZC83qA+h2hfou5KgPtMeny/bfzaGUJmeWfKf
         h3/1nIct3VIlGyvv9RrE1GVMXUItFC3cRGVfo/2ijLkxbTAYUJ4X9W999rz2H5shzqdm
         E0hWMrXIph/i4msGWguxJQwo/jgZXu9iFNfwHfAQ3EslZTy38BTIAHziUEXIvTt7YHbH
         xOTg==
X-Forwarded-Encrypted: i=1; AJvYcCWW96YHRuVwyXi1AZHw6ckTwHxrLNllSmWmhquZRGdKZM7IRVlMAx811Eh5nmt+abzxBzCifxNL2cOGRdeeurMg@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPS7Nb2vaAvUs59DUxHj5oVchov3pjXJSKNmQvJWdi5cmuu2a
	6p4gnqKmceMSR/J85XkaqZ6FYTMXjU319TkpvycLVdvbQkanCiK5cDBIeLwewbnm720YtHcT1VJ
	Oc6a6DqhHMg==
X-Received: from dyfv3.prod.google.com ([2002:a05:7300:8243:b0:2be:1421:f19])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1355:b0:2be:617:2dec
 with SMTP id 5a478bee46e88-2be4dfcc739mr1422007eec.17.1772823025919; Fri, 06
 Mar 2026 10:50:25 -0800 (PST)
Date: Fri,  6 Mar 2026 10:50:22 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306185022.2016541-1-irogers@google.com>
Subject: [PATCH v1] perf ftrace: Proper error clean up in print_profile_result
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The ftrace profile_hash is cleaned up on success but not on memory
allocation and empty paths. Fix by running the clean up for all. Free
the profile too, so make it NULL, just for clarity that this is all
clean up code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6b6eec65f93f..19e796e58fb0 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -18,6 +18,7 @@
 #include <poll.h>
 #include <ctype.h>
 #include <linux/capability.h>
+#include <linux/err.h>
 #include <linux/string.h>
 #include <sys/stat.h>
 
@@ -1369,17 +1370,17 @@ static int cmp_profile_data(const void *a, const void *b)
 
 static void print_profile_result(struct perf_ftrace *ftrace)
 {
-	struct hashmap_entry *entry, **profile;
+	struct hashmap_entry *entry, **profile = NULL;
 	size_t i, nr, bkt;
 
 	nr = hashmap__size(ftrace->profile_hash);
 	if (nr == 0)
-		return;
+		goto out;
 
 	profile = calloc(nr, sizeof(*profile));
 	if (profile == NULL) {
 		pr_err("failed to allocate memory for the result\n");
-		return;
+		goto out;
 	}
 
 	i = 0;
@@ -1403,6 +1404,7 @@ static void print_profile_result(struct perf_ftrace *ftrace)
 		       p->st.max / 1000, p->st.max % 1000, p->st.n, name);
 	}
 
+out:
 	free(profile);
 
 	hashmap__for_each_entry(ftrace->profile_hash, entry, bkt) {
-- 
2.53.0.473.g4a7958ca14-goog

