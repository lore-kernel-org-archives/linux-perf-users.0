Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB04377AB5;
	Sun,  2 Aug 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680851; cv=none; b=FaXxG3Avoyh4/lb6Bb1ZZh4Gy2qkStU2HYfro9UOwTZ3bh1MdG2+191GzaASOYkhdUR1x4ZsXI4ifXNt3zz5iosCoyhI5p+BRZV+R/Syc5DTSTr/0nyA15ziu4GB0l+JgT9qk1BZ6M0GDX0NBbywkAA/Pj7ShcQ68rZYlilC4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680851; c=relaxed/simple;
	bh=DR6PD7Ey5TmqTWgHBew+d145z/STPQJ/kBWViIfNl/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvVpg/XmM/dT6AQPHd5HuRnEsVpRfrfVUCUWVxcc3vVpuDXksHMDbLBf8yIQr7akxX3XcDAJRYv18znQ9WrarlwYJg/QBnhSGV9BcsVlFOd17IAScxPhlC/rZtjb2MTp46WA1GdD64ANdV8hBTGHNsx8TNLGLD4L9EUQkGXfST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtzEWc4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtzEWc4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4C71F00A3A;
	Sun,  2 Aug 2026 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680850;
	bh=iLiBwdShXAbqRqFRhrLT845rNT8E4xpqJqX8bz89zqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mtzEWc4NZKNDvefcrCdZ32sBCiqSZEgBiMuaOriQaDMXpXfzbqJL5GgxN9tipzz8s
	 SKCA6lzkPz1ODixtZz/UsoCtqWBzRiYvy20QF/nsdjj3ZNqFvIcNY0bz1lbXircXtF
	 H7rHv+eLzP+8VVydocA8OOzxpGg/GczTfrCsHjgPx0GNpyWhv9OL8wanECE9pNnFou
	 F7hKuflflLiLqN+1/1u/rZsLsGARXoGblKx/Lr+1nVcotbjHAeqBV8lM6HU46qVVxl
	 VYrk7wff996ISb51wHiU6McIaB/THIyTrxDg9OYiSN7c1Q/h34SVvpe0stLb15Ki2I
	 vmKY7HFfktJuw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Song Liu <songliubraving@fb.com>
Subject: [PATCH 2/4] perf header: Use write lock when translating BPF prog info pointers
Date: Sun,  2 Aug 2026 11:27:10 -0300
Message-ID: <20260802142712.154726-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142712.154726-1-acme@kernel.org>
References: <20260802142712.154726-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

write_bpf_prog_info() holds a read lock while temporarily mutating
info_linear via bpil_addr_to_offs()/bpil_offs_to_addr().  Between these
two calls, the pointers in info_linear contain file offsets instead of
heap addresses.  Concurrent readers holding the same read lock see the
file offsets and dereference them as pointers.

Use down_write()/up_write() instead of down_read()/up_read() to exclude
concurrent readers during the addr-to-offset-to-addr translation window.

Fixes: 63ac7968a1fb ("perf bpf: Save bpf_prog_info information as headers to perf.data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e90e541f546b4537..7db7da090a1e0c78 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1120,7 +1120,8 @@ static int write_bpf_prog_info(struct feat_fd *ff  __maybe_unused,
 	struct rb_node *next;
 	int ret = 0;
 
-	down_read(&env->bpf_progs.lock);
+	/* write lock: bpil_addr_to_offs() temporarily mutates info_linear */
+	down_write(&env->bpf_progs.lock);
 
 	ret = do_write(ff, &env->bpf_progs.infos_cnt,
 		       sizeof(env->bpf_progs.infos_cnt));
@@ -1150,7 +1151,7 @@ static int write_bpf_prog_info(struct feat_fd *ff  __maybe_unused,
 			goto out;
 	}
 out:
-	up_read(&env->bpf_progs.lock);
+	up_write(&env->bpf_progs.lock);
 	return ret;
 #else
 	pr_err("ERROR: Trying to write bpf_prog_info without libbpf support.\n");
-- 
2.55.0

