Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD591B86D6
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290786; cv=none; b=aSs8DENAfLAcV4jfFtk9C/najbbfFGadzdSVKb/UHuSdp/lYIXSEE3TOTFv4j+NHwjn06G7md3l6Ik8XqlOsfBz1leVly89toPNHaSLxQ6zuU/juAHf6cs31rr5gd00rZbO4poe6xWcPORTH7WYMFOnB5aflyteTnNmsQxcY+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290786; c=relaxed/simple;
	bh=EeQeYK+x64OXkhmMGTFuYNlDUaC+XK0yykrV4HcmysA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=iVg/5bDfcZY1EFR+wGYJ3m0xj5g6rZCK7H0DbCBgKQtVr9woJR1rFJGQlMee8FZ+MdxWW4usOMQ0Fh8WA87DjGK9RFeXrg8kW04AGJy0LABtm/hyHMmLY1jYmVIj8MkQgpOUtp6eqIb66csLN4osbkSg3YOpekF5AF5xbR0eTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8hz7dZA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8hz7dZA"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6506bfeaf64so67287937b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722290783; x=1722895583; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4C+fPzygUAiWhfLZfE/xPC2ysJ0EaSf4F96gDN4Sp0=;
        b=Z8hz7dZADzNey7mEqI/Fpxsv2XV0QjVNJ6SUzx8hEnh70lmeJKZ7MZ9SpZ/s4WhQqS
         UJe4+sp0mNbBS4mXL20YIgJBtDXJOMUOKM+ZLEkkm9rIDcSZ+1gNasGVWbbI31m2rb/H
         2z8LE6EDjlkPnSQW/lpl9TEpr/5Ogdp1MmepPlOHsIQEYvWY6L3geBSYo+B46YROGtNq
         JIUbApuG4+iJTzCF/0D1wKgluAa9pgdM6KlcGxY8qG9Qm7RB71nQnOB1gHdJclDUP+mD
         F5hLZSmzErFvFJ870C4r5IV3k7DcJl53o+3/QeD7bWDhlyVWxo/epswWH4QAyCKhCHRJ
         JPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290783; x=1722895583;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4C+fPzygUAiWhfLZfE/xPC2ysJ0EaSf4F96gDN4Sp0=;
        b=CjU1XYxPxnfjA3mckbm1frsI+lVoRz1x/VbpJmGNw/eChD99vp1nYyYvfCxFIV8oLu
         NYVqDoWVo1pFtAwZBj5Il3Z2LrIn2a9LUoxmPgZSLsoslbmWSkMeyClEMhBGRC6wYFzg
         agHI6zEWIPAqiCt9FzpaJUqx1COfiYSoYm0tXkVi+GiDKcVAvAgQKLZocXsYv73E4Q0w
         zhv5MVxDyov76NuDqRsIC8sFqpWdJD17TNDGd7OTMi1dNCDaB2PSjw+aG2Fiao2ReLsa
         hwnHg+LAbfX3Tm1g2ommgvI3OjkKjOqNew5hAROqssg+qQkAEd2mkdpdr3IPXEqAY+TT
         +J7g==
X-Forwarded-Encrypted: i=1; AJvYcCUpeudmtOmwcyQ87xHXlGypb0cAMRxV2zthScDooVyuUfJLJvrFSe4d0lmXgW3YbRrxb70ipzqzYUKnQkZxIdZOr4VKt15mwrCRqq5ZNWGW0Q==
X-Gm-Message-State: AOJu0YwUeNzA4ogFJoirDmtBQF/njaYoVFIJE6soYs2/Jmj6xR8Edfei
	J1PzfcykYSLwwPuFUU0bU8qvPa9OaGYOPXWSDGOKKK97hnq/6V+ULH/NsWfniaeGoO9AQSIMbGH
	qqqkWRg==
X-Google-Smtp-Source: AGHT+IHUfVZDhR9sNayBuvkNVMU2Wg5cyT0rDNgLTynhCATmluyf/2EVBs4/9fcA1k5lBhJ2AVLIx6Yqij0Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3776:680e:8cce:4b93])
 (user=irogers job=sendgmr) by 2002:a05:6902:729:b0:e03:c033:1ce3 with SMTP id
 3f1490d57ef6-e0b5443f94fmr585990276.4.1722290783537; Mon, 29 Jul 2024
 15:06:23 -0700 (PDT)
Date: Mon, 29 Jul 2024 15:06:20 -0700
Message-Id: <20240729220620.2957754-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Subject: [PATCH v1] perf inject: Fix leader sampling inserting additional samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

The processing of leader samples would turn an individual sample with
a group of read values into multiple samples. Perf inject would pass
through the additional samples increasing the output data file size:

```
$ perf record -g -e "{instructions,cycles}:S" -o perf.orig.data true
$ perf script -D -i perf.orig.data | sed -e 's/perf.orig.data/perf.data/g' > orig.txt
$ perf inject -i perf.orig.data -o perf.new.data
$ perf script -D -i perf.new.data | sed -e 's/perf.new.data/perf.data/g' > new.txt
$ diff -u orig.txt new.txt
--- orig.txt    2024-07-29 14:29:40.606576769 -0700
+++ new.txt     2024-07-29 14:30:04.142737434 -0700
...
-0xc550@perf.data [0x30]: event: 3
+0xc550@perf.data [0xd0]: event: 9
+.
+. ... raw event: size 208 bytes
+.  0000:  09 00 00 00 01 00 d0 00 fc 72 01 86 ff ff ff ff  .........r......
+.  0010:  74 7d 2c 00 74 7d 2c 00 fb c3 79 f9 ba d5 05 00  t},.t},...y.....
+.  0020:  e6 cb 1a 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
+.  0030:  02 00 00 00 00 00 00 00 76 01 00 00 00 00 00 00  ........v.......
+.  0040:  e6 cb 1a 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+.  0050:  62 18 00 00 00 00 00 00 f6 cb 1a 00 00 00 00 00  b...............
+.  0060:  00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00  ................
+.  0070:  80 ff ff ff ff ff ff ff fc 72 01 86 ff ff ff ff  .........r......
+.  0080:  f3 0e 6e 85 ff ff ff ff 0c cb 7f 85 ff ff ff ff  ..n.............
+.  0090:  bc f2 87 85 ff ff ff ff 44 af 7f 85 ff ff ff ff  ........D.......
+.  00a0:  bd be 7f 85 ff ff ff ff 26 d0 7f 85 ff ff ff ff  ........&.......
+.  00b0:  6d a4 ff 85 ff ff ff ff ea 00 20 86 ff ff ff ff  m......... .....
+.  00c0:  00 fe ff ff ff ff ff ff 57 14 4f 43 fc 7e 00 00  ........W.OC.~..
+
+1642373909693435 0xc550 [0xd0]: PERF_RECORD_SAMPLE(IP, 0x1): 2915700/2915700: 0xffffffff860172fc period: 1 addr: 0
+... FP chain: nr:12
+.....  0: ffffffffffffff80
+.....  1: ffffffff860172fc
+.....  2: ffffffff856e0ef3
+.....  3: ffffffff857fcb0c
+.....  4: ffffffff8587f2bc
+.....  5: ffffffff857faf44
+.....  6: ffffffff857fbebd
+.....  7: ffffffff857fd026
+.....  8: ffffffff85ffa46d
+.....  9: ffffffff862000ea
+..... 10: fffffffffffffe00
+..... 11: 00007efc434f1457
+... sample_read:
+.... group nr 2
+..... id 00000000001acbe6, value 0000000000000176, lost 0
+..... id 00000000001acbf6, value 0000000000001862, lost 0
+
+0xc620@perf.data [0x30]: event: 3
...
```

This behavior is incorrect as in the case above perf inject should
have done nothing. Fix this behavior by disabling separating samples
for a tool that requests it. Only request this for `perf inject` so as
to not affect other perf tools. With the patch and the test above
there are no differences between the orig.txt and new.txt.

Fixes: e4caec0d1af3 ("perf evsel: Add PERF_SAMPLE_READ sample related processing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 1 +
 tools/perf/util/session.c   | 3 +++
 tools/perf/util/tool.h      | 1 +
 3 files changed, 5 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a212678d47be..c80fb0f60e61 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2204,6 +2204,7 @@ int cmd_inject(int argc, const char **argv)
 			.finished_init	= perf_event__repipe_op2_synth,
 			.compressed	= perf_event__repipe_op4_synth,
 			.auxtrace	= perf_event__repipe_auxtrace,
+			.dont_split_sample_group = true,
 		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5596bed1b8c8..080242c69196 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1511,6 +1511,9 @@ static int deliver_sample_group(struct evlist *evlist,
 	int ret = -EINVAL;
 	struct sample_read_value *v = sample->read.group.values;
 
+	if (tool->dont_split_sample_group)
+		return deliver_sample_value(evlist, tool, event, sample, v, machine);
+
 	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
 		ret = deliver_sample_value(evlist, tool, event, sample, v,
 					   machine);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index c957fb849ac6..62bbc9cec151 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -85,6 +85,7 @@ struct perf_tool {
 	bool		namespace_events;
 	bool		cgroup_events;
 	bool		no_warn;
+	bool		dont_split_sample_group;
 	enum show_feature_header show_feat_hdr;
 };
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

