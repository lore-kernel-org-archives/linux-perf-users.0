Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF43932D8
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 04:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782798; cv=none; b=P5C7ipmFqZoYX+S7KzVfow31PnaVkYBmlrN43r477+jRhnGm44l3esalg30bn8Wn+mfk/iN+S84mQ7HoSj1VJfJbWLITgCI25VjkA9gKNViIDxGB6bJPEmJTbUXGm5QWaNEnWHYqT7CEmIVPP9Yg575RZLTHfaUSwL0yfai7nJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782798; c=relaxed/simple;
	bh=4e5lJdshyVNLKjHpTciKZbgUhuEA4gmHv2L0MMDkQ6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WXySHD03XzeaYX/wGqF85//XVYg3D/sTCt55zhPzRBAnGcVIawXg6ZKR2mVw7gwpMaVWyEw+p1aLhscTUmKuZ5/9PGAc21ssMUmOt9j2haYqCyHolDrEjqwIugZDoyX7RfHKpQejDi+pdDs+krrHj/Cg4s10+Bw8Wshg8uF+RME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2EzmqdH; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2EzmqdH"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so659048a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 21:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784782794; x=1785387594; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b/udcemSvZpoMA77w8mffwylF1dXnKAWFX5RvsMWK8I=;
        b=H2EzmqdHDn4UNG5wOGlXYNUMPWFIYkTxw4nRYXRUffk2nQBF+czUl/Ez/9ddMiBe/n
         1CJ6GoD4/3N86e87OU1RCeysqrla1lMfQFxyrBkffNaw0J91tCO22D4rMQatLM4Lnuey
         vFxkSDv3QD4qqYkGckLDETjZUIt9ewA5mX637Y5Ptj+nofyDGDvR/5NFRKnHspnraHqZ
         lkvo4W7J5LaWkaeqvR13RAysh3L4LNTHmA4UvlR4QyUoo/OBDSE5eKNn5poDdKNden1c
         GmF24wB8TMNZJ2LYNyJ1AA/OTh/X+R490jHLZ71rDvsu4GOHKfeisdNcCMB+08KWHcGP
         juRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782794; x=1785387594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/udcemSvZpoMA77w8mffwylF1dXnKAWFX5RvsMWK8I=;
        b=hozqz966SvyDZqaXVy6xY31msF1KbyVHlFcm0Bp6RD9kEwRU80szcFY5eNL+fO6Hcn
         IyShw4MZuHXIjUiOXHki+BGi+6pR8Tyfd2eQ9NgRqulNlqM+mqumAx1fnOA0mJ65V5f5
         XFeM8TjiFnEDcwNs2IQAhQ7q5vElaQb5chRCxKvor1OxVXIsisZjiKAU0H1wIsHkqPTh
         P0+gYOn02WlCq1uyhVLK6CR5hOsa1EyTvrUkM6PpOyVNmpc5rDZciMs3eOQBqIHvmjWh
         Qeye9c8TNajpxGl3QFtz/NjyPv89GNR8bNyEASXC8+/zWWvZY44VdpF5Mxcc2Jfo3PZu
         JODw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0cBdGLq1wNjkVuyB7owxB0K7E/PVBaOBP1D8d8MWHbu3YrR1rv/VHWxJgp3lAGpXi4XvDGONSvOlJo1qXEJHj@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwLWbRjJxWIevuUhYvukWVz+/XZg7GMVvJlStRFXc3bsG1yFX
	88xm/in+oAANJlzXArfI4zkN70YodhBN1RZ5i6BNdyOfMPD9VrPeC9gJdXz3BP2vQpQFrfDvlFv
	T5cC/kvdFZA==
X-Received: from dlbup12.prod.google.com ([2002:a05:7022:fd0c:b0:13b:340f:d011])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f06:b0:38e:adf1:5b03
 with SMTP id 98e67ed59e1d1-38ec6665307mr1653963a91.35.1784782794287; Wed, 22
 Jul 2026 21:59:54 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:59:43 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723045949.988740-1-irogers@google.com>
Subject: [PATCH v7 0/6] perf ui hists / annotate: Remaining fixes for
 reference counting and annotation
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

This series contains the remaining 6 unmerged patches from our UI, hists,
and annotate fix series. Upstream maintainer Namhyung Kim applied patches
1-6 (except patch 4) from the v6 series into perf-tools-next.

This v7 series includes:
  - Fix stack use-after-return for symbol_filter_str by duplicating with
    strdup() and freeing during evsel destruction in hists_evsel__exit().
  - Guard against NULL hist_entry in add_script_opt() when trace is empty.
  - Populate map_symbol thread in report UI with proper reference counting
    (map_symbol__copy, thread__get) and memset zeroing in
    free_popup_actions().
  - Fix dso_filter reference leak and exit zoom cleanup.
  - Robust cross-platform disassembly fallback when annotating without a
    thread.
  - Remove duplicated thread member from struct popup_action (placed at the
    end of the series per reviewer feedback).

v7 Changes:
  - Rebased onto latest perf-tools-next (after patches 1-3, 5-6 were
    merged).
  - Move symbol_filter_str teardown to hists_evsel__exit() to allow filter
    persistence across TUI navigation while preventing memory leaks.
  - Add memset zeroing to free_popup_actions() to prevent cross-iteration
    stale action leakage.
  - Placed "Remove duplicated thread in popup_action" as the final patch
    in the series as requested.

Ian Rogers (6):
  perf ui hists: Fix stack use-after-return in symbol_filter_str
  perf ui hists: Guard against NULL hist_entry in add_script_opt()
  perf ui hists: In report UI ensure thread is set with reference
    counting
  perf ui hists: Fix dso_filter reference leak and exit zoom cleanup
  perf annotate: Be robust to annotating without a thread
  perf ui hists: Remove duplicated thread in popup_action

 tools/perf/builtin-report.c       |   7 +-
 tools/perf/ui/browsers/annotate.c |   2 +-
 tools/perf/ui/browsers/hists.c    | 153 ++++++++++++++++++++----------
 tools/perf/util/annotate.c        |  51 +++++++---
 tools/perf/util/annotate.h        |   3 +-
 tools/perf/util/capstone.c        |  42 ++++++--
 tools/perf/util/hist.c            |   1 +
 7 files changed, 182 insertions(+), 77 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

