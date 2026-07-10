Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41523386C3F
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661984; cv=none; b=SojiMXegVeEOtRSz+xsjCp0K7OF08XXft8Y6YgZuC9l04IQyFeej1Ot4ojTlDde9lS0TAOGDA3Bc3ZM0MxOZPb6AqhsjAta8HEMg/BPX9jE4aX8zFq4X8tBbv015XSlwMGMl+MNjiHoqBI1YIG2/S9Ra+rZPDNAbU/oR9KGRSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661984; c=relaxed/simple;
	bh=hTEFAHtxkuaJOBwCOhG+9+yK8Q/tIA2ju0Tfcl9tdKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GehrovGmwbfnHOZtZqgNugBpnS/se8j5YPCmJavk6L2pRKIwaevgkm1uNlVEgQFleXaSz2vXmfO6m/gCFVD3tsN3Lr48/CAgQQFGs/DTpF39KJqBVzMVdVb/InDRXvLl4zvVpI8+7UPBCmPsv6j8wwnOP6kWRPTUqqmgrx/fTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfEs6EgG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfEs6EgG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-384419c6c74so904464a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661983; x=1784266783; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIZhNoNene1zs47xP+28Oq3PvnCrvAsWqTgfbnrd/A0=;
        b=SfEs6EgGPgrqRleYjmgQ0uapk8mQIjQ+w53aqdc49QaHe6YEcvYmumonp83gZbzhr6
         bV2lBoJeigl9U3SlfGWFWc/aSooe1/WXiu7+kJ1Eo8Fwxw4J3IXpk3Wh32uYPMY8PjoE
         grhHm9CUzqtcgSUBqLrI/B7UBXHKGXSlxwhb0D1XMWWGIgvKOFl3w3a1JbWzpfsZOIB9
         MXsaQ+Qd6m2qnSi3vtRxweK8TycEKY6urmhizC62n6Uo+YCfQdU7epulvzc2Y3JBlfQ0
         GiemL7tLgVAIzQs4wO7vWU0OKAveJfj0cUSR3u6JG3Xt/Ma32u5+HJqDe7MEpCOJY5t3
         PFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661983; x=1784266783;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dIZhNoNene1zs47xP+28Oq3PvnCrvAsWqTgfbnrd/A0=;
        b=l+CBbkc5fJbMkhWPp7bqYyYioeh/HGnuCQM9oHFrBonEwiJA/bMaEHKdQNrjz7nXpd
         o+yz11uENEMlhQ5Pp63Q1ogmr7pZ3zi2NBDl6BbMN1eaEgPbUnQH1ExegZJ32BUpGanu
         nO6/mmIVz9fw/4uZ2xpP7F1CiOBBF+Vzt3UjMfkCloDR6/dzGCKGG2zMYCcGJp2AP48V
         /DMFHxJsPqnGiSwt4CWBlaspU0OtZUR7EY2sWthT3YdS+LuVhWhTQFnqsCauNO44+Vhq
         sd6kbLG/DyBMZSCSVLl74/2W2qI3GiFBF5x+hkO44sFQ6xGs/IQaQnpwhIjaVDR8HkQf
         ugFg==
X-Forwarded-Encrypted: i=1; AHgh+Rpi4iafCbaRXMByBCisuFeZMjXKjdWuI2Efdc0jWm1p6Et6S3CZhEWBH31PpA6AF7jenzMPtdabiIpPhk4K2mTb@vger.kernel.org
X-Gm-Message-State: AOJu0YxOns1jgopIk6avP7WbFbCpPf4hS+IKOTzPawrHxMCOJLDFL7mb
	aTM8RhOwrzcjStYlouNSDqJJNI8rx5ALV71oYPIwToIVbxfPIJz2SBnpA/JqrdSqDNRIYUuBV0u
	BoTXMYZzxCA==
X-Received: from dldyq20-n1.prod.google.com ([2002:a05:701b:4554:10b0:139:f590:1d58])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1c8f:b0:3b4:75c0:3ec0
 with SMTP id adf61e73a8af0-3c0bca47f3cmr10871892637.30.1783661982459; Thu, 09
 Jul 2026 22:39:42 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:39:07 -0700
In-Reply-To: <20260710053927.1864021-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053927.1864021-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053927.1864021-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf cap: If capability is missing still perform root test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiawei Sun <abyssmystery@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refine the capability checking logic in perf_cap__capable() to in the
event the capability is missing do the fallback used_root
test. Previously this was only performed when the capability syscall
failed.

Fixes: e25ebda78e23 ("perf cap: Tidy up and improve capability testing")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
index ac6d1d9a523d..a2baecbc3145 100644
--- a/tools/perf/util/cap.c
+++ b/tools/perf/util/cap.c
@@ -20,6 +20,7 @@ bool perf_cap__capable(int cap, bool *used_root)
 	};
 	struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S] = {};
 	__u32 cap_val;
+	bool has_cap = false;
 
 	*used_root = false;
 	while (syscall(SYS_capget, &header, &data[0]) == -1) {
@@ -37,12 +38,21 @@ bool perf_cap__capable(int cap, bool *used_root)
 	if (cap >= 32) {
 		if (header.version == _LINUX_CAPABILITY_VERSION_3) {
 			cap_val = data[1].effective;
+			has_cap = (cap_val & (1U << (cap & 0x1f))) != 0;
 		} else {
 			/* Capability beyond 32 is requested but only 32 are supported. */
-			return false;
+			has_cap = false;
 		}
 	} else {
 		cap_val = data[0].effective;
+		has_cap = (cap_val & (1U << (cap & 0x1f))) != 0;
 	}
-	return (cap_val & (1 << (cap & 0x1f))) != 0;
+
+	if (has_cap) {
+		*used_root = false;
+		return true;
+	}
+
+	*used_root = true;
+	return geteuid() == 0;
 }
-- 
2.55.0.795.g602f6c329a-goog

