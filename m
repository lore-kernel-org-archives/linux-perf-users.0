Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12E3E7BCC
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411369; cv=none; b=qxqvimKeNOTtm+nOTGQRl908ELmKkBDAQfmJ7Gyf8h6r5lXqoSCTiAnnBtzv5XZBYLn4bWfvd11IlMQZfZOr0P421uXGqL22Zpt/da8D4yB2OMJOEVmjkayKSQmIoHwrQQoPtTgMyFeoiASQif7AsHfpk51D6fTvBgjQcng+ZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411369; c=relaxed/simple;
	bh=IGYS9/MJmi0crQrMqbiomdqqv5fS8S+rJ101ghPw26E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nrtdl+dbmmbxtrUBv92mPzVotMyu1EiQIqxUpDjBIpklh2y+LDiDgq1ObdAikGJwDDyj6KNy1duD4JTyHLjXg2WJOPvi61OAmSjKL45MjOV3kyQquABaZWoVSnUBNfWXwkZPcEiMALenJjZZ3B6JTlq07yD2kxCA7y6wRzXIlHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM7SrUrt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM7SrUrt"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1963068a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411367; x=1788016167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xN4hXMOwbHYw8YYoHSGskBU1Hru9hAdLN66h2VVXOns=;
        b=YM7SrUrtYAnhHYAaeIsAdACdKCoehgVqosn8VSUcPiYv7S5UXVIE6/f/GWmYdyLSSg
         olfwtyOA0EzuPMwWoMVN0TpOMYvpey2qY18eUwO/6fSPYe4Ni5bjfMZYwMRRGjoTJj7e
         obec/wGWWF5/P0/9Qx3eOxU/6pVaixqytZbrsKtf9VFK1DPC+ekED/+tjgU1NZbW8hhP
         NZR7cWUdjp2Qx46Hzqcl7rk340Nc6xoQRYOQDf7FkN1wqTOeElXbu9j+Z2KsBjB002If
         11ybhfHXz3RpfqT9LnZVryktLlPdV7qsRhvlC/EDjEUhy8oKJiNB4Jxa5o6sRnshBEgP
         lFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411367; x=1788016167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xN4hXMOwbHYw8YYoHSGskBU1Hru9hAdLN66h2VVXOns=;
        b=I8K0pVocLH9C/FzeIN2aY9cojwiFwCMzARRBxji2weyqhyB1Kdcxy7PdBXNdSyOira
         97afOn2CMDSbG8/ynCaL0651WG3aenSt9Ed8sIzH4Px5NQrR3b4BPbmMkQlgedxhcJAg
         qvEbTXUpuWqcg71PeTktQmqAhIgG1SRSGSlpBkINOr+x+W5fCH7onj9EOO5Xjin1m87v
         WodqyR8AIr3S68IZOZB6cJtSw5qqITT3mViPuyHWjRfOgvEkOgv0C90ctSerrZ9fuuPa
         YwlEtHeOvDcJmDc4AZQqbytz5L9a0mMAKwhMxlh1Fyay8VsQcj1QRsVFsmOowhYvSkQz
         QtCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpS/h7b34B77leK2liXxpcgr9+28hYyf2Q683ThZHcWGZZNekyjPXz8B09oDglpVTHgNaC43Hx7g1gln72R2NEf@vger.kernel.org
X-Gm-Message-State: AFuF++l8Qn9Hsjxqm+Bv9GRbN0AeWho8EDkH32Jk6v/LkMuN9VKUjzZ7
	onwRTWL96dcUxDYKQPeWsD7yYihtz+5y8ucdtfz7z1cedi4ew4sjbmjE1G5CcjVuLsE=
X-Gm-Gg: AR+sD13BkV5iohsPyPUMEHGGbTqBamrgECE5Yo11Agc5HCGQYavZn4BumbrQtpQnRm5
	P71RTWAFq815/kuOlsUZfWTv3ZxWyodm0fVhG8LMjKUxrevpoXsNg0g2XQ804TSyn3QuTBdwGW3
	YwK8o9Fm9Jl1e1ypw78gGbeU6E2fhQHc818BvSycu0IFjMgK1jYR+kjms58J2G2Ll06xsY/yWbS
	nl32TIK839lNLvNG50tpHvrlHgg9D4ujsOlzkyp7pwfJyJf80ZslataEglgCk2SmIkVByASnu+v
	PtrwsIV8IQizv7qWXYYeo+Eah+yqxVtDZ1K5hPPemi+NqHElD+llD9wfyB8rVoqfCnNWHeZOjKg
	NUWpwN2BwS5VQrFMPivqDXnvDOzcqqYGV7Es/HO50v6bOtZFXtJPkxmj13FcZLkQN8mDf6Khh7X
	kJrcwQQBp2nNLPducVx6htLiwRsz7TqN7HVNOGt45oK4pi3KYVq3ZZCEzgHA6FAMOHAzJkOBlTQ
	NeSOgi2RZE63vyA6NZpdMAB+w==
X-Received: by 2002:a17:90b:2cc3:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-395df29666cmr11845108a91.13.1787411366593;
        Sat, 22 Aug 2026 08:09:26 -0700 (PDT)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([117.172.228.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418619d6ecsm8057043c88.14.2026.08.22.08.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:09:25 -0700 (PDT)
From: Keke Ming <ming.jvle@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Keke Ming <ming.jvle@gmail.com>
Subject: [PATCH v2] uprobes: Free utask on dup_return_instance() failure
Date: Sat, 22 Aug 2026 23:09:06 +0800
Message-ID: <20260822150906.528208-1-ming.jvle@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822054620.452262-1-ming.jvle@gmail.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dup_utask() installs the new uprobe_task in t->utask before copying
return_instances. If dup_return_instance() fails, the partially copied
utask is left attached to the child task.

Free the partially copied utask before returning -ENOMEM.

Also, dup_return_instance() copies the return_instance before fixing
up extra_consumers.

Here, if no deep copy is needed, clear the copied extra_consumers
pointer.

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
---
v2 changes:
- Clear ri->extra_consumers = NULL when old->cons_cnt <= 1 in
  dup_return_instance(), fixing a potential double free during
  cleanup.
- Keep the dup_utask() error cleanup from v1.

 kernel/events/uprobes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b25531331902..73a6620c5701 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2118,6 +2118,8 @@ static struct return_instance *dup_return_instance(struct return_instance *old)
 			kfree(ri);
 			return NULL;
 		}
+	} else {
+		ri->extra_consumers = NULL;
 	}
 
 	return ri;
@@ -2140,8 +2142,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
 		n = dup_return_instance(o);
-		if (!n)
+		if (!n) {
+			uprobe_free_utask(t);
 			return -ENOMEM;
+		}
 
 		/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
 		uprobe = hprobe_expire(&o->hprobe, true);
-- 
2.43.0

