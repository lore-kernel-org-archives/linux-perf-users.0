Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051571;
	b=wH/1Sp+jxsIslrhzzvTO2lM3Z8aaQjaaLgb90GSDYxkQlkZk3UnF4MzG/doVB7dwTzna
	 NKXkTBGRrQjreJFwmdTCpOO+qWi1yKbByo4hHikrTPKVYgJcgjUYuGDv3G/0LGxp8MjB2
	 JlOoCpvCRCQE+/9AaJZB95JkipSSGudWy4Dwww9eumrTc2WlYP77y+feSVJvZHcDu60ll
	 gEmEKB60iK0fVgXXmk/ncnPUtzulWBQsZlOH8rgNXFenBdHzfrOJGC5k6hbMIWGRPCheZ
	 cqmj4HfSpycAS3FICOwB30xh+wgQUuMLQBkCnlj43vuS2xUsJjdU/AYpeBes5Sg3lDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
	b=zfL7nJML0gCNQkjqOLU+KI9IE3xm2Lm8DKwShzPBJmXtDCRzw0eREfKeOkHHq7tNQQCf
	 7J2LKswXEdJZXHR0xbWtxK/chRGnycwSX0l5yFi4p/DELKsqrWmEQyjcB2XZK2uKcvgEs
	 4ZI+BEwDZwrhW9l+UPQzKU4H84msDwGB3hoUXdK4UmejbVClUeOSNmdb+LTn2PSvBMl2C
	 OhF4HQyuzvch4x1NyhTCLC3858IU8vmhfIMNPC7i+RHditcHugrYI69hrdXAY3nz5Xv6u
	 iWbPf5A/PYPEJAoVddmxYu73THdZNNRl8iZtUGgslaZZKhq+ORD7cGgGrBxzrfc08Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fU7gA7Dl;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB260A261E
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52FB260A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fU7gA7Dl
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so3402234a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051570; x=1793656370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
        b=fU7gA7DljvCqdvdMpaU2dp8kIrEccZFKOmWnfW6sw+A054S6dlNZugZLhIYYcfiePQ
         hsLgQW99gw7/40gSfJI6nU0rtnm0+1dPDbRaUoY665tdkjNVHr2UFbegtIbotfU9v9/A
         uK7QOilz2oAfaWXl/tsF91D3vAUMVrFCU+UmdWgUF2++tfRICFcImVM7cH8b81croIe/
         3gbPbeDpIxRnPDaXaoU22kL/RynJy6L0hYZfzyDRTzTeCDcQlDb8FUzF1BEGuZLmjKzH
         eeONqBOhxrAFnMU8HI0VT7oOvpOxL8LajgaOKQMUvvRXhW0M5pmi7s9QGStFhbTf6Lb8
         9JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051570; x=1793656370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
        b=ya1GuHIXImtjKI5RsHqqRguZnNgvKnQF15MFVYYmH7lsf2UxcjqPKZlIp/ImHsaOd+
         aMYOlsYGn4R2E9B95Y3ffXYmoKChfDkSqj3B3vBsBbC++r71NANATI117z8J1LcH1OUM
         2TDV0xu+XvKATlvtv9ky7G/EqfshmkND8U3/XKVi8+6MQhyh7fnAh4rmbdhXUHQ29H/P
         HujR5f/c2pRaBF3i0TH72/zWg68me/7auWAjLJIbenVomLrYd+M/ZbPVU70bGQSwqfOM
         r9omnqWZU+vWDPwSdliGEvpRUOgDy/J0X5X0Jqg4ngQ0cDuS3O57YQt3yEQh0S8b22Uj
         8y4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxnhiRyIETOAS+3tBzUIt7XQzRPothstiWPTQ9GaJQkZfR0qVurFHaztS3Lc4p/HlK8aVqEephp030c6D2x2YHR@vger.kernel.org
X-Gm-Message-State: AFq9FYKoAQ6Ut0aykndEEq3zOvD0PqqLyTrBLoY8NMee7sCY9BHuS9v3
	BIHQGMcyZjOrVHPGI+0FSy+T2jcs5DmpbSgatCvU/cPrSNg0tGxJ7CA/WnBsksUVqcMEr73NEnQ
	2qSizj0GyIaNrGJDdGclB0w==
X-Received: from pjbme4.prod.google.com ([2002:a17:90b:17c4:b0:3ae:349e:2bcd])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35cc:b0:3ad:1b31:92d8 with SMTP id 98e67ed59e1d1-3adeb16ecffmr5865801a91.60.1793051569572;
 Mon, 26 Oct 2026 14:52:49 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:18 +0000
In-Reply-To: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026215226.3713941-3-jthoughton@google.com>
Subject: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user memory
 when canceled
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

btrfs_uring_read_finished() copies the data of an io_uring encoded read
to the submitter's buffers with copy_page_to_iter(). It runs as io_uring
task work, but io_uring may also run it with tw.cancel set from other
contexts when the submitting task can't run it: from a kworker when the
submitting task has exited (io_tctx_fallback_work()), or from
io_cancel_local_task_work() when a DEFER_TASKRUN ring is torn down.

In a kworker, current->mm is NULL, and the copy does not reliably fail:
the user half of the address space belongs to whatever mm happens to be
lazily loaded, if any, so the data may be written into an unrelated
process.

Don't copy the data when the task work is canceled, and complete the
command with -ECANCELED.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/btrfs/ioctl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f3e2afe221be..d9044fbd9547 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4609,6 +4609,16 @@ static void btrfs_uring_read_finished(struct io_tw_req tw_req, io_tw_token_t tw)
 		goto out;
 	}
 
+	/*
+	 * If the request is being canceled, e.g. because the submitting task
+	 * has exited, this may run from a kworker or in a different task, so
+	 * don't copy the data to the submitter's buffers.
+	 */
+	if (unlikely(tw.cancel)) {
+		ret = -ECANCELED;
+		goto out;
+	}
+
 	if (priv->compressed) {
 		index = 0;
 		page_offset = 0;
-- 
2.56.0.307.g5fe7bd680c-goog

