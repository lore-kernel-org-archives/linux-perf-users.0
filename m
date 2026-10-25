Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965889;
	b=K+RsBOxHVY1KRtssH6k2P0DJsRRpe6Z5vIXyMjBaad7HkoZ/tUDVh6YMLGA83fCdNYXp
	 +FPpEy9p7brMAGiNzhZBwQsf/muTCrSwCmpWq0BM4jjKZ5Gii/qpTiB18zrJlXNtCt6yh
	 mvJ/9d8uW9DfIhmUGKsolOcarVE7CxRqZuwLpNVkuRJheemNzUBjziWRODP74Fyk14ujb
	 /BXa+kdvQZErssVY6wP2t1ywBHeN+/BUk27uqBHvgC2wATGKjvE0Q5M3bKd6EtK8joS+r
	 ZP7K8IjAKyiQeNt09dhHSsiC1XzmoKAId6kmCauk19mrnPjxs+sXYz9squlFJPZxN/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=pOADWcGOPToCVkIIlJEq+Vs0tCSXpfjYPCXfS9/IopM=;
	b=B+9cOL3ulMO78z6xqPLXW2lrbGdMwKxdLoM7E+x64S/kRyCjztbu7ytP5OSMVoKBYNMO
	 lEmHTng/Jm3QWO5y2kOvZ9UlcS9r7q83+OKhpd5rVnuuTeWbdrfMG750+YmEUVa7+uenu
	 /x2BwZd/Ptt45ZQP3q/9XbgniMgllHgfKtrx/JUElK5lFb/d49Ro9IagsnhXl3VYhYlR4
	 6tzlWSxTzbuBvnP+HzwLAYHGMwxfZ5U5eguN48Y6DRGG2Rsx3CvfILyuHbDFp+s/YSppX
	 NcZR2cDmfcCIh8/d9tSuJba95hNVczViHfWP7UhVsxslLefkBl9Y3FtDTpRDRp6VhPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SIeaB5kN;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D3606A334
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824D3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SIeaB5kN
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso4061183eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965888; x=1793570688; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOADWcGOPToCVkIIlJEq+Vs0tCSXpfjYPCXfS9/IopM=;
        b=SIeaB5kNUGPEKCEkPiPPRD1zVasOhdeFrNfVWehGeHA3qLT9T7BsSO0IMd6QsXfCIX
         oPqULZsG5amqmwJfg9TdWjQcpcdJ90+EFJd5igs0Pu6qVUBzSOJeUGGgDwab3SoDAKub
         678g8kRPzPgA7o326exi+VRfUzJM3cxatvgd3tWcM2HjWpl5fPvAfdBuX78mMm3IbmbR
         C2BdsTtNLpIXiiXqjdwmiayYbMGDanvd4vx4+Mg3cQzBI6zdBOnQ8ahEPLtIYqwz/gZ2
         XlcPIVYY99ARn2+hPJ2jeLgmbx7pGcuUh1hAVZsrkRSioGn0rt7wi4+NbznZoIgvTn5D
         ZYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965888; x=1793570688;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pOADWcGOPToCVkIIlJEq+Vs0tCSXpfjYPCXfS9/IopM=;
        b=iIPJnGh62a1OdMMmDPEd+XFjdO7V+DkLh9fSzI8wVS5mHaUcfOprxkVzY/1NNqpvFJ
         ReYVJpYaalLk9KPrwqEEKiV7S4Iq5GykXg4DMaommbaFDEjkbDjoj+h0BwNS9EK915cZ
         uoBYcOCr2Pe/uF+GmPLQgw0uhThvQID8Y74O/xxtR8ZAzCGiZ9Jd3JVdf4i2UQrS27On
         rlophO+CDI2IFOUwYNoysozPFXsZiIUJ0J60RhFnNQcjn60Vycz3GHIKSqtFgXFx6ntS
         J2bGwzl4ReeNnLCzwi3nnganBzYb9WZerhskfuhWvrWG26nHqstEUU+gkEn8WIJFKHMN
         hzig==
X-Forwarded-Encrypted: i=1; AKwUvBzwYkffRIakXuIhHuEx5EZgdGIzddl4OKXw4ca1B7MueuggCnw5nBpQZb7EO64Jnmiw52g0o5mbYUmij0h4aOo8@vger.kernel.org
X-Gm-Message-State: AFq9FYIlwHPnCnEnLx2joHiG/blAqdnH5Zpj76Yl6ZxjgtTEuJDP1Q1o
	ExweJkOTL0lIgHqsLG9lxWIlFcbHURGuhvcYRrvOUL5OmPG7eXakbNl8PIZe8aUPNvWoex9YQ3w
	2y6k4VYySEA==
X-Received: from dlbsn8.prod.google.com ([2002:a05:7022:b908:b0:196:cccc:8099])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f12:b0:179:a1d0:be39
 with SMTP id a92af1059eb24-19935fcba5amr7749987c88.29.1792965888158; Sun, 25
 Oct 2026 15:04:48 -0700 (PDT)
Date: Sun, 25 Oct 2026 15:03:45 -0700
In-Reply-To: <20261025220349.1244499-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025220349.1244499-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025220349.1244499-3-irogers@google.com>
Subject: [PATCH v1 3/7] perf dso: Handle trailing zeros symmetrically in dso__build_id_equal()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dso__build_id_equal() allows a 20-byte dso_bid with trailing zeros to
match a shorter bid (such as an 8-byte or 16-byte build ID), but did not
handle the symmetric case where the lookup bid is 20 bytes padded with
trailing zeros (e.g. from BPF/perf kernel build ID extraction) and
dso_bid has the exact shorter size. Handle both directions symmetrically.

Fixes: f4e3381648be ("perf tools: Minimal DEFERRED_CALLCHAIN support")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ce98613868e7..e46cd614eb21 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1949,7 +1949,8 @@ bool dso__build_id_equal(const struct dso *dso, const struct build_id *bid)
 {
 	const struct build_id *dso_bid = dso__bid(dso);
 
-	if (dso_bid->size > bid->size && dso_bid->size == BUILD_ID_SIZE) {
+	if (dso_bid->size > bid->size && bid->size > 0 &&
+	    dso_bid->size == BUILD_ID_SIZE) {
 		/*
 		 * For the backward compatibility, it allows a build-id has
 		 * trailing zeros.
@@ -1959,6 +1960,13 @@ bool dso__build_id_equal(const struct dso *dso, const struct build_id *bid)
 				    dso_bid->size - bid->size);
 	}
 
+	if (bid->size > dso_bid->size && dso_bid->size > 0 &&
+	    bid->size == BUILD_ID_SIZE) {
+		return !memcmp(dso_bid->data, bid->data, dso_bid->size) &&
+			!memchr_inv(&bid->data[dso_bid->size], 0,
+				    bid->size - dso_bid->size);
+	}
+
 	return dso_bid->size == bid->size &&
 	       memcmp(dso_bid->data, bid->data, dso_bid->size) == 0;
 }
-- 
2.56.0.307.g5fe7bd680c-goog

