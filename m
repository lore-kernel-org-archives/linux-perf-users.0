Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C531B285
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300684; cv=none; b=a88AogUCvK6+g99JBdOU1iYprTkAUIgWKoti9NavrbEO/a8PwBWWrqly+VpntFqpvYfdbV7cz2CKzHTaXmzihBB0xlJpFPwCiXkIlDgRXbwctc8bCtZct50kjl2cbQJQqh2E51baT/tpOlHwYK6Xmt4zeLZaKk0ErcRTt+eVUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300684; c=relaxed/simple;
	bh=EavCetVSCgCq8a1RaVsXoOaflK2PYWCs6cIGsY45SPs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KzvhNSwVtNTl2D+nw6ra87Efu1jy/N5+oDT2FbbBUhw8uWHHmw6cX4xd3gCI5mZjRWg7+1VtzJfMDDUDe8ZagrXKPN7EHFAXfbfhlIj0QP3wCftm6uurd0XawBV8+he6kUcDAV3LwCCbjKnxI53mkpDghR9MW/DMfr89wqR2WHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6oP6eX2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6oP6eX2"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61c9e368833so26197457b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300681; x=1715905481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eqm/BqIluFQHvpRuckwNPKwG5hWXwTVWnnYkmrJGUM=;
        b=Q6oP6eX2EIg9SP1I0c1rti1vPfhT1ZObGGUb1pfzKVkMS39ZugHbj+zCZzGU2pqKLp
         QIDQo3ODwrvmjaxT9hftZeLGvA+qfWYTnvFNzYTXmCKqe817XbG/5HcM1VswKYQin8R5
         qrmHmouRUiGyz6g3jIq0IpsKMidRf6i8ShKx+fIpVdqz0AoqnfdaN2jCNqgssErcjuUp
         ui8pas8lprR+rKq8F2xlFjy5TLVeYLj3zumCNz8JWN39TjoPuya2eIFXE9ZIseDwTSXv
         7TY/sCogBvsKnQ54qEVVHhbDlr5cejO8CQ5/A/AkrOyEpkWTU4139dCBPvv2OmBJtRJ4
         QpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300681; x=1715905481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eqm/BqIluFQHvpRuckwNPKwG5hWXwTVWnnYkmrJGUM=;
        b=bl/7UL1gq7g6C+8dE2WWD/oBL/KRCFfmtsfl2zN8SY9JnPzEwD0qQGx0+DtNZ/mcFC
         dDL/7l+AXxjQBf3TpeMpI63r8JO1E2WJB5lyUCko3yI35CmQls5RWpUPnbZ4hBC019Nn
         CB1vPS5ypffrisNQ1gd5ucwkHW30Iq8qe8v/dfLvTOLW/162Upul4mbfVX8Mp0jLJUGE
         jRpKOmWXib0g5Qlt6psQ6sWqDy76WhKk9qWe9mVPkFU9O6BJLSy1Gsz10KWlgGcwtmLr
         RjzUm/2G2WzSsjtl0fzyZR9EBsRcam4DZwvwEP4dvS9LkrnhjX+q9ZXRi6tcdYIL1pzW
         z/wQ==
X-Gm-Message-State: AOJu0YziOr445ikVUzHiyRAabWP9VxuQ5QwrpeR3zRm0kR3duUaKRxte
	gw9It6J6L0RXuUw1mZR6zPZZkcWx3Q0uNVMag6jom+NNYxcq+uzu7L4dxQg4MmLGZ6CVJNKTi0B
	d
X-Google-Smtp-Source: AGHT+IFLiYM8VZwRIj/wP+/duC96Rdf7O6hJav827B2VR01oQrpB/ASkm4qSwdbPKc+j1GRgZ4Sunld9v+0=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr295036276.9.1715300680883; Thu, 09 May 2024
 17:24:40 -0700 (PDT)
Date: Thu,  9 May 2024 17:24:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510002424.1277314-1-yabinc@google.com>
Subject: [PATCH v3 0/3] perf:core: Save raw sample data
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Changes since v2:
 - Move sample_type check into perf_sample_save_raw_data().
 - (New patch) Move sample_type check into perf_sample_save_callchain().
 - (New patch) Move sample_type check into perf_sample_save_brstack().

Original commit message from v1:
perf/core: Trim dyn_size if raw data is absent

Yabin Cui (3):
  perf/core: Save raw sample data conditionally based on sample type
  perf: core: Check sample_type in perf_sample_save_callchain
  perf: core: Check sample_type in perf_sample_save_brstack

 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/core.c         |  3 +--
 arch/x86/events/amd/ibs.c          |  5 ++---
 arch/x86/events/core.c             |  3 +--
 arch/x86/events/intel/ds.c         |  9 +++-----
 include/linux/perf_event.h         | 10 +++++++++
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 10 files changed, 44 insertions(+), 38 deletions(-)

-- 
2.45.0.118.g7fe29c98d7-goog

