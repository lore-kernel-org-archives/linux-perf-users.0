Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBD48AE1B;
	Mon, 19 Oct 2026 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397302; cv=none; b=Eq/+z/rvtKA7fO6qPCq6wHMHSEB5eA8J6sIubnOjikQBUiriD5S3D248691TeKj2FmXG34AhHWU+Z+EyP+N/m5cLKxNJaqYOUcalBTvcNzVPlZc9qAiFvMUs2aSqC5LRhWF7RfGDTJGCTsF25gpFiE65qfDnmYtghEvn7dZ3+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397302; c=relaxed/simple;
	bh=wcOXy9B3DbVtBa+EzryE8J4ZW+jO109RlIiPLk2w2xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D78nmUmM5FNRgGyT93WwC2zeovanAB9UzD/ot9iIaxHA0cU2FnTqWiAm7Pl7wvTmMUajAAb10nMKLSdgy/yjsD15XTxeQZGjeqe9xu8EieKVRdhaQUQWQt7hQL225L4FwO10FzGJiDdfDVakxzfv2Lv9BGHYtH3kB3DgDzoDsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FBB1cfWf; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FBB1cfWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Yc
	HHiKIDYNnPxeBXOqhJlZrJp4ZEWl/YWNx7btzPgfI=; b=FBB1cfWfkuCdx/EBmg
	Q1hGBPi2JjuAvaCDAgJPRw6OmUTtcVNAsqmQpAEzJJgvY7HwvbnFkzIzXu7f59la
	Fo1vT03ZONGaa0Gx3rbVtlSJO6F7zOwcRJMYpDtcJyzIqszTgx3izrL40hg6FJHy
	Qh0mmlughRA/obo6AwHnHfhO4=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33yquz9Vqd9a9Aw--.57344S2;
	Mon, 19 Oct 2026 16:07:11 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	andrii@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] uprobe: Assign session ID before publishing consumer
Date: Mon, 19 Oct 2026 16:07:09 +0800
Message-ID: <20261019080709.477548-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33yquz9Vqd9a9Aw--.57344S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1xCF47Jw1fKw47ZF1fJFb_yoW8ur13pa
	n3Jr9Iy34kJw1YvrWktrZ7X34Syw4rJF47tF90ga45ZwnxJr45Ka17Ka15ta4Dtrs5KF1U
	tr42g3yqqFZ7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7b18UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4A8vE2rVz69IhAAA3A

consumer_add() publishes a consumer on uprobe->consumers
before assigning its session ID.  handler_chain() traverses the consumer
list under the trace RCU read-side critical section and can therefore
observe the new consumer while uc->id still contains its initial value.

The race is reachable when an uprobe at the same inode:offset is already
active and a task hits its entry breakpoint while another CPU registers a
second session consumer.  handler_chain() may store the stale ID in the
return_instance consumer array.  By the time the function returns,
uc->id has been assigned a nonzero value, so return_consumer_find() fails
to match the saved ID and the session ret_handler is incorrectly skipped.

consumer_rwsem does not close this window because handler_chain() is an RCU
reader and does not take that rwsem.  Assign the ID before list_add_rcu()
publishes the consumer; the release publish of the list node then orders
the initialized ID before readers that traverse the list.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: 4d756095d399 ("uprobe: Add support for session consumer")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7709ea882477..83e6aef61181 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1032,8 +1032,8 @@ static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	static atomic64_t id;
 
 	down_write(&uprobe->consumer_rwsem);
-	list_add_rcu(&uc->cons_node, &uprobe->consumers);
 	uc->id = (__u64) atomic64_inc_return(&id);
+	list_add_rcu(&uc->cons_node, &uprobe->consumers);
 	up_write(&uprobe->consumer_rwsem);
 }
 
-- 
2.43.0

