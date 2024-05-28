Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DF17BB19
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932592; cv=none; b=S+NfeSgq38FFt4ftnnMzxllnNvVo5130IT6p5tifB4b+bQat+RgYWOaX5vccEBHg1G/QyxU4McLfehfq8nRasb19B2efxIFfEWo3UblEmcRgBEoAM+TB0FjVUwDhMBj5KpL+tAlehaA5UmVwfrkUPAybAXwhnFumEyZWgCmNWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932592; c=relaxed/simple;
	bh=4Euc2CMnctDapCdPMHYZOgRdPCcqUQ94iWFsu7+cNrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuL1A+3Z4TOGpQn/XJBze8pZEQRvwqPbWaHS1AtemoP1+BQOeszZz7GgHzrUhqq+yBxPd+GJOu1PlHaF0fo1kTW9TPkj4KxOJeOLwb6f3Wdkn68Wqk9C4Mv2ga3BJqgSOpitkppPVl4GMnp+JS7lL2jqZTBz3SecibVAxuZ2zYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fUFgJrTO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fUFgJrTO"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a635a74e031so92334266b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716932589; x=1717537389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghaFBcZ2YNH3u+EoV6MQ3l9SwN9z5dJUxFXXhJnhIsc=;
        b=fUFgJrTOfTPlsS7BbVRIUbVISRZ8SNaJa5aSEBGgJESt4h4rlPZgUQCuTXhU4WW+Kg
         /vomPwrMzWOTUaxF/LvRKRWQHQd5ylFtyfA4xxGdhuJpUiA4tk56+yVCs+HQ3WVodfh0
         bup3C5YBMRsRbfhHgpDHQGX+GJLdeNtjfFQQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716932589; x=1717537389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghaFBcZ2YNH3u+EoV6MQ3l9SwN9z5dJUxFXXhJnhIsc=;
        b=P7Kd5hG43JX0L2MUTWfSckmR+P/HIx929HRemxBID8Sdj/89Ka6en5C8FXgsQofKmy
         MGFTC8NPrIYjB3/MUWMTc9CyW1IGKz4cuOSQbR299R8PWDcdtCw95LnmIdktIYLYlm/Z
         o7O53wIUelqb7DfuCFjPDM0+eQPEia/ZNaEwHRLC4JCMR6MR2aYG9TImbS8k50HiAtT0
         VC1MkXqH9GLbqJlUDjGJrp8sEQsugb5qLqxVrtq3EUEEvAeap96SDTALhDNHEobNQo3V
         +EwWJVVjfQXrR52e2XKCash5G/p0lXAD28XY0q+2ODujrk78QSPRQzLKJoKMZaFtI41F
         A41w==
X-Forwarded-Encrypted: i=1; AJvYcCXKb9LeLuVy1IXJeYuPC9AMJGZnTYRRkvWC9jSWEOJGR30BdxHPb2+qdYnHwFJdu7n1ba3TprtEXRGbUpTFT8FQZRxsFpkkfiQKgscSau0ENg==
X-Gm-Message-State: AOJu0YwZsNGNjWdcN87eo1qiMTS55Aajo9BKOUIUEMvkXu7dhb2gZqas
	9DHJrLlHKXPGzvyfoLyj9Lq3FCeSMrXW/wtd5+NY9qaU96J6/+5kNTtMlipsIIo6fpR0ZI+Dm6Q
	M/tah1w==
X-Google-Smtp-Source: AGHT+IEMt8Y865Ke8+bJVPGwnSm75NCePgyo1gPE/BlZTHwS503Q6hsaNYNd9TosFHMRKmirgPeI5w==
X-Received: by 2002:a17:907:984c:b0:a62:a63c:18fa with SMTP id a640c23a62f3a-a62a63c1c3bmr941176966b.16.1716932589417;
        Tue, 28 May 2024 14:43:09 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a635238fcc3sm75521266b.63.2024.05.28.14.43.08
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:43:08 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a635a74e031so92332966b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 14:43:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFE6myaPXJrz0lDlVXy+e1cJNovEOZuRQ+Vt3l9RJcEHRTYvL4WFNrAaKumjHYzPcWGGjLJpVHsnmoDSaTLG9mPLT90HyK5dsE7TpVVsaOLw==
X-Received: by 2002:a17:907:7ea1:b0:a62:fcf7:8927 with SMTP id
 a640c23a62f3a-a62fcf78a7cmr906858766b.56.1716932588191; Tue, 28 May 2024
 14:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
 <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
 <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
 <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
 <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
 <CAP-5=fUwcgsB-AruAmGhw6WVNViMaiJ_iHWuZ8=ksrN7Y3V9QQ@mail.gmail.com>
 <CAHk-=wgtb7y-bEh7tPDvDWru7ZKQ8-KMjZ53Tsk37zsPPdwXbA@mail.gmail.com> <CAP-5=fUQLxt1X6QASNf0Bop+vjam28HsD9ua9ODEd2xnAst5Wg@mail.gmail.com>
In-Reply-To: <CAP-5=fUQLxt1X6QASNf0Bop+vjam28HsD9ua9ODEd2xnAst5Wg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 14:42:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_-MyVH0CJv16PqGkuzYMTRAT=a95HFEnzk4=WnpwM-w@mail.gmail.com>
Message-ID: <CAHk-=wg_-MyVH0CJv16PqGkuzYMTRAT=a95HFEnzk4=WnpwM-w@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 14:37, Ian Rogers <irogers@google.com> wrote:
>
> I think stability in the context of this problem is an abstract term
> especially given the low amount of ARM support for PMUs.

Just stop arguing.

The 'cycles' thing is documented. It's CP:U cycles. This is just a *fact*.

I have now blocked you. You will get no more replies from me, because
it's not worth my time.

I simply have better things to do that deal with people who cannot
accept documented and existing behavior, and spend days arguing that
their broken fix was a "fix".

Just go play in any of the other open source projects that (sadly)
don't have regression rules.

               Linus
