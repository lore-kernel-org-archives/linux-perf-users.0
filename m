Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011123875D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167318; cv=pass; b=aZCKNunzkgdHJG9ShKrnSXoWtXG2iSiXQo/i5y0kHoz/a9mI01liCzfYqulTl+WZsdUOX2QdUpsgBtTz8aGx+4BRdLUuFWBCJAF/YUJO6o8pvkdbHB0vgKsnJ7ltkLjvWvf0yeh5GI88uTkBu/KeaOCRwMgHipLNYnbm1MJoVHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167318; c=relaxed/simple;
	bh=dDmljR1YaDmWJButTVewOKZbQwpxrVcPMzLSR6XPJz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNV9ipXW2XNV+JMjIYCQd2qygj8SpxNUqecPCrZTvGMvTAKsS9XYaz4O10sjyAkfSFhSugle1OQVodiJoIykEgZ7GTryJ6wSMtWF2gNl0CRVCSl1ze0StGYko70vWG5C3DK/afyrblzp/I7vVBlVyAkRjz9pZXuJ7NasiXXx2Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In6Eb6E4; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In6Eb6E4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so3048981a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 17:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770167312; cv=none;
        d=google.com; s=arc-20240605;
        b=LSqFN411AZyZxEt6tXOnpGV4LpzHx1epacI2jm9YLqohMa4WeoufExkMsCDz8XnCqk
         USPh4SJsHb1XPgS2y9zLbhhgCR5Rzlsz2b7dxDQKXMNxR2IvEEcb1nCaIrRTTJx1Otis
         rrPg5UCde6GUzCWd6vY+jVyzTUsiacaIG8Y15lIGXv2ZutqhA8UDrGmOHToAVIvM2zd6
         Dv+3nS9cfvH0FmDFb1/eZbx3RwIEQAPtdLxYBDMAsxwODm/17uTbP2CfDudIKfpK1FlN
         S32eSmBmD81xUGjbCyWCL1igZSJcqdZ1V3H9belY1mDSdbB2szpvTHr3oWkkWTK8Xe+W
         ZF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4AVLtBv+ItNA7W6L6HcrhBQtwBUytUYB9z0TDRmd0oU=;
        fh=ZfOnLQFJQs3UpnVlSIRYHFAGdw6h94eE5CqwkJy6Kzc=;
        b=FXHANYnWDqjp2yw7twam3K+O160wVfPOJ7+8sCm9riARqoLRziwOXHnYa28yay1v3r
         YOhRpz1xwRFWhna0kkgJ4v8TPjcDIGoxafuuXrnNa3JOj580urcE3qTu2hDi71Qlp3An
         qCX29i89ax8DZMofGJliRnxVKhLGFlO2gmNzx8gv+WUA7mqUZGJemBaYRiF1AHR7zvLe
         e8ZZJ49i48GwTfb6Vw8uDqw0zoTMRnR/seh+yE8w3qdVo2Jo3bZUCQBZxVpX1BnkcMVQ
         C96154Fo3QdTNqLDbGMw0uwD0FB++uR/6i6HX2N6gCm2Gehj5VnHB2IJszn7w68jXRS2
         RQEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770167312; x=1770772112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AVLtBv+ItNA7W6L6HcrhBQtwBUytUYB9z0TDRmd0oU=;
        b=In6Eb6E4yLLKnmAImHwkKEfKjLo4xxFTok+eB1l3ENWQ/5YfD5xvRJ7iNu5hIAwjNN
         zxk6xZi+n6mBGANKeO8vsk2BVJtmplBGoFclZAmnGRdVl/FIsZNpCJ6bX3cenQh/0ptp
         IO8k7LtNci2NeiTJOjQ6vbzfu2QSUqO97WrJA2R0oBNQtJ8XcvhBgMag6CEfQOZLAb4s
         wM3LDkygud0Yxzjnvaa44L6gfVPG1IvVrBXZjCGRLVhxnJ0J3mEcZpahCsMmSxCf0smv
         8El2uAF6cRgDYNmW31SNktW6fVZwAP7JwDmOudJC8d2MFKpFZ24pW0oQfR8Pv2AdmBFp
         JgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167312; x=1770772112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AVLtBv+ItNA7W6L6HcrhBQtwBUytUYB9z0TDRmd0oU=;
        b=fw63TwrK5+GUghE74GgAZx+OHRHFetcF+cTVaIGDmg4L3u2hJ3kOECIg3bElYUV/ak
         4U1cLmqb0ZmZ2kGVCXflqbCXDwl0JS1QmDNW8cFvtcY8TI6KMifsJGz2e8PChtnU4Cxg
         IfkhvBCrVXf+DuZNCvMF2H5EbY3B8kZR/wdbe9dx1Uc90cJo37lNZ5MUQUFrmEVgPPnB
         aQ8Tziapu+z88pxPGvkgeyBkz3UKsR42Td5w6dx+LXSudJSV6pfHqZUeUmqqg7Di7/9p
         L4GUr0RidtMmkt8dGTi3d1pA1a8nSbFbXSynOE3Lxr4ilFM6Dvl2EoxyEzJQiIYrX9tz
         mPhA==
X-Forwarded-Encrypted: i=1; AJvYcCUuHt9Hvet/25u8xeDCn6DbgcpDrtVBw2tGIHb+OQAy05I3q23NqHbjIa0geF0CDVyLY8F7IrQ9NkIqZdw+NSDW@vger.kernel.org
X-Gm-Message-State: AOJu0YxuW5lf65Vi79eknO4p8F6g3xRYoc4o8XZh2ByDMUdbXuSAZnGP
	2A6WH4bCOMpT0S2ZzW9+JrR1lplTrmKqkk5sNeeLLROY00Mu35/XU0n2g3mbGMdyCPzZyOWtOqA
	FkTtz3CJ5nOQ1ku3y6YvR1kuKqgn/neI=
X-Gm-Gg: AZuq6aKb4Tt4GLKxz2s2MZrS19YDhf8jeHyGHDm7GKrXmBW8gIz284WdDledyvmNSOH
	4/lzWnSUoiWE5xqvTZPa5+WpNrLp3MbVIwdNXZ5llOKKwJN0N/RvUzkZNxoke5BS3ztLRu3ZkNh
	UlF60AxWppYKdfwD6gshpbS+PpwSRacooOWHV0h16jYa63vTA8mOe7h34QecHDg4AGkWQHrfPKz
	pNFVLyZqNcXpLWJJzdXiF+bU2jfziTJComPTaqTJnn6plDvygdkJWJPF1rjfCk4CaxFzaz70s3+
	F6TZ7tXwmu0=
X-Received: by 2002:a17:90b:5246:b0:341:88c9:ca62 with SMTP id
 98e67ed59e1d1-354871db0e9mr909509a91.31.1770167312372; Tue, 03 Feb 2026
 17:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev> <20260126074331.815684-3-chen.dylane@linux.dev>
In-Reply-To: <20260126074331.815684-3-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 17:08:20 -0800
X-Gm-Features: AZwV_Qgpn8-cdsaGEqd4GfMTjYIgHVfw8Z0o0OS8K2yxYhHzNsrLuAVXEUnQ4Ek
Message-ID: <CAEf4BzYMJfQN+0SwzBM-DhREHwZ54TwA6GUtFv9=xret9pzXrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 11:45=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> From BPF stack map, we want to ensure that the callchain buffer
> will not be overwritten by other preemptive tasks and we also aim
> to reduce the preempt disable interval, Based on the suggestions from Pet=
er
> and Andrrii, export new API __get_perf_callchain and the usage scenarios
> are as follows from BPF side:
>
> preempt_disable()
> entry =3D get_callchain_entry()
> preempt_enable()
> __get_perf_callchain(entry)
> put_callchain_entry(entry)
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/perf_event.h |  5 +++++
>  kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
>  2 files changed, 27 insertions(+), 12 deletions(-)
>

Looking at the whole __bpf_get_stack() logic again, why didn't we just
do something like this:

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..80364561611c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
struct task_struct *task,

        max_depth =3D stack_map_calculate_max_depth(size, elem_size, flags)=
;

-       if (may_fault)
-               rcu_read_lock(); /* need RCU for perf's callchain below */
+       if (!trace_in)
+               preempt_disable();

        if (trace_in) {
                trace =3D trace_in;
@@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
struct task_struct *task,
        }

        if (unlikely(!trace) || trace->nr < skip) {
-               if (may_fault)
-                       rcu_read_unlock();
+               if (!trace_in)
+                       preempt_enable();
                goto err_fault;
        }

@@ -494,8 +494,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
struct task_struct *task,
        }

        /* trace/ips should not be dereferenced after this point */
-       if (may_fault)
-               rcu_read_unlock();
+       if (!trace_in)
+               preempt_enable();

        if (user_build_id)
                stack_map_get_build_id_offset(buf, trace_nr, user, may_faul=
t);


?

Build ID parsing is happening after we copied data from perf's
callchain_entry into user-provided memory, so raw callchain retrieval
can be done with preemption disabled, as it's supposed to be brief.
Build ID parsing part which indeed might fault and be much slower will
be done well after that (we even have a comment there saying that
trace/ips should not be touched).

Am I missing something?

[...]
