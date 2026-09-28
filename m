Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9A3955CD
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620001; cv=none; b=ABmZuMTaReXKa5uo3N4QG26c6KN5kwXQbihECsjLfBOsneywGzBjTrouhHjmDEqcZiqaXZN63k48MeqqN9tAtSUBg0rb8HJNl+RV+J+OpKh767a94PM2C8RgE16XW60DGZTIp3pXAboFP7uYnp+hOcr4RZB1EnlsITtx1AoQoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620001; c=relaxed/simple;
	bh=+a05Q2428FCe7YhJZh9qZPE9IPSwYKKZt+pGEcJC4Ac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DDR17+O/VOVOw7cyxaPotAGRJe2OHNu8JJqcWcyh5r1onFffnAXcWoIhJ5kvvUIzddBC9WI1ddc06oM4yW/C0SfIxS9qTmDovdjMR3Bl6QLF3gmUFhRnqz9qE/orpU2lVUNK1is4dcG095YBm8SJHiMFa+eZmaUCewOdn6t2OuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIL4B4YX; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIL4B4YX"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso1730113c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619999; x=1791224799; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4hFD82Af3GD/0O4jphB7A4i7F+gxI+oJkaQQHxtJQk=;
        b=nIL4B4YXcyLC52PRAzS+8dHXuMq95BMPD/XXr8wg0aXwpDZo6eBbdjhYkRSjBtKwUO
         /5E1NAYeHzUKx7nYH9PoXm3lkVOH5zX9N30ZvoO43DzomJFr5gzj1anWJzKnX/7C2YH1
         eiVgCNNOqcuL3blQs31RIebD6ebns9a8G2c2esuC/vPMJN3Jn5waH02AVC31vslZro9O
         JpOxlHy/fvMd4rwDE1hYZGGc4EL7WIgIVpA56XiTHk0Q/a6qfsGna50CFPysey85to8Q
         xz39pmsx09wnKutDTc8x8oZMuKD/gZUTdqUTOflh1SpzdGlFOrg4+hnD0nop8/eL8XAn
         +wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619999; x=1791224799;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4hFD82Af3GD/0O4jphB7A4i7F+gxI+oJkaQQHxtJQk=;
        b=AEVzEk9BchmDPV2JsrSqT2ir3pH/YMip1XOEgljielzeD5/hm9mzTzuad+zcE8UXUl
         8svAGrc9Ph7d27mByv4igFOAxiN5hCk6ZPWIP5UtPeOMBCY0VZDJuPIXYPzVajuT8YAW
         OudI7atTij3PvFwtVli0suF0H7keEMeqSJhQQfApmWhKLwRnT4ENS7kFcA4/GjL0DxBz
         Z9gy7Bhr1gxS5AfB8KVeVQFgVVZ7Yr11ChBI5VF7pYLA5Uqes7Evu8Dh9QZDTNJqaXql
         V20y0uSwW9dUql2ivdk+Sd8gW9HHRiaCcznl2xMZBlcD8F257eEsMv7/P8ZHp5H//HGg
         jq0A==
X-Forwarded-Encrypted: i=1; AKwUvByzDdXASC2jqTwF3eutzqCD9FgMan+jf0c/KO0PGMtfUgnRiPZppQxZj2OqTF9R5js+1A6TVuuz2gDBkI5NrU7+@vger.kernel.org
X-Gm-Message-State: AFuF++kUgEFEMpcnpzV0G5+BHkEBKusPuTxua3FVkFudLyhU99epUY44
	lCMu4wfJt+xLE6LFXIHSsuXfPQgy3bqkkrZBSqzspLZlirHYe6ecQ16u9arthHzxMVImTc+vukP
	PW6s5u1OgMA==
X-Received: from dlbsi8.prod.google.com ([2002:a05:7022:b888:b0:144:bbd4:62e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f0b:b0:14a:a6dc:9ca6
 with SMTP id a92af1059eb24-14aa6dc9eafmr1619767c88.3.1790619998252; Mon, 28
 Sep 2026 11:26:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:51 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-13-irogers@google.com>
Subject: [PATCH v6 12/26] perf trace: Use the CPU map index for the BPF output
 event's fds
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

augmented_syscalls__setup_bpf_output() looks up the bpf-output event's
file descriptor using the CPU number, but the fd xyarray is indexed by
position in the CPU map. With -C, or with offline CPUs, the two differ
and the lookup finds another CPU's fd or NULL, leaving those CPUs
unaugmented.

Use the CPU map index.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_trace_augment.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index 0f510554ad9f..7087849031e6 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -76,8 +76,7 @@ void augmented_syscalls__setup_bpf_output(void)
 
 		bpf_map__update_elem(skel->maps.__augmented_syscalls__,
 				     &mycpu, sizeof(mycpu),
-				     xyarray__entry(bpf_output->core.fd,
-						    mycpu, 0),
+				     xyarray__entry(bpf_output->core.fd, i, 0),
 				     sizeof(__u32), BPF_ANY);
 	}
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

