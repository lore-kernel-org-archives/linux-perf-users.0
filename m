Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C7325711
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848608; cv=none; b=dw/C+7+JB6I5QEUAUzx1B/X6BYEmp0sE3eAA92WeZolOokpBCQ9VicWyVTJ6Rc4v9mVideLPrOUl7FjKD5sFG6xe4Ko/vO2P/YQkoSennI8wuh2w7M31JZlUv6VgJS80HM0Q/rvyWAFoCsNbH265nysx6ci4I5IqE4ccuQ/EbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848608; c=relaxed/simple;
	bh=sRvXaccqEOLfZpTQKHnPoLP/VGpY5fCf0tZuR1ywRxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HwUhlggLC3Pvfedyj9bmCdd6dtzWuqAPUaxoedsVPoiXPthhf0P5cTyfSGVaW6XWunUssTCw9Y2TvZ94TUUJnKrEtI4HewpTLZubSlvRzk6W3ii1UCTcD2wwN7GfgW4vf2+LhFryt5CNWBu8BeVUW5+qng6hRJEgxKdduyNjGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=bYUb0NJ+; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="bYUb0NJ+"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso4826535eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1768848605; x=1769453405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM7YwFaYfpzWin0JEzaV48zpKRTcuAip989AP9etaf0=;
        b=bYUb0NJ+rT3f1MKaGfsWepTwD1k5aNQaPYu5Ho7mGdZa++i4I+zhL++xOkVmLGNpDi
         K1jaMFOORDnKGKRhaI6HKFO7q1JSoWsIN51uFSKaTI+cn5tVJ7hPbG0D5ivkLSPJGSEd
         WM//7XTOOE+5ENZNh0F3Yemb7RoyHLoUHx+T0NBFeRDVTdgIIpJOj9SVtwl0BfpMRF/K
         6IEL0dXPpl+bx85ANiXw1GLYdpkrv3f5yJDX5xhrzL7Rc3LuevYCITVGmoXgVVrjhE1R
         u5Dii+CYKPLYngQhbwvh02WenlQjxoyrqNH/eQy4tUC+9HxbxWy5h3OdYfheGSkkserx
         q/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768848605; x=1769453405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oM7YwFaYfpzWin0JEzaV48zpKRTcuAip989AP9etaf0=;
        b=b8Ug2x23FNzql64W8loI7y5Da96GhAtom8zENQCEWUnCA4rOCosE6dS5dCRa9Deghp
         Dlnx2fUKa6ZCIW1d4cog6paDunP9kk1GJK6gKAjXvEVIokefvON5UZc/b/1tb+NqP/A7
         FcIwOaJILugKJY1/BaHx9y6aNM6lrZZTPoFelDMAHsNzk7ruCBCEj6WV7zirNPoErZmK
         R0uMcsUHBIQOwuTsfaVnmxM6C4BxmbS/9LEt3/esSH3s5TWOa2/YtBwhKNrvCw1FLJJO
         AraWYCvzkMDGQARvvqLtuo2w9NjHaAt/b1Uj0hn811v8K1zinOnKK0Q4Bxk++stn+a0f
         do6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTnT+E3PhOawe3ofI2ERrwto7pBK15uoAvMsalcCe4nqemlJuJGXxiurZMKfOKA2CLjZAPLgGXsieloE60q01b@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAGmQPu+uJLsZ7r3p+6FRcdNHy7MXhOTlK37rvQby4U71TU6N
	iITM1YkPfFRbhPADweSBHIkbaLi2raSQa39jURIAzEIsuhLgrt1W64gE3nsnD7uEPA==
X-Gm-Gg: AZuq6aKsdVOcX4l7Y4AMmIgU0EpvLS7APHpdY/d1mCRzF9S6n790nU6sQda4cxjn6wx
	qDz6uTblc+X1zbai3hFKXqKxe7BxCUJWeqevhM/eckFgoS7zs9ZzLPz3Ujld5HqWIDep0/wL8q2
	Vyxhcy8PGxBKiU90PltAJg10+9mT8bGl1VQRrS3jbCDCOD/YZ5T1bFRKit8OzWaa7/0ecyorirM
	9I5odKmQryBOruwURNpHBDPVen4mE9Jqw8+hhgVf0cegugCX67qkRm4BeLgmgNIGhJfL1iYbpDK
	Kzxm10y2SCC1oJx+1OE5wPL/UhEln/wRv8SJyHLY7FIm2DmhbEK6X+ydrHdqt84mxu1Fuaym23V
	9RklqZzi3ZcGzwslUFzaJqFSj8ed/p89Bt0AZtfq4enbghA9euVZoyg90W9TyqKqHQ+tcPF8O8F
	GRzHd2sKf9JwCQFVYnzcifIZqaD4TxK2kgFM6/qjuTOOApA4Vmzg==
X-Received: by 2002:a05:7300:54d:b0:2a4:3593:ddd9 with SMTP id 5a478bee46e88-2b6b46c69ebmr8731975eec.6.1768848603315;
        Mon, 19 Jan 2026 10:50:03 -0800 (PST)
Received: from will-mint.dhcp.asu.edu (209-147-139-190.nat.asu.edu. [209.147.139.190])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b6b34c1177sm15926209eec.7.2026.01.19.10.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:50:02 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: 
Cc: yi1.lai@linux.intel.com,
	Will Rosenberg <whrosenb@asu.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v3 RESEND] perf: Fix refcount warning on event->mmap_count increment
Date: Mon, 19 Jan 2026 11:49:56 -0700
Message-Id: <20260119184956.801238-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106203547.38354-1-whrosenb@asu.edu>
References: <20260106203547.38354-1-whrosenb@asu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling refcount_inc(&event->mmap_count) inside perf_mmap_rb(), the
following warning is triggered:

        refcount_t: addition on 0; use-after-free.
        WARNING: lib/refcount.c:25

PoC:

    struct perf_event_attr attr = {0};
    int fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
    mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    int victim = syscall(__NR_perf_event_open, &attr, 0, -1, fd,
                         PERF_FLAG_FD_OUTPUT);
    mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, victim, 0);

This occurs when creating a group member event with the flag
PERF_FLAG_FD_OUTPUT. The group leader should be mmap-ed and then mmap-ing
the event triggers the warning.

Since the event has copied the output_event in perf_event_set_output(),
event->rb is set. As a result, perf_mmap_rb() calls
refcount_inc(&event->mmap_count) when event->mmap_count = 0.

Disallow the case when event->mmap_count = 0. This also prevents two
events from updating the same user_page.

Fixes: 448f97fba901 ("perf: Convert mmap() refcounts to refcount_t")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---

Notes:
    v2 -> v3: Update patch to error out instead of incrementing.
    
    Thank you, this is a much better solution. I was not thinking
    that the mmap itself was unintended.
    
    I believe you are missing a "!" in your patch. After adding
    that, I tested the patch, and it fixed the bug.
    
    I also wanted to check my understanding of the race with
    perf_mmap_close() to double check this patch will not cause
    an issue. perf_mmap_rb() should always hold the
    event->mmap_mutex, so there should be no race on
    event->mmap_count with perf_mmap_close()'s
    refcount_dec_and_mutex_lock(). If there was a race, we would
    risk returning -EBUSY when we should "continue as if !event->rb."
    
    Thank you for your help.

 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3c2a491200c6..ac7f12560172 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7273,6 +7273,15 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 		if (data_page_nr(event->rb) != nr_pages)
 			return -EINVAL;
 
+		/*
+		 * If this event doesn't have mmap_count, we're attempting to
+		 * create an alias of another event's mmap(); this would mean
+		 * both events will end up scribbling the same user_page;
+		 * which makes no sense.
+		 */
+		if (!refcount_read(&event->mmap_count))
+			return -EBUSY;
+
 		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
 			/*
 			 * Success -- managed to mmap() the same buffer

base-commit: 5d3b0106245d467fd5ba0bd9a373a13356684f6e
-- 
2.34.1

