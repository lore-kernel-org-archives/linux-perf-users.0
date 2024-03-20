Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E815C9
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952847; cv=none; b=PX5zzQQizuqA7pruasBtRE18AzXOMZ6IN24DX0K75rHHUHJi5CgXVUPpTP+0QD+LsJILMArhJ34loAEDoj+qYaOW4iarzJEZe4ZuJj2nT/A153XDND71ev/YJ72AAvWJ9TwgoXrKpOOrAI1J5l4O298BUxSr8hDTk4oYz1tosko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952847; c=relaxed/simple;
	bh=IPFJcENiCyzyUJ0Rcq2tI05Ded+kvu7vtcAY8HhSnFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHtF3rTDbyFvRwnbysEXilqWJHiMni+LJWpA1a8eZapZIdxRxqk/Bt4Uuc7WRgGSDkod1tDEsOSSxbLqVP3RXtcN30WQSVzlH3SV3ux0Ai90SdKANPgcSfyveKSzXCd/yXziwQZxhJC/T/sKEG9KS586gHVhjBRsa8NVEtxSQow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2TYOo+T; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2TYOo+T"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-428405a0205so377491cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710952844; x=1711557644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E2Iioua2lyhsilXiJJfaF8CCrcEUXRoDq4VH/C+Uq1U=;
        b=B2TYOo+TB5/IzVY/NQHHP+S2PCrjCrzwDxoydNWzbz2sb+34SjrB7/daM35F6KKQYy
         m3rXSqNHJwuhvrZTTsxTjgYWeY48+ZH2w2Ei+aD5cc14UGb3xO0b8j2VYspZkL3TpR4N
         0jcwlzSer/4G/BcU5KrR2JbOxGFY5aw6v0FnNIJLNx8M8pD4SstnQ2GaoQd6BINXbgVB
         bd6O7AkiMWZNWwAdRHrJZwLLjsKzHqEVNqqOMfOtuTFUI27iopl3M7tDe/IrKqU+4rE3
         s4rhHP2rzauXe148UmHDNxonq/GTnUtM8XyvLbN//vNImbwPe8FKa5lPYMvF3VvrT0Cg
         3e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952844; x=1711557644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2Iioua2lyhsilXiJJfaF8CCrcEUXRoDq4VH/C+Uq1U=;
        b=qs8tSPmW73qNt2NGqjAcgFppCXl0XmyE9+aHmzVFdtFusQ9fi4jMJ3A0RWPzX42Eda
         uqfm8/hlx3JljB6k1FC7lJKFSXRPwHU5o9tQ55HXHoOa55EB4wuYfdqmsBA7TunGEDw/
         U0/iGdg0BRna/Pqj7sUFBP02KD6XxY1riBClOqvRwGNNNlvzrtLY/si8dd2rRNWHckMH
         swCcGpM1h8hAZgZVfvFJxXvof7TPlNA2GveXrCknWu8ojED6nlod/Ip8j3OtOEW+VoLd
         TNFXzzA7nN6NR+kF8GbTap5k3pWv/uR9tpOSKCw4TzOoInt+cj8k63q8pOruty5GqJEp
         Yoew==
X-Forwarded-Encrypted: i=1; AJvYcCU4DKOnbMIc5c+7vA2LkTf50qZwNa9D464X+1m/cr2R7l7GGcxksKvyndYhCQeAm2SUMoHaq6TKXQJHaizRbW43zcHJq+TrkzdGPpFbue6rSA==
X-Gm-Message-State: AOJu0YyEFHlWZ5a0B4EgOIo3fRCUdp58+oQFSypi+wrHBIejADZcE5Pb
	pS1n0+uIz40Yo5V16IPLgtF2Y5lhSwS7Yi2ySS7CdyMwXH1DX6wRdZgkUl3zV5SX6xme/mqZocz
	Ov7YksfXudaA0HyY3Nqvux3ynyUM7UN1a+CEv
X-Google-Smtp-Source: AGHT+IGiVjjeu/I+qCPN7/5tTyBw/r40GN/5VRWHH4Ks7bnzHDezQwHcKs4lD6F55rSEQaRGRR9F3BFwXms+THBnfjA=
X-Received: by 2002:a05:622a:1904:b0:431:55a:57fa with SMTP id
 w4-20020a05622a190400b00431055a57famr221576qtc.16.1710952844403; Wed, 20 Mar
 2024 09:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-3-xiong.y.zhang@linux.intel.com>
In-Reply-To: <20240126085444.324918-3-xiong.y.zhang@linux.intel.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Wed, 20 Mar 2024 09:40:31 -0700
Message-ID: <CAJHc60ww7cOhtbWNp9WP7bxWKXCZtcT=6e4Fk2TaB63YqWMWbw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/41] perf: Support guest enter/exit interfaces
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org, 
	mizhang@google.com, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	dapeng1.mi@linux.intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com, 
	Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Kan,

>
> +static void __perf_force_exclude_guest_pmu(struct perf_event_pmu_context *pmu_ctx,
> +                                          struct perf_event *event)
> +{
> +       struct perf_event_context *ctx = pmu_ctx->ctx;
> +       struct perf_event *sibling;
> +       bool include_guest = false;
> +
> +       event_sched_out(event, ctx);
> +       if (!event->attr.exclude_guest)
> +               include_guest = true;
> +       for_each_sibling_event(sibling, event) {
> +               event_sched_out(sibling, ctx);
> +               if (!sibling->attr.exclude_guest)
> +                       include_guest = true;
> +       }
> +       if (include_guest) {
> +               perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> +               for_each_sibling_event(sibling, event)
> +                       perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> +       }
Does the perf core revert the PERF_EVENT_STATE_ERROR state somewhere
from the perf_guest_exit() path, or is it expected to remain in this
state?
IIUC, in the perf_guest_exit() path, when we land into
merge_sched_in(), we never schedule the event back if event->state <=
PERF_EVENT_STATE_OFF.

Thank you.
Raghavendra
