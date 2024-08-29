Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB11B3727
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943743; cv=none; b=G/ISaf3GXkKXHy1AXt3Ltyj0xnIl8vklt0NObSECFNt0JAyo727EC86LZBlVGGLktWs1pnzBvvHZKBd9oNhuBNmNZuurjXXOcywXb/vTFuUpPL0U8EFZS12ymejf2hOb5mMRLSt/8EPZEbej6OepS9weYJUtZPQq6xlY47wFaQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943743; c=relaxed/simple;
	bh=d8IwRgzU6IVwfT3fOB5yzVRUcKFqP32FXJTEN4UXaQc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l6L9Zwt41QqzBEr/w/xN32S8MzGx8WcTQFZkgTGnFu5s+jkEDzwmwJ4SR4GdUtZn64Co2LX0uA3VOvFplCIjPPjpOtdwBSVvG6iYcBaL2yr28GZsnEd9nGMLOcw0q73QhXdv2UHliXPgwHBErPs4fNoxogvU3TKqr3QINqppnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwdNzjPq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwdNzjPq"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e13c3dee397so1220971276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943741; x=1725548541; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhwOndd672eQTsmeiahQCx8DV4+qjBSQD+DApZqBRQc=;
        b=QwdNzjPqpbrbNICxGyTlinbTLreCGYfWMpx1B0vArbVMIhl+DaUlkcFasV3dUwHSC6
         w04dmyLmKD4jeDDYKWNGbcmeeIBJDe6TQDVZYfQNPgt0iSiRWKQtAJNnNrI76UVPF4DF
         RE4BSVqdEbYwoCEtEN4vgpfGfenkchXzt08WqyVVbnggpB4GHwxFQA1JbFCb0ftmYTxJ
         8O/vrgdwm4dttSYAW6ZTpMLEDoAwNDcGW8aStX+k8vhWLj8qG9GUm16c7jjyu8DVpC9g
         yCG1/IK7xkC7haPH0kseB3DYPAbp916onYlikpns2Pay9IqLylqHUgDY1cvnz3VMdPny
         n3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943741; x=1725548541;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhwOndd672eQTsmeiahQCx8DV4+qjBSQD+DApZqBRQc=;
        b=AupimIEeoyHQ12rvyI1L9D5Mjc/W6OK+ld8GqsjD+Wo+XNy+BN627touqrc/CZXVjk
         BreCp+5Clm9CQH8PyTJn332tZGeLlCA+r8P4uz/EaKM2vuAKgU08Bef0TVfMalmEVZ0V
         F2p5FMNF3fr4wnzHqjj1rbGIGiduA3ez1lDCJUzDnsmm4qE66PcNibFgWFMdR7XXA4Nm
         8ok4Xx1ewa7xzZbHsDz2wap31UquGJB9Pvw+yKWKH/taC+QvNdtJTc0Nsl56fSCIDdn9
         zRk5omoK3+l3LRteIZiGMSf4XFxH640Sfwjjc0pJ37fRR+kBpLjBERpR5z/BL7IAfjBI
         fHig==
X-Forwarded-Encrypted: i=1; AJvYcCXz0nOm5rOggwJlGo4XXxYa6kB1IU/Khx0ESOmI9UCHLdKYB72eH3YGetIqj9+soEVLCqLG2X3TV6DdLBaMOjH7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9COuoI8Ig2oHy0/kTxtxOCi/1pYTw7tM4bfMRxVR5ZupAU+hd
	6K0KiPsfNKVjvmKwDPAdeNpJtv1aRUHNGznBBwtTQO9EFuoWgbiCoxR3dK+gpahp1RR981jYeU1
	n/Z4gDQ==
X-Google-Smtp-Source: AGHT+IGanMcnYgYr5sBz7VZyu73qNQxkHIbx4GJrBetIEyCLMHA+YYkqVY2DAscY/rtVLupMJi2rIh4g1d8n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a25:7cc4:0:b0:e11:69f2:e39 with SMTP id
 3f1490d57ef6-e1a5adee523mr37264276.9.1724943740764; Thu, 29 Aug 2024 08:02:20
 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:50 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 4/8] perf header: Fail read if header sections overlap
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Buggy perf.data files can have the attributes and data
overlapping. For example, when processing pipe data the attributes
aren't known and so file offset header calculations can consider them
not present.  Later this can cause the attributes to overwrite the
data. This can be seen in:

```
$ perf record -o - true > a.data
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.059 MB - ]
$ perf inject -i a.data -o b.data
$ perf report --stats -i b.data
0x68 [0]: failed to process type: 510379 [Invalid argument]
Error:
failed to process sample
```

This change makes reading the corrupt file fail:

```
$ perf report --stats -i b.data
Perf file header corrupt: Attributes and data overlap
incompatible file format (rerun with -v to learn more)
```

Which is more informative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3309fe7f1d12..65c9086610cb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3986,6 +3986,24 @@ int perf_file_header__read(struct perf_file_header *header,
 			     adds_features));
 	}
 
+	if (header->size > header->attrs.offset) {
+		pr_err("Perf file header corrupt: header overlaps attrs\n");
+		return -1;
+	}
+
+	if (header->size > header->data.offset) {
+		pr_err("Perf file header corrupt: header overlaps data\n");
+		return -1;
+	}
+
+	if ((header->attrs.offset <= header->data.offset &&
+	     header->attrs.offset + header->attrs.size > header->data.offset) ||
+	    (header->attrs.offset > header->data.offset &&
+	     header->data.offset + header->data.size > header->attrs.offset)) {
+		pr_err("Perf file header corrupt: Attributes and data overlap\n");
+		return -1;
+	}
+
 	if (header->size != sizeof(*header)) {
 		/* Support the previous format */
 		if (header->size == offsetof(typeof(*header), adds_features))
-- 
2.46.0.295.g3b9ea8a38a-goog

