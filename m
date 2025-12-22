Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EA32AAB0
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416499; cv=none; b=qNjsTAPhep4439zA+Ii+mcMOdCETVFFjmt/mZlwNp0b8IwH57eu6Kl3kN/4iOxRkSRQMSeFNv2Ocn5viwmZjMAmR1PvYPeSNN6cD2GkbDBpYR4mK8DsBc5ijgd2VhUQoET4FWdCnIXgC3ANN6zfhelwaPhDGJIabHVWBYkvyvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416499; c=relaxed/simple;
	bh=7YYoqOIAjjMEaf57v2iXEXgdQFmEmn/LvBsi7H9riRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEuNOqQkBgJ1MobKt4XGxFdv1iY+Id+kNXSwbX9k4+qY/0jBYe6Psf9BsVTmlgUgrRgiPNt2mgxUdmGKAsNvwovR0sSPIb8oLteMxtx+YdRCLEgAUUYpBTe4Jl9uTzgO0E9r+xJk0+6Gqtb1n/jGPB1LNQ1HyEkOcH2E9QJ5UwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nl7cPr6P; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nl7cPr6P"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2143465f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416496; x=1767021296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxU1vsfrqBADbCFBEcH8TNvakDJOOuWqCmLiru2LKyg=;
        b=Nl7cPr6PaKXnGPfeAwRKcvcm68ySokhSTqwGwaqQNF/Uuvl5zrh9BDHf5G17YLikyb
         LbQWCYqWOIYKAxqh4FKfWYvlzzYdkE5DyY89jsENsXg8G+palZ0bkq8MnL4AsyWU556h
         iBQjMhClJpGa1VhUHXxlt2X6l5izigJxe8IH0zBMk3R5Nfy0w1zVps0JtoH2jePKSHPn
         1XZi75yPqP1aAnOK1GCU8KZ4ZzFSjgWOfcysiofNHA1ycVynV0zmBk/RnRDXaz8QhsRI
         ON1EiR4lXSZUMtl8xsWEzjBtCKqt5+H/gNl6TbCDtj9qbbshZLoQDL1EXhI3bHpF8fMT
         5dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416496; x=1767021296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zxU1vsfrqBADbCFBEcH8TNvakDJOOuWqCmLiru2LKyg=;
        b=SWSKWIgKOj1ohF3F5I5wGUusIPbEOg/dzm9A0wVViehwmStkD027PQzIpFd/Yyi2OS
         7XEjJqCiEtr2+/9mY4mzpkXfJW6JVCAHTccBi5fC9TlV4AC67cbfO02nYSO+vAXvx9wc
         l0XPmM9g+INtXcquP1hwjUK63+lOlVXrexHUtA8ENyFEafpyPGbEkYe4saiG6CscRTd0
         pe+7S+C6bs6hUVmmAepVgkW1HTPeOkkCvDxtm3HhUizStGttXGrZ5wyJBQ6Ks+7yoq1o
         2/hvMVaUbmU0Fp6+i4e0ie0kX8s8buO9EOwRJFfrZr/xKsbj0Yy7Cf/QFSqGhCfIG8Eb
         OjcA==
X-Gm-Message-State: AOJu0YyalUZK89UzhSf6PS4onIQ3LQWyKOYh1EIFkLbep61l3Gc9VHkM
	YyresKMuztNOLUWy2HLzmItKjqQLTGxL89MmTfkRMx2UZcYwlHdP3Ilt2YYJirXskdQ=
X-Gm-Gg: AY/fxX7CIWI7/DeuvzlpZ3fIBE6MeBV8DAjouzq5ZmtaqQ5xREF6ULD0eYxAztr0cn6
	dZqtenZKFCqGlhUKBOY6EjwF4WHPVVIrOPniXf4q9inBTm1JcjA0NjxJioMeaIpsKwUxvHDU7o6
	UtOM1PyRSBG3YMuv96JJveSZAYQGiKvO1vZP/bKWb3hwintKO1CL7IAvlJpZgepMyBfF0mQ+CRe
	soFfDk9CW/lntcBZCQmZw2QDykYzbr8Ny9NJ/t8rWDeryrEZKDGpmQUXUmrVxRJntkhMhFQqNm3
	jyER/3/jwOSai6vjqGP1FI5bLrwZHjEgcSIjWcmz7oQx2jGcfrpA6x1Pn3JHQ5ucTj6iqB1BOOo
	VjzcL/FXrTP+w6jMvsi1eoTAxCBNKFKAudXoLHBNG2T9WpAZwuhI7e+MNkkhNPg0LmyQYfTclQP
	MLAW0ZlRrZTByf3I8XSgav1FlipIMop6Y=
X-Google-Smtp-Source: AGHT+IFfTabNMYMJBYLmezzBRrk87qgMJIlKZFfgncn3j2IGaAmUdNJuFWzm+rqM2oVLN7iElkhpjg==
X-Received: by 2002:a05:6000:22c4:b0:431:9f1:e4c7 with SMTP id ffacd0b85a97d-4324e4c9d76mr12946406f8f.21.1766416495549;
        Mon, 22 Dec 2025 07:14:55 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:55 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:33 +0000
Subject: [PATCH v4 08/14] perf parse-events: Always track user config
 changes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-8-0608438186fc@linaro.org>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Requiring the 'pmu->perf_event_attr_init_default' callback to be set to
track user changes is a bit of a trap to fall in. It's hard to see that
this is required when depending on the user change tracking.

It's possible to want all 0 defaults so not set it, but at the same time
still do some programmatic setting of configs with
evsel__set_config_if_unset(). Also if a PMU reverts to 0 defaults and
deletes its existing callback, it will silently break existing uses of
evsel__set_config_if_unset().

One way to fix this would be to assert in evsel__set_config_if_unset()
if the changes weren't tracked, but that would be a possibly untested
runtime failure. Instead, always track it as it's harmless and
simplifies testing too.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/parse-events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1f6e2213326d..c8f2962a06c7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1528,12 +1528,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -ENOMEM;
 	}
 
-	/*
-	 * When using default config, record which bits of attr->config were
-	 * changed by the user.
-	 */
-	if (pmu->perf_event_attr_init_default &&
-	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
+	/* Record which bits of attr->config were changed by the user. */
+	if (get_config_chgs(pmu, &parsed_terms, &config_terms)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
 	}

-- 
2.34.1

