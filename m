Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244341;
	b=HNqAWqZHPCs0qupytv/goB2yDbMuVmqmVra8hQwvj7skRwlV4haPYJYRyLctMce/46J5
	 mz45PAlUtOIwpkvxVqMjcJvXU3gZfKSWC+GX+OsLpe93NJJ5d3UVnIxc2JsOPguhjW8pH
	 fa9rMf0oHXeuQKamK99lsx0lfHnYijazjLeF3QRUs9e96HETmljsz09axZT/dxZ9Cmxwx
	 VTp8s/++BICymToAUpIlAg3kaX2NILutpV+CWE4yiWsW1aAefBcqYB+Cujg5fAYFBd9XY
	 0cEXhJIvnohcfsV5Dqan3ooQNb7nJLuJSqaOIIZdwcxz9qq99pcs5qKx0wOHwCvE52w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5uxDxgfBGA5yTPHcCIqyXHP3BnAmG6Jm0Jp5UQ/3dx8=;
	b=YFlGp68gyS6ACMmMIR92hpeCz1ac8GkZhQC0K3NFboznlV/AZvx+5UUCl6Fh5cgBuBfd
	 GY8/eKJaZvAqrqqjI9n9DuN1T56Ok4gNBu3jMzpjBxFvhQLVw0LHAYbj8CPNOhmWsqEDt
	 4SbURO93rrjoQUt42WOXW0OKaqllztqv0Qepf55twCRazImQ7CCHoNJWS+k/8wnPRKKS8
	 txRYS4OwCVgjMIeFFBZ1TD/nTwYF0E//sBRKbO/bAXwxupidB2Q/7vJUoESIpjT/74Ase
	 8gUpsAu1uMNTklkmtzBYzn/ATkAe39Mua5QH+qiKkTwQLC+XmKzZuxP4F4liNuMjiwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RXfniuAf;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D438606A335
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D438606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RXfniuAf
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c7f887ac6bso3335217b6e.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244340; x=1795849140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5uxDxgfBGA5yTPHcCIqyXHP3BnAmG6Jm0Jp5UQ/3dx8=;
        b=RXfniuAfp3EtgdBAKLr75KxU1qE5n7pDoI4d1alzGAlfMRAwN3+g3ZJnmIGW4r1buS
         0NF7vvAxIMfQLGu2DiyROfiBeiWT50y0M9CRyJrT5qpvGCRcoKV1gO7XCWzbUrIhH6po
         KyzoqFq/Aj/ZvpMLYhuGzkTV9W7IoPEFMAHmkjc19hMbMZ5yxxr+wk2AL4Ylo8qzKAqr
         +FwiIPzRmEtTe4ZjvPr0OdLQboYn84U7cpF6/on+F3ewqtk65+gr5q4YhrUINMSpSbe0
         KcxKZlQh/2El9pk+oyQ9X/EjtaDhXnNfpUx6x9DbbYd0iA+9I6jOpHZ7YoKXp+80Lpkj
         9nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244340; x=1795849140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5uxDxgfBGA5yTPHcCIqyXHP3BnAmG6Jm0Jp5UQ/3dx8=;
        b=gBWj/w6Fke0vYOcB7DSfhe848u5JHUL0G4XNa+G4Fa2M49DCSX1okFS0QeZTODkUSd
         j4QZ5yYCEIPqb/h5cdXc8Be4k/KsslIQgk637V1X+RwGX3kZpGTQkiB+yQdH34ftYShQ
         IDARiRbFBViB4++N+pBHoJlp7krNIUVzIRTaixFpXgwAJsHZOaXOxG8gpTQj9tH5hv5W
         905zArbd8ijol/vzZM2nnMziJLk8r7OsAkumwUpPK5T0xvZcdNRDVBxXpixjdwtzblNr
         4Vd+GTt0PsmQN5ao3xPEUtORyMNElgfZy9C9MFhGb6yFXSNyfLTB7RKDal/4B+01tFwh
         cM5A==
X-Forwarded-Encrypted: i=1; AL+hErGABF1EXby+hm6mAuS17C7UEZHJXwWgghPUE4COh6v/1ue6Ik0OmDdI0kh6jabAlNbQPxI4P5qMylMib2Ra4LRL@vger.kernel.org
X-Gm-Message-State: APuU4Z8GyxBd3tdSgAHdkid2MFEINd67yfBw0B9yq1Ffs7l6MUSWZ5RJ
	FDspytjoPVyZb/Vm1AZDBtpGK9STOLyfJOxN0ZpK81ctFMnu5KqN6ehb9kNAH2ixAC+DmqwROGg
	2Iu81YTH8HA==
X-Received: from iobdo25.prod.google.com ([2002:a05:6602:4619:b0:9ca:bcca:dd8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:640a:b0:572:e8fb:2125
 with SMTP id 5614622812f47-57a09504aadmr5490293b6e.20.1795244340118; Fri, 20
 Nov 2026 22:59:00 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:55 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-7-irogers@google.com>
Subject: [PATCH v15 06/23] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
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
2.56.1.750.gf70dc682cf-goog

