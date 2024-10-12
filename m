Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629E2C95;
	Sat, 12 Oct 2024 04:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728707324; cv=none; b=sSWwnfbH78TdrtY0U8QVGo1KzaEPSpNehQdhp6880EMflxblrBCKwY9Xp6jvU1fa22JRVw3ZzNlB8V5tGjibmVZPhD6Q/Y6O1jkQI2MB2XiDYrkvnNWaEp4fumxBgFWDphfXzcwXRrk76UmK8pmO2jV6ZTEqhI75R3ShsrJFaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728707324; c=relaxed/simple;
	bh=Bbf0Xi8nDyy0RQ9xMJwyhmMbOnR08G2FM731oneJbqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArYDaVro90oPRHqMKGdnvHaHDkPvRt+jY5PRTWwclf6Js0wWndMqNwoKB9pCbdlQGgJC+Sp9G65U66jSIcGKwCRV9BnVNX7tGb6Tnai3kMxIDPjTwvvo6nAkuPcReZ4GPjD9NhH3a7c+qdlj0p0sLNX5YQdCrGXPHXOCQggRM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiNN3Rkt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiNN3Rkt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c8b557f91so19102335ad.2;
        Fri, 11 Oct 2024 21:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728707322; x=1729312122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmXnEse+/nGal33tdtrst7YWtOOAQzSEHx/Y+E1mNt4=;
        b=UiNN3RktrDjXcms0oZsJF9uoMQOsA/LSEVQ4WVZ29qKu+qog/cvjpuUB22YGMZQqFl
         /4lW8QpbNTmVmTPCJn/Ckfpwq96f+xyOZ+M9DKInNXvoGyziprlFtRDCrbwmbEgT0+JH
         uOO9Q5guSRiiNJqUeAzMhUFRO0hnmjxoqwRdPqtHsoh/8YX5qOpxesJlr77Aly9yKfFb
         PqZTI1hYQlS/22YkeH+PC1m6lu8nZhL7lce0zYscMGKBnwhrwtl9OxAdJqA7gwzw6z6R
         GcIAO8OrevlKZjv4UgtoJ7EZohfAsnKQFwck8JEs7uADEFvCZjoX/qb0JTfDelq8kFtn
         JAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728707322; x=1729312122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmXnEse+/nGal33tdtrst7YWtOOAQzSEHx/Y+E1mNt4=;
        b=MHFmNIMngYLO3c1iSN9awuKbX+xzR3FEXZJelUiuUMroGwEIP1IigzdMd+BLTox5y9
         /n1JVk+5Jj0zX+uX33Vz3itYbOouZSqwFjS7E6sbTAnU1mur18P6/GKT5+Ta81VkJ7M1
         kQXunyL0++aTHV6A7OaBnKLe3wT2GKnP20Q4yham1W9g4pO0d+CPgHevBraBOXia9zMS
         CDWt82t3ujhzxO22Py4pNmjZPy8KedYvkmmEkdlOpvvxmMn7xwON69+HsL2bhprlQIez
         zxgJjlQ8sQofa9Af/oylGqggBmkfcUWthcPhs/li75R2sDpBXH60DpTBumnAkqNtCa+K
         39jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD8HbcvlFMHs9bAiHA5uGIHvo5GCYps+MoFssbZzaFcxa7OGKsHnS/jRv1923mTCp88qGGwbJvsj4SY3E=@vger.kernel.org, AJvYcCXGm52YeSK6MRxqdpjBOQ4k6M/upoKR4yIhDbw1piClXHYFjy0nmUJRpVo7yNDGOeMzsTJKVugjzsZhinHdZh1PnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FLEeLoSaa7AMBgDpJO8PtZQFFEmqqzBDNaEpz9AY2ARLVYrT
	D2g8+tv+aksCd86NbPboSyoqkyPjndjFAG8ugROl0BO8QyNbGv/A
X-Google-Smtp-Source: AGHT+IEe3bqr1mfSFGQO2hyrp70yJGYOVXYRRhegr3xV/q2PYsDnqvmUOx6ORjS6ptY2+BAZU+a3Fg==
X-Received: by 2002:a17:902:f542:b0:20b:8bd0:7395 with SMTP id d9443c01a7336-20ca16c8c08mr57692445ad.46.1728707322149;
        Fri, 11 Oct 2024 21:28:42 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212fc7sm31017165ad.204.2024.10.11.21.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:28:41 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/3] Remove unnecessary header includes from {tools/}lib/list_sort.c
Date: Sat, 12 Oct 2024 12:28:25 +0800
Message-Id: <20241012042828.471614-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove outdated and unnecessary header includes from lib/list_sort.c
and tools/lib/list_sort.c. Additionally, update the hunk exceptions
checked by check_headers.sh to reflect these changes.

Regards,
Kuan-Wei

Kuan-Wei Chiu (3):
  lib/list_sort: Remove unnecessary header includes
  tools/lib/list_sort: Remove unnecessary header includes
  perf tools: Update expected diff for lib/list_sort.c

 lib/list_sort.c                                      |  3 ---
 tools/lib/list_sort.c                                |  2 --
 tools/perf/check-header_ignore_hunks/lib/list_sort.c | 11 ++---------
 3 files changed, 2 insertions(+), 14 deletions(-)

-- 
2.34.1

