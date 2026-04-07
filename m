Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B11A262A
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592963; cv=pass; b=mi467Xj12aYxEhTh70TJanLtY4lkUQTV/erWo9to5bhj1ILUV76IhxUFv5eul02cHB1IWQ4GtBS+bTprTLv5nDZ1W/OCXBymUWmdA13BUriycrlgXXlVUFe37g/vN81TtiFC4657yIwquWeemta4NToBXOhr5XAWL4YHSLDQ0ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592963; c=relaxed/simple;
	bh=4HkK+SFAIDi/Qv9NCBDnAr6SL2IV/+ZQ3QEhJu3T8YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO1bgE25oPGfavARY1WuaaxohePbBcqEc8KaF9gqyqB+VGVhbyvc5sgGizP+vJ+L4X3EdIVRuqiYAL/wPcdDO0CguUhX1SvnKDCKAbINCj4KGnnOscfiF0m8QftMPxRTXHZMP69WeiTs3cwQFIxfzF/pV9CjpCzZ4+03h/E5mqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WlbNDJ3z; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlbNDJ3z"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0b260d309so4545ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 13:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775592962; cv=none;
        d=google.com; s=arc-20240605;
        b=YhEKnmfO6SKmIbNy21sXrzHnwDwociulY5kE2gc7j6yW6ipuBFxHbi5ViAOezCaJmA
         9M4deYjzJOjZZ+V71TPBo8BuWbHjLLFPaakHiFaaCUeFmJ+7C2h0Djt3rRLC3CH5kKug
         KMatcRk7Ii3+wSxZGCN8PoF00wqS0z+6/gKM8fNFNRYAtiSdHvwA6LoeDZYHU3+2l+TP
         64XVC7aRlFxPXHOfPgyBilpZFtuLJ2W0ev/x260w+NDoOJcvUZXPbOFgvlqhmg4kh73I
         jmiiNGdm8m0V1L/a8J6tzli319IDZFQAP/ZpDJJXn3irf6LSBpiet4zMeI+X89jgDpHG
         hISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0e0uEdAOSmKddubyhsZ6HNeNsdVb2CK5OK9cYlCaMhk=;
        fh=8b2GaDSSdJDUjEqgH76OICAbNhFM3zUKgD4JqMWZf2g=;
        b=ESWIAuoXHWIM1ZmnhVucUzSXYQyXAZ09TVJThzkynj9eU86K0YXA7XMI85GV/AJXrl
         YXl3MGohGJeL4RRGPBrfuxpv4j9tiOSsQ7aDsxOodH5WPmqh7cVu6o44c9zbBlT12Yoa
         nJB0P1ce6VqGW9Yt7OQCGCATRB9lOyAozGpdqTh18yeoGySicdRjZS3MkH2dgWwtrHaj
         ZdAD1er3rkGIlA34hAmq/O5EuTndu8p2Ctl0x3/YeAOAE+uC/p2ul7VxtVBxONWbAlpU
         nuU+gWrFXWaplEnoCYtG6D/geCAiZwJ2bbxjpc25Db5El6xpLaM5icrb7uRpgm7X4ipE
         csfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775592962; x=1776197762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e0uEdAOSmKddubyhsZ6HNeNsdVb2CK5OK9cYlCaMhk=;
        b=WlbNDJ3zvvA4bWHOS3XKqfuw3vvpRQSWVgT1IUz/9h1My+hAuUne1NH7vLfOiOfSP2
         8YJj1hADXVH2E8TLCeuP2+hYS27gmdBdKIMUpYpkEnmY9dtcVR6yGS7ov3CcQ6/LnTfJ
         vCtxp5rjOIHcRxkrkJedxF2GSUdK+d970yZGxqdh08fBYcC1O/i3jMGE9QTI5/UGIeXx
         tIMTIS7O6ZopOr377YLwqFk/x8N5++KqoYZc+vAVBcliTk5vZWS574/j5j7pGDiqBS10
         bTF5/fCrdp4BZo0RkumBBIj7ePVWqq29aLaWlyR58ewtph7BTzogaDoCX9+Hk9k3rvo8
         Ke9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592962; x=1776197762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0e0uEdAOSmKddubyhsZ6HNeNsdVb2CK5OK9cYlCaMhk=;
        b=D4NeBQic/7b+7HU5KYAQHbC6OlmDpWOf6Gfk87Sn6Jx1xnHE8oqQe5w++/gQsMXkrm
         94ItW3UhEGAHJDBQbpF2B0m3T9saqkfUW0HlHclgzeqvoeM/FvvQDkI40DbkXKoWD3Vj
         +xe6MDRVX20DAMlvKBGbTUzJjaj1VKWbarGmo26e/mDAwmHcw5JqK6qtWmJhnACcF0Uj
         oneHDcHASit2v5sWAIEJdPUf+FbkYOynpcQxW1vlK6y1lhEcaNVmFY6hTzNhVsPBfMUT
         Ggt3j3hP43zjjWSEvcHdAwZ3RmHtHrGcdms1eOwMiw2F4Pd6ivi7k7S6G80KfE+uC2Dp
         2dRg==
X-Forwarded-Encrypted: i=1; AJvYcCXvrXBrsRWHFW+An4MdsxmjVpgss+Jdgwprlv57YuDPZL7ibZgciuWUriKQV25sl063HPxVx8QfjbQk3B0LbmSB@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4KCBKtdWSj/msXgseh13fqcsx5q/SDk7kwpidwQIM0CsVwB4
	sySE/YfLmkqKBYOxWZyY9Cbzv2DyxwPsnI5gwdhoUWx79qRmNP7YbEWrt9VDH/HDsIa6/ClpUDl
	w6VVpWFPzPxMKBx6EzZq+WbJtmHSTCUC1cXCu43GG
X-Gm-Gg: AeBDiet8MxOLy/FuDA8s7Y1HNkL1p/vNd0pvyFznwJcHUnFUywPXnfd7ycdtxd7+kWV
	JjiSbMIGjB8KMhIkN6lyD/lmCbWi4nukmIxpZWs1LGIQ7ko/LYPXFK6DxMoBsszEMYuDgAujt30
	blejl3SN61h8luHUxuCirE2S53aGUp34mKN+2F4ux0EWSD/aR333GJ4A5RC4t9YhUHBdXk33yDX
	HZ8Evaz7NMpPYt6MF/UDHayDXruF7R41Y6pKtMkPb0pGZLwyoEoBhuAeL9e+F483rtbjxCUtoTv
	7NZF35ZyW1/P4CmliQoQL5STuHEVYLmSxg6P5w==
X-Received: by 2002:a17:902:e545:b0:2b2:4a2e:5dd5 with SMTP id
 d9443c01a7336-2b283f04a30mr10414775ad.3.1775592961127; Tue, 07 Apr 2026
 13:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407195145.2372104-1-acme@kernel.org> <20260407195145.2372104-7-acme@kernel.org>
In-Reply-To: <20260407195145.2372104-7-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Apr 2026 13:15:49 -0700
X-Gm-Features: AQROBzD_Ox1O_IOeSipCCKgTZCw8cMhbm1bjeQWKRCcQtT-EPdgdelwx32KG5EQ
Message-ID: <CAP-5=fXXYBvomjunDpeW3QxFdOxpqc7O+dLGMxSA5rSB_qozkg@mail.gmail.com>
Subject: Re: [PATCH 6/6] perf util: Kill die() prototype, dead for a long time
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 12:52=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> In fef2a735167a827a ("perf tools: Kill die()") the die() function was
> removed, but not the prototype in util.h, now when building with
> LIBPERL=3D1, during a 'make -C tools/perf build-test' routine test, it is
> failing as perl likes die() calls and then this clashes with this
> remnant, remove it.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

You could add:
Fixes: fef2a735167a827a ("perf tools: Kill die()")

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/util.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 8d32bc8895c9fe4b..87a0818a8c765c45 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -30,7 +30,6 @@ extern bool perf_guest;
>
>  /* General helper functions */
>  void usage(const char *err) __noreturn;
> -void die(const char *err, ...) __noreturn __printf(1, 2);
>
>  struct dirent;
>  struct strlist;
> --
> 2.53.0
>
