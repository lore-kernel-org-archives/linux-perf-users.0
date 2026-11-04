Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793818430;
	b=dezG42GkEWfmLZxcW3p73VESEekXLYtsIAiaG3XR3kzqMv096ALiZ2DVnXfai11zroba
	 ZWVmLxd1wpGnhjsSxYCvySIGoDRo2k3s9ukPMX3S/GzzOsk/Mgu4/E+LRhp1PaTjoVy/e
	 wGuX8WESqQ9hM0Ok9pqb4sT6/9+jR0hbA7UyuaG86OF0dv6yDkzg5pnSU/C9Ej2hCrSDF
	 xUHfGr076RAJJlBtTkw0FbO4FA1DV3dMLYv6oh97W7lU8yDJkR28DCfp1FgHnFNn8qRfn
	 3IMy7i5dPf82zANZ1hckYak+vGyPY5VFh8SUYIr9abovNyNxS1xeLdaj6RV6KDpU6uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VSLZirYLfXxCX6vmTSLPB0q93v507OlVixWklmCxkMQ=;
	b=aBaOByIZ6rLBTTL8uNNg5EKpuNtAjyfLnWOMXFmXov+dPC7jmoh0h4zkBGRk8mH+aPP+
	 6gZZ70Wtv2IVz9pJY0dTbrNV5/98tSuMmdppcRWyTkTwwo3PZCRh100xRs826eKyQl9Bf
	 rgQ3QQYYHGNkALZtVjT7lro5T5akc/udT6KJ6Ppvv1FTrk1oXR/h081S3jEq6S0uHCNpf
	 km4JXsE3O2wEqqAwIByeu2wjuSSvSf/juEDHiTP3Poc96Qdy7oAP2NC4jx6a8wKDwOwUx
	 amLZCVfOU9ghjzvOjO5loWQwt6pLWhmcGad8Jok35AQs1D+TM/q/97e35Uix7LsKS1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMbT5d5A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10480606D824
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10480606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMbT5d5A
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so879978e87.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:53:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793818428; cv=none;
        d=google.com; s=arc-20260327;
        b=A6rs/9tjUIz+cDGavUvxWs7O1Fmpk860f9KsQY5pTOx87lgDBjpH8sknTS1GAIKGnO
         6j/2VqFWymSXA5jqS8AgcL/+T9C6I3JaBprUeNMaS6WMEnf7QEaAKLiQBkXhO+eBbfkv
         jYgiMj4TwPrcuhdGmYVX8fzhGjX6rJegvde5UaC+VDsEg7VirK4arO698iP9TahyaLYN
         WwlK4RiKOAmjXlSagEkI9ZQONf0CDIiMj60RqKBALgdRmfCSF6tEhRLfwIMi5I88NIXU
         kKeeGov0wplT7PVO4yRjlQ9fUeEmxEypaXZV6Yxkx57BYpfMu+SGA9iTNUFNQ6ngXvIz
         0USA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VSLZirYLfXxCX6vmTSLPB0q93v507OlVixWklmCxkMQ=;
        fh=5mPIqRj4BHc8GsmfDVoYJTka7rVLWgNTa7b7vCLNaQk=;
        b=YGyhSoYdNPuVhYaoh9E1SDIVafQfd7hUSH53U5z/eZLqHZjteE45YIOtnDH2SgUFXd
         a/A37NlA8yNRZCYTmc5b3Pt+N6pwKgU11mnjBC366bombEh1mzGCOkaAnEJSJWZRDoAA
         +W505LQjzw2oPxYyjfTYP9Jch1M4tpjqY6Nr9QTS7BYFZtrdTbcqNCt8EIEE+d+xKCeT
         E7kx71eGlkfnERJczP/IjmA4PdfVpOtIMeG7nY2xgasMMonAwYLYDaIioXYBUrZL1DTV
         j9yKZsVmBkiIFeAoZ9nRjDPpZaOKpvNUnVJobNBdEEAmrE6T/UIv4f9pPOOPVc4KchvR
         EQUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818428; x=1794423228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VSLZirYLfXxCX6vmTSLPB0q93v507OlVixWklmCxkMQ=;
        b=PMbT5d5AfA3PKJ81m+UKPVsHKXN0tvmPHqP3xOpY/M+JwQrno2/TrDH+YOK4f8QGUu
         6GKbUP+P9YY0vfpxdMSD0aEQTFcQsNQcE/KpLy7ut2Q9u1OYhv+c2xKLDSupF7wPccWj
         AzqWg6XpW85jy6tzDERjz4YOnRQP0jzH1JxOm9A+CtfKQZXRe8i+tg5mCcAOEeytu6c7
         MdAMtJi+ZZJcog3NDVz8tNIgWM4LPsqd4y18rE/s3/iE/XkuulpjAgE33g1kQoXMRwQD
         TqpdyOPLDh474Hh0Vb6gkzsYoHRPu/dG1/u68hm1nEHM2Bl3hYSOVbl/XlH5q41T2quV
         r8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818428; x=1794423228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSLZirYLfXxCX6vmTSLPB0q93v507OlVixWklmCxkMQ=;
        b=idb1kuefQpmnxf+NBw70gcLEytCrs3uWHSAPXoya0P4CIOh2jRwbaFQjuuIg5PCYy5
         vpnQ/BIYAZqhhzNSORvdodyCkO7NWSxF8bMqp3lPJpvRywMifksWnEj9YrHdlz+Wl+SU
         R37rP1EFTMjE6mYOmZ4pMGlErTtB4DEoDPbXdviPo0FLVbXh/8ZNmvyS8gFrNPaRWa9b
         mtEUFRS11MOvVkdRJ1M6oQ+QPGq2qqMcazI5mYXccbtwkYpUFK2czUzeKTGC2FbDJXjs
         QZpqNukzpjJ9ESJPg/mzsOU4JNACvSjpzVmEXMLmMcPRz2MPl4X+HGqmpGenX9uEkmwx
         iltg==
X-Forwarded-Encrypted: i=1; AKwUvBx4Lhd4DP1rUu5Hl3VggDN6WnKH+hWpdIr+mnwkbwKId9OCY3uVocNU7QQ194BIQ2oVRLKkuoBwMjLK4K+Mmy9I@vger.kernel.org
X-Gm-Message-State: APuU4Z98g+PiK6Rs/K9K9sWM9YfeuQnjpBYI2GS6ckL1P1FQCobklirA
	K5ZwcBDU+q4nd6PQo1shuvZyWW+lzOxLWM3CCbbSh9mVaYDd4rQoMZmi3phWehICk5JK+bUPc2Q
	irA5blzBAEkKux62yGSDlooFGAwvUwrc=
X-Gm-Gg: AYBFou2evMlLWQoE7r+SV51HOM+dpieyHMYhWRgEBwRmH4olzM2TB5P+jvLQwaCBfrV
	cqqMKqhsVK2dGx9KWSf9TK3qwKQQjKMAa/K/AZUYARTHbBoANAoidmDzPIfZBj125mqetoOxGZH
	pp8Gsv+BStmm7C9ogFLxDGl0ebaamRy9ms7U1UA7iZ8d4OAfWD6KKHdpYvMsss1GgalNzooE3LI
	40HPxlMkCfpMhFsvw7IWV5sl9JuaGRK7mfd3mvpNL4DJRoMUHXJHyCxwTFfmdBpluAwmcmDwSq0
	cgs9O5frV3FVrZLJNFdPpkfey+lgiXv8SLqh8cTERAVEeVAWqm9jpfaNsDBcHQMN/Hrrqo1llsv
	p2tIeCsKVKS/+ldiVstX5KL/MADtU9T0ZytitFNMp1mck273lHng6x1kmSDvJzgQAYT8ypiAsB4
	gAKxxoRwwXdlHGKbVmqAA0+z0q/5KK8neQz5ltslsSGLXBP/OSmMzRypLXS6N33Kr3E9bJjCF+7
	A==
X-Received: by 2002:a05:6512:3a92:b0:5be:3c86:f24a with SMTP id
 2adb3069b0e04-5bfd957e37dmr6686063e87.53.1793818427812; Wed, 04 Nov 2026
 10:53:47 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com> <CAP-5=fVtMnaoF1JbVFJuiRqPx-2izJafs=+ov6eF_PYFE9Xrxg@mail.gmail.com>
In-Reply-To: <CAP-5=fVtMnaoF1JbVFJuiRqPx-2izJafs=+ov6eF_PYFE9Xrxg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 4 Nov 2026 13:53:34 -0500
X-Gm-Features: AclHuK9pOKGbog0PgwGPnVhdNm68bt_g_FLIV6Q4IvNlgqwLLjl2Ikr-ET1-ZgE
Message-ID: <CAEdQ38GxScDOhw-4ev_cOyWcEiE2jtfyp2FEJEEomvcgExjL4w@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] alpha/perf: add ProfileMe sampling
To: Ian Rogers <irogers@google.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 6:42=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
> Patch 5: I think Sashiko's report is right. With idx forced to 0 in
> ProfileMe mode, a PCTR1 overflow still pending when an Aggregate event
> is multiplexed out gets taken as a window close: it adds a bogus 2^20
> to the count and emits a sample from a stale PMPC, possibly another
> task's. That's the mirror image of the false sample the commit message
> documents for the other direction.
>
> In both cases the interrupt arrives for a counter that hasn't wrapped
> since it was last written, whereas after a real overflow or window
> close the counter sits just past zero. Could the handler drop an
> interrupt when the counter hasn't wrapped relative to prev_count? It
> would need some headroom: a counting event's period is 2^20 - 1, so
> its counter starts at 1, and a real overflow, which leaves it just
> past zero, would look unwrapped too. Capping left at half the counter
> range, as armpmu_event_set_period() does, keeps the two cases apart.
> That would fix both directions, and the caveat could come out of the
> commit message.

Agreed, and done in v6 as you describe. It's a separate patch ahead of
the ProfileMe one, since Aggregate mode has the same problem when an
event is reloaded or perf moves another event onto the counter. The
cost is that counting events now interrupt every 2^19 events instead
of every 2^20. The caveat is gone from the ProfileMe commit message.

> Patch 9: Now that patch 11 drops DTB miss samples from cycles:p, it
> may be worth giving retired loads and stores a data source too.

Done. Retired loads and stores without a DTB miss trap get
PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT. LDA and LDAH aren't memory
instructions, so they get nothing, and neither does the ldq_u UNOP.

> Loads into $31/$f31 need care either way. [...] Running your
> one-word-per-page test with loads into $31 would show which.

I ran it. On the EV7 a load into $31 that misses the DTB does take the
miss trap, so it shows up with TRP set like an ordinary load. Those are
now reported as PERF_MEM_OP_PFETCH, both misses and hits.

One thing the test showed that I didn't expect: an ordinary load's
samples split about 1:1 between DTB misses and hits. The miss trap
aborts the load, PALcode fills the DTB, and the refetched load hits and
gets sampled again. The commit message says so.

> Patch 11: Kept samples still carry the full period, so with -F the
> sample rate, and perf report's approximate event count, fall by the
> killed fraction: to about a third on your mispredict loop. That seems
> the right trade-off, and it's what IBS's swfilt does with the samples
> it discards, but it may deserve a sentence in the commit message.

Added.

> For the next spin of the tools series, alpha-profileme.py wants the
> same PM_KILLED_BM check before it trusts TRP and MIS. Its example also
> records instructions:p, which after patch 11 has no killed samples, so
> the killed% and invalid% columns would always read 0;
> cpu/instructions,profileme/ keeps them.

Both fixed in tools v4, in the script and in the perf report -D
decoder.

> Two possible follow-ups, neither of which needs to hold up this
> series. perf mem has no Alpha events yet; cpu/cycles,trapped/p would
> be a natural default, or cpu/cycles,profileme/ if retired accesses get
> a data source.

Since retired accesses now get one, tools v4 adds a mem-ldst event of
cpu/cycles,profileme/, set up only when the PMU has the profileme
format bit. cycles:p would lose the DTB misses, since it samples only
retired instructions. perf mem record and report work as a normal user
on the EV7, with the load showing both L1 hits and misses in the TLB
column.

> And as the driver already works out the profiled
> instruction's mode for the trap frame swap, ProfileMe events could
> honor exclude_user and exclude_kernel by dropping samples, as IBS's
> swfilt does, with PALmode counting as kernel.

Done as a new last patch in v6. PERF_PMU_CAP_NO_EXCLUDE is gone, and
event_init rejects the exclude bits for Aggregate events, plus
exclude_idle, exclude_guest and exclude_host for all events.
exclude_hv is ignored, as IBS does. A sample that falls back to the
interrupted PC (a PALmode PMPC, or a user PMPC in a kernel thread) is
dropped if either its PC or the profiled instruction is in an excluded
mode, so a user-only event never sees a kernel address. As with IBS,
the event count and the PCTR1 window count still include kernel time.

With perf_event_paranoid at 2, perf record as a normal user now works,
and on a workload with plenty of syscalls none of the samples were in
the kernel. As root, cycles:pu and cycles:pk split the samples cleanly,
and perf stat -e cycles:u still gets EINVAL.

I've sent v6 with these changes.
