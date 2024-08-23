Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DB4430
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Aug 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420621; cv=none; b=QSjXXYFU5fUBClaQ3cXFtfkpnAN9vmbABwIf/NnmOGPYd4iIwfbRqcP9bkDDK279cnHLEFaq8kMBGBtb0zIu5bLQ3Xk3xl9jM2lUeZSGXEyhWFKfRhV+iL+okvo1gd5nHHALDXVqOio3jrIKmtzHeQsGoiLNmUfssrOed+qtOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420621; c=relaxed/simple;
	bh=cLLnHvDkSqyRKoXw7u5aN3T1vaPp8+PHSwr7OMPFl90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LWTINlyrI1T3rCksc08duN2HgHUYn4KqrY+UlBFgkwKdvt7u+fkdCDcWLVZj4feoe7mt71XX8XWgxG94y8l+c0QDkOHnuHji94WI+DcKhzJZHmaWQmEvTX+ZMfdmUKEoSA3UbtUU1dT58LZowNcN9oWBzcFqCokppTv0Efj/6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XDGEqpoI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDGEqpoI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bef4d9e7f8so2673488a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Aug 2024 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724420618; x=1725025418; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/93O2lVtVfAQLoREFUo7A80V927wBhIQxx6ZicbCtjk=;
        b=XDGEqpoIiDfY7lDJjDWIzS/Qz/MUJMHNenvTYuYMMUDnbVqIAvsp4TxYfoFl3TgVBy
         8O4/DrLIQlun0BoiTepn33Wok6QEolVHrjZ/OIoj2hZcl1G4IpkLVoSLYgR+yAF4dbia
         D5Swr3xTsOv9SYrDzIZO8so3MUlL+DYAQH5lVbmrzphobhCGsCvjvNCqTyfJdDwPnkBR
         dcqAuKwTbfSP88bZwiKzVFcF0y3E6WDAXgAkFFm4gdZaoHjOwO80djSlxdzjIPf+kaQL
         MIsea+nauFlKgTkUgdCC27Jv+sZXb1K7wucPmfN4WXwt0Wx6giaEX07tgBFXNsRhmaMO
         Audg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724420618; x=1725025418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/93O2lVtVfAQLoREFUo7A80V927wBhIQxx6ZicbCtjk=;
        b=H4GZzi2h+BuTpsXCIzJau8T/R8zn21aUUpGrDUEklRv+QvUdbL5eWy0MGznU2FvnkU
         3LVzzoluOf+DqpRxLsELp170PkLOOyiL2ARTa45gzcx+d0aNuvdBujS01fsAarLdqy5q
         +M8Y7TFi65FJaSJn3LHlOkZ2t+d2ZqNb2QwoB8VcZa04K1lx6Zk8wnIh3DZhSSfr6it4
         A3sggJQ2FsUxZLYjrtZkO0HSUnHhNiMlvQYMEaJMwdbpC4PW0l75TuByf/fNg39SnBBa
         YRMEMyPAsku4GqMOa+95n4HYul0J9NiVdKYcVwT+8I/uSVONTfHIo+YqaWM7/8ztPzei
         gDIA==
X-Gm-Message-State: AOJu0Yw16wTvftU6h0yUUuKG3lqPjmbgg+S6UMuCl+cFxQZBDRZyvOY4
	7sJMhg9S1RT9OlqGHAvYSse95bdz8KEEw1FLEiq2jSeTtRWBtvUVaKJ3PM40pML2Le82rQjREUQ
	mDxDpVQ==
X-Google-Smtp-Source: AGHT+IHUomNKmWB4zTt3pKoh1c7oiKylbsfBsyiKBWdAA5W8efuxHqkx4Mop5tgWB3QMAm86685GzA==
X-Received: by 2002:a17:907:f18d:b0:a86:7c6f:7cfa with SMTP id a640c23a62f3a-a86a52c49ddmr163783666b.37.1724420617943;
        Fri, 23 Aug 2024 06:43:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f223596sm260485066b.28.2024.08.23.06.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:43:37 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:43:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Subject: [bug report] perf: Fix event leak upon exec and file release
Message-ID: <5cc313bc-c44d-4f6c-80ee-5a9fe9356f43@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Frederic Weisbecker,

Commit 3a5465418f5f ("perf: Fix event leak upon exec and file
release") from Jun 21, 2024 (linux-next), leads to the following
Smatch static checker warning:

	kernel/events/core.c:5301 perf_pending_task_sync()
	warn: sleeping in atomic context

kernel/events/core.c
    5280 static void perf_pending_task_sync(struct perf_event *event)
    5281 {
    5282         struct callback_head *head = &event->pending_task;
    5283 
    5284         if (!event->pending_work)
    5285                 return;
    5286         /*
    5287          * If the task is queued to the current task's queue, we
    5288          * obviously can't wait for it to complete. Simply cancel it.
    5289          */
    5290         if (task_work_cancel(current, head)) {
    5291                 event->pending_work = 0;
    5292                 local_dec(&event->ctx->nr_no_switch_fast);
    5293                 return;
    5294         }
    5295 
    5296         /*
    5297          * All accesses related to the event are within the same RCU section in
    5298          * perf_pending_task(). The RCU grace period before the event is freed
    5299          * will make sure all those accesses are complete by then.
    5300          */
--> 5301         rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
                         ^^^^^^^^^^
The commit adds a sleep

    5302 }

Smatch is complaining about four call trees which are holding a spinlock.

One:
pl330_free_chan_resources() <- disables preempt
-> pl330_release_channel()
   -> _free_event()
      -> perf_pending_task_sync()

Two and three:
perf_remove_from_context() <- disables preempt
__perf_event_exit_context() <- disables preempt
-> __perf_remove_from_context()
   -> perf_group_detach()
      -> perf_put_aux_event()
         -> put_event()
            -> _free_event()
               -> perf_pending_task_sync()

Four:
perf_free_event() <- disables preempt
-> perf_group_detach()
   -> perf_put_aux_event()
      -> put_event()
         -> _free_event()
            -> perf_pending_task_sync()


This check tends to have more false positive when the call tree is long.  For
example, maybe event->pending_work is always zero or something.  I've looked it
over, but I'm a newbie to this code.

regards,
dan carpenter
