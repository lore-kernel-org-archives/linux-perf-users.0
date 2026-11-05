Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793912216;
	b=V5BrRgPFopK8DK3FZ8PLAjaTCfzZ+nlQbdj0ZYguPEaOE6QTGLgTmI+Fua6EJNdaFsEV
	 wGPD/C+ZdbtSLf9hEi+v/qXvxhs4cBeZqezLhfXgJHjLNDChyg5ZO9D4BYypaPjfmYDva
	 3AfCU7hztPb86mmZND0WpQPclyFwrdplgG2uuf1vwy9sFWeunOh305jWHtDNat6kQ/z4V
	 3ey4CVi+KAjW+bSqwE2G59H48tVXaKlE5ukxls+Zae1iR//Mv/q2SteysswLLZs7/Wf/u
	 70Kyv9U5XbpqmiQozb+Fagew5jzrngQfjmLL4AmKKIkbMuSnrYnJTO/9qP5Q9fDrTQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:MIME-Version:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/phxpzI1UKsSV5tNfaw6aHcef/RF4EXbM4Y9RmHS98c=;
	b=qAtJaTxIPjRHldTONl6oqiOt3rt6hg9zdxnUF0MgDfEhquFINAk0nH6rzWspcNxXgZQh
	 uzoakDewcH8Yx1nwXaX5ieDvzaMAOZKM5laUEh5eLPhStoiT9QteJZWJYm6pTQQe63ltv
	 9PAS/VIxeppwucJXxWke1uK5gGWpwnyS6Cs8h/daveMI1rAuyJlivK7ZYN1ZfK+FYHsld
	 yvvo51Ndmv8qVLBVyXPf3toUEInq8inxmbL7D9vXtceHAs9Wq+PQdwNeqgxvHyB5uVJMI
	 gWU0/QCECzMEEPJErO77hFuStYMyOKRw5EqEuEoQFs1MhLfnczTv1wn3ifAhU412hFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0M7hcgVG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326A606A33D
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 20:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2326A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0M7hcgVG
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c315869241fso363518266b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 12:56:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793912214; cv=none;
        d=google.com; s=arc-20260327;
        b=Tc9auvQw1o+55gI4/foq/A4H2FT1AcCxuTs88cmP8hQ6X22/l7iC+61tCY/gIKnnFz
         bIqd7xZGzCbVtaphBnGZA8/oepxWfuNV6+EIR4uGFam3lu44RBZjxSE9dkBqhVFAvtsY
         HXG9WB7oJw4dwuMO5VBVOhY0vRyWWlPQMMkIlHD5+8vllZlen4IFjDgKJJqx+p8HpCDr
         on8jE6w7MLgckZJdOtFzanuQ8Ql4iPInRYtRvFLuv2GA1LHARUbBsRzprfXtodVoDaK5
         j6JZ5q+kI2d+Li3fbQ0rog/sce2NplHe+fFd0NbXsLuupmC3bhqhzUaZ7cy3LQGIest/
         8b9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
         :from:dkim-signature;
        bh=/phxpzI1UKsSV5tNfaw6aHcef/RF4EXbM4Y9RmHS98c=;
        fh=Zb7yi95WcSjqjKuad3ajqlzqd39iKHT+lwrZiafCnxE=;
        b=V82fwhoGl0n+BwMLo6K+5r7Yo4R49+YB0XD+8ooOJaEDDBzxiTfqJtQRpvYOUY3RsA
         WFPb9g8cgkd/yHAEN++3/p4PtQ6X9YvJVyU0VChG8nBH95OUheiMg+Vn56liD8s2ZZ9N
         uDdoyi3yinNTxoD1883AonXyXMoTRrr82l2n6bARCWJQ/5Ohf39XVB11u5GG2OHCVcUg
         4wFkLFUm/QHYdQ7mWbcrR2AlB62xqgU8tHWZ2QT7LaJ++PGOtPOUu5CeMp6dony5FgtW
         C1QwmKGu5G1+tnhDy7hyiGpdkL/DCGy8pyKg4QMZEYWbGihnK0HD/vmo+MGPseM3t+Cp
         Y2zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912214; x=1794517014; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :mime-version:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/phxpzI1UKsSV5tNfaw6aHcef/RF4EXbM4Y9RmHS98c=;
        b=0M7hcgVGFgbIE5Udh48jwEMtd1uJ9LR4UbVv6DCxojXW6j3R8UhDFSKAnhUGXQyBAP
         HWcgdTD1KqurD7nNt9eufJyaFyQLA/CJ/e/23I/S0hpWbus/b1LjIgMpGllTFpDKT0aE
         ZY5R8RAXJQBoULgo6hE/Z5o0G9URUAi8ASI72nE8RbLA3K96xmwpk+2m7UY4FoULju7G
         GnNlDpdioj/I22eZFoRrp3LlLh46W6hXtPiH18pQljJI1QDAjCJycyIyJ2vfwJQcKgKG
         uZvfd2cYNhNvaOuwFj0zjWsijLLosFqSN1L/+uAeDMsfi8JJX1f4K5Od0jFmQJ5AnIm0
         V/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912214; x=1794517014;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/phxpzI1UKsSV5tNfaw6aHcef/RF4EXbM4Y9RmHS98c=;
        b=LuhuIPDIcnvnXaOQYomtvX+qX5dZBnD7OFHR39cAY9Jzj9nhdWU6WFbaXdU4+zp7eu
         n42Dh4tl39XBu6ATdbIhAPPDTFfs2E/b4rvwuOsvuGptaqinvDQWdoCtAbQ4WSOnQjIn
         Sz3/UACSdyOJOWmKuJid5TZZSLiS21Raxng37s8P9Ca9N86hcOTmpqq1x4HibhSw6dGC
         0Q9egurtXHIiRen2T99mTYmboF1+NftLkDDdPRuQ0Gfe8XrybjNilINpK8D3LSrEXrzD
         17v3+yXj2/nBJO7T/ZY50bDz7dTABNWEb+uZLhEjyfkOvDu/bd+rlbfj6+p2YToEW5CU
         FP4w==
X-Forwarded-Encrypted: i=1; AKwUvBzIQ+ZMo1CwKYlFUvj2aqALpRIYbqFBGHfw8wAyChxkZ0mDMFqLhf1xmCAt6CSTmlWkqO8+EfAdKZMUQ/j4Q7ZQ@vger.kernel.org
X-Gm-Message-State: APuU4Z/4CO8cckTE40vvBq6SdXQOW+2MMtxVETD4sdj7iwqN+Zk394Za
	660cOcjw8NWQ+uZtoUcgmBNRNLvdCCmNFNZ6Duj4SA+Q2IuVqu4A5jUCxWNoc+frhcj3OUUteYh
	D2ihq4vw/4TrtYSXaf40kkiL82pSyLIg=
X-Gm-Gg: AYBFou1m57nlwQ4U+c02I6VHhekE0nxIT0qVyXwAVSREfQQPDDVUdTjNhxdw//b67EK
	VQiWBcmXpqueMyVT+d/I2OGBKf+W8O/k2vtDc+KfrosAp1LGgqGOsHRXpSYv4P0iYbLtLKC9py5
	8TfKZq/VO0mKrsznXWPWphX5mLZM8qlJJFfLKl83uDsLw+DIYfYgPzFdKU+KtAj6hFhasofwK3P
	zsmoriNrd9c7G1eKNN1RJTSVUmNJumPQDu+wIdZ+v3mzsFbVFghvoqdFEYr106mpPQKRcrGCnF1
	zofNhCVwMbyiL3yo7h+KqGAlcoyPZeIPDJ6u2drS3xCYBr1wzPGa2AJaoumSbVv/xTsgYllZcja
	1R7X21WiMRXPvEBMnN8NOZHRXAJQdT+HK3LC1
X-Received: by 2002:a17:907:d22:b0:c3f:7e8:235d with SMTP id
 a640c23a62f3a-c4d351f3023mr53078166b.5.1793912214402; Thu, 05 Nov 2026
 12:56:54 -0800 (PST)
Received: from 374130946952 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 12:56:53 -0800
Received: from 374130946952 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 12:56:53 -0800
From: Joshua Warren <joshua.s.warren@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CADjP6_CC-jv6nyEHaLj=Z0eyjubOJZuiKESqszW3LgTJTTQ_Aw@mail.gmail.com>
References: <CADjP6_CC-jv6nyEHaLj=Z0eyjubOJZuiKESqszW3LgTJTTQ_Aw@mail.gmail.com>
Date: Thu, 5 Nov 2026 12:56:53 -0800
X-Gm-Features: AclHuK8S9km1Ew1lvTGzMPLE6UCtBo_MM5e2JxRFpB85QJDvElEn0nr9hBRZ3sw
Message-ID: <CADjP6_CNzjdi795ZgSeO-RuOou1h97zbp-D-T9edH6G8HPf0wA@mail.gmail.com>
Subject: [PATCH 2/2] perf/core: handle first AUX mmap on redirected events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A redirected event (perf_event_set_output()) enters perf_mmap_aux()
with mmap_count == 0: its first mmap() can only be the AUX mmap, since
perf_mmap_rb() rejects count-0 events with -EBUSY.  The ring-side fix
is commit d06bf78e55d5 ("perf: Fix refcount warning on
event->mmap_count increment").  The
tail refcount_inc() from zero saturates the count and reports
REFCOUNT_ADD_UAF, which refcount_warn_saturate() raises through
REFCOUNT_CORRUPTION(): a WARN_ONCE() normally, but a BUG() when
CONFIG_BUG_ON_DATA_CORRUPTION=y.  A saturated count is never released:
a later AUX mmap() of the event adds to the saturated count and reports
REFCOUNT_ADD_OVF (a WARN_ONCE(), silent after its first report), while
perf_mmap_close() takes the saturated count silently --
refcount_dec_and_mutex_lock() fails without warning -- so the close
path that detaches the event from the borrowed rb can never run.

Reject the AUX mmap() of a not-yet-mmaped event with -EBUSY, matching
the ring mmap() stance: the redirect keeps the state
perf_event_set_output() left it in, and the shared rb's counters and
its user and mm accounting stay untouched.  As on the ring side, the
reject avoids creating a mapping that aliases the borrowed rb, so the
shared user_page and AUX area remain the owner's alone.

This changes observable behavior: the first AUX mmap() of a redirected
event now fails with -EBUSY where it previously reported a refcount
error and saturated the event's mmap_count.  Only flows that are already
broken on this base are affected: a redirected event's ring mmap() is
rejected with -EBUSY already, so its AUX mmap() could only ever report
that error and saturate.

The impact of the defect is availability only: the count saturates
fail-safe, and no use-after-free was found.  The defect is reachable by
an unprivileged user through perf_event_set_output() (PERF_FLAG_FD_OUTPUT)
on AUX-capable PMUs where userspace can create the AUX-owning event.  On
a default kernel the first such mmap() prints one warning.  With
panic_on_warn=1 that first warning panics the kernel, and with
CONFIG_BUG_ON_DATA_CORRUPTION=y the BUG() oopses the task regardless of
panic_on_warn.

Tested with a source-level host harness that compiles perf_mmap,
perf_mmap_rb, perf_mmap_aux, perf_mmap_close,
perf_mmap_account/unaccount/calc_limits straight from this tree and
drives full ring, AUX and redirected-event lifecycles over them
(single-user, single-mm, single-threaded; nothing runs in a kernel):
the previous commit's source fails the nine redirected-AUX scenarios
(the AUX mmap of a redirected event saturates mmap_count), this source
passes all 33, and the 22-case alias-charge harness still passes.
The harness is tooling, not part of this change.  Compile-verified with a
focused x86-64 defconfig build of kernel/events/core.o; the kernel was
not booted and no runtime kernel reproduction was performed.

AI coding agents in the omp harness wrote the patches, the reproducer
and the measurements.

Fixes: 448f97fba901 ("perf: Convert mmap() refcounts to refcount_t")
Signed-off-by: Joshua Warren <joshua.s.warren@gmail.com>
---
 kernel/events/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c8bb805bc..d336e5747 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7419,6 +7419,17 @@ static int perf_mmap_aux(struct vm_area_struct
*vma, struct perf_event *event,
 	if (!is_power_of_2(nr_pages))
 		return -EINVAL;

+	/*
+	 * A redirected event (perf_event_set_output()) arrives here with
+	 * mmap_count == 0; perf_mmap_rb() rejects its ring mmap() with
+	 * -EBUSY.  Reject its AUX mmap() the same way: the tail
+	 * refcount_inc() below would raise mmap_count from zero, which
+	 * WARNs and saturates the count, and a saturated count cannot be
+	 * released by perf_mmap_close().
+	 */
+	if (!refcount_read(&event->mmap_count))
+		return -EBUSY;
+
 	if (!refcount_inc_not_zero(&rb->mmap_count))
 		return -EINVAL;

-- 
2.39.5
