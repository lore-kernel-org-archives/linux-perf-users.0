Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650C38655A
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737452; cv=none; b=RthI9qHsGDwxRzOp5ODNjaYLlehKQ6VTh3ZbSlAYPutOg1R10Oj5vqqp6fh3dn5txilBJNB+8UT5aX46hM4Uv4IYicmM655h1AlXJSkHg8B9lAtsrgz7+mXp66knshmbPnw2QNFvDEARkoZu3RxKISvunAeFvZfY3bEiMFaYBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737452; c=relaxed/simple;
	bh=Qs82aQblWtjLLgeF3M5ilDmR1IJTXAu5AzapLrf9cY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cQPWvATKUA80Tzvd++qB72tLX1tOCZ9mCC+pDhbJy7jWqXQjiD/Ab7cAhZsb8spgmVRFt+ucSnkp9hu9hmik+mNcPQ3V14GexmI5PqSHbslNeWM28D2Nkd4NR/5lXG0LadmTZ2HcAozF94LUV49+NUb3bpwCwv6pbad/IRtZn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Etww/siu; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Etww/siu"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1275c6fc58aso5582495c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777737449; x=1778342249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt7TK3JC4x6/Ps79h7tGqZ56cFuxWDFNGGhg/Dvi8W4=;
        b=Etww/siu4pTyjG8dgraUTSsRH+k1VfqNDcBpSvOoLhumt5/oQ+gTOLCaeUD8rDRPjy
         vxxUSkz7BI7M9VIpVYfijiyd2TsjGnFpx8t3p/MMOTiVNjODtx2i2ietHkPYeC3I6L1P
         8enzbMMj8pxtOI74BgNwEgDK8RZeULBRkEj5mCgHYbfsP5gNaBq66IdHRKEG+V6tK7E/
         90nbv8PZX9frkhj+0Vt+buDGerAswIM4wgpJT/iTc1UPpFWggFupmKJ25zO8KF+Vvp2V
         aPoioWH/YeuMnj0ct0xsCRbP6CRHOK6K4B2SbWoxJ459+0HdjEFmIkZF668evPsLzkvd
         monw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777737449; x=1778342249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt7TK3JC4x6/Ps79h7tGqZ56cFuxWDFNGGhg/Dvi8W4=;
        b=FhGOPRvrhQCaytbctPX4GmFkp6ScjyuczjxUW/rfXQXy3yZhYFh6363fET3OVtQ8Fd
         CN75LlDuiv5Ql+rNUgazGSdQV4REGVF3y67cxwcSgX35NDSjim6ZqZWxhpBonaxac/Bl
         i0LP1/RcOmYncXeftt3caQXaMjGSKsQYmTdKONLMkSIjCL3/yh4vXw1Qq76MJimRKlIT
         3to2XqFWL4x+GJ1iBsaV5IoI6wsZp9i+OLdMMpy6j7tgIoPqgxvd70YRPshF4cfEfYuI
         Tcup5J+vcfDxMB8uCkAjrryMcQxiKDSlov3PaRekhoJt6/nHyvs9CvTWwU1BHHVPMtmp
         /TlA==
X-Forwarded-Encrypted: i=1; AFNElJ/DH9LIExffCtJoa+xcWj04TGlRFkOwOrFi2+MuPVwqXES/nuR2r1NKBdgb/9IYZAPGOoBfqroF0T1XMA7vlnkr@vger.kernel.org
X-Gm-Message-State: AOJu0YyarBQLkr80os9OYG+alZa7tjdIwKTeldeoP0soy9twaWXo83lq
	JsWQ2tcZI46wBne1h7h/kNPHyXbhkpfx67mo6WrMAgUw1psQH6AxR1caTLBd6VAwc/ECaHhnoFt
	dd7sPiIHwlg==
X-Received: from dlbph19.prod.google.com ([2002:a05:7022:3713:b0:12d:d0a4:2ed9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a:b0:128:d967:4678
 with SMTP id a92af1059eb24-12dfd80734emr1533128c88.23.1777737449277; Sat, 02
 May 2026 08:57:29 -0700 (PDT)
Date: Sat,  2 May 2026 08:56:55 -0700
In-Reply-To: <20260502155656.478642-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502064839.282422-1-irogers@google.com> <20260502155656.478642-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502155656.478642-6-irogers@google.com>
Subject: [PATCH v2 5/6] perf annotate-data: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return values of `dwarf_aggregate_size` and `dwarf_formudata`.
Validate `dwarf_diename` before `strdup` to prevent potential crashes.

Fixes: 2bc3cf575a16 ("perf annotate-data: Improve debug message with location info")
Fixes: 4a111cadac85 ("perf annotate-data: Add member field in the data type")
Fixes: 8b1042c425f6 ("perf annotate-data: Set bitfield member offset and size properly")
Fixes: fc044c53b99f ("perf annotate-data: Add dso->data_types tree")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate-data.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1eff0a27237d..e881a40a4885 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -74,7 +74,8 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 		break;
 	}
 
-	dwarf_aggregate_size(die, &size);
+	if (dwarf_aggregate_size(die, &size) != 0)
+		size = 0;
 
 	strbuf_init(&sb, 32);
 	die_get_typename_from_type(die, &sb);
@@ -250,9 +251,10 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (dwarf_aggregate_size(&die_mem, &size) < 0)
 		size = 0;
 
-	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr))
-		dwarf_formudata(&attr, &loc);
-	else {
+	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
+		if (dwarf_formudata(&attr, &loc) != 0)
+			loc = 0;
+	} else {
 		/* bitfield member */
 		if (dwarf_attr_integrate(die, DW_AT_data_bit_offset, &attr) &&
 		    dwarf_formudata(&attr, &loc) == 0)
@@ -273,7 +275,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 				     dwarf_diename(die), (long)bit_size) < 0)
 				member->var_name = NULL;
 		} else {
-			member->var_name = strdup(dwarf_diename(die));
+			const char *name = dwarf_diename(die);
+
+			member->var_name = strdup(name ?: "unknown");
 		}
 
 		if (member->var_name == NULL) {
@@ -370,7 +374,8 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	if (dwarf_tag(type_die) == DW_TAG_typedef)
 		die_get_real_type(type_die, type_die);
 
-	dwarf_aggregate_size(type_die, &size);
+	if (dwarf_aggregate_size(type_die, &size) != 0)
+		size = 0;
 
 	/* Check existing nodes in dso->data_types tree */
 	key.self.type_name = type_name;
-- 
2.54.0.545.g6539524ca2-goog

