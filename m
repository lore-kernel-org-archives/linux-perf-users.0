Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C381745
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112702; cv=none; b=oUOuKjfDXCndxsRq3MoItnqeyaALsPvDTseEWGT6+H/FgypviEDuOS071moAd+WWaNOghLCxuWze7kpCq/DeQdEIzbP4WcaND+/u2F/yixx2Z0KfCix7zYIARdC072HsaPRoSGOoXjh2fV6f0J0DekYagGA454F6lPFSRlnwzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112702; c=relaxed/simple;
	bh=rmktKWgkJHRVy/ZdsAA0Vc65puJoSfAalv+s0diLDGY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Xk65zetr6xs6CgNPSm6Wb9ZfF8u9xJXDIHVQfOYafi/WqO83pHEFE93eIwnb8DXJF0Kxm08NaN50wpzYkm7HXV7kaUYWEVh7ba6dIUASU4703Jdx+xCFD8RcSqs4wF093+swm8DcgfBoL1kcb0Z7AdpPlN/qrVoVTWNxx8nm8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAxdo2XH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAxdo2XH"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so4946684276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112699; x=1731717499; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=JAxdo2XHJkmVnZVU2H5VwO7b7u1regk0rH6zIPJ/I0U1gfpKypxEQkzdsfI47jcj0U
         tU0jS8+m/CTIP3z9vQRURr7cdusyNVcsQMSTXbr7ARjR7qnX6oBPdivKIvnilvm/X8V+
         HAp7NRlKQ2e9V+wPw1cWwzefQVLLD0E/DrN4psrqFO+1YfI7sp2Q+HqGrL+xe030y4Lo
         +SWAxSUkHbSheDj5QF5QbpbdimE8f6RY0qz+q8lC6o3qIItnPBPPbvX0EB4BX3GIZGeB
         iey+sp0csCQF1wDCc126gjCHjP9Ptw3+yWxeFII+cChCwX23fVOblU5oRP0p3iUE6hJW
         3iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112699; x=1731717499;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=WZvajSfcDx2BmPdOFnyL63PkwIq4Tlw3Sg69TJMalTRLG0zI2xA09OoHqMJxb5QbLw
         uEJulVG60qEDUTvFFgJydA4zAeqGxhRuwpeQnjjctKN4kfC2cdhFDp7YIxd7i6AvnMop
         G+QtDzcgzVckBDjdVtAvlgnU3CN1DWIAJ0ypYnHDoom2TeAU6Pyiz2rVIblrHh1CB39T
         Y1Pf8QFHnEaQu7xRUBw8aDO+3gl6/d61NlUirYXChq5YdXlSe1I5lNWmefDVlJw7+zaf
         3KtSf3D2x/XrvOGWN7pBddHgNGjgx3wb2RYjCSJftPKftbCWSuzixZKrOijgYx/iaMm/
         BbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHJG/BdWtlOqjSC0IKyNsh6gwT241+yJtVlUwzfITx2zkX1y1KQSFs/O1y3zqfuFUsQa2ugQvOfcfC1G2Y9Hcr@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/3IQhFS/ONgDEwhu1T8v6gSei3+JIjP2yTzD4GW8q2M3GmVq
	Jv/0mDSnENg7wU1JsmOJkIoQvedm0a9qQYOMP11GvA2gPFo2RrM6M/9LJQ04INvhLtPJHkWZ7+s
	NnORWgQ==
X-Google-Smtp-Source: AGHT+IEqdC8t660cmhTSYdvMHvoW2c5074g9eAsdYu18qhy97ttYT1601rGIQiMK2FsGOX+Uk2p9iv9SY39p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a5b:80a:0:b0:e30:dccd:9aaa with SMTP id
 3f1490d57ef6-e337f8c6c74mr13337276.6.1731112699203; Fri, 08 Nov 2024 16:38:19
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:37:59 -0800
In-Reply-To: <20241109003759.473460-1-irogers@google.com>
Message-Id: <20241109003759.473460-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003759.473460-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v9 7/7] perf docs: Document tool and hwmon events
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

