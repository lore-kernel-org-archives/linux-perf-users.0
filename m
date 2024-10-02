Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63D84D0E
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839256; cv=none; b=vCztSVHDoMGpibu6n0/7xbWD38qzVcOPxuMgoovUTr0Gzz+KQjVinNMK3ow23zSnNws3A6X7Gmknz4HmNeiAlcEiVe3bV2PBRs8ns7p3SLfnFozKQH56mdaGlREbmMwcOtmfUsEFH1jZQ/yPj2vKPX+4xTW6AZxJLkfN6ecoVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839256; c=relaxed/simple;
	bh=fMXDe6FzbtYxqcCD7arXivj4L02uApdRNk9Y9SSBnoc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=S5IxQqJNXOuAjx27jHsd7pmh6W2MuUk7g32gPaQ9BYRdPmbCTzAFFABR8sEwXwWpgQb2iVIwcRVjAil1zVJwASbvYahiZ/Ah6wbNSINW5bpYNm3AdZXebKieuHqPnqn/Own4FT0hiQI+pIRjQIILzS6pkbbZTlVb8ewGoxbe7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfNSxh97; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfNSxh97"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6db791c42e3so96818857b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 20:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839254; x=1728444054; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNJbO3ECVgjqRfVy41pUI42bkQNVjMupI2VGD0uB/As=;
        b=FfNSxh97dI38VfoDUvqOtlWME9n/i2k8Bcov/5B6Bbw07crr4YXhkZJFV1u2cUI9fF
         8wWuDs6RNa4R5B/5SK6VZXi04uuETQX5sQt6Vj6IQkSlzmdZAUHPK50K2XsOOI/mYfUH
         1J9V8xyKJLvs4A193+TIZt+pMBD8dmS5rzye+AxZkt5lrS4Kon0FabCUQQbI+xo056Zb
         QyKgt+RMcbO0qvUWqhMFJBuCls196IeTdZ0xKEG9dBNyTbWLQ8PmmgmGWo4nB9JqCm2S
         2OC4sFLKnqrMYQoOgu00JR0Dg1yHA0g7TXUWYiKQg5bvzOXGn6avmMqb29gk64iBdcBA
         Y47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839254; x=1728444054;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNJbO3ECVgjqRfVy41pUI42bkQNVjMupI2VGD0uB/As=;
        b=e7XV4dFuqTr1X91OeNDFLRm+gmYVmsShLsQxcx77dSFlXR7ZX+PLoYH/EIaf2oMV8W
         D6n9Qx/Fwfj4GVC7bmSGvCkFQf+yfbaXk0GBbQtq0aSSvWJ/6iZB0iOR/t12SIk0MBbr
         jt0EAqgB7WckE1aDVk2PeFrV6L7jvl4mOz5uFx/Ys+Gban4sXX+frafQYtKPP+mRRRdt
         GFj90Tmnvae5LoRNX+PiMzL5kjPhGwpe9yEzG9oXkamIyjblwUtFQodyjT/J+qE2Ehjc
         o14xcDaU+1joDNeEqwz1yFmjniHAGsLUWFGFU7D9ufzl/516lEC0wYKCzDFXrcBrm3MX
         uLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVimp5u6ZJ8S+V+KGhGhTMf8bfDLzChwroJnw1Mi/DUjN1IwXatpBp04oR9MAUqPlfJfx4Cnu52D2Hs+rk0Tdgn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgw18aDPZC1mt+Z+gUZQ8ZWCoCzrtpYNowJcoV6Q68OlvmxGBL
	IIfOrqSGspEfJYLMhtWE4HAHFxdgxjKxDRn+qQ7Wu+4tlVwEI5lrIuXKjtH9IPWhpyBa6sk3uDq
	Cmpe4hw==
X-Google-Smtp-Source: AGHT+IGyarEeuwdMvust1yq5sAQKvw4va1UKOfQvuvp37bcj1JGnGgp0h/YfXIu9yL4w1PHiMsTtvB//he04
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a25:6992:0:b0:e17:8e73:866c with SMTP id
 3f1490d57ef6-e2638443a7amr7352276.10.1727839253957; Tue, 01 Oct 2024 20:20:53
 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:16 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 13/13] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dea005410ec0..7e3cd6c5e35d 100644
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
2.46.1.824.gd892dcdcdd-goog

