Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50C30E0DC
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974126; cv=pass; b=B/26qlKcGgvQYhJ42bdN/xUVL8ZGcOGtbAneeU01JerOs0W8XOAoy13kk3piFiLdxLfju+3QxLi1jgdXQeZNN24iU3LqPgHS59eIUc9F2ymDUgoTDDhmI/zdxW5WOz2NUOIJWRLo8uMk4czGdkWHKQGNgg0WXT/WqyjcjuVklMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974126; c=relaxed/simple;
	bh=laAesc2DWHHY+XHvDhZvR+Cqdh0i+9IybQYWeli+aBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwnu0g22MT5vgMnNbb6OiecvloNWJS+nAo+8lrDotm0dH8fJovokxm2gxv/oqMLDKnVqu8c1ULtT/9An/vBcpP3uiDsoVN2WsSNIRtQZDlC0lgxuAaI4TJ28mR2bMzPK5A+j+rpLGcda8f3OWnubbKvI9wLBnD4A6+jdE9xVoss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNrwq/QA; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNrwq/QA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0c12be0ecso124135ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 09:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774974125; cv=none;
        d=google.com; s=arc-20240605;
        b=lGWoRP9bJZOGriMD63rA1vc8nj1rc/6nM6Fzi3hv4Xvi/H1jpnEz0H56Jy4gIJkane
         4Vm+qxCFMlTM0eDGFMnGtuQEuLoYI9UqM/QHdH7A6pxIHogLJbrFi/kg4pTXsVt2OR7P
         zzSZXIWiNotqnQt5pnvA3MM+sNek6q0oz9pDaVIcdVeBjbcmINDJxvrUjlmWnI9+YY1Q
         GlTWAjgWi2dJW0eHIpKfW1YsXvKvgJWG1An4JADDakeGnaZJM6M9QQQVS6iUmwXpUUod
         pHeEHBnaolbKSEcsmp71dEQQEZpRYGplVBd5BCkvMnY+qtI31UEV2VVPn6gv1gqFe/+D
         8JWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yZi4x52Tz19qxTf/zTm0U0WBodN60K0SdHTxgYhWyF4=;
        fh=t7EpQlYf5av/Kd4QV+ImR9s9N0yOStvhEoTOR4PEPL4=;
        b=hrcNBYBM+pfyEXGkxKQZRyHMaDXtJ4Y3MGFV9DjhOb/LbBOAkwD4zDqkkwfBToBz+U
         2NsIf8NqtPpu0CNYGqANEInLfGBMpEf0up7W7+SA57Q0gi6b7xS+pWQ31YtR0KA7h4NG
         BPx5M2lrLVu+RuU+nNaanJcH2iXdX70hQ8GOmK4+PHF6U61R2lXX9VyI49sOQX11Rg19
         eQAQAV3sBDhnZ5D81qZf7weKjTnWOan8gewQNv8FLAfMwDMMdFWEO7sHH+92C/ux3cc+
         dbhKcL2ktcH7W7RE0xhga+Zs5Z9HLo8+hofpnYHH31TME9QPOGvGpnNHCR0xq5twDfgj
         jOPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774974125; x=1775578925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZi4x52Tz19qxTf/zTm0U0WBodN60K0SdHTxgYhWyF4=;
        b=gNrwq/QAPfRbGx1ajwrXyWaEfeDGQ65XIlQn2umoBMc0PZnCfbPKzJl3Yi2nbH91sB
         xUhwxb1qSbjwIJLkL2aUvArCN9iEse1chd7Jjtkp+pyQ7WlkvHzqZvwKeZ7ibrLVWEyu
         tc98uMJZh02HCH5kGFxk+1i4tmWkyZs9+H3J5lWfoRJh3gA2SSxaLkYdCI7UzFr+CuFB
         oQIZlHyBFkSkG91pp13HbjIcJDxMxe7mEyVh3UyEeYMhi6X4xVbIVd2qM3AuqPHim0bE
         R8BTnR1NG7vy0SkuF+5kH0beLa2BeaVfH65D5hY1T0lUBPfO4PbZlYSldE2BzwYJAN/L
         jUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974125; x=1775578925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZi4x52Tz19qxTf/zTm0U0WBodN60K0SdHTxgYhWyF4=;
        b=jZIBiP9Py8DXCMC064lta7YUhLMhDiFUJ/34mOhahF8PBKDekq4bjGteKIgUI0ha/H
         QYyDUrWHqfcskieoAgIS9mrTK8rWEAD/cGmx1dyHyZoN7SYQltmg0vF2Ius3be9613C1
         2YtB/h/3wA0p5J/Z1VJp6pHv/5ecKVhMxLSb6Do0m8EaC++o9uIlGGZgHP/5NivzpCn/
         xZZS2SHI4ZNwj9k4WvLX7Em8+F+iqKpiotU3KRJr9uqBb374XUtCUymqJ+v9jbufoVgF
         8WL7v1H+HtOjHJGFj5ncCxld3FyqWd80YWtgNq+LZjdKb3pcG5EELpxEB9rUQzKvESHp
         DFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTf/twRQYfN3/pZmw9e9Dpr7Qys253wzdGQJZ+KYLKpLSaPHcA2kKkoRKo2vLdTLYaXxjOuU/TnFve1pyl+VsW@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2GuffcyBIJ5m7BEpDntHhc/z0eL+y1RR59Eew+YqFqTo5O/7
	G1V83pf/RtfocuEKuLwOdsVp+hx5vB7bNft3Itat4fPRj+W8pN6uW/ZypWk0iN6QRNHESlaXE/l
	rQPnu8z21kb4VTvAXKsnwEzDm5otSfmR/k8l2EN30
X-Gm-Gg: ATEYQzyz2hgGOiTOIZVFsCoyXnA999tqWyxN2evmZawP4Aufl5sVhQFbc21bm1wqFTy
	Rs67CLO6u2xmuJJyvLH85CqVtaURcH80ym127vOjudw/4eMxAnLzYR4YQMx71t0K+SOFKg3UYg7
	4tLGnQ0SQM5JSxtEGvaRN6ujCBfBS1PIuvXK2EVBTrckN3kO9Ej2LgJRHDr5Ipt4zcCQ34NP9rG
	J4jmQF095q21FzrJ3zFzzZsfBmR6GYGH5xWL7FFAT+bWfc55waq4qZXKBdfLuddZ75abOhk7JKP
	Zlt6pAJk6KDC8oYlzIJsV++RBvRNNWAZ20qE/w==
X-Received: by 2002:a17:903:1b6f:b0:2b0:5683:1cf with SMTP id
 d9443c01a7336-2b268eb903cmr171025ad.13.1774974124549; Tue, 31 Mar 2026
 09:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330194021.212912-2-ashelat@redhat.com> <CAP-5=fUvN=7ynEXju4jo6mWuajRRY0uC68SpUR8mTvXPqrgQTw@mail.gmail.com>
 <CA+G8Dh+rSWHuO4ihq3Qbf9=qBcjhZ_AWLZxBPh_cxJ=GDfvCRQ@mail.gmail.com>
In-Reply-To: <CA+G8Dh+rSWHuO4ihq3Qbf9=qBcjhZ_AWLZxBPh_cxJ=GDfvCRQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 09:21:52 -0700
X-Gm-Features: AQROBzBlXbvSW7TXbvv7P3ATxKI_apRsmh5V-VZY4isqQ9Z-20JPn-Z2PFNuPVg
Message-ID: <CAP-5=fW=rMqV_ci5u9wvXUJq_1aiKxTSwi3MMYPM4XHGwUDSvg@mail.gmail.com>
Subject: Re: [PATCH] perf dso: prevent null dsos from being added and add
 comparator checks
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 2:50=E2=80=AFPM Anubhav Shelat <ashelat@redhat.com>=
 wrote:
>
> On Mon, Mar 30, 2026 at 5:06=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Do you have a reproduction for this? The entries in the dsos array
> > should never be null, so the check is redundant. If this is
> > out-of-memory related the check in __dsos__add should suffice.
>
> We don't have reproduction, but we got a coredump with the system
> crashing in dsos__cmp_long_name_id_short_name. This is the stack trace
> of the culprit thread:
> Stack trace of thread 12717:
>
>             #0  0x0000aaaad2905cb0 n/a (perf + 0x1e5cb0)
>
>             #1  0x0000ffffa7090b38 msort_with_tmp.part.0 (libc.so.6 +
> 0x3eb38)
>
>             #2  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
> 0x3e9f0)
>
>             #3  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
> 0x3e9f0)
>
>             #4  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
> 0x3e9f0)
>
>             #5  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
> 0x3e9f0)
>
>             #6  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
> 0x3e9f0)
>
>             #7  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
> 0x3e9f0)
>
>             #8  0x0000ffffa7090dc8 qsort_r (libc.so.6 + 0x3edc8)
>
>             #9  0x0000aaaad2905e28 n/a (perf + 0x1e5e28)
>
>             #10 0x0000aaaad2905eac n/a (perf + 0x1e5eac)
>
>             #11 0x0000aaaad2906764 dsos__find (perf + 0x1e6764)
>
>             #12 0x0000aaaad2928438 map__new (perf + 0x208438)
>
>             #13 0x0000aaaad292765c machine__process_mmap2_event (perf
> + 0x20765c)
>
>             #14 0x0000aaaad2973b94 perf_tool__process_synth_event
> (perf + 0x253b94)
>
>             #15 0x0000aaaad2974874 perf_event__synthesize_mmap_events
> (perf + 0x254874)
>
>             #16 0x0000aaaad2975200 n/a (perf + 0x255200)
>
>             #17 0x0000aaaad2975428 n/a (perf + 0x255428)
>
>             #18 0x0000aaaad2975504 n/a (perf + 0x255504)
>
>             #19 0x0000ffffa70d2e00 start_thread (libc.so.6 + 0x80e00)
>
>             #20 0x0000ffffa713d49c thread_start (libc.so.6 + 0xeb49c)
>
> It looks out-of-memory related and I agree the comparator checks
> aren't strictly necessary, but I think keeping them would be a good
> redundancy against some future issue that would cause a similar crash.

Thanks Anubhav! I think adding null checks on elements in the array
could cause null checks everywhere. How about we keep:
```
 int __dsos__add(struct dsos *dsos, struct dso *dso)
 {
+       if (!dso)
+               return -EINVAL;
```
and drop the others? This clarifies the invariant on the array clear,
avoids bugs and eliminates the need for additional checks throughout
the code.

Thanks,
Ian

> Anubhav
>
