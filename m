Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889A2D781
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Mar 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178817; cv=none; b=NBczV28K27F6Nc6SvXEklTWAhE6c91OdGEQgMfWkPMjGcbs1WssMu2iLITNoxoi2YRGhqbXFom38LcikzRfYNCnO396qAvOsZJP+Vvga48au8+oJg/lvURxhSu+3bveZrfKPJuQJcNNNpP0G0pPqY6kLNY70seTMkUJ1RtvunhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178817; c=relaxed/simple;
	bh=hd5gikp0vc2N6bZJgrq9wVj+rRiZAjXng1Xqa7TV6CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx+EGMvrCtH2dIqLmrzkGWnBxmqKp+GXX0mBMA1c8spThhNAQ1CQtrK9qCw9GWUTPGFqr6fD4dnDE4rJuNwQbeADwIAULvFjCLKMhkqJVnnnGHngzhnh7dyWZ3aJ1cQzLfCgDtb8CawmqsPtCy7yKMrruXdjup6zGfIQogdGoEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLmMYXul; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLmMYXul"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-428405a0205so14651cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Mar 2024 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710178815; x=1710783615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvZZjW8V4QSv3wSrX51FU3CWzJnSisLpykPAhfx62oc=;
        b=RLmMYXul5Lb55mekU56XpfSUrEerlLqefGzfBq8sjyBlxJuGcxm9KGuH2XABt2OMnJ
         GplLqeuy3s6gkK87tOXWd90yypN3feEJc+KNoe/vViK49uWlObUdWGtw0t9KLmrWgtie
         JRLjfjfn1fuVISXrq5drV+z+kdFTJXGHZLbMmZl0mzRfy/4tsAumoCqHtavFdRzdu1m0
         qyOLyAgGX4cTGZ+x1bdxInDZ3lbL/mt2aSuN5hgWYXQEUnsIHcs90KvczTbGwhO961iR
         KeAYHNX9csb/qXOnnaUCON3LrRFneBdIV1H0QC7UW/ldU3pRh27JY9314nWlvBloDQKv
         Kbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710178815; x=1710783615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvZZjW8V4QSv3wSrX51FU3CWzJnSisLpykPAhfx62oc=;
        b=dnY/6eFLpV5x9Q6gjKsKL8AT3vgrEMaL+NtNLJe3OCXecT7DwSh4p9+M7mkLPi1HuQ
         qtAtwndJjNunDc94YgvM+2tONaRXKS/yNOPTXJk9D6FfSt2EK+1fDX54E3uSCOobbFQ5
         F9qqnt1CIP0pFX/l1jXZDOSM9j/rnW5TwUqCCF5HdOsdDZrtczhIFfkV8VXExq5nDGCT
         5Hq4TO7fFFru4Xpu24y5rCOgQZ1WdtD5Fg8/6NBAfny9arjFCLQceArTAyw33XaCAaOp
         Hoa9ijmspINEzpsCTMZ1v57yxVIn7x1R5ltkWjO+wO3dtTIvWJ5t6WAt2jrUZFzqtb+H
         SSRg==
X-Gm-Message-State: AOJu0YwmasaxiZT3biEwkGFlONLjFM7d72bDByyN+ZwlmZPOpEB1mm0b
	Aneos6EcEVVVSTMyKa0onG3TgAyezvwnvtFUgqdv4fP6OK/U4ojNcVuGuZdjY+SC5up0jSjtAOI
	BlfXYjQ+a6ihjFrEh/IT+GtGhT+dOVSqbTxLs
X-Google-Smtp-Source: AGHT+IF6099lhAbQyfyLMhuxPuQThWGNDNo27yji/hbKmnIRQDm5vZwakil94YZV5a6pABPWkLV86cxbd7Q9c0l+Pr8=
X-Received: by 2002:a05:622a:13cf:b0:42f:a3c:2d54 with SMTP id
 p15-20020a05622a13cf00b0042f0a3c2d54mr1221194qtk.21.1710178814682; Mon, 11
 Mar 2024 10:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710133771.git.sandipan.das@amd.com> <0d18c3a93083f12481f27dcc5f5795877fa02b90.1710133771.git.sandipan.das@amd.com>
In-Reply-To: <0d18c3a93083f12481f27dcc5f5795877fa02b90.1710133771.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Mar 2024 10:40:03 -0700
Message-ID: <CAP-5=fUV=6my-+z0Qc+TS2+CbKT1DqsLbpHZrZLitqpAnDd2-A@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf vendor events amd: Add Zen 5 core events
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 10:23=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> Add core events taken from Section 1.4 "Core Performance Monitor
> Counters" of the Performance Monitor Counters for AMD Family 1Ah Model
> 00h-0Fh Processors document available at the link below. This
> constitutes events which capture information on op dispatch, execution
> and retirement, branch prediction, L1 and L2 cache activity,
> TLB activity, etc.
>
> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D305974
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  .../pmu-events/arch/x86/amdzen5/branch.json   |  82 ++
>  .../pmu-events/arch/x86/amdzen5/cache.json    | 605 +++++++++++++
>  .../pmu-events/arch/x86/amdzen5/core.json     | 122 +++
>  .../arch/x86/amdzen5/floating-point.json      | 830 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdzen5/memory.json   | 180 ++++
>  .../pmu-events/arch/x86/amdzen5/other.json    | 168 ++++
>  6 files changed, 1987 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/floating-point=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/other.json
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/branch.json b/tools/p=
erf/pmu-events/arch/x86/amdzen5/branch.json
> new file mode 100644
> index 000000000000..208c646c59ca
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/branch.json
> @@ -0,0 +1,82 @@
> +[
> +  {
> +    "EventName": "bp_l2_btb_correct",
> +    "EventCode": "0x8b",
> +    "BriefDescription": "L2 branch prediction overrides existing predict=
ion (speculative)."
> +  },
> +  {
> +    "EventName": "bp_dyn_ind_pred",
> +    "EventCode": "0x8e",
> +    "BriefDescription": "Dynamic indirect predictions (branch used the i=
ndirect predictor to make a prediction)."
> +  },
> +  {
> +    "EventName": "bp_de_redirect",
> +    "EventCode": "0x91",
> +    "BriefDescription": "Instruction decoder corrects the predicted targ=
et and resteers the branch predictor."
> +  },
> +  {
> +    "EventName": "ex_ret_brn",
> +    "EventCode": "0xc2",
> +    "BriefDescription": "Retired branch instructions (all types of archi=
tectural control flow changes, including exceptions and interrupts)."
> +  },

So the "bp_" prefix means branch predictor, but here this is an "ex_"
prefix. You've put them both in the topic "branch".

[ ... snip ... ]

> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/other.json b/tools/pe=
rf/pmu-events/arch/x86/amdzen5/other.json
> new file mode 100644
> index 000000000000..9d49a23622e9
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/other.json
> @@ -0,0 +1,168 @@
> +[
> +  {
> +    "EventName": "bp_redirects.resync",
> +    "EventCode": "0x9f",
> +    "BriefDescription": "Redirects of the branch predictor caused by res=
yncs.",
> +    "UMask": "0x01"
> +  },

Here is a branch predictor "bp_" event but the topic is "other", why
isn't it a topic of branch?

Given the number of events categorized as topic "other" wouldn't it be
better to regenerate the events just using the prefix to set the
topic?

Thanks,
Ian

[ ... snip ... ]
