Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D8BA49
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313612; cv=none; b=Y42PGzvhLW5biGkFQRu9/gpwf+E365q19zbZSuuBTZF6XlY4fr1bk5eMYd4qP0A/F/9nMntJJEVWnsJA8MbZ5m9+V0vZ8qLklYiAcQVQ+dYFeryiwbpriTRYjEIFkHJj7wY+xTSCJfLLamAVcdg2Cr4B7eHreAGNG2Rk9XS8bC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313612; c=relaxed/simple;
	bh=WydwZX+4HGFs/roSNEAeN+iGcRwNyw0N9yYTQ/F7jhM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Gj/8SeJXhIVqr9iOUpi8bLIIbNucZm2mvYWhocDnz1AleuTHGoHfJxZILiQIYPIU5VM0hoJGONAj62oPaxZSiVszEKDBPZDTTVjgsXuO682mzEfVA9e0ihf3tyAUF+wyAnNkR7H+8MnrwA+iPlbPgnMBquuUq33nfJZlkuoCr3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrakO/+R; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrakO/+R"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a1bc0c876so5291830276.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Dec 2024 17:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734313610; x=1734918410; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hgXWFWdI7UOHyMHNmnwoqLPHk2iqhyZAlZkweGRato=;
        b=mrakO/+RFdm+nPNt6nRY4WNHsgN7GgUI3og/GJMueUlH5JzN/IhfjH2DEFsi0BZjxX
         42xLmCYnnkFPZKIHCo47UbIWAnqptRyyMOMNqjAT71rp9+6oKaAW/qBx5CUEgv8UShY9
         n/n0bqiVvM7yicugcxDd+dWOXLhyex8EVjtr5zEEAZ/uqviz9sljo2URC+Is2egzT6HP
         L5utqq6vmtjCrvgdMilNhjhj0BalF/TTe4LVz178FfMjw6DMGb3S+atDyw7G90iRJshP
         8Rb9M0eY7Y8ToHsf9uR5B4tCoPK8t9DKaA/FHB9Q7YmQrjEFrfY0qQSupsLPslt9dooi
         q6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313610; x=1734918410;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hgXWFWdI7UOHyMHNmnwoqLPHk2iqhyZAlZkweGRato=;
        b=DDHY+NPfCg1lp4XoyRQQYSDVNrrWO/hLlSRdvXEcR9WnOvF2M7pwLE53wGjM0Hmw1h
         8Fw/hEEjKyHjoo0p6RLDiNmPwRPWyzsGDDDC1bg1CCftA9DGvoGTzHLo1CXI1nu0wpfP
         mgaWPYbRssAKX7Y0Usn0/8keXkoZT6hVJBj3QSaxvpCKtmH9Loh3jpS5VBH6QvvNZTNd
         dqL6soswPtsjnvOCTIowAaqc02yBW/+3ourvGsnFwBARWO3ORMbQWbhCHVqJLrebZE5U
         GGCjpgUH8spqhOl5uwyMf/MaJYth9Wj8siDlq/K+osDZApwiLIQr4XD3FoQrDU9ms384
         U3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUEJE/HhgU2xxHcYUT4kQWc8sUXXdJbQ1lQFldNWDvlviooDckspV/Pgs9G/JKUERIuoWOoFO7DumBJeDUdZ4E1@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsA/j+XY0rxEVlr1OK99QjnwZPYTkYNT9XErHcZSwCIf7lWqS
	ZNqo/Urx637Ek2gW0LrrFHu8tJkKHklkjjj2I2aqUAqFXU+GOVp2//gXJwyZzNYIeB6A9LBW/bH
	mhPLljA==
X-Google-Smtp-Source: AGHT+IHxNKOZXQRqXFBh0Em/H+iNSlDNtLvXHYWQSDa5n8zbCETpNRs8QA+iIutGKx825WSX+uZFAOsSUWPP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:175d:4db2:deb4:d450])
 (user=irogers job=sendgmr) by 2002:a25:dc0e:0:b0:e3c:9c76:b2cd with SMTP id
 3f1490d57ef6-e434ecab7d4mr17133276.5.1734313609783; Sun, 15 Dec 2024 17:46:49
 -0800 (PST)
Date: Sun, 15 Dec 2024 17:46:34 -0800
In-Reply-To: <20241216014637.304761-1-irogers@google.com>
Message-Id: <20241216014637.304761-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216014637.304761-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 1/4] perf header: Write out even empty die_cpus_list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reading the CPU topology is tolerant to the dies_cpus_list being
missing by using the feature's size in the data file/pipe. However,
the feature's size is just the header size and may be
unaligned. Making the header size aligned breaks detecting a missing
die_cpus_list. To allow the header size to be aligned always write the
die_cpus_lists even if empty.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 048e563069bc..03e43a9894d4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -628,9 +628,6 @@ static int write_cpu_topology(struct feat_fd *ff,
 			return ret;
 	}
 
-	if (!tp->die_cpus_lists)
-		goto done;
-
 	ret = do_write(ff, &tp->die_cpus_lists, sizeof(tp->die_cpus_lists));
 	if (ret < 0)
 		goto done;
-- 
2.47.1.613.gc27f4b7a9f-goog

