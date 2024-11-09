Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B10770FD
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112459; cv=none; b=iIlHWNGMGei10LjjE/gZ8Tf4RbxChaHBjwbfFASP+ehNZteWvmmHW2XFXzmjJpkiB4aviBMZUtfulFyfF3MXHOmeQHE01xfzh0FapIiU13NaQtADsO/2ytyjKNpmzfts2EGHsE/pLoTXNHuBdytQxZeN3igfNdNegyTC+L2iyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112459; c=relaxed/simple;
	bh=rmktKWgkJHRVy/ZdsAA0Vc65puJoSfAalv+s0diLDGY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OZobQqOAuS5RrM3k4wby6WBXDE0gOLBhG2GzICnftAqOQx5MRc2Nl/iwn4ncJ6KXdfsBxPraZsTYHbzRYV6yoEHoTzobmLLhzjElngabM39AimfKPpJlOSRQ2x+dvSkJ/SB4yuqrKaTNRM9Mg1ezV6NU//FN61xeR92Qf/fEMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7tVz3ya; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7tVz3ya"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e297a366304so4416253276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112456; x=1731717256; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=f7tVz3yare1UoZaHoZBUgaD1sK1DSYsitmHawjYBmR9TA9WRztxdWari9gJpNq6ayo
         swQM/7KJngsn+4j0g0n57OOSpgxZbE3Q0arof9dMc2yVNVOIMxE+0Chrnl07ne6O67tu
         TQcPooOiz47LFajlsPcSmXIQ+RAIwiBCljoJ3+2n6iz+GyZy7g6zddlWFCRxFu4pebxI
         ilmBWAN4uAgeRbsi3YJmH5kJ/xYtVE8yDdn7G1+a5liznZxiinRcG+QwgwQWxtC4MkyH
         U1H5b2NBstbJk4cb56XGak5u7/Sp9DxgYX7aQFlSaHBsO/0cxW/EezGHpkFO/hJ0mZoJ
         qgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112456; x=1731717256;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=TXhCchWQ/CrMMnU56zypfn/IaRFfqvdMwcigB0ejh4NyND/k5eotqqGkH/pCVSVGRO
         aUOuzt5cJHe9XeOtsdMkbCKvs/ryqXt45/rTPkHwGJG/7yy8XAplZ76iOxKdVV1EarJk
         S/zboxIO81FRQtyh9ZebaZUCb66kKJp3xf3jt18ljNwQI57jvWjGwq5XjdSmRH3pPPkR
         q7GudjWxeDtsAGaqqvlhDS2VNz1fFU1oWa+ZJ8XUyKYBsOuKDryWh/gpJ91QTLhdlGI9
         11707SXjYwfJSG3SX+fO+8sbQQAfh9mZypBQNoQJoR6BARYvlKaMop6HDBPBWDZ3i8OY
         gFhg==
X-Forwarded-Encrypted: i=1; AJvYcCWGij1Aw2pQ5rbSqfw1vIBwdRDyoJeSkbb0VrNRmTPc+mJICf5LAPV+btWOvYTol7o+UslCYGvXjy39Ll+Qvnd5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2w1o2yVEXVhnxhakDD7Q8PfKQbbA4eJs5ye+k8vkAE6NvPxqT
	tuOgIaJCkTKa9gOV3CdGXr+ZKybpvuEXdxAQSNyXl12w0xZ6oUemmnmEThH5jq91Yv5g9aeKPI7
	nvxM+uA==
X-Google-Smtp-Source: AGHT+IEAozEkum9vfb7cCfMy5i2k3+qV284laW+Ph1hIOrUoIrhhbk39KCwWH20rVje+aP2dq/6XwEnknlkA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:bfc5:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e337f8c911dmr10786276.5.1731112456718; Fri, 08 Nov 2024 16:34:16
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:33:58 -0800
In-Reply-To: <20241109003358.461437-1-irogers@google.com>
Message-Id: <20241109003358.461437-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003358.461437-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v8 7/7] perf docs: Document tool and hwmon events
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

