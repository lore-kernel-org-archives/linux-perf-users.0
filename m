Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A92257854
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627543; cv=pass; b=hrTM9Gt/9GpA17NfZkVB7UiUh3oW+IBwRxMriQhHLaTGn/CMzqo4OStze6S7QkJS7uSUdmqb9EqAOgsjNrnp47izKijJSTMhyxSt5QZlsi0ZygoWSf3WGtklzurmW9EB8Cq4wtyYIK193AQXW4ldUbI+MT5oizX56dahgnPz/Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627543; c=relaxed/simple;
	bh=VpoPbBGbz6mfdfJMvoYEQgQYYWq4Fn6yHjM4jwRMYpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzx1D7/WR/FEn7NED/fQCbFX0IDQOX4t0a1ntcYqoJiUwXCVSVktktAYWMJypfdKBW6vFnu1eWE8hAqLZwNwZ95TIydkC/FXScGESnZuT4CPnL7YDAWl1Go0czuPYJCqWZA7oSqZNCrsc8UDcfNOItys3pDfZ+6B7TYvgaozUFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJW7z+Q+; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJW7z+Q+"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so51652a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 11:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769627542; cv=none;
        d=google.com; s=arc-20240605;
        b=DWCTADSb5UYT6O+OVH+OgOaxdOhvHyvbiSQPJBdKN4MiUtevYv3raHOv7pKtCFDLF3
         kYAGuu/W6jJG+BjWFXx0BXr/w609+qoeuJ/ApYMdwWOzzsCWJ2nNkW6S535C+tw8f9vc
         vzWTHdGX0vM0GEXXTOgiB6qWv+/HhyE909Ym43SCpfGRZA4j0Pstl8bc2/uy4IrEIhiJ
         Nyeoq9f4BbfZ218oQ1+dUTPXvkF4tft5tRGaGODKro4DfqCYaUtYAoQfFLuFGJ/kAArx
         S5PLbE+f+QyW5Bk42xdz8FzwNQ47Jh84mddbBZV2k82YTfSYE3lDW2EpUwIKwnQa7w1T
         dSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VpoPbBGbz6mfdfJMvoYEQgQYYWq4Fn6yHjM4jwRMYpI=;
        fh=YvcEc3TEgG6Qt1RO/6VyAihncUnjJY8D/4TeZoIimkU=;
        b=QFbX0C0V8Ay0SWHerLRrSkNE+WrkP1Or89RAIvcq+UGLb54b91IFi9Q3dYmL8Jt73T
         LakbdMeounnhVRW7Z2h9G3YbzKTDO9edL6BhzXdyrn3YozkhhDycAF2C3GXibNroWcit
         lo9821Hiz1gziYhvt3uZK9F/Guv1bJGdPi9uW2aW57V7AsqzksVPnl3+OVJx8Pztc37R
         BMJW8H+fcluWIOOmtRd8rw7T70/6WVg2qOvduWkBKXfVueP1C5W0wkqcWICPITT/G3zd
         gBOup075yiOCbcrUiHuVPnVYZUd7CqQcTNyl7cVs2T0uLE8Kgi6gpdWkKaYVHGl83Xd8
         uzLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769627542; x=1770232342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpoPbBGbz6mfdfJMvoYEQgQYYWq4Fn6yHjM4jwRMYpI=;
        b=bJW7z+Q+/KfY1gY+VvHGlcR2AIo/wIOoBp3VKb7rHUb6r5Y/fKbq8KPJbPl9KGtiUo
         MCJmIGlcjzX8h2q8kiEOgqs/Da/dBkZ7b3IFWIwzTGYO8IMMCnh4F6OWtYEiy+WWM3E7
         pPn4s2EaBeLPUZkrJnJct7ZvpYMeemTw2xIaVdaZiUA4NK7LA7qhItu8Sy/CaH8w56GL
         lG/JEac6wzUPkcjURiQept3cOVgNHQEOb77PaK6Yf0Py7Grv85vm8s78izgvL6RTbbCu
         5xhKa+dtO8O0CW68tsjmIRjIe4FmIr0CCigETI8ONihkMr18m8L0WzL0rBZfm5w6/tkM
         herg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769627542; x=1770232342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VpoPbBGbz6mfdfJMvoYEQgQYYWq4Fn6yHjM4jwRMYpI=;
        b=Bzudr6cPF15Mo+mp/PbQgmMz4hNb/+SjVITgK+6qmY2SWZWnW4CdeqFQMyvV0L92lv
         px/xEFUor6N6Je14xxP53u7GAiqArICO2WIe8uL4T7hpo/WS8TxA20R2wfFNZSeGInbT
         QfMJKn94jSqWuahcCWBl2uT/7lwQqJ+4GmbkTuR0Gh7IWFYgrQd3xQA1K644xuZlZfVr
         PgBrBnMzLxLZ48DnG+bwkYQ3y5UK+pdf2mg+R7ANmra6qTQzYAEO6U2mFPb1gnXgOMkc
         a0ge4WdRBQvbWqST+cjfyxvZ+VRzctmEp1opLTfquGarwTKkVj4mpw1Z8T1fpvUW7CPz
         v+JA==
X-Forwarded-Encrypted: i=1; AJvYcCV7SEdkTK4eAdNXbSGQiRONvWMHBzzXetpU16c6NDE2pzTwblbAPHDueZ6GwriLgGI8W5RiFa9GL8hT/NgfSsze@vger.kernel.org
X-Gm-Message-State: AOJu0YyNctEhGflYMnezZ/zhYIp5OnlHYOsA2WapSG6o0oaaBRWZ8QZd
	z7eBQnHJkdDFw1CK5UUuMv4n/UGHzURBy9EtAEYAMqw7HwSnsn+asyF0OuECBffOgK75p1B5q0Z
	CA0WqlVCdLzDZV3sShH9B6NFL9CM5//M=
X-Gm-Gg: AZuq6aJJ44WHjO8VpzmxcAVN4ws3aBuKA6r/+ITsRKC1HbEn+9/LamPseU8b0fIUYRW
	4EPwDhZogXYpDMipoFB1TKVY+CrVvB6Q2NCGP3YFoUGzawKXvH2nuHnnE+awSAaRfLZcV6E0SPo
	OTzn2rJfK6AFRMAmy5PFc7AQcdwyAmS/DJHCMPKq4LOMaZsuMnI+FoKKrYNY9YfEgfpx7PadEss
	e++1yk3uKbCsvPesX1yLgwLckdrgMkVgsOfHvk/9QEtK38BvpxrmmencvYh8QP0Zn14JWTSAKYq
	mIg4AUA1/Fk=
X-Received: by 2002:a17:90a:c2cb:b0:34c:3cbc:db8e with SMTP id
 98e67ed59e1d1-353feda7219mr5415955a91.25.1769627541653; Wed, 28 Jan 2026
 11:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev> <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
In-Reply-To: <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 11:12:09 -0800
X-Gm-Features: AZwV_QgQnbf0pZwpt-k9lWK7o7z11VRyXzgeBmNVjegplmNSLZ0igAY-ZPB3AHM
Message-ID: <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Chen <chen.dylane@linux.dev>, mingo@redhat.com, acme@kernel.org, 
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

On Wed, Jan 28, 2026 at 1:10=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jan 26, 2026 at 03:43:30PM +0800, Tao Chen wrote:
> > From BPF stack map, we want to ensure that the callchain buffer
> > will not be overwritten by other preemptive tasks and we also aim
> > to reduce the preempt disable interval, Based on the suggestions from P=
eter
> > and Andrrii, export new API __get_perf_callchain and the usage scenario=
s
> > are as follows from BPF side:
> >
> > preempt_disable()
> > entry =3D get_callchain_entry()
> > preempt_enable()
> > __get_perf_callchain(entry)
> > put_callchain_entry(entry)
>
> That makes no sense, this means any other task on that CPU is getting
> screwed over.

Yes, unfortunately, but unless we dynamically allocate new entry each
time and/or keep per-current entry cached there isn't much choice we
have here, no?

Maybe that's what we have to do, honestly, because
get_perf_callchain() usage we have right now from sleepable BPF isn't
great no matter with or without changes in this patch set.

>
> Why are you worried about the preempt_disable() here? If this were an
> interrupt context we'd still do that unwind -- but then with IRQs
> disabled.

Because __bpf_get_stack() from kernel/bpf/stackmap.c can be called
from sleepable/faultable context and also we can do a rather expensive
build ID resolution (either in sleepable or not, which only changes if
build ID parsing logic waits for file backed pages to be paged in or
not).
