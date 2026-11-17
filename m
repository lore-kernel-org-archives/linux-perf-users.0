Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941357;
	b=nqbo4vA69QEeD23Pp/IKGWEv4gcdqWyLGpyCIctWEtHTLEqq136PUrSf0CzF4qPJ0xg1
	 pa2vl776LRzaRdCHgFjb7n7oafnRFAhOdL5+mjYq1nC/lhGzzZZXNmVX9BZUOgnFSZPI3
	 R1Lq9GDKH0Sy9tVqjO2+Q4jviO/L8DC5zqoT9Jqm50JcJLgKyCv7GSsiMMkxYbBwigEKn
	 q2pDxGwqIat3bwkyGU42WLJs389mzCWarghUcMQ0GstpljjktGTQsgsriODw/1FBnm3SD
	 dgsnKDio2VMVnPoaXJc9AXAq1LOwBktuE8SQlNpnHW/OES4pjo1RN0UHawVhsmNmJFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gRNK11YgcY8cyMOB0/Yo8DNfUbiIMkO6zRKLCyKH5W0=;
	b=4jWlZmDoeKi8Bk6D+ryHCIzFsCESjnKvBpbflAVsw/pNSbV5Zy1sLlPVEdDD6jzsytFn
	 JrYyBgT4kdpHHEwiZVLTgTzKFjciPJo/DbmfIAyfxx3T9vO8HKiwMuspKfGKAvTeHxUSx
	 70ENrB7L5K++yU+10EYvpxFNk14h+0Wwy1+wXz1lN77QHHwCROWHCy+PlJusLMk6k2hW2
	 ML8buef0q/mzQdr0RIKv/+GmwrVKWtdafRoqcGArZZ27CmqewaPRw9ku+6RHUUJGIEvte
	 EH+uD6HXJ0Zi0zcQ8WBZqqaD/AQZSBn19ouCnKK7Is1kbP9RALVzEnPPonRhJ6c5vcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="h/ph+T14";
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD9606A88A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35CD9606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h/ph+T14
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so80567c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941356; x=1795546156; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRNK11YgcY8cyMOB0/Yo8DNfUbiIMkO6zRKLCyKH5W0=;
        b=h/ph+T143MTdkEUM9+rF3Ol0mZmjixyyX8F4HbpBuYsH2n+8fwXGw2oXPufVenKweA
         6eSythBIxd9kJMnAgEujXiOHYyJAWkBrGDyh17t873RFsLR26Dx+s4Nn6FvVwB+wEVH7
         hrnKeuZvwh5M9S6DROCv5IH5efAx7nDQ7nllCwHvMcIuJ2TVJkVB39oM8FuruIgi2TFy
         47atAWJBCBvjkjUWQmrck4l9UwdH6ocp1YmY5OQLjr8aJ+vnuHMhsLm+E9tQ655ktEaV
         dVKsSbP5mF7QOYkBsQisVcg41s2Y5MXCPdRf55ZxDNBLgVfRpcUeM+GZvN3M7WU5X9sy
         rlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941356; x=1795546156;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRNK11YgcY8cyMOB0/Yo8DNfUbiIMkO6zRKLCyKH5W0=;
        b=pZea89HHJqgxFXzqY8SQ2yBAxQzRGCbb57p9BYot3GbPU/WRZhFBODo1hWqywgBdmp
         Xc7HFjY50gYoIkcfnqqOmtfxRRwu2pjtmpxkO0/qmkxOs4GkpJgY0XW6so+qWXAZ6bCe
         wtlJjDxtpqMcXN6iyH+i88pnc/PGFp7vvOlupnkX11/B0SrCwD9VsjuulpxoG1cxkozS
         al4tFH+EHh92xxqFpqVvrfFvYwuOUAVUtkXKpt2j5PQl7BCfCIjFqqZafsU8H9Ojdk9T
         Q67X+3plckFlKdQCmJl+nhdx/03ObHXkfzf1Uo7Xmwhwk7PerlF318dnRFOa+D3EHzZa
         CvHA==
X-Forwarded-Encrypted: i=1; AL+hErEO27vsKGSBv3Fmd3aOBzivaAANsDfGA8iqgy9Hl1Wvqs0lz9KXn7rrAIuUf2TkDhtgc+Vtt1DnU3YNOSB8nghI@vger.kernel.org
X-Gm-Message-State: APuU4Z8B69YbFJZtHgL3NwUuhswmBqVMknpr+VZZTQIyA7LEPKgU+Snr
	xPb4tWgk9azyy0/ZK7KOVRUq2tcFRqwXwkcXgZMWB+c8jGlwMXGG/5xROHMGyOWVF4hgh9W0+LX
	ImNoSxf3r8A==
X-Received: from dlbur7-n2.prod.google.com ([2002:a05:7022:ea47:20b0:1b3:b4d2:9bba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f509:b0:168:3243:c91a
 with SMTP id a92af1059eb24-1b543cb5110mr354520c88.13.1794941356013; Tue, 17
 Nov 2026 10:49:16 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:27 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-7-irogers@google.com>
Subject: [PATCH v14 06/23] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate strs, num_strs, and capacity in struct comm_strs with
__guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
accesses hold comm_strs->lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 6343a3c9debe..9fc4e91a36e9 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -16,9 +16,9 @@ DECLARE_RC_STRUCT(comm_str) {
 
 static struct comm_strs {
 	struct rw_semaphore lock;
-	struct comm_str **strs;
-	int num_strs;
-	int capacity;
+	struct comm_str **strs __pt_guarded_by(&lock) __guarded_by(&lock);
+	int num_strs __guarded_by(&lock);
+	int capacity __guarded_by(&lock);
 } _comm_strs;
 
 static void comm_strs__remove_if_last(struct comm_str *cs);
-- 
2.56.1.703.gf848ed807c-goog

