Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832817589
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892657; cv=none; b=GvAcAjF1lYSoF+Ux5Py7DaehKH0aY1Meen5aq+tKqLTXGxVT7cUPY5RCSmOd9joC2tev6hge8WiqkJiMNvemXn+PTcsnnHIkyLlPf9BD7cbupYPCtzKA8htMl9VHQwiRgy8jTBRmxOCa+4jZ8KcprfYLaHqmPSKRZcE/ymrZSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892657; c=relaxed/simple;
	bh=UV01xgO1m+X1+w1j0tsdOivqonwgpzUr5TVWVuyCS+c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dTsZGbShoOgkSc9KVU+npfrjLHvVwA/tX/fMR4ihSCfpj34zSkhraANbCc7w+KkpuMQRTjc25CHQEvOJSybXKjXhXFZUJyuwfas+XqeAEX4KKoH79lcGnHfQ0mAosURBioSUBmawXfD6VcpXGU+e0+bSQLzlF46HM87IUZO5XiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNGnupZf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNGnupZf"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74645bfa8so2673093276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2024 22:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707892654; x=1708497454; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fauoScqMGb0T6W+waGwPLd0PTd+mrpoq3alj54i0j8Y=;
        b=dNGnupZf2D5yXYxrAoxIUNakQIi2pIcolGJADLKmjdaanYrjGbyFJGbA2Z18wCEyZi
         QmRcAtWjA0x0Y9ryuD2mTHRFsxAuj71EfkdBPfYyrap+WIKqyoWGJxzIAbvG/nAvUc5P
         0Ilh3V3hwGbpMN20G/l/V+5TKBGgnsXdmJ7hu+JkEX9shCxK41AD3kuLfIcrpna67m9F
         Mcmg3zCBL+DqBKykhwSXYIi1oMiZUh2C3YjHb9f4Y8FE/3rIwz6eB8tatUyKylnCbNlp
         4G5QJgsP7UUqV5sP5ZrrkllSDQP9ihbtSuy17djfN6m8ySPs6D93UeJumEP5zGy8vDce
         xz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892654; x=1708497454;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fauoScqMGb0T6W+waGwPLd0PTd+mrpoq3alj54i0j8Y=;
        b=DWexr6qp3VytBHXWetWi06ZyEipa2JAoqlWzrd2hbKScTTGwwZKk8+KA4ZIvbZ0AJa
         09MA/6Xm/C+/jDlJI7iYyTdIo5bXircTPOIPl00MBegrCnHnbxHM4RBjQxF+SE5agUNj
         h0JUV1oz2j7gcm57ny5mDZ5tclJP0r1DRmw+W+pckdkehPd2kI3OLay9lqNSPuuINSoF
         rRW1cTtOXcTbg1Z2YC1w0P8G9IElqVIss+BBU6rbQILGPI2AdiomCgE1119I6Yh3Ebut
         UQHjdDLaRh4NdtETQgn3rSnfX2eDMY+fhQm8G4rlcFiBAfB5nUqrGOQ/Xyc5Cav3lluD
         kO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYTvs11+jRmAnCiLHVwxOTDAEJ/x5tcs/Bp+nXPZmoUW4ikgrUj7eufkfSnHRiHIitsRAr3Nu8rgqmR2+vP9eBSMQUxI8cjtoqSpV2k5BX6g==
X-Gm-Message-State: AOJu0YwWyWksi/CniMpxY5WatT2B3mMVZF08OPPXfIyVxr72ZDoBgEHl
	topgYgT+GOXrolEQUDfasUWdSEKFbp+GF1MX56zgQt7GR9c1d3snvZUPgTrI9jAOr0buKRg22h3
	Kkat/BQ==
X-Google-Smtp-Source: AGHT+IFi3zXQvwnC/z5gX6vCW3M3+FZqgPpuASOu1UAfp5HpZ8Z2Ob9CLJ9tDZc3bIk+YeJf9imFZQHz+HCI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:120a:b0:dbe:d0a9:2be8 with SMTP
 id s10-20020a056902120a00b00dbed0a92be8mr57048ybu.0.1707892654638; Tue, 13
 Feb 2024 22:37:34 -0800 (PST)
Date: Tue, 13 Feb 2024 22:37:08 -0800
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
Message-Id: <20240214063708.972376-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 6/6] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.43.0.687.g38aa6559b0-goog

