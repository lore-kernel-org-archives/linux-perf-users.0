Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142952;
	b=0CQ5JcY297Cb0fdbtvrhOlmhdYVFHtZvK0T+JkMit3gl8KTqY+TLAZBQiJk4Kp44f5GY
	 VaJO4YZG/Eoe7W7sP4GvJKpGu45M6bnALZpVSzQCeLl1r5BCV0Vc2o/Q/iEzZT9Zv37lr
	 CVyZHQhc2jorYWGrsGnBaaoPTAn7CcOnn+k3bxUb02CFE/EI8m1im3qCDt7Wd8nJvOkxl
	 e2LjnqrpBcmVKxpCvd5qu91eW5Baa3B+GETAKLZwSrWRyuGRv07uNwPAGhSbSgWUwSdKS
	 751XaJWfwuRyHSFZBUmciAZuk2R59OWeim6+b9AHPP0PlWhr5W+AsZeomViwJJ8ESGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KBkH5Nn6KwmCJAHfu/YWXefwXi+nPHLDKKFILwJFl2c=;
	b=WprvFY6E/0lAH3PgRi4F6bnww08X7/LLkbuJnv2ESezdQ3hhZIl2XTjEzlDMD3EsR4mN
	 ooQfSCIMPRjKpvD6hJLbxA1pyUo9+9ZT7P1wyc7b72FNvUuv+HQGqCLRVWXuTjuArM7w9
	 toohF1Ihqij7PWe/1tVIPyDYsje2ODDsaCukhMRaVgjDTlQuN1OheR2ubbxHQ0RzKhGHq
	 TsfECbomB55Us7X+zFWolLIxn9szBqgU6ZGkFOJGzC5A5DppQXgNwCNP6eIeWxtmeqvxz
	 Y07YGao0GJhVlbjAcRGkRjJarJcQDUwZLrNvDrPfcc02crGPKETgHDhj0a+RWnvLqBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BpxwMHXe;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B260A262A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F07B260A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BpxwMHXe
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso619329eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142951; x=1793747751; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KBkH5Nn6KwmCJAHfu/YWXefwXi+nPHLDKKFILwJFl2c=;
        b=BpxwMHXeRLmT2bbcwUZCVi3qQNxU4CWIJichXCkFlK7QoiXV9n+k6tBBPdzGKGSkba
         Wn4P6xPboN9EKh8Tf2NCydLjZhAZZIyjvG4plrPXD6hwGxWna8HJXf+t8a8PENXJtwGw
         vg+uh19ib09vz3/7IFejfFAVnZvgnAoM+XLEgGMVMaIH8NolKYQK2nEaYbWWQ/EzVjRx
         tNEJTqUfdeefqCfFeXwErFb2OVvr/zXYctyWEW4SMVjnPkZVqPgNIeYYazfHo3zWCxDv
         2TErajon5qelWgbHMGdNpgq81n2b57oUb3wj7aNhimxubiqX/LpIJ15Bd11b8UKjb5cT
         nb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142951; x=1793747751;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBkH5Nn6KwmCJAHfu/YWXefwXi+nPHLDKKFILwJFl2c=;
        b=vV3HhA92IROL0Y18gyYGjQPeYqOZcY6US57GIMdNY8ODqGe1pfil1hKocHNcBAoLuq
         rB8/zyRoWNTOxRMXuM16DGc+WJCMcrlHx9VT1SFY/gpNqHETgbnQgZbaIFM8M+zSHO+V
         4HefJv6ZZzYMNiCNyWVDm4xccxcgSZZKoT/h7DZIzjpk4PZE5ZbhypD1JEYTrb2FP981
         TW6IgLA81Lf0mfsO4pdwxEqJmHC/1DcBdIdp9pL3H3VgAWsbuix8NlQJmslYUtTBlBB3
         2cWUaVAO75Gh57grD6XNQlawWucoNda2tKK9ZWyBtkYyNj/x5Q3p94dtEU6mnBK03V2C
         qmDA==
X-Forwarded-Encrypted: i=1; AKwUvBz7H/vioiouZMwLS4UdONP/Mg6rR2sUZO5k7Xa07ku6mPdn80GPzmVdDKKIrze2mJ/hOGN1trE5aEypn8Wjw/l2@vger.kernel.org
X-Gm-Message-State: AFq9FYImx4yjnLAfW1OrSKcqG/qRP01wJAgXN+NHYC72zEfWcv7Tysu/
	LH4oqKVcs4bKpTQ0L/vCS5Us8b25q9Tr2KWKJvzj4w6jnZVQL0tTgLel0SmTMENr2BKOMaQbm05
	5QJBlKE3vwA==
X-Received: from dyki4.prod.google.com ([2002:a05:7300:7c04:b0:364:225c:dfac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:41c8:20b0:369:fa7c:aee9
 with SMTP id 5a478bee46e88-36a201686b1mr1520976eec.19.1793142950771; Tue, 27
 Oct 2026 16:15:50 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:07 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-14-irogers@google.com>
Subject: [PATCH v2 13/18] perf vdso: Constify dso parameter in dso__is_vdso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

dso__can_shrink_symbols(const struct dso *dso) needs to query
dso__is_vdso(dso) on a const struct dso pointer to exclude vDSO images
from symbol shrinking.

Change the parameter of dso__is_vdso() from 'struct dso *' to
'const struct dso *'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/vdso.c | 2 +-
 tools/perf/util/vdso.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index c12f5d8c4bf6..7f2dde70f3e4 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -361,7 +361,7 @@ struct dso *machine__findnew_vdso(struct machine *machine,
 	return __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
 }
 
-bool dso__is_vdso(struct dso *dso)
+bool dso__is_vdso(const struct dso *dso)
 {
 	return !strcmp(dso__short_name(dso), DSO__NAME_VDSO) ||
 	       !strcmp(dso__short_name(dso), DSO__NAME_VDSO32) ||
diff --git a/tools/perf/util/vdso.h b/tools/perf/util/vdso.h
index bc74ace603ae..b6e05bc2d9f3 100644
--- a/tools/perf/util/vdso.h
+++ b/tools/perf/util/vdso.h
@@ -19,7 +19,7 @@ static inline bool is_vdso_map(const char *filename)
 
 struct dso;
 
-bool dso__is_vdso(struct dso *dso);
+bool dso__is_vdso(const struct dso *dso);
 
 struct machine;
 struct thread;
-- 
2.56.0.313.g2479322e68-goog

