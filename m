Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B3101C4
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Apr 2024 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886651; cv=none; b=dlLLXFZgOMkYNSy4fXOEWrd3lc2bPjFidv0LmHnbPztw8nhhlqSnQVtJKhsPd53IRiFPyEANbvP5B0t8pac2hD7wq7CbKXiMDuHFSEubnLe6+0fjGxotkITcZlb+ya5j75ba2cp1KmRk5JQwy+mfrWm2DtGJc6YT7/xoVhDBuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886651; c=relaxed/simple;
	bh=7YouWyZuxbSYzHxqPUnW+aY1UMlIJgGnhI+PHUoOFhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1BQHX8LOF0d2tTr5KCYHTQJ16I8XtTElR2BzRAWdwPiJ08+kUKe2eS5kgWLHy4VM0hJLt2puD1Brsy+BRUd23tT21keSCQM+/hyML3mZxBFKslEPYSawUvcr+bS+6rMT04bj2UHpWX4MTOCX/EUzzRcmXdBdfYV81RVvCA5caA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=aU0bVvpI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="aU0bVvpI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d62c1e82bso26438885a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 18:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886649; x=1713491449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR+aRAW+xEUckMtcdjKW/EEXnX6Dbx8rKcxaN3dNqzg=;
        b=aU0bVvpItdjjGy0Uh4y25anjArKIOtlIy5bEQk0mhmXbgUtnAoxQU+EWL0JLXBUsGE
         PaFzOpaJzH8GVLLDtvVTKCjsLTFLU3B0AAlawSh4HGgxhag7TfwZH/R+MYRm7QUwbMAG
         w8FRBHIep8Bt+j5TOyytwhtljABL69vAvnkrXANE7rldNPtRV4s9KqL/BVLLdaS0EEhU
         S7NYM1+pr3opDH0IQanKJieTjzymm+1VP+TTtawBfPlvipoLVVtG8Lq+0a4+iHZQoxji
         bYan7dULV/jISLCvZvrhf5LY4IUpVNt3UDYdMtkiPY1qHjhOBcRJAb9+2KRRgreFRl9R
         P3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886649; x=1713491449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IR+aRAW+xEUckMtcdjKW/EEXnX6Dbx8rKcxaN3dNqzg=;
        b=w95FSFknbS8SG+59WdjHCMZm4SlQO3tIErBL4Xvf966JEDOcZ/pIEUdByj/RYWl6M2
         19yUZjEmBMyI+LgcJTCr7JUt59TxLzBKcZ/dylgzKf2kpGMNZk4pneRE3tRfFrCxBNQc
         KRJRLX+VBx7frzgsJQ6wN8VG5Ax0iHf8c/4AHKIdTBTFVSuM5o9pUXUW8Ph9sKqRXK7/
         uwShuehBlONlhM+OktRyuJhrOOkPx4c+iyryit3Hf713TrQmisObWnVvOExbmT40Qc3k
         9Y/+o30Yb5sPOpUQs66id3nW947naSQpbpuftwthaq75xu3KqlCyw7uUkOkvCSi9XSJ3
         wxVA==
X-Forwarded-Encrypted: i=1; AJvYcCW9wd/RqAlyq4XWA8+0OlIw8KAsvbV5Sqnib0e4iiPh5eSjyGucZna5K0LryAOLYbKdaRRooGHHgx89koONnQ8WI8zrIAIQmRHU5qWujyFT5A==
X-Gm-Message-State: AOJu0YwsR6sMqbiBj5dOmTSIAXjQzGX+15GMAF9W/zRCRgkR/HxOdeP5
	LZQNx8MPBKjhyVygO3KSjonvV8QLKH8jcKAZAA+IvcNtnOVNMqfrUj3yjMzLTg==
X-Google-Smtp-Source: AGHT+IHD5DOmOr2nUz59Bfple5VcMmCJtdiKzwwn2KQ/kHy7BLf5evZIyHYa8ySlQOOQSWDiJjefKQ==
X-Received: by 2002:a05:620a:1983:b0:78d:6339:b943 with SMTP id bm3-20020a05620a198300b0078d6339b943mr1698615qkb.20.1712886649123;
        Thu, 11 Apr 2024 18:50:49 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:50:48 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 2/7] perf/bpf: Create bpf_overflow_handler() stub for !CONFIG_BPF_SYSCALL
Date: Thu, 11 Apr 2024 18:50:14 -0700
Message-Id: <20240412015019.7060-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412015019.7060-1-khuey@kylehuey.com>
References: <20240412015019.7060-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow __perf_event_overflow() (which is independent of
CONFIG_BPF_SYSCALL) to call bpf_overflow_handler().

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ee025125a681..a7c2a739a27c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9624,6 +9624,12 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	bpf_prog_put(prog);
 }
 #else
+static void bpf_overflow_handler(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 struct pt_regs *regs)
+{
+}
+
 static int perf_event_set_bpf_handler(struct perf_event *event,
 				      struct bpf_prog *prog,
 				      u64 bpf_cookie)
-- 
2.34.1

