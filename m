Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DE5013D6
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602264; cv=none; b=dN5iFMIdb0+i8F+M7nQSy+F8lsgRH2XD30nXpXe9i/R/fIZetphAnc5heB30FlKC4u3sFjqvr1qlWbeOQ+ifSDwuRcQ3rYTcSdZsWNx+wP5Ql4bTimQfmEnkWThEGo2X8HB+uq3BfMxVIjaNXi887gPB/ghys/+CaFTApYA+HXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602264; c=relaxed/simple;
	bh=jeEJpcUOnMW1H6iQsMNBSRPc1DiwXIDweaguQDaQWkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q4Q8+OdZbcdl+N4YlzquMNAF9sypSOJMtb0aDRiweXzh2y9MhFCYoPErpfYWoFG+HtLtZdwxjZaa4Xc8hORujqj8BKYqDHYRmgstMnU2LCvCq9nbyCsTCXXpY/0fOtW0zd3QvPJ1nA8IR3jTd1XdX3afA/qHnP0JHAMHTiIyam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWBKjFJu; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWBKjFJu"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so497846a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602261; x=1790207061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Juznuv85kRzuednz/BkmExb07fgMhpHO/r2YE0AU9aA=;
        b=vWBKjFJudfRw7A2p+0nHk/bCpqH4l4+T8oj/cp16S6aO7SqI/wcplnQbyTFJ4BvJp2
         EYw08kK6NyCPOcfqog0kdzodi6nMw7IYUbzXPN5r5F0vw8/GsggsOzLZgo8GP2LIBReZ
         x+ZrEeuid8QTXfnIMHB+lkH9FVnacdR7rKPuLUZFG9BVc0aPDXcvQc6YXS+sN51Xxkza
         wfXTcUjkpTHqE5HqvqqRjKmvv7XSyKZhgtCfMT3G9yI39Wt8UnLU+2PsGTVo/O9J8UIf
         J0nBh7217gHHxC2BblXKI5yjantSJ3FEV5Zmr8R7wSSB6kycz8jI3kUbUDC+c2atGn06
         Ahgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602261; x=1790207061;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Juznuv85kRzuednz/BkmExb07fgMhpHO/r2YE0AU9aA=;
        b=R77eU6bzvcODAYQDwg0JDSNNUtOzo6JQVSgM4NrfEWdpMHpWpyt0Saye6qDzDdGGBt
         gX6585ZaGaACJGrpnxQNx+Zzl0Rwb+ASDLa4GmQUP/HyRO2IPVl7gQ4FuyABnw79fXE4
         oIoZdRaOsSzfE+rI0gd9p6HkMqpdDXblyJnZ6PkNJvJUTpcOTjgiZHmifL8ELRJMOkXb
         +S9bQQQd8+1/gm/DR7LducvPJeX/Qx4CojfqrS7oEHmxgR4RCvnK3wAMEr7SxdHbOvwQ
         8oG8V7xnHvxSBAUMGnKSKnndaG3DajFOPDeG8Mwx82Lit4WrlJtDFR1hsOJZKCF8kCoi
         1qkw==
X-Forwarded-Encrypted: i=1; AKwUvBxelu9iwlpNkaCFA8Zc/N9YwHoGUn4bGY19CiBLMEkEyAlPZgBCRraZf9L8946Jiht7lpuBBjT/7atbxt5XTJl8@vger.kernel.org
X-Gm-Message-State: AFuF++ldtMZGHpyTdeL4CDbyt7YsDFXz1QoXrHthZGfUDY7KNnolS7uK
	80FQWo0t3qehDsqK+7ZFNLHle80TqnrYxx5Kulsq4tBVEpYPYuTPlGs2IGvzq+xJPZpHapPituX
	bOJynwyLRHA==
X-Received: from dlbvv15.prod.google.com ([2002:a05:7022:5f0f:b0:143:7a1a:167d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5108:b0:39d:b769:3067
 with SMTP id 98e67ed59e1d1-39e1df6154emr9932917a91.0.1789602260835; Wed, 16
 Sep 2026 16:44:20 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:44:02 -0700
In-Reply-To: <20260916234402.437113-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916063545.3103314-1-irogers@google.com> <20260916234402.437113-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234402.437113-4-irogers@google.com>
Subject: [PATCH v3 3/3] perf libbfd: Report success when an address is found
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

libbfd__addr2line() only reports success when the caller asked for a file
name. addr2inlines() passes a NULL file as it just wants the inline_node
populating, so libbfd__addr2line() returns 0 for it unless
bfd_find_inliner_info() happened to find an inline frame. addr2line() in
srcline.c treats 0 as a failure and tries the next addr2line
implementation, which appends its own frames to the inline_node libbfd
already appended to. Every frame that isn't inlined is then reported
twice, which happens by default when perf is built with libbfd but
without libdw as the fallback order is then libbfd followed by the
addr2line command:

  $ perf record --call-graph dwarf -- perf test -w inlineloop 1
  $ perf script --fields +srcline
  ...
	    56051a994f8e parent+0x2e (perf)
    inlineloop.c:32
	    56051a99503a inlineloop+0x8a (perf)
    inlineloop.c:47
	    56051a99503a inlineloop+0x8a (perf)
    inlineloop.c:47
	    56051a95841a cmd_test+0xb7a (perf)
    ??:0
	    56051a95841a cmd_test+0xb7a (perf)
    ??:0
  ...

Report success whenever the address is found, like libdw__addr2line()
does, and clear the frames appended so far when appending fails so that a
following implementation starts from an empty node.

Fixes: 257046a36750 ("perf srcline: Fallback between addr2line implementations")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/libbfd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index d87242d88525..a907d7c1ac94 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -287,6 +287,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 		int cnt = 0;
 
 		if (node && inline_list__append_dso_a2l(dso, node, sym)) {
+			inline_node__clear_frames(node);
 			ret = 0;
 			goto out;
 		}
@@ -300,23 +301,32 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
 			if (node != NULL) {
 				if (inline_list__append_dso_a2l(dso, node, sym)) {
+					inline_node__clear_frames(node);
 					ret = 0;
 					goto out;
 				}
-				// found at least one inline frame
-				ret = 1;
 			}
 		}
 	}
 
 	if (file) {
 		*file = a2l->filename ? strdup(a2l->filename) : NULL;
-		ret = *file ? 1 : 0;
+		if (!*file) {
+			/* Leave ret as 0 so that another addr2line is tried. */
+			goto out;
+		}
 	}
 
 	if (line)
 		*line = a2l->line;
 
+	/*
+	 * The address was found, report success so that the caller doesn't try
+	 * another addr2line implementation that would append the inline frames
+	 * above a second time.
+	 */
+	ret = 1;
+
 out:
 	mutex_unlock(dso__lock(dso));
 	return ret;
-- 
2.55.0.1082.g2b9226bbc0-goog

