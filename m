Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756038DE5;
	Thu, 15 Aug 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685818; cv=none; b=ViLLbM0VR+sfacenHagVBFBX+Xr+SQxVVWsHVUgEBijw6TZXE7Nkq6fTbRLL/WcYbboIEtVIzBofRJ4Is+ndweIByV5GarVRZovWAcSaS1UyjOgvGKoZf0RWRNIa6Cl1ifVUihrrbG5NkzKTUtUdldai5s7U9HAy1O7QxK9MDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685818; c=relaxed/simple;
	bh=t9UhZ6X/AY+Tn/50iuq2vVY9/iUqohzuRrnunr+kFvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYpXJubZeX5wv73ObWWM/ZcqKka72urjKDLPe974GRlL3kSvHCXZSYXM5PrHgUbtRbLNF1l+jKS4lTx2hJ0QoLW4cAvkQIkcM7LVM+YkTzYpqm/VBEJOaxGTrT8v7lLjpPeOx5Nzn0hhXEtSJriF+37vwGiYmOCiQI4kCim0i/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWMF/jx0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWMF/jx0"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3dd16257b7bso181874b6e.1;
        Wed, 14 Aug 2024 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685816; x=1724290616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpLNXKrjrHLHX+d5UGlOuRxjnFIniqE1exAgXOvBtt4=;
        b=fWMF/jx0km0HxYtVVtlEz3OuPkFzcflSKEEXlWiDQ+wxSyBaLe5heTMLowlMbvYUhj
         Ywb5eDdwnuF9W3SN2kX65x5O7w0IBjSCBMLi/DEtPDUaNO8bD6hVh9mTT3F5h9lbi9rK
         2b+aTXz0zxiY4cJKuT00lSB5kDnjlhkmoKUvIzgAk9aAGylWZ1PJLGfV7V+QGCTYXy1R
         z4pe3H0UY6rIVnerEXCxYBtnQzUSXBjlBKPu+JIOmDYm4nRNogn03F8W4K/Utd6EUTjx
         VBIXFjzguhs95r1+QW8TXVQx3VC+Bc9H9rTLKZ3PNdlV0sT+QuVPycKL3HZ9NU8TlmNd
         Ydog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685816; x=1724290616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpLNXKrjrHLHX+d5UGlOuRxjnFIniqE1exAgXOvBtt4=;
        b=Ah4YjHoLl16g5GUawBkBYeq1T1eyFhLfLgUN9TPiXHjVlXUuONK3AzIbKJVS1IFgP1
         10QCbJ4cdF42J0bM07BRLdXn/aCDIAgImdFWZuHKAteTLXCjU9JeKrJN69Am5KsVSAFW
         LtezAxAz0J1MQeAtNOPW+Aiu7OyQegOX2gPbTZ7zHNrxgkP5olliLiAQ48Kec2rJYpxt
         /H7z3+WMfMRqxGfTMXaZeCjSbYi3NM9nE8pcIQk++eidl01ww4kYQs0HuTDpq7i8EUMA
         //BaI996IoukrXpn7IkHpkwzYPcrSyhzf4utzWQn6bg/wniDh+i6W5Oc7MO7qe+RpDEg
         0UwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB73Hc0WUZVJNMVkpGi1d1sqiYlcSQcbpXgNOyGeJkLz91V22UpA7IJoI3H8xt4n8lq7l8B4dxn0iP70fNMB79KbTgB4cfXQbKt72dtmTvqBj/2xBXCzQ1JS6Ll6s9TEDQY+IZLqD2Y77U0CCX8g==
X-Gm-Message-State: AOJu0Yw3EGxBqpVuMlRNQ1KkcymgF6rZb2MW+sEAChipQ7duTu6oAdpj
	IGP8bwWd9pr0f1QmRcBQGS9Tp3hJt0yJ40aDjmERbUks/Vo37jaR
X-Google-Smtp-Source: AGHT+IFNM70IsuWw7eVkgcXf9GjQh3p5QegRiBJM+A+o+zKFgmUnOGviA50u478xuqFTb6WLU3RO4Q==
X-Received: by 2002:a05:6808:3994:b0:3da:b35d:52e0 with SMTP id 5614622812f47-3dd299922bdmr6165376b6e.43.1723685816340;
        Wed, 14 Aug 2024 18:36:56 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:36:56 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] perf trace: Add a new argument to trace__btf_scnprintf()
Date: Thu, 15 Aug 2024 09:36:21 +0800
Message-ID: <20240815013626.935097-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the struct syscall_arg, so that we can use the augmented_arg later
in the struct augmentation.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 84c7398312d8..4bde40f91531 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1007,7 +1007,7 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 }
 
 static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
-				   size_t size, int val, char *type)
+				   size_t size, int val, struct syscall_arg *arg, char *type)
 {
 	if (trace->btf == NULL)
 		return 0;
@@ -1030,7 +1030,7 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *
 #else // HAVE_LIBBPF_SUPPORT
 static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
 				   char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
-				   char *type __maybe_unused)
+				   struct syscall_arg *arg __maybe_unused, char *type __maybe_unused)
 {
 	return 0;
 }
@@ -2284,7 +2284,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
 			btf_printed = trace__btf_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
-							   size - printed, val, field->type);
+							   size - printed, val, &arg, field->type);
 			if (btf_printed) {
 				printed += btf_printed;
 				continue;
@@ -2986,7 +2986,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, field->type);
+		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, NULL, field->type);
 		if (btf_printed) {
 			printed += btf_printed;
 			continue;
-- 
2.45.2

