Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0E31A076
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666837; cv=none; b=I+PEPoeIeXwLPaaL8lHHh6Sk6PBvorqDKAFlqAIMaA3LbvhXFl44zuMozvjqmyVTYjYEGfxYkHgT+/3XoVAXYrBNwI4ct3yxLkj3rX20BgmrM33o1bDd9uTq6T9oWuhq2TbSM7IDCq6U2qOGH4y+F19TQbOCZXa7oohYZykdXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666837; c=relaxed/simple;
	bh=9O0SNp6qNzDy9oFmBjqIkwm4W7+WsJXlTJVpqO78PTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J3vsxAJM02AegdBZQhgCLUh3d5VryYv7okRyK9TsMctDjSOLM3LwxqdbYUotweyx6+0Uy4RuBiBu7PepKkvrIMJupQZaTkYX/CFhwtLkl1TBkH5FVtrcBzOo08qSVExpKh7DeBGG9JqTgBTaVldGTpFUhfhRNExY5GQx9BlW3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkqB01j0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkqB01j0"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5529da7771so2916687a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666835; x=1759271635; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0JHoX72jOJKlox/FmxfaLo+8gSeVEW25ROCTEI3UNc=;
        b=AkqB01j0nG85EdHMM2VicaSpqMv570EVKtUePvhBbbPistVY9w8y2W0INLtNiik71r
         sgVyWQgvdZn/zQIcd8SbmEONuNtyn5GbjKkUuqelUNrA7kDlQW+avHGm+f56+o3Hrz3C
         KN02iJSuCGgA2P60g28KBUaqUmqYDI8yk98HbCwem2tzPudowU1+61nUh2CS/r53WPKj
         rsaPb+cJnX/UgHPuxn1pMba0i1sNwQhVcGR8rLkgdihvfPPKouUSuxph1jw5gdlcU9Ib
         vSIU3xy6SkIdMUWIkxMEvF9Pse9WvpPpUsrQP71Qk7RJQeyWOlH58p+fmNrVlosmmyKA
         XlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666835; x=1759271635;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0JHoX72jOJKlox/FmxfaLo+8gSeVEW25ROCTEI3UNc=;
        b=amlit06vGKdL67firuz9SyJiPzaM+/mTusCWqUtOf9byEjZcNjb7lsqH9BmiBr3o5U
         ngPNDuCZndW0AQtEeMY+Iouw4hvao6sTsjWNY7DNqBVdyjmQMhD1kQ1Y/XbpamlqTuEb
         ylWBE70cUa5JHXc5dFqw5uSasoGzESm+pYP/PrkNZmLKRbLGk/izeP7DGraLP91wPhx1
         k2YjEkM9H0QrKo18ogW4S6ycADkbUpIAYtNavFFSGYTSQdn1iMuakeLGEfJ8vhoCcRfJ
         ATAu9qujJ2iOjTi+T2qeILgBRkCDkvZYrveILoeqBHF14k7qa+YTO4NaSzbakcVsSArR
         VIPA==
X-Forwarded-Encrypted: i=1; AJvYcCUMFBw50VimdOqE7Mh+JqQNDWYYI+Nk0R4+fk04cQFBWlky4XsVYNIUl0jH2Ax7VNbM/wKyMZ57Lyg7LGcXhoqe@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDefgXldx8VugsPf2ciLA0oaOIXRRjJH+NbXvsFyWbpsUhXh6
	XgwQaXUjaxOMXGhvmn4PRRdXyT80X8bCyB8Gq+T1Bk0SvlYx5CUIgkRe1iHOzypxl2KbxFjGMqt
	tjSC7T1nsNw==
X-Google-Smtp-Source: AGHT+IHeQypyUqFsEbVICSrUYORKs3zwl6NWeWm2GkcngOh5TzAu6PZZ0+z1ndYzdyFum5JrUltuzhGtqt/M
X-Received: from pgar28.prod.google.com ([2002:a05:6a02:2e9c:b0:b55:509:7882])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d07:b0:2cc:692a:3a32
 with SMTP id adf61e73a8af0-2cfe96eec4cmr5942185637.26.1758666835335; Tue, 23
 Sep 2025 15:33:55 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:03 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-20-irogers@google.com>
Subject: [PATCH v6 19/28] perf top: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a11f629c7d76..710604c4f6f6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1695,11 +1695,13 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		struct evlist *def_evlist = evlist__new_default();
 
-		if (err)
+		if (!def_evlist)
 			goto out_delete_evlist;
+
+		evlist__splice_list_tail(top.evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
-- 
2.51.0.534.gc79095c0ca-goog

