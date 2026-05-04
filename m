Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F963DA7D7
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902821; cv=none; b=Obzq2sbZJO4o7VZSGWITr1lDMvEjPrWH5CvHwD6n+pU0vsDJ5nC9j+ErZsqdryE8GmzhSUTC5rqTdtG9YuzLM3KE2FhUK1NbOyJ60sla/gvdpWeg07HV7q1SjcMYng+b2WhhkmBiSWQYS01QR6UBKG8RWOcW+u0WGm7sEkm+v5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902821; c=relaxed/simple;
	bh=OWWKk1O4PQhifhYuVB8Ox6BqabB7mC37ee79/FkVmm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSH9c3kMksnodZgciAoR8vfQ0b6tic41SF3xP6z+ATG46Ki20CQLv0QN1m4BP9vUjkmL141O/Icmve+DvwwQJFsiO9exP4IB4gN3v3RiQ/GfAAQjmEgFDqKn8NW8xaTvaH+ov+BvGST5KI4DV8hAXPF2w//kGtOOaaSZN9DTtjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sW+wUzfX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sW+wUzfX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-837b39eb078so624681b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777902820; x=1778507620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZvLVM8KmFpscXyNlpgqnG6u/pzaOvu4z7PrNxvBuMs=;
        b=sW+wUzfXHahsAR0CVCxlXSLsonHiSnPMt2NHXHQ9PYyGenKurZO3JkymEZ2hSmS8vc
         Gu5xUEZFHTp8zfcaHLcaAVE+Lz5ZPsfIL7pwXi8ZD0ldyPwO5v6ELU4zR7h0zJD6Ld9Z
         VVz/GcXyk2uzz/rtc6elFLzw5EjXhQpWJgC6K9eReJlPA08E3qlOHVHVf8Y5VnGW428G
         ePm8dxWQlX7o85QY9kkDuVHE9gNYKfoL4owD6Ccx1pAp0I60GuU8+z3+o79yul8cCTI2
         wKHaFXfkrjZ5aW/OMMcdo7HUQdOBrJiagtHY4kegK8JUSkmL0BYFhGWJS+6yJnTypAJm
         6ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902820; x=1778507620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZvLVM8KmFpscXyNlpgqnG6u/pzaOvu4z7PrNxvBuMs=;
        b=oOkuRppu/EyFHmDVXilxrf9dDXSApVqitZ7Rdqj1ewLrWEW0d0gH1JVj1uEOryhuhG
         4ns3rXbsIo5lQWL5+JkJndJF5Y43jWXVgp1Ae4n6OKgEoPTgSWvtEuvwh5ebDwxFcThE
         cPouoiYGLAazi263gRLwhu3Zvs3LmC5sqUD/9E3VZkzkFOVbZDy2zBjqiM7RQQV/hI/O
         MtOxoONZoFOKPP+h2XlS+M3pvRx/R6OaTzJsn1i+U3+Tb+sP95Iaqf9feShNoUr1EH7/
         jL6GN4ZnIWuQBtXJrd8D/zaart9Ps71eDvF2ch/7XFPVgzmTioTzGVtYFbCPjlOMJ5y5
         dq1w==
X-Forwarded-Encrypted: i=1; AFNElJ8Z9e9kpvfXXcpIaP20PUV/uUE9FA/pGK7YqG00Lp9Ua/uJHhd+w3SUxlb+TcdIaOEiy9JXPOdvn3/48GZrZipb@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHuq8F3GnU76ttlCQO+Drx8xTu9OulrM9gQiTLft+G5gBw9DQ
	loarK05tj3cY5VuuOB/+c5wzqeG1whQr9lXvDD+8Imu/YlI5o2jzlxdJ
X-Gm-Gg: AeBDietx6+d/5V9UDP02ATL7bK7R0Ef9kWmxxc61KWw/4O8OlpQay2+xWhuJY0FCieA
	IMeIt1/QK54eV6o1cLwalHw1e+1gOQGqOZpBmXl3uaQmDpT3MnyJKajP88jcRLBvciVwVGSKX2I
	uBuXQfT46ES2Wji0JIGZycOxXA2aRFG75XqXDDpnyYSExjBY1JLcBseZoD5zaw7EjQv8kLB9nNT
	QSNuyNVnfUtq4wc8EI4Tc+05FGrBiyORccXZKRXEYq1VsDLWxR+5e05bbCc+P+2cGvWsJ5l+mlj
	LuCvIx5lx9Qy2xEubTzfuSFcc6DuIREU+rA82igTKD8bJdftJeSMQROOAEM2cTArKljvHCaYb07
	gCFN22amCjyyY2X5iyOLkTjQa8xFTJOOBdCZO5jsTAvr6T2xwVQJ5xpytctlnfexpaSwD33JlHV
	dQJ/l9DlLxX3M9vLSDhDsVL3vyLlrd0+DNshuoiewJJiE5AQQ=
X-Received: by 2002:a05:6a00:4fc7:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-8352cdd625bmr9607272b3a.0.1777902819562;
        Mon, 04 May 2026 06:53:39 -0700 (PDT)
Received: from localhost.localdomain ([165.132.143.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515893f14sm12641246b3a.17.2026.05.04.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:53:38 -0700 (PDT)
From: Minwoo Ahn <mwahn402@gmail.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jinkyu@yonsei.ac.kr,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	mwahn402@gmail.com,
	namhyung@kernel.org
Subject: Re: [PATCH v4] perf/core: Fix sampling period inconsistency across CPU migration
Date: Mon,  4 May 2026 13:52:53 +0000
Message-ID: <20260504135253.1649829-1-mwahn402@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504080832.GO3126523@noisy.programming.kicks-ass.net>
References: <20260504080832.GO3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, May 04, 2026 at 10:08:32AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 29, 2026 at 09:51:34AM +0000, Minwoo Ahn wrote:
> > 
> > When per-task software events are sampled, period_left is not
> > managed consistently when task migration happens. The perf_event
> > may observe a different hw_perf_event::period_left on the new CPU,
> > breaking the sampling periodicity. Even if a task was near its
> > sampling point, it would use a stale period_left after migration.
> 
> How? This is just vague words, not actually saying anything of
> substance.
> 
> > Introduce struct perf_task_context as a per-task container to
> 
> How can you propose a solution to a non-defined problem?

Let me describe the problem more concretely.

A common per-task sampling invocation such as
`perf record -e task-clock -c 1000000 ./a.out` or
`perf record -t TID` opens, unless the user constrains it with `-C`,
one perf_event for each online CPU on the system. So a single target
task ends up with N distinct perf_event objects, each carrying its own
hw_perf_event::period_left that only counts down while the task is
running on the CPU that object is bound to.

When the task migrates from CPU_X to CPU_Y, the event on CPU_X is
scheduled out and the event on CPU_Y is scheduled in. They are
distinct objects, so the partial period accumulated on CPU_X stays in
that object and is dropped, and CPU_Y's event resumes from whatever
period_left it last held -- typically a full sample_period left over
from when its hrtimer was last armed.

Timeline (sample_period = 1.0s, migrate at t=0.6s):

  t=0.0s   on CPU0; event_CPU0->period_left = 1.0s
  t=0.6s   migrate CPU0 -> CPU1
           event_CPU0 sched_out, period_left = 0.4s
           event_CPU1 sched_in,  period_left = 1.0s   (never decremented)
  t=1.6s   first sample fires on CPU1   (task expected one at t=1.0s)

So sample intervals seen by the task no longer correspond to
sample_period.

The example above uses task-clock for clarity (sample_period is in
nanoseconds and period_left counts down with on-CPU time), but the
same mechanism applies to any per-task software sampling event: each
per-CPU object holds its own period_left and the partial progress on
the source CPU is not transferred to the destination CPU on migration.
What is dropped on migration is the unit each event counts in
(occurrences for non-clock sw events, time for clock events).

`perf record --per-thread` avoids this by opening a single
perf_event with cpu=-1, but it also disables inheritance, so it
cannot sample threads spawned after the run starts. The default
per-CPU mode is the one that supports inheritance, and it is the
mode where the inconsistency above is observed.

The per-task period_left should remain consistent from the task's
point of view across migrations, and that is the motivation behind
this patch.

Thanks,
Minwoo
