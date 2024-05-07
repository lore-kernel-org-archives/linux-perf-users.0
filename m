Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7388F59;
	Tue,  7 May 2024 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715051754; cv=none; b=g8bHUxhCbVAVDx8PDR/SVg72SfqaaUUtiv5JOcadfXUoDXAMe059iXspvo3NjQVoPew/hdSfUKetUMoxPfxHszChCjpspgq+GY2zi2e8pGJRZSlMgLaA4BbIo+Jdac/95f0Ww3CNi4hcDe6M1rsOxcijQBDOmzD0oEw7eqYeibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715051754; c=relaxed/simple;
	bh=AHH/m+ka+Qb6OnM3YwkZe2xFH0HDbhoI5R1oc5Qceuo=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QqiSWXd1MS+M6GoVbIId9mxzBaKT/9jyxZgqCJMj01d0V2JB71V7GWXdiz3rA7GeUap1KlJpLCYBGQQ3Mse7EAnJPxa0PmEcdsFy1ds1UksVNtsim279mmGJ9FZj4YRn25tYcJm8EcdjsJ8ajYODQ/NTfOK+z9Wej/mjvvlSUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6WHK7QA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6WHK7QA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee5235f5c9so8376175ad.2;
        Mon, 06 May 2024 20:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715051752; x=1715656552; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ats4eFWKO0oX0tbMb50Cxd74w7mweIFzoDVzLRszzCc=;
        b=C6WHK7QATNmjzUOJDOq9TYFLILoi7Uq8KPOYzgHAd9TsvlUmG1WoRZUiZUHfqaTPEF
         GMVzs8UP1jfFvX/9RtiKFfJ8E4iOgyIT5M75SfuCJuwI0nYjXxkMZXXYjw9bCljUeNNC
         KJ+oZQsF+LyEp1/NoIPOPBPFeoh3XoTKchyXCGD0eqASE+h/IzCnbH7qeQrWvF7X8MAT
         5r88V25USzOWfg9R7awPxINUfYPuegfs9kvIFPH+I49dNPwxoF2fDvKINWn2DITuJPFB
         mrB4wenJ5jKiEkIQNmi9CpAPfYHrZ6zzK/LqtlNW3kPzW+YfhofgtvblzfKVTKsgi7G4
         Ivcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715051752; x=1715656552;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ats4eFWKO0oX0tbMb50Cxd74w7mweIFzoDVzLRszzCc=;
        b=b7Frq4ispRZPMDiFK1VuPQIUMrC3zJ8M0gn7flFcgQz2FJmgbSk8uhWN+pNnxawCQf
         4LowU1vuj3RBCHbZxTOtQEaYXCR2xBjRG/j2akK9w12LY6RNgxrumCUgZQXnLRoh0xPa
         C+3CZhLQTekniyXv4k/YqFNab7ZdpJt5/ImzoEsMtjMpRJal/6A3s8kj2UZZ7lH0DT+G
         xUvpQzLEKVcRlmOrYclsKTm60Z/D2slrvV3thX41NKC6k25xdDsf7qYgC8c8UUx3vIGH
         VwyiS3RLpMWO7PbzmEXpGzjSa1lEjIHgRcICQaC1yev8t7tWIGVlfijEPm08eN+iqfcd
         HJKg==
X-Forwarded-Encrypted: i=1; AJvYcCWsv6GKwX6QywNl5KrW7rS6UpY+1ZOMTMk/a9I+9Fa3yntlCcJp7f8V4IwGclEOVZ2OwRo9S/C36f17A1eXPGx2nOph10B59mLJP+VPzSy3wxBw+BGI9jRjCDRWpNTFatavzXryNeeP5m0Fg9/uIw==
X-Gm-Message-State: AOJu0Ywhp5XjOh/hpYmq9ej+MU7uGO+J7oa3OgFbMm2WESUb6llMOM8w
	vK3OfbpDuYHwsZMv3YSrZfy9SRiYMZ6qc0WZoQIrl17s7jfI85jF+8rvYHLi
X-Google-Smtp-Source: AGHT+IG2A7Jwj//hAc1nElH89NrAwUx4BwSm0mZH0KTXViKxK5NFUpOagyBjUz5F+wnlnOmp9CW0Ew==
X-Received: by 2002:a17:903:11d0:b0:1e8:26e4:d089 with SMTP id q16-20020a17090311d000b001e826e4d089mr14805245plh.54.1715051752198;
        Mon, 06 May 2024 20:15:52 -0700 (PDT)
Received: from localhost ([187.19.173.21])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902c95200b001ecbc8137bbsm8970419pla.131.2024.05.06.20.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 20:15:51 -0700 (PDT)
From: arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 7 May 2024 00:15:48 -0300
To: Yang Jihong <yangjihong1@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf kwork: Use zfree() to avoid possibly accessing
 dangling pointers
Message-ID: <Zjmc5EiN6zmWZj4r@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When freeing a->b it is good practice to set a->b to NULL using
zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
pointer is kept somewhere, we can more quickly cause a segfault if some
code tries to use a->b.

Convert one such case in the 'perf kwork' codebase.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kwork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 0092b9b39611d7e9..56e3f3a5e03a2d66 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2230,7 +2230,7 @@ static int perf_kwork__top(struct perf_kwork *kwork)
 	perf_kwork__top_report(kwork);
 
 out:
-	free(kwork->top_stat.cpus_runtime);
+	zfree(&kwork->top_stat.cpus_runtime);
 	return ret;
 }
 
-- 
2.44.0

