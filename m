Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0F341651
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Sep 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837075; cv=none; b=YQa8P5Rr0h+mEpwmPlRP0N9Dn1wvTyGLV+4Z3nM3NdExpWiL/SJnH5BW8n6cu7ZiyLb3mqFtSI8MVJw663sZM5DWfEJznoxBlUtPQKHByJX2KqIHVjxMrWz8wW2yKi1/Dp9WWEkSjGRdx+J17jKiEtVv1ky+xDylKhZ89GfQNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837075; c=relaxed/simple;
	bh=1pc5MJq/DOmEEO9qJbY5qbt8bUEssrESLh7t0NAJFuE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=OTGjYCEYaYP1aq2FfeQ5pMahPFPeeEMtN1tICIuBVWG9TePLv8VcH4qeesoxkkP94BTo1yW0SxiZmBNGBxz/23g59FixrHZwUXRBHDKgKWwcWZe4YNvQexZQ+Tt0pWlJ/uRoD7QaOEkwEYZ5J621k5C/io2QubFet9lCvpdPrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8P1hzXN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8P1hzXN"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47173afd90so7750320a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Sep 2025 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756837073; x=1757441873; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYRDGWUEa7FzMyNE6ErUXI1q4yIWe6EsYB+9O3a0jhc=;
        b=p8P1hzXNgyH5VaZ3q/Xa05sDfTIBRJ8gsBz5P3YKjWRtH/9NVktKVNhh86+WfJKAv/
         5Oly1SIi7MCiWZzg14d/D6CrxlU8AKCxcocIDpJ4sZbNCBgp9DgpEFbdporuijX5fy2e
         rOF0NEcVDdQ2+rkNYH5dggUYUXvEqj5QknSrXez6lX9id1EaCNuEBUEtCJ/zxNJYFpFH
         vkhurv5GAMQggfrvWAoK1TKbKs4ZO9WUUWCalQebcA0Ptn4QWBFrrIKc7H4Za0iJCvGO
         HWWwbgg4oSkhLgsaJI7dj8vTyOjDj9ofGOPPMbYSciFrvRnUy+KSVsg+Wox/8f0Pq0kg
         fUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837073; x=1757441873;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYRDGWUEa7FzMyNE6ErUXI1q4yIWe6EsYB+9O3a0jhc=;
        b=AQqZQrAVcLeatQv+VwT8VJhCmH5iTL7gKLXEsVLgsXjSztv8Z0Ib9ZW3Jd3fILudXi
         SC7kLHWKpQj1wMdyoUuHJkVWyDcuAjRDUYdANvJPIGNLCKhF4Pc8exMzzQ/UcQr4XQnj
         Zi3av/nayLYlMmeHYxlUHxyXHATzjJADbvPE5i+WLEPBsHLpBkttOK3yymM0mu49oUre
         OFDBRJMDcOBiG6Nn96PXS85TY3EEDq1CShHTd9F0c3dlwBgKiRAcybqienuMFGJNaj0S
         k5r+2yfAO4Hd5JobKwaCoqaGEstEKxXT56dsxXiBu0q67W8XfziW5M5T7PoIrT9A8xNl
         IU9A==
X-Forwarded-Encrypted: i=1; AJvYcCVlH9KRgcuD79x7ZLpdnV0CGE45HYjjfujnpwWPSekucVUtyzyd4vJtdRayIXsksM+AncUuyDNNBaiACQGTSrbp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97HBqyJyazPvp/YDSOad2PB3Z/1FCFyCtOvoDXZ+pivdRmQ/4
	I1/ADWRJGgwkd7uyqyBmw7cyFHc1SRKqAiRx5jvgmM3Hx7lT0mhzii1ZNbXKBiOXtl2HTHSDCMe
	cO6sUqkJ5+Q==
X-Google-Smtp-Source: AGHT+IEct/ZgBY5J6uSU7NxFc0iEGBl0tZPLIQ9NRRouOzI9G05tCQbxGLMxy1HPjR5iF2k6sMpYooV71Wel
X-Received: from pjbpt6.prod.google.com ([2002:a17:90b:3d06:b0:327:c20a:364])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2785:b0:31f:b51:eef9
 with SMTP id 98e67ed59e1d1-328156c5fbbmr19449455a91.17.1756837073381; Tue, 02
 Sep 2025 11:17:53 -0700 (PDT)
Date: Tue,  2 Sep 2025 11:17:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250902181713.309797-1-irogers@google.com>
Subject: [PATCH v1 0/3] Fix use-after-free race in bpf_prog_info synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Blake Jones <blakejones@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Howard Chu <howardchu95@gmail.com>, song@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

The addition of more use of bpf_prog_info for gather BPF metadata in:
https://lore.kernel.org/all/20250612194939.162730-1-blakejones@google.com/
and the ever richer perf trace testing, such as:
https://lore.kernel.org/all/20250528191148.89118-1-howardchu95@gmail.com/
frequently triggered a latent perf bug in v6.17 when the perf and
libbpf updates came together. The bug would cause segvs and was reported here:
https://lore.kernel.org/lkml/CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com/

To fix the issue the 1st and 3rd patch are necessary. Both patches
address a race of either the sideband thread updating perf's state or
the kernel state changing over two system calls.

The use-after-free was introduced by:
https://lore.kernel.org/r/20241205084500.823660-4-quic_zhonhan@quicinc.com
The lack of failing getting the bpf_prog_info for changes in the
kernel was introduced in:
https://lore.kernel.org/r/20211011082031.4148337-4-davemarchevsky@fb.com

As v6.17 is currently actively segv-ing in perf test I'd recommend
these patches go into v6.17 asap.

When running the perf tests on v6.17 I frequently see less critical
test failures addressed in:
https://lore.kernel.org/all/20250821221834.1312002-1-irogers@google.com/

Ian Rogers (3):
  perf bpf-event: Fix use-after-free in synthesis
  perf bpf-utils: Constify bpil_array_desc
  perf bpf-utils: Harden get_bpf_prog_info_linear

 tools/perf/util/bpf-event.c | 39 ++++++++++++++++--------
 tools/perf/util/bpf-utils.c | 61 ++++++++++++++++++++++++-------------
 2 files changed, 66 insertions(+), 34 deletions(-)

-- 
2.51.0.355.g5224444f11-goog

