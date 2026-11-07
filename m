Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026480;
	b=3zo+VhuQpgZjEi39NUN5HOV26jvECRkCzbwyGIQ0HeiaBF18FFetjkEQaxGQ5YTmAORy
	 WoGEfj/RZw1evBl5zZ3ugXSQda7hNF1ixWfSkpC66ycE1O+mTgArNZMzMbDLFOgqr5xSd
	 SCcQNNR1YqwEHn5fFLFgbgRtFg/+M0L7C0fPBhJMZRTcHv5WUdmknr4l2RlFFBOg3iTr0
	 JAywl2lGSn6JVjs5D5X3Bfi0EjC2WcIOBe434T2zGZvgj4fGhr4uEAPSaii0tFOqVuEg1
	 esnp9JQhBKuvbmgiMg+VFJ1iF9h3EEF8Rvduzng5lAg97JdgDnsrm22lqPbe/wyIFfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
	b=VX0e6Dnd1v7emMUx0UBpqk8RLHqcY0BadkzLH13xjSHp7H9UypT7oNYKZLedQJABze6f
	 PN1r15sQ75F0DWXTYlj9Eoi3kKfY1vVe0lZ+2iG4+rkmB6a7HXoH13enU9uzshfJkczmg
	 dbljyFXcxGG4wUszC4vJBFAq9Ep5HthAVaJHk1U6zbq4d7RbREIbzd/feQxbHGo3OCheV
	 PCoGZ7iGj8UOltqZW3Fwgs+lvmNO061nuYucsVgZ6PbOiiil1nrqPUGxXAiLVxtFKwYVS
	 B9iIevLIZ84GR19nvtbm4hSDHnM2Sp/4yu9puXpjQSh7tUAuuUUUH0qQWqBB9/9+enQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=loNpZisR;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09F606D805
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D09F606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=loNpZisR
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36f26e6abe9so2347332eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026479; x=1794631279; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
        b=loNpZisRQBSqUFgZi7hOe2CwX5rAB3c/T9oRlFAGN/P67a/eOHYXlqz0ZL1bY7ta+f
         xVmktgtja5ZfvVkhBkTbvTncuAzWu9IkpCRSgogkkiWp1L9KwJ+jFDRg45aUoyWMUIXJ
         HhSFSMhJqR57ORQjm+pW6h5nxohkdZDQ9sebw4+5jtlceiCkXQHYu/771mcNpoZFfc9G
         Z3SmRhghYKwkXu6wcnIYVG4LQQ0WanvllZSNK/tIs6XXPk0aiXSgobU433MB7yYqbg5c
         wKzZ5PYxrsp8KFuWGaCgTNXzy7Ui5T/Su/2ulurX+kCRxCjQZlh4stZgt4uxn7q6F/7F
         zU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026479; x=1794631279;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
        b=DQKGLROGWaWta+gXxSVKwNTPlgHoNmWoLvHuyqv/2Wa9f9CVhAQU29q+jP3Q2vY0Dq
         sAUQb4s6lxYD1VgTQgBHxkM33C1zQZPGn8uIMeF2o/3G68AFoR/jXjs1oFcPshs42RCU
         3TIQju5fpjCrU14xfRc/ct89gvE+SZtbEz4lJLGp63okofqO1CtwcJs8DyyA/FyGOsiM
         UHHC14PiGbzjjqqgzUDRmEkyhZ2qX1uPQofpVAg2p8Hk5Wr3CrWbV4r+AGxyijsphb8O
         f9b3omU0/ELj37rtds82f/CNzWM3RHSN7FqW8rXUDacmW/O1KG3Kp08dDQ95hRMZM6RV
         FSCw==
X-Forwarded-Encrypted: i=1; AL+hErEi2NrCIcl2f8CFHoqQURWtLryGfsloZickOwgElGKxJeLQEhsORWFkFXXEJ+yMWOnvxSXnuWLMthuQ4X1snytb@vger.kernel.org
X-Gm-Message-State: APuU4Z/uK2XQwI++ZtVXAoIBmvh01UmRvPTkJqVrARqPUT3Z/tz9PS+T
	9AY1fA5DMq9G7n0WiPpB7lVJctFkCi682kFphwLYA4TWNkKv3Tmm5F+M6E2ZF2oD+oyeepDtr9R
	Vo0wA73F6Rg==
X-Received: from dyboy1.prod.google.com ([2002:a05:7300:ed01:b0:368:57fe:3057])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d813:b0:369:fe81:a575
 with SMTP id 5a478bee46e88-36f772fa7e5mr6450670eec.35.1794026479099; Fri, 06
 Nov 2026 20:41:19 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:47 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-7-irogers@google.com>
Subject: [PATCH v11 06/20] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
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
2.56.0.455.g6c5a503b38-goog

