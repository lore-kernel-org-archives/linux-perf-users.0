Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCA3ABD9D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192949; cv=none; b=D72fvgAOd9F8qlSsm9BUpW0WX6rg3Q2iSrlMo86Fyxe2doK6qeFJnfEBLbFo3j8pJyXXRTZxLUIUKzFTG8GkeARA7h8SVpCUkybriR1InzdrNhYvaGscEjVKDst1gDYu3/rnYH6hnq1OyPY9/JzL9TVZVcEMR4XtgLEmAw9e2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192949; c=relaxed/simple;
	bh=5A7KVlmZKh1fTGdXJsrQeP0bZNY7mic+K8aYC/cl94Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pMJNpbsu64TB36nQIvTNytG4Bvwvb1xrO2tk0lr9VawY2ReKlhoUnp89rt0GyNg2/7ModKrVhHJ6opFt+XZEzT14wcDJDA9jaiHAphU2XyvcRLEN73yUUjIAKs5xs8yVVlB3/wHp5FYuKaLOkhPxmj5ESuNe3QbNu2S3DVT1CxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aaR5Kppp; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaR5Kppp"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-139553dd8acso22633420c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192947; x=1782797747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+MJ/IGwOxEDbrcBVfxT8wFW3niWWvmzR4wMznwTBK8=;
        b=aaR5Kppp9aKFNbChWbnh9Sdae/qDNRe8aiJoFlrNKnl2YOV9Y5GVbWAPzej/z2N5Oq
         FCibau1pL3nvFNwlZlKIzeqe2qJwR4LD7csbu15pvZh7VZfZr0xvflZOoHYbtaZWG6cx
         bMOQsC2UfQR8Gu3fQXqRaRodruWcaKMBh+vVTlOWlR4htbnZa+Ew+LPXHQ7ox/dUk64G
         UhQ5n+pvXfDHoHTaVrhM3/BzK8apTjVf78e6XMDws1KeC9MA0x1mvJh6OFxjCv1ctXdi
         PGHwXFhQ6HQdFvCxchENe/NTNk3drRUmwHAJ6ZjmfOn5vqDSNlQVvfZM1uTKsJtBHEK3
         kV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192947; x=1782797747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+MJ/IGwOxEDbrcBVfxT8wFW3niWWvmzR4wMznwTBK8=;
        b=kXwJJ6bMOk1I9QQR7PO71VBup4E7RJ0wwgMfjxRUQuJ+LAy49mfwJZcF4gIunf4Q13
         0O5XJMjU5G6MK+w8CTn0mBjdaTYI1KQLqGqSvWbsJLHsgwigXSuetVZZOnb8VKp8xmEc
         prI/9tB0UWv31EUNGz/DPkJQ8qc9ikBN8T+7UZ0KIFwpPFcBD+7R7qxZGm1PW0Rf52fC
         oC5n+eQctj0R6y5Iq3Q2G3O60HgCJlypIN8yGFIMd5zW6gZxRCUhSRu+qKBGWvmc6hbi
         KNqX58ub9bZ3WUvh0bXeFybkgBqwyumzn/LNBC8Fy47ASN6mhDM6Dfk4/twJSmnP1/NR
         RkFg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ek6Q1W5HRVTEgf1bzUTKxiGb6/OjsO4xg2+HJqGa8xEa6MoIZPcGPbVgpyMy5TPR42jRDzVcX15kofCKJxsIg@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZzS/xWWO5AKJtRMWDDpp6LoiAH3F5hOD31m6UOZYC8wFHS10
	XdQnvHTlth1uw/OxeDlkIUoKZQGUmdEhUN+2Pu/bLgUY3j4S3tHNbiucA0YGHiXUSp/KsGqkuSG
	TQ6MiZC20iw==
X-Received: from dleb17-n1.prod.google.com ([2002:a05:701b:4251:10b0:135:b432:37dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f216:b0:135:608a:2864
 with SMTP id a92af1059eb24-139a3698903mr10998049c88.33.1782192946722; Mon, 22
 Jun 2026 22:35:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:10 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-9-irogers@google.com>
Subject: [PATCH v1 08/13] perf python: Check counts_values size in set_values
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The set_values function incorrectly assumed the list contained exactly
5 elements. Add a check to prevent out-of-bounds access.

Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 21e8b5a23a1c..f9398bc30a80 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1913,6 +1913,11 @@ static int pyrf_counts_values_set_values(struct pyrf_counts_values *self, PyObje
 	}
 
 	size = PyList_Size(list);
+	if (size != 5) {
+		PyErr_SetString(PyExc_ValueError, "List must have exactly 5 entries");
+		return -1;
+	}
+
 	for (Py_ssize_t i = 0; i < size; i++) {
 		item = PyList_GetItem(list, i);
 		if (!PyLong_Check(item)) {
-- 
2.55.0.rc0.786.g65d90a0328-goog

