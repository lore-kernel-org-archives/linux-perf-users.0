Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464021A8F98
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123887; cv=none; b=riX6hIlYI+jBdrswjTdAfsHuRos8dj9Rwt2lO+IKA6EttvlyRawnuWklpzZcxlTGRCioqFxdqh2guTyPUNDpcxdJKJP3PwyPBXSkwMEwJuVnW+iRIE9AwwSZAadZiVint4X1BZ0hxdlOcQKqVN6IsocAhlpNqM9+27/lO/VqtKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123887; c=relaxed/simple;
	bh=5BfNct9byh0W7AC8JMgEtJwAR7Xw+iCYGpMPgd4MCTk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=K1Brs9lNmuT5FCHwyWL5EqcxzXFruz/hPlQmc+k1PT8XVhqOZwkg1kdAccVp8tGXqNj8XGFugMznPTW/uZFqANZvmvfnGbjXW0XbDz1e9rYYEGQFMsdCgrWXXrIoVPdaSiikIz05hnk9FgAtXTPlCKmW1e3K84d/2ZfSfN9kN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XA48kZVA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XA48kZVA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f013249180so42998897b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 13:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123885; x=1734728685; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qacuxPXKAwtJm5TN79eg+JxRwsGOSsBYxYDQ++eqYog=;
        b=XA48kZVAUrfWTBDXjz0jXrBBzFbDknSBz9MSMzV17wcTW5cBoomstUvDr4fXk9qLHE
         Obp1zaBIPtdK9UxUsBvezfR98ALdmz7bHv0EusHE5Z2qO+BRGPjFr/jAVBa4YxLzMak3
         Bq79DQIUVm7yll7HFmrbBAYZzOf36+KkNnrgvauJTbCh6M/4tFQLUV5d7ddzXDE0zpt8
         0MrRE65swRWmKon/Z7hMX6ERxCQoffIgYCMkLbmBdmDasrknJWidDce5tVcIxUVfHcqo
         2P1o3FY9rh2x2f0bVP2jXQrxYLR4/joHyk5YUBm4NIPU8l61pEnXXq9afxB4trXVaT5H
         Vkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123885; x=1734728685;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qacuxPXKAwtJm5TN79eg+JxRwsGOSsBYxYDQ++eqYog=;
        b=sa7/u7zRmtPKo1OfkWvYfdLIMzw5OKPAU5lwdFW/6EKflsgzRnQYfxMGdDQW++xWBL
         lawrYX8DMDlxjgRu5z6/87LvvJnEZkt3/bj7Fknzk7AFfA/dmFWrCY0kDTZ+Of7H5zdG
         2uPFtmWQmNNgijPpGoA6zwmFlxIsWt3UZ5VCHyhOptISwbD05LqTZeyHlhaM4+Q9OwYa
         5TFq8+9/Q03fXeuj/2JFdLOyoyHFALrzCRFEFOD/w6QKZ+Wwx7InL83yqTBkx6cO0c8p
         esEaGHQFuRDIH1drhhA2ugFATyVNVg/vXz01fQNbGfdfak6aq4DKSdFMZT1Q3nwL6Pur
         4fCw==
X-Forwarded-Encrypted: i=1; AJvYcCXt1gDQGTjmIHAI5lSiMQ+nRw6vvZvVKyq+653fICb77QcB0FGMs7JYg/kXo85WJ0LYIYGPSzaOWU6zVYyzSQVz@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjch73+PeVUTp3zTl7gRvOz12BTHAn+bCZBkVWcQMyre0iWoJ
	qPeyMfc4xnoKylUMUNiv4tziid9X+KFb8sUbch/HdejBvk62kP5df7pW/xtQyI3BIsE+Elk6+ZJ
	wwBh/ew==
X-Google-Smtp-Source: AGHT+IGqgycsnZKrksHy4v4iYMpl2ufouZips63Cp16d5p+/jtwg0UiMEdUsO1fDqochqw+p2D+Qij9DCsMk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b83:b0:620:32ea:e1d4 with SMTP
 id 00721157ae682-6f27a84e636mr66297b3.0.1734123885537; Fri, 13 Dec 2024
 13:04:45 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:23 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 6/8] perf maps: Avoid UB passing NULL to bsearch
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If maps_by_address is NULL it is UB to pass it to bsearch, and will
trigger ubsan, even if the nr_maps is 0.

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 432399cbe5dd..1830ae776052 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1042,10 +1042,13 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	while (!done) {
 		down_read(maps__lock(maps));
 		if (maps__maps_by_address_sorted(maps)) {
-			struct map **mapp =
-				bsearch(&ip, maps__maps_by_address(maps), maps__nr_maps(maps),
-					sizeof(*mapp), map__addr_cmp);
+			struct map **mapp = NULL;
 
+			if (maps__maps_by_address(maps)) {
+				mapp = bsearch(&ip, maps__maps_by_address(maps),
+					       maps__nr_maps(maps), sizeof(*mapp),
+					       map__addr_cmp);
+			}
 			if (mapp)
 				result = map__get(*mapp);
 			done = true;
-- 
2.47.1.613.gc27f4b7a9f-goog

