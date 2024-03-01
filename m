Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED154794
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271430; cv=none; b=N5CbNza2diOe2EUYzl5cyxpkE33Q44VXgqbxu+WW+Uu7Z68cUlSaoST2RQdiQbrZgTKJyIei41/KaNddxDMqzszydyXsVct0gL7U6J+7Axshw2xYYTGdfB5L/IleYlhd8UCKRwZNZFMUOkf3R4N67jLAbDe09FX28MNZAgPbl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271430; c=relaxed/simple;
	bh=GIegngHqtLjHARUsBjYE1nUvvYzurvCdwBU55T25Zws=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tfJmZsougO3t0uGs7ymIe4kf0sHMfA1TuD4Ymg/grxcW03l2htl1RxGlZ+z2Sf2byy2lywubZ3/TMoa9PtQXsfGzHF8ZF3mwDcj47+lUqRDya0Ds7v9yjnOliQM73t/9zWC1El7+ECcONOG1R0+eoA2+F9tqRgWwNdmp4ilGG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQLSYKDJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQLSYKDJ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6087ffdac8cso26288757b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 21:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271427; x=1709876227; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3EeOnj2LJFuh4Gzgf1odB7yRFHxb61zXSqdlmTf/sY=;
        b=xQLSYKDJmoaE+yJNvdjYjShfCm7eK04b3GLGi2U3N5GvAS9YcB8vCk7OpmItFobhts
         195HdHsABF1tJrM4Bh1DlxbnjDClsKPi/EBzuwfmvOo2JpRXoF6pGIB1DgwxZ8eJJ0N7
         CklgfszI1bqzu19u3ftFqEZB1edr00ki94uK8WaTnVcVmj51booCGqpfjzrwLhF2pBsV
         xxgQT3Ip7mi5zeAtgP9o8sYqF6IvW8WEzWDWFd1HELnTgHOtJwA1HwMmfpY8gADj7T0P
         obIEV+00Ihr42PS5GNDphI2YNA+7meByKQ/Wc9Mn4APnr9JFJ0C44WW3hlikRxzXIPSF
         DmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271427; x=1709876227;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3EeOnj2LJFuh4Gzgf1odB7yRFHxb61zXSqdlmTf/sY=;
        b=lS591ERA+Ai+Y8xQFL60jipopKOCxwptuw98wE1z4sV3IP/zsrp2+Y1WAVH9tT9xSt
         q7JFvmAsdk/FaSMSLP/HA5shONldEM69eP1Fc1XRZQTD8vPF0F6jyoKeaXFCtWC4tIjA
         nc9ntntnJjJvXVckpAQy7j+awtrKMMzP9XrZBJ7/xo+/SdQ7yrVz4G8qGPkvCCidXjlV
         QAvZXLz76FM7cQyWfErWV8Y+ZgmdwwvCEuwgACmTkREhYVkioE3V41tl1gei3K8ybD3U
         8TwRk9NBRgb8HWXNlHlwpMQ4CJFvK9BG11wVNzdz7PSeAakKzHw8qRCBEb8KViURYrT+
         OzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVek3pPgZe7RPq6oPtBXZXSF8tb1tgxmWYv/f3POIZbOs27hoN1yPGDvUxRNgQwSqDeOoFBFPi48LG+65A+GwTpj21oghUAeDHJkBhiaQWjwQ==
X-Gm-Message-State: AOJu0YwVa1EyGYF/fdpN9UX78sisTx2GimSBC7+ZSycJWLhd9huBVnrR
	OUJFy63pTDRQ28Fj3Fv+PdLt1gSgAOJ5aAJhFewDddi0CoHOkRvuxmPF9YcFLj3IhkByPch9LJA
	syXaG9w==
X-Google-Smtp-Source: AGHT+IEu09qcHpz8XVF0bJYUs01j219s9OVd3W8pW3osKdThUV9pFvDfs+miQGs9atOQylZEGB8D3SP3TfJK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:72f:b0:dc7:68b5:4f3d with SMTP id
 l15-20020a056902072f00b00dc768b54f3dmr130791ybt.11.1709271427758; Thu, 29 Feb
 2024 21:37:07 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:45 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 7/7] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.44.0.278.ge034bb2e1d-goog

