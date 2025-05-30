Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD531F4E3B;
	Fri, 30 May 2025 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748586253; cv=none; b=YxwloVHyhTOm01txbvDDoOjEe0tMkbfI5dOYWOk3QerWUjbJvQLsgOhco4w08bSoe8tPkibGUSNEZpBpnHCvAklrEtF7MRErjjWIG4zvBlzf+t1VQkdlB+A4/LYbYfxVc2Gks/HoNBqX8/ya5DflBz7ccEAeQGKSuFdlV4WXHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748586253; c=relaxed/simple;
	bh=TLOr+MMbBq8LIoGHuyg4UM3GOFKuQnjTBpH9P0Fu9/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZipVBGz6Z9yOqIr7UZj6I+OU8IomzUzalmBzL6t1SfOdld88COrGH1c503q8M3exq4piB9tuLOKP06uij8tQI21TiCcHTLAUxs5+yqTNhIL0NU4Uf8/DPQyCyZCtDJ4kDkZcTOzNHLWzrLTe3ukma34OavaZRUOCg2NiVIArHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnhPIZRO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnhPIZRO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742caef5896so1358606b3a.3;
        Thu, 29 May 2025 23:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748586251; x=1749191051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2cw5LRqV40eP2YGqMoiQDq+JZrwrLC59++RLr4NsG/U=;
        b=FnhPIZROho7z9UIEB+jBC3EzRyqH1dkUhhm4+2z00XryJx+neYIVp06kx0hPgAz4wm
         fqijLJhhyNszcg6pswj3aqEH/nbI1B04F0e7ov9o7nXAA+a6nmFIY9/nbhbwiScE8TyA
         tWXy9x8tvn+R8UWDtfov5qEP7IjAyteBxy5tvVS6ELkQdzCKRuTYDfgGT8J6SgUOz989
         8ExwqsmiWZuy1uLj1/Ew/ugQe02c5O1L/F3wjxKWchmmKTSFdzYeayGaUXno4zASHsHt
         tBzrnCfOXSNbRO+AZ79ODafflAZAtB9Cp/QvI4DyBbzEyZg1LJZ2M9dzV4lAULmG6csF
         MTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748586251; x=1749191051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cw5LRqV40eP2YGqMoiQDq+JZrwrLC59++RLr4NsG/U=;
        b=bOa6gLR49ZVKlbH1PIhm5ZWxpXsAlKMDKaadCD+0dqlpN4OKb4gJPNFlFHXUY/IjIk
         IhVPd6sS9yfzotqJlHSBchfjyO1j7xdRUI+dBQeCttBKSIshhNTLU0z4C78pB4Chb3s0
         MNFfvQaTDqRU09r6QYTLhNal0mISQ1pOulWp5UghBmPaAqDsSBe9s/fhPODOZhFtAvb9
         ZwPzh+CMS+ucrnkctHeV6tOB8kKVEAVbOBkP3UsIrhgkIygXRTIJ0ImoXkQdOQrnRBPT
         mjwi8CNZ4j5Oj7q45pIDUxxiW9zZOuqzT+tJJBSS6tngV94IYvvjYlglxhfoMGZcVkH+
         siFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0JBheBHiKTzOLcJjTGDgp0HlWMr4P1P3KJV5Mpnk4RWqZpLlIgZl7azrFTV6PN/7GX71jJMt+5yW/r/5S/iaXyw==@vger.kernel.org, AJvYcCUwgXaBbDko9PJBn0AbioEQsL1HgOu4MJ/uQtSPhJraZnzUl1vdNxcrsB8o+c4jQF0Xb8FfI6SH+oMNAVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0tVdkuhI6CGnFn0/CFzKgrCI5GsIT3KuATFcXvVJhNJzvOoU
	9eMMDsYUoxq2gyk09LTqfe8Dx7iKaZK1OAxhlAPFjMlqAttqCCq+qmfyHSL/Fzcb
X-Gm-Gg: ASbGnctTGv3EXBNXsD7ywzf6Ko66DIdjIEpS2UOVW9Fwn+HcvonEWDJ7DGrRIB78q1x
	SY7lPlyj9+mZoxWgoG+tnk5iQm7ClvfoDOMUxW/y9gREtSySN8EP71YRNjmw8sEL2Z3l4/wzcWV
	roQUGO+u9OgztDL6QFKNch0CH/Z1kp6UgYURKe0zAggv7gkhWHetEUEv9RhhkyQzZ9zfh/dRYRc
	+y+974kcYkcIK5hJzd2PylYWauvrgOgCuRved5c4eu18desKMbVck3Ln8IfQXL89yW7Rl5tF2NN
	x9gj7RED6s8j9i/lmCC/Nqy9lEUD+/8Sm2oxQ3miJfAAp9YIOaRA7r84a22/gFajff8jAo5q9wH
	LUfxEsaK2VRw=
X-Google-Smtp-Source: AGHT+IEwXUABpMD/QbtBBcIjF4niL3b2gHc8b+nw4cAZai7Ro0QnvT5OTwuPuUwmmnmosS13yUy1bA==
X-Received: by 2002:a05:6a21:3418:b0:215:d14d:6626 with SMTP id adf61e73a8af0-21ad9563993mr3557338637.12.1748586251309;
        Thu, 29 May 2025 23:24:11 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb6857sm757498a12.73.2025.05.29.23.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 23:24:11 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 0/2] perf trace: Enhance task filtering and remove an unused function
Date: Thu, 29 May 2025 23:24:06 -0700
Message-ID: <20250530062408.1438861-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Task filtering is flawed on perf trace. Spawned threads can't get
augmented, and the BPF program collects more data than it needs. This
patch series adds a pids_targeted BPF map to better filter the tasks,
and makes the bpf-output event '__augmented_syscalls__' system-wide. It
also removes evlist__has_bpf_output() that's no longer useful.

Howard Chu (2):
  perf trace: Enhance task filtering
  perf evlist: Remove evlist__has_bpf_output()

 tools/perf/builtin-trace.c                    | 52 ++++++++++++++++---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 35 ++++++++++---
 tools/perf/util/evlist.c                      | 14 +----
 tools/perf/util/evlist.h                      |  1 -
 4 files changed, 73 insertions(+), 29 deletions(-)

-- 
2.45.2

