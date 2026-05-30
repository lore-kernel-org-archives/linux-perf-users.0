Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80E3557F3
	for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780180787; cv=pass; b=K/6CZWJGlHdX1ca7VZdNkvwZ3gJMYv0QWGtRIPKmkc8HsNVbKGI2JL9rkGIsoNfgDbLKKgKTane4Fy87LxFdkQGFqCSYswECVfHj+0Nl+nUFyGmq1AEr6lkBHQov5SCT9o1lfjlIoGT3yqrn96vmbVrpF9t9Jy0Z+xi8CGPEjFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780180787; c=relaxed/simple;
	bh=JyTD6qVb1qHAE7E2hdTdrF12cQhdrJuQ6qG8m0wPhGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZzuSe7+hervxL/zKXK/p5MtxK9tP7T/ejkttF+ULseNCj1PpBYK0UIOwOyQnq6eGsoReBjafPFJ5TONEl6sTOa4KB+OBU4XolyxEf0S2t6Lb0CDJpyBx1bpsp0UM5kM6OQTDvZvevHAI6XuZQwRW5oaYEeywPJQ0zQQ3znyvPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRr4ZeRx; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRr4ZeRx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2911f93cso275ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 15:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780180785; cv=none;
        d=google.com; s=arc-20240605;
        b=ImNH/+RL2TJHrJBxMeA3sq3HNv5L5cKnnB8IaQnGdG08NEmfZ43o1SwoPGyLDSLf00
         rvizbQ1rZHYcnzzv//SCRul/GsDwPAeJBxfSEdJN0VrnGEQK2oKaT2nTKRgpYUImSaXo
         nT3A9JB2VglaACqNtA4omfn1glthjNMrGeceqw1om4IIAPGFUKdQGzVDkxLpBUJ2QJmv
         HmSfgINVEXJ164EgPXtlSz61L19RaDcTSxdBhthDp7uBpV56kLD1I62jTxfBGmR42f89
         zfT1ppvd0NXtjQuPM5Cv/bB/Q/83uDYPiH9ai25bivP2DAEqvhWwWMYBsERbBo7Crd/E
         23OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOyk9c5aDgUM0zKDCnJp8ZCtO1C/2o2wSI27Hd6Y+dk=;
        fh=VLmOTg0x3DnvjgnM2mknKBrcZrlK/lmuE6aV0RrapPo=;
        b=h9I792E2eioUE2FfRmsuXVER8Q19II54T9eUplYN0ikRzafuMA+EjfnTxj0vg0yOCm
         ZJ0AzyXjlqmQDSaxl5+74JuvkfedjN3+Pn7l5GkRAWi2odB7CJintHq/Af4YRAt1vA7w
         0+RV3y4F2xBFUiKMYfCHKGsxNY5BkaB5MeNuFc3uZmbjclNIJnava9rfslEKbYnulwWe
         l7jqXXIIE1HwYTBnAYGkv64Yz6ZwbOEZ3BUY2Um2ktpMzZU4ASJjmOVj90GUDtKvXwpE
         yMuuM2Q4FTMcb4Hp/V7WdZXkCaj83+Ajfg7uQvBAAcjxOkAkro7fmq+uoCY5Fpas3YAN
         5GQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780180785; x=1780785585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOyk9c5aDgUM0zKDCnJp8ZCtO1C/2o2wSI27Hd6Y+dk=;
        b=IRr4ZeRxsn59vI8XNEBZBZNIPqFAdHkzkLf37jrHtRP6hGaXZ61YO+ATHzUuVmZr5q
         +C5ECTNgfdRvlqbltybDfMGRckQ18uRyVRL8Ego19Ic08eHAjQcBmv/V8G/y1eGmaTwF
         4igbwGKKyQAho35oFruwW8+HpK8KfhWM8TBS9DSJ9oNUMms7hOZhSC/0STQNytY3woYO
         vVQR5+zdHtrFBMpgtaUcPd5s16f5i7jvL6vmPG6w1IG3jX3ENQSLHaxlVL8E4MhXKyzk
         vw7rwWSEhdcnt9OOM83hFsdrpPO6lKj7enN6YBwuY8ctNTOmDd6ohL6qnLZ3LQCpJLLT
         0yKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780180785; x=1780785585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOyk9c5aDgUM0zKDCnJp8ZCtO1C/2o2wSI27Hd6Y+dk=;
        b=lhP4kSo7EpiDrvOqi7F7pPFQt2n7qD6mSego6q6Dt1CkXxDyoD7FDC6fmIM0C4hwR7
         i83CGZ42+SRY+XXYJrxtOCpR9ki+sLbooZeR41oFdVTgA6cnG+5gyFAWtLMnNLxNAcnq
         D69cU5YvisZ8skiIrZW9jushjs2ZUPJGUbmOcmqxZN2gwY2A7Gqb8NUpLCYL1WF6CnG8
         Pf7vpYh0Vpi0MpP1jjKqYMDSHbkswA2ggRlhs3ENhEd+dZQWGCez4HygHnulzYaKC83U
         doYBu22TaLcKPqt+HEjPVjnJ7xmZXBg9TqIVVrcMcl2WOtkpnpVFFRSeaFyFh4BzFYI3
         4fyw==
X-Forwarded-Encrypted: i=1; AFNElJ9eD5QFBQyu4UEi+b0TbzgFtaheKEpXHKN1RWRTJmvYIFyOw2LK4hdK2zm/m9I4izzWQIZJSIY29faq7FVuYSEi@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIvYCj009TCe8/nQ5MDwIZkOH6kD8Sjscu4Jjte6gCeZufYzG
	fSthtkD1TuCDhy3zl9zrwgp6Be18cPvhwIVm9FqMGdyRwKV+Q2ZJXGI17gQSNqTPeOzr4dGRIlR
	3qvW9aMr4bBgnIhUf5+zuzprbcgUTTc10chHWw4ap
X-Gm-Gg: Acq92OECUgG9ivol44G1PHZOYMv69Y3otmiHi8uzNQsRqiIaKZNWG9aH4NFuvL+C9mY
	oK4wmqlE8YhM6DYt1zu/dRgz8U/R6coWwAUM1VbPEqo1UW9UHK1nHb8NqH8RGXjFmXGGTVoOFKQ
	A3vfJcuGikmhBH/1AqBM+g6jsL9C89z11uv7SxpxHN4FkHh2WjS5rJ3Gd1L17q4MABR1wEVkao4
	g3HkAhpAh7PurB5vGUVz2L2hMGKrrkPTceUb1isH4W5UCXE0Vv6x7ykwD+SjRCFso8nzFo0d7rj
	H2aftxil30Jfl9o7gjg=
X-Received: by 2002:a17:902:e84d:b0:2bf:749:551 with SMTP id
 d9443c01a7336-2bf975a82f1mr3314295ad.22.1780180784107; Sat, 30 May 2026
 15:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530195511.71452-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260530195511.71452-1-suchitkarunakaran@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 30 May 2026 15:39:32 -0700
X-Gm-Features: AVHnY4Ly4g9eRSx8JX_CEpFmAYme7-7E7FRmCShWruHLL9feKzvGDxM6PMJLXeI
Message-ID: <CAP-5=fVZ0zOG4yEPjn2Lk2H4zteoHKjmdKdNdMeeTTMCFvZLgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf build: compile BPF skeletons with -mcpu=v3
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 12:55=E2=80=AFPM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> The lock_contention BPF program uses __sync_val_compare_and_swap()
> to atomically update the max_time and min_time fields in
> contention_data. This builtin lowers to the BPF_CMPXCHG instruction,
> which is only available in BPF ISA v3. Without an explicit -mcpu flag,
> Clang targets BPF v1/v2 by default on older toolchains (Clang < 18),
> causing build errors when v3 instructions are emitted.
>
> Add -mcpu=3Dv3 to CLANG_OPTIONS, which is used exclusively in the BPF
> skeleton compilation rule.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Changes since v1:
> - Moved the -mcpu=3Dv3 addition from tools/perf/Makefile.perf to
>   tools/perf/bpf_skel.mak, following the refactoring of BPF skeleton
>   build logic into that file.
> ---
>  tools/perf/bpf_skel.mak | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
> index 7704e7e635d8..f2559de39f96 100644
> --- a/tools/perf/bpf_skel.mak
> +++ b/tools/perf/bpf_skel.mak
> @@ -29,7 +29,7 @@ ifneq ($(CROSS_COMPILE),)
>  CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
>  endif
>
> -CLANG_OPTIONS =3D -Wall
> +CLANG_OPTIONS =3D -Wall -mcpu=3Dv3
>  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_A=
RCH))
>  LIBBPF_INCLUDE :=3D $(abspath $(or $(OUTPUT),.))/libbpf/include
>  BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(SKEL_TOOL_OUT) -I$(LIBBPF_INCL=
UDE) $(CLANG_SYS_INCLUDES)
> --
> 2.54.0
>
