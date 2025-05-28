Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB61FF1D8
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402816; cv=none; b=V1FlCRJfiHyvzx712Zw/OFTszUxOuSxijDJrXvzNMOmISpMLMyThDAOCTMqKvNe78LxYvc3kcELqJVYLTV/EP92kHwkNClI6WRk3VcmyeUlwfkf7LUEq95lg7/esk5JQCN8+A4zLssQineLdAy+S3w6mOUyDbsEITxbDrCMav5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402816; c=relaxed/simple;
	bh=yDdkDVXJa4LAtUyk9Bgo06vGKbsrt3gQVFGfh0+Q7BY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UvTc/Kl95zNf45/IA4YCKlOjvX5/gUD3Ln2Yo0p6a1tNXbKZsoF8h/TptMM8MNt5jFlmQoJy5vZGmCtkL992KKppQaFvQsxOy8t21sUx1VxIiR+OMmKuRDM2gb0jaKR24rqBB5aJwwu47bYI7VzRSU1If/9hj3Y21QZucid52ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srvkSJ2P; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srvkSJ2P"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311d067b3faso1213913a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402815; x=1749007615; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OP73Bs+bCS0Lnt9HD+IXUqkNBcchfjlRThGQUgNgoPE=;
        b=srvkSJ2PnJ/TLx6Elmz8H8ATu/ClUVmrJkHZY1FndEu+KjbaNgVAsBGHvE17+TT3ka
         dfEhosodrtj4e//1PQSOgj4Emx4Dr7yP4JO6IxPU1TwCRogH8Rbkw85wC20uq13+MnNP
         aiDJvTGZYk8Ovb/+moRbL/Fqxc5tvN/9qQbBBkV2/kpVg8HtoVHZe0D8jhgVTAT0EUfz
         XA75bxm7OakOZgeG+YIRFSYIhRQ/mbTh0WywEKhfLuLMP/IJK5L09qHmMAnMoZNzTJEd
         3yUvZF18VLfsY2tRQTcSzTCOmzNKRXibStzOyg7kj3qfU+GwmslgxOI1tZojvsm6GA/I
         idlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402815; x=1749007615;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OP73Bs+bCS0Lnt9HD+IXUqkNBcchfjlRThGQUgNgoPE=;
        b=ceiIti/7Umqu7SzFtaNuCw+Z/Mv5r6PWtjzD6QrJ2TFq6XrOteufL521zikN3gpm1s
         5RvkRgOvNEYa/xiOInLksfWU+ME77OocQvSZspUgnVpfInyBeSZ+foD/9HUBIUTj7tTo
         vQXaH4pf/eHH4ibX30Eaj/s82QMsIMNycw0bJfe7j1K8picNAoKhReSzCf8K9iaWLyld
         D9nUfExF1+dgncehUvx4yoJAedusu8Cv65wJ93E4ZPTZsnt0gVxtpK+7hxhWWc8OuXrq
         cJoN2HImfU58xIbjRP7qwNicKxC65qFbCdSSvK2z2H3eitRvbY23Z33UEWQCcWg3xsqd
         j/aA==
X-Forwarded-Encrypted: i=1; AJvYcCU0PNAtMLKKIFfO8nJpQgm5wFEEEpq3eWEUXXlDbIyTP/uKGoTNuzs/Btdp4t5DHoGbvEjd0nUjuLeGGGrvUrP+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8RHMc+/Wb4n2sjf4lkMMu5q5xqtrRJEzEIqgOr5SgALiq+0Io
	3vKAK2hamSFge40gSdLZvvul7M3jPRUBVbtW/+0K0sTvCNdxuOTDFYHcxodEbaYisEnwJw78TnJ
	yRpnzrasaMQ==
X-Google-Smtp-Source: AGHT+IHPzrydUxK+ONtesAiJ6lgu3uQKUAWeAXS6Dib84yogrTnHecMR8fxJOe+5D6+8+kKKgJB7wuHFxOj2
X-Received: from plbkm14.prod.google.com ([2002:a17:903:27ce:b0:234:bcd2:f39b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf42:b0:224:c76:5e57
 with SMTP id d9443c01a7336-23414feaadcmr247729375ad.39.1748402814817; Tue, 27
 May 2025 20:26:54 -0700 (PDT)
Date: Tue, 27 May 2025 20:26:37 -0700
In-Reply-To: <20250528032637.198960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250528032637.198960-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250528032637.198960-8-irogers@google.com>
Subject: [PATCH v2 7/7] perf thread: Avoid recursively taking thread__comm_lock
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix cases where functions that take thread_comm_lcok were called
holding thread__comm_lock. This created some buggy behavior in perf
top when built with sanitizers. Ensure -Wthread-safety warnings for
clang work.

Fixes: 8f454c95817d ("perf thread: Ensure comm_lock held for comm_list")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c202b98b36c2..f4ad15e1e314 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -201,13 +201,21 @@ int thread__set_namespaces(struct thread *thread, u64 timestamp,
 	return ret;
 }
 
+static struct comm *__thread__comm(struct thread *thread)
+	SHARED_LOCKS_REQUIRED(thread__comm_lock(thread))
+{
+	if (list_empty(thread__comm_list(thread)))
+		return NULL;
+
+	return list_first_entry(thread__comm_list(thread), struct comm, list);
+}
+
 struct comm *thread__comm(struct thread *thread)
 {
 	struct comm *res = NULL;
 
 	down_read(thread__comm_lock(thread));
-	if (!list_empty(thread__comm_list(thread)))
-		res = list_first_entry(thread__comm_list(thread), struct comm, list);
+	res = __thread__comm(thread);
 	up_read(thread__comm_lock(thread));
 	return res;
 }
@@ -243,7 +251,7 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
 				u64 timestamp, bool exec)
 	EXCLUSIVE_LOCKS_REQUIRED(thread__comm_lock(thread))
 {
-	struct comm *new, *curr = thread__comm(thread);
+	struct comm *new, *curr = __thread__comm(thread);
 
 	/* Override the default :tid entry */
 	if (!thread__comm_set(thread)) {
@@ -294,8 +302,9 @@ int thread__set_comm_from_proc(struct thread *thread)
 }
 
 static const char *__thread__comm_str(struct thread *thread)
+	SHARED_LOCKS_REQUIRED(thread__comm_lock(thread))
 {
-	const struct comm *comm = thread__comm(thread);
+	const struct comm *comm = __thread__comm(thread);
 
 	if (!comm)
 		return NULL;
-- 
2.49.0.1238.gf8c92423fb-goog

