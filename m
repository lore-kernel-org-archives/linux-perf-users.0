Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB252475CE
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Dec 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767042242; cv=none; b=exATEFceC7wA1z2I6DMwSOR2gVMGZyRvrmyZD1iRRiywNH/eqsksdKgRxHUAHyKUvnNvdnVm8gpa9IsyM09Eab7lBfKj0NAPeVJ/JLSpjLfVI3US6Umyj7kLgiiGinXG5uJr9o8QoiecZiryGwbHZmJHOXObYzX6dhuKR2li/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767042242; c=relaxed/simple;
	bh=6Ks0xRzyWcD5nHqKH8+WHYZ2GiW1MN9WIRQUrkwV6HE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lmeBntjAGHVDUcW8glMKlx3UVA4KU2HGXw0QFc3S/76aR5Ky8crgD8BUsOCNDApczouL7i13Jpk6KnDTBVCHJtKJaIgehkclLLhRZ96NHZf1xe+8Km3tk577Wm59Q1/RL7sfNyVEzQrUlLJAYWPXSoylXEyZxEJC50BoO3KoUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=QLTPyIzy; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="QLTPyIzy"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-121b251438eso2257837c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Dec 2025 13:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1767042240; x=1767647040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXmmIwHZ/4Otl6o+BH1rACcqNy1K+ueCZiBvlBf+dM=;
        b=QLTPyIzyVNTqlsmI191ZlFVxi54xzeXh1nFeGrb2Ecdqq+YEtqDkgFoQrM+Z4uinXy
         8U16Oa8hrtaDVHiqv4usmYGp7j2WwknCwz5Hc9sDf3+9mfPC6ldxmt5O52N0rTBLD1i0
         AwU/Z3LW92jzjKjwoy+CfForPMvGuqo2MMS5WX2igGPxx3gWHi5z0BcQ/P7XWCtMH6td
         Ro2lhDUAcoDOt+z86cKxpNQeS79JtaR283u5+gZUmuTCBI2pk2U1cnNa20aQfqSAjFEn
         1CUK2DySxKsDKZKKb8Rpo4k9I2Gcw9jH5IlwktohhMfwJQoQEYjedCW2xmo1euMf3O5m
         SrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767042240; x=1767647040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMXmmIwHZ/4Otl6o+BH1rACcqNy1K+ueCZiBvlBf+dM=;
        b=M/70H2sBLt1CuXYs7E+JOu5RuedBnG41jKODHEJS9L0yiBveVw/lDtBmaojFUTGVZS
         WakV0FJFgR7P0d44UqCD/raysWqxDxj7omIbgrqCSlxmbO0l471UZhtjiTCGPtFLlBU0
         kSkYDuJqTW0emoF7I9374WMOu1b/ART90dQeYGoO1Fdh/iq7ujeaO6xrFbk1+LeQeQtw
         WYoc3J3NGPYz0GkmXlqLHw2FSWN4BitSZo3RWq8hQuvwnrM+m1td3tEeJcvSk73JRjJ9
         lSYz3XLsWOgTNcjXsnQJ0kd1L7CyXKGSEZF/j84HfYY9HYngut1pP2Q+3KGe4cTkO+f6
         VP4w==
X-Forwarded-Encrypted: i=1; AJvYcCU2MNOA5mbUlfT29UAMakq9vGhh+NN2GwzHemOFejAxcdkDCiQREykO+aaGLdkx/rtw+rXVy1JZzGEydqUSN4q1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4rYf5All4SLfuW6qrDIqbAe0Ik32S9qCIknFhXohYp4+b+iy
	Yk4P2L4i2223JEHyHnDyCyoIoiJEkrQvC8cZauJMWx0USLX+UCBQO+T7W3I2racdZg==
X-Gm-Gg: AY/fxX4TLc+hS7DDrl2pFZoB36oYY3Dn7xL0q8e5tNMGtw7GDgZCsCZdw0dXs5cQL3k
	X0YEgrS8r0RTLDaILYBKEVeI3kXnOp0Kg4CHhmu1gnY48ReY5oMtlp4qyersaVCojiymZT59VPk
	BkAJZU/IbRbXdv0dwA+QB4ynK+3VWbsi8Ys71iVPQUfXuZdurKQ5p97OVAHrjXBADqp5FLnk0AK
	LV7VV40jD5Mg6nmz+Y5qgkgHDrCHMfnfnQ/99lahRI5nf5yZV1diPpLUf+tvxRHQULi02n6POS0
	bO2Pzq+I/WFwlCSaqsldsIG0ohckmvHnyvZnRmGT/7xmnd4g3LHgXaFrzZScOcQD9DKjd6ac1rC
	Moud7+LvJCzwvJx1UJxoc1fWb18VOYA9bEMWQhG4RatUibI8aCp3oRmPols1qJOo4o+x3nxbwJT
	D7jU5hd/1vguqIUQuypTMJPE+H0YXtAq+h8swoFe8TNBPL7vZKQQ==
X-Google-Smtp-Source: AGHT+IHm06cgGI7TRQvfy27jGwQ2mVdrbCBdorkVBs/wQMFeuTn7eDIadqhVNbcrNoV5fzO3gUfjig==
X-Received: by 2002:a05:701b:240d:b0:11d:fc25:af63 with SMTP id a92af1059eb24-1206194371emr25133278c88.11.1767042239815;
        Mon, 29 Dec 2025 13:03:59 -0800 (PST)
Received: from will-mint.dhcp.asu.edu (209-147-139-190.nat.asu.edu. [209.147.139.190])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm120632754c88.5.2025.12.29.13.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:03:59 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: 
Cc: Will Rosenberg <whrosenb@asu.edu>,
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
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf: Fix refcount warning on event->mmap_count increment
Date: Mon, 29 Dec 2025 14:03:55 -0700
Message-Id: <20251229210355.65732-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
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

Account for the case when event->mmap_count = 0. This patch goes against
the design philosophy of the refcount library by re-enabling an empty
refcount, but the patch remains inline with the current treatment of
mmap_count.

Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---

Notes:
    I also have a related concern about code that handles the mmap_count.
    In perf_mmap_close(), if refcount_dec_and_mutex_lock() decrements
    event->mmap_count to zero, then event->rb is set to NULL. This
    effectively undos our output_event copy. However, is this desired
    behavior? Should event->rb remain unchanged since it may still be
    mmap-ed by other events and can still be used?

 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 376fb07d869b..49709b627b1f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7279,7 +7279,8 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 			 * multiple times.
 			 */
 			perf_mmap_account(vma, user_extra, extra);
-			refcount_inc(&event->mmap_count);
+			if (!refcount_inc_not_zero(&event->mmap_count))
+				refcount_set(&event->mmap_count, 1);
 			return 0;
 		}
 

base-commit: 538254cd98afb31b09c4cc58219217d8127c79be
-- 
2.34.1

