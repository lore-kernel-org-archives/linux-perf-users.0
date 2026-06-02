Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FB27FD74
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416760; cv=pass; b=Xt+dtp5XKYSRUGiYzyZfBt2Ct0SD1PYdkMqThn1IvHOvvvpuJzc7Th4bL0uVIwJNVwV6A+Ykzv067L/xyB+SpOORus6s8cY9s9PJAkAOH7u6NU7yT8VWz2xv64jHrugFOLdRlMsi+OpYaifE8hXqUE/jYze47o7vV8nXxCMlG4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416760; c=relaxed/simple;
	bh=jsVIcmcV6g+wiQNa9nON043q6Oo5ERD1DmYjyVTfa/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0HuUcFjxZWu0LP05XLcCqaMZon4MalKk3WUH2fMtPEdow7iAnPGfhoNb8q4OvJuBSD9bJm5F20ax8xie4J9XcqmZek9eYGZRRQ30/kMVXriySOhvqYJeH5eBGQM/brfDguC13Q4DNdrX8BuJCKQkgLZ8xOHGNc4/4IPmvUo8ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNBe8FGF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k2Ssxb83; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNBe8FGF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k2Ssxb83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780416757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv6b8Lim/VWL7tffrNbpEUXxSrhwW/FcqHSo50GrOUo=;
	b=aNBe8FGFyz4ISSzXgVFtXqn3LhvN3fYYk/wLYNpSC8Ko3okIJdftxPWxwomaBDme+/zp53
	J+pFFSzaMvYNmSuHwvlAZQxZZxdlWCDX9tOo4tdhsM88oWIxaz8jvipIAv0yg3CgJJZ25p
	hBFU9ykZU9GjvSajB6XM0frXkJqlTXA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-k4k7oJjzP5m93lwaqvqFRg-1; Tue, 02 Jun 2026 12:12:36 -0400
X-MC-Unique: k4k7oJjzP5m93lwaqvqFRg-1
X-Mimecast-MFC-AGG-ID: k4k7oJjzP5m93lwaqvqFRg_1780416754
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3966c1df9e6so14229621fa.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 09:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780416754; cv=none;
        d=google.com; s=arc-20240605;
        b=HhZm98SYtms2foV+XXFeEDEvfoXdkNZjpPVnSTkQTO40gRiqaDNw+k9ogHlhtE4vPT
         qX7Lcj2d08riBPNemyGDy4hA6oPcyMuDeY6Ndivs7UKOUpEUtLvjeRYRufIJjFkxIRop
         PQPTDGaEEzgO9Zg4JqZsZ/m//9cbCS15BbXl+TAZhlP2juLzcOZzzwM46qimCbUM5wU5
         0iO44LnWBXalxwkgfEckao8pSdoKGKFv0adYr3Xi5q676MZBsbTdSDSGIpvaiwDyuqsv
         zDLFkG+PNPKGSVG+JjvERHlFdpOMJ34CLNgHwbNT8RaldB9nTpSx08ttPr1kRZ9l+UKa
         5QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hv6b8Lim/VWL7tffrNbpEUXxSrhwW/FcqHSo50GrOUo=;
        fh=F6p+o4O7lPBicV+FAyp6rnQVf/aHZJT07yXTEMZb7A0=;
        b=SlGd4SMujUhMy99KMWNhoKg0vxyrmIOrYSvwd3phhl2davxYK1U4/UIjBrTPL077tk
         SccudFYGx2gsmGMwHdfr71s5JJmOQ1Axkst+tpsfK0rvzAFuAWzVmcaOCJ2BLu1Xn+nf
         w+ShDOHwoP0NqhAmWINK+ksO28/kfNlX1V3uSP2gDLAalWiUhAoVnB8vAXFEJa2gYHXx
         QaAII1nWs9WeL6KVtaBxHY/8ZkdkHYy/auUhpHYxApckLPLL1elvMqwMn+jccM3C1JPQ
         5fq5HYQ7HLEBr6sntad6W+yNw8rmzV7vdjtCUKRlulxVL6ERRZYAKkAbq3NiwCgoH6uN
         ADdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780416754; x=1781021554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv6b8Lim/VWL7tffrNbpEUXxSrhwW/FcqHSo50GrOUo=;
        b=k2Ssxb83LbbbelX7N0EZ5GAn3Ib9tk9dAseXezp8f+NqHD09j88P9/RYyTJXDpBTve
         PC6U+z1iOHBLOwdzr+LZjmG2si6uQ7nJedpUEbBIT7P3ijeo9Qw/kL4BnOtt7GxA5mmf
         VSTYerBsFJ8PAUiUYf5fNazb0juGG3l8hw/5hqAbF2PlSl/AYi5kYehvVwDNM9DR6eck
         e0ynAbSr+rGLaeRR+3ikiLX1kSEIURtRFqpC3+YbPvfKBgUMN2kGV4ZpIUg2p0Bl0OUe
         ssAerp0gzT8lTWFCIb2+zNGgacY0d2oqkyxfCLkzrZxaqQjoED0cis80oZmKjlbuYoxY
         o3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416754; x=1781021554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hv6b8Lim/VWL7tffrNbpEUXxSrhwW/FcqHSo50GrOUo=;
        b=PanwkGZVoYoD0CO2vQeexMrnJTu5ggSQDPu4yPMqKBZTafjtsN569vi8it3Vb7xPzS
         IkiqXitN5h9+Yy9g6ZlRSvblxSMeJVCdQ7HGgUJzcN8uoaRxpuIy0sXtENy+dvqqlzsv
         tx/IQJuczURQmtMqz2t4chq3bHSqt+vEvLgxE4GewYl9dmqTQgqhj5NjmbldNyuIW/tz
         MPefQCg581M5uL3ks2dJpSghjwofy0pf0CXcbbqR7DIWSGRXzCO5h0vw1NgPX4uxfPhE
         SH5iJg/1AFOT9ZQYAomdNPowmoWTuHJmlxx+h0aiJGnAOnxCjRmQkFSYGi33/LWIxwaX
         PRtw==
X-Forwarded-Encrypted: i=1; AFNElJ85glJpGhU8GY4AbofbGhp78bgZ3RikndcL0bPx/vr0a8G1/hKOCoK5k6w+a1MuvP4paVHwTTBUtyv7OuJnPkwC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EUu21ZSANIL1vJ56KPpl8AltymbgGuBsOE4e8iunj9zvZU/a
	CKfIuH1sK7+9ZUS7fvsAAxwa3dugaIftg1hM0dxSjGmVyY36Uoa7vhNx6I8hifDObOtOWyPHLy4
	GCxdjHi+5XpSczRIwemLZpeB/MYxEmZUgve5Ltw97ufvUelBfHmp/qO+zS9zl7vQxrRiJhmadWV
	7VdEZ2zOOhsJ4y3jCgp+GqjxBcTbChM/wLdkW0ex8S0fsUww==
X-Gm-Gg: Acq92OGBF5ojVxm/XAz0ysYj1Rdaho/sRaE413zs7zWimnQCgDBp8SDPVMXa/DKsNOv
	cxGv2eM1Nmjpn8brehLbr011osaFUEpVsZsetbG6CHUCYlhOsRe89U0ieTeM3+BPeGq3xZC/Un/
	OYdGD1GlcTC9k1YvRpVKj5ozfBYMHXiAydH4vNIXuyDz1X5iANK+P7IkScW4pO925A3P37bVfXE
	IBHYlKGcVh3fTuQb2a3gpOidSK9OUJtzHP/Fvnx5DQb16I1GO8=
X-Received: by 2002:a2e:9a13:0:b0:393:82e9:fb63 with SMTP id 38308e7fff4ca-396ac26058emr1399921fa.1.1780416753977;
        Tue, 02 Jun 2026 09:12:33 -0700 (PDT)
X-Received: by 2002:a2e:9a13:0:b0:393:82e9:fb63 with SMTP id
 38308e7fff4ca-396ac26058emr1399811fa.1.1780416753576; Tue, 02 Jun 2026
 09:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515194010.93725-2-ashelat@redhat.com> <20260515194010.93725-4-ashelat@redhat.com>
 <20260518214116.GZ3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260518214116.GZ3102624@noisy.programming.kicks-ass.net>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Tue, 2 Jun 2026 12:12:21 -0400
X-Gm-Features: AVHnY4ImP7GIhTl8MEnOUlfsCdz6wMiKYij0lm6-i55yCrS9sEILvfi1RchCDE4
Message-ID: <CA+G8DhL78GE-1OigkF++aw-CmFzHkbeU5b8JbZ-ymswRfaEt+g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf: enable unprivileged syscall tracing with
 perf trace
To: Peter Zijlstra <peterz@infradead.org>
Cc: mpetlan@redhat.com, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:41=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> Typically patches are supposed to a single thing, you're listing 4
> things. What gives?
All four changes need to be made together to work properly. The second
point could be pulled out as a separate patch, but will be replaced
with the eventfs that Steve suggested. The other three points
represent a single logical change: selectively loosening the
perf_event_open() restrictions without exposing kernel data or
breaking uprobe functionality.

> PERF_SAMPLE_IP should be here too, no?
If PERF_SAMPLE_IP is added to the kaddr_leak mask it blocks uprobes,
so the PERF_SAMPLE_IP check is in the trace_event_perf.c changes where
I can exempt uprobes:
+       if ((p_event->attr.sample_type & PERF_SAMPLE_IP) &&
+           !p_event->attr.exclude_kernel &&
+           !(tp_event->flags & TRACE_EVENT_FL_UPROBE) &&
+           sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+               return -EACCES;

> And I'm not sure if tracepoints can trigger it, but PHYS_ADDR also seems
> something we shouldn't allow.
There's a check for unprivileged access to PHYS_ADDR at core.c:13917
so I didn't add it to kaddr_leak.

> And we're sure RAW doesn't include pointers
PERF_SAMPLE_RAW for TRACE_EVENT_FL_CAP_ANY tracepoints doesn't include
kernel pointers.

> Again, you're doing the same thing in multiple places. If only there was
> something to re-use a previous expression.
>
> None of this gives me warm and fuzzy feelings.
You're right. I'll factor the checks out for the next version.

Anubhav

