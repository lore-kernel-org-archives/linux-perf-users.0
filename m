Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2325A359
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Jun 2025 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749276805; cv=none; b=JjHu1GdY328FstEgHwHcb54+AR6KIUMsBHHMmYfv3l6XQNmaNWUifXpiO9ZYx6cJT9jKmjnX/feOpmqbiefkjYJ7XeKFIyXmhpJor3wwAR+7OyMhK3bVbiV7sHYDhBhnxoVAnz78QFhHFbhi2dc0s/M/9wDyNCe8RamDMYUf6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749276805; c=relaxed/simple;
	bh=bfHS/emfGlHnhoC/ZDSKlVMnpqM4aGBGfYvFX8Gj9tA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rksRIz00nV6ZGTH4sZXcZMVSe5WDVfzg+GkpnB2x5/SuWp8SocDyhxCvX/XMcwtNeU4PHON4XV0H4lPzibp8XYCx5XjZvHZX7d7eJY1IZIR1rJWFQZ+6c5W4kzxCFkOcpuqndhoT1aWQV3IGiFN/dD37oeAUpJhaClkbhkD0WJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CUeoO+Z; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CUeoO+Z"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-403317cd1ffso1062713b6e.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749276803; x=1749881603; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/b3j+1gq1V00//t0ia9GN0R+cu1hGQ0HBZAPtJXD44=;
        b=0CUeoO+ZyLFZMnyh7mCshFxuBfZVZHP6cQlNyXdcLmzzOe/rizvarU8U++1ZWZRXr3
         7qgGmL3ccgpYoCLCi4jqXgny/h1Kx8plTu/N3YxiTKF8qBObru8t+7YBWxV2MTRdI+nc
         MiwsadIO195z7SkX//SWamVtbc9DXxL8L78Ps1UBgoDpqp8G41Z9LhTNiQIw4+iMR0FJ
         rWWXHNaYX+d5f1FNbpNxtcMD7OiuCWnB00hynu7jrnKGqEI7nZk0x8hpIabBOqE1Kduy
         wLCMH9oUKsyuHqW2yet0USQMcQehCPpnyHE51JvEDG0mizdpKxPCQxGWjF11X58JIvw9
         qqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749276803; x=1749881603;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/b3j+1gq1V00//t0ia9GN0R+cu1hGQ0HBZAPtJXD44=;
        b=gtJ+ZXj5l50ZsatNuTH6Ht7emIxO+7cJspobEfDuFBkzniJOT01dWci3VxqbknAoPv
         eCFi9stqMUhfk9xGLaYRdSHdYjjWdiYLLt0M8nNMP5TANRUrzRBXdCiqCrkkC5VGbhAh
         mpT/NG3ZkdwAXQ2arcPym61aTvoGNvhdCo5hzTt/VjYuVculRlKWucmAhopyQOUdY87l
         6igsD4UKxTwW/h4CuJX71UWDziBW8EtRsXi0oLom8h7e3Mt3znd3ErnvjgeiXA5krQ90
         DYU19bmihU3Cl4+ErhRXOeiAyo5VvXJalqmm/aj3X8NJT/WcPK72i6Nzx/aNfKec5v1e
         TQtw==
X-Forwarded-Encrypted: i=1; AJvYcCWYsvtaFKXUVFX0lkaQ7pTJfsoqRj/A+3Nb9lunTHiDXvvKB9iaF1uZzD/haZB7QwajgJTRTT3wtCGXj/zELekk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0x8IjIEZADn6GCv4dJ1zcX6ElYw5HFZDXwD9iWgFOeSIkr7QA
	zjsk6GWBHzTPTsLgUTgKxsRpImEHYWziRI1cndX0Nkh0Y0bJBRuGe48mnRNfl8Yy2+nx276ed+r
	202lVzBsPPg==
X-Google-Smtp-Source: AGHT+IH772Rq2nXLQ5qLnBdp+yzi4nlFBMyEJIs4tK7/s8fbstOvndVR3+Izd3s0kfth2t5zaU7EubzrZgF9
X-Received: from oabwh6.prod.google.com ([2002:a05:6871:a686:b0:2da:6d76:b15c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:b6a6:b0:2d5:b2ae:2ebd
 with SMTP id 586e51a60fabf-2ea0153d81dmr3661056fac.34.1749276803057; Fri, 06
 Jun 2025 23:13:23 -0700 (PDT)
Date: Fri,  6 Jun 2025 23:12:38 -0700
In-Reply-To: <20250607061238.161756-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250607061238.161756-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250607061238.161756-5-irogers@google.com>
Subject: [PATCH v1 4/4] perf header: Don't write empty BPF/BTF info
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If there are no values in bpf_prog_info or bpf_btf feature don't write
the data into the header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 69e4f6aae293..6657b02d4a81 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1016,10 +1016,13 @@ static int write_bpf_prog_info(struct feat_fd *ff,
 	struct perf_env *env = &ff->ph->env;
 	struct rb_root *root;
 	struct rb_node *next;
-	int ret;
+	int ret = 0;
 
 	down_read(&env->bpf_progs.lock);
 
+	if (env->bpf_progs.infos_cnt == 0)
+		goto out;
+
 	ret = do_write(ff, &env->bpf_progs.infos_cnt,
 		       sizeof(env->bpf_progs.infos_cnt));
 	if (ret < 0)
@@ -1058,10 +1061,13 @@ static int write_bpf_btf(struct feat_fd *ff,
 	struct perf_env *env = &ff->ph->env;
 	struct rb_root *root;
 	struct rb_node *next;
-	int ret;
+	int ret = 0;
 
 	down_read(&env->bpf_progs.lock);
 
+	if (env->bpf_progs.btfs_cnt == 0)
+		goto out;
+
 	ret = do_write(ff, &env->bpf_progs.btfs_cnt,
 		       sizeof(env->bpf_progs.btfs_cnt));
 
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

