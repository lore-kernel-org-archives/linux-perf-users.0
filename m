Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF663B47D9
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382247; cv=none; b=XqObDiwAy6ir2A+AJnb+0fGYJheLT9HNqdQe8IPdRNmK2VHqEOtHsmD20D0xudrwtqlPCv3dBVqnwkPiPQIqMdKGUpuBSUvof9GnNSOZWQ78ERVWYo2prHS6hU92s/ggg3cvfci6eZZ7+75sfRktH/7ObTu0F2NU662S2G4xdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382247; c=relaxed/simple;
	bh=VoFt/8d9bTF5R80NXayZqE/E40cAkxOPEWZbKvSt2C4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jav/sWZ4lA/yiqHLL1x0Zf2pRP2ZRC1l5O04gVH1sb2m26KVQTLl7qsvCx/urYZ9utIxrsqzGGQUXjae1foUZlSZNQlz96GksEgyhVqb+VEfVuXrVuDRrgr6vsEh3ZGjJcZYNET1lVC8mAIdcEMmpHBRgQMWjsfxwP9WQLjYScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4M4677g; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4M4677g"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cda5e048fso60205e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789382244; x=1789987044; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jk6L9cGG+NNPuRM+9aIldjw68vekE7ZQtL4c5PAcnDk=;
        b=r4M4677gERtV/sEWy1Q/JB5qG+6dvk8Q3W/MPPffEVPybpEn3jnjO9u4KwGa5+swl/
         Ix5/dLGepr+tAYx/UpRcFbb3SuirGgjENCxrcqxQnKrU/LW/2rtsYApp7FvAYpDnMnJo
         RxHrhQPp9ypPqYbdq0d0BRDPvUUeM/tqQzI2xDZiWJbBNrSVlnh/YIi1+OZWCT51Gs60
         aPvJjJKiPx+XN4CZvPlJZVsCybWW1RUn1ZvdXgyPuj8vWBk7O1AWUw9Q0ZFkutqxbvdA
         AtZPr3PhEdWMfodlYMJUdHW0mgun3Eeme1VegosJW1Byg64XyV7eXelwXSQ0dwLkM+6i
         4Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382244; x=1789987044;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Jk6L9cGG+NNPuRM+9aIldjw68vekE7ZQtL4c5PAcnDk=;
        b=tSE/a3jv4DziZF5g2misZ4bzWAyV0dqDpS0YGuDKswn8fcHs426JM1HFdCqix4kvr/
         ojRqk5Zm6oJ5YvtJvmU/g6N6nfwWd8tj43ZPS2rTDxOsezkTyYW9wwfpYYRweVvYy1sr
         pprYGA5wPSUICHmaieLYTT4oKq+aWSgWp3NcG4a3cjib/3OkqZ1k7tw/MnECetMPccgw
         JCMXOtEEsofW078hctUKen30cB9cins2qD5eF0w8tr3Tai8cTCwcRdBccs93EhEdI8Ku
         WwDpQIYslqYJOTFuEwdThIa0MnQpDUZNTZET+FkynCgayVRmzh9vZwPoCdHTK8Fx7FAZ
         Wurg==
X-Forwarded-Encrypted: i=1; AKwUvBwHkENAc6dphPeG4YHFi5kxVg/uk08DYkd0TdCciWlJvHe3LvWsiKCaGak9QJugW6AfTGR7NZ+fiR6lFVO9j5OL@vger.kernel.org
X-Gm-Message-State: AFuF++mBZkrs6beN3jJGk7ayqVvryMKA5fjsskzme474XHueWwtXZMZK
	y9lEDssSgR8YJf3hdtmKi32J0q6rcRSmVVrcKBth17sv0qKwLNyKO9BONaFtjHfLBw==
X-Gm-Gg: AYBFou2/hUgck53BSu10N24lkQttzLEIQ/blm+XkrakEGkhrx38E8Acpu0TY/gk76Vh
	kh7Nq5MBjSKZR0FmolS6A0TP7py+I+iCNJtw+ztiE2CyjdqVgyYnP65SZq9MAfkuxj6Q/wW/HGI
	qLhnVJxXf1MBTwfbQB0rnAJMgLWZF7weeUIFeVfvj3Ys4xt2HAr4aVxZGRDSJo/NJWAOV6fybMr
	KmNEIgLuP8SY8y9Gg1aL8d3M1ZsudkGj8RuXZVw3+KHuP0izhH1CVBP85yqJE4WSZmS4bPbjc38
	G0Q1jD/Jl4enDmVq7/3/D98G51Yly8WIjgkyqH8OuVCy33LT/SY0AYmefraE316/UIUhfIFj05X
	jYrsnPRht9Ebu/UKz+obqUm6O2HrEyUguXSMLuPQvEjsDz5xsZvs1iEzG8mDtUY4Yjj9G95Ox/b
	zucwZutzQptJRoKAuylHSmKrWajfQC6BlmmEgCCQPyjIfZ54Q+LalW6aryqXWd/9PwLw6kNcfHN
	zIv2Nz6pYxqdYQlshcInDtlJlKmX4dqwBWKLG4yvSBvOCPOiEkIlL+Q+hSEVd8+kSOwJg==
X-Received: by 2002:a7b:c847:0:b0:49e:7981:4294 with SMTP id 5b1f17b1804b1-49e7aabd00fmr241415e9.5.1789382243989;
        Mon, 14 Sep 2026 03:37:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:1f9e:b6a9:a1f1:7faa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm233088375e9.5.2026.09.14.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:37:22 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 14 Sep 2026 12:37:17 +0200
Subject: [PATCH] perf: Fix refcount leak on perf_cgroup_ensure_storage
 error
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-perf-cgroup-refleak-v1-1-eac12ba28be6@google.com>
X-B4-Tracking: v=1; b=H4sIAFzOp2oC/yXMUQ6CMBCE4auQfXYTWhXEqxgfaB1g0UCzFUJCu
 LsVHr9M5l8pQgWR7tlKilmijEOCOWXku3powfJKJpvbIq+M5QBt2Lc6ToEVzQf1m13lSlwvpix
 uZ0rPkAZZ9urjeThOrof//lO0bT+IIYJ+dwAAAA==
X-Change-ID: 20260912-perf-cgroup-refleak-b9b7e5417683
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789382239; l=1382;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=VoFt/8d9bTF5R80NXayZqE/E40cAkxOPEWZbKvSt2C4=;
 b=VrzwHWCmiNCTd6jiBqZfsRO9CEkkx1IS5tVp10U8iuLoLM74ZChvxzVfAcPg5b7cBZEtyPTwK
 qPXUrLzh+qUBkp0AFEPN5evtPJilUnddcl+5h6joAN7RNqY7x1kw8zi
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If perf_cgroup_ensure_storage() fails, perf_cgroup_connect() has already
acquired a reference on the cgroup_subsys_state.
Drop that reference before returning.

This probably doesn't matter in practice - it only makes a difference if
a kmalloc allocation fails, with allocation size depending on the cgroup
nesting depth.

Fixes: c2283c9368d4 ("perf/cgroup: Grow per perf_cpu_context heap storage")
Signed-off-by: Jann Horn <jannh@google.com>
---
I've tested manually that forcing the failure path without this patch
causes the refcount to go up and stay up, while after applying the
patch, the refcount drops back to its original value.
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 33210aff3ee6..557c950eae06 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1143,8 +1143,10 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 		return PTR_ERR(css);
 
 	ret = perf_cgroup_ensure_storage(event, css);
-	if (ret)
+	if (ret) {
+		css_put(css);
 		return ret;
+	}
 
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;

---
base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
change-id: 20260912-perf-cgroup-refleak-b9b7e5417683

Best regards,
--  
Jann Horn <jannh@google.com>

