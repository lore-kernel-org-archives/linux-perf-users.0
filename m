Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54D386550
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661808; cv=none; b=jzFclJSYm5pWdTUa5hcyu1PVzItbTg5YO+b4UEBiyyDwOJTHAxsLNUBjvhvKe9lssOdBWKiRgHUtDPztBjBwLIP18iRzjhxRbt17UYE6rRdOM1tPh14MdFswDWrwiPykrnatSO5Tov6rHFJzTy1E5xHu9Yuxro6mMu3wAk9ILkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661808; c=relaxed/simple;
	bh=us+ds7Q+P/t0eK3oG4tayVjN3xsX0juDghwKB9dP7EA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJue/EvlCCGYlqG+117EoVqN+9j/UQdZhjB5idFIxD8DOaDei/s65U7+P41iJJsfxpkbfoVlI4/QhraDVzmQ/x143oURM4lrVIwpfdI6zzbvJ1Y8FpFj6h7jxP2T8VPHQgNLXaYL/ANOQ4B32+bzFcfagYHpFYgUBEMs8TNW5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQpzMoF5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQpzMoF5"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso898149a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661804; x=1784266604; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lvut/wGJaYaqaC8EOuzXLgdON3f16JOPTuJWAAgcRZg=;
        b=bQpzMoF5+0Ag262urkSPI0bLWhkOFdXMbP+ZLbS4ZkmFU1qDLZOJlLzZ2VRoi6I1oa
         XTJdoCRUCtaAVkasxFZfAOjaoO8aDwNiV3u3pTP0rhjVQkXVGZX4GhHmozVQKhYCIW/1
         d6C9NJHgEtoNpCVdISbCJigAbpGs9PjOmrpmCvLruKOazGCFFNwQIkVnHShGwR2YdQQK
         ltspPoD6c14HygYutF//pqdHalyuGidDIzjXdYReIDB++aRvIYEV9gZJwsvsXI3fuWML
         y5d0fdG3QRRsJYbSYVu0LyWo0RGE+jeDnZ/aYGIAQ5svEKFUSrqRLdr1CdGpnuW8k17+
         HaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661804; x=1784266604;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lvut/wGJaYaqaC8EOuzXLgdON3f16JOPTuJWAAgcRZg=;
        b=Z0FNZKBF3mRgJoa1sMpd6+cEUQHSPAW/NmieAwXAJuMGQ6VHo902eZwLBvVqJekJ/R
         93SxTZ07wCbuyJQ0xE9P5HIahg7IuqPDncpaA9Pi8os7lrPX7YwAQPixbQtixlnU1MMp
         b8WZKa3NS0jMu6P/HcYzp/wiz6Dz4RWr8OoS48DnLi4WiW3bl6osi9CyEMRUklhTXgEE
         f9XHf8wOQ6VR/FRDrZWOPqd6osWVWpg7YeDkc7PR6OJTUDPYxYz4gqSswJPvWJDaywz9
         hFxMI3+y/+TlZ4YJt7kcaz42wqnyoj8DjnWlUbqPqaLM3E8raxlVFz+7XbrbUrRroJqY
         z5Tg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/ACLtLN110w4O2M9H8PdDra/oT76wsGC7TcKGN5e2TiAK68POxZAemeeNZNJ9x3LjbtlwncPSPKSXJjpU6/g7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49ogwvLqDtxLUgDGVjlOnhIGvZGrUr24k8zJkiVhIV3/+flpY
	qGnhf4WCD9LCXMmtbvH8M9MyHtjucaDwmZI20Lq42YNoA6AL6MGPkuZbMPSPjdXmYRer5NeH2lJ
	EQvGzWi/2aQ==
X-Received: from dlbsn10.prod.google.com ([2002:a05:7022:b90a:b0:138:301a:6f80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258d:b0:3c0:9c1a:893f
 with SMTP id adf61e73a8af0-3c0bcd143cdmr11375443637.71.1783661803898; Thu, 09
 Jul 2026 22:36:43 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:24 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-6-irogers@google.com>
Subject: [PATCH v5 06/10] perf ui hists: Fix NULL pointer array gap in add_script_opt()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In add_script_opt(), the function unconditionally increments the optstr
and act pointers for a second optional 'time' popup action before
attempting to invoke add_script_opt_2(). If the first add_script_opt_2()
call failed (for example, due to an asprintf allocation failure), this
leaves a NULL pointer gap in the options array at the prior index. When
ui__popup_menu() is later displayed, it dereferences this gap and
crashes.

Fix it by avoiding unconditional pointer increments. Only advance the
optstr and act pointers if the first script addition actually succeeded,
and safely attach the time parameter to the correct assigned action.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 675910893644..07a2e18f8aaf 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2811,7 +2811,7 @@ add_script_opt(struct hist_browser *browser,
 	       struct popup_action *act, char **optstr,
 	       struct thread *thread, struct symbol *sym)
 {
-	int n, j;
+	int n, j, ret;
 	struct hist_entry *he;
 
 	n = add_script_opt_2(act, optstr, thread, sym, "");
@@ -2819,17 +2819,24 @@ add_script_opt(struct hist_browser *browser,
 	he = hist_browser__selected_entry(browser);
 	if (sort_order && strstr(sort_order, "time")) {
 		char tstr[128];
+		struct popup_action *time_act = act;
+		char **time_optstr = optstr;
 
-		optstr++;
-		act++;
+		if (n > 0) {
+			time_optstr++;
+			time_act++;
+		}
 		j = sprintf(tstr, " in ");
 		j += timestamp__scnprintf_usec(he->time, tstr + j,
 					       sizeof tstr - j);
 		j += sprintf(tstr + j, "-");
 		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
 				          tstr + j, sizeof tstr - j);
-		n += add_script_opt_2(act, optstr, thread, sym, tstr);
-		act->time = he->time;
+		ret = add_script_opt_2(time_act, time_optstr, thread, sym, tstr);
+		if (ret > 0) {
+			time_act->time = he->time;
+			n += ret;
+		}
 	}
 	return n;
 }
-- 
2.55.0.795.g602f6c329a-goog

