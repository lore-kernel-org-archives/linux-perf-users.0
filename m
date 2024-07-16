Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872AC25624;
	Tue, 16 Jul 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115358; cv=none; b=GIIfOAbqx7+WLncd0cJpk6yZevqXt+iEOnBNa2mZIBmOBP451fihj0LkqIqVkG6V8BR+DhMTapL8Vhfjih8fm8XO7F8qq1Z6t2nQoELYQ162dkaKdgmzvYFGfJM/8vjdYesSjp5mLFKzLtTgS6VWAOsB0PhH6sEkgkS0H0HNenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115358; c=relaxed/simple;
	bh=Jv23nrvAKWkpeNI/6cEjPrytTQdL4KRiYhmlmma8k+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BihzkoLR+kOQ8B5/54M8KPt+tmmtCn61bPjWO/YyIzVqZuFVg+iiNXKqMUp2dxnwQDz5PB7/Q0G6u/zV3tBjrydIisPgk90bgnL3hGgOTNUJ3/0q0ghFE7/o27TsNCZw1ET2QlY1GgWaAHhj+LCEP6xaAmDKc9Di04ssXS0v2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADn7+fIIpZmeSyWAw--.53848S2;
	Tue, 16 Jul 2024 15:35:36 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	nabijaczleweli@nabijaczleweli.xyz,
	penberg@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf annotate: Convert comma to semicolon
Date: Tue, 16 Jul 2024 15:34:05 +0800
Message-Id: <20240716073405.968801-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADn7+fIIpZmeSyWAw--.53848S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF18Zry8KryfZr4DCFg_yoWfCrc_C3
	WxXF18try5Gr9FqFsFkay5ZayFvF4DCr1kX397Gw47CF4kJrWUZ3Wrta4Duw1YqF9IkF9x
	JwnxWryUJwsIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd5rcUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: aca7a94d6a59 ("perf tools: Move UI bits to tools/perf/ui directory")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/perf/ui/browsers/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ea986430241e..fe991a81256b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -985,7 +985,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 	browser.b.width = notes->src->widths.max_line_len;
 	browser.b.nr_entries = notes->src->nr_entries;
-	browser.b.entries = &notes->src->source,
+	browser.b.entries = &notes->src->source;
 	browser.b.width += 18; /* Percentage */
 
 	if (annotate_opts.hide_src_code)
-- 
2.25.1

