Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E84405
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Feb 2024 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535078; cv=none; b=JT6TKnrr5dyByGp/kXekkLRaEN5E5KGzNW0YGiePnBmx8/uSch/Q9NIufmwiL/LcOjVNuCqYeq6wMWv/Ovj4puujSrl8RPNuPIuhETS2Ljuqeh7V5dhlm9KNHIcJyzcEORXVVArn+Aqpvz/dLsFqd4Qgj5fThKVOWLNSxFYUKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535078; c=relaxed/simple;
	bh=YAb4FlNOlAfLeMVXc4h45YX0N5LZt0PmJHt3lr+GdM8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=nfd975ceoTXAqHN9lv0BOv906IhzVEgCPGHJ0KzlWGkDtgAtp6J/LoPZz2BhlB18MxJ5xOaDvdrNiU31za/ZReHtFa11hVRAIF4Fl3Jv2gErSavGrKBlhnjWrzl0GDqxNYVpCnn1goA1EID6saL7fJLB4rx9/VjjpSPsSKVUopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkkOBcXa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkkOBcXa"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so2388127276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 19:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707535076; x=1708139876; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cyyhzZNS8ki5ynML3KytcROjeKIHNvTXQuDKrxr/+s8=;
        b=rkkOBcXaCHIJwlM/NBMSaArU/iKtllJxFbcFW8N4r95XaP38e2jJsJCHl7sAsOyIXH
         zuyfXB3feNtzpwyBY1ulfjoA/O/LCXJPJwhElD6vqnf72UimHIric2MzuhE88zquvSrT
         s1kCJ3GL5+hp+Nw5pi9TtPOVyluCaC990S26E47D27gzhl2svLH6rc3dtpFPhPKRepRK
         GtJFsJvkn+x6565a9pNfcbzYCExEa1WlWyXDZoVesY0BOcdDRT+jSgaKvX2jgpM3WjyH
         GBoL2jPRjAp5uD5hjs7ov0CSe3gDJ5XGFM8Jzs9YsjOaPq1NexUCTGWDOHx6iRayDfes
         Dj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707535076; x=1708139876;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyyhzZNS8ki5ynML3KytcROjeKIHNvTXQuDKrxr/+s8=;
        b=l4/xI66O5gW2YfzKRFsyYzYY4ZkfkF7qFiFTfUwYmhggqxFKgSpA6E3dVVW3xYBa6o
         QuEI6ZLzMGBYQqZ2kRMyIVUFMg4d9TGi61Eyy8bJPuxexujdOQ5YQWp1NUgWGBC2T8iU
         LHihl8E5XWDYCECSLClokyfIvXTR8WQNB3OTwioYPlIamQ6YEOLcKCefF3Mq1IhoeeAP
         /jUsVsC2f+Wvta39UdSsqqIGdd2H/qvD7358N8Udi4UZso4e4dV+tOVKgmm0qCe/LUnk
         SCK4icSXpUrIiaD22u1vb+SK6HB4cJW9+Oi3EGlwVk1Pbi8UNh5A/th1yfAVlIZXSXUL
         CNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPa72RqiKtyY/673zqEjZPuY+OPYJALdIcYed6R8m2tpn8Ubvk5EHdKK89KIwvfXlnty6nTpLskZJTSrRO2KoeDID5NrrkMcy3JPvjP0Dp6Q==
X-Gm-Message-State: AOJu0Yy3kZD7giQANRKZ7p6DXniH66KyrWyedlINKRKii+ixmGOGzcmw
	gSLU13YO4SaCCV7R4raQHUIzWZd3QtxmIHHqM8FXy91jPK6BxGd3R2cOnyZS4TMK/z4mSW81Jx6
	T8GhqHw==
X-Google-Smtp-Source: AGHT+IF1SwDaOZUfH6p6f3vnVppObrWGYDyiolwE6lbi/prKPGdxMlVbinVXuYjFA0KQF2Caw7xd7oz5mCZc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1207:b0:dc6:dd76:34cc with SMTP
 id s7-20020a056902120700b00dc6dd7634ccmr31801ybu.1.1707535075759; Fri, 09 Feb
 2024 19:17:55 -0800 (PST)
Date: Fri,  9 Feb 2024 19:17:40 -0800
Message-Id: <20240210031746.4057262-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 0/6] maps memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

First 6 patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/

v3. Fix latent concurrent modification bug in maps__for_each_map.
v2. Fix NO_LIBUNWIND=1 build issue.

Ian Rogers (6):
  perf maps: Switch from rbtree to lazily sorted array for addresses
  perf maps: Get map before returning in maps__find
  perf maps: Get map before returning in maps__find_by_name
  perf maps: Get map before returning in maps__find_next_entry
  perf maps: Hide maps internals
  perf maps: Locking tidy up of nr_maps

 tools/perf/arch/x86/tests/dwarf-unwind.c |    1 +
 tools/perf/tests/maps.c                  |    3 +
 tools/perf/tests/thread-maps-share.c     |    8 +-
 tools/perf/tests/vmlinux-kallsyms.c      |   10 +-
 tools/perf/util/bpf-event.c              |    1 +
 tools/perf/util/callchain.c              |    2 +-
 tools/perf/util/event.c                  |    4 +-
 tools/perf/util/machine.c                |   34 +-
 tools/perf/util/map.c                    |    1 +
 tools/perf/util/maps.c                   | 1302 ++++++++++++++--------
 tools/perf/util/maps.h                   |   65 +-
 tools/perf/util/probe-event.c            |    1 +
 tools/perf/util/symbol-elf.c             |    4 +-
 tools/perf/util/symbol.c                 |   31 +-
 tools/perf/util/thread.c                 |    2 +-
 tools/perf/util/unwind-libdw.c           |    2 +-
 tools/perf/util/unwind-libunwind-local.c |    2 +-
 tools/perf/util/unwind-libunwind.c       |    7 +-
 18 files changed, 906 insertions(+), 574 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog

