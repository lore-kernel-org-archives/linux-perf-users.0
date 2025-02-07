Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CA19CD13
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970698; cv=none; b=sEbHbNjqot43J22WNxZ/Z35FL6P8PNYcH60Gm47VAJzF6b40FJkl8xDIrKY2j1R/tG5J9I2OpGsQuHKHGCf+o77sGrQ+AwmXRJ4KLSueEK/TU+Tl2zth3UoRyhf8knWAyid7DCYX7NqumqSjIj8sWsUSCuVu/72YiUiDabXI6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970698; c=relaxed/simple;
	bh=Y4du//20sWWnDtEqhtLu4H5rTLO7os6JJCnz8U6UnWg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=mrGuSdV2BYVx6KSZ9K9VEsPSu7P3DSmz7ItjwyNShJXxRJ5QpgwkM1Dv/gUpHLdIH1wEK7rpalVEhzKrXS7n3K857vCIkwffJN4VnVJTqaDlD21ZLCi9eiWWe0DC9jd3MpFFLyN+px0QMo+gtwzsbZWkDqFVZ+hlm1M9kkUOU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Lqg6lvQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Lqg6lvQ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e582bfcada6so3760983276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 15:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738970696; x=1739575496; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G28Pgc21JIFMYyeRzXdZsM86R0qu8I3HZsqE2BSuMCs=;
        b=0Lqg6lvQqb4uFLCWT9N3FBVm6uLLB/47BmOJ86jjS+yAXeiC/+zzTvr7hdBMtpGe4N
         l3Pofj8G9n0N3O7Jk+YhniM41q1j0kNJS6JUcGCU5PNx9NDNA2UFXlJZb5t4CYtkVTzo
         lLW1MKU8l82kyP8AZ95catEhjbUsyZUrWVxitGRuo19LwvXstfw++SXN4jAbM3l70Z6k
         RI5M6jI19IG+4+0909pLkY/n9hGja0DO2TfLarZBj8cBxyeBTyoK6ql4W6fCxLGapNf8
         nn13HOfWc4Tp/J6vpQ8TnRBRKUCZFB9RtwlGGoAfkoSULj+ivaujjZdrpMjLK2FCpZzc
         Re+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970696; x=1739575496;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G28Pgc21JIFMYyeRzXdZsM86R0qu8I3HZsqE2BSuMCs=;
        b=ZRO5u5wyQd1Dy7uFZ1bYMbA5on2iDpG3Rnu+w7ObFpAepII8M9rXutA36+/3j/WX8A
         Kgif3CMMsAImB+0Cra9TNLvD20fEizM/6H0bxIOdYy4UhJ4XxaD3k9FCSPomeSz8UEZH
         B+/XigRllwZvDBgHJwpkBymuwNcblaikc3TAgaHwt+8Hwm9suhR24BgMUtOd7PXt/yKJ
         cqHx+lk7mDCpJUoXikGQoNKzq1bpzqqhBpN54O3d1RxcUqua46NNYlbNtVapH5E8NvT8
         WQ0Kl04UkKWtpCz8ze++Am4lQcCcCCKGug4XKulF5bftLIkZb+U/lZl0dNGG0jfEkWY1
         xQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrhJkt/E7hoecOyP4JVANUvL4yPT6As7GonPCwUz+3rIaoKXWuF0Dh4wLL67ngf0WqNh86I03oy5nSS1cB1Sup@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdUXM91lNSrppdsNC6G2R3IUemdgeWf+thooXtbK+2InAol4P
	1iwbC3jn2qOD4SSk0shF83UNAv32a+UGwvH6hzCspDXHgMLhjZlmo011UGgYR9XljRJpfwZ6GHZ
	+dwbo/A==
X-Google-Smtp-Source: AGHT+IGQ7ytB+CeIoSBw5nJB/CMn4ZCIJBTrHqdV6RL2DAfaOJvDAGtLOPdzYmsgC40yOlT/lRg+xJbNpzt/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a25:8752:0:b0:e5a:cbb9:4d4a with SMTP id
 3f1490d57ef6-e5b4615d78bmr37062276.2.1738970696103; Fri, 07 Feb 2025 15:24:56
 -0800 (PST)
Date: Fri,  7 Feb 2025 15:24:41 -0800
Message-Id: <20250207232452.994822-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v2 0/7] Add io_dir to avoid memory overhead from opendir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>, 
	Jesper Juhl <jesperjuhl76@gmail.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb

v2: Remove the feature test and always use a perf supplied getdents64
    to workaround an Alpine Linux issue in v1:
    https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.co=
m/
    As suggested by Krzysztof =C5=81opatowski
    <krzysztof.m.lopatowski@gmail.com> who also pointed to the perf
    trace performance improvements in start-up time eliminating stat
    calls can achieve:
    https://lore.kernel.org/lkml/20250206113314.335376-2-krzysztof.m.lopato=
wski@gmail.com/
    Convert parse-events and hwmon_pmu to use io_dir.
v1: This was previously part of the memory saving change set:
    https://lore.kernel.org/lkml/20231127220902.1315692-1-irogers@google.co=
m/
    It is separated here and a feature check and syscall workaround
    for missing getdents64 added.

Ian Rogers (7):
  tools lib api: Add io_dir an allocation free readdir alternative
  perf maps: Switch modules tree walk to io_dir__readdir
  perf pmu: Switch to io_dir__readdir
  perf header: Switch mem topology to io_dir__readdir
  perf events: Remove scandir in thread synthesis
  perf parse-events: Switch tracepoints to io_dir__readdir
  perf hwmon_pmu: Switch event discovery to io_dir__readdir

 tools/lib/api/Makefile             |  2 +-
 tools/lib/api/io_dir.h             | 91 ++++++++++++++++++++++++++++++
 tools/perf/util/header.c           | 31 +++++-----
 tools/perf/util/hwmon_pmu.c        | 42 ++++++--------
 tools/perf/util/machine.c          | 19 +++----
 tools/perf/util/parse-events.c     | 32 ++++++-----
 tools/perf/util/pmu.c              | 46 +++++++--------
 tools/perf/util/pmus.c             | 30 ++++------
 tools/perf/util/synthetic-events.c | 22 ++++----
 9 files changed, 194 insertions(+), 121 deletions(-)
 create mode 100644 tools/lib/api/io_dir.h

--=20
2.48.1.502.g6dc24dfdaf-goog

