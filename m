Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E8470EB9
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791591; cv=pass; b=XTfhYTZuwmEoRUHBYp6rETCzJX0jI+0+XRCKD27TVap7dUpgE+dlYky5ReJMqx5U/gR83mI4otCeF3EwPUqvT24xojdH82o9EcntntSEQbOHgTeGULUSpK/X9lcak69/LWxtWseHcZG0xIfrelHFbDswdoj5rxU9w3OeG5Alri0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791591; c=relaxed/simple;
	bh=2nEvFBMdhJgSNJqGqxUejTWHPfeJ3XTzfHyWg5nP0Y0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TS68eMm2Whay/xjcW4zfrGyWY7HgjWL7pVU9sx0lJKDd5sGz96UP5R7OdeIWD7uNk06pkndaFqBd+N6IRE7rqleCngZ0PgAvFRAZpPX+FO+BPs7oafJlGD8Y3Kpk3CZ+w2C+VA4eX0F8f8WJGI+gst4qoCH9QVs0kVL4ParL68g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQzxhSrd; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQzxhSrd"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b1a1a442c1so2428407eaf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Sep 2026 07:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788791586; cv=none;
        d=google.com; s=arc-20260327;
        b=p1kw2zYqmVId16NVniYVOtr4Fb1ql67VtmP7Po7pzrC51qjLT29rxFAGIUNuKv0a/s
         HDPIcWWazpuRqaAtefaH4IWoeJFY5RWPB2yyNj2CT2CscuUIQO/z6QXLaLvVWpNVD9wA
         VYvSB/SkiQqWgI0A7Mmey0i9a9UjCj5VAikVUKh/tkiyLjAITobo6we/4wd2SPKp02JM
         GKy9coepA7SuMsIDEg2lexa55UP5kglvhOM2D+HOFOKVR0zMova1ZPJH3V2ONapTxqGZ
         5UvWiVJWCmJAv9GRt2nSewBp5VEOvYYnzjD63kLT8MSmr9mNuKEro4X+wAxvHEvjT2UJ
         2BiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=aw/I14PjLqxMlfwn9Wc8/sLmMP8s19e2n/OZfMgOjdY=;
        fh=SQ7NAkp7iiy4Ngc/zYhsg42O42oUEocLGuxpHaSWm4M=;
        b=KyL8kQUmKN/og9jOLFMYw45pWdnKN0uDIawpiIeJGfw2oWNZJ5lzSUuuZwakKpXYGk
         UN5n04nLkvlvAehaa7wuPu9ygOB5b4GXUNJ+Dd5+wRStXrwjsVQSbLkwIGNzadOmIUkr
         RsvHEXpO+87iC0Ifs7z1B5dyQx0yay5QpECgh2o1VjKWPDNQ+9IxcnAJPKiUvMt325Qr
         ssk/xSO1fAOTYBL8oCAXlFw6bV+4rGNj7kONZfBbD7LbjflEMDs5wGinHhfooRV1OvQf
         twCatxoBKS+3ldUoQ8LdZuZHCYtzClfJ/oPDDkd2M2Y+3nwxae0L2yP3R1+V7BEdiD6f
         bE4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788791586; x=1789396386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aw/I14PjLqxMlfwn9Wc8/sLmMP8s19e2n/OZfMgOjdY=;
        b=MQzxhSrdsUS/on+BfmujaNz2+h+9M1stiq3y3fYgnShoFsHHwlaGk4gI8nQpUz6SJN
         5JDv9XTj+YTUGZ3OiM2CuEaxwQgADoIkL+tuQP9mpo+ZGvaaldYC1j0mg8KuNnCJzoQU
         HkVip2Z9ZowMZTbv3oNzAbG5NpvSGj9fM+QeQQaeEXC6/Qw3IPj3wWJjm3F5eqIMqCQn
         0MAuMGmAYwEPrTPskorKFtVToZ8LDVPXtO2gUfQSz1FnT1Vw7oFBqIglIyw01aTPCxLa
         jYB6nNPXsT9Q2K+sX4tAbKSmcRT2+QVgWGUvfkxYXkOx2T9ISOA60ElsK06xjRx4ejRL
         vhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791586; x=1789396386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aw/I14PjLqxMlfwn9Wc8/sLmMP8s19e2n/OZfMgOjdY=;
        b=bLfPCOhGM8wTOhUSXmoqb+rrGx5LdgvVYNkE1KZ4Vg2p65zrmNzOoyda0gePlom9Ns
         0dcnk9Grlkhnr/azVYU8o6f3V7nzwkGRGhdQffPMLLBJoHoovS2luNo2CRX2YeSS9fu+
         DmNZmZT48elu58Nz23SSXrWMTdwdXueU1ob/TdYq34WaWq0WE39YcR2UPlZ9Gz5s66ea
         dcfVBgyrt2FT0WXHVcG7908j9CbWJjYME5Cf37qlUIQ7iUyQAB4waPqC1Lbm/oWSC7j0
         M50P+Tdmo/qikbTf1QxGMWY0c4qA6mVHpLyz5e4eKtDp5rwdbkX8WOody0aj720kgHuU
         k5Tg==
X-Forwarded-Encrypted: i=1; AKwUvBzlYRXw7qilhstaYVzSU0TGZSaKzDccHqhhoU1Ab+pvfLL2DPf+saRNNG9vrGp+p9UGDUiZj/i9lX9QdwmOuE1l@vger.kernel.org
X-Gm-Message-State: AFuF++kTY98fW4wmPzBgQkzwXkdU86R9hoOA0pFWgTCRJ2OyRnm4wFyf
	HtsfMh5uVHzcaeLgdWhNviuD86QYaZG+9LOE8NPANJuVVti/BSE2HOJt+DTqSYZH1h5ARYZcIdx
	V58XOlSRqAG5h9ZgUvkH0CuPwraI3mrw=
X-Gm-Gg: AYBFou2rb79ZBxOa6DFB3rAz9oTZo3ShWRj0hyajfCAEVoNc61Ujxny6u4xStfVuMnk
	on6ZuPTfk/2DKP++uTwdbbnVsmMRCTQD1R3vokWfHaAYOWGQ5mybIZLeNRptcrEA3QQri22txU+
	gQTYY7MD0fIgV6A6ZIRx4vgmgyoa1aMCCa4zWLBsObL/l2TAjpdk0s1SE6y1ilNinusVQ7ji0GO
	NcDWl/sCxuA4UuMR824ocB7Pixz8RdbHdwOIzqH1GpzgAtgLLyo9O50pccBdwPx71jJi1ls5gyy
	r0S4FHzTEHgHxDexLjDy4opfulGZDEXlTw0tHnbYbSLZ
X-Received: by 2002:a05:6820:290b:b0:6b1:39b1:80ee with SMTP id
 006d021491bc7-6b6fe796fd6mr21967862eaf.24.1788791586103; Mon, 07 Sep 2026
 07:33:06 -0700 (PDT)
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 7 Sep 2026 07:33:05 -0700
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 7 Sep 2026 07:33:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jihoon kim <kigihi85@gmail.com>
Date: Mon, 7 Sep 2026 07:33:05 -0700
X-Gm-Features: AcwNN1W84ahu04IwVUw6e0PdRBAHXJrOP3ZWHAeZnJqQKWjnIEyuihUuQY5OljQ
Message-ID: <CAAyWcRWWULkDa9L+Qgxt8c_mAbdYAU4uUA+51HhEKKDao-1KMg@mail.gmail.com>
Subject: [BUG] WARNING in perf_pending_task() outside do_exit() path
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

While fuzz testing mainline (syzkaller, arm64, local build) I hit the
following WARNING repeatedly and reliably:

------------[ cut here ]------------
WARNING: kernel/events/core.c:7629 at perf_pending_task+0x268/0x2a4,
CPU#1: syz.1.79/2934
Modules linked in:
CPU: 1 UID: 0 PID: 2934 Comm: syz.1.79 Tainted: G        W
7.2.0 #1 PREEMPT
Tainted: [W]=3DWARN
Hardware name: linux,dummy-virt (DT)
Call trace:
 perf_pending_task+0x268/0x2a4 (P)
 task_work_run+0x124/0x1ec
 exit_to_user_mode_loop+0x1f4/0x210
 el0_svc+0x1e0/0x270
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c
---[ end trace 0000000000000000 ]---

This is the WARN_ON_ONCE in perf_sigtrap() (inlined into
perf_pending_task()):

    static void perf_sigtrap(struct perf_event *event)
    {
        if (current->flags & PF_EXITING)
            return;

        if (WARN_ON_ONCE(event->ctx->task !=3D current))
            return;
        ...
    }

Why I think this is worth a separate look
------------------------------------------
This exact function has a history of related issues:

- CVE-2022-48950: a use-after-free in perf_pending_task() (fixed by
  extending the perf_event's refcount across the queued task_work,
  commit 8bffa95ac19ff27c8261904f89d36c7fcf215d59). That fix
  (put_event(event) at the end of perf_pending_task()) is present in
  the tree I'm testing, so this is not that bug.

- commit 3da6bb419750 ("perf/core: Fix WARN in perf_sigtrap()"),
  2025-09-04, fixed a WARN at this same line, but for a call path that
  goes through do_exit()/do_group_exit()/get_signal() while the task is
  actively exiting (ctx->task pinned to TASK_TOMBSTONE).

My reproduction's call trace has no do_exit()/get_signal() anywhere =E2=80=
=94
it's a completely ordinary syscall-return path (task_work_run ->
exit_to_user_mode_loop). So the task is not exiting, and the 2025-09-04
fix's precondition doesn't appear to apply here. I have not been able
to pin down exactly how event->ctx->task and current diverge outside
that exit path =E2=80=94 reporting in case this rings a bell for people who
know this code better than I do.

Severity / impact
------------------
I don't believe this indicates memory corruption:
- The WARN_ON_ONCE only compares pointer values; nothing is
  dereferenced before or after the check on the taken branch.
- This build has CONFIG_KASAN=3Dy; no KASAN report accompanies the WARN.
- I also built a variant with CONFIG_KCSAN=3Dy (KASAN and KCSAN can't be
  enabled together in this tree) and reproduced the same WARN several
  times; KCSAN did not report any data race.

So this looks like a WARN-only assertion violation (no observed
memory-safety impact), but given the recurring history of races in
this exact function, it seemed worth flagging rather than silently
working around it.

Reproducer
----------
Minimized by syzkaller to two syscalls:

    perf_event_open(&(0x7f0000000000)=3D{0x2, 0x80, 0x77, 0x0, 0x0, 0x0,
0x0, 0x9c29, 0x147cb, 0x8, 0x0, 0x1, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1,
0x1, 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x2, 0x1, 0x0, 0x0, 0x1, 0x1, 0x1,
0x0, 0x0, 0x0, 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x1, 0x1,
0x1, 0x0, 0xb, 0x4, @perf_config_ext=3D{0xfffffffffffffbff, 0x100},
0xa1, 0x3, 0x4, 0x6, 0x7, 0x8, 0xfcbe, 0x0, 0x0, 0x0, 0x2}, 0x0,
0xffffffffffffffff, 0xffffffffffffffff, 0x2)
    io_uring_setup(0x25fa, &(0x7f0000000180)=3D{0x0, 0x6bc, 0x2, 0x0, 0xaa}=
)

A standalone C reproducer (autogenerated by syzkaller) is attached
[repro_perf_pending_task.c]. It reproduces reliably within ~20-40s of
boot under syzkaller's syz-repro tool; I have not yet reduced it to a
hand-written minimal C repro independent of the syzkaller harness.

Kernel: mainline, local build tagged 7.2.0-g26260251022f-dirty
Arch: arm64, QEMU/KVM(hvf) virt machine, 2 vCPU / 2GB RAM

Happy to provide the full syzkaller log, the C repro, or test patches.

Thanks,
Jihoon Kim (Harumomonabi) <kigihi85@gmail.com>
