Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFns5eF/"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9325C26A9
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:18:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3a1e5f8d6so1792167b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911929; x=1702516729; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpIxg4nqFiCoM7pb7LX1eOoCjvBevBq2O8IO0Pdf/d8=;
        b=zFns5eF/J7nWm3yb3m0c7b7QTNuhSpntBvAZhyVKMBGL/6KrZkX6K3Fih1hykC7T8+
         OstSZNXAMN2DDtkYIhizIGX7EyCj7Qnp3MW27OHT+mTgEK1rIUYvnRuldS3lL0kmU8gZ
         Fygrs5SltVxomP3tPBu2Icu0FlPBgsJsIU/iv9f28yN+Oq537Xm5T1WsXaOkRSAJ1zyX
         lxsLKwy/mNsRcDYB9VLG1uHuh3eXQFwoCm24WLditXnvztm+nuN5VkwvclBl67KCarPc
         qX3eX1A185fxBYZT1xf/5ieBfxAsq24Mdp40acCm+QK5sfJzbmXMHa8cHBt2wyta4FPu
         bNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911929; x=1702516729;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpIxg4nqFiCoM7pb7LX1eOoCjvBevBq2O8IO0Pdf/d8=;
        b=CEtHyd4IvfxCcAjEw+3iWgCv6W9pU0y+hShqSZSKs6VeDyDtVVz3uBAB+hVsnxOREv
         Cp3h3sBK8DFB2u6t6/AO75ZIK+rAZe5wOUuaNW6arVamAxW32/zWkv6NNZGAfjbEkYHW
         8XooqYPYChBVKKMXbLIXUu2laSrwtgSZvqf3AS1JrUva5k1StHZmQj3rOlkkwvzZzyGZ
         LxUFsPFwqgD1YAG4cEeDBOdCnRqXFFJQdKZra18kj5UKUJL522DX7wfcQHQ8ZkfCLIIK
         lzIh+R+UjQl9CTkAf2Xuz5qwLTi03PwGyYEhMZ5IZuvHpkbV5ZPC0s0NzUAYBpC9AsQj
         Gh1g==
X-Gm-Message-State: AOJu0Ywx5AO6QGvtDa7lFOrISh4FmJN94w84chO/eDr4K3WN2PYbRNlh
	puk6PnTexIh1dK+Sih9ozrP4P2rpQqJT
X-Google-Smtp-Source: AGHT+IGtbxDmn4dp4bvZz8MF8EKrsVbUvpFnaIZDxuseidIJVznot8lanb2j5lGnira4v+d8lCr0BOKV5s+J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:af28:0:b0:5d8:eec5:f57c with SMTP id
 n40-20020a81af28000000b005d8eec5f57cmr28157ywh.4.1701911928989; Wed, 06 Dec
 2023 17:18:48 -0800 (PST)
Date: Wed,  6 Dec 2023 17:17:09 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-36-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 35/47] perf threads: Reduce table size from 256 to 8
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

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.43.0.rc2.451.g8631bc7472-goog

