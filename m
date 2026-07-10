Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A6387371
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661802; cv=none; b=tiUHOSiGwaBjnicwmyNXRVG9xEUyu3eUf2GEiua39SXy5E2wR+DJjiSSYJwXxrIphbl0QdbGCJMTauRLJsHtO+N8QTkL/DoBV1GHzTIIVXphkmljFb6LXCNgOKIA6BZLirQ5PgrEVqX7U48vZ0nyDLSlBFJaFswqS+TngAwM2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661802; c=relaxed/simple;
	bh=qe7hglhv/2Sg39+E4X3S+6XweKaVcs4fTn8qzFiPS1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cwdeWazfvyav/tcGvikxcPA7psDMgFGoSUmkrGDp+HjJscjW7qornJdrvH3JmkitHCbGzvXFoINrKgr+JptsJKE+fNffgYN1rZ3tw6JGVcGFZ23hph4tc1LMtLQHFxaWC3XYv3AFqC+74j9a1uHpLnTWXVhPDJAXSxAqb1lN0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkzZF0cC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkzZF0cC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so783315a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661798; x=1784266598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CURnWaQYGdICkcdpVlyqAJACKS69cdYL48ecpQO/Aug=;
        b=AkzZF0cCRJkfdKNnv4S+egBrEsmDd//Abeso2uF//zxXn85r4mXA9rFImzdvKXrzaG
         ewE6Av5dmU4+YnQTW7NSnCpm4tpbFjVc8baQA9riakH8npUuTeP7o5D7X1JLHFK+2Tvr
         qo21dPBkz2LhYNj8Ry1HLJMM4awQKBIIPE+fbm5lTg0pfwgKNtSHwUzHUxw7x5gcI7+I
         Ky4pwasgc3hcxDEkzQE13KZb+C3OUqj34imfEnoor00+qczDe2YGKIEKE8cy7SiDiPbz
         W4AE6z7H3zeXooxY4bNRRGfZTXQa5oNi9T9xapGpTiTdhhRCFQcrUgDfbD8eL73zUI3a
         nbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661798; x=1784266598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CURnWaQYGdICkcdpVlyqAJACKS69cdYL48ecpQO/Aug=;
        b=hHYcs8euqNUgD9ssgUIEKW6OzmvDfNG3tOGuGgUxFGBKK8vP+nlBhzpGlX9sCHbEwq
         FEwE7AyqWdsTWKT0vOtlXsjDQCDRxZNTQI/z3EbOOBMTTCpf1PizR7TywEZ759uwv3uw
         0m7ZOmV8ErkBsAZ3i5G/v2kUN5YMtSzCE6ehdLNY6kl8VV2ZYR4qrJD03f180t+noAD6
         LkU7TrU+bzCbZo9pap4qiAN4uZbWgM4IUpcZmxbnRntMTfef3abreBEydKgSVvd/bPSn
         Lw0P+DmN30cgdxoQijrvH7KDm5Vxxt7zDiDn9LXUkU9fCptXTT8D5e0CcgxvY6civCO8
         Zp5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrXC6GglH3CaIpxOFXNLBwPt+kJXFuP0MIiWieK6EkYKtNSZU6BlNAB8zTP5NmpGtKY38wIRkoZMNxS+4kqOlon@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2IsKjlBcesR1zIuwbxiay5XaqXDtnvRphJlDksfFxpK3Yhqp
	Hnkaq7MYFwgsFWMXP09nJi77VNac7P3bc8IxKWjyfuNDfjcRspO66yARE/GRi44pNhDPcVwSTSc
	eeI8JItGvoQ==
X-Received: from dlbcj42.prod.google.com ([2002:a05:7022:69aa:b0:13b:7e54:8ab8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ad98:b0:3c0:9c19:6585
 with SMTP id adf61e73a8af0-3c0bcfaa7d8mr12173464637.63.1783661798434; Thu, 09
 Jul 2026 22:36:38 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:21 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-3-irogers@google.com>
Subject: [PATCH v5 03/10] perf ui hists: Include limits.h for PATH_MAX definition
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Looking at switch_data_file(), it uses the POSIX constant PATH_MAX.
Omitting the explicit inclusion of limits.h can cause build failures on
musl libc systems, which do not implicitly include headers in the same way
glibc does. Fix this by explicitly including <limits.h> at the top of
tools/perf/ui/browsers/hists.c.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 319c3d6c0375..9a3844dc3246 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2,6 +2,7 @@
 #include <dirent.h>
 #include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.55.0.795.g602f6c329a-goog

