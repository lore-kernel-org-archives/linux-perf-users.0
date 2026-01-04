Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F77185E4A
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Jan 2026 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489734; cv=pass; b=fxzSgQ1USw4QpDlG0b3JvPLfk9kHluhgMyfbDqE5LO3DRyFFEMweEITbSptYMcweqoHl6mvF6otC0Ax/OmXkx9siE4bSz/Q1otG4tGnesoz/bhtLQq2H371v7YXipTpSVjablOUFNGBkIOPwRSSNREXp29kq2HOgOBoU0Et7dCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489734; c=relaxed/simple;
	bh=7szdOs9Y8gMRA8IItIm/LQJiJZGixB5VoT2WwqDkf60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TNHQ4ECbcp3SnbNUT6+kQf2jGk7uH4oOjLKYFeStq0QVZTc7BttJdZIErAtASVl5p95t96CTQZhvKg/zWmnICvsoLOMCeCX8Wberws/3MkNv4MJ+CFmPAr5XXZrJ1aMVdyC/EqMT2Uqybkx8bMr5uDPnQhzH2rpuyvrDD3HbHMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jx3H1Hb4; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jx3H1Hb4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f02651fccso103135ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Jan 2026 17:22:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767489732; cv=none;
        d=google.com; s=arc-20240605;
        b=LoApRAJssGfCQn4tGJY/M0bMWy3n2p6MZ8ekJTBOjXetUYyBV8VuZSwfQsgje/a/Kr
         VlKcmCjXc6pdEwYEgQINlNoOAttp4gQqSW9idsV+qd/QOClz7GStY0Wpz+1XLosIEnXe
         sHKjGvVFlhJGSHnbiVfuAI+SL5L/qYtHcHveGCQxZiYPNdNKf3yU8IdX9sDIU3WfNDvO
         H/bhrtgnsl5w4uyqUL9cmBqvoIsEpoSPF4cnmlFiv4S73T76XE+RgpnSdRof7/zUnjC9
         ddzQNlm1+ifkiDO1GbK52kRwo5S6LraWyv2bENEp2S0skLIYTmq02X6hwIDLKYa3GhSg
         X2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GhO68FFhhaH4yCAOdNZqh3fne9TIbbinLycL0EQji4o=;
        fh=A1qTq9l4YWUte7kERPiA4AkLAM7bAScUCw1GhYMBlLw=;
        b=fpd9btvu5O6aWo0mJC7csFI3tWpMpwizKzWtfYRNG3Yq98edjm/2Tmk1LQTpRok6QK
         oiyKDxpcvEV+JeJeHNeLFIZDOkHNPAQlvEQ+qKsnza/mhVu6ZAGCHzcLYw//tOdd6E98
         5QclCZkAwUINUd1OqCp1bhgg6suQfef8NiPgq4ylZsIBY6+3kYntLn3f38mlB7kc+JDk
         p2djNKBiapqEFC8iw3cZiYmD+qdM85P+nv/7xWfMZkPcmoMWYHdQNjOlfJFvxgeH4NAT
         19GC5VljQGmK5irA/mhZRWQy9B+ciX1oHcKfvVpArz8n7ffrf+vBOSoL69sb69C9GKOF
         oYKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767489732; x=1768094532; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhO68FFhhaH4yCAOdNZqh3fne9TIbbinLycL0EQji4o=;
        b=jx3H1Hb4ZDYZH7fPAz6mf/1TOUQWPW0WqoFl/dvoZcdOYZEw3V62loFfwooeAw0+69
         2bPwVA8rzY2yc0EQBswSGLyu16CKj36EbfPXc18ytXoKhqkTzZQ/RBKw4uFzsWbfyAis
         rjnZ/CRIkloLx2sKH6Sy5598s2JSpD0+Ck02/aGt+OdY62rhRx/COJLPZJWE1weBbX67
         tSdznaNa3IbMhjqQtnMkGaTiUnpJxjiYsjor5frw+ln+UbWj2dAS51W1KvHGJ6NnuMv2
         BEHawHfVkOt2be6B2jeu8j2kXCNE5jPuMwd3MYxoRe1zQkWdRKMD4EmswP20S9XJsEc5
         HSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489732; x=1768094532;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhO68FFhhaH4yCAOdNZqh3fne9TIbbinLycL0EQji4o=;
        b=tD18dMzg4ynsXhGuLqdNmUOXCyt7huKGnyhdMlDlB1rG6TNOY7h/ZqrVZhS5IJnoyj
         8eQ1kWXmYHdPaIagMDrEW5oy48IwjD42Z96WPosgvgj25lVu8GpVo80WWxwY/AKoOAxE
         ymifsbKxxZBlIb/Niw7Ogrq/kQcxo0HLKu0KRKJuVGmikt0bCVCwOkyfE/9gSN/l3mwH
         4CCIcmaW83HMh+Uv0bhL22TnYrO1MBqhs82VXYqXgcDB+NBBCtkVpTjoP8W01n4n8Axs
         ITU1qHmbpF6QJdOnXvLJ6sBFkJoFz+nYze7QYymBenVUiQMj2w+HVXMVejk+GJYmRWRf
         H/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIVvbKIKXuvH8qy7oeYhoiUwfNDEmUFhDEiBsf/t1+I6UzYCutO5NI7QXhzjtSDBNAhENX2idmxQlHEgIJzXiB@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXA5KmKpneRMiFf7yi8DxUB7WCOVRBlqE4/W4adPufhq1+jEK
	VCdjRI8iHGH0S+84mjRMTc1hHcxAnQ1AvrL2P1DLVmQZyTQR1c6rUmG9fqlYdYNSTFYJ211iDG4
	kXA6CvjB3moA4OdvcOLZ6ah2Vax0IGj/g1gfVXV/Z
X-Gm-Gg: AY/fxX6notyH1qAEg4AV5cg1FHUaQ9seOcaw6twx4e+h8M5ZkVOtHt6LbK0DO/uDOfG
	8N9q6Ps72r15DRc9H//70cx8tVoGkfemME/pn1b3Oo7NiHvhztSE0H6fpeg+3PqOELt/s21kw6v
	Tar/OBWkgGlI6TkknaWl+cbhvsVEt9VoxJTW9GuCt1WxcJXF0a+vN1xvP6CTaiUiG/yeJNrOhRp
	NKIx8/eSqUF63paiDnxUJtJ1YwrbMjPGPt9NLooEnN07fXJJQSFvwFtoNdXqAC48SCfzSTRGaho
	bkqPMu4=
X-Google-Smtp-Source: AGHT+IFEo9vMs9VeAuQWRTOUwoQ3fhjdZXFPJUiw9HSubH2jqhknsyc1jkmKOOkqCDqy4L/3VqU+Od//nHfFc/vp8bg=
X-Received: by 2002:a05:7022:2486:b0:120:5719:1857 with SMTP id
 a92af1059eb24-121da8ab620mr60703c88.21.1767489731535; Sat, 03 Jan 2026
 17:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104011738.475680-1-irogers@google.com>
In-Reply-To: <20260104011738.475680-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 3 Jan 2026 17:21:59 -0800
X-Gm-Features: AQt7F2rR07ELj4pAZxGCkMCbHp7KuLrpk-SUAos6BsGBGK1TKZlAjeXA8QYI18A
Message-ID: <CAP-5=fUmH84ohUqzXOzG_msB08xf2cPqR=H2QQvXSo+SyMXBrw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add procfs based memory and network tool events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 5:17=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add events for memory use and network activity based on data readily
> available in /prod/pid/statm, /proc/pid/smaps_rollup and
> /proc/pid/net/dev. For example the network usage of chrome processes
> on a system may be gathered with:
> ```
> $ perf stat -e net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors,n=
et_rx_fifo,net_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_tx=
_carrier,net_tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_fi=
fo,net_tx_packets -p $(pidof -d, chrome) -I 1000
>      1.001023475                  0      net_rx_bytes
>      1.001023475                  0      net_rx_compressed
>      1.001023475         42,647,328      net_rx_drop
>      1.001023475        463,069,152      net_rx_errors
>      1.001023475                  0      net_rx_fifo
>      1.001023475                  0      net_rx_frame
>      1.001023475                  0      net_rx_multicast
>      1.001023475    423,195,831,744      net_rx_packets
>      1.001023475                  0      net_tx_bytes
>      1.001023475                  0      net_tx_carrier
>      1.001023475                  0      net_tx_colls
>      1.001023475                  0      net_tx_compressed
>      1.001023475                  0      net_tx_drop
>      1.001023475                  0      net_tx_errors
>      1.001023475                  0      net_tx_fifo
>      1.001023475                  0      net_tx_packets
> ```
>
> As the events are in the tool_pmu they can be used in metrics. The
> json descriptions they are exposed in `perf list` and the events can
> be seen in the python ilist application.
>
> Note, if a process terminates then the count reading returns an error
> and this can expose what appear to be latent bugs in the aggregation
> and display code.

I forgot to mention there are also other events that could be added.
For example, from  /proc/self/status the signal information could be
useful as could voluntary vs involuntary context switch counts. What
is here is likely useful enough that a bigger patch series isn't
warranted.

Thanks,
Ian

> Ian Rogers (2):
>   perf tool_pmu: Add memory events
>   perf tool_pmu: Add network events
>
>  tools/perf/builtin-stat.c                     |  10 +-
>  .../pmu-events/arch/common/common/tool.json   | 266 ++++++++-
>  tools/perf/pmu-events/empty-pmu-events.c      | 312 +++++++----
>  tools/perf/util/tool_pmu.c                    | 514 +++++++++++++++++-
>  tools/perf/util/tool_pmu.h                    |  44 ++
>  5 files changed, 1026 insertions(+), 120 deletions(-)
>
> --
> 2.52.0.351.gbe84eed79e-goog
>
