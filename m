Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6B15485
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511816; cv=none; b=PCoA7yw9i4qC4I27X02j8LEAnyZiZk35wusv5z3pOovBF4iPISiSukgLvYM8bxlII9xV9asjmJo2g6n9J+xnuzbN4uU+izRGcXC7sbGEzQ2kpThwHWhvrVmMNpvLz8nqE+9fax0Mjh4H98WOsCCQh7kXzTF5pE6lhs38mBcLA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511816; c=relaxed/simple;
	bh=CbVycyAyqWnjOhqGXZ0kFJxI7/ZRDcDTc9Vb1+mg4QU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=m1qrnPaBcTBk38My2I6q0/fl0VcOVoMugpLtTz5ReqYdF1FWoEcWFkhk8B0UFQYlNv1icaGEQdDywZ8b7BLhTPzlJQHrpxvF/ITmfgejGTIGVVQ4udUNhQXhI1dcFdo9hk1v6KwuLn9+eQmL3/N5bd/PGxbVsNIICqBuOFWRosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKSu/MlE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKSu/MlE"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604ab15463aso23982617b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 12:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511814; x=1708116614; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qR84mNrslfcjY8XyWDHEQaLVA/4KGd9xMsI7WbfV4Ig=;
        b=NKSu/MlEPjqRlXp2ajUFxbptngSq73PdhmcXYYJQxXkCeNkHLDQvO5N7rRS3KsAmO+
         l8eVBCYgMTl3TT6A0utsFOZtMbPfLzbbMuUC+8Ew8d18IS0Lz9T/u9KeEbDoQ60K+lEl
         QbvvNlTkfnDKt6zgOSU4CumTyXtONpNBVB+Pn7oz3h31Nvgz4Gw1xcs7uHCXYzPoeEQd
         fM0LcnaRATYRZAjWslvZ1qtc+DT+YqTb97/dHTzR1Pw3hp03h6jWr3AYP6fWHWBI3bNS
         kZrzhMLva2jF/76kLLSwtJr9hRUB0zTTgXBgpYxj/1KNffiF1c24A2Zk4z1D3Sw6gnkF
         yr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511814; x=1708116614;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qR84mNrslfcjY8XyWDHEQaLVA/4KGd9xMsI7WbfV4Ig=;
        b=jEnJRosZJAMShhgPnDxOEpBNfbhLlUFgmRUkntfoly6DVmCrXNUBAH8cYPgLPmaa+d
         E5dIkOSKuH7qQeMbUClKcDsyu0y8mIJhtbbQd/5MYV627v3ad0F6gXWUbJz0C2zqqWiz
         lufwbCy30nSBAoEvmhUw7Npt9gdMd3C+gFPNvinuti85op/jIeGNFiRClFLLM3q6y5aU
         toY4RRNVm3p9w8AB13GpQmu+8kd8Gv1bt0uaLlf9VtNu3cEFnpePqZ3Ze0QW/5thC4mR
         PJD/LiZHtfk/VsLpk2Ytlhh95dZprYpqn1FQzthucnpwEhuwgGU96BfFqtNbQkypF+0V
         7Ntg==
X-Forwarded-Encrypted: i=1; AJvYcCX0x9MCmGr8qsgni7MlAxKn6EauATE6pcjHT1XaQDLaJs/OrIWzaIp5EAb1L+gFzxbTRRaQlmFWnmtK+7drIflS7emf8FRHFXS1rV9g1Y5Hmg==
X-Gm-Message-State: AOJu0YwVsZazXYp1Z0sra9cTAWLVY+tgvRLnwISBr6/A+Fudg5ZQyzo6
	j/4PbwwDCAUPg0SrxTQrvw+00qQ9m63KsTRq9pXU1yCJ1Ub37rMiJf9+WqCc4/ryFLytUQZEDew
	vUaAP2w==
X-Google-Smtp-Source: AGHT+IGG1Rxf3SMcCpxfxkRqDUz7dHOOD8Ki4rNA4wYhKtISteoWwvV3FknwBD0NosqhldKZg4qJbWokC5mc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:709:b0:dc7:59d9:7b46 with SMTP id
 k9-20020a056902070900b00dc759d97b46mr11144ybt.3.1707511813991; Fri, 09 Feb
 2024 12:50:13 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:45 -0800
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
Message-Id: <20240209204947.3873294-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209204947.3873294-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 2/4] perf expr: Fix "has_event" function for metric style events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Events in metrics cannot use '/' as a separator, it would be
recognized as a divide, so they use '@'. The '@' is recognized in the
metricgroups code and changed to '/', do the same in the has_event
function so that the parsing is only tried without the @s.

Fixes: 4a4a9bf9075f ("perf expr: Add has_event function")
Signed-off-by: Ian Rogers <irogers@google.com>
---
Note, this fixes a has_event issue but as no metrics currently use
metric style events like cpu@inst_retired.any@ no current metrics are
broken.
---
 tools/perf/util/expr.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7be23b3ac082..b8875aac8f87 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -500,7 +500,25 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
 	tmp = evlist__new();
 	if (!tmp)
 		return NAN;
-	ret = parse_event(tmp, id) ? 0 : 1;
+
+	if (strchr(id, '@')) {
+		char *tmp_id, *p;
+
+		tmp_id = strdup(id);
+		if (!tmp_id) {
+			ret = NAN;
+			goto out;
+		}
+		p = strchr(tmp_id, '@');
+		*p = '/';
+		p = strrchr(tmp_id, '@');
+		*p = '/';
+		ret = parse_event(tmp, tmp_id) ? 0 : 1;
+		free(tmp_id);
+	} else {
+		ret = parse_event(tmp, id) ? 0 : 1;
+	}
+out:
 	evlist__delete(tmp);
 	return ret;
 }
-- 
2.43.0.687.g38aa6559b0-goog

