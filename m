Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98103AA1BB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192944; cv=none; b=DUTCz4k7FK0EcETFv1RoaYZxrgsDriRg8aplB9NTO9SW23TG8A3pVID16iYRD7ZwWmRuqdBpw64i/jZwPeZe66k5AnpU90EUG02WlMQo+juBWaBVMc4Xsa1XsZeFcRKfAXoj5ZpH6VU3qy3JbcKgvBEB89HTwBQZIgFU/qq51sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192944; c=relaxed/simple;
	bh=iPcpZWIP6za8O+u30RDQtFF5jiM7hsZPzxKYGwSlx/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rISQk2HhToGzOPlLOhkZYG4qBCwtVYJ2q6kWBJz2pwBzKVQ3YZ83EomNR5F98rU1BczUxtRcbcCPoAwpiwS6LHKAtPMSunGFjoMzLtOuImEMhGgfNDPxgI8e14FsHlfAvbzKiw1ijCk1Olp0zdy9HjmXZxUDstIAVjfTSM5uoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4vAT8Ke; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4vAT8Ke"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c0c489e72so3985724eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192941; x=1782797741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DukrpnZ+OQVB3ie5sydNGpOwAMqR9Pzh6rQDPSatO24=;
        b=V4vAT8Ke3lBRAmvtHSwfJ3R/m54/3BqfvFFmNfTcpvOxHt6T9hnW3+3ILmJ/MmGK5F
         bjvo6lWkyVw1NPOuFktkqiNEZra5mjc+etqaNu1aK0fpcmR+VrzjxjXQwdnVVqQsPy/i
         +/EvEHMHtFJb17AoRP/9Kdz/xZ5b98SV4/fy9dgQUtb82/9KHCBRT2NWKDxvvyjgsYx6
         AwKAEhE1WOgq9CsRp4yz6yPOYWMovWrYPiZJ85ON2V3s5Y+AQNZZaMN4FsYhx07wAdPx
         xmvaVZDS4osnj1mAQ8ZG8yPPcMMJc3NcY1pmM9LbzOTuvbhVxD5P1yetgLd0datF+bjT
         5AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192941; x=1782797741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DukrpnZ+OQVB3ie5sydNGpOwAMqR9Pzh6rQDPSatO24=;
        b=JeIoGZRx+iMJ0c2c4DEAzwlGy4bbDLPT47ohuXDLTpDhNZqpe7G10ykufBxyk/fGGN
         kQqoE12ZXxYzgkCjus/84Llb2/h/1CrJKY0LkuHHHC0IP4fnSbAfZTMs/Khuw9EI9T9G
         TexjCIpn//8UJkXBZLIBtI230VaowOcMp9LnyDyMwgSpoEw6PtrkdcHR452JTsTV80UI
         G5FLsTfUTUIBoaNtsmz8rUrF4UUrSiVGkZI0bu/naf7254sgg3b1jrqqOSWU5UmtgxdJ
         Hd7cyPFEtwj7B7zGYdNMbC6x2t6s1Mwp3dqh9kLZWtgkUwsNv7lz4st/TwSV2SxnYWL4
         WawA==
X-Forwarded-Encrypted: i=1; AHgh+RoCXm//WK83gsqOSvenRGIvksmdgSOy8QshVow/4YKXtiOSm9PjlwxWYwvw97BC92oQjma9/tJzuceDIYZkHmtt@vger.kernel.org
X-Gm-Message-State: AOJu0YznbNPfVppV8cBaeT/E9Tudm1WHnAkhSekWumTGxCjfOPCOgKZC
	Mis5kuyqRagdTozUqIC4e5uEdAvEPCm4hpzGsPQKa7RW5ZsHf3SlbwtVO0ctYHMD53AuwvXp4TD
	OHNzCT2SkxQ==
X-Received: from dybtt11.prod.google.com ([2002:a05:7300:f40b:b0:30b:ec47:ecdf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9f17:b0:30a:e5d4:22a2
 with SMTP id 5a478bee46e88-30c06fa51f5mr11552230eec.34.1782192940649; Mon, 22
 Jun 2026 22:35:40 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:07 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-6-irogers@google.com>
Subject: [PATCH v1 05/13] perf synthetic-events: Fix uninitialized pthread_join
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
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
index b75f9dcf4dbf..35de41ad14d3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1104,8 +1104,8 @@ int perf_event__synthesize_threads(const struct perf_tool *tool,
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
2.55.0.rc0.786.g65d90a0328-goog

