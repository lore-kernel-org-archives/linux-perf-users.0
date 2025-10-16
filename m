Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908242580FF
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653366; cv=none; b=J4oISmPOm8ftOEA0+aS8ujujd3Ew8rM1/hF/3BEJp63oOWzsFA5pbuMD2dFy1aNiGvqV/eI4VsVaqJVSdlKqSwErvfenhDvhhvA77jwxpFTOh8aZBjFoN2yZK4SKGq6BVvhVVOYy6xyjqCh1M3ZS/H+QVoB+1PaZd2rhKkkXq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653366; c=relaxed/simple;
	bh=h/6P2i0cPvl1J3nh7FAXduqaTOGYo5LitTzF2sPHYB8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=p3+OoEhB0+RHDXduq3L41uqIYqOOzMJrwF7FrKgKHUJnOh9cXa8MDjMkZ/+fLfQxUDsqREjQwXNf1gc3v17kslJpkCiGg2G408zfrGZZXKON4LOjVdfjGa0e7gfTVfJK42PYZrMk7/G9chOUMPWMgRen/NKWm9et3psWC6KC4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/qLemFU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/qLemFU"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-782c219f163so20133807b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760653363; x=1761258163; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5ZqdTnxovh0hUBVUFIGbIIEhwvnBK/idgJz2iuPnZY=;
        b=W/qLemFUjMWMjZjcGG7VFeQ+Wx4NvFhHKjlIyRieFAtxdhPSttciO0iTWDYaKKzz5A
         Gis1WDxsxYBpDnoIYeWEQkipJOD0X9IUJ6b2eGUMu9pTy1eWLIjZ8gMCpnNxC85SxbBR
         4uXrxWsoLArgKqGisCSko7PaqEzHYPGAf/LZ8L2Kh+31B69efp6Ve6IwpbpgzZZ1Ife8
         UahrcAItaRuCl5gG8ozfhcFvjM3F8MD/jxrDfwDPbMUuCp/Pd2x8j/TlyqY92PJwIirX
         Fa2RynwWrng2J7IF90QqIfdPKL6YXcp7xoVqaL+wcEe81DwWwnnMuq2z8Tx8xa83Y6tr
         rmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653363; x=1761258163;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5ZqdTnxovh0hUBVUFIGbIIEhwvnBK/idgJz2iuPnZY=;
        b=Llun+qipUTEgStswvIUWMySBLZp7l/LILYG+zjjhnb+8MSWM2Cw1pCwxZ8rRzsS22l
         M73UKCSFyEitBfyUhfvITXSGgwT7wsgsdrLXGUBrKxP/uD4OyqI4KfDD7rEtONPZ8cWF
         YuQl+1D7GH5MC8DX4cyFM5PdXY8kXt0LGH163M+q+keDUtSluyOhljqdB8EhWqziZ3Ra
         aQSnN4RGiv6LTIEOEWBc07jWY1bfztmK5JVKFIHfPDXSMJ+rCnJXxBruBSvoSgEM6/P5
         +1EY7KgbN5+JYJ6/lQmeRG6BYRDI+sWnukIhg9jrUKAPE9lDMHwlLZKY+Mc9Zq+8Eszm
         Yn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQrWJdgiraXFA7yDdpj1oWY1I0ioXGBkFSWkz4oVsH74Y1Io/cWzcxkzURaQYOihGuVwd+QgufezCXJHtEy3Jb@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSrUsannvtEUyh4RJp6Qo9RXLvI9E4qWJRjcMpMgGWf8mblOw
	Z7QuVKjYKtTKzP9L+ubpLwLP5Vk2AvlM7mc/41I8h9e9FI6gEtxypNj4tfC/9JtTk/z8ZSPYsme
	51pNl5ZpOgA==
X-Google-Smtp-Source: AGHT+IH7rIhiWtNcNSddMDz4ZQ6msPTZBWWqVy1DCILgFpuRoFpqJwboZJJvtLR58rz3R/egD1Wu4uXQsidx
X-Received: from ywii19.prod.google.com ([2002:a05:690c:a053:b0:773:30c6:516b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:6183:b0:780:f506:b1cb
 with SMTP id 00721157ae682-7836d1c5a81mr15877807b3.16.1760653363607; Thu, 16
 Oct 2025 15:22:43 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:22:26 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016222228.2926870-1-irogers@google.com>
Subject: [PATCH v1 1/3] perf ilist: Don't display deprecated events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Unsupported legacy events are flagged as deprecated. Don't display
these events in ilist as they won't open and there are over 1,000
legacy cache events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index 9d6465c60df3..69005a88872e 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -439,6 +439,8 @@ class IListApp(App):
                 pmu_node = pmus.add(pmu_name)
                 try:
                     for event in sorted(pmu.events(), key=lambda x: x["name"]):
+                        if "deprecated" in event:
+                            continue
                         if "name" in event:
                             e = event["name"].lower()
                             if "alias" in event:
-- 
2.51.0.858.gf9c4a03a3a-goog

