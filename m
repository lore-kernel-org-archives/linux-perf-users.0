Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E23AA1BA
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192938; cv=none; b=lJgvrbfsHm5oUuyqjCJCY4q5cUYnDmceQ9OZeLR+VI4lNsbOwjf1qfRvLrVJhiyop4RFJD3idexfm0yxW9QjHLxWr7AlzliD9a7tV692fN/CElZkRsiHdeHdu2EI8LK0gbpN5IyJ+YTN+btbeFUbINiydkBSWGkK/g9HM30ofp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192938; c=relaxed/simple;
	bh=vpY89zTXq+TFA9e0tPvx2fmivWMWEMltN3valuftgr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rK8p50oEkPbYvKMD5wllWmjX5FAFCOy/D+qjRqnd5eAQ+STOL0PmAt/N6Z9LbC1IVzRuHaa/f/mygsphJXlutzdDvBmX+W2dtseeHMAWLjrMtCuy6gOtWtuEc4SeDyLfABJwGdOlqGDjaIfBuEpSsDV33v4MnnQMKt6jKkb/7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hg2Ruxtq; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hg2Ruxtq"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-139b62317d0so7830436c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192936; x=1782797736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+KNhjfau2qXeYaajZSYTjVk1U2OevA2gov1CAYXhgo=;
        b=Hg2Ruxtq5m9bJKSLYhz205wRmrPpNRxUVwWt8rp4Ni2egbZ/D0SPPjGfNw4xPVUTs3
         XZ7aF1xSgHQrNCl/PBxe32qQuoLWzmMDisrBF6hF491WVveX4wLd1sneZB1OWuqixS79
         33Wp9l0T2YOXbgF9rVyElOxIc8L35w6AFMVgtvcEZBeO2Tru4ItFqyC2E7T4q4XcQZri
         H00QAO5YJJkkGDD2is1lv4UnV+/ePxPX7mzRfXOcXj4olwMhUyZec4VHDlj4A/8v6TqX
         VZh8I9R5xw4cpz14rh2x9PDe3vAa8PIJAc8O1w2cFvEAkL9fId9w55Mw6SqTRlacGTtg
         JIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192936; x=1782797736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+KNhjfau2qXeYaajZSYTjVk1U2OevA2gov1CAYXhgo=;
        b=YVwacNuhzjqrovJsAh2tEvsQR7UPjmuMVuOjgCIAe3dWmkrTPKGhLYb7rxXIkw7Nwc
         7MreizbUNNp3WXTZw2yiKKSvwVrsgMCI0nVwp6KAR/UpCGYXiJRmZ1RLqSDcaQgdzw5S
         f7/mZ8ykVWinHBcq46ekgVuLOzrb2EE3VMoOSDFJXuloCO8+sPtu/p+5o4/Du/c/ek0q
         LZOqrH5J0FWThHmO2hQMhuOhIhpt3sVG701gjD9URkB/V+MI4CM6OQT9Wig14syJo5sv
         66olKXIZLFsT1UPAfNvUBGB95F5PhH/+ipu89gFxThGGZhGcSIfy/g0FjcYE9xrEr2VE
         Jegg==
X-Forwarded-Encrypted: i=1; AFNElJ/XbCsbZttCQuNYrn4vdfwrmg9NmSbZYrSUZNWr9vTMeYDiXYeduU7kwgk6kB0B70ti2mTUqxZZxKlK+4Wg2KnL@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVPjZpdyz40P0Bwx2Be4Xagaam9sA1CFJU/rP+DyYQbmw8I8P
	DwhKiJNLoHrSQBINUHY4FG9pt3KAzTIn3hAOsvjOxYMLbeQApviYrkBxOmNFjeBffDe7mjOmTJS
	BoS4wGlcxNA==
X-Received: from dlbdz8.prod.google.com ([2002:a05:7022:ec8:b0:136:23d8:d537])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:20d:b0:139:7bac:db41
 with SMTP id a92af1059eb24-139c705bb41mr695946c88.28.1782192935917; Mon, 22
 Jun 2026 22:35:35 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:05 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-4-irogers@google.com>
Subject: [PATCH v1 03/13] perf top: Fix sb_evlist leak
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in cmd_top() where top.sb_evlist was not freed if
evlist__add_bpf_sb_event() fails. Note that evlist__start_sb_thread() and
evlist__stop_sb_thread() take ownership of the evlist and free it, so
we must only free it if we fail before starting the thread.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: b38d85ef49cf ("perf bpf: Decouple creating the evlist from adding the SB event")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5933c46ee137..abc74b8ab759 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1881,6 +1881,7 @@ int cmd_top(int argc, const char **argv)
 		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
+			evlist__put(top.sb_evlist);
 			goto out_put_evlist;
 		}
 	}
-- 
2.55.0.rc0.786.g65d90a0328-goog

