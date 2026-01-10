Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711E2E7631
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033632; cv=none; b=BFIOelZz3/vEjE6CzXS1xm9W0/RSB7jSWK4FbEp1hJLDg2QR99Pz7Uu8QUGTTJVeDG7ieUbLFv8peNL+/OlqXO5VBHf83gc+kpLrCtSZXcySGiNA2fkr4YnqQADwQtNWmwIQGPWEgTPsCUeh36I/JKpCSQPllxTxtDYCFxc28is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033632; c=relaxed/simple;
	bh=maJyLYZB2FWx2e0vl8zLnRWKAaYapuD0B5sWshQY2lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H1P5gKb2GbCb37KAu0W4oKwJm7C1N3Y685nayZwDT3dyhrAy0bEMeuybF20oy3O7M1JqaWQ6YlqzX58OXMRXHe/FXlLUVfw9wV6hWho76+e63NOp48xRzutzIc5V0Mqep56/T1CtnCdHDLtjVnmrStWFQNHDcRSxHVUlg+dy7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4vlv/72; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4vlv/72"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11b7dbce216so6865683c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 00:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033630; x=1768638430; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBuF0YhhsuNCPdotB4FjlRI1J5nXeTBdLsus5/rNBYw=;
        b=r4vlv/72J7RCGTsh3SwLtP8gs847NvBPSeyF+ZvXGlTx7GtomouBAln/0b+BTJFUkZ
         egUD0tJ0PsJmCMAp8Dpd477l1sszdPmHABRWygwihJ0OM7fRDZWFcl2DFl31Z1AheRb9
         W/+SB0+ADRvRl71IyScq6mDw3xkZu7T/xJ7mq0OIAK8RcRoJcIjcsEDyOYy09h9Ks0h6
         3TCrHEhZwBoPbwCmwrE4VnThg/OvJYkNAYft1QiHbZWQlR2R7+lY5U81Q16g+mowTDA9
         stg/8zAYUeNmBtfb99i71PGRFYmXafKB45GyTgmxG8MWzqs/xxuN/zhGk1cUFXzrmYVn
         ZNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033630; x=1768638430;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBuF0YhhsuNCPdotB4FjlRI1J5nXeTBdLsus5/rNBYw=;
        b=PpXe7t2W6vL7SDRHAWwLqyPb6oTvdjwYd4AeFcs9carFJmOomTlJqYDQx7xaZrfPjZ
         sPOkEe7jWEJJi9qb2MOqC5THfV6KblYKoIs4i7c92yOWlDvMO2no186QyQsROlzpHMjo
         f1Bin6TeKto0MP0N8a0Kv+L77u+dgGa1WQkxsfXvg2lBdVTaRsnrfEgj6hIoOrOhGdV6
         Ynu3nh8UQ65DhcpSF9pbtG7JvqDHmDbeI0FWkgjMtJWu7Y71dUOmYZjA2O7eC9cNIFDx
         hMC5d5AKaK/2TFV0O3jvhd3eJcQ8tfg6217ZBnVYq/Asw1Wr0SybgK2QDw5e6R8rpNgF
         eA7w==
X-Forwarded-Encrypted: i=1; AJvYcCU6GG2ZfSuT5t4FoLt5fWotPRFJ9v9Xb4BikaaszR9yuN0L5iP2A5hq0Q88u6adTzz1x43XJH3n890G4MYM/vJk@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPgBqh5Cr9eNlk10Cfx7xaka1tPbFi/nIPEYMJi7+0CQtTwJg
	K8AbdacltC5DtItmLZXrZahlyTvynPnqa71i0NnkbV9WCac+Po88YQj+Ye9JTyt4U0yKpcx1rgF
	Nbt8U0lA4Gg==
X-Google-Smtp-Source: AGHT+IGYojtwJBo4BOFYANV+ARAGrhYAgkvu3KCkGq68x1ht0dKFHVggr0YcEyQRIZ7/cPkkOkikzpTGiGl1
X-Received: from dlbqi1.prod.google.com ([2002:a05:7022:ebc1:b0:11b:8174:bf47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:24a3:b0:119:e56b:91f6
 with SMTP id a92af1059eb24-121f8b656c7mr11354434c88.39.1768033629805; Sat, 10
 Jan 2026 00:27:09 -0800 (PST)
Date: Sat, 10 Jan 2026 00:26:45 -0800
In-Reply-To: <20260110082647.1487574-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082647.1487574-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082647.1487574-5-irogers@google.com>
Subject: [PATCH v2 4/6] perf callchain: Fix srcline printing with inlines
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sample__fprintf_callchain was using map__fprintf_srcline which won't
report inline line numbers. Fix by using the srcline from the
callchain and falling back to the map variant.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel_fprintf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 10f1a03c2860..5521d00bff2c 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -185,8 +185,12 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (print_dso && (!sym || !sym->inlined))
 				printed += map__fprintf_dsoname_dsoff(map, print_dsoff, addr, fp);
 
-			if (print_srcline)
-				printed += map__fprintf_srcline(map, addr, "\n  ", fp);
+			if (print_srcline) {
+				if (node->srcline)
+					printed += fprintf(fp, "\n  %s", node->srcline);
+				else
+					printed += map__fprintf_srcline(map, addr, "\n  ", fp);
+			}
 
 			if (sym && sym->inlined)
 				printed += fprintf(fp, " (inlined)");
-- 
2.52.0.457.g6b5491de43-goog

