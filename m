Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701045D930
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147675; cv=none; b=tOpbyQloj63pUzdINu73OGoeJvPhFnj2TqkZg+nEj7RBxT4G+dCHW8dX68DkXKFHCIXCHk0qfcWDAkQo1OgU0fac+Tsf7/Uj+XGh3/tpeUtwxuLZVZK0XU9Oa1WF+rY23YYarlWvr/Ws2u3miz4OmTY/h2teGFmtisdFSuhwlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147675; c=relaxed/simple;
	bh=tkU5/HW0EJVFlf7xMc3oLa1n9EN1rmNyxsbrNxyo5aY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qcLgWntWF7ghNnFxm+JYE7qhZqbR2cVG3UW/BLk/0KRNi1O9Aj3UHNhV3v6RVCLlqJmxabexlKSL6N7DwcO8NVOefJoCYr0FirYsUr4+6v9ymn0fc6djef/jvyr7eK//V3jbkqBweoNV0BcP7cZNC8pa3tuS/IKhNxYgMKE8+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtSWq2T7; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtSWq2T7"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14383177746so903981c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147672; x=1790752472; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4s3o3BN7rRyced2L+PC1QB2nCzMDA7Y6t5Oq1+KBNAY=;
        b=AtSWq2T7TBwqwRA8/zE96gCZD6AHZuAy/avGccFNvtlS5uxo1d1Tz1MI6hWS3khzko
         5duzlo4CwWMmdUFzDmEIWPXdDD5v4gDRyyR1p9rYQa316K4lvjtiywd57irCG9FgrLfm
         jWhhRqGxEni3F+Homq5LJcbN7lbLmLJv6ImxW/zQV5JVSFrGv7AHgnbM26JIsZYufwjB
         0F5hHc/ajtr4vOR5RdVBDlnlN9eMESTSBtm1L9FCk82E1w3vzTDAFwrUSM4VnELkFqfG
         Cs5ECfQOVwiGYPxpoWjI8SLtPEcOyJM/SJ++COq3TISWdOEo0NXOPVfu/3/ZhYhB4EgH
         mh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147672; x=1790752472;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4s3o3BN7rRyced2L+PC1QB2nCzMDA7Y6t5Oq1+KBNAY=;
        b=ocPxhl4CzNYYYNePfDmSpR+fRJgd4Y/9Asqw/cBpRhnuBPnBufAvMEk0zO3qPMR7bX
         0PMQsQVP1oE8ItLnyjUHy0DOcFUgomGpyBsSGNh8fBQ99lrs0otpSK9J/d9JqXFq+gUi
         67xvVaUiDTwEkWj617XTQAhuRHh5sSQ1hdhJn5QlBsg8qxKeU7hcjGYQ3v+yRhIygPnJ
         afhyX0ukuQkYKohU08sO+9JsIPPpkFG7fSkywDPB0DpuMnbH6dFZNmZtSBbDiV2l86sf
         hXJjqoYjnPIHDtFhH2AIZcSCXkpvTLNhjJPFCMIoQ8ft6H6jbvng1WL+ZF1WFijnyIPm
         CEiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxo0fbhpI2aNRATQKecTbZoLBJ1bZU1QOnMIzdTIfbxn0kngMN7eucDZc2M9oDYRTxpchNaOiE/aLc/Fbh+sPbm@vger.kernel.org
X-Gm-Message-State: AFuF++nzRkMcuS4zkZRrdw+2LcDohAKGo0aA2LKKM2mceqVDjn/7X/eq
	4SkbFfakspdAbuUFcJUP4GE7r6ZM8L+BFJUYlnLmQk++dub1mZ7zfLYC9rHl8p2sPCGethfb2Jn
	HBpaY5+RcxA==
X-Received: from dlbrn9.prod.google.com ([2002:a05:7022:1509:b0:144:bcd9:aa06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b047:20b0:144:ff47:60d2
 with SMTP id a92af1059eb24-144ff476110mr249479c88.13.1790147671975; Wed, 23
 Sep 2026 00:14:31 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:50 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <ef191bac73ace3ff810eaf6fb1cbe6a45f35be2e.1790145937.git.irogers@google.com>
Subject: [PATCH v5 10/23] perf trace: Do not read sample padding as an
 augmented argument
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

syscall__augmented_args() treats everything after the fixed tracepoint
payload as augmented arguments, taking any non-zero trailing length as a
struct augmented_arg. A record with no augmented arguments at all still
has a trailing run, because the raw payload is padded.

perf_sample_save_raw_data() sizes the raw data as:

	size = round_up(sum + sizeof(u32), sizeof(u64));
	raw->size = size - sizeof(u32);
	frag->pad = raw->size - sum;

and the kernel writes that padding with __output_skip(), which advances
over it rather than zeroing it, so the bytes are whatever the ring buffer
last held there. A 64 byte struct syscall_enter_args therefore arrives
with raw_size of 68, and the 4 bytes past the end are stale memory that
syscall__augmented_args() copies out and hands to a beautifier as the
size and int_arg of an augmented argument.

A trailing run shorter than a struct augmented_arg cannot be one, so
recognise it as the padding it is. The length prefix and the payload it
describes are checked separately by syscall_arg__augmented_args_valid();
this stops the padding being offered as augmented data in the first
place, so that the syscall appears with no augmented arguments as it
should rather than with one whose contents happen to pass validation.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 47 ++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index eeaaab44016c..aa2d64eb56bd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3022,6 +3022,7 @@ static void *syscall__augmented_args(struct trace *trace, struct syscall *sc,
 	 * traffic to just what is needed for each syscall.
 	 */
 	int args_size = raw_augmented_args_size ?: sc->args_size;
+	static uintptr_t argbuf[1024]; /* assuming single-threaded */
 
 	/*
 	 * Augmented arguments are a perf trace specific payload, they are only
@@ -3042,24 +3043,40 @@ static void *syscall__augmented_args(struct trace *trace, struct syscall *sc,
 		return NULL;
 
 	*augmented_args_size = sample->raw_size - args_size;
-	if (*augmented_args_size > 0) {
-		static uintptr_t argbuf[1024]; /* assuming single-threaded */
 
-		if ((size_t)(*augmented_args_size) > sizeof(argbuf))
-			return NULL;
-
-		/*
-		 * The perf ring-buffer is 8-byte aligned but sample->raw_data
-		 * is not because it's preceded by u32 size.  Later, beautifier
-		 * will use the augmented args with stricter alignments like in
-		 * some struct.  To make sure it's aligned, let's copy the args
-		 * into a static buffer as it's single-threaded for now.
-		 */
-		memcpy(argbuf, sample->raw_data + args_size, *augmented_args_size);
+	/*
+	 * perf_sample_save_raw_data() rounds the raw payload up to a multiple
+	 * of 8 bytes less the u32 that holds its size, and the kernel skips
+	 * over that padding rather than zeroing it, so those bytes are stale
+	 * ring buffer contents.
+	 *
+	 * A record that carries no augmented arguments at all therefore still
+	 * arrives with up to 7 trailing bytes, e.g. the 64 byte struct
+	 * syscall_enter_args that an unaugmented syscall emits comes back with
+	 * raw_size of 68. Anything shorter than a struct augmented_arg cannot
+	 * be one, so drop it instead of letting a beautifier read a length out
+	 * of uninitialised memory.
+	 */
+	if (*augmented_args_size < (int)sizeof(struct augmented_arg)) {
+		*augmented_args_size = 0;
+		return NULL;
+	}
 
-		return argbuf;
+	if ((size_t)(*augmented_args_size) > sizeof(argbuf)) {
+		*augmented_args_size = 0;
+		return NULL;
 	}
-	return NULL;
+
+	/*
+	 * The perf ring-buffer is 8-byte aligned but sample->raw_data
+	 * is not because it's preceded by u32 size.  Later, beautifier
+	 * will use the augmented args with stricter alignments like in
+	 * some struct.  To make sure it's aligned, let's copy the args
+	 * into a static buffer as it's single-threaded for now.
+	 */
+	memcpy(argbuf, sample->raw_data + args_size, *augmented_args_size);
+
+	return argbuf;
 }
 
 static int trace__sys_enter(struct trace *trace,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

