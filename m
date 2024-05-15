Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489E3219F
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801782; cv=none; b=CDnaaOKpnbEhuJVoc/Z+8FRz4JIS9ZAJdBitr5Q8abP0aMEzXvQmhPmN75AEHOxwQIeZoLqL1/y6jcFz3R9hYvAtzMnKzXpJ0Yyrnwc1c7pfBaTaCQwLoWpjp4M/s+Ad9MOOyNem/5IyW5im7kArmt676vd2mvinN2roYLCE2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801782; c=relaxed/simple;
	bh=rNcKdHemTqXp/jWokR6p4S2Gh19u1eDcI/Wkq5LI0TA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VUO46BiON6WG3iqamjeyVvwGc7xEfJ6j9ZYD9qNPReHVFFwzjjO/aj2AZ93PHLzn61ze+GmuJpQakt9HTZpKEYiBR5r8nlsOWhx0UdB0veEFflckAHujC2+Nv+/KahRCb1a9S2xMqk4C0eWo59GTee5o0IIzw0YemJquyqvomyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ymxpliUj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ymxpliUj"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627751b5411so10933167b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715801780; x=1716406580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8mo40hi9HkXQPI0hPSG3MjEbNa63l8uDo/3AAaoaXZs=;
        b=ymxpliUjau7tW/aFRnwLgbrFs8PjXmfpKYZDfIeE0ucSmv1YpIaaXAiL1kNxao/hag
         NNZfL3pQ8KP8DpGDiF0yChRSHXMVcBBN6iwTdA6YJjHIiJvF7eR3UD5IDUY9v1Ld5H+9
         EuNCBQz3xuKuOtBBBaoECw5Zcf9a6CEBH+ZJQmWX5hYGaW5ER684OQ9BZni3/d7WPzOb
         gY/u2DsMWqhAcfFu6Lt+MFM9ilealcz2kw1b91tJau04V2ty+NOE6At5XeVKcXnB6R1o
         OCywm1TjzVdJOo+fw47vcJ4r0aEMbHuX53hX2vicVRaYY1P8MSpFG+k2vMq4TaN21Yw+
         T/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801780; x=1716406580;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mo40hi9HkXQPI0hPSG3MjEbNa63l8uDo/3AAaoaXZs=;
        b=qElSpYhbIjTd1tSh01Ci+HydtVCRJldnWqZINl1bUkTADPfKDPIZOFO2alRD96KLbt
         urB26hZDYUqTh7ivCRz56bAvkrms7xgPUX8nyFroaZTv9X0z53Onrtn01HLJAxWEmWzZ
         2A5Kd/oodeyNlkfEbBVc9CkQh/ujKVs8hJXyBupf4xfMN/9y5aZP8yb9fg0OQRi9vCA7
         i4wlpqMJ4KVeD0cMRenajH+FTqoO1Wa5n18UlD+qNLUjDSBJmGIGZmOa9JYKxv27/CxK
         PsAOv+24CIkNZxJb98/MZFDHiD9Cf81XVTELw23ndYnAvMP2pdZ3SBXAjHNKjRBOPl2E
         u9Jg==
X-Gm-Message-State: AOJu0Yw52u5Wq0YuHUoRAG+ly48DaX3XwFZNKM0X37GZMJ1/UOQiaAn3
	V7pi1hUvrXrsX7mdYhE8CCFHb1HE/YZzNRK+RolEq8NZl9YZq6BZB5wlClEHfSpjAoEY3uoxMrg
	0
X-Google-Smtp-Source: AGHT+IH0DGxH7FiS9IKB53lZ/iJkOvC68dQQh6DPRikcqpIYM9vqeJtrXJMVdVoglnHDpQsEeY8eJHhrmho=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6e4e:954d:1e49:f87c])
 (user=yabinc job=sendgmr) by 2002:a05:690c:6f8c:b0:61b:ea12:d0b with SMTP id
 00721157ae682-622aff85f0cmr46339907b3.2.1715801779694; Wed, 15 May 2024
 12:36:19 -0700 (PDT)
Date: Wed, 15 May 2024 12:36:06 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515193610.2350456-1-yabinc@google.com>
Subject: [PATCH v5 0/3] perf/core: Check sample_type in sample data saving
 helper functions
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

We use helper functions to save raw data, callchain and branch stack in
perf_sample_data. These functions update perf_sample_data->dyn_size without
checking event->attr.sample_type, which may result in unused space
allocated in sample records. To prevent this from happening, this patchset
enforces checking sample_type of an event in these helper functions.

Thanks,
Yabin


Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Changes since v2:
 - Move sample_type check into perf_sample_save_raw_data().
 - (New patch) Move sample_type check into perf_sample_save_callchain().
 - (New patch) Move sample_type check into perf_sample_save_brstack().

Changes since v3:
 - Fix -Werror=implicit-function-declaration by moving has_branch_stack().

Changes since v4:
 - Give a warning if data->sample_flags is already set when calling the
   helper functions.

Original commit message from v1:
  perf/core: Trim dyn_size if raw data is absent

Original commit message from v2/v3:
  perf/core: Save raw sample data conditionally based on sample type


Yabin Cui (3):
  perf/core: Save raw sample data conditionally based on sample type
  perf/core: Check sample_type in perf_sample_save_callchain
  perf/core: Check sample_type in perf_sample_save_brstack

 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/core.c         |  3 +--
 arch/x86/events/amd/ibs.c          |  5 ++---
 arch/x86/events/core.c             |  3 +--
 arch/x86/events/intel/ds.c         |  9 +++-----
 include/linux/perf_event.h         | 26 +++++++++++++++++-----
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 10 files changed, 55 insertions(+), 43 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

