Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B61EB5CE
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768568; cv=none; b=WRDuPaUSvB3pZDZ2LxYCHefSwcDbQoImFQFi1vvryI0qlhuB6AEv02tbnWImvE2+di/NsfpZOnwdL/0S+5Gy1PVQk+WCNOYv0+maVsLZ475Pu5bt+HBugJ/SXdYwZNaOTrW7DBN7Zch96lp3n6QtKYW7T/ohQjiqtra0gt9U5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768568; c=relaxed/simple;
	bh=Qs82aQblWtjLLgeF3M5ilDmR1IJTXAu5AzapLrf9cY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SIqENZ6m4r1AQLImo8acckxWRzLFSEUeperIJye2Z4SO0/FFlFC99OkNbLGzrjKXdo0eVtzYf9MUsWrqdghoEkt6BK1X3/pPvETZIIiTohh9mgmPZXF4XPZLZfQ9+W29UZ7cUNrYZYBmqScra1wBb2Z5Cr/F0D5EOuvHuk31hlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGFviffI; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGFviffI"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1275c6fc58aso5970294c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777768567; x=1778373367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt7TK3JC4x6/Ps79h7tGqZ56cFuxWDFNGGhg/Dvi8W4=;
        b=vGFviffIfqnN87BeAJz4mbfx8+gQJ5yf2hv22JAV8mYBD6pTdclGbY6jUOuZCJ+3lR
         Xr6kMUrzFyGXnPFbuyfHY1hrXIyGxpUX7Nnu2mm0xgupAZYaLY81vdsI2Qt67XZlPTe8
         cG7vXCWjA4QIIzKKZ3LYR+zgwHJ7N8USJkanvG81LlCNkVD3B4b1iJ2V70AX/Nlurkss
         mTYLIPQrBfmzGNM87ckaDMD2+O+PUWacXm5iNJY/xkSKh7P6yaSREjnvytytOpI7F4hf
         TFWUmDmJ4HgVR1dmFNad++t3+rMLddOfS6T8WT7k630yf7LujR5DG6jyKtAkM/37iYM2
         1HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768567; x=1778373367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt7TK3JC4x6/Ps79h7tGqZ56cFuxWDFNGGhg/Dvi8W4=;
        b=oeAM1licUy1oo8AZ4xvGF++fvt7B8tmE3FGsdg9HENT0WXLWXdxGfiGCkOCZFrE+22
         2Luzlg6dd+P97tQVPPZ1UMApDnPYGzKBh/mZeG/mUYmzVugAZnfD2KekOxBlTs9NMAgC
         iku1KzyWucrDi31pfDYkCiUMApVCLYAzHNk0q6IehUUfK4x/460UyY9tYCgHnJIiNgWN
         H0A3+Cve1HnWVTTB2sFopu6cyJOUkEKTcM1BhWBqXlX+FEtCL0kHek4bNi8XjLuKFZYJ
         zl15PJdVB1n/kuMNTVSRvmQCCly7ayqIgjEHmBdkjDVap1Bda7eVkma8EKlWXBRxlEUe
         7pNw==
X-Forwarded-Encrypted: i=1; AFNElJ+ytB7AfvaCZNcOlNf4qNbGmV2E7Lnp9z1sxtyGKkmDmeLF6nTZZcqmOn9XKx5GB/a5ARM34TVxlMvYw1eyGyIH@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyVhAKsZ005hhTtyiUcj/6MQVVPXi1IOTVo0JfunNhKqm+EIX
	DDKFkuVhrbw5bbdzvrANq6r0Dsf3bVSZzdyCRvrWJVNhquIaClMj/BmZoKV2U7uMtOONtMHq9FB
	g0GmTXE9YaA==
X-Received: from dlea17-n2.prod.google.com ([2002:a05:701b:4211:20b0:12d:b7d3:3e31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2222:b0:11b:e21e:5653
 with SMTP id a92af1059eb24-12dfd7c6388mr1746330c88.19.1777768566436; Sat, 02
 May 2026 17:36:06 -0700 (PDT)
Date: Sat,  2 May 2026 17:35:51 -0700
In-Reply-To: <20260503003552.1063540-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503003552.1063540-6-irogers@google.com>
Subject: [PATCH v3 5/6] perf annotate-data: Fix libdw API contract violations
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

