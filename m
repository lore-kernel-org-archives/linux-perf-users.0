Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4eqo5IN"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1A1FEA
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:18:19 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d8da78a5fbso1682727b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911898; x=1702516698; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=080Vne9luGbMZqG9+uC+XiM2BHOgF/5Ti1/3JRRVPt4=;
        b=p4eqo5INaoPbamFeVR49NReo+CxMmLU6+CG2r0+wdu5piDGHizYYEydMgsHRprRqzk
         7cE6EhfJu3s0tPKjPHVl/ZuIfIkdCYHyXvZMshC0CobrumfOTBKVblmEfHQl88XgHdq0
         yk954OC3RXiFjUHqhm3DOlDF/qmBQIlLkvNoBbNT23D2fbA9qEP6de1JqiU2lvH1KuJx
         lAGFB8eZ3lhsYaLC0trDhYpO6akM+YDoeJkxH6X/2tv2RMiA2KLDZGzQ5zx9NJQwa1NZ
         DN9Or8a4R+/J1R1VPEcCxMe5tEOVhB+qm7u2toDmgt++f7527HXsYg7nQfiqp6AAGIkd
         f+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911898; x=1702516698;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=080Vne9luGbMZqG9+uC+XiM2BHOgF/5Ti1/3JRRVPt4=;
        b=JEbf9SH58NrISjp8+VNYRoJ8mDfo13AtoX+LRPhJV/ELJWOZnl23nXjF07DJD6DNXW
         JDnVUcj8N2S6IblYK3BN8doDYL7nM3IBN+ECty3N/ZotVmWkN11jZfKgNZxS3DbAg4kt
         FjTXXXPiZ5nHPHzZh2Nk7cgr4btSpvsNUOSoyTrL6Q/3nlRzuAkeVPd6UXttYtNTpbKa
         eY4aLyzZBnZI9Ou8p0MWtbTBenj+dpHD5iaRGLxjzxcNeqWe374+aMIDBGmHmcVWPc/5
         pYkYwn2d33qxLiI1uWCIQgxMKEiyZa1MpJsWR3E8mEYFv1Wo6plEm+huNPiP55hT5uhF
         HM2Q==
X-Gm-Message-State: AOJu0YxOaP1hS8gmVX25sIGRCPkVn01ethGqBtXC1DNqaqwTM+9d7U4x
	p5stGvqO+qpEFnLfRdCxVCTAoAY3tkZi
X-Google-Smtp-Source: AGHT+IF5aaRbwcv0XllHz91G60ZUSyZ9fr+69hP1CaRKexRfy4nKX+GDDlUbzuh4LVjq4Xl1k73n/zEbsEk3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:ad24:0:b0:5d9:20ac:5126 with SMTP id
 l36-20020a81ad24000000b005d920ac5126mr26333ywh.4.1701911898601; Wed, 06 Dec
 2023 17:18:18 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:56 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 22/47] perf maps: Fix up overlaps during fixup_end
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Maps are sometimes made overlapping, in particular kernel maps. If the
end of a map overlaps the start of the next, shorten the overlapping
map. This should remove potential non-determinism in maps__find, ie
finding maps by address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index dcd67384d877..0334fc18d9c6 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -701,7 +701,7 @@ void maps__fixup_end(struct maps *maps)
 	down_write(maps__lock(maps));
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !map__end(prev->map))
+		if (prev && (!map__end(prev->map) || map__end(prev->map) > map__start(curr->map)))
 			map__set_end(prev->map, map__start(curr->map));
 
 		prev = curr;
-- 
2.43.0.rc2.451.g8631bc7472-goog

