Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFA28DA0
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310280; cv=none; b=Kq1OfpC4Te1eK2UjvpM+1s6vEUDKQm0++jd/sfgPei/hpTr1pG/p/mwkAIEUsVmTOMrLzLrczL5j7CJLjkeqvQh7RbZyVua25bAD9y/Jvb5gYLmmRw2cGiJK0MWg5fU/wmiRasoPmgEdX3fkVViQlZgkUYgNbm+AR5jrIkzSwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310280; c=relaxed/simple;
	bh=bjhkqCLwFh5x4/YQNYhbvCnOXQQwYWrnkQRg+dc4jVc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=nKjk6eJn27FMIX/6CiNeo6fkuIodczpwcAeLmfYbicwaxHKEFj1pcEoWVgFiB+97wJVVJRSe51HB0tsJsj6/RvsGAYSMoK42/vV7Efv4yZZFuGL7DWt7zV/gFRzBh8LIxjDhPnagX5bX+idgABeTNlnF7uYw9g23UWUMkIEV4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkIxJPC7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkIxJPC7"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4d631a4c1so578549276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716310278; x=1716915078; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dTzCtBYqo5qPAcuxKyv6ANbzvYtg0N+sVJ3rcLshDVM=;
        b=AkIxJPC70HmEjjUS3NF1ZSWTj2RcmTW1Hj86YylWMN+Ig+oNfZRZI84xCSzms6w0+4
         CoWVlpQvzzZJuowDVt/ESbkP0x7rj0MleC5AlOZQGpXg96qhg73jp3WRUB7bKhCpOdgV
         tJjDZ7B7MwbTawxFTC1M3cymtb4eDpFyufmqO2XWTmAt5kwzSiRntF/ROOE6mtV6y6rN
         N2QfUtrtxzAMN+klzEG5FT8dTWhOJogLAJa714M8QwE2e1Dfpiowdvv6NgyjumC6wJ21
         EAl1bjRG2le8lFzUbvqVuSjm30Hsqoq0qkSohoQ6Oaczp4UjXJBKzhKTdBwfrSb2ZsCt
         M1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310278; x=1716915078;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTzCtBYqo5qPAcuxKyv6ANbzvYtg0N+sVJ3rcLshDVM=;
        b=r+qaCW4IrLt8ggt71iZbbnpqNRVEUrYCQZWYX6yS4vLZR9zYgGCyWqZ8OZ2PRF5NfD
         EDm2YwEgMhHEVJlCxvsL1uMfmksPOIcyWW/MP6YJMzJeXWINg/gFQotxV+PnNcSGPlve
         RjFu+gflkbEAsFYosFeYCNv7PCHjz2y9bnh8kuzWZhGe7/bjc3w6JUXAUvuAfcp3YNS7
         IjlQKXLGQS4dW/y9qvkWCZJZQrfcksVwEd116ifpSSYxn+T6rLspJIyyTnCBB1pwWsxX
         Wn0yelfLcoTBG4RMGQU330KDvrxSv9g5tvsrB4z38rWiSTyrg8ZsxIIQClLDfFax8cFN
         g3cg==
X-Forwarded-Encrypted: i=1; AJvYcCX7FU4XlkPuQ791RDclEWO7ZusIucl69vZnrqMK/xEWQ/cSJMeZNM629h4JCNFzW/MbpqHQD35a300eNh8qs+wA7c2H1FlC99LvR2vS7uQISw==
X-Gm-Message-State: AOJu0Yxiq9G2Z0rx7sNXoVYmEWaXhWJXi3z6txsStu2xcxRuiUXWTBwb
	HORAyMCs6wUzoNTh7su+Ycu7Zl0zkqlA8DcsyxHpd4yy/Q24m+3IJJ0Q+WL8vdPwZ4S0hgdirFR
	HmcJ9vA==
X-Google-Smtp-Source: AGHT+IEmMr0Lb0d9RryWzApjev8jwTAxZLwt8l5tfrfEm3fDSReYbTbe5ajh9TwlpM6kOzRv5E2xItYNLzXm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a25:8211:0:b0:deb:9d56:b498 with SMTP id
 3f1490d57ef6-dee4f321076mr2428304276.13.1716310277923; Tue, 21 May 2024
 09:51:17 -0700 (PDT)
Date: Tue, 21 May 2024 09:51:06 -0700
Message-Id: <20240521165109.708593-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 0/3] Fix and improve __maps__fixup_overlap_and_insert
From: Ian Rogers <irogers@google.com>
To: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix latent unlikely bugs in __maps__fixup_overlap_and_insert.

Improve __maps__fixup_overlap_and_insert's performance 21x in the case
of overlapping mmaps. sesse@google.com reported slowness opening
perf.data files from chromium where the files contained a large number
of overlapping mappings. Improve this case primarily by avoiding
unnecessary sorting.

Unscientific timing data processing a perf.data file with overlapping
mmap events from chromium:

Before:
real    0m9.856s
user    0m9.637s
sys     0m0.204s

After:
real    0m0.675s
user    0m0.454s
sys     0m0.196s

Tested with address/leak sanitizer, invariant checks and validating
the before and after output are identical.

Ian Rogers (3):
  perf maps: Fix use after free in __maps__fixup_overlap_and_insert
  perf maps: Reduce sorting for overlapping mappings
  perf maps: Add/use a sorted insert for fixup overlap and insert

 tools/perf/util/maps.c | 113 +++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 21 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

