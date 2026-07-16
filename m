Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7053B1032
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186653; cv=none; b=foOfm/HlDbNfcRc7ga7XYwqYfzDRgAJRZI8nIpOAg7Mz3IHECQ71x+QqBB8Ua3UZXKfJJBQd2xoo3TYNSFa1mEijkdItwUJc42cg0Ea4XYpkPjECW1zA/QhrRM2h8UgJNYrhxpo4WLEMsUkigepniqaYNV9qqkPcReS0MEfZ6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186653; c=relaxed/simple;
	bh=LpZZf0uPbpnqLbOnK2/kDxxpnsHTAhj1zWC92uFZWec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJf0FyYL8po2poSkhfi15z3N3EEbhT5R1mSa3QliNXOZA+DasClFg6GSsMpn5Q3pz1wdSh7aElnT5A6klxhCvMb78uSQ/+VWdZpNulZKeTjuh5dGNUOx5mA8XOgjT1AbdwxLyqRWzEYcFoQMii7Ts7sSLAoLarPKhzBiU1izY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/a365fV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/a365fV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8894570b58so2344734a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186645; x=1784791445; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/V8kjed7GrwGUSXhoCStThpGIKdkKGdtQopyQ9oles=;
        b=J/a365fV5AsiJPf+f1xF3q+4/50o7mvOBdpvEZ1Q2rP29ILDGlbesXNbtqU1CfM36o
         Lj8iehWyBupFLEeQlxMfdFOoIzepoZT4PZqZwswge0M0Zjuhc7UWgKkFkkfQlu65s68n
         8ZXrubO9lw0JxoGh8jhchmdvo+KHEFVwNFhcTZQk+/nu8Bh8cxIj2hu6lVZL68Y35dh+
         BirU72kSAVaU+UXBZlub/Pb0ZiUjch1wFxuiWm0HKRKKNIvdcUY0SE5I1RRS/G89Q9Ku
         SXFzwtIexIZYnRMgwuVmJjipyjcPBCn02mRbT3LPZlsurHwKgqM0QouLB7Fev9HArJgS
         b8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186645; x=1784791445;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/V8kjed7GrwGUSXhoCStThpGIKdkKGdtQopyQ9oles=;
        b=lt0BZylrZDNGb4wvghw4Fap6FFsBXCMlZ+n624Vf958DhMowfwYmKhlyQb8UcduhRS
         U3R9FFRIzpCC7dKWwy3IEnRGjMiOBepJbIAHDPwlgEHtlY4miF8zwWaHWZu2xhWUoi+V
         fW77WTi+zhbABYboX7sr7GLVToYa/AEAL5TCyQKdaCydzArEp8mviliwqrkkOpLgqiXH
         nyAIeJa8DtsDIhUvtFbAkOu5SvN1bJTPzBdYzy9wO2cLudDje4TZfT1aOgOI+8MBkJ4w
         UYqC1DETKkodrCChdHFHVBr16u6NlC5Qf68+y6KX6yBpk0IGPw/TfBuRWMMNImCRBOSk
         +EGg==
X-Forwarded-Encrypted: i=1; AHgh+RqwsILMDm9l+/7R5IWgdCwtox+Iz0rE6y52U6fz9Pw+h4nzspmeI8FotiFH3SxdBRfFL6JiZmJvLomVqdvIxj+m@vger.kernel.org
X-Gm-Message-State: AOJu0YzqK/n/f9qmBcvKwnl8mczYgofxr7LaLyagDoQwcTrW/ge/4j46
	pZwIoy0CAVOzY6PpeKu6ZSU2JQ650hHVw2ZhSmgK+mU4cEnvmaU3YjHXeKdduxLLU4iqbNHiuU7
	4bHUb46rY2Q==
X-Received: from dycmg4.prod.google.com ([2002:a05:693c:2504:b0:313:fd4f:14fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:460e:b0:3b5:489c:7bb5
 with SMTP id adf61e73a8af0-3c1109ede1bmr20690274637.28.1784186644696; Thu, 16
 Jul 2026 00:24:04 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:47 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-6-irogers@google.com>
Subject: [PATCH v6 06/10] perf ui hists: Fix NULL pointer array gap in add_script_opt()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
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
2.55.0.141.g00534a21ce-goog

