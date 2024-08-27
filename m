Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BB76056;
	Tue, 27 Aug 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750433; cv=none; b=s88NO5edwx0nTRs7j9PgyleV00QIXaW7N3yQtDwBYEQtI1I/QSTKW882wPxahd5Im8JlrMmVBYb4Xlug8mE24GmH0E4FPz11YMWY50hSeTTu6zd8zASNjsxJUlSHpIkf3giN0Rk66vsvqLHHXv3X2/7/+rQZlBHkYR9LkmLNzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750433; c=relaxed/simple;
	bh=gtbhb54O0RAnnazSqHDzmfQXO7JPiWdE7fDbWQ9dxwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kk7cHewPTdET7ihbb3OSEjIPUsTLOtkjoSYrAtvrYMaBXOsbN1ADIVMiUIZEKcB7Z2ZDYsaaReFswetv2QYuzPbq7G+zIkUj6olfLhSMAT/T6bcrKl486+cYp3q6EqD/tnnOzIS9g4OVV7PZUhSJFFYG+S+Glgy/fmZra6aqNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3WwBUse; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3WwBUse"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7142e002aceso4297963b3a.2;
        Tue, 27 Aug 2024 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724750431; x=1725355231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3OD8akG8wHAOaiKj8NG5SpXVJ2rOAl/ksW7Y2RAtL8=;
        b=D3WwBUse7ibh7Vuz8axqGEisi8HCeOYGl4ZBxNlZUFHZRnSozBqS7drJkTcERkZMsj
         WSvSUMFUTIHFopX8PyU+KELiFIQVCR05tPofLuGzpTKYiHi1UI9ZfIAf1RVl6ywP55am
         hcqrIiwzDWRl3/QVcQD7VFlYkbxN/RoyXzVXFCdsX6KSgx1v3CD/cVGtn9cbQKKJ/ZB7
         voLucjBGCF60711CPxQON0rf0rsoS53mYEoe8/zBY9CY5cjw3/JEtYAfJo9Cur7iF1u4
         BtrvFb4PCzkbn7norgCLFG7bWNopGmevLmqNUmu/CUB0fyC6RliuD5jZvJZzEmUBTcNu
         ORKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724750431; x=1725355231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3OD8akG8wHAOaiKj8NG5SpXVJ2rOAl/ksW7Y2RAtL8=;
        b=CV67H+JzQuKkZIPxN8Sn4/euJ+qoEnqF19cXZl27LmrIXDPiRM5CkUecGOJ2/nynJw
         SC4Mi54hqetMRfrDgd+8m6ZXyKHdTinksBWocCRjBT/axLZqRfZ42V4vQk3sKqZGDO59
         BcCgrquX8zC7LV00Xr8ILIaUgPnik/xdLjg0H9PL/aJvbJBb7NKJSBTmQr/BPW6DnNws
         cG4CcZrXM2UkP2LzgtITGCXVip7CFEUOoAUlMSubDdIAQ7v/SrYLSaiYnTZ9OptZGcLg
         pNOcCdD0435BAaRXl5TXM2uiKUrB2gne4c53tWHn8zDCDKN/VEPQKnNb4tsYv1z0fZ6a
         zTQw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Hmpck5w6q7YPRo0J4XZ1JPO4vJISK78DBIO3c+kIKlRJ/VawFSeMt4CImhNUZU83cKI8GY2Q8O1ZHYomvXNrlg==@vger.kernel.org, AJvYcCXOVqWyfLcjc0CLKJvME8hdNEffUJsMuV0Vxifmt83IC30SBuhG51rCPtPyOjJn8iHAt09YxcJ4Y3b51/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzau+WkfDUOzg03I/MwwMNEWvhkgMQJO35Yn1sJilgDRbXzcW
	bc4ybNCI2bnI7ulzUNK630FOo028Xd3K1LkupGqvqdaV6QcaaPyn
X-Google-Smtp-Source: AGHT+IFMwNpEwzOdchRiBCm0k59fIKZASq1grwE3RloSqqXcnhuwbbbg7sQHO5ePgA5wBR2h9Asmjg==
X-Received: by 2002:a05:6a21:164e:b0:1be:bfa2:5ac3 with SMTP id adf61e73a8af0-1ccc0997455mr2219641637.35.1724750431121;
        Tue, 27 Aug 2024 02:20:31 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:ab14:280:f82b:883b:12eb:74c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d6136fdaeasm11523939a91.7.2024.08.27.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:20:30 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 0/2] perf trace: Better -p support
Date: Tue, 27 Aug 2024 17:20:11 +0800
Message-Id: <20240827092013.1596-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we don't support only collecting data for certain pids in perf
trace. We either collect nothing or everything.

Another thing is when using -p, becausing it's a per-pid mmap,
bpf_perf_event_output will fail under current per-cpu only
configuration. But since I fixed the -p problem already in the perf
trace augmentation v3 patch series, this method will be an optimization
instead of an actually bug fix.

!! Note that this patch series should be applied on top of the perf
trace v3 patch series.

Before:
perf $ perf trace -e open -p 79768
         ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)
         ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)
         ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)

After:
perf $ ./perf trace -e open -p 79768
     0.000 ( 0.019 ms): open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)
  1000.187 ( 0.031 ms): open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)
  2000.377 ( 0.019 ms): open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)

Howard Chu (2):
  perf trace: Collect data only for certain pids
  perf trace: Use pid to index perf_event in BPF

 tools/perf/builtin-trace.c                    | 100 ++++++++++++++++--
 .../bpf_skel/augmented_raw_syscalls.bpf.c     |  54 ++++++++--
 tools/perf/util/evlist.c                      |   2 +-
 3 files changed, 135 insertions(+), 21 deletions(-)

-- 
2.46.0

