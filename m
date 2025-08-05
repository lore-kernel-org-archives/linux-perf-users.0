Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70F18A6A7;
	Tue,  5 Aug 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375544; cv=none; b=WnRv4H5oYyvYQ+yALFd5FaOT/QCv4VgPK5/Irt4+8As+1VrIXIWw8P7OzGK8210XG/p3NQ/vZxRyu/OUiIqb1Khz3wtfHzy5C1R9bBUQTA6PeqfNtLQY5SFObgGLoo88xGmT9lPDbeUvEtIQR+OHY8kF36wfcYSnhB6WfAdOQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375544; c=relaxed/simple;
	bh=X/+sKyp5jo7lHuithhAGKpxLZMM4SM9W5PQOPqWjGZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PdPMDKnx/AaXxo31iR4UrCahlZGxV936tCsdz7RjhqGYOmcGD2Y8ak3BSYmj4V9+6hNUz/rpbWU4jkD49OCemAxhC7xFJg2PVw7dgqDxo0vss95j2/PqRYgVpibgcO5TTd9bBIb11178PR9SNLUk0Of0dqJxs/I1yh9RvJhw0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg2u0rol; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg2u0rol"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2405c0c431cso53515885ad.1;
        Mon, 04 Aug 2025 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754375542; x=1754980342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lt/ZmoyZo367eftvXkcrNASqNULsTIyhJjgEj0SWv8E=;
        b=gg2u0rolA6ruyDLv0Hx1m9sCXGyZACjiOwoELNXGWg9iqXCYSd3NyECeUpQvoAldnC
         5oq0srmwDo15KTdXHwi38oQBLzMhDbudnLnXUJiIdsh/+ms74TC7xubSqxrgpMmerUZL
         51Q5FQBHJzc5wYtDMqhww0UJUm5Rgcf0stvFpCuwT1LOKhigYwVcs59zvwkpLQU021yx
         NmZ5ng6gJj1wqoX7APxol2pLdtqyrdjcuuwm5Xdt55S4enhvBGJDEugCjulPQY2UNSjR
         dNoPHMLRYyGlnq+F131odfWIhDIoF7btPW/eL47OgKjfwnDn0rtIVPaEdPlXGzUi81mN
         td8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754375542; x=1754980342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lt/ZmoyZo367eftvXkcrNASqNULsTIyhJjgEj0SWv8E=;
        b=U8cWPSWlxn0W2PT+OohY8wLUGf2VdrPGJYz5bghPDX4Rgvh1I0hA1Gz0QXdWtXvkzO
         WXb5Z2vbd7qsjR0Wrg1mz89JT7JkA5Ts65O6aTkliAVxNXNaWU+16THRoQqNbQWh+V1O
         nR7aiZXH04Z0Zs9y5qesnAAX78ORieKQYhcKQBalv03KivgmR6SYakNPRHG+aaxkOcUY
         B8yYq8paLI+CCTHSuaJRymyUTC32xJsceQ4DnhCyUuScB6squ5JVdMDcFGcNRvFx8xEg
         Su6xDFK1jLyqr6xO/6wKAfC8orD8hTLJ9ac/6vguvclA0ZO1H9nFf3AyctdZcrPbR/d8
         t4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkBAjFCc5xu7RbMPnugJFxB0pQH/CB0NMNJPrg9nkIgDNHl+jjxN1JI+rGtwNGujUvELa6ADccZkfCg2w=@vger.kernel.org, AJvYcCWVxhpBRtOfFtWNz4upMGZuVdfDKl5zKl15lT5bzKh1pW7t0wE+G/Wv6JuYdbUlxtujVzzzr48Ojgotmyv6ew44YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBhqUXEUSwxenDFD9EQpYsyXiTo283N59xI1s86ydewhGHcRW
	YihekErhN0zIjowoL1fYVllQvQncCt8KI9cdZqiNUZ3GYkaaDoZHpt3F
X-Gm-Gg: ASbGncuRkt+Ft9gcdXzEAtuHmNYsfRPhR1lCbiQs6C7EGsp2EmJkjkaWvJGca+nq97u
	+PvGwT4jt3XxxfyW/Wt8ciWl2HEJpXFhvBoM0TbMXUgRgseHiy2sX7lqDCawxuRXUMQEGi00yIq
	rZ69cPEniWuxIbtcWiBQ2CX3FlD4fFwRIOKxgb9QceUZqEyN+62b+G93EK0UiNTgRyGN4pz7qFD
	jRhObjstSvb3074RC02MQfA4LkZBUJ+unwRDP/yUV1cjhsrWDgxkgK0Erj6AEzu0pGn2teoUvzQ
	GbUp6HEnASHmQIkigQA5YQnViZUKVjBK98EGunDHnAM1tZMTX8hDUpfh3/UmBb+tNMdi4e2jxTh
	UXNWBFjVneJnii8g6LMEW0nc2spfQAhY=
X-Google-Smtp-Source: AGHT+IEwjRm/cO5ehYo1FC9ZqKkts8f7CzTR+CW66812rjBpWAByosm5Cx3UYb8SOz9HzD4OVw+Q+A==
X-Received: by 2002:a17:902:dacf:b0:240:49d1:6347 with SMTP id d9443c01a7336-24246ffbf2cmr158424085ad.35.1754375542504;
        Mon, 04 Aug 2025 23:32:22 -0700 (PDT)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm124448865ad.46.2025.08.04.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:32:22 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] perf: pmu: Fix IS_ERR() vs NULL check bug in perf_pmu__init
Date: Tue,  5 Aug 2025 10:32:07 +0400
Message-Id: <20250805063209.3678359-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace NULL check with IS_ERR() check after calling
hashmap__new() since this function return error pointers (ERR_PTR).
Using NULL check could lead to invalid pointer dereference.

Fixes: 754baf426e09 ("perf pmu: Change aliases from list to hashmap")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5a291f1380ed..da6f05872493 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1176,7 +1176,7 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 		return -ENOMEM;
 
 	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
-	if (!pmu->aliases)
+	if (IS_ERR(pmu->aliases))
 		return -ENOMEM;
 
 	return 0;
-- 
2.25.1

