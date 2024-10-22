Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C31CB316
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620400; cv=none; b=RWJ4famc5PWEuwbXyu/vfd+en+2m4C0Gg05jaueTDg1JnvWlT+UXqZHVvL/r6gkZmDZPpwrDD7OErmHmVfgIAS8S+B/8xJrRHBY4UhMihfjfu2dt5UKk8s047UcQqVYVFCZWfSwnsPemzKeO4BlI4KvqEfRibusDVl02PjlIKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620400; c=relaxed/simple;
	bh=raAc7l7+e6idjT0jvMkbeIhgwYBlvolRxU41kRdYBDY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rQP5CQYwIA/f4Hf/BOhV3MX5IiTod/0IVJrjnwtQ7SR9ftmCsng5Lm0OpuS5XLx29hylFuRDja9mN+JrRd/Jypf0ORtJNx/rkeHXJs7513s/q+hlLuxD4YBexjg4aBFM7EQqwvV/JUYuurZUpRkSHMgu4Es4QQSsWNkADI1MWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlP1q6VT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlP1q6VT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso106071287b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729620398; x=1730225198; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZE4khg3hVWn747RG5rCs/fiqdzgdZsOYLI35TpLPnqU=;
        b=vlP1q6VTX1uOJ1p2NfIoBJD5jScMfTbWb4y9YJzDHhy7FwDuYWPvC2LQFnIkFmtoZD
         YdnVxAOjQuPlPakj1O6nX9gXUSWbfGLcaVGzuQ/KecaGnKf8SVe3nTsIzF9kdwEpmSnT
         O9YSgK9KjGZlHHoZKoB/45M+t/vSMfHqc1YqQXjhCQEkU2NWUnDEfS3gbQ8FG3L8Z4pz
         3NTJ743l7xL18VUrzA9WRsVFJrImDcT+/CThB9aVfaFU9DZLbn7/iaO3nnVejfRKPHrx
         17CwNru3t02YKr4DZkOb1ajs/ErgjdrobDeFr0aW4Yk4D+q7xeUcbp5V30WCnTRax0Kk
         559g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620398; x=1730225198;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE4khg3hVWn747RG5rCs/fiqdzgdZsOYLI35TpLPnqU=;
        b=IfPsyWquXaJdssqFUqOzN/cpBtRwXWYzBudTd4bOKviSzLmrjQlHjP2hp353wG0XGL
         1U2HVJwoPeoY0+NVbamiFvGUX2+MtdkF+KYcw3+6D/KlrsXMjx4kf6vgoo2F3qAUmf3M
         jBJfDFhmlQaY942CKnFH81J4itZRSpsZg48Vu1FcEMMfVAAVQsxjwyg1ZRRcBwQOFcrj
         d/6KtL6WNYehUoWOnzA9ycjBssYEniJXnQxuwiVhOLaJQ/47+xDZhPuIna9ovkObLajS
         fF/iO1bP/IfVJrSteqGbX8WJHEi8ejcMOeCT4KY1o+e4HLtr5JKEAoR63LcRB9hJi2kz
         zrqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQWEzTzMENZWvu0/znWXUVQKBt8w5PkXM1+ulrtcpoby9u7Jo1SPVehjZyOBJnRp5r7VfaI6OS+TtfnORl0bCY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83OubI6J3oPOycea56H1JtEEE3ikkd5n01+oixVXKJ3UPjdkm
	Xbd/xlJ6mOWfMfBzL/HMMzr4tKmZfHGtUcjRwfgr1ZGNQn7Ke/RTBcEJJCxE+2OMlDTHDn3HlSY
	tf7J28Q==
X-Google-Smtp-Source: AGHT+IFY42xpVIqwy/PLKWqYkV7Dh3ULqLd+brSMo2MMREjD/kH2QEjNWxekmpVPCZaO/0nWYg8m6558YIAF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:6681:b0:62c:f976:a763 with SMTP
 id 00721157ae682-6e5bf61b030mr5277577b3.1.1729620398304; Tue, 22 Oct 2024
 11:06:38 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:06:23 -0700
In-Reply-To: <20241022180623.463131-1-irogers@google.com>
Message-Id: <20241022180623.463131-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022180623.463131-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v6 5/5] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14621f39b375..d0c65fad419a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.47.0.163.g1226f6d8fa-goog

