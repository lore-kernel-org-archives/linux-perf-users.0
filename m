Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF9145B2D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968376; cv=none; b=c+TFhB3X15tUOhsWzn+ElVZE2Cy4Vq5ynEhs0sjbDljybLdvTZfXxmr0zK30LU/SD3fffdUh3Py5fbEefPNszqeqIYe3TSkRlTJBQl0+CH93Q4dZmbr7/kvzhfs8ZjGwX9Ksw//+yAGBcVkV0LzK5pHybtFS3x51B2wfJjGHWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968376; c=relaxed/simple;
	bh=2Mcju2GLkOcjIP4VmHebW0u9y/4mznKlV2xvs1tiG0E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=P0y/TGOh+hZB0NCh/L3A4iIXL/uHK0wCp8o9QucKOVlsPxN5K0ZYH8jXidWNK+OJiockrSFLkXmGRKNnW5XB4I/d1qOyi6/l7WO+9yMZlTO4U769zPRt7x1swnsGSKzbZ/X1k4UCeeDVvIGyrcB08AhS6k8Uxt0AnxU+v+iy3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pv40Lpp/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pv40Lpp/"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e617562a65so65063497b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 16:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968374; x=1706573174; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3mpNhly1K/FvbNZbxoXHC3VDHfIYZfutn2fVhIXUKE=;
        b=pv40Lpp/n6yPN3Jz8ClUDW3t63AozyP4SRlbgC9zaXuXXJLf2XZvSs1BRiSRM3Aj8u
         s/exOBEDYj+40H/xlYV3PwZzoSdGTLlmPKKJ2Fkis4r1qUtQ/AtB2SQhB90VznqqE/Em
         NIR2VPswNSCQ/rKuhJpq7i/cXFlHamW9YJUXdBv1weHY9hh++yJEsPT/xrJxwHrbydT6
         C45nTaq1UUNHF/M7qK7i1e43m4KtXuz9/2InR56vI0bxK0DpYJx/ipLvYFha97dF4dYC
         ZXlf8f9lZNaa+wg/qrcDOOCubN3EQe/ceuB6jNB9C0XaESgjnga/RN/JVyevbjOwKxj8
         rOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968374; x=1706573174;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3mpNhly1K/FvbNZbxoXHC3VDHfIYZfutn2fVhIXUKE=;
        b=Wkl0I9tqANTHUSeEALVSj7NdrRJ31M/wvyAH+KSCzqECy8uipyFrVuvNW3K9bMkCWp
         J32nMqSbTU13oQrDEmQHmch+ySzKDNfoOgAF2X/sUX0Y5M57kh5YiMcBLk1cCIqZDydv
         mfN8n+q+u6RcvyEK7n2qn2k72AIsgFLoBhGwqYGoM/06LAF2an4q6gGSOJQxqFrPf1Ff
         6qmfmz1iJ7e6Z+D/9W4DZV1NlhaPdFplDlhu9V2P/1cjzKvxV71EtUXx+pvNhc/IGu6A
         6SKVSE9jRhpreO3J3cMYW9QEi2Pw9jD8gR2jF2i/lmCdDeZ8RpFKluo+WLRm/Hc7KBx9
         kQHQ==
X-Gm-Message-State: AOJu0Yx3WqXw32VWxw+hStY4SCeLswpyQyOAfX2cAUX7gIMEdB5vM8Iq
	AG5gnmdcsJ6wQY2lQNqdM0A1XJBidlpX7OQymsvnzfkiwUAqiM/0lPWDdcZMBaUe6JmgdctACk8
	Xtq8Kbw==
X-Google-Smtp-Source: AGHT+IES9bCsJfIiOtTOibh4+xJeDVvRe32AU7FcJxjrcp4vNbd38MEX2x54Xu2QtSgLJN/uWFW9WRACCM3P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6aba:f97a:4dc7:7e92])
 (user=irogers job=sendgmr) by 2002:a81:4c88:0:b0:5d8:4274:bae2 with SMTP id
 z130-20020a814c88000000b005d84274bae2mr2333638ywa.6.1705968374141; Mon, 22
 Jan 2024 16:06:14 -0800 (PST)
Date: Mon, 22 Jan 2024 16:06:00 -0800
In-Reply-To: <20240123000604.1211486-1-irogers@google.com>
Message-Id: <20240123000604.1211486-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 1/5] perf list: Switch error message to pr_err
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using printf can interrupt perf list output, use pr_err which can
respect debug settings and the debug file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index b0fc48be623f..9e47712507cc 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -66,7 +66,7 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 
 	put_tracing_file(events_path);
 	if (events_fd < 0) {
-		printf("Error: failed to open tracing events directory\n");
+		pr_err("Error: failed to open tracing events directory\n");
 		return;
 	}
 
-- 
2.43.0.429.g432eaa2c6b-goog

