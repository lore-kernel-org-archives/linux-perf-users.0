Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733D44AB92
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700011; cv=pass; b=ExvtRdaVIKYaSoMHi2/o2oFBwRO/R+5tqdfWmAwWuvDQs2RTD7FdEC9weZbecPMoQ6gotSHqncOOpQpGK8dAdNjeYevyhfdKzCvc0AqiDjxS6jjyIkKKWVbXg02CMegXc+GEi7FtgQ2eHTsY7cXoIhEmonvxixsPBM5npNmBawA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700011; c=relaxed/simple;
	bh=igivdVsOvPHIveFIaxIikiukbyuGfGdliAya+L1VVGE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uAR7PaRmzfs+jSpiKskjoec+pg+vJr7lLEkYvQbzVApCgHu/mGd+LyCZ9iLip9I6DGFU1KRvu372rn36E5Wbv0jMm11As4A4xe9pJuG5kRHN5vXi4DeKVdZrKkffL2u5GEBBjKsSMI5qGwk2xojBEzSUZubGyeuAJGkXKWlzjZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw/hiqse; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw/hiqse"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-745497ac8fcso2468106137.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784700009; cv=none;
        d=google.com; s=arc-20260327;
        b=ljftAChvvC7aKYqh+Cl4xNCdDMP9tdsI26yYwX/fuXahpK5I6Ym9/7xujeb4lZlMOF
         Bam+fOmdLcZoyu93eCEjdG1Fs5hgK19HC65SGlUQZVA8+acBYZH1v0HQiVU4gcgjOJ0+
         OkusepFM2VXYGXzgq3UFV8fObd5jnUQcNrKIv3K15w9K6u7unwMfvUsEu7k+7tqi37a+
         7sWSW1qcS9JAIk6yFn6JjUeqw8VyG9eApJGj//3SytsxtsCEujTDfVmqkSJnQvV80O6n
         c9A/Gd5zbibRYnRkcFR1GEVietnKm0OH+oqXT/OjpVPl/4sBdziEl/CEox4v4iQFne4m
         DP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pmomoS5p9LVckUY8+ABJ8OTOHtPZkYxN4zD6iAYjDpU=;
        fh=c7SEq5UWyfmRqUB0b1Nx4a0tC1ic3k6Tn+lOxkLnqjI=;
        b=Je/df1fbbz2mviBAhOyAb2LhDMvLAioQqWal7FtrQRCw9MkPjT4c25/XGKR6HoOZjh
         WmtZQsXdp9qfoyqAG6Xp4cRyoMKY19p4QIgHSvUO+8nsS1OV0YrbSzv5R0Gb9p9t70l8
         VnFt3bgR7R77UsRGXbj3VcuX2Qdk8/RqqvN/WvpNZIeOC3B+9CxQ5Zs/xs/HyXYNwXRF
         0AWF6W3Phmnwopo5ba3WB21M42Z3YRRQD/dRpmN28dMclSbQzlVsURkkne2XTA7cTnWw
         VXO+HKjF55QrehKHUE9P91SJacoI++modWqpMceourvWgZgraflO/5VsfAR25PnrIMCa
         WIHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784700009; x=1785304809; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pmomoS5p9LVckUY8+ABJ8OTOHtPZkYxN4zD6iAYjDpU=;
        b=Mw/hiqserAfk/o0/XSDDPEgnvpgBompPskJXOy9HX12p9kHWwL9O86rZgt7U1lw8MR
         HIgWBsJ074bue770qFp6gGGIhrzyZZsLuEH+U4pdOMmvqMV842p8ZLz+lBrP3atce8y/
         bny0SjTfykoOS5ALrDBRb9FDB2PWLS6QcXGSyvI8z39/A+lnHm+VsZ0l61tQPK01ynKv
         rNXOjVfpyE54G5G2qxG6z/M+qZfJwMgDYet43y2z4qqKQXBwYS2OtQdfMjPF/qQ4Q5kS
         b8Fc98YbmBZOu0G4fIPfndCEI62bF3Kp4WbYf1Le8GXmebuEpmdh1E6/7VUfY7sYj0N4
         rOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784700009; x=1785304809;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pmomoS5p9LVckUY8+ABJ8OTOHtPZkYxN4zD6iAYjDpU=;
        b=B+Bw4xw9E6fawodjPAeYoNN5Nfhe/xsAXkcDMOAUhQdDzpqD3eOaN5Sn+Vqv/W36Vj
         2O5YXElKBkxKTtdJm3DaHM/BGYl/7A/1V41NAlNwFGwI8AG0SvgwGN0dqAi1+WGyhZHB
         mSwMCu1zEBKq4/7bQkuqcpxl7YJ+Z5Vgoi/DB1VlBAk5v3hHPQKrqtoC7QTWLyQq3rcW
         fl4ECR7MD1ZSY3zw7hPYYLo3QA1ylH5wYVCsdEFO56oDWVK+oFwSONbYYCTn+fqGMHuX
         0RBWDqSHCyhXzTj4+86e81VaHRboq0kroN3dXAZaSrFEd7uC/lut/rcCeH4wVzNP4LjU
         mjuw==
X-Gm-Message-State: AOJu0YxCiBX94RoVSRGYDjaQjAAeSYqAXlfbTSNBtl19l3pfFy8HnEbB
	WdPgUzF9rE+FNbkH4FC0KThe1fi87JSFXJN+q7F3k2LLzzrsOdAErRVVXXcKRPZ8vASSQYme2+l
	WOQmVRDbAuhERVuT8xjcOA6XEK6OrcmE=
X-Gm-Gg: AR+sD11vAc7cTGNQHRoHnVT8AL3aL+K0XTPIoOg3vByVi7IuwYoFCg7n/M7P2Q7WgTa
	mRR7qG4sEYXvmYYXgyolaAvOPVTCjtFZM/fGZh4pS+6yJHwob8g98mQFxX/dzrYht9z98d/wBgL
	SPaHe5k7pI4RoeETHSbWu9twRqwyPydsjSaSzlF04v7sdHBw+RQmNLTas1a+yHjaz64W93TgWWn
	XHkaBaSAgZ3EZ7Wds2UgcFA4Y1GUw6BbAPtwKx+vO2P7XUdygNVBZGoEPvcTF8=
X-Received: by 2002:a05:6102:162c:b0:737:f0ba:508f with SMTP id
 ada2fe7eead31-7475346947bmr6777616137.3.1784700008727; Tue, 21 Jul 2026
 23:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael B. Dias" <rafaelbttdias@gmail.com>
Date: Wed, 22 Jul 2026 02:59:56 -0300
X-Gm-Features: AUfX_mxKlyj31H0X6qrRIuSLP6TbGoj4aTtPSStNJlXw2ZYIG_odi09MnYfhFBg
Message-ID: <CAFhB66oYbThmK59NiT1YwFZ4z=xkNxj9paga4EJW+mGFHa8f8A@mail.gmail.com>
Subject: [BUG] perf: cross-mm mmap teardown unaccounts pinned memory from the
 wrong mm
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexander.shishkin@linux.intel.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

perf can unaccount a data-ring pinned_vm charge from a different mm than the
one it charged. An unprivileged user can repeat this to create negative
pinned_vm credit and allocate perf ring pages past RLIMIT_MEMLOCK.

The first VMA that allocates a perf data ring charges the excess pages to
vma->vm_mm->pinned_vm and stores the amount in rb->mmap_locked, but not the
charged mm. If another process maps the perf event fd and closes the final
VMA, perf_mmap_close() subtracts the charge from that process's mm. The
allocating mm remains charged while the final closer gets a negative balance.

I reproduced this as UID 1000 with CapEff=0, NoNewPrivs=1,
perf_event_paranoid=2, and self-owned PERF_TYPE_SOFTWARE events. On a
two-CPU Linux 6.12.94 guest with perf_event_mlock_kb=516, the reproducer kept
270 perf pages live, used 23 short-lived address spaces to create 16,385 pages
of credit, and mapped 65,540 KiB in a receiver with RLIMIT_MEMLOCK=0.

The vulnerable result was:

  RESULT mode=vulnerable mmap_errno=0
  LIMIT receiver_memlock_kb=0 perf_mlock_kb=516 cpus=2
  BASE allowance_pages=258 filler_pages=270
  CREDIT pages=16385 requested_pages=16385 requested_kb=65540

With only the accounting owner corrected, the same binary returned EPERM:

  RESULT mode=fixed mmap_errno=1
  LIMIT receiver_memlock_kb=0 perf_mlock_kb=516 cpus=2
  BASE allowance_pages=258 filler_pages=270
  CREDIT pages=16385 requested_pages=16385 requested_kb=65540

Commit 26cb63ad11e0 ("perf: Fix perf mmap bugs") introduced the data-ring
accounting pattern. It remains in Linux 6.12.96 and mainline commit
248951ddc14d. AUX teardown has the same final-VMA assumption and also uses the
data ring's mmap_user when a different user allocated AUX.

The proposed patch retains the charged data-ring mm and AUX user/mm, then uses
those owners during final unaccounting. It passes checkpatch and builds
kernel/events/core.o against mainline 248951ddc14d. On a patched 6.12.94 KASAN
kernel, the same reproducer returns EPERM. This runtime test covers the data
ring; the AUX change was reviewed and build-tested.

The source reproducer is available privately on request.

Until a fix is available, workloads can block untrusted perf_event_open()
calls with seccomp or an LSM.

Regards,
Rafael B. Dias
