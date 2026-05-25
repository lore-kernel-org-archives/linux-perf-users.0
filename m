Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6883644DE
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751178; cv=none; b=U4oQ2ZrdxI1neF/mdI/1zaobxZ/FUyzvtrqpi70eOC89W5MqZx3APF1UtfBfcuNNjqlVXCIHsn/X3T28ugm8nt0hjZzSN9hn6ortDXMhTNhEcjKPM2/EJdK7NIFLDNl8QD2inx6h55WFNezpK6D5ofMkiBI+Dj221KgjxDU/JQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751178; c=relaxed/simple;
	bh=8Vj2sUDbgzfz9JgyapQiYs3hu3CxfybFZtiHlHvtRrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gyZHIGUsHTKCfjJaNj1iIQ3OamGxJgLW/LXkts6ST2a2+E2wA155qy1dzYFYHygGnjw1c89e5L+R8hLBNhL0ouCujm+KlZShIXSLIAyIZQJ2hDAN3Z0Ve3/ZJIG4tzh6FUA/2zjyRcZ0xc0iDY697Vx4AhHEbJXQiHijlguX97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnsbH/O7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnsbH/O7"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c829586e894so5234218a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751176; x=1780355976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kc5rwQIsP6Vuppfcuur6klK9jrgMryjFKDK5RBygvYk=;
        b=CnsbH/O7aTbnicr3qtvfv9sGhsPKHidduHLHhwnKAhzkRzV9X7b8ioe0Hir2FDynof
         o2mWGT64Ndl0NSOiUFd1U8A59VOOVEjSHBR1F/L/klbRktT3jhzoYgj16d9TLvbAS3kW
         mFqnBho9Zs9n8nPkkdpFF0p0HbxkxCuLLNZEgPvI1iTo/8MLu/Ms5Ehpej7gGhdsckW+
         fSZvO36VZ85gZF24M6IgHc2E/e9v7wm+cyGj0tXwNIrpKFPxW4ULQ/djgPP60HgIrvc+
         ThMBepb5XaORAX09LDeHuFb/4jFvzdg7Ym5wbOmg+11yxuoGiu3ZnNX7DbkkKrZMXWVo
         IKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751176; x=1780355976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kc5rwQIsP6Vuppfcuur6klK9jrgMryjFKDK5RBygvYk=;
        b=s5k7h2pZRkSJnyobzqFl8/e/ePiYBGwtq1bHWaSMajMqSEBqWumrJ+oIylG+iiMNif
         Y1fG3jreshMyrfbvh3aWtvTGCHdx6luLCKXnd2Pjw5L84ruSl66aHASpLrd5ju5zJukn
         tV3uAENrojOcBrZ4Qo+XelYjic6H8mhd+CdqBFmXp8oXvm9bC8CQbAjUkBFC1aaMEMTg
         L0crV2IgXZc77GtRjKX8hSfYEuP96zjDktuH4pUVoVM9mCvL741Ev4FMfXyTtjfqLElS
         fSE0rtW1yn687LsnliKV4gQGOQYMjZg2xb5GeFNOibmtFKxFELzBxo/c9zGWoq+JMceo
         /W2g==
X-Forwarded-Encrypted: i=1; AFNElJ/dACKYUDrI4VV4dshRObYQX3tWnzw6rUQ4cI1KZCHqOTgmAcUBq3IrfuHGzXaa+Er/ixRpYaET8xbqQut/bVh3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lVpmLasIvJ+IKhTKr2h5YARLzh8X0sDu+fbgM4IUDSDcLAUv
	qT+cJW+6Pv0YMpSOAtIELvHy/3ywN5C0MBXqb/WNVzvobbF7Jhp1YyPm8+clOX3TBLJnLIc6MaG
	bngrF06K6sQ==
X-Received: from pfbks23.prod.google.com ([2002:a05:6a00:4b97:b0:83f:24a9:a829])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:15cf:b0:3aa:f9cb:d43c
 with SMTP id adf61e73a8af0-3b328e7457cmr16181153637.34.1779751175934; Mon, 25
 May 2026 16:19:35 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:58 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-13-irogers@google.com>
Subject: [RFC PATCH v2 12/14] perf stat: Extend JSON output linter to test
 advanced PMU and metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+json_output.sh to run
the advanced hardware PMU, topology-aware aggregation, and metric-only
JSON checks a second time under the --new print flag:

  - check_per_cache_instance
  - check_per_cluster
  - check_metric_only

This guarantees that JSON outputs produced by the decoupled streaming printing callbacks
are verified and structurally valid under advanced topology-aware modes and metric-only
JSON row-column layouts.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/tests/shell/stat+json_output.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 8168b861ade7..d18cac5dcff1 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -249,7 +249,10 @@ then
 	check_per_core
 	check_per_die
 	check_per_socket
+	check_per_cache_instance
+	check_per_cluster
 fi
+check_metric_only
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

