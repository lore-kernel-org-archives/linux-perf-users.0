Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831E533595
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877671; cv=none; b=qT5YJUIgSxV5z7skDVQhUbaZ4czY/cSQnOYxDXCmiOa+IAs00C1y7rhG3NKa1cSsQm1m9FDidVRVGIoH48taTRN29X+xxGeetWlpgbICHnHvS4MqpH85sE9n1eTdDf+fh8Gl/urFFvBTpRSmrwNCqNycNZI0wGxwB2bpNr+IwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877671; c=relaxed/simple;
	bh=xs47/ZquuRSh5EAxE1ukOHEBk6TzifBU8rys2s3fUy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3GPE44vWWDQpHfn686c3fhiYLVnk96GRmIU9m5mEh84CJlF3TTWIvnZtsd3NYxnw1wcZMzkadF8zqmT7IYj35nnfqncv46+bdikfxmEjy3kR4ZjWu5o0gO3nMPG8dgweMVe8O5zf5W2pwWSGNA2BwAW2ZAI6cH2F+ALS7BIu88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIALXBCh; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIALXBCh"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f0167e59a3so3305831a34.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788877655; x=1789482455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4rGRXmnlx95MB5kVTdxzr1v1/yGYeCfiSVry1Oz1DA=;
        b=NIALXBChGgrc7uSTQRwn43TvOoj3YGT8A7i3bOH00L+u6QmcrRmhMYtsUx9fUYstSq
         BMSXOwyP+xm6+nuLN268j7n3lSCP8cZ9W7kC+HL4Oq/dFRGL3dOXA1r+AjPfRAXPsJ/c
         RGgUQgpMi/B8hd5hw99CxsMCWLjMGFLbIB7ddJEulbyYdP9fzWOmL8WuoHMk+qYsJ5cM
         Qrvypo38ptf/9As+Se8s4Up1rIZSbU9ZA9csMFyr2O51Ywrygk7unLTkYjq0oTqOKdLV
         rBDixv5wI08q1FyimJUFs/jGVpZu7Uw+3VB+0E7//mhwGN58nj51vgmzY09pjjzapflY
         pR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788877655; x=1789482455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4rGRXmnlx95MB5kVTdxzr1v1/yGYeCfiSVry1Oz1DA=;
        b=sKxkNMtN9xoSHwmmmlxXF0250Bg7XULawOhXQYBjUx8yizf4Ca2ECTelGAcLiB6v4l
         pCpZLluOPbjOdIDlrOkAyQsFoYTo/Uxf1sMuCzaynXmpRzX9qQwjsdih3SbHEnDwZjDU
         +JL24/Q+ShOujwyPPBWYNXUCM2nqO4/FVsC2zTDjQmRA4HWWWrR+i7QXnT4Ganuc3wci
         Gj52d9bfIAezTrJ2pxnFKSU0vyIfQH3+5NxtvaA4EWHzqKjt+Gn5O3XNoqIpFwPuVJPf
         zGweZGBlPTwR9k2rO8+o5hpyTws0w1Kb6o5ZvVENYD6k4IVD0OKcnBylHgwpffVMc57w
         2j7w==
X-Forwarded-Encrypted: i=1; AKwUvBzxTBeHeBj+jHY4QgfsYV/u7cyWEmUFfU7wOvP1Nf1UsuoTRrRHyZDR9GD8wURuQsvLm7vdZcO5MJ8DtSwPBkSq@vger.kernel.org
X-Gm-Message-State: AFuF++kkGeRJo754n0wRVU74r4Ol+0w7AAQvKI7Y4fijh/2aw0w4Xn+m
	uc4uSk3CluJ9+vaR4bqM0qdz3dz6Ud08wXMkZl357bWFN8tj0ifVkMih
X-Gm-Gg: AYBFou33uKXq/A8lpjF6qEtim4BEgQeQ4K8IsIUm26xsM/6fbtyhoNHIhSOzFJGHmZv
	zCJYSaTHXiRThrQlhJUeX3vxTDePI0uyLLb4J9utoS4geFj6TkJyz3Sr5hQmVPdH5PpS4p5RvHe
	RVQ7WPL7E/XLHLn0tr8M320hbQ2eHWd8UJI4AVph7L78zkV38HnAPXRsJL33dxAx+YCbJLvAD+/
	hVlQ0A+dPsYxP4FTQinyo3UlBu1ua+Jnm9brcC8Evxi3u6uAn9pJHxtBzBlo6T5CZB3Zu/QVq/m
	ucZPfl9zlcfPYDZUjmXJKu0p7PyHoYcM2cQfCPzymY8Vu6UyGvn5FubNLirX2CyvnXuFGbjS5de
	lbSsgaSKOqlAhB+102PBavEt50ZN/gBfnkUAjkS1560IfUr3UzQtmZ+K0zfXYSs5xxBTZtihQO7
	kbVI+950tVrL5GeZEt89OX+dWOyR2znpIm9kcJoLWjKwe9YnBJifg=
X-Received: by 2002:a05:6830:43ab:b0:7f4:e011:6b2b with SMTP id 46e09a7af769-7fa1dc9d20fmr18168222a34.1.1788877654500;
        Tue, 08 Sep 2026 07:27:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fc39e5cf1fsm9459213a34.24.2026.09.08.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:27:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 08 Sep 2026 07:27:10 -0700
Subject: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot state
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
 acme@kernel.org, namhyung@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788877648; l=3143;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=88iWtKcXxUazkWlhxqTHkjP1b2Zga7aQtAYNkuVTgac=;
 b=fmWe15Xe85smC0snYH9s6kKWbpvnTg5AiUs4LoaOm53baFwZsFceC/ccm/N+R/u9zad6i7h2d
 6JvayRVkZFYCJTtdQcmJmic7UPkB1FmbN9hAYEof8MjnA4aAn1D5zxk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A perf counter can be zero at fentry. PMU multiplexing can schedule the
event during the BPF program. The old counter check then drops a valid
sample.

Use an armed flag to track each successful fentry snapshot. Reset all
flags before new reads. The fexit path clears each flag when it consumes
the snapshot.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index f48c783cb9f7..6c654bd9b346 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
 	__u64 running;
 } __attribute__((preserve_access_index));
 
+struct profile_reading {
+	struct bpf_perf_event_value___local value;
+	bool armed;
+};
+
 /* map of perf event fds, num_cpu * num_metric entries */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -21,7 +26,7 @@ struct {
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
+	__uint(value_size, sizeof(struct profile_reading));
 } fentry_readings SEC(".maps");
 
 /* accumulated readings */
@@ -45,7 +50,7 @@ const volatile __u32 num_metric = 1;
 SEC("fentry/XXX")
 int BPF_PROG(fentry_XXX)
 {
-	struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
+	struct profile_reading *ptrs[MAX_NUM_METRICS];
 	u32 key = bpf_get_smp_processor_id();
 	u32 i;
 
@@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
 		ptrs[i] = bpf_map_lookup_elem(&fentry_readings, &flag);
 		if (!ptrs[i])
 			return 0;
+		ptrs[i]->armed = false;
 	}
 
 	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
@@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
 						sizeof(reading));
 		if (err)
 			return 0;
-		*(ptrs[i]) = reading;
+		ptrs[i]->value = reading;
+		ptrs[i]->armed = true;
 		key += num_cpu;
 	}
 
@@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
 static inline void
 fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
 {
-	struct bpf_perf_event_value___local *before, diff;
+	struct profile_reading *before;
+	struct bpf_perf_event_value___local diff;
 
 	before = bpf_map_lookup_elem(&fentry_readings, &id);
 	/* only account samples with a valid fentry_reading */
-	if (before && before->counter) {
+	if (before && before->armed) {
 		struct bpf_perf_event_value___local *accum;
 
-		diff.counter = after->counter - before->counter;
-		diff.enabled = after->enabled - before->enabled;
-		diff.running = after->running - before->running;
+		before->armed = false;
+		diff.counter = after->counter - before->value.counter;
+		diff.enabled = after->enabled - before->value.enabled;
+		diff.running = after->running - before->value.running;
 
 		accum = bpf_map_lookup_elem(&accum_readings, &id);
 		if (accum) {

-- 
2.53.0-Meta

