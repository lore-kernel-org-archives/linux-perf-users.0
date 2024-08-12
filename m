Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3C199244
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495670; cv=none; b=KWot7xxIrmvqt7o3uXj4b8jAr69rgqpE4YNoLSjorrJAqKBpG2IEpdJ/T4d7wZ5vuGLjUNtDII9Iv/3Po6XZc+fmyGb1s87dTKs6omMDim9dHzJj0S3wj43fjgVrtXt9PleFVRI+3HeFem6puN7SddVG4vbJaNDHRdgnvyS9j0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495670; c=relaxed/simple;
	bh=ErZE0kGZ4ZxGV+mXmdTl4tmd7rV/oJEMjATT/aoZEmk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=L1guxWzK8G+6L5no85D+DFctbLxZGswQcUsfUPw0myJwVYo1smGQKisveNT6NeOInDODQUXRlA3oYn5iIKS0619m8raXEmH14J//9/OJsgtaXPAwmLxkfsKBEbRCGhrgTXoCX6T3ULxWgiExDiy2L97zwi2Ib4hKlvbto2P37YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXAGU/OZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXAGU/OZ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b70c4a269so99109867b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495668; x=1724100468; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DV11m8aSPlwhVbL5UDuJIqeFel/OEDD4+3PWN8l4CY=;
        b=PXAGU/OZc6Ia0pE807ljO7YcUuZhCvMcm45cpiFb8Mk+R3tIuUr0mnt33iGzfNC52n
         NQ4j7HA6huYXKnolwfUZuUBR9lOrtW8Ny+lJbfH9sbGQ5Wdmjgrk4VoknVYrKJosRsj2
         DP/tA17dGYCCJ3yH4i0f7/FwDfrqZlX79DXZNRTB8NS068jYD/lJWrc/SPzpC6U4kzKC
         ccYGQvlYaU8rLp66JWwShUUvGJTPahtCnVqoqkHXwhFC+bIEGGtlMhqIGiTjCR6XhsIF
         e6oHnux5FtwR5jZClYj6rUTr5Lxcj9gHfLke29AO4DhVX/R4s/I2pLfwa+RgEIdvTtpf
         56rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495668; x=1724100468;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DV11m8aSPlwhVbL5UDuJIqeFel/OEDD4+3PWN8l4CY=;
        b=OEiJcLgBER6feWDQZwgN5YG904oSnJd4fDGm4IlRhsrp7wOMioFGOmhfwmS0VFDmzO
         t6jZS0j/Df6dHglc1ULef2w2HlnaAlbleDhHDzihVFAMAlB9Gbaf2S1rLHxkdD8B1lCp
         /TaCC+zf5JJMsj1vWIxW0MOiUB/1G59AqyVabwzVR3ibMbelRk8W/X6OMYc1YGuC0JJ3
         42pvZUQx5vmVvlUSLq910P8lLz1yP/vv9TAO0f7uYp8PTyFI3D6D0QjpCIpjIdRgvLV5
         AHwWXkpXk4TsULH5IhEmU344hAI4lLlRilneWlQNFpeN0XBwamjOJkVegtfhwAXP+nN/
         KzEA==
X-Forwarded-Encrypted: i=1; AJvYcCWI/KQtfD/83bzt1WyUnOQ+3pl3Wa+SAOJPzmlRSZgyIIbmFnco2hZF0eJilP2m6a5ybQaraxPPA0gaaUVvv9z+ZZpsptt1PBwXM3XtWmQTDw==
X-Gm-Message-State: AOJu0YxAWp/mgle/K5GTYGka+iUix4tYVwkAr99h0VK4iieQ9URKAg23
	OJa9FyURjG8u4oZR+O7H3CrMHCpdge3rMfoUsx0MKLLcKvqjWbRrw2f9ZsxrNnXOWjk+Bkq7oNi
	+5Qly5Q==
X-Google-Smtp-Source: AGHT+IFcMvZcg5ZEAFVSHmNQ3m5FSJyneWq44MKK+WXcjN+tqvmi661PGCnO5YGW6UXfSarvChqY24R3j8Qy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a81:be08:0:b0:62d:a29:53a0 with SMTP id
 00721157ae682-6a975f92448mr366107b3.7.1723495667983; Mon, 12 Aug 2024
 13:47:47 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:02 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 10/27] perf evlist: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-evlist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 7117656939e7..818ab21c3f73 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -35,13 +35,13 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
-	struct perf_tool tool = {
-		/* only needed for pipe mode */
-		.attr = perf_event__process_attr,
-		.feature = process_header_feature,
-	};
+	struct perf_tool tool;
 	bool has_tracepoint = false;
 
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	/* only needed for pipe mode */
+	tool.attr = perf_event__process_attr;
+	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.46.0.76.ge559c4bf1a-goog

