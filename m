Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210A35A38C
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651817; cv=none; b=T5Vx6SXAa1qiIVPk7qUaEVpxW1vJdOhvJo/AA+Nd0vqF2Rfx+vuU89FLxa22nQIiSfeIupJboTtvEtdDmrznwXmbZHKvjTpycrdHh2WcU1UQq/ZkmeoSYE0VvRE3+/P91oqUTvLTNf4v4BQHCZP9btAOGS5v+NnpUDCr8SDOFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651817; c=relaxed/simple;
	bh=zYm3bLKUty/WV2+kKihBBgugI8V81g1JwrJzaQrFFks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cIRcL63YHgq5K9huFo3Im6hPtPjdw5nLoVAfw67hm3wlKUqn/QX1I++0Z94Z5AcBu3BSA6aPUVVEChLjh4CKS6zoQtJkcL9OMHRU43IZBX4rsDL5u+2yDDd98As564nwJ5Z8hPcDsOxacalxXo3hnfYXZUab7vnDKAFzzpATOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lidw0OIc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lidw0OIc"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c894391f000so1076986a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651813; x=1784256613; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eCmZOwEWZATUU/3QYtzfI9njbQsTGpIGno+eX0+5jmk=;
        b=lidw0OIcjy/+EVo8TEpZmJ/lHiwfa4zB0etOT+6pRYc2JEWBiAoJYscswT+ltts5Z3
         o1HLxUkyAFVo2ceYVbGvY1bg2QlkshjPBiiUfGnuRgSUnhmxbnIig2W+gS5vyoJV7ilB
         KcqPdTCfxUrU5ZO/2P8+nO0pw2PX8Yn91OXj1hUNV3ua2ZgNRGotYVNu924OfdGVABnf
         39aimHYcATeiQBk/gETIuwZ/iFeS3d6R7jWGKRGCyPdunKSdVzs9SQ6weKVphGZh8AZi
         D+0NBeH5Ea0d/lYWIhlEL/Q9toapV7fGV2/UzZE09YzMokAgCo4ZbRUGYgFBdxVf4kBK
         fHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651813; x=1784256613;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCmZOwEWZATUU/3QYtzfI9njbQsTGpIGno+eX0+5jmk=;
        b=NqWPiAFXN3uoq3GclVV6LylhbVMNVOLty4f+ETy0RWQm/T5FgjfYRsiDoEt4ATmvfR
         rMB1ppHPPQGZgzIYlzveR6QUsNeJA/9UUcF8E6gzpwO0j3cpO0H8lwpB7j+W412zF27u
         CdPTrlCEArkuvLToQKX9DONAhlBDqBjwcK2UXO/4igtGDGpKamLP4IAwJu05Y/uy7F30
         8XhBGFjrtDWyezDEPP3OnY+56tabd0GqyR0ON0lgxhp4qF5jhNUWrvrpa3i4ojk29iRl
         uPF7xgETWcMWxHdhoMYmDoSOX6jcDa/MIPAmI5VO9T5P+HQVuFROZqJE4STyGVCVahGz
         CSjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9yKXObBfimzT4f7hK5o0RONh0l66VdurAtqvLvf6IQalZ7xsFUZp+qO/FPO2NA+mPCrJ/m2EG+wZWwCpt2ExT@vger.kernel.org
X-Gm-Message-State: AOJu0YzSG7EGFW8fvXUEgM0hsaFJY0YkptzUTOHYPa4SvH569GoLENb3
	Ptzz+6+++tLI0AWWXrnYNGKKEHqMaTiRLJV8GZjcdcQDWhbmsKW9S3844X03ABR+aDTTkDaysNT
	Spnh6dbJDmw==
X-Received: from dybmx3.prod.google.com ([2002:a05:7300:d403:b0:30e:ead4:7b1b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d0c:b0:3b4:93b9:2b91
 with SMTP id adf61e73a8af0-3c0bcf16364mr11507220637.12.1783651813064; Thu, 09
 Jul 2026 19:50:13 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:50 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com> <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-7-irogers@google.com>
Subject: [PATCH v4 7/9] perf ui hists: Fix NULL pointer array gap in add_script_opt()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
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

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 316db603bf25..28f1abdd87da 100644
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

