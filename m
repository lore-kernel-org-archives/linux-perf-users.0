Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD37342CB4
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495099; cv=none; b=nxlCOA0V1Ofvs8pxXkP33F9rgnmXoHxpvJFaxOXeb8bzINxBSK1useLXxeyEW/KMcgH9458mwKMAsafTakoSj/OZu2Hm8ssu82Vt+iwasX+iRGGNeHglHG1NZQZwTbDvUaPm5nRhdp+W9GY2X9juzFWk9sY9O0AvtHM2KFVL1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495099; c=relaxed/simple;
	bh=szGr69gF+vdEu9NuDlS62rGphnL6lDBt9qkzVt6uERU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OibS68ypwatjjQoCIQN/kG/OSYGz0MrIeJTui1YCQl03NvhpzmIeewB6BFFaRPLUx0gYjcmvl7Hi+GJGj0xCaqt2glUkfcka1sOIQUEjGK688b0n1G/XLPvBasqvQleNA0wjd8AciqWPWS8k2KIh6TLj243XMvQ+RvTeaF9kvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/xI7GsJ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/xI7GsJ"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8296dabef74so503974b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 20:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774495096; x=1775099896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJyZdzHJlp0YpomaVsmEd2du9wsvCvcnjce5LqH7hsc=;
        b=X/xI7GsJ7neL2ltjkz9G04EJCB3q65SyO2auh7WChXHBdr9h/05XSWI9G2VfbLy9hO
         wV2LrS73/CTAmowgGuwe8rzgkZSXpk9ORUQh8xvIkXZt5cV6LjpTel3/j01OGeYM+qd5
         fL3+ZbKXtoxL7FXaa5Y21vfu0xlF/a6GLQI09ShMaBW7TCfoMTCIoHWf2wQyHOPyuXik
         ALwPtu0UM7cszmB7JihGMUKs7P9zSFaZkzgACAFJe+K6BuuHXCZ4Hsw0czLFWkumoK0M
         Z4JhL5oYxH/pPCPvEH/5vGl+Vg5lAmgKg0yDxK2pDsL+rCpo8GtOgb9tRHiJ49c3WIny
         CCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774495096; x=1775099896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJyZdzHJlp0YpomaVsmEd2du9wsvCvcnjce5LqH7hsc=;
        b=L81mfTK8mYiWxahE8O3WXqzOmvfyUWfJCvsrGxau8JPuT11IVjyVYTPTfqFz18ZwXE
         8PTHN4EzbuT/AM6/8iK6cK38tskXxwnCDwQfgpWMI8OXakEM/TvbMZ/u3E9W3dUu/dI8
         HJ8rH3KWnIkjTSrUqDWnWB3el2lqqPSx6/AC0Xtm/Uq/Vgp6i4NvsZpnPt+GpA7LsbZt
         sS6kISYHMPSj3fDg3ZZMa8F3hD2OWsoQvfE4J901yzDJ7ildBUl8ko1KO/H0KjWsiZ2N
         EdghQMbQLxLonZiXb8BL4ukKKj3eZhkf0OwLXF+bq+7O9Ks6LeKFZZRR7WkcSc4dhtfY
         Zvmg==
X-Forwarded-Encrypted: i=1; AJvYcCUE7Yk/Jy+gpZ2apjQLmMJqGa+GKNB2G7LjA3uFYW2HTWwDLAUeL6YsGB3cg039j90Vbhn7vAbNGt5rMRwIuzoc@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1V3q50QSkpIeSBfIFyKqanmqK5neNSqyRBbsNiavKIUIFFtM
	uann/4/wWT8L0kIy1mWxu2jfBtGDUXgqOzAyqIx4XCoTnVXOe48QqEmb
X-Gm-Gg: ATEYQzwfhFSd8TGmNkYXIK9WpFKV1dKJtslvGTEhqpAdZX4rF6hh2+KhaJwRZxjAzMY
	W8Ac0VWab5e7J1LytyLyk2KDzFHMtBCyla4Tbg5XTsvZFPuKQdQx6j0GL41+PKW32W3/QPGaEgj
	hZeA1s++D5dz3+3n1CN1v2CPkhKX1nC1MncTOKELZjQ6aai3OTbDW1dk4Jt9oqUiV3oV7ov1alg
	7oZipKsC6kUPHJuirqlQparCtjxsO6nWtiEh6uoQZQDfVfmC+2ZZfRIx/JgwbWmVA3Uv70tCNlI
	ypTGhQJyqNfczo136ilLBJdNmkL3eqqvCoEBPAHo0bw5meKVTprHasqt0fE18aevpjqxEzVjNXY
	wdM1nCxtHWV7SqqXqYOxq2ZOILkTJSQyOferp7+OO5WkaHegHVrlwYPURC7dcmI7Dg944bfByzS
	tmQL59O/IEKYjtcJ0p4jZnqa+z8lV7aMVps+OARIDIknCgOb74Cw==
X-Received: by 2002:a05:6a00:a210:b0:827:444a:58e0 with SMTP id d2e1a72fcca58-82c6e0e6089mr5629907b3a.32.1774495096498;
        Wed, 25 Mar 2026 20:18:16 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3f8a51sm1089780b3a.60.2026.03.25.20.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:18:15 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com,
	wangqing7171@gmail.com,
	yuhaocheng035@gmail.com
Subject: Re: [PATCH v3] perf/core: Fix refcount bug and potential UAF in perf_mmap
Date: Thu, 26 Mar 2026 11:18:06 +0800
Message-Id: <20260326031806.876931-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325151735.GI3738010@noisy.programming.kicks-ass.net>
References: <20260325151735.GI3738010@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 at 23:17, Peter Zijlstra <peterz@infradead.org> wrote:
> Argh,. why is this hidden in this old thread :/
> 
> On Wed, Mar 25, 2026 at 06:20:53PM +0800, yuhaocheng035@gmail.com wrote:
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 2c35acc2722b..a3228c587de1 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6730,9 +6730,10 @@ static void perf_pmu_output_stop(struct perf_event *event);
> >   * the buffer here, where we still have a VM context. This means we need
> >   * to detach all events redirecting to us.
> >   */
> > -static void perf_mmap_close(struct vm_area_struct *vma)
> > +static void __perf_mmap_close(struct vm_area_struct *vma, struct perf_event *event,
> > +			      bool holds_event_mmap_lock)
> >  {
> > -	struct perf_event *event = vma->vm_file->private_data;
> > +	struct perf_event *iter_event;
> >  	mapped_f unmapped = get_mapped(event, event_unmapped);
> >  	struct perf_buffer *rb = ring_buffer_get(event);
> >  	struct user_struct *mmap_user = rb->mmap_user;
> > @@ -6772,11 +6773,14 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> >  	if (refcount_dec_and_test(&rb->mmap_count))
> >  		detach_rest = true;
> >  
> > -	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> > +	if ((!holds_event_mmap_lock &&
> > +	     !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex)) ||
> > +	    (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_count)))
> >  		goto out_put;
> 
> *groan*, this is horrible.
> 
> Let me have a poke to see if there isn't a saner variant around.

I think it's ok to move perf_mmap_close() outside the mutex lock, like this:

https://lore.kernel.org/all/20260325153240.GK3739106@noisy.programming.kicks-ass.net/T/#m0f82e8ecdfdfce4acd5121bcb799e864cf05ebf9

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..e5ce03ce926d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7485,9 +7485,12 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 */
 		ret = map_range(event->rb, vma);
 		if (ret)
-			perf_mmap_close(vma);
+			goto out_close;
 	}
+	return 0;
 
+out_close:
+	perf_mmap_close(vma);
 	return ret;
 }

How do you think?

--
Qing
