Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E78361DA1
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823196; cv=none; b=QZVEiaAZi+Ba2l7haAnVdoTJ/q3GvsPm79gwl0lur3HAOgTdO0XcThiwI7YpIDNTKQiuhepzqqzVgDzcwJBat4bXEGsibG2VDn1pm2vyQnr6f1wm1bmrFZfyHmX3qeZVOINJC7PC24aETrFoGiuv98tC1oSDqLhLd1IoNdemaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823196; c=relaxed/simple;
	bh=RtW6Tg8u9ZryYXz2VsGVNfTu1UK+gzTFNsD1Err7l/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TCxgi3YsnY9OpS2mpiDLqcubr3mHRASA64eljtSIka4oSOHCaW/+eVwIpEKlg450G1oUMzOug/0q2MWBO6SQ7N3s8RXZeFvjnQ8y7bHq1dY6yjs25s4rVD/H2ZruLho1WOGSLSR17LFnkotJDhFsjCrv0Q1yTfDciBXbf0CHkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePPBNu8N; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePPBNu8N"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127133794b6so13935739c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 10:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772823194; x=1773427994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ikXh2daPOy/qnwJ0aKuCaWp6OrRXAExiHsLKotJxvM=;
        b=ePPBNu8Nj7uOebchG8Awn92PbL4a2Q1f0xdEGDi4ToqwU2hODBDhcqbzyWVptZi7YT
         S6yjoU4r7DlLZY9XSctTATOSx7V4ba7TGPJHgUrkJoiIvWvfkNlxfHVNFolq5vz1W0E3
         golHzYLH7KgWTkPqt9JE0Ixog1rbt53axV6m4aSGV5Szv66Slt+HD5FHDENGyWj8WRgp
         +1Xr2WJ8a4FZuLvL5rotBu0TEOweYTqnOA88nCSxVtNl7koTTxhq9qkgQAOcI0moyyGI
         vOUARSJmrRS+D+SkfratHrPZB2Ardgp1x97FmwHLU8ZIf6DrmA9U4ZS6c4sw5mrLuku+
         zWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772823194; x=1773427994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ikXh2daPOy/qnwJ0aKuCaWp6OrRXAExiHsLKotJxvM=;
        b=VUpLcSzdq/dQz2CJvAgoBsLC7fGOlXAq1vfDdPWhSqXb4y+E/JKj+QXdLevP2++dhB
         IFV+ZXwpKQPUcHtAdNek1wqdkT2yLnPfJ7yBQ/WlKmZ8XQoTX55rWgESW8LfNjoqbifP
         Uj/civpCDjLr5GELBfI1v5EHe5kzhnC55miByf68/vgls/+55aw0DVGvMZ7phFqH85wi
         h71VcfeBxLkgKMot2VqUdxq2QyacQmv9WzXZBchds8Y+X6WuwFE2QTcNYrTH86cdBdpt
         Dd5k7gfRkrWEog2XUkIJYj6EGB50rUFgWxwCWDUocLjAgiJ1MOta/8bhsAQKuMM0f0ZE
         4nDw==
X-Forwarded-Encrypted: i=1; AJvYcCU6dj+M9mcbgAs5BZLtejy5KTq4YtL2DskFdMMspTweHABavcQe9ChJYlTTHxgQ3NHlY2DUYDkPSu5scugKGVBs@vger.kernel.org
X-Gm-Message-State: AOJu0YzLK7Xruk5WlUGnHBWULROq/+WFxhL7Zm5A+SCFswIckzBz2zg/
	Bb87u9DzfOYyQAZEOZKDHu0v+hIlyg/3+Ec8ib1Js/BgDamSahiFjgevStvw9NgbzPTyaAu6BT/
	kre1bOglu3Q==
X-Received: from dlan5-n2.prod.google.com ([2002:a05:7022:eb45:20b0:127:54fb:a75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7a3:b0:124:9fd8:4ba9
 with SMTP id a92af1059eb24-128c2dce678mr1284115c88.12.1772823193797; Fri, 06
 Mar 2026 10:53:13 -0800 (PST)
Date: Fri,  6 Mar 2026 10:53:06 -0800
In-Reply-To: <20260304190613.2507582-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304190613.2507582-1-pcc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306185306.2017505-1-irogers@google.com>
Subject: [PATCH v1] perf annotate loongarch: Fix off-by-one bug in outside check
From: Ian Rogers <irogers@google.com>
To: pcc@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mark.rutland@arm.com, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

A copy-paste of an issue fixed by Peter Collingbourne in:
https://lore.kernel.org/linux-perf-users/20260304190613.2507582-1-pcc@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate-arch/annotate-loongarch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index 3aeab453a059..950f34e59e5c 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -93,7 +93,7 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 	start = map__unmap_ip(map, sym->start);
 	end = map__unmap_ip(map, sym->end);
 
-	ops->target.outside = target.addr < start || target.addr > end;
+	ops->target.outside = target.addr < start || target.addr >= end;
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-- 
2.53.0.473.g4a7958ca14-goog

