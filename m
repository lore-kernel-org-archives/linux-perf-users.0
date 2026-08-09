Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CE3AB5CA
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259714; cv=none; b=BMvahEIA7CcMB42TazDkFgRnyoHIKGFgBsk4PCIetXUytVN52zNbUJrtXd9vElLaw7Xqcs1ss3vsc/RnxO/cEhVfz3jNWpx1NG1GwpHiB2KvlKOJ/BxGEuE7A5lUPYjEE8/6U+5BA3ryu186kUaZmwkfDPaUCJEdVPfkJ4YPtZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259714; c=relaxed/simple;
	bh=VjEx0Rc8kSYoI06IJ52/Wy0QYVQQ/E0WJX0p4fzuaIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dISVOxxvHP8uVKXUM8E9lbrHmP/NoL7xMmnHT9/ssu89VElPdDoRDYudSrXbJj93GFGEpwFpiUiMDGzS7YqCawL27af9GcrK2ZK1pXSrf4p2tsyoHbrLhFG5gRbTmGGImXeKXZI+VsrvVlQ/BuoDv/F85EyW8dWmx6KT+VIHM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syLDhGij; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syLDhGij"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so1136402a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259712; x=1786864512; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPYjLCjJI30RI52LUn8RaWVxhtcmVMJzJLmM3HtSGHM=;
        b=syLDhGij3ZG8fAeSQwyV8V6Vo0mO7tjhtsMoYzTRk/Um/nlR0yUtpo9b4Qjayuh+XF
         sPvPZi16Xe96dGJ7dGngpEuXU5iLWmqNsMdtty79OlC5PGzs5KG1yltq7DkAtGFo9wM1
         EfMknM65YjPtbIPQGwq3v6k6WyEMSIA4/S2XXtWwnnb/Rl3cmL5pGkZC73uSGx2jUDr9
         5cEuPrnqw727T0z5wulMYFPZ9DCzi1DYqkCRtXHSdQKRWz3620K7oaejYvRnshahr/vE
         IXIE+LAnrxvCkS2H3NGBepOgKEjgidfjJkhGyUZ5bs3oa+8O5PcDqZzS4vvzmkMbm3AV
         QXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259712; x=1786864512;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jPYjLCjJI30RI52LUn8RaWVxhtcmVMJzJLmM3HtSGHM=;
        b=FUPqrGzZk0GuCUfKfyqlNPJlPpsVBohiKzlfocVk6rCuz2Cx0rnzhqPa28+iYzff2H
         W5Ah3aqEQUFYbFbCC5hbX04Ryegr3hvYl7g1zHTSLeBMpLeyzOdLH2kihUD2xBWLKhcy
         b+RhSUjynv3uEvR0/hyfBQ6bqbnftjHXaduK+/puh0Ljmkiw8a3117NN3JMryF4JIxKd
         seeBmBzif7V5B3CVMJQXBPrq8JaFtRbQGM6IZWQ6mDfDHyhCCsvLfqfbMzhJuf9gTbFE
         plMDjTqqKYdHEXBwk8rW0VsWsTz6gw/9a6XUkN2EbbJTBOSyryL6IIyXdrVzXUmZWdMj
         ZGQg==
X-Forwarded-Encrypted: i=1; AHgh+RoBKWq0psfVVYdSiR4GZmMWOvN6tFQT42XK6t49qjV0nAkOecB9Ab0OJXR2Tk/mEtxg+rlLC6vusbl3yZPkF4S6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1nUr3ULiysCxWw5tJ+EL3BO2J69w8LUMkWCNVAtKOEEnrsiG4
	MPDqaKkYbeRrqfzL3OpvxTcIIholLojsEpfmA1BMpb6nPqv4DKamnEd/vd8xtVYYWxpNeefCg38
	SmBIhRauzFw==
X-Received: from dli20-n1.prod.google.com ([2002:a05:7022:294:10b0:13b:97f1:acba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:164a:b0:3c3:a08d:5b44
 with SMTP id adf61e73a8af0-3cb85ef9234mr41982540637.23.1786259711901; Sun, 09
 Aug 2026 00:15:11 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:44 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-6-irogers@google.com>
Subject: [PATCH v3 05/15] perf synthetic-events: Fix uninitialized pthread_join
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In perf_event__synthesize_threads(), fix an uninitialized pthread_join()
call when thread creation fails by only joining the successfully
created threads.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 340b47f510bb ("perf top: Implement multithreading for perf_event__synthesize_threads")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 75a32ae8ef62..3583a60cc487 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1221,8 +1221,8 @@ int perf_event__synthesize_threads(const struct perf_tool *tool,
 	}
 	err = 0;
 out_join:
-	for (i = 0; i < thread_nr; i++)
-		pthread_join(synthesize_threads[i], NULL);
+	for (j = 0; j < i; j++)
+		pthread_join(synthesize_threads[j], NULL);
 	free(args);
 free_threads:
 	free(synthesize_threads);
-- 
2.55.0.679.g6767b8d81c-goog

