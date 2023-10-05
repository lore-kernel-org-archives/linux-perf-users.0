Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B5436B4
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHb1fH5j"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9211A
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 16:09:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a4f656f751so23141517b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547346; x=1697152146; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDPuyVd3XTrJMjMwlPDdlF9+59DlOSoA2gz1djDjGjM=;
        b=QHb1fH5jZfpq8RyeS/YaV/fetq7213oKI3Glm+P5Tv0brElakNGE0zusBc1IqtkzHS
         F3cE0t+BdUKNRsfu4cOXwERujggbR3NbvxMMcWltEgnL7eyCws5CIP/V/GXYEIinNH++
         cFxdCofmm6ACZ3U7t5n0pC7GXLLtCfcaLa9bwh0z6g4tF0bsVEVy4oUiAfiHjllUhIWT
         MynrYEVVosmuvb9Cc/SL22cUvJGFQuRu4kVtwnTtHBYNhkvXxDIKvrxiRIczfjwbJuq7
         oHi2F4cmXpeU38AyWzqrmnv0SmctqOZYMnwGIDuFsCOKFkiJK9WpAfLQ0PmMeOUyCSCc
         fYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547346; x=1697152146;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDPuyVd3XTrJMjMwlPDdlF9+59DlOSoA2gz1djDjGjM=;
        b=JcMw0qOJtUZhWg9NTyR0GoafGdcMUkoa+o1iS4XTVZSL7KSNcriB28I2jAoWek+3jb
         RlNl53Ut8vy67ZgSbrRNmSZL1/qmIVQQ7i3aJPeQbmOEKTGlCphvhUDli14d+y5el0Jj
         qFGp2PnsELDwlzge5zQN/7jHYqolHk7z3m2t4sMUU0JHcxhagA8oxvKqZ/oOfAnsPrIU
         o/7gwzpjfbsLJW0s0hWy6WUMydJBgCdGUKjYp5EyxNxMT0LlEC2dOHXnyO7eO7Zr3Zns
         7BLLs9rIx7hpGP80VK4Nq4EE0d0r5q5n4y6YtONrOBgUnXKTyRkCYOoQIO6g36NCCiZW
         Yjrg==
X-Gm-Message-State: AOJu0Yya/zpHiEm11XsutpNMACGunDgm/vdWiuJWF+gcn5250GMYTFeP
	uE+P0l/iYs3NuX2VWAAVIjRukdnlsRoP
X-Google-Smtp-Source: AGHT+IFQDjjuJ9i5zSFcUSzRWjUMmm/ajUwJIkmJtY7wD6WB6BJUTaAn4xhEtzWUY7ES/84RgxbXsLDpBnQp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a05:690c:3146:b0:5a4:f657:3a95 with SMTP
 id fc6-20020a05690c314600b005a4f6573a95mr91738ywb.1.1696547346425; Thu, 05
 Oct 2023 16:09:06 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:37 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 04/18] perf hisi-ptt: Fix potential memory leak
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix clang-tidy found potential memory leak and unread value:
```
tools/perf/util/hisi-ptt.c:108:3: warning: Value stored to 'data_offset' is never read [clang-analyzer-deadcode.DeadStores]
                data_offset = 0;
                ^             ~
tools/perf/util/hisi-ptt.c:108:3: note: Value stored to 'data_offset' is never read
                data_offset = 0;
                ^             ~
tools/perf/util/hisi-ptt.c:112:12: warning: Potential leak of memory pointed to by 'data' [clang-analyzer-unix.Malloc]
                        return -errno;
                                ^
/usr/include/errno.h:38:18: note: expanded from macro 'errno'
                 ^
tools/perf/util/hisi-ptt.c:100:15: note: Memory is allocated
        void *data = malloc(size);
                     ^~~~~~~~~~~~
tools/perf/util/hisi-ptt.c:104:6: note: Assuming 'data' is non-null
        if (!data)
            ^~~~~
tools/perf/util/hisi-ptt.c:104:2: note: Taking false branch
        if (!data)
        ^
tools/perf/util/hisi-ptt.c:107:6: note: Assuming the condition is false
        if (perf_data__is_pipe(session->data)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/hisi-ptt.c:107:2: note: Taking false branch
        if (perf_data__is_pipe(session->data)) {
        ^
tools/perf/util/hisi-ptt.c:111:7: note: Assuming the condition is true
                if (data_offset == -1)
                    ^~~~~~~~~~~~~~~~~
tools/perf/util/hisi-ptt.c:111:3: note: Taking true branch
                if (data_offset == -1)
                ^
tools/perf/util/hisi-ptt.c:112:12: note: Potential leak of memory pointed to by 'data'
                        return -errno;
                                ^
/usr/include/errno.h:38:18: note: expanded from macro 'errno'
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hisi-ptt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index 45b614bb73bf..ea297329c526 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -98,18 +98,18 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
 	int fd = perf_data__fd(session->data);
 	int size = event->auxtrace.size;
 	void *data = malloc(size);
-	off_t data_offset;
 	int err;
 
 	if (!data)
 		return -errno;
 
-	if (perf_data__is_pipe(session->data)) {
-		data_offset = 0;
-	} else {
-		data_offset = lseek(fd, 0, SEEK_CUR);
-		if (data_offset == -1)
+	if (!perf_data__is_pipe(session->data)) {
+		off_t data_offset = lseek(fd, 0, SEEK_CUR);
+
+		if (data_offset == -1) {
+			free(data);
 			return -errno;
+		}
 	}
 
 	err = readn(fd, data, size);
-- 
2.42.0.609.gbb76f46606-goog

