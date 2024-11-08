Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC0227BA7
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088205; cv=none; b=JfWuj7YBRoqNW9ou5bNV5FV8PcuAprb0P2evfJ0v+uhrX5BtfG1nUiU5dpGwB8MXlJnlw5rPlKdeNf/af6Cd9SOCMgX1THY2h+C9TmAkzs5AYXgB2Z0IkpIZzQgPW5WcMy1AK+JTZg1uBRADckJPUWTPUrmUDemXYiY+0qrFpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088205; c=relaxed/simple;
	bh=rmktKWgkJHRVy/ZdsAA0Vc65puJoSfAalv+s0diLDGY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=deaCHTWaA0zQM68YLhMakUfcBZ9F5AQs2Kthb4kb3zcXseNpOeWcPqH/rRO07fvmkqR/m2GkMceRauCwp8EBS8X+jTvwARFSUYuUVWs/28MNhNKqhmIy0LU/Pn/jYw3VlGQ9Ey9doonl5cnbnwNeQKkSk0kgKxaWEg04St/5oNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbg8TK2e; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbg8TK2e"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2971589916so3893729276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 09:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731088202; x=1731693002; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=hbg8TK2ekfbl7b7fvBanQiotkExyxCobWs2mC9Q8Q+Z1rqvs48ih7NA9VXbGcZUjCp
         BJxI9PdavZQtcdTVwosMLdTOlPAv+79BmzHrV8YHKPEvNHs1gzCQwd8DBnN3jE0YWmZV
         6/XCGLhln11CrZfeOA0dvMu79+krIUIPWec7fkvL0oXY/F1MDFT6Pomg+o1JlkFqc7Hk
         9L46e1ZajhVLTciJvSC0MFhZeK3LhrgBjrj9XsZHYZmWXYr5MWr9gkey8YNO2Pk9pzpw
         /jRuZKjj8z3obOmeY2oig1TrRernTbcVHjWbq14fdXdK8bVz2n0HCuJlrhqmnzOrW+zC
         /R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088202; x=1731693002;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=Fx7PVsFVcSZQPNw0OfELiHQnr0Cq0W3ByZLJnfuw7uY7x/CACE2hQx/bae/8pGGQ8U
         SgGPBVJhn8y40TfBdYAE25Fg3S8C8oDo2opvcX0jneVfAawE9R81sZOagcpUNTcMoHp6
         U1wxn/+pF7fJHL2fna+O7rK+mu1H7PuLTLamBydIEqV2Jpv+HIFpVyjaGXbrxbfD62Ls
         SPO7sWCJHfXYnCv1fGe7DhQwQsP44h1giVrgJUxH1zTCmMXvNLkzuelbi9xk18016Slh
         0cvT2AwJQTBVHAE++HpxvHVTIwie/LNJQWf8Jc/dWEKwaIN37ScGeXWN9hXK6YBWQqqA
         e4JA==
X-Forwarded-Encrypted: i=1; AJvYcCUN1zUO26sMtFBEvWG29FBk1Dt6LvbKUIns3BEVHfZP9Ypv2FP8Nyd9bXW+k3nQsRbNDDTWSDGErWMJTqFnqXae@vger.kernel.org
X-Gm-Message-State: AOJu0YwtymoSNQMC+xo8fLkZ/AgZz/zMid95NIybskccZh5/P5HOSGQo
	2KB1+9wuI79LxlxkwITaYg2tM0yOSly1k14e5SutAXojw1HkNkcQ+H5L/kxibgtwoGmbvQhPH+0
	sP9brJg==
X-Google-Smtp-Source: AGHT+IE6H8CgOpCqJig/S4Vgt0UKfIFpQ/8DXRr9lC+DKXJKn6W/WgeX/rl6HZtxD1DxaonovpxJKCR6AiXA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a5b:c09:0:b0:e30:cdd0:fc14 with SMTP id
 3f1490d57ef6-e337f8ed79emr2910276.9.1731088201981; Fri, 08 Nov 2024 09:50:01
 -0800 (PST)
Date: Fri,  8 Nov 2024 09:49:36 -0800
In-Reply-To: <20241108174936.262704-1-irogers@google.com>
Message-Id: <20241108174936.262704-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v7 7/7] perf docs: Document tool and hwmon events
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
2.47.0.277.g8800431eea-goog

